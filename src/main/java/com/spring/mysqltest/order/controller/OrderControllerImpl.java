package com.spring.mysqltest.order.controller;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.mysqltest.cart.vo.CartVO;
import com.spring.mysqltest.member.vo.MemberVO;
import com.spring.mysqltest.order.service.OrderService;
import com.spring.mysqltest.order.vo.OrderVO;
import com.spring.mysqltest.seller.vo.ArticleVO;

@Controller("orderController")
@RequestMapping(value = "/order")

public class OrderControllerImpl implements OrderController {
	
	@Autowired
	private OrderService orderService;
	private MemberVO member;
	private OrderVO order;
	
	@Override
	@RequestMapping(value="/deliveryForm" ,method = RequestMethod.POST) //구매 form으로 이동
	public ModelAndView deliveryForm(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		Map<String,Object> articleMap = new HashMap<String,Object>();
		Enumeration enu = request.getParameterNames();		
		
		while (enu.hasMoreElements()) {
			String name = (String) enu.nextElement();
			String value = request.getParameter(name);
			articleMap.put(name, value);
			System.out.println("name="+name+", value="+value);
		}
		
		List<CartVO> cartList = new ArrayList<CartVO>();
		int articleNO;
		int quantity;
		
		if(articleMap.containsKey("len")==true) { //장바구니로 구매할 때
			int len=Integer.parseInt(articleMap.get("len")+"");
			
			for(int i=1;i<=len;i++) {
				if(articleMap.containsKey("itemCheck"+i)==true) {
					articleNO=Integer.parseInt(articleMap.get("itemCheck"+i)+"");
					quantity=Integer.parseInt(articleMap.get("quantity"+i)+"");

					CartVO cart=new CartVO();
					cart.setArticleNO(articleNO);
					cart.setQuantity(quantity);
					
					ArticleVO articleVO=orderService.getItemInfo(articleNO);
					cart.setArticleVO(articleVO);
					cartList.add(cart);
				}
			}
		}
		
		else { //바로 구매할 때
			articleNO=Integer.parseInt(articleMap.get("articleNO")+"");
			quantity=Integer.parseInt(articleMap.get("quantity")+"");
			CartVO cart=new CartVO();
			cart.setArticleNO(articleNO);
			cart.setQuantity(quantity);
			ArticleVO articleVO=orderService.getItemInfo(articleNO);
			cart.setArticleVO(articleVO);
			cartList.add(cart);
		}
		
		String viewName="order/deliveryForm";
		ModelAndView mav = new ModelAndView(viewName);
		mav.addObject("cartList", cartList);
		return mav;
	}
	
	@Override
	@RequestMapping(value="/addOrder" ,method = RequestMethod.POST) //주문테이블에 주문 추가
	public @ResponseBody String addOrder(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
	    member=(MemberVO) session.getAttribute("member");
		
		Map<String,Object> orderMap = new HashMap<String,Object>();
		Enumeration enu = request.getParameterNames();
		while (enu.hasMoreElements()) {
			String name = (String) enu.nextElement();
			String value = request.getParameter(name);
			orderMap.put(name, value);
			System.out.println("name="+name+", value="+value);
		}
		
		String n_name=member.getN_name();
		String phoneNum=orderMap.get("phoneNum")+"";
		String address=orderMap.get("address")+"";
		String addressDetail=orderMap.get("addressDetail")+"";
		String msg=orderMap.get("msg")+"";
		String pay_method=orderMap.get("pay_method")+"";
		String depositName=orderMap.get("depositName")+"";
		String bank=orderMap.get("bank")+"";
		int len=Integer.parseInt(orderMap.get("len")+"");
		String result=""; //주문번호를 저장하기 위한 변수	
		
		OrderVO orderVO=new OrderVO();
		orderVO.setN_name(n_name);
		orderVO.setPhoneNum(phoneNum);
		orderVO.setAddress(address);
		orderVO.setAddressDetail(addressDetail);
		orderVO.setMsg(msg);
		orderVO.setPay_method(pay_method);
		orderVO.setDepositName(depositName);
		orderVO.setBank(bank);
		
		for(int i=1;i<=len;i++) {
			int articleNO=Integer.parseInt(orderMap.get("articleNO"+i)+"");
			int quantity=Integer.parseInt(orderMap.get("quantity"+i)+"");
			int price=Integer.parseInt(orderMap.get("price"+i)+"");
			
			orderVO.setArticleNO(articleNO);
			orderVO.setQuantity(quantity);
			orderVO.setPrice(price);
			result+=orderService.addOrder(orderVO,i);
			result+=",";
		}
		System.out.println("result="+result);
		return result;
	}
	
	@Override
	@RequestMapping(value="/completed" ,method = RequestMethod.POST) //주문완료페이지로 이동
	public ModelAndView completed(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		Map<String,Object> orderMap = new HashMap<String,Object>();
		List<OrderVO> orderList = new ArrayList<OrderVO>();
		
		Enumeration enu = request.getParameterNames();
		while (enu.hasMoreElements()) {
			String name = (String) enu.nextElement();
			String value = request.getParameter(name);
			orderMap.put(name, value);
			System.out.println("name="+name+", value="+value);
		}
		String resultOrderNO=orderMap.get("resultOrderNO")+""; //주문한 상품들의 orderNO
		String[] orderNOArr=resultOrderNO.split(",");
		
		OrderVO orderVO=new OrderVO();
		for(int i=0;i<orderNOArr.length;i++) {
			int orderNO=Integer.parseInt(orderNOArr[i]);
			orderVO=orderService.selectOrderResult(orderNO);
			orderList.add(orderVO);
		}
		
		String viewName="order/completed";
		ModelAndView mav = new ModelAndView(viewName);
		mav.addObject("orderList", orderList);
		return mav;
	}
	
	@Override
	@RequestMapping(value="/myOrder" ,method = RequestMethod.GET) //주문조회 페이지로 이동
	public ModelAndView myOrder(@RequestParam(value="period",defaultValue="1m") String period, HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Map<String,Object> infoMap = new HashMap<String,Object>();
	    member=(MemberVO) session.getAttribute("member");
	    String n_name=member.getN_name();
	    infoMap.put("n_name", n_name);
	    infoMap.put("period", period);
		List<OrderVO> orderList = orderService.listOrders(infoMap);
		
		String viewName="order/myOrder";
		ModelAndView mav = new ModelAndView(viewName);
		mav.addObject("orderList", orderList);
		mav.addObject("period", period);
		return mav;
	}
	
	@Override
	@RequestMapping(value="/myOrderDetail" ,method = RequestMethod.POST) //주문 상세 정보 페이지로 이동
	public ModelAndView myOrderDetail(@RequestParam("orderNO_") int orderNO_, HttpServletRequest request, HttpServletResponse response) throws Exception {
		List<OrderVO> orderList = null;
		orderList = orderService.viewOrderDetail(orderNO_);
		String viewName="order/myOrderDetail";
		ModelAndView mav = new ModelAndView(viewName);
		mav.addObject("orderList", orderList);
		return mav;
	}
	
	
}