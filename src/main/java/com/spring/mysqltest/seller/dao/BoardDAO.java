package com.spring.mysqltest.seller.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.spring.mysqltest.board.form.BookmarkVO;
import com.spring.mysqltest.seller.vo.ArticleVO;
import com.spring.mysqltest.seller.vo.Criteria;
import com.spring.mysqltest.seller.vo.ImageVO;
import com.spring.mysqltest.seller.vo.ReviewVO;

public interface BoardDAO {

	List selectAllArticlesList(Criteria cri) throws Exception;	// 모든 글 목록
	List selectAcceptedArticlesList(Criteria cri) throws Exception;		// 승인된 글 목록
	int insertNewArticle(Map articleMap) throws DataAccessException;	// 글 추가
	public ArticleVO selectArticle(int articleNO) throws DataAccessException;	// 글 정보 조회
	public void acceptArticle(Map articleMap) throws Exception;		// 글 승인
	public void updateArticle(Map articleMap) throws DataAccessException;	//글 수정
	public void deleteArticle(int articleNO) throws DataAccessException;	// 글 삭제
	public void insertNewImage(Map articleMap) throws DataAccessException;	// 글 추가
	public List selectImageFileList(int articleNO) throws DataAccessException;	// 이미지 조회
	public void updateArticleImage(List<ImageVO> imageFileList) throws DataAccessException;		// 다중 이미지 올리기
	public void updateArticleHits(int articleNO) throws DataAccessException;	// 조회수 증가
	int countAllArticlesList() throws Exception;	// 모든 글 갯수_페이징
	int countAcceptedArticlesList() throws Exception;	// 승인된 글 갯수_페이징
	List selectAllArticlesList_searchedByKeyword(Map map) throws Exception;		// 모든 글 목록_키워드 검색
	List selectAcceptedArticlesList_searchedByKeyword(Map map) throws Exception; 	// 승인된 글 목록_키워드 검색
	int countAllArticlesList_searchedByKeyword(String keyword) throws Exception;	// 모든 글 갯수_키워드 검색
	int countAcceptedArticlesList_searchedByKeyword(String keyword) throws Exception;	// 승인된 글 갯수_키워드 검색
	List selectAllArticlesList_searchedByWriter(Map map) throws Exception;		// 모든 글 목록_작성자 검색
	List selectAcceptedArticlesList_searchedByWriter(Map map) throws Exception;		// 승인된 글 목록_작성자 검색
	int countAllArticlesList_searchedByWriter(String writer) throws Exception;		// 모든 글 갯수_작성자 검색
	int countAcceptedArticlesList_searchedByWriter(String writer) throws Exception;		// 승인된 글 갯수_작성자 검색
	String getProfile(int articleNO) throws Exception;	// 작성자 프로필 조회
	public void deleteExistedImage(Map<String,Object> imageMap) throws DataAccessException;
	public String checkFarmerBookmark(Map<String,Object> bookMap) throws DataAccessException; //농부 카테고리에서 해당 글 북마크 여부 확인
	public List<BookmarkVO> select_FarmerBookmarkList(Map<String,Object> bookMap) throws Exception;
	String selectThumbnail(int articleNO) throws DataAccessException;
	public List<ReviewVO> selectReviewList(int articleNO) throws DataAccessException; // 해당글의 리뷰 목록
	public List<ReviewVO> selectMyReviewList(String n_name) throws DataAccessException; // 회원의 리뷰 목록
	public void updateReview(ReviewVO reviewVO) throws DataAccessException; // 회원의 리뷰 수정
	public void deleteReview(int review_NO) throws DataAccessException; // 회원의 리뷰 삭제
	public void insertReview(ReviewVO reviewVO) throws DataAccessException; //회원의 리뷰 삽입
	public ArticleVO selectItemInfo(int articleVO) throws DataAccessException; //해당 articleNO의 제목 등의 정보를 가져옴
	public ReviewVO selectMyReview(int review_NO) throws DataAccessException; //회원이 입력한 review 가져오기
	public void updateReview_Chk_Y(int orderNO) throws DataAccessException;	//s_order테이블의 해당 orderN0의 review_chk을 "Y"로 변경
}
