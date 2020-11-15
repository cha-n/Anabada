package com.spring.mysqltest.order.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.spring.mysqltest.order.vo.OrderVO;
import com.spring.mysqltest.seller.vo.ArticleVO;

public interface OrderDAO {
	public ArticleVO selectItemInfo(int articleNO) throws DataAccessException;
	public void insertOrder(OrderVO orderVO) throws DataAccessException; //주문테이블에 주문 추가
	public void deleteCart(OrderVO orderVO) throws DataAccessException; //장바구니에 있는 상품을 주문하면 장바구니에서 삭제
	public int selectNewOrderNO() throws DataAccessException; //orderNO+1를 반환
	public OrderVO selectOrderResult(int orderNO) throws DataAccessException; //주문완료 후 주문 정보 가져오기
	public String selectThumbnail(int articleNO) throws DataAccessException; //해당 articleNO의 썸네일이미지(첫 번째 이미지)의 이름 return 
	public List<OrderVO> selectOrders(Map<String,Object> infoMap) throws DataAccessException; //회원의 주문 목록
	public List<OrderVO> selectOrderDetail(int orderNO_) throws DataAccessException; //회원의 주문 상세 정보
}