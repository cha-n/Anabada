package com.spring.mysqltest.cart.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.mysqltest.cart.vo.CartVO;

public interface CartController {
	//장바구니에 상품 넣기
	public @ResponseBody String addCart(@ModelAttribute("cartVO") CartVO cartVO, HttpServletRequest request, HttpServletResponse response) throws Exception;
	//장바구니 보기
	public ModelAndView myCart(HttpServletRequest request, HttpServletResponse response) throws Exception;
	//장바구니에서 상품 삭제
	public @ResponseBody String deleteCart(@ModelAttribute("cartVO") CartVO cartVO, HttpServletRequest request, HttpServletResponse response) throws Exception;
}