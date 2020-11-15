package com.spring.mysqltest.cart.dao;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.spring.mysqltest.cart.vo.CartVO;

public interface CartDAO {
	public void insertCart(CartVO cartVO) throws DataAccessException; //장바구니에 상품 넣기
	public String cartOverlapped(CartVO cartVO) throws DataAccessException; //장바구니에 상품이 이미 들어있는지 확인
	public List<CartVO> listCart(String n_name) throws DataAccessException; //장바구니 보기
	public void deleteCart(CartVO cartVO) throws DataAccessException; //장바구니에서 상품 삭제
}