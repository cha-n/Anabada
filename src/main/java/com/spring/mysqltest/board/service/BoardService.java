package com.spring.mysqltest.board.service;

import java.util.List;
import java.util.Map;

import com.spring.mysqltest.board.common.ResultUtil;
import com.spring.mysqltest.board.dto.BoardDto;
import com.spring.mysqltest.board.dto.BoardFileDto;
import com.spring.mysqltest.board.form.BoardFileForm;
import com.spring.mysqltest.board.form.BoardForm;
import com.spring.mysqltest.board.form.BookmarkVO;
import com.spring.mysqltest.board.form.CommentVO;
import com.spring.mysqltest.market.vo.VegatVO;
import com.spring.mysqltest.member.vo.MemberVO;
import com.spring.mysqltest.seller.vo.ArticleVO;

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
	
	public ResultUtil getMyBoardList(BoardForm boardForm ,MemberVO member) throws Exception;
	public ResultUtil getMyFarmerList(ArticleVO articleVO ,MemberVO member,String user) throws Exception;
	public void deleteMyBoardList(BoardForm boardForm)throws Exception;
	public void deleteMyFarmerList(ArticleVO articleVO)throws Exception;
	public BoardFileDto selectThumbnail(int board_seq) throws Exception;
	public String selectsellerThumbnail(int board_seq) throws Exception;
	
	public String getWriter(int boardSeq) throws Exception;
	public List<String> searchByKeyword(String keyword) throws Exception;
	public List<CommentVO> listComments(int post_NO) throws Exception;
	public boolean addComment(CommentVO commentVO) throws Exception;
	public boolean deleteComment(int comment_NO) throws Exception;
	public boolean updateComment(Map<String,Object> commentMap) throws Exception;
	public String checkSellBookmark(Map<String,Object> bookMap) throws Exception;
	public boolean addSellBookmark(Map<String,Object> bookMap) throws Exception;
	public boolean deleteSellBookmark(Map<String,Object> bookMap) throws Exception;
	public Map<String,Object> select_Total_Bookmark(Map<String,Object> bookMap) throws Exception; //카테고리별 북마크한 글의 수
	public List<BookmarkVO> listSellBookmark(Map<String,Object> bookMap) throws Exception;
	public boolean updateSell_YN(Map<String,Object> boardMap) throws Exception;
	public String add_delete_Bookmark(Map<String,Object> bookMap) throws Exception; //북마크 여부 판단 후 추가 및 삭제
}
