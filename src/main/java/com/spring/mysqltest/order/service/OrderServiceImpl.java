package com.spring.mysqltest.order.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.mysqltest.order.dao.OrderDAO;
import com.spring.mysqltest.order.vo.OrderVO;
import com.spring.mysqltest.seller.vo.ArticleVO;

@Service("orderService")
public class OrderServiceImpl implements OrderService {
	@Autowired
	OrderDAO orderDAO;

	@Override
	public ArticleVO getItemInfo(int articleNO) throws Exception { //구입할 상품의 가격과 사진,상품명 가져오기
		return orderDAO.selectItemInfo(articleNO);
	}
	
	@Override
	public String addOrder(OrderVO orderVO, int cnt) throws Exception { //주문테이블에 주문 추가
		int orderNO=orderDAO.selectNewOrderNO();
		String result="0";
		
		if(cnt==1) {
			orderVO.setOrderNO_(orderNO);
		}
		else {
			orderVO.setOrderNO_(orderNO-cnt+1);
		}
		orderVO.setOrderNO(orderNO);
		orderDAO.insertOrder(orderVO);
		orderDAO.deleteCart(orderVO);
		
		result=String.valueOf(orderNO);
		return result;
	}
	
	@Override
	public OrderVO selectOrderResult(int orderNO) throws Exception { //주문완료 후 주문 정보 가져오기
		//String thumbnail = orderDAO.selectThumbnail(articleNO);
		return orderDAO.selectOrderResult(orderNO);
	}
	
	@Override
	public List<OrderVO> listOrders(Map<String,Object> infoMap) throws Exception { //회원의 주문 목록
		List<OrderVO> orderList = null;
		orderList = orderDAO.selectOrders(infoMap);
		return orderList;
	}
	
	@Override
	public List<OrderVO> viewOrderDetail(int orderNO_) throws Exception { //회원의 주문 상세 정보
		return orderDAO.selectOrderDetail(orderNO_);
	}
}