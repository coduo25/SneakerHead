package com.sneaker.mylocker;

import java.sql.Timestamp;

public class My_sneakerDTO {

	// SneakerDB에서 가져와야 하는 정보들
	private String member_id;

	private String brand;
	private String sub_brand;
	private String brand_index;
	private String sneaker_image;
	private String model_stylecode;
	private String model_name;
	private String model_colorway;
	private int original_price;
	private int market_price;

	// 내가 입력하는 정보들
	private int my_size;
	private int my_price;
	private String my_condition;
	private String my_usedRate;
	private String my_purchasing_route;
	private String my_status;
	private String my_future_status;

	
	public String getSneaker_image() {
		return sneaker_image;
	}

	public void setSneaker_image(String sneaker_image) {
		this.sneaker_image = sneaker_image;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public String getBrand() {
		return brand;
	}

	public void setBrand(String brand) {
		this.brand = brand;
	}

	public String getSub_brand() {
		return sub_brand;
	}

	public void setSub_brand(String sub_brand) {
		this.sub_brand = sub_brand;
	}

	public String getBrand_index() {
		return brand_index;
	}

	public void setBrand_index(String brand_index) {
		this.brand_index = brand_index;
	}

	public String getModel_stylecode() {
		return model_stylecode;
	}

	public void setModel_stylecode(String model_stylecode) {
		this.model_stylecode = model_stylecode;
	}

	public String getModel_name() {
		return model_name;
	}

	public void setModel_name(String model_name) {
		this.model_name = model_name;
	}

	public String getModel_colorway() {
		return model_colorway;
	}

	public void setModel_colorway(String model_colorway) {
		this.model_colorway = model_colorway;
	}

	public int getOriginal_price() {
		return original_price;
	}

	public void setOriginal_price(int original_price) {
		this.original_price = original_price;
	}

	public int getMarket_price() {
		return market_price;
	}

	public void setMarket_price(int market_price) {
		this.market_price = market_price;
	}

	public int getMy_size() {
		return my_size;
	}

	public void setMy_size(int my_size) {
		this.my_size = my_size;
	}

	public int getMy_price() {
		return my_price;
	}

	public void setMy_price(int my_price) {
		this.my_price = my_price;
	}

	public String getMy_condition() {
		return my_condition;
	}

	public void setMy_condition(String my_condition) {
		this.my_condition = my_condition;
	}

	public String getMy_usedRate() {
		return my_usedRate;
	}

	public void setMy_usedRate(String my_usedRate) {
		this.my_usedRate = my_usedRate;
	}

	public String getMy_purchasing_route() {
		return my_purchasing_route;
	}

	public void setMy_purchasing_route(String my_purchasing_route) {
		this.my_purchasing_route = my_purchasing_route;
	}

	public String getMy_status() {
		return my_status;
	}

	public void setMy_status(String my_status) {
		this.my_status = my_status;
	}

	public String getMy_future_status() {
		return my_future_status;
	}

	public void setMy_future_status(String my_future_status) {
		this.my_future_status = my_future_status;
	}

	@Override
	public String toString() {
		return "My_sneakerDTO [member_id=" + member_id + ", brand=" + brand + ", sub_brand=" + sub_brand
				+ ", brand_index=" + brand_index + ", sneaker_image=" + sneaker_image + ", model_stylecode="
				+ model_stylecode + ", model_name=" + model_name + ", model_colorway=" + model_colorway
				+ ", original_price=" + original_price + ", market_price="
				+ market_price + ", my_size=" + my_size + ", my_price=" + my_price + ", my_condition=" + my_condition
				+ ", my_usedRate=" + my_usedRate + ", my_purchasing_route=" + my_purchasing_route + ", my_status="
				+ my_status + ", my_future_status=" + my_future_status + "]";
	}

	
	
}
