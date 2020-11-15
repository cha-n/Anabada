package com.spring.mysqltest.seller.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.spring.mysqltest.board.form.BookmarkVO;
import com.spring.mysqltest.seller.vo.Criteria;
import com.spring.mysqltest.seller.vo.ReviewVO;

public interface BoardController {
	public ModelAndView listArticles(String keyword, String writer, Criteria cri, HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ResponseEntity addNewArticle(MultipartHttpServletRequest multipartRequest, HttpServletResponse response) throws Exception;
	public ResponseEntity acceptArticle(int articleNO, HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ResponseEntity removeArticle(int articleNO, HttpServletRequest request, HttpServletResponse response) throws Exception;
	public @ResponseBody List<BookmarkVO> listFarmerBookmark(@RequestParam("n_name") String n_name, @RequestParam("page") int page, HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView writeReviewForm(@RequestParam("articleNO") int articleNO, @RequestParam("orderNO") int orderNO, HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ResponseEntity addReview(@ModelAttribute("reviewVO") ReviewVO reviewVO, HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView myReview(HttpServletRequest request, HttpServletResponse response) throws Exception; 
	public ModelAndView modReview(@RequestParam("review_NO") int review_NO, HttpServletRequest request, HttpServletResponse response) throws Exception; 
	public ResponseEntity modifyReview(@ModelAttribute("reviewVO") ReviewVO reviewVO, HttpServletRequest request, HttpServletResponse response) throws Exception; 
	public ResponseEntity deleteReview(@RequestParam("review_NO") int review_NO, HttpServletRequest request, HttpServletResponse response) throws Exception; 
}
