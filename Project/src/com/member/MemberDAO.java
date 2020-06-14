package com.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberDAO {
	
	//데이터 처리 객체
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "";
	
	// 드라이버 로드 & 디비연결 (커넥션 풀)
	private Connection getConn() {
		try {
			// Context 객체 생성
			Context init = new InitialContext();
			DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/sneakerDB");
			con = ds.getConnection();
			//System.out.println(" 드라이버 로드 & 디비 연결 성공!! ");
		} catch (Exception e) {
			//System.out.println(" 드라이버 & 디비 연결이 에러!! ");
		e.printStackTrace();
		}
		return con;
	}
	
	// 자원해제 처리 메서드
	public void closeDB() {
		try {
			if (rs != null)
				rs.close();
			if (pstmt != null)
				pstmt.close();
			if (con != null)
				con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
/********************************************************************************************************
 * 회원관리 관련 함수
 *******************************************************************************************************/
	
	//회원 전체 리스트 가져오는 함수
	public List<MemberDTO> getAllMember() {
		List<MemberDTO> memberList = new ArrayList<MemberDTO>();
		
		try {
			con = getConn();
			//sql
			sql = "select * from member";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				MemberDTO mdto = new MemberDTO();
				//DB에 정보를 memberdto 객체에저장
				mdto.setId(rs.getString("id"));
				mdto.setPass(rs.getString("pass"));
				mdto.setName(rs.getString("name"));
				mdto.setFulladd(rs.getString("fulladd"));
				mdto.setFullphone(rs.getString("fullphone"));
				mdto.setEmail(rs.getString("email"));
				mdto.setReg_date(rs.getTimestamp("reg_date"));
				
				memberList.add(mdto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return memberList;
	}
	
	
/********************************************************************************************************
 * 회원가입 부분
 *******************************************************************************************************/
	
	//Id 중복체크 함수
	public boolean idDoubleCheck(String member_id){
		boolean check = false;
		try {
			con = getConn();
			sql = "select id from member where id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, member_id);
			
			rs = pstmt.executeQuery();
			
			//DB안에 해당 아이디가 존재하면
			if(rs.next()){
				if(member_id.equals(rs.getString("id"))) {
					//System.out.println("아이디가 이미 존재합니다.");
					check = true;
				}
			}
			//DB안에 해당 아이디가 존재하지 않으면
			else {
				//System.out.println("아이디가 존재하지 않습니다.");
				check = false;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return check;
	}
	
	//email 중복체크 함수
	public boolean emailDoubleCheck(String email){
		boolean check = false;
		try {
			con = getConn();
			sql = "select email from member where email = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, email);
			
			rs = pstmt.executeQuery();
			
			//DB안에 해당 아이디가 존재하면
			if(rs.next()){
				if(email.equals(rs.getString("email"))) {
					//System.out.println("이메일이 이미 존재합니다.");
					check = true;
				}
			}
			//DB안에 해당 아이디가 존재하지 않으면
			else {
				//System.out.println("이메일이 존재하지 않습니다.");
				check = false;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return check;
	}
	
	//Member DB에 새로운 회원 추가하기 함수
	public void insertMember(MemberDTO mdto) {
		try {
			con = getConn();
			//sql 구문 작성
			sql = "insert into member(id, pass, name, fulladd, fullphone, email, reg_date, postcode, addr1, addr2, addr3, mobile1, mobile2, mobile3) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, mdto.getId());
			pstmt.setString(2, mdto.getPass());
			pstmt.setString(3, mdto.getName());
			pstmt.setString(4, mdto.getFulladd());
			pstmt.setString(5, mdto.getFullphone());
			pstmt.setString(6, mdto.getEmail());
			pstmt.setTimestamp(7, mdto.getReg_date());
			pstmt.setString(8, mdto.getPostcode());
			pstmt.setString(9, mdto.getAddr1());
			pstmt.setString(10, mdto.getAddr2());
			pstmt.setString(11, mdto.getAddr3());
			pstmt.setString(12, mdto.getMobile1());
			pstmt.setString(13, mdto.getMobile2());
			pstmt.setString(14, mdto.getMobile3());
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
	}

	
/********************************************************************************************************
 * 로그인
 *******************************************************************************************************/
	
	//idcheck()
	public int idCheck(String id, String pw) {
		int check = 0;
		
		//DB연결
		con = getConn();
		
		//System.out.println("id는 " + id + ", pw는" + pw);
		
		try {
			//DB안에 아이디가 존재하는가
			sql = "select pass from member where id =?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				//비밀번호가 같으면
				if(pw.equals(rs.getString("pass"))) {
					check = 1;
				}
				//비밀번호가 다르면
				else {
					check = 0;
				}
			}
			else {
				check = -1;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return check;
	}//end of idcheck()


/********************************************************************************************************
 * 회원 수정란
 *******************************************************************************************************/
	//회원 정보 가지고 오는 함수
	public MemberDTO getMemberInfo(String member_id) {
		MemberDTO mdto = null;
		
		try {
			con = getConn();
			sql = "select * from member where id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, member_id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				mdto = new MemberDTO();
				
				mdto.setId(rs.getString("id"));
				mdto.setName(rs.getString("name"));
				mdto.setEmail(rs.getString("email"));
				mdto.setPostcode(rs.getString("postcode"));
				mdto.setAddr1(rs.getString("addr1"));
				mdto.setAddr2(rs.getString("addr2"));
				mdto.setAddr3(rs.getString("addr3"));
				mdto.setMobile1(rs.getString("mobile1"));
				mdto.setMobile2(rs.getString("mobile2"));
				mdto.setMobile3(rs.getString("mobile3"));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return mdto;
	}
	
	public void updateMember(MemberDTO mdto) {
		try {
			con = getConn();
			
			sql = "update member set pass=?, name=?, fulladd=?, fullphone=?, email=?, reg_date=?, postcode=?, addr1=?, addr2=?, addr3=?, mobile1=?, mobile2=?, mobile3=? where id=?";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, mdto.getPass());
			pstmt.setString(2, mdto.getName());
			pstmt.setString(3, mdto.getFulladd());
			pstmt.setString(4, mdto.getFullphone());
			pstmt.setString(5, mdto.getEmail());
			pstmt.setTimestamp(6, mdto.getReg_date());
			pstmt.setString(7, mdto.getPostcode());
			pstmt.setString(8, mdto.getAddr1());
			pstmt.setString(9, mdto.getAddr2());
			pstmt.setString(10, mdto.getAddr3());
			pstmt.setString(11, mdto.getMobile1());
			pstmt.setString(12, mdto.getMobile2());
			pstmt.setString(13, mdto.getMobile3());
			pstmt.setString(14, mdto.getId());
			
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			closeDB();
		}
	}

/********************************************************************************************************
 * 수정 & 회원탈퇴
 *******************************************************************************************************/
	
	//회원 비밀번호 체크 함수
	public int checkMemberPW(String member_id, String pass) {
		int check = 0;
		try {
			con = getConn();
			sql = "select pass from member where id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, member_id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				if(pass.equals(rs.getString("pass"))) {
					check = 1;
				} else {
					check = 0;
				}
			}else {
				check = -1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return check;
	}
	
	//회원 삭제 함수
	public int deleteMember(String id, String pass) {
		int check = 0;
		try {
			con = getConn();
			sql = "select pass from member where id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				//아이디가 있으면
				if(pass.equals(rs.getString("pass"))) {
					
					sql = "delete from member where id=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, id);
					
					check = pstmt.executeUpdate();
				} else {
					//비밀번호 오류
					check = 0;
				}
			} else {
				check = -1;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return check;
	}

}



































