package com.spring.mysqltest.share.service;

import java.util.List;
import java.util.Map;

import com.spring.mysqltest.share.common.ResultUtil;
import com.spring.mysqltest.share.dto.BoardDto;
import com.spring.mysqltest.share.dto.BoardFileDto;
import com.spring.mysqltest.share.form.BoardFileForm;
import com.spring.mysqltest.share.form.BoardForm;
import com.spring.mysqltest.board.form.BookmarkVO;
import com.spring.mysqltest.share.form.CommentVO;
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
		
	public ResultUtil getMyShareList(BoardForm boardForm ,MemberVO member) throws Exception;	
	public void deleteMyShareList(BoardForm boardForm)throws Exception;	

	public BoardFileDto selectThumbnail(int board_seq) throws Exception;
	
	public String getWriter(int boardSeq) throws Exception;
	public List<String> searchByKeyword(String keyword) throws Exception;
	public List<CommentVO> listComments(int post_NO) throws Exception;
	public boolean addComment(CommentVO commentVO) throws Exception;
	public boolean deleteComment(int comment_NO) throws Exception;
	public boolean updateComment(Map<String,Object> commentMap) throws Exception;
	public String checkShareBookmark(Map<String,Object> bookMap) throws Exception;
	public boolean addShareBookmark(Map<String,Object> bookMap) throws Exception;
	public boolean deleteShareBookmark(Map<String,Object> bookMap) throws Exception;
	public List<BookmarkVO> listShareBookmark(Map<String,Object> bookMap) throws Exception;
	public boolean updateSell_YN(Map<String,Object> boardMap) throws Exception;
}
