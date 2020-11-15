package com.spring.mysqltest.member.dao;

import java.util.Map;
import org.springframework.dao.DataAccessException;
import com.spring.mysqltest.member.vo.MemberVO;

public interface MemberDAO {
	public String checkId(String id) throws DataAccessException;
	public String checkName(String n_name) throws DataAccessException;
	public void insertMember(MemberVO memberVO) throws DataAccessException; //회원가입
	public MemberVO login(MemberVO memberVO) throws DataAccessException;
	public void updateName(Map<String,Object> memberMap) throws DataAccessException; //닉네임(n_name) 변경
	public void updateMember1(Map<String,Object> memberMap) throws DataAccessException; //회원정보 변경 (프로필사진 포함)
	public void updateMember2(Map<String,Object> memberMap) throws DataAccessException; //회원정보 변경 (프로필사진 포함X)
}