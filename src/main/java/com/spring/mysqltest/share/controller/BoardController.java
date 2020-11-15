package com.spring.mysqltest.share.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.spring.mysqltest.share.common.ResultUtil;
import com.spring.mysqltest.share.dto.BoardDto;
import com.spring.mysqltest.share.form.BoardForm;
import com.spring.mysqltest.board.form.BookmarkVO;
import com.spring.mysqltest.share.form.CommentVO;

public interface BoardController {
	public ResultUtil getBoardList(HttpServletRequest request, HttpServletResponse response, BoardForm boardForm) throws Exception;
	public BoardDto getBoardDetail(@RequestParam("boardSeq") int boardSeq,HttpServletRequest request, HttpServletResponse response) throws Exception;
	public BoardDto insertBoard(HttpServletRequest request, HttpServletResponse response, BoardForm boardForm) throws Exception;
	public BoardDto deleteBoard(HttpServletRequest request, HttpServletResponse response, BoardForm boardForm) throws Exception;
	public BoardDto updateBoard(HttpServletRequest request, HttpServletResponse response, BoardForm boardForm) throws Exception;
	public BoardDto insertBoardReply(HttpServletRequest request, HttpServletResponse response, BoardForm boardForm) throws Exception;

	
	public ResultUtil getMyShareList(HttpServletRequest request,HttpServletResponse response,BoardForm boardForm) throws Exception;
	public @ResponseBody int deleteMyShareList(@RequestParam(value="chbox[]") List<String> chArr, BoardForm boardForm,HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	
	public @ResponseBody String addComment(@ModelAttribute("commentVO") CommentVO commentVO, HttpServletRequest request, HttpServletResponse response) throws Exception;
	public @ResponseBody String deleteComment(@RequestParam("comment_NO") int comment_NO, HttpServletRequest request, HttpServletResponse response) throws Exception;
	public @ResponseBody String updateComment(@RequestParam("comment_NO") int comment_NO, @RequestParam("content") String content, @RequestParam("secret") char secret, HttpServletRequest request, HttpServletResponse response) throws Exception;
	public @ResponseBody String addShareBookmark(@RequestParam("post_NO") int post_NO, @RequestParam("n_name") String n_name, @RequestParam("category") String category, HttpServletRequest request, HttpServletResponse response) throws Exception;
	public @ResponseBody String deleteShareBookmark(@RequestParam("post_NO") int post_NO, @RequestParam("n_name") String n_name, @RequestParam("category") String category, HttpServletRequest request, HttpServletResponse response) throws Exception;
	public @ResponseBody List<BookmarkVO> listShareBookmark(@RequestParam String n_name, @RequestParam("page") int page, HttpServletRequest request, HttpServletResponse response) throws Exception;
	public @ResponseBody String updateSell_YN(@RequestParam("post_NO") int post_NO, @RequestParam("sell_YN") String sell_YN, HttpServletRequest request, HttpServletResponse response) throws Exception;
	/** 게시판 - 목록 조회  */

}