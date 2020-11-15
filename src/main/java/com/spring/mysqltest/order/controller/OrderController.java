package com.spring.mysqltest.order.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

public interface OrderController {
	//구매 form으로 이동
	public ModelAndView deliveryForm(HttpServletRequest request, HttpServletResponse response) throws Exception;
	//주문테이블에 주문 추가
	public @ResponseBody String addOrder(HttpServletRequest request, HttpServletResponse response) throws Exception;
	//주문완료페이지로 이동
	public ModelAndView completed(HttpServletRequest request, HttpServletResponse response) throws Exception;
	//주문조회 페이지로 이동
	public ModelAndView myOrder(@RequestParam(value="period",defaultValue="1m") String period, HttpServletRequest request, HttpServletResponse response) throws Exception;
	//주문 상세 정보 페이지로 이동
	public ModelAndView myOrderDetail(@RequestParam("orderNO_") int orderNO_, HttpServletRequest request, HttpServletResponse response) throws Exception;
}