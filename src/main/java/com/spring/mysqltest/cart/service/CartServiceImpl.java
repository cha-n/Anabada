package com.spring.mysqltest.cart.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.mysqltest.cart.dao.CartDAO;
import com.spring.mysqltest.cart.vo.CartVO;

@Service("cartService")
public class CartServiceImpl implements CartService {
	@Autowired
	CartDAO cartDAO;
	
	@Override
	public void addCart(CartVO cartVO) throws Exception {
		cartDAO.insertCart(cartVO);
	}
	
	@Override
	public String cartOverlapped(CartVO cartVO) throws Exception { //장바구니에 상품이 이미 들어있는지 확인
		String result;
		result=cartDAO.cartOverlapped(cartVO);
		return result;
	}
	
	@Override
	public List<CartVO> listCart(String n_name) throws Exception { //장바구니 보기
		List<CartVO> cartList=null;
		cartList=cartDAO.listCart(n_name);
		return cartList;
	}
	
	@Override
	public String deleteCart(CartVO cartVO) throws Exception { //장바구니에서 상품 삭제
		String result;
		cartDAO.deleteCart(cartVO);
		result="ok";
		return result;
	}
}