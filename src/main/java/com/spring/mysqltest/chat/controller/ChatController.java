package com.spring.mysqltest.chat.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

public interface ChatController {
	public @ResponseBody int submit(@RequestParam(value="fromID",required=false) String fromID, @RequestParam(value="toID",required=false) String toID,
			@RequestParam(value="chatContent",required=false) String chatContent, HttpServletRequest request, HttpServletResponse response) throws Exception;

	String getAllUnreadChat(String userID, HttpServletRequest request, HttpServletResponse response) throws Exception;
}
