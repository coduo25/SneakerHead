package com.sneaker;

import java.io.File;
import java.sql.Timestamp;

public class SneakerDTO {

	private String sneaker_image;
	private String sneaker_realimage;

	private String brand;
	private String sub_brand;
	private String brand_index;
	private String model_stylecode;
	private String model_name;
	private String model_colorway;
	
	private int original_price;
	private int market_price;
	
	public String getSneaker_image() {
		return sneaker_image;
	}
	public void setSneaker_image(String sneaker_image) {
		this.sneaker_image = sneaker_image;
	}
	public String getSneaker_realimage() {
		return sneaker_realimage;
	}
	
	public void setSneaker_realimage(String sneaker_realimage) {
		this.sneaker_realimage = sneaker_realimage;
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
	
	@Override
	public String toString() {
		return "SneakerDTO [sneaker_image=" + sneaker_image + ", sneaker_realimage=" + sneaker_realimage + ", brand="
				+ brand + ", sub_brand=" + sub_brand + ", brand_index=" + brand_index + ", model_stylecode="
				+ model_stylecode + ", model_name=" + model_name + ", model_colorway=" + model_colorway
				+ ", original_price=" + original_price + ", market_price="
				+ market_price + "]";
	}
	
	

}
