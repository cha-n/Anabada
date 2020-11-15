package com.spring.mysqltest.order.service;

import java.util.List;
import java.util.Map;

import com.spring.mysqltest.order.vo.OrderVO;
import com.spring.mysqltest.seller.vo.ArticleVO;

public interface OrderService {
	public ArticleVO getItemInfo(int articleNO) throws Exception; //구입할 상품의 가격과 사진,상품명 가져오기
	public String addOrder(OrderVO orderVO, int cnt) throws Exception; //주문테이블에 주문 추가
	public OrderVO selectOrderResult(int orderNO) throws Exception; //주문완료 후 주문 정보 가져오기
	public List<OrderVO> listOrders(Map<String,Object> infoMap) throws Exception; //회원의 주문 목록
	public List<OrderVO> viewOrderDetail(int orderNO_) throws Exception; //회원의 주문 상세 정보
}