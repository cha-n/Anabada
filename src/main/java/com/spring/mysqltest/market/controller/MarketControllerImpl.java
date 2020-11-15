package com.spring.mysqltest.market.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;


@Controller("marketController")
@RequestMapping(value="/market")
public class MarketControllerImpl{
	
	@RequestMapping(value="/locatPopUp" ,method = RequestMethod.GET) //장소 설정 팝업창
	public ModelAndView locatPopUp(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName="market/locatPopUp";
		ModelAndView mav = new ModelAndView(viewName);
		return mav;
	}
	
}