package com.spring.mysqltest.exchange.service;

import java.util.List;
import java.util.Map;

import com.spring.mysqltest.exchange.common.ResultUtil;
import com.spring.mysqltest.exchange.dto.BoardDto;
import com.spring.mysqltest.exchange.dto.BoardFileDto;
import com.spring.mysqltest.exchange.form.BoardFileForm;
import com.spring.mysqltest.exchange.form.BoardForm;
import com.spring.mysqltest.board.form.BookmarkVO;
import com.spring.mysqltest.exchange.form.CommentVO;
import com.spring.mysqltest.market.vo.VegatVO;
import com.spring.mysqltest.member.vo.MemberVO;

public interface BoardService {
	public ResultUtil getBoardList(BoardForm boardForm) throws Exception;
	public BoardDto getBoardDetail(int boardSeq) throws Exception;
	public BoardDto insertBoard(BoardForm boardForm) throws Exception;
	public List<BoardFileForm> getBoardFileInfo(BoardForm boardForm) throws Exception;
	public BoardDto deleteBoard(BoardForm boardForm) throws Exception;
	public BoardDto updateBoard(BoardForm boardForm) throws Exception;
	public BoardDto insertBoardReply(BoardForm boardForm) throws Exception;
	public List<VegatVO> listVegats(String[] items) throws Exception;
	public String listItems(int board_seq) throws Exception;
		
	public ResultUtil getMyExchangeList(BoardForm boardForm ,MemberVO member) throws Exception;	
	public void deleteMyExchangeList(BoardForm boardForm)throws Exception;	

	public BoardFileDto selectThumbnail(int board_seq) throws Exception;
	
	public String getWriter(int boardSeq) throws Exception;
	public List<String> searchByKeyword(String keyword) throws Exception;
	public List<CommentVO> listComments(int post_NO) throws Exception;
	public boolean addComment(CommentVO commentVO) throws Exception;
	public boolean deleteComment(int comment_NO) throws Exception;
	public boolean updateComment(Map<String,Object> commentMap) throws Exception;
	public String checkExchangeBookmark(Map<String, Object> bookMap) throws Exception;
	public boolean addExchangeBookmark(Map<String,Object> bookMap) throws Exception; // 교환 카테고리에서 해당 글 북마크 설정
	public boolean deleteExchangeBookmark(Map<String,Object> bookMap) throws Exception;
	public List<BookmarkVO> listExchangeBookmark(Map<String,Object> bookMap) throws Exception;
	public boolean updateSell_YN(Map<String,Object> boardMap) throws Exception;
}
