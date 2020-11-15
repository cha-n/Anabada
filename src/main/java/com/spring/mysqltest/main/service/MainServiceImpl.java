package com.spring.mysqltest.main.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import com.spring.mysqltest.main.dao.MainDAO;
import com.spring.mysqltest.main.vo.RecommendVO;
import com.spring.mysqltest.member.dao.MemberDAO;
import com.spring.mysqltest.member.vo.MemberVO;

@Service("mainService")
public class MainServiceImpl implements MainService {
	@Autowired
	private MainDAO mainDAO;
	
	@Override
	public List<RecommendVO> list_Recommendation() throws Exception {
		List<RecommendVO> recomList = null;
		recomList = mainDAO.list_Recommendation();
		return recomList;
	}

}
