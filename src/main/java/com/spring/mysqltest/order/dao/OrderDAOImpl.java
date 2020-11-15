package com.spring.mysqltest.order.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.spring.mysqltest.order.vo.OrderVO;
import com.spring.mysqltest.seller.vo.ArticleVO;

@Repository("orderDAO")
public class OrderDAOImpl implements OrderDAO {
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public ArticleVO selectItemInfo(int articleNO) throws DataAccessException {
		return sqlSession.selectOne("mapper.seller.selectItemInfo", articleNO);
	}	
	@Override
	public void insertOrder(OrderVO orderVO) throws DataAccessException { //주문테이블에 주문 추가
		sqlSession.insert("mapper.order.insertOrder",orderVO);
	}
	
	@Override
	public void deleteCart(OrderVO orderVO) throws DataAccessException { //장바구니에 있는 상품을 주문하면 장바구니에서 삭제
		sqlSession.delete("mapper.cart.deleteCart", orderVO);
	}
	
	@Override
	public int selectNewOrderNO() throws DataAccessException { //orderNO+1를 반환
		return sqlSession.selectOne("mapper.order.selectNewOrderNO");
	}
	
	@Override
	public OrderVO selectOrderResult(int orderNO) throws DataAccessException { //주문완료 후 주문 정보 가져오기
		return sqlSession.selectOne("mapper.order.selectOrderResult",orderNO);
	}
	
	@Override
	public String selectThumbnail(int articleNO) throws DataAccessException { //해당 articleNO의 썸네일이미지(첫 번째 이미지)의 이름 return 
		return sqlSession.selectOne("mapper.seller.selectThumbnail",articleNO);
	}
	
	@Override
	public List<OrderVO> selectOrders(Map<String,Object> infoMap) throws DataAccessException { //회원의 주문 목록
		List<OrderVO> orderList=null;
		String period=(String) infoMap.get("period");
		String n_name=(String) infoMap.get("n_name");
		if(period.equals("1m")) { //1개월 내의 주문
			orderList=sqlSession.selectList("mapper.order.select_Orders_1M",n_name);
		}
		else if(period.equals("3m")) { //1개월 내의 주문
			orderList=sqlSession.selectList("mapper.order.select_Orders_3M",n_name);
		}
		else if(period.equals("6m")) { //6개월 내의 주문
			orderList=sqlSession.selectList("mapper.order.select_Orders_6M",n_name);
		}
		else if(period.equals("1y")) { //1년 내의 주문
			orderList=sqlSession.selectList("mapper.order.select_Orders_1Y",n_name);
		}
		return orderList;
	}
	
	@Override
	public List<OrderVO> selectOrderDetail(int orderNO_) throws DataAccessException { //회원의 주문 상세 정보
		return sqlSession.selectList("mapper.order.selectOrderDetail",orderNO_);
	}
}