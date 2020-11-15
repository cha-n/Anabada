package com.spring.mysqltest.order.vo;

import java.util.Date;

import org.springframework.stereotype.Component;

import com.spring.mysqltest.seller.vo.ArticleVO;
import com.spring.mysqltest.seller.vo.ImageVO;

@Component("orderVO")
public class OrderVO {
	private int orderNO;
	private int orderNO_;
	private int articleNO;
	private String n_name;
	private int quantity;
	private int price;
	private String phoneNum;
	private String address;
	private String addressDetail;
	private String msg;
	private String pay_method;
	private String depositName;
	private String bank;
	private Date orderDate;
	private ArticleVO articleVO;
	private ImageVO imageVO;
	private String title;
	private String imageFileName;
	private String review_chk;
	
	public int getOrderNO() {
		return orderNO;
	}
	public void setOrderNO(int orderNO) {
		this.orderNO = orderNO;
	}
	public int getOrderNO_() {
		return orderNO_;
	}
	public void setOrderNO_(int orderNO_) {
		this.orderNO_ = orderNO_;
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
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getPhoneNum() {
		return phoneNum;
	}
	public void setPhoneNum(String phoneNum) {
		this.phoneNum = phoneNum;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getAddressDetail() {
		return addressDetail;
	}
	public void setAddressDetail(String addressDetail) {
		this.addressDetail = addressDetail;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public String getPay_method() {
		return pay_method;
	}
	public void setPay_method(String pay_method) {
		this.pay_method = pay_method;
	}
	public String getDepositName() {
		return depositName;
	}
	public void setDepositName(String depositName) {
		this.depositName = depositName;
	}
	public String getBank() {
		return bank;
	}
	public void setBank(String bank) {
		this.bank = bank;
	}
	public Date getOrderDate() {
		return orderDate;
	}
	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}
	public ArticleVO getArticleVO() {
		return articleVO;
	}
	public void setArticleVO(ArticleVO articleVO) {
		this.articleVO = articleVO;
	}
	public ImageVO getImageVO() {
		return imageVO;
	}
	public void setImageVO(ImageVO imageVO) {
		this.imageVO = imageVO;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getImageFileName() {
		return imageFileName;
	}
	public void setImageFileName(String imageFileName) {
		this.imageFileName = imageFileName;
	}
	public String getReview_chk() {
		return review_chk;
	}
	public void setReview_chk(String review_chk) {
		this.review_chk = review_chk;
	}
}