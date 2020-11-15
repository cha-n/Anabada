package com.spring.mysqltest.member.vo;

import org.springframework.stereotype.Component;

import com.spring.mysqltest.board.form.CommonForm;

@Component("memberVO")
public class MemberVO extends CommonForm{
	private String id;
	private String n_name;
	private String pwd;
	private String address;
	private String profile;
	private String name;
	
	public MemberVO() {
		
	}
	public MemberVO(String id,String n_name,String pwd,String address) {
		this.id=id;
		this.n_name=n_name;
		this.pwd=pwd;
		this.address=address;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getN_name() {
		return n_name;
	}
	public void setN_name(String n_name) {
		this.n_name = n_name;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getProfile() {
		return profile;
	}
	public void setProfile(String profile) {
		this.profile = profile;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
}