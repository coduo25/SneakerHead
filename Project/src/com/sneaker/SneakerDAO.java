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

	// DB���� ���۷��� ����
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "";

	// ����̹� �ε� & ��񿬰� (Ŀ�ؼ� Ǯ)
	private Connection getConn() {
		try {
			// Context ��ü ����
			Context init = new InitialContext();
			DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/sneakerDB");
			con = ds.getConnection();
			System.out.println(" ����̹� �ε� & ��� ���� ����!! ");
		} catch (Exception e) {
			System.out.println(" ����̹� & ��� ������ ����!! ");
			e.printStackTrace();
		}
		return con;
	}

	// �ڿ����� ó�� �޼���
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

	
	//�Ź� �⺻���� �� �̹��� �����ϴ� �Լ�
	public int insertSneaker(String brand, String sub_brand, String brand_index, String fileName, String fileRealName, String model_stylecode, String model_name, String model_colorway, String original_price, String market_price) {
		
		int check = 0;
//		System.out.println("�����̸�: " + fileName + ", " + fileRealName);
//		System.out.println("�ڸ� �����̸�: " + fileName.replaceAll(".jpg", ""));
//		fileName = fileName.replaceAll(".jpg", "");
		try {
			//DB ����
			con = getConn();
			//sql ����
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
			System.out.println("�Ź� ���� �߰� �Լ� ����!");
		} finally {
			closeDB();
		}
		return check;
	}
	
	
	//�Ź� ã�� �Լ�
	public List<SneakerDTO> searchSneaker(String model_name) {
		
		List<SneakerDTO> sneakerList = new ArrayList<SneakerDTO>();
		
		try {
			//DB����
			con = getConn();
			
			if(model_name.equals("")) {
				//sql ���� �ۼ�
				sql = "select * from sneaker_library where model_name like ?"; 
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, model_name);
				
				rs = pstmt.executeQuery();
				
				//���� �˻��� �̸��� �ִٸ� 
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
					
					System.out.println("- DB�� ����� ������ ���� : " + sneakerList.toString());
				}
			} else {
				//sql ���� �ۼ�
				sql = "select * from sneaker_library where model_name like ?"; 
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + model_name + "%");
				
				rs = pstmt.executeQuery();
				
				//���� �˻��� �̸��� �ִٸ� 
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
					
					System.out.println("- DB�� ����� ������ ���� : " + sneakerList.toString());
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally { 
			closeDB();
		}
		return sneakerList;
	}
	
//	//�Ź� ã�� �Լ�
//		public SneakerDTO searchSneaker(String model_name) {
//			
//			SneakerDTO sdto = new SneakerDTO();
//			
//			try {
//				//DB����
//				con = getConn();
//				System.out.println("try������ ���´�.");
//				
//				//sql ���� �ۼ�
//				sql = "select * from sneaker_library where model_name like ?"; 
//				pstmt = con.prepareStatement(sql);
//				pstmt.setString(1, "%" + model_name + "%");
//				
//				rs = pstmt.executeQuery();
//				
//				//���� �˻��� �̸��� �ִٸ� 
//				while(rs.next()) {
//					
//					System.out.println("- DB�� ����� ������ ���� : " + sdto.toString());
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
