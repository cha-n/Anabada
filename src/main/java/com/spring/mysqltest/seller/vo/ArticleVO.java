package com.spring.mysqltest.seller.vo;

import org.springframework.stereotype.Component;

import com.spring.mysqltest.board.form.CommonForm;

@Component("articleVO")
public class ArticleVO extends CommonForm{
	int articleNO;
	int articleNO_;
	String title;
	String content;
	String imageFileName;
	String writeDate;
	String n_name;
	int accepted;
	String item;
	int hits;
	int price;
	ImageVO imageVO;
	int deleted;

	public int getArticleNO() {
		return articleNO;
	}
	public void setArticleNO(int articleNO) {
		this.articleNO = articleNO;
	}
	public int getArticleNO_() {
		return articleNO_;
	}
	public void setArticleNO_(int articleNO_) {
		this.articleNO_ = articleNO_;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getImageFileName() {
		return imageFileName;
	}
	public void setImageFileName(String imageFileName) {
		this.imageFileName = imageFileName;
	}
	public String getWriteDate() {
		return writeDate;
	}
	public void setWriteDate(String writeDate) {
		this.writeDate = writeDate;
	}
	public String getN_name() {
		return n_name;
	}
	public void setN_name(String n_name) {
		this.n_name = n_name;
	}
	public int getAccepted() {
		return accepted;
	}
	public void setAccepted(int accepted) {
		this.accepted = accepted;
	}
	public String getItem() {
		return item;
	}
	public void setItem(String item) {
		this.item = item;
	}
	public int getHits() {
		return hits;
	}
	public void setHits(int hits) {
		this.hits = hits;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public ImageVO getImageVO() {
		return imageVO;
	}
	public void setImageVO(ImageVO imageVO) {
		this.imageVO = imageVO;
	}
	public int getDeleted() {
		return deleted;
	}
	public void setDeleted(int deleted) {
		this.deleted = deleted;
	}
}
