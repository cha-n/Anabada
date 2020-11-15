package com.spring.mysqltest.main.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.spring.mysqltest.main.service.MainService;
import com.spring.mysqltest.main.vo.RecommendVO;
import com.spring.mysqltest.order.service.OrderService;

@Controller("mainController")
public class MainControllerImpl implements MainController {
	
	@Autowired
	private MainService mainService;
	
	@Override
	@RequestMapping(value="/main" ,method = RequestMethod.GET)
	public ModelAndView main(HttpServletRequest request, HttpServletResponse response) throws Exception {
		List<RecommendVO> recomList=null;
		recomList=mainService.list_Recommendation();
		String viewName="main/main";
		ModelAndView mav = new ModelAndView(viewName);
		mav.addObject("recomList", recomList);
		return mav;
	}

}
