package com.spring.mysqltest.seller.vo;

import org.springframework.stereotype.Component;

import com.spring.mysqltest.member.vo.MemberVO;

@Component("reviewVO")
public class ReviewVO {
	private int review_NO;
	private int articleNO;
	private String n_name;
	private int star;
	private String content;
	private String writedate;
	private MemberVO memberVO;
	private ArticleVO articleVO;
	private String title;
	private int orderNO;
	
	public int getReview_NO() {
		return review_NO;
	}
	public void setReview_NO(int review_NO) {
		this.review_NO = review_NO;
	}
	public int getArticleNO() {
		return articleNO;
	}
	public void setArticleNO(int articleNO) {
		this.articleNO = articleNO;
	}
	public String getN_name() {
		return n_name;
	}
	public void setN_name(String n_name) {
		this.n_name = n_name;
	}
	public int getStar() {
		return star;
	}
	public void setStar(int star) {
		this.star = star;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWritedate() {
		return writedate;
	}
	public void setWritedate(String writedate) {
		this.writedate = writedate;
	}
	public MemberVO getMemberVO() {
		return memberVO;
	}
	public void setMemberVO(MemberVO memberVO) {
		this.memberVO = memberVO;
	}
	public ArticleVO getArticleVO() {
		return articleVO;
	}
	public void setArticleVO(ArticleVO articleVO) {
		this.articleVO = articleVO;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public int getOrderNO() {
		return orderNO;
	}
	public void setOrderNO(int orderNO) {
		this.orderNO = orderNO;
	}
}