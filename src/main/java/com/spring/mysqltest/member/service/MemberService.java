package com.spring.mysqltest.member.service;

import java.util.Map;
import com.spring.mysqltest.member.vo.MemberVO;

public interface MemberService {
	public String checkId(String id) throws Exception;
	public String checkName(String n_name) throws Exception;
	public void addMember(MemberVO memberVO) throws Exception; //회원가입
	public MemberVO login(MemberVO memberVO) throws Exception;
	public void updateName(Map<String,Object> memberMap) throws Exception; //닉네임(n_name) 변경
	public void updateMember1(Map<String,Object> memberMap) throws Exception; //회원정보 변경 (프로필사진 포함)
	public void updateMember2(Map<String,Object> memberMap) throws Exception; //회원정보 변경 (프로필사진 포함X)
}