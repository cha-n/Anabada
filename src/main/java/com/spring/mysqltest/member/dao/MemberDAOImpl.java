package com.spring.mysqltest.member.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.spring.mysqltest.member.vo.MemberVO;

@Repository("memberDAO")
public class MemberDAOImpl implements MemberDAO {
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public String checkId(String id) throws DataAccessException {
		String result =  sqlSession.selectOne("mapper.member.checkId",id);
		return result;
	}
	@Override
	public String checkName(String n_name) throws DataAccessException {
		String result =  sqlSession.selectOne("mapper.member.checkName",n_name);
		return result;
	}
	@Override
	public void insertMember(MemberVO memberVO) throws DataAccessException { //회원가입
		sqlSession.insert("mapper.member.insertMember",memberVO);
	}
	@Override
	public MemberVO login(MemberVO memberVO) throws DataAccessException {
		return sqlSession.selectOne("mapper.member.login",memberVO);
	}
	@Override
	public void updateName(Map<String,Object> memberMap) throws DataAccessException { //닉네임(n_name) 변경
		sqlSession.update("mapper.member.updateName",memberMap);
	}
	@Override
	public void updateMember1(Map<String,Object> memberMap) throws DataAccessException { //회원정보 변경  (프로필사진 포함)
		sqlSession.update("mapper.member.updateMember1",memberMap);
	}
	@Override
	public void updateMember2(Map<String,Object> memberMap) throws DataAccessException { //회원정보 변경  (프로필사진 포함X)
		sqlSession.update("mapper.member.updateMember2",memberMap);
	}
}