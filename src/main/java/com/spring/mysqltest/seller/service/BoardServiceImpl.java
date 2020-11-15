package com.spring.mysqltest.seller.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.spring.mysqltest.board.form.BookmarkVO;
import com.spring.mysqltest.seller.dao.BoardDAO;
import com.spring.mysqltest.seller.vo.ArticleVO;
import com.spring.mysqltest.seller.vo.Criteria;
import com.spring.mysqltest.seller.vo.ImageVO;
import com.spring.mysqltest.seller.vo.ReviewVO;

@Service("sellerService")
@Transactional(propagation = Propagation.REQUIRED)
public class BoardServiceImpl implements BoardService {
	@Autowired
	BoardDAO boardDAO;

	// 관리자
	@Override
	public List<ArticleVO> listArticles_admin(Criteria cri) throws Exception {
		List<ArticleVO> articlesList = boardDAO.selectAllArticlesList(cri);
		return articlesList;
	}

	// 일반 사용자
	@Override
	public List<ArticleVO> listArticles(Criteria cri) throws Exception {
		List<ArticleVO> articlesList = boardDAO.selectAcceptedArticlesList(cri);
		return articlesList;
	}

	// 글 추가
	@Override
	public int addNewArticle(Map articleMap) throws Exception {
		int articleNO = boardDAO.insertNewArticle(articleMap);
		articleMap.put("articleNO", articleNO);
		boardDAO.insertNewImage(articleMap);
		return articleNO;
	}

	// 글 정보 조회
	@Override
	public ArticleVO articleDetail(int articleNO) throws Exception {
		ArticleVO articleVO = boardDAO.selectArticle(articleNO);
		return articleVO;
	}

	@Override
	public Map viewArticle(int articleNO) throws Exception {
		Map articleMap = new HashMap();
		ArticleVO articleVO = boardDAO.selectArticle(articleNO);
		List<ImageVO> imageFileList = boardDAO.selectImageFileList(articleNO);
		List<ReviewVO> reviewList = boardDAO.selectReviewList(articleNO); //해당 글의 리뷰 목록    //06/16 수정

		articleMap.put("article", articleVO);
		articleMap.put("imageFileList", imageFileList);
		articleMap.put("reviewList", reviewList);
		return articleMap;
	}

	// 조회수 증가
	@Override
	public void updateArticleHits(int articleNO) throws Exception{
		boardDAO.updateArticleHits(articleNO);
	}
	
	// 글 승인
	@Override
	public void acceptArticle(int articleNO) throws Exception {
		Map articleMap = new HashMap();
		articleMap.put("articleNO", articleNO);
		boardDAO.acceptArticle(articleMap);
	}

	// 글 수정
	@Override
	public void modArticle(Map<String,Object> articleMap) throws Exception{
		boardDAO.updateArticle(articleMap);
		boardDAO.insertNewImage(articleMap);

	}

	// 글 삭제
	@Override
	public void removeArticle(int articleNO) throws Exception {
		boardDAO.deleteArticle(articleNO);
	}


	// 이미지 수정
	@Override
	public void modArticleImage(List<ImageVO> imageFileList) throws Exception{
		boardDAO.updateArticleImage(imageFileList);
	}

	/*키워드 검색*/
	// 관리자
	@Override
	public List<ArticleVO> listArticles_admin_searchedByKeyword(Map map) throws Exception {
		List<ArticleVO> articlesList = boardDAO.selectAllArticlesList_searchedByKeyword(map);
		return articlesList;
	}

	// 일반 사용자
	@Override
	public List<ArticleVO> listArticles_searchedByKeyword(Map map) throws Exception {
		List<ArticleVO> articlesList = boardDAO.selectAcceptedArticlesList_searchedByKeyword(map);
		return articlesList;
	}

	/*페이징*/
	// 모든 글 갯수
	@Override
	public int countAllArticlesList() throws Exception {
		return boardDAO.countAllArticlesList();
	}

	// 승인된 글 갯수
	@Override
	public int countAcceptedArticlesList() throws Exception {
		return boardDAO.countAcceptedArticlesList();
	}

	// 모든 글 갯수 _ 키워드 검색
	@Override
	public int countAllArticlesList_searchedByKeyword(String keyword) throws Exception {
		return boardDAO.countAllArticlesList_searchedByKeyword(keyword);
	}

	// 승인된 글 갯수 _ 키워드 검색
	@Override
	public int countAcceptedArticlesList_searchedByKeyword(String keyword) throws Exception {
		return boardDAO.countAcceptedArticlesList_searchedByKeyword(keyword);
	}

	// Article 이미지 썸네일
	@Override
	public String selectThumbnail(int articleNO) throws Exception {
		return boardDAO.selectThumbnail(articleNO);
	}

	// 모든 글 갯수 _ 작성자 검색
	@Override
	public int countAllArticlesList_searchedByWriter(String writer) throws Exception {
		return boardDAO.countAllArticlesList_searchedByWriter(writer);
	}

	// 승인된 글 갯수 _ 작성자 검색
	@Override
	public int countAcceptedArticlesList_searchedByWriter(String writer) throws Exception {
		return boardDAO.countAcceptedArticlesList_searchedByWriter(writer);
	}

	// 관리자_ 작성자 검색
	@Override
	public List<ArticleVO> listArticles_admin_searchedByWriter(Map map) throws Exception {
		List<ArticleVO> articlesList = boardDAO.selectAllArticlesList_searchedByWriter(map);
		return articlesList;
	}

	// 일반 사용자_ 작성자 검색
	@Override
	public List<ArticleVO> listArticles_searchedByWriter(Map map) throws Exception {
		List<ArticleVO> articlesList = boardDAO.selectAcceptedArticlesList_searchedByWriter(map);
		return articlesList;
	}

	// 작성자 프로필 조회
	@Override
	public String getProfile(int articleNO) throws Exception {
		return boardDAO.getProfile(articleNO);
	}
	
	/* YS */
	@Override
	public void deleteExistedImage(Map<String,Object> imageMap) throws Exception {
		boardDAO.deleteExistedImage(imageMap);
	}
	
	//농부 카테고리에서 해당 글 북마크 여부 확인
	@Override
	public String checkFarmerBookmark(Map<String,Object> bookMap) throws Exception { 
		return boardDAO.checkFarmerBookmark(bookMap);
	}

	@Override
	public List<BookmarkVO> listFarmerBookmark(Map<String,Object> bookMap) throws Exception {
		List<BookmarkVO> bookmarkList = boardDAO.select_FarmerBookmarkList(bookMap);
		return bookmarkList;
	}
	
	// 회원의 리뷰 목록
	@Override
	public List<ReviewVO> selectMyReviewList(String n_name) throws Exception { 
		List<ReviewVO> reviewList = boardDAO.selectMyReviewList(n_name);
		return reviewList;
	}
	
	// 회원의 리뷰 수정
	@Override
	public void updateReview(ReviewVO reviewVO) throws Exception { 
		boardDAO.updateReview(reviewVO);
	}
	
	// 회원의 리뷰 삭제
	@Override
	public void deleteReview(int review_NO) throws Exception { // 회원의 리뷰 삭제
		boardDAO.deleteReview(review_NO);
	}
	
	// 회원의 리뷰 삽입
	@Override
	public void addReview(ReviewVO reviewVO) throws Exception { 
		int orderNO=reviewVO.getOrderNO();
		boardDAO.updateReview_Chk_Y(orderNO); //s_order테이블의 해당 orderNO의 review_chk을 "Y"로 변경
		boardDAO.insertReview(reviewVO);
	}
	
	//해당 articleNO의 제목 등의 정보를 가져옴
	@Override
	public ArticleVO selectItemInfo(int articleNO) throws Exception { 
		ArticleVO articleVO=new ArticleVO();
		articleVO=boardDAO.selectItemInfo(articleNO);
		return articleVO;
	}
	
	//회원이 입력한 review 가져오기
	@Override
	public ReviewVO selectMyReview(int review_NO) throws Exception { 
		ReviewVO reviewVO = new ReviewVO();
		reviewVO=boardDAO.selectMyReview(review_NO);
		return reviewVO;

	}
}