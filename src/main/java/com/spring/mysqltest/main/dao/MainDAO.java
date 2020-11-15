package com.spring.mysqltest.main.dao;

import java.util.List;

import com.spring.mysqltest.main.vo.RecommendVO;

public interface MainDAO {
	public List<RecommendVO> list_Recommendation() throws Exception;
}
