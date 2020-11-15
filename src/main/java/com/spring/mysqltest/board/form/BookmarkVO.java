package com.spring.mysqltest.board.form;

import org.springframework.stereotype.Component;

import com.spring.mysqltest.seller.vo.ArticleVO;
import com.spring.mysqltest.seller.vo.ImageVO;

@Component("bookmarkVO")
public class BookmarkVO {
	private int bookmark_NO;
	private String category;
	private int post_NO;
	private String n_name;
	private BoardForm boardForm;
	private ArticleVO articleVO;
	private BoardFileForm boardFileForm;
	private ImageVO imageVO;
	
	public BookmarkVO() {
		
	}
	public BookmarkVO(int bookmark_NO,int post_NO,String n_name) {
		this.bookmark_NO=bookmark_NO;
		this.post_NO=post_NO;
		this.n_name=n_name;
	}
	public int getBookmark_NO() {
		return bookmark_NO;
	}
	public void setBookmark_NO(int bookmark_NO) {
		this.bookmark_NO = bookmark_NO;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public int getPost_NO() {
		return post_NO;
	}
	public void setPost_NO(int post_NO) {
		this.post_NO = post_NO;
	}
	public String getN_name() {
		return n_name;
	}
	public void setN_name(String n_name) {
		this.n_name = n_name;
	}
	public BoardForm getBoardForm() {
		return boardForm;
	}
	public void setBoardForm(BoardForm boardForm) {
		this.boardForm = boardForm;
	}
	public ArticleVO getArticleVO() {
		return articleVO;
	}
	public void setArticleVO(ArticleVO articleVO) {
		this.articleVO = articleVO;
	}
	public BoardFileForm getBoardFileForm() {
		return boardFileForm;
	}
	public void setBoardFileForm(BoardFileForm boardFileForm) {
		this.boardFileForm = boardFileForm;
	}
	public ImageVO getImageVO() {
		return imageVO;
	}
	public void setImageVO(ImageVO imageVO) {
		this.imageVO = imageVO;
	}
	
}