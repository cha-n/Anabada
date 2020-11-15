package com.spring.mysqltest.board.form;

import org.springframework.stereotype.Component;

import com.spring.mysqltest.member.vo.MemberVO;

@Component("commentVO")
public class CommentVO {
	private int comment_NO;
	private int parent_NO;
	private int post_NO;
	private String n_name;
	private String content;
	private int seq;
	private char secret;
	private String re_name;
	private String writedate;
	private MemberVO memberVO;
	
	public CommentVO() {
		
	}
	public CommentVO(int comment_NO,int parent_NO,int post_NO,String n_name,String content) {
		this.comment_NO=comment_NO;
		this.parent_NO=parent_NO;
		this.post_NO=post_NO;
		this.n_name=n_name;
		this.content=content;
	} 
	
	public int getComment_NO() {
		return comment_NO;
	}
	public void setComment_NO(int comment_NO) {
		this.comment_NO = comment_NO;
	}
	public int getParent_NO() {
		return parent_NO;
	}
	public void setParent_NO(int parent_NO) {
		this.parent_NO = parent_NO;
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
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public char getSecret() {
		return secret;
	}
	public void setSecret(char secret) {
		this.secret = secret;
	}
	public String getRe_name() {
		return re_name;
	}
	public void setRe_name(String re_name) {
		this.re_name = re_name;
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
}