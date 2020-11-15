package com.spring.mysqltest.cart.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.spring.mysqltest.cart.vo.CartVO;

@Repository("cartDAO")
public class CartDAOImpl implements CartDAO {
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insertCart(CartVO cartVO) throws DataAccessException { //장바구니에 상품 넣기
		sqlSession.insert("mapper.cart.insertCart", cartVO);
	}
	
	@Override
	public String cartOverlapped(CartVO cartVO) throws DataAccessException { //장바구니에 상품이 이미 들어있는지 확인
		return sqlSession.selectOne("mapper.cart.cartOverlapped", cartVO);
	}
	
	@Override
	public List<CartVO> listCart(String n_name) throws DataAccessException { //장바구니 보기
		return sqlSession.selectList("mapper.cart.listCart", n_name);
	}
	
	@Override
	public void deleteCart(CartVO cartVO) throws DataAccessException { //장바구니에서 상품 삭제
		sqlSession.delete("mapper.cart.deleteCart", cartVO);
	}
}