package com.sneaker;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class SneakerDAO {

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

	
	//신발 기본정보 및 이미지 저장하는 함수
	public int insertSneaker(String brand, String sub_brand, String brand_index, String fileName, String fileRealName, String model_stylecode, String model_name, String model_colorway, String original_price, String market_price) {
		
		int check = 0;
//		System.out.println("파일이름: " + fileName + ", " + fileRealName);
//		System.out.println("자른 파일이름: " + fileName.replaceAll(".jpg", ""));
//		fileName = fileName.replaceAll(".jpg", "");
		try {
			//DB 연결
			con = getConn();
			//sql 구문
			sql = "insert into sneaker_library (brand, sub_brand, brand_index, sneaker_image, sneaker_realimage, model_stylecode, model_name, model_colorway, original_price, market_price) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, brand);
			pstmt.setString(2, sub_brand);
			pstmt.setString(3, brand_index);
			pstmt.setString(4, fileName);
			pstmt.setString(5, fileRealName);
			pstmt.setString(6, model_stylecode);
			pstmt.setString(7, model_name);
			pstmt.setString(8, model_colorway);
			pstmt.setString(9, original_price);
			pstmt.setString(10, market_price);
			
			pstmt.executeUpdate();
				
			check = 1;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			System.out.println("신발 파일 추가 함수 오류!");
		} finally {
			closeDB();
		}
		return check;
	}
	
	
	//신발 찾기 함수
	public List<SneakerDTO> searchSneaker(String model_name) {
		
		List<SneakerDTO> sneakerList = new ArrayList<SneakerDTO>();
		
		try {
			//DB연결
			con = getConn();
			
			if(model_name.equals("")) {
				//sql 구문 작성
				sql = "select * from sneaker_library where model_name like ?"; 
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, model_name);
				
				rs = pstmt.executeQuery();
				
				//만약 검색한 이름이 있다면 
				while(rs.next()) {
					
					SneakerDTO sdto = new SneakerDTO();
					sdto.setBrand(null);
					//sdto.setBrand(rs.getString("brand"));
					sdto.setSub_brand(rs.getString("sub_brand"));
					sdto.setBrand_index(rs.getString("brand_index"));
					sdto.setSneaker_image(rs.getString("sneaker_image"));
					sdto.setModel_stylecode(rs.getString("model_stylecode"));
					sdto.setModel_name(rs.getString("model_name"));
					sdto.setModel_colorway(rs.getString("model_colorway"));
					sdto.setOriginal_price(rs.getInt("original_price"));
					sdto.setMarket_price(rs.getInt("market_price"));

					sneakerList.add(sdto);
					
					System.out.println("- DB에 저장된 데이터 값들 : " + sneakerList.toString());
				}
			} else {
				//sql 구문 작성
				sql = "select * from sneaker_library where model_name like ?"; 
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + model_name + "%");
				
				rs = pstmt.executeQuery();
				
				//만약 검색한 이름이 있다면 
				while(rs.next()) {
					
					SneakerDTO sdto = new SneakerDTO();
					
					sdto.setBrand(rs.getString("brand"));
					sdto.setSub_brand(rs.getString("sub_brand"));
					sdto.setBrand_index(rs.getString("brand_index"));
					sdto.setSneaker_image(rs.getString("sneaker_image"));
					sdto.setModel_stylecode(rs.getString("model_stylecode"));
					sdto.setModel_name(rs.getString("model_name"));
					sdto.setModel_colorway(rs.getString("model_colorway"));
					sdto.setOriginal_price(rs.getInt("original_price"));
					sdto.setMarket_price(rs.getInt("market_price"));

					sneakerList.add(sdto);
					
					System.out.println("- DB에 저장된 데이터 값들 : " + sneakerList.toString());
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally { 
			closeDB();
		}
		return sneakerList;
	}
	
//	//신발 찾기 함수
//		public SneakerDTO searchSneaker(String model_name) {
//			
//			SneakerDTO sdto = new SneakerDTO();
//			
//			try {
//				//DB연결
//				con = getConn();
//				System.out.println("try구문은 들어온다.");
//				
//				//sql 구문 작성
//				sql = "select * from sneaker_library where model_name like ?"; 
//				pstmt = con.prepareStatement(sql);
//				pstmt.setString(1, "%" + model_name + "%");
//				
//				rs = pstmt.executeQuery();
//				
//				//만약 검색한 이름이 있다면 
//				while(rs.next()) {
//					
//					System.out.println("- DB에 저장된 데이터 값들 : " + sdto.toString());
//					
//					sdto.setBrand(rs.getString("brand"));
//					sdto.setSub_brand(rs.getString("sub_brand"));
//					sdto.setBrand_index(rs.getString("brand_index"));
//					sdto.setSneaker_image(rs.getString("sneaker_image"));
//					sdto.setModel_stylecode(rs.getString("model_stylecode"));
//					sdto.setModel_name(rs.getString("model_name"));
//					sdto.setModel_colorway(rs.getString("model_colorway"));
//					sdto.setOriginal_price(rs.getInt("original_price"));
//					sdto.setMarket_price(rs.getInt("market_price"));
//
//				}
//			} catch (SQLException e) {
//				e.printStackTrace();
//			} finally { 
//				closeDB();
//			}
//			return sdto;
//		}

}
