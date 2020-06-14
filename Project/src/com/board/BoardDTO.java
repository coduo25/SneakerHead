package com.board;

import java.sql.Date;

public class BoardDTO {
	
	private int num;			//글 번호
	private String board_type; 	//글 종류
	private String subject;		//글의 제목
	private String content;		//글의 내용
	private String member_id;	//글쓴이
	private int readcount;		//글의 조회수
	private int re_ref;			//글의 그룹별 번호
	private int re_lev;			//
	private int re_seq;			//답글 그룹별 번호
	private Date date;			//글 작성한 날짜
	private String ip;			//글 작성한 ip주소
	private String file;		//글에 업로드한 파일
	private int likecount;		//글에 좋아요 눌린 갯수
	private String like_member;	//글에 좋아요 눌린 멤버들
	
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
