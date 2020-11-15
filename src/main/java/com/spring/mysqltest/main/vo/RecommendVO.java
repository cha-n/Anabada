package com.spring.mysqltest.main.vo;

import org.springframework.stereotype.Component;

import com.spring.mysqltest.seller.vo.ArticleVO;
import com.spring.mysqltest.seller.vo.ImageVO;

@Component("recommendVO")
public class RecommendVO {
	int recommend_NO;
	int articleNO;
	ArticleVO articleVO;
	ImageVO imageVO;
	
	public RecommendVO() {
		
	}
	public RecommendVO(int recommend_NO, int articleNO) {
		this.recommend_NO=recommend_NO;
		this.articleNO=articleNO;
	}
	public int getRecommend_NO() {
		return recommend_NO;
	}
	public void setRecommend_NO(int recommend_NO) {
		this.recommend_NO = recommend_NO;
	}
	public int getArticleNO() {
		return articleNO;
	}
	public void setArticleNO(int articleNO) {
		this.articleNO = articleNO;
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
