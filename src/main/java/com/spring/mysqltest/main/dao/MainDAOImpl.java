package com.spring.mysqltest.main.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.mysqltest.main.vo.RecommendVO;

@Repository("mainDAO")
public class MainDAOImpl implements MainDAO {
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<RecommendVO> list_Recommendation() throws Exception {
		List<RecommendVO> recomList = sqlSession.selectList("mapper.recommend.list_Recommendation");
		return recomList;
	}
}
