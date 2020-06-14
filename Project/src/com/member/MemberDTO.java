package com.member;

import java.sql.Timestamp;

public class MemberDTO {
	
	private String id;
	private String pass;
	private String name;
	
	private String postcode;
	private String addr1;
	private String addr2;
	private String addr3;
	
	private String fulladd;
	
	private String mobile1;
	private String mobile2;
	private String mobile3;
	
	private String fullphone;

	private String email;
	
	private Timestamp reg_date;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPass() {
		return pass;
	}

	public void setPass(String pass) {
		this.pass = pass;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPostcode() {
		return postcode;
	}

	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}

	public String getAddr1() {
		return addr1;
	}

	public void setAddr1(String addr1) {
		this.addr1 = addr1;
	}

	public String getAddr2() {
		return addr2;
	}

	public void setAddr2(String addr2) {
		this.addr2 = addr2;
	}

	public String getAddr3() {
		return addr3;
	}

	public void setAddr3(String addr3) {
		this.addr3 = addr3;
	}

	public String getMobile1() {
		return mobile1;
	}

	public void setMobile1(String mobile1) {
		this.mobile1 = mobile1;
	}

	public String getMobile2() {
		return mobile2;
	}

	public void setMobile2(String mobile2) {
		this.mobile2 = mobile2;
	}

	public String getMobile3() {
		return mobile3;
	}

	public void setMobile3(String mobile3) {
		this.mobile3 = mobile3;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Timestamp getReg_date() {
		return reg_date;
	}

	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}

	public String getFulladd() {
		return fulladd;
	}

	public void setFulladd(String fulladd) {
		this.fulladd = fulladd;
	}

	public String getFullphone() {
		return fullphone;
	}

	public void setFullphone(String fullphone) {
		this.fullphone = fullphone;
	}

	@Override
	public String toString() {
		return "MemberDTO [id=" + id + ", pass=" + pass + ", name=" + name + ", postcode=" + postcode + ", addr1="
				+ addr1 + ", addr2=" + addr2 + ", addr3=" + addr3 + ", fulladd=" + fulladd + ", mobile1=" + mobile1
				+ ", mobile2=" + mobile2 + ", mobile3=" + mobile3 + ", fullphone=" + fullphone + ", email=" + email
				+ ", reg_date=" + reg_date + "]";
	}
	
	

}
