package com.spring.mysqltest.member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.spring.mysqltest.member.vo.MemberVO;

public interface MemberController {
	public @ResponseBody String checkId(@RequestParam("id") String id, HttpServletRequest request, HttpServletResponse response) throws Exception; //아이디 중복 체크
	public @ResponseBody String checkName(@RequestParam("n_name") String n_name, HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView addMember(@ModelAttribute("member") MemberVO member, HttpServletRequest request, HttpServletResponse response) throws Exception;
	public @ResponseBody String login(@ModelAttribute("memberVO") MemberVO memberVO, HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView logout(HttpServletRequest request, HttpServletResponse response) throws Exception; //로그아웃
	public @ResponseBody String updateName(@RequestParam("id") String id, @RequestParam("n_name") String n_name, HttpServletRequest request, HttpServletResponse response) throws Exception; //닉네임(n_name) 변경
	public ResponseEntity<String> updateMember(MultipartHttpServletRequest request, HttpServletResponse response) throws Exception;
}