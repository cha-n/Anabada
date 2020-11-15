package com.spring.mysqltest.main.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

public interface MainController {
	public ModelAndView main(HttpServletRequest request, HttpServletResponse response) throws Exception;
}