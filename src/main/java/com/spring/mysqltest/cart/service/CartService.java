package com.spring.mysqltest.cart.service;

import java.util.List;

import com.spring.mysqltest.cart.vo.CartVO;

public interface CartService {
	public void addCart(CartVO cartVO) throws Exception;
	public String cartOverlapped(CartVO cartVO) throws Exception; //장바구니에 상품이 이미 들어있는지 확인
	public List<CartVO> listCart(String n_name) throws Exception; //장바구니 보기
	public String deleteCart(CartVO cartVO) throws Exception; //장바구니에서 상품 삭제
}