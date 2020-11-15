package com.spring.mysqltest.cart.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.mysqltest.cart.service.CartService;
import com.spring.mysqltest.cart.vo.CartVO;
import com.spring.mysqltest.member.vo.MemberVO;

@Controller("cartController")
@RequestMapping(value="/cart")
public class CartControllerImpl implements CartController {
	@Autowired
	private CartService cartService;
	private MemberVO member;
	
	@Override
	@RequestMapping(value="/addCart" ,method = RequestMethod.POST) //장바구니에 상품 넣기
	public @ResponseBody String addCart(@ModelAttribute("cartVO") CartVO cartVO, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String existed=cartService.cartOverlapped(cartVO); //장바구니에 이미 선택한 상품이 있는지 확인
		if(existed.equals("no")) { //상품이 없으면
			cartService.addCart(cartVO);
			return "ok";
		}
		else { //상품이 있으면
			return "no";
		}
	}
	
	@Override
	@RequestMapping(value="/myCart" ,method = RequestMethod.GET) //장바구니 보기
	public ModelAndView myCart(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
	    member=(MemberVO) session.getAttribute("member");
	    String n_name=member.getN_name();
	    List<CartVO> cartList=cartService.listCart(n_name);
		String viewName="cart/myCart";
		ModelAndView mav = new ModelAndView(viewName);
		mav.addObject("cartList", cartList);
		return mav;
	}
	
	@Override
	@RequestMapping(value="/deleteCart" ,method = RequestMethod.POST) //장바구니에서 상품 삭제
	public @ResponseBody String deleteCart(@ModelAttribute("cartVO") CartVO cartVO, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String result=cartService.deleteCart(cartVO);
		return result;
	}

}