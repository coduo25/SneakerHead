package com.board;

import java.sql.Date;

public class BoardDTO {
	
	private int num;			//�� ��ȣ
	private String board_type; 	//�� ����
	private String subject;		//���� ����
	private String content;		//���� ����
	private String member_id;	//�۾���
	private int readcount;		//���� ��ȸ��
	private int re_ref;			//���� �׷캰 ��ȣ
	private int re_lev;			//
	private int re_seq;			//��� �׷캰 ��ȣ
	private Date date;			//�� �ۼ��� ��¥
	private String ip;			//�� �ۼ��� ip�ּ�
	private String file;		//�ۿ� ���ε��� ����
	private int likecount;		//�ۿ� ���ƿ� ���� ����
	private String like_member;	//�ۿ� ���ƿ� ���� �����
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getBoard_type() {
		return board_type;
	}
	public void setBoard_type(String board_type) {
		this.board_type = board_type;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public int getReadcount() {
		return readcount;
	}
	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}
	public int getRe_ref() {
		return re_ref;
	}
	public void setRe_ref(int re_ref) {
		this.re_ref = re_ref;
	}
	public int getRe_lev() {
		return re_lev;
	}
	public void setRe_lev(int re_lev) {
		this.re_lev = re_lev;
	}
	public int getRe_seq() {
		return re_seq;
	}
	public void setRe_seq(int re_seq) {
		this.re_seq = re_seq;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public String getFile() {
		return file;
	}
	public void setFile(String file) {
		this.file = file;
	}
	public int getLikecount() {
		return likecount;
	}
	public void setLikecount(int likecount) {
		this.likecount = likecount;
	}
	public String getLike_member() {
		return like_member;
	}
	public void setLike_member(String like_member) {
		this.like_member = like_member;
	}
	
	@Override
	public String toString() {
		return "BoardDTO [num=" + num + ", board_type=" + board_type + ", subject=" + subject + ", content=" + content
				+ ", member_id=" + member_id + ", readcount=" + readcount + ", re_ref=" + re_ref + ", re_lev=" + re_lev
				+ ", re_seq=" + re_seq + ", date=" + date + ", ip=" + ip + ", file=" + file + ", likecount=" + likecount
				+ ", like_member=" + like_member + "]";
	}
	
}
