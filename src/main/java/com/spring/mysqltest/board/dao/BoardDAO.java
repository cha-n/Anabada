package com.spring.mysqltest.board.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.spring.mysqltest.board.dto.BoardDto;
import com.spring.mysqltest.board.dto.BoardFileDto;
import com.spring.mysqltest.board.form.BoardFileForm;
import com.spring.mysqltest.board.form.BoardForm;
import com.spring.mysqltest.board.form.BookmarkVO;
import com.spring.mysqltest.board.form.CommentVO;
import com.spring.mysqltest.market.vo.VegatVO;
import com.spring.mysqltest.member.vo.MemberVO;
import com.spring.mysqltest.seller.vo.ArticleVO;

public interface BoardDAO {
	public int getBoardCnt(BoardForm boardForm) throws Exception;
	public List<BoardDto> getBoardList(BoardForm boardForm) throws Exception;
	public int updateBoardHits(int boardSeq) throws Exception;
	public BoardDto getBoardDetail(int boardSeq) throws Exception;
	public List<BoardFileDto> getBoardFileList(int boardSeq) throws Exception;
	public int getBoardReRef(BoardForm boardForm) throws Exception;
	public int insertBoard(BoardForm boardForm) throws Exception;
	public int insertBoardFile(BoardFileForm boardFileForm) throws Exception;
	public int insertBoardFail(BoardForm boardForm) throws Exception;
	public int deleteBoard(BoardForm boardForm) throws Exception;
	public int updateBoard(BoardForm boardForm) throws Exception;
	public BoardDto getBoardReplyInfo(BoardForm boardForm) throws Exception;
	public int updateBoardReSeq(BoardForm boardForm) throws Exception;
	public int insertBoardReply(BoardForm boardForm) throws Exception;
	public int deleteBoardFile(BoardFileForm boardFileForm) throws Exception;
	
	public String selectItems(int boardSeq) throws Exception;
	public List<VegatVO> selectVegats(String[] items) throws DataAccessException;
	public String getFileNameKey(BoardFileForm boardFileForm) throws Exception;
	public List<BoardDto> getMyBoardList(MemberVO member) throws DataAccessException;
	public List<ArticleVO> getMyFarmerList(MemberVO member) throws DataAccessException;
	public int getMyFarmerCnt(String n_name) throws Exception;
	public int getMyBoardCnt(String n_name) throws Exception;
	public void deleteMyFarmer(ArticleVO articleVO) throws Exception;	
	public void deleteMyBoard(BoardForm boardForm) throws Exception;
	public BoardFileDto selectThumbnail(int board_seq) throws DataAccessException;
	public String selectsellerThumbnail(int board_seq) throws DataAccessException;
	public List<BoardDto> getSellerBoardList(BoardForm boardForm) throws DataAccessException;
	public int getSellerBoardCnt(String board_writer) throws Exception;
	public List<ArticleVO> getSellerFarmerList(ArticleVO articleVO ) throws DataAccessException;	
	/*글 검색기능 */
	public List<BoardDto> listSearch(BoardForm boardForm) throws Exception;
	public int countSearch(BoardForm boardForm) throws Exception;
	
	public String getWriter(int board_seq) throws Exception;
	public List<String> searchByKeyword(String keyword) throws Exception;
	public List<CommentVO> selectComments(int post_NO) throws DataAccessException;
	public void insertComment(CommentVO commentVO) throws DataAccessException;
	public int select_commentNO() throws DataAccessException;
	public int selectSeq(int parent_NO) throws DataAccessException;
	public CommentVO checkSeq(int comment_NO) throws DataAccessException;
	public void deleteComment1(int parent_NO) throws DataAccessException;
	public void deleteComment2(int comment_NO) throws DataAccessException;
	public void updateComment(Map<String,Object> commentMap) throws DataAccessException;
	public String checkSellBookmark(Map<String,Object> bookMap) throws DataAccessException;
	public void addSellBookmark(Map<String,Object> bookMap) throws DataAccessException;
	public void deleteSellBookmark(Map<String,Object> bookMap) throws DataAccessException;
	public int select_Total_Bookmark(Map<String,Object> bookMap) throws DataAccessException; //카테고리별 북마크한 글의 수
	public List<BookmarkVO> listSellBookmark(Map<String,Object> bookMap) throws DataAccessException;
	public void updateSell_YN(Map<String,Object> boardMap) throws DataAccessException;
}