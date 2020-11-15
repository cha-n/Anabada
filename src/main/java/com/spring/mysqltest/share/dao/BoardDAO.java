package com.spring.mysqltest.share.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.spring.mysqltest.share.dto.BoardDto;
import com.spring.mysqltest.share.dto.BoardFileDto;
import com.spring.mysqltest.share.form.BoardFileForm;
import com.spring.mysqltest.share.form.BoardForm;
import com.spring.mysqltest.board.form.BookmarkVO;
import com.spring.mysqltest.share.form.CommentVO;
import com.spring.mysqltest.market.vo.VegatVO;
import com.spring.mysqltest.member.vo.MemberVO;

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
	/*첨부파일 이름가져오기 */
	public String getFileNameKey(BoardFileForm boardFileForm) throws Exception;
	/*정은수정*/
	public List<BoardDto> getMyShareList(MemberVO member) throws DataAccessException;		
	public int getMyShareCnt(String n_name) throws Exception;	
	public void deleteMyShare(BoardForm boardForm) throws Exception;
	/*정은수정 판매자 글정보 조회*/
	public List<BoardDto> getSellerShareList(BoardForm boardForm) throws DataAccessException;
	public int getSellerShareCnt(String board_writer) throws Exception;
	/*썸네일*/
	public BoardFileDto selectThumbnail(int board_seq) throws DataAccessException;
	/*글 검색기능*/
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
	public String checkShareBookmark(Map<String,Object> bookMap) throws DataAccessException;
	public void addShareBookmark(Map<String,Object> bookMap) throws DataAccessException;
	public void deleteShareBookmark(Map<String,Object> bookMap) throws DataAccessException;
	public List<BookmarkVO> listShareBookmark(Map<String,Object> bookMap) throws DataAccessException;
	public void updateSell_YN(Map<String,Object> boardMap) throws DataAccessException;
}