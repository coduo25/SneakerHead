package com.sneaker.mylocker;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class My_sneakerDAO {

	// DB관련 레퍼런스 선언
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
			System.out.println(" 드라이버 로드 & 디비 연결 성공!! ");
		} catch (Exception e) {
			System.out.println(" 드라이버 & 디비 연결이 에러!! ");
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
	
	//신발장 DB에서 데이터 가지고 오는 함수
	public ArrayList<My_sneakerDTO> getListMySneaker(String id) {
		
		ArrayList<My_sneakerDTO> sneakerList = new ArrayList<My_sneakerDTO>();
		
		try {
			//DB 연결
			con = getConn();
			//sql 구문
			sql = "select sneaker_image, model_name, my_size, my_condition, my_price, market_price, my_purchasing_route, my_status from my_locker where member_id = ?";
			pstmt = con.prepareStatement(sql);
			//System.out.println("id값은 " + id);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			//신발장DB에 로그인한 아이디가 있으면
			while(rs.next()){
				My_sneakerDTO msdto = new My_sneakerDTO();
				
				msdto.setSneaker_image(rs.getString("sneaker_image"));
				msdto.setModel_name(rs.getString("model_name"));
				msdto.setMy_size(rs.getInt("my_size"));
				msdto.setMy_condition(rs.getString("my_condition"));
				msdto.setMy_price(rs.getInt("my_price"));
				msdto.setMarket_price(rs.getInt("market_price"));
				msdto.setMy_purchasing_route(rs.getString("my_purchasing_route"));
				msdto.setMy_status(rs.getString("my_status"));
				
				System.out.println("(신발장 디비에서 가지고온 정보 : " + msdto + ")");
				
				sneakerList.add(msdto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return sneakerList;
	} //endListMySneaker
	
	//신발 추가하는 함수
	public void insertSneaker(My_sneakerDTO mydto) {
		try {
			//DB 연결
			con = getConn();			
			//System.out.println("try구문으로 들어온다.");
			//sql 구문
			sql = "insert into my_locker(member_id, sneaker_image, brand, sub_brand, brand_index, model_name, model_stylecode, original_price, market_price, model_color, my_size, my_price, my_condition, my_usedRate, my_purchasing_route, my_status, my_future_status) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";	
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, mydto.getMember_id());
			
			pstmt.setString(2, mydto.getSneaker_image());	
			pstmt.setString(3, mydto.getBrand());
			pstmt.setString(4, mydto.getSub_brand());
			pstmt.setString(5, mydto.getBrand_index());
			pstmt.setString(6, mydto.getModel_name());
			pstmt.setString(7, mydto.getModel_stylecode());
			pstmt.setInt(8, mydto.getOriginal_price());
			pstmt.setInt(9, mydto.getMarket_price());
			pstmt.setString(10, mydto.getModel_colorway());
	
			pstmt.setInt(11, mydto.getMy_size());
			pstmt.setInt(12, mydto.getMy_price());
			pstmt.setString(13, mydto.getMy_condition());
			pstmt.setString(14, mydto.getMy_usedRate());
			pstmt.setString(15, mydto.getMy_purchasing_route());
			pstmt.setString(16, mydto.getMy_status());
			pstmt.setString(17, mydto.getMy_future_status());

			pstmt.executeUpdate();
			System.out.println("신발장에 추가하였습니다!");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
	}
	
	//아이디에 따른 member_id 갯수를 세어서 총 스니커를 몇개 가지고 있는지 구하는 함수
	public int countOf(String member_id) {
		int result = 0;
		try {
			//DB연결
			con = getConn();
			//sql 구문 작성
			sql = "select * from my_locker where member_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, member_id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				//sql 구문 작성
				sql = "select count(member_id) from sneakerhead.my_locker where member_id = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, member_id);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					result = rs.getInt(1);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return result;
	}
	
	//아이디에 따른 my_price 총 액수 구하는 함수
	public int sumOfmy_p(String member_id) {
		int result = 0;
		try {
			//DB연결
			con = getConn();
			//sql 구문 작성
			sql = "select * from my_locker where member_id = ?";	
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, member_id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				//sql 구문 작성
				sql = "select sum(my_price) from my_locker where member_id= ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, member_id);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					result = rs.getInt(1);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return result;
	}
	
	//아이디에 따른 market_price 총 액수 구하는 함수
	public int sumOfmarket_p(String member_id) {
		int result = 0;
		try {
			//DB연결
			con = getConn();
			//sql 구문 작성
			sql = "select * from my_locker where member_id = ?";	
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, member_id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				//sql 구문 작성
				sql = "select sum(market_price) from my_locker where member_id= ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, member_id);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					result = rs.getInt(1);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return result;
	}
	
	
	
	
	
	
	

}

