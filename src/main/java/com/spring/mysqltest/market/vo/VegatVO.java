package com.spring.mysqltest.market.vo;

public class VegatVO {
	int NO;
	String name;
	String foodCategory;
	double cal;
	double protein;
	double fat;
	double carbon;
	double totalSugar;
	double k;
	double na;
	
	public VegatVO() {
		
	}
	public VegatVO(int NO, String name, String foodCategory, double cal, double fat, double carbon, double totalSugar, double k, double na) {
		this.NO=NO;
		this.name=name;
		this.foodCategory=foodCategory;
		this.cal=cal;
		this.fat=fat;
		this.carbon=carbon;
		this.totalSugar=totalSugar;
		this.k=k;
		this.na=na;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public double getCal() {
		return cal;
	}
	public void setCal(double cal) {
		this.cal = cal;
	}
	public int getNO() {
		return NO;
	}
	public void setNO(int nO) {
		NO = nO;
	}
	public String getFoodCategory() {
		return foodCategory;
	}
	public void setFoodCategory(String foodCategory) {
		this.foodCategory = foodCategory;
	}
	public double getProtein() {
		return protein;
	}
	public void setProtein(double protein) {
		this.protein = protein;
	}
	public double getFat() {
		return fat;
	}
	public void setFat(double fat) {
		this.fat = fat;
	}
	public double getCarbon() {
		return carbon;
	}
	public void setCarbon(double carbon) {
		this.carbon = carbon;
	}
	public double getTotalSugar() {
		return totalSugar;
	}
	public void setTotalSugar(double totalSugar) {
		this.totalSugar = totalSugar;
	}
	public double getK() {
		return k;
	}
	public void setK(double k) {
		this.k = k;
	}
	public double getNa() {
		return na;
	}
	public void setNa(double na) {
		this.na = na;
	}
}