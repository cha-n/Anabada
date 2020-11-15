package com.spring.mysqltest.seller.service;

import java.util.List;
import java.util.Map;

import com.spring.mysqltest.board.form.BookmarkVO;
import com.spring.mysqltest.seller.vo.ArticleVO;
import com.spring.mysqltest.seller.vo.Criteria;
import com.spring.mysqltest.seller.vo.ImageVO;
import com.spring.mysqltest.seller.vo.ReviewVO;

public interface BoardService {

	List<ArticleVO> listArticles(Criteria cri) throws Exception;	// 글 목록 조회_사용자
	List<ArticleVO> listArticles_admin(Criteria cri) throws Exception;	// 글 목록 조회_관리자
	public int addNewArticle(Map articleMap) throws Exception;	// 글 추가
	public Map viewArticle(int articleNO) throws Exception;	// 글 조회
	public void acceptArticle(int articleNO) throws Exception;	// 글 승인
	public void modArticle(Map<String,Object> articleMap) throws Exception;	//글 수정
	void removeArticle(int articleNO) throws Exception;		// 글 삭제
	void modArticleImage(List<ImageVO> imageFileList) throws Exception;		// 이미지 수정
	ArticleVO articleDetail(int articleNO) throws Exception;	//글 조회
	void updateArticleHits(int articleNO) throws Exception;	// 조회수 증가
	int countAllArticlesList() throws Exception;	// 모든 글 개수 조회
	int countAcceptedArticlesList() throws Exception;	// 승인된 글 개수 조회
	List<ArticleVO> listArticles_admin_searchedByKeyword(Map map) throws Exception;	// 모든 글 목록 조회_키워드 검색
	List<ArticleVO> listArticles_searchedByKeyword(Map map) throws Exception;	// 승인된 글 목록 조회_키워드 검색
	int countAllArticlesList_searchedByKeyword(String keyword) throws Exception;	// 모든 글 개수 조회_키워드 검색
	int countAcceptedArticlesList_searchedByKeyword(String keyword) throws Exception;	// 승인된 글 개수 조회_키워드 검색
	String selectThumbnail(int articleNO) throws Exception;		// 이미지 썸네일
	List<ArticleVO> listArticles_admin_searchedByWriter(Map map) throws Exception;	// 모든 글 목록 조회_작성자 검색
	List<ArticleVO> listArticles_searchedByWriter(Map map) throws Exception;	// 승인된 글 목록 조회_작성자 검색
	int countAllArticlesList_searchedByWriter(String writer) throws Exception;	// 모든 글 개수 조회_작성자 검색
	int countAcceptedArticlesList_searchedByWriter(String writer) throws Exception;		// 승인된 글 개수 조회_작성자 검색
	String getProfile(int articleNO) throws Exception;	// 작성자 프로필 조회
	/*YS*/
	public void deleteExistedImage(Map<String,Object> imageMap) throws Exception;
	public String checkFarmerBookmark(Map<String,Object> bookMap) throws Exception;
	public List<BookmarkVO> listFarmerBookmark(Map<String,Object> bookMap) throws Exception;
	public List<ReviewVO> selectMyReviewList(String n_name) throws Exception; // 회원의 리뷰 목록
	public void updateReview(ReviewVO reviewVO) throws Exception; // 회원의 리뷰 수정
	public void deleteReview(int review_NO) throws Exception; // 회원의 리뷰 삭제
	public void addReview(ReviewVO reviewVO) throws Exception; // 회원의 리뷰 삽입
	public ArticleVO selectItemInfo(int articleNO) throws Exception; //해당 articleNO의 제목 등의 정보를 가져옴
	public ReviewVO selectMyReview(int review_NO) throws Exception; //회원이 입력한 review 가져오기
}