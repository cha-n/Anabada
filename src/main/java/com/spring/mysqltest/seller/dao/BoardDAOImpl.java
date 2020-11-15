package com.spring.mysqltest.seller.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.spring.mysqltest.board.form.BookmarkVO;
import com.spring.mysqltest.seller.vo.ArticleVO;
import com.spring.mysqltest.seller.vo.Criteria;
import com.spring.mysqltest.seller.vo.ImageVO;
import com.spring.mysqltest.seller.vo.ReviewVO;
@Repository("sellerDAO")
public class BoardDAOImpl implements BoardDAO {
	@Autowired
	private SqlSession sqlSession;

	// 모든 글 목록
	@Override
	public List selectAllArticlesList(Criteria cri) throws Exception {
		List<ArticleVO> articlesList = sqlSession.selectList("mapper.seller.selectAllArticlesList", cri);
		return articlesList;
	}

	// 승인된 글 목록
	@Override
	public List selectAcceptedArticlesList(Criteria cri) throws Exception {
		List<ArticleVO> articlesList = sqlSession.selectList("mapper.seller.selectAcceptedArticlesList", cri);
		return articlesList;
	}

	// 글 추가
	@Override
	public int insertNewArticle(Map articleMap) throws DataAccessException {
		int articleNO = selectNewArticleNO();
		articleMap.put("articleNO", articleNO);
		sqlSession.insert("mapper.seller.insertNewArticle", articleMap);
		return articleNO;
	}

	// 글 추가(이미지)
	@Override
	public void insertNewImage(Map articleMap) throws DataAccessException {
		List<ImageVO> imageFileList = (ArrayList)articleMap.get("imageFileList");
		String articleNO = articleMap.get("articleNO")+"";
		int imageFileNO = selectNewImageFileNO();
		if(imageFileList!=null && imageFileList.size()!=0) {
			for(ImageVO imageVO : imageFileList){
				imageVO.setImageFileNO(++imageFileNO);
				imageVO.setArticleNO(Integer.parseInt(articleNO));
			}
		}
		if(imageFileList != null && imageFileList.size()!=0) {
			sqlSession.insert("mapper.seller.insertNewImage",imageFileList);
		}
	}

	// 이미지 조회
	@Override
	public List selectImageFileList(int articleNO) throws DataAccessException {
		List<ImageVO> imageFileList = null;
		imageFileList = sqlSession.selectList("mapper.seller.selectImageFileList",articleNO);
		return imageFileList;
	}

	// 새 글 번호
	private int selectNewArticleNO() throws DataAccessException {
		return sqlSession.selectOne("mapper.seller.selectNewArticleNO");
	}

	// 새 승인된 글 번호
	private int selectNewArticleNO2() throws DataAccessException {
		return sqlSession.selectOne("mapper.seller.selectNewArticleNO_");
	}

	// 새 이미지 번호
	private int selectNewImageFileNO() throws DataAccessException {
		return sqlSession.selectOne("mapper.seller.selectNewImageFileNO");
	}

	// 글 승인
	public void acceptArticle(Map articleMap) {
		int articleNO_ = selectNewArticleNO2();
		articleMap.put("articleNO_", articleNO_);
		sqlSession.update("mapper.seller.acceptArticle", articleMap);
	}

	// 글 정보 조회
	@Override
	public ArticleVO selectArticle(int articleNO) throws DataAccessException {
		return sqlSession.selectOne("mapper.seller.selectArticle", articleNO);
	}

	// 조회수 증가
	@Override
	public void updateArticleHits(int articleNO) throws DataAccessException {
		sqlSession.update("mapper.seller.updateArticleHits",articleNO);
	}

	// 글 수정
	@Override
	public void updateArticle(Map articleMap) throws DataAccessException{
		sqlSession.update("mapper.seller.updateArticle",articleMap);
	}

	// 다중 이미지 올리기
	@Override
	public void updateArticleImage(List<ImageVO> imageFileList) throws DataAccessException {
		for(int i=0; i<imageFileList.size();i++){
			ImageVO imageVO = imageFileList.get(i);
			sqlSession.update("mapper.seller.updateArticleImage",imageVO);
		}
	}

	// 글 삭제
	@Override
	public void deleteArticle(int articleNO) throws DataAccessException {
		sqlSession.delete("mapper.bookmark.delete_BookmarkFarmer", articleNO);
		sqlSession.delete("mapper.seller.deleteArticle", articleNO);
	}


	@Override
	public void deleteExistedImage(Map<String,Object> imageMap) throws DataAccessException {
		sqlSession.delete("mapper.seller.deleteExistedImage",imageMap);
	}

	// 농부 카테고리에서 해당 글 북마크 여부 확인
	@Override
	public String checkFarmerBookmark(Map<String,Object> bookMap) throws DataAccessException { 
		return sqlSession.selectOne("mapper.bookmark.checkBookmark", bookMap);
	}

	@Override
	public List<BookmarkVO> select_FarmerBookmarkList(Map<String,Object> bookMap) throws Exception {
		int page=Integer.parseInt(bookMap.get("page")+"");
		page=(page-1)*10;
		System.out.println("page:"+page);
		bookMap.put("page",page);
		List<BookmarkVO> bookmarkList = sqlSession.selectList("mapper.bookmark.selectFarmerBookmark", bookMap);
		return bookmarkList;
	}

	// 리뷰 목록
	@Override
	public List<ReviewVO> selectReviewList(int articleNO) throws DataAccessException { 
		List<ReviewVO> reviewList = sqlSession.selectList("mapper.review.listReivew", articleNO);
		return reviewList;
	}

	// 회원의 리뷰 목록
	@Override
	public List<ReviewVO> selectMyReviewList(String n_name) throws DataAccessException { 
		List<ReviewVO> reviewList = sqlSession.selectList("mapper.review.listMyReivew", n_name);
		return reviewList;
	}

	// 리뷰 수정
	@Override
	public void updateReview(ReviewVO reviewVO) throws DataAccessException { 
		sqlSession.update("mapper.review.updateReview", reviewVO);
	}

	// 리뷰 삭제
	@Override
	public void deleteReview(int review_NO) throws DataAccessException { 
		sqlSession.delete("mapper.review.deleteReview", review_NO);
	}

	// 리뷰 삽입
	@Override
	public void insertReview(ReviewVO reviewVO) throws DataAccessException { 
		sqlSession.insert("mapper.review.insertReview", reviewVO);
	}

	// 해당 articleNO의 정보 가져오기
	@Override
	public ArticleVO selectItemInfo(int articleNO) throws DataAccessException { 
		return sqlSession.selectOne("mapper.seller.selectItemInfo", articleNO);
	}

	// 회원이 입력한 리뷰 가져오기
	@Override
	public ReviewVO selectMyReview(int review_NO) throws DataAccessException { 
		return sqlSession.selectOne("mapper.review.selectMyReview", review_NO);
	}

	// s_order 테이블의 해당 orderNO의 review_chk을 "Y"로 변경
	@Override
	public void updateReview_Chk_Y(int orderNO) throws DataAccessException { 
		sqlSession.update("mapper.order.updateReview_Chk_Y",orderNO);
	}



	/*키워드 검색*/
	// 모든 글 목록
	@Override
	public List selectAllArticlesList_searchedByKeyword(Map map) throws Exception {
		List<ArticleVO> articlesList = sqlSession.selectList("mapper.seller.selectAllArticlesList_searchedByKeyword", map);
		return articlesList;
	}

	// 승인된 글 목록
	@Override
	public List selectAcceptedArticlesList_searchedByKeyword(Map map) throws Exception {
		List<ArticleVO> articlesList = sqlSession.selectList("mapper.seller.selectAcceptedArticlesList_searchedByKeyword", map);
		return articlesList;
	}

	/*페이징*/
	// 모든 글 개수
	@Override
	public int countAllArticlesList() throws Exception {
		return (Integer) sqlSession.selectOne("mapper.seller.countAllArticlesList");
	}

	// 승인된 글 개수
	@Override
	public int countAcceptedArticlesList() throws Exception {
		return (Integer) sqlSession.selectOne("mapper.seller.countAcceptedArticlesList");
	}

	// 모든 글 갯수_ 키워드 검색
	@Override
	public int countAllArticlesList_searchedByKeyword(String keyword) throws Exception {
		return (Integer) sqlSession.selectOne("mapper.seller.countAllArticlesList_searchedByKeyword", keyword);
	}

	// 승인된 글 갯수_ 키워드 검색
	@Override
	public int countAcceptedArticlesList_searchedByKeyword(String keyword) throws Exception {
		return (Integer) sqlSession.selectOne("mapper.seller.countAcceptedArticlesList_searchedByKeyword", keyword);
	}

	// Article 이미지 썸네일
	@Override
	public String selectThumbnail(int articleNO) throws DataAccessException {
		return sqlSession.selectOne("mapper.seller.selectThumbnail", articleNO);
	}

	/*작성자 검색*/
	// 모든 글 갯수_ 작성자 검색
	@Override
	public int countAllArticlesList_searchedByWriter(String writer) throws Exception {
		return (Integer) sqlSession.selectOne("mapper.seller.countAllArticlesList_searchedByWriter", writer);
	}

	// 승인된 글 갯수_ 작성자 검색
	@Override
	public int countAcceptedArticlesList_searchedByWriter(String writer) throws Exception {
		return (Integer) sqlSession.selectOne("mapper.seller.countAcceptedArticlesList_searchedByWriter", writer);
	}

	// 모든 글 목록_ 작성자 검색
	@Override
	public List selectAllArticlesList_searchedByWriter(Map map) throws Exception {
		List<ArticleVO> articlesList = sqlSession.selectList("mapper.seller.selectAllArticlesList_searchedByWriter", map);
		return articlesList;
	}

	// 승인된 글 목록_ 작성자 검색
	@Override
	public List selectAcceptedArticlesList_searchedByWriter(Map map) throws Exception {
		List<ArticleVO> articlesList = sqlSession.selectList("mapper.seller.selectAcceptedArticlesList_searchedByWriter", map);
		return articlesList;
	}

	// 작성자 프로필 조회
	@Override
	public String getProfile(int articleNO) throws Exception {
		return sqlSession.selectOne("mapper.seller.getProfile", articleNO);
	}
}
