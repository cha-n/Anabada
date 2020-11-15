package com.spring.mysqltest.main.service;

import java.util.List;

import com.spring.mysqltest.main.vo.RecommendVO;

public interface MainService {
	public List<RecommendVO> list_Recommendation() throws Exception;
}
