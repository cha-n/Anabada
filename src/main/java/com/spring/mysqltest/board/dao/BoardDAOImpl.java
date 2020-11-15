package com.spring.mysqltest.board.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.spring.mysqltest.board.dto.BoardDto;
import com.spring.mysqltest.board.dto.BoardFileDto;
import com.spring.mysqltest.board.form.BoardFileForm;
import com.spring.mysqltest.board.form.BoardForm;
import com.spring.mysqltest.board.form.BookmarkVO;
import com.spring.mysqltest.board.form.CommentVO;
import com.spring.mysqltest.market.vo.VegatVO;
import com.spring.mysqltest.member.vo.MemberVO;
import com.spring.mysqltest.seller.vo.ArticleVO;

@Repository("boardDAO")
public class BoardDAOImpl implements BoardDAO {
	@Autowired
	private SqlSession sqlSession;
	private VegatVO vegat;

	private static final String NAMESPACE = "com.spring.mysqltest.board.boardMapper";

	/**  게시판 - 목록 수*/
	@Override
	public int getBoardCnt(BoardForm boardForm) throws Exception {

		return sqlSession.selectOne(NAMESPACE + ".getBoardCnt", boardForm);
	}

	/** 게시판 - 목록 조회 */
	@Override
	public List<BoardDto> getBoardList(BoardForm boardForm) throws Exception {

		return sqlSession.selectList(NAMESPACE + ".getBoardList", boardForm);
	}

	/** 게시판 - 조회 수 수정*/
	@Override
	public int updateBoardHits(int boardSeq) throws Exception {

		return sqlSession.update(NAMESPACE + ".updateBoardHits", boardSeq);
	}

	/** 게시판 - 상세 조회 */
	@Override
	public BoardDto getBoardDetail(int boardSeq) throws Exception {

		return sqlSession.selectOne(NAMESPACE + ".getBoardDetail",boardSeq);
	}

	/** 게시판 - 첨부파일 조회 */
	@Override
	public List<BoardFileDto> getBoardFileList(int boardSeq) throws Exception {

		return sqlSession.selectList(NAMESPACE + ".getBoardFileList", boardSeq);
	}

	/** 게시판 - 그룹 번호 조회 */
	@Override
	public int getBoardReRef(BoardForm boardForm) throws Exception {

		return sqlSession.selectOne(NAMESPACE + ".getBoardReRef", boardForm);
	}

	/** 게시판 - 등록 */
	@Override
	public int insertBoard(BoardForm boardForm) throws Exception {
		return sqlSession.insert(NAMESPACE + ".insertBoard", boardForm);
	}

	/** 게시판 - 첨부파일 등록 */
	@Override
	public int insertBoardFile(BoardFileForm boardFileForm) throws Exception {
		return sqlSession.insert(NAMESPACE + ".insertBoardFile", boardFileForm);
	}

	/** 게시판 - 등록 실패(트랜잭션 테스트) */
	@Override
	public int insertBoardFail(BoardForm boardForm) throws Exception {
		return sqlSession.insert(NAMESPACE + ".insertBoardFail", boardForm);
	}

	/** 게시판 - 삭제 */
	@Override
	public int deleteBoard(BoardForm boardForm) throws Exception {
		int post_NO=boardForm.getBoard_seq();
		sqlSession.delete("mapper.bookmark.delete_BookmarkSell", post_NO);
		return sqlSession.delete(NAMESPACE + ".deleteBoard", boardForm);
	}

	/** 게시판 - 수정 */
	@Override
	public int updateBoard(BoardForm boardForm) throws Exception {

		return sqlSession.update(NAMESPACE + ".updateBoard", boardForm);
	}

	/** 게시판 - 답글 정보  조회 */
	@Override
	public BoardDto getBoardReplyInfo(BoardForm boardForm) throws Exception {
		return sqlSession.selectOne(NAMESPACE + ".getBoardReplyInfo", boardForm);
	}

	/** 게시판 - 답글의 순서 수정*/
	@Override
	public int updateBoardReSeq(BoardForm boardForm) throws Exception {

		return sqlSession.update(NAMESPACE + ".updateBoardReSeq", boardForm);
	}

	/** 게시판 - 답글 등록 */
	@Override
	public int insertBoardReply(BoardForm boardForm) throws Exception {
		return sqlSession.insert(NAMESPACE + ".insertBoardReply", boardForm);
	}

	/** 게시판 - 첨부파일 삭제 */
	@Override
	public int deleteBoardFile(BoardFileForm boardFileForm) throws Exception {
		return sqlSession.update(NAMESPACE + ".deleteBoardFile", boardFileForm);
	}

	/** 게시판 - 첨부파일 이름 가져오기 */
	@Override
	public String getFileNameKey(BoardFileForm boardFileForm) throws Exception {
		return sqlSession.selectOne(NAMESPACE + ".getFileNameKey", boardFileForm);
	} 
	
	

	
	/**영양소*/
	@Override
	public List<VegatVO> selectVegats(String[] items) throws DataAccessException {
		List<VegatVO> vegatList = new ArrayList<VegatVO>();
		for(String name:items) {
			System.out.println("item:"+name);
			vegat=sqlSession.selectOne("mapper.vegat.selectVegat", name);
			vegatList.add(vegat);
		}
		return vegatList;
	}
	
	/**아이템불러오기*/
	@Override
	public String selectItems(int boardSeq) throws Exception {
		return sqlSession.selectOne(NAMESPACE + ".selectItems", boardSeq);
	}
	
	/** 내글 목록 조회(판매)*/
	@Override
	public List<BoardDto> getMyBoardList(MemberVO member) throws DataAccessException { //판매 카테고리- 회원이 작성한 리스트list
		
		return  sqlSession.selectList(NAMESPACE +".getMyboardList", member);

	}
	
	/** 내가쓴 글 목록 수(판매)*/
	@Override
	public int getMyBoardCnt(String n_name) throws Exception {
		return sqlSession.selectOne(NAMESPACE + ".getMyBoardCnt", n_name);
	}
	
	/**정은수정2 내글 목록 조회(농부)*/
	@Override
	public List<ArticleVO> getMyFarmerList(MemberVO member) throws DataAccessException { //판매 카테고리- 회원이 작성한 리스트list(농부)		
		
		return  sqlSession.selectList(NAMESPACE +".getMyFarmerList", member);
	}
		
	/**내가쓴 글 목록 수(농부)*/
	@Override
	public int getMyFarmerCnt(String n_name) throws Exception {
		return sqlSession.selectOne(NAMESPACE + ".getMyFarmerCnt", n_name);
	}
	
	/**내글 목록 삭제(판매)*/
	@Override
	public void deleteMyBoard(BoardForm boardForm) throws Exception{
		sqlSession.delete(NAMESPACE +".deleteMyBoardList", boardForm);
	}
	
	/**내글 목록 삭제-농부*/
	@Override
	public void deleteMyFarmer(ArticleVO articleVO) throws Exception{
		sqlSession.delete(NAMESPACE +".deleteMyFarmerList", articleVO);
	}
	
	/**이미지 썸네일*/
	@Override
	public BoardFileDto selectThumbnail(int board_seq) throws DataAccessException {
		return sqlSession.selectOne(NAMESPACE +".selectThumbnail", board_seq);
	}	
		
	// 농부이미지 썸네일
	@Override
	public String selectsellerThumbnail(int board_seq) throws DataAccessException {
		return sqlSession.selectOne(NAMESPACE +".selectsellerThumbnail", board_seq);
	}
	
	
	//판매자 쓴 글 조회기능
	/**  판매자 - 글 목록 조회(판매)*/
	@Override
	public List<BoardDto> getSellerBoardList(BoardForm boardForm) throws DataAccessException { //판매 카테고리- 회원이 작성한 리스트list
		
		return  sqlSession.selectList(NAMESPACE +".getSellerBoardList", boardForm);
	}
	
	/**  판매자- 글 목록 수*/
	@Override
	public int getSellerBoardCnt(String board_writer) throws Exception {
		return sqlSession.selectOne(NAMESPACE + ".getSellerBoardCnt", board_writer);
	}
	
	/** 판매자 - 글 목록 조회(농부)*/
	@Override
	public List<ArticleVO> getSellerFarmerList(ArticleVO articleVO ) throws DataAccessException { //판매 카테고리- 회원이 작성한 리스트list(농부)		
		
		return  sqlSession.selectList(NAMESPACE +".getSellerFarmerList", articleVO);
	}
	
	/*정은수정 키워드 검색*/
	@Override
	public List<BoardDto> listSearch(BoardForm boardForm) throws Exception {
		return sqlSession.selectList(NAMESPACE+".listSearch", boardForm);	
	}
	
	@Override
	public int countSearch(BoardForm boardForm) throws Exception {
		return sqlSession.selectOne(NAMESPACE+".countSearch", boardForm);
	}
	
	
	/** 여기서부터 예슬 코드 */
	@Override
	public String getWriter(int board_seq) throws Exception { //글쓴이 이름 검색
		return sqlSession.selectOne(NAMESPACE + ".getWriter", board_seq);
	}
	
	@Override
	public List<String> searchByKeyword(String keyword) throws Exception { //키워드로 품목 검색
		return sqlSession.selectList("mapper.vegat.searchByKeyword", keyword);
	}
	
	@Override
	public List<CommentVO> selectComments(int post_NO) throws DataAccessException { //해당 post_NO의 댓글 목록
		List<CommentVO> commentList = null;
		commentList = sqlSession.selectList("mapper.comment.selectComments", post_NO);
		return commentList;
	}
	
	@Override
	public void insertComment(CommentVO commentVO) throws DataAccessException { //댓글 등록
		sqlSession.insert("mapper.comment.insertComment", commentVO);
	}
	
	@Override
	public int select_commentNO() throws DataAccessException { //comment_NO+1를 반환
		return sqlSession.selectOne("mapper.comment.select_commentNO");
	}
	
	@Override
	public int selectSeq(int parent_NO) throws DataAccessException { //해당 parent_NO에서의 최대 seq값+1 반환
		return sqlSession.selectOne("mapper.comment.selectSeq", parent_NO);
	}
	
	@Override
	public CommentVO checkSeq(int comment_NO) throws DataAccessException { //해당 comment_NO에서의 seq값
		return sqlSession.selectOne("mapper.comment.checkSeq", comment_NO);
	}
	
	@Override
	public void deleteComment1(int parent_NO) throws DataAccessException { //댓글 삭제
		sqlSession.delete("mapper.comment.deleteComment1",parent_NO);
	}
	
	@Override
	public void deleteComment2(int comment_NO) throws DataAccessException { //대댓글 삭제
		sqlSession.delete("mapper.comment.deleteComment2",comment_NO);
	}
	
	@Override
	public void updateComment(Map<String,Object> commentMap) throws DataAccessException { //댓글 수정
		sqlSession.update("mapper.comment.updateComment", commentMap);
	}
	
	@Override
	public String checkSellBookmark(Map<String,Object> bookMap) throws DataAccessException { //판매 카테고리에서 해당 글 북마크 여부 확인
		return sqlSession.selectOne("mapper.bookmark.checkBookmark", bookMap);
	}

	@Override
	public void addSellBookmark(Map<String,Object> bookMap) throws DataAccessException { // 해당 글 북마크 설정
		sqlSession.insert("mapper.bookmark.addBookmark1", bookMap);
	}
	
	@Override
	public void deleteSellBookmark(Map<String,Object> bookMap) throws DataAccessException { //해당 글 북마크 해제
		sqlSession.delete("mapper.bookmark.deleteBookmark1", bookMap);
	}
	
	@Override
	public int select_Total_Bookmark(Map<String,Object> bookMap) throws DataAccessException { //카테고리별 북마크한 글의 수

		return sqlSession.selectOne("mapper.bookmark.select_Total_Bookmark", bookMap);
	}
	
	@Override
	public List<BookmarkVO> listSellBookmark(Map<String,Object> bookMap) throws DataAccessException { //판매 카테고리 중 회원이 추가해놓은 북마크 list
		int page=Integer.parseInt(bookMap.get("page")+"");
		page=(page-1)*10;
		bookMap.put("page",page);
		List<BookmarkVO> bookmarkList = null;
		bookmarkList = sqlSession.selectList("mapper.bookmark.selectSellBookmark", bookMap);
		return bookmarkList;
	}
	
	@Override
	public void updateSell_YN(Map<String,Object> boardMap) throws DataAccessException { //sell_YN(판매여부) 변경
		sqlSession.update(NAMESPACE + ".updateSell_YN", boardMap);
	}

}