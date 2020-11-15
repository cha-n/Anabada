package com.spring.mysqltest.member.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.mysqltest.member.dao.MemberDAO;
import com.spring.mysqltest.member.vo.MemberVO;


@Service("memberService")
public class MemberServiceImpl implements MemberService {
	@Autowired
	private MemberDAO memberDAO;
	
	@Override
	public String checkId(String id) throws Exception {
		String result=memberDAO.checkId(id);
		return result;
	}
	
	@Override
	public String checkName(String n_name) throws Exception {
		String result=memberDAO.checkName(n_name);
		return result;
	}
	
	@Override
	public void addMember(MemberVO memberVO) throws Exception { //회원가입
		memberDAO.insertMember(memberVO);
	}
	
	@Override
	public MemberVO login(MemberVO memberVO) throws Exception {
		return memberDAO.login(memberVO);
	}
	
	@Override
	public void updateName(Map<String,Object> memberMap) throws Exception { //닉네임(n_name) 변경
		memberDAO.updateName(memberMap);
	}
	
	@Override
	public void updateMember1(Map<String,Object> memberMap) throws Exception { //회원정보 변경 (프로필사진 포함)
		memberDAO.updateMember1(memberMap);
	}
	@Override
	public void updateMember2(Map<String,Object> memberMap) throws Exception { //회원정보 변경 (프로필사진 포함X)
		memberDAO.updateMember2(memberMap);
	}
}