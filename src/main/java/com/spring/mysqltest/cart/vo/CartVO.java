package com.spring.mysqltest.cart.vo;

import org.springframework.stereotype.Component;

import com.spring.mysqltest.seller.vo.ArticleVO;
import com.spring.mysqltest.seller.vo.ImageVO;

@Component("cartVO")
public class CartVO {
	private int cart_NO;
	private int articleNO;
	private String n_name;
	private int quantity;
	private ArticleVO articleVO;
	private ImageVO imageVO;
	
	public CartVO() {
	
	}
	public CartVO(int cart_NO, int articleNO, String n_name) {
		this.cart_NO=cart_NO;
		this.articleNO=articleNO;
		this.n_name=n_name;
	}
	public int getCart_NO() {
		return cart_NO;
	}
	public void setCart_NO(int cart_NO) {
		this.cart_NO = cart_NO;
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
}