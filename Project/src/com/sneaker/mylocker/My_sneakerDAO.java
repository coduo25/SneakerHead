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
	
	//�Ź��� DB���� ������ ������ ���� �Լ�
	public ArrayList<My_sneakerDTO> getListMySneaker(String id) {
		
		ArrayList<My_sneakerDTO> sneakerList = new ArrayList<My_sneakerDTO>();
		
		try {
			//DB ����
			con = getConn();
			//sql ����
			sql = "select sneaker_image, model_name, my_size, my_condition, my_price, market_price, my_purchasing_route, my_status from my_locker where member_id = ?";
			pstmt = con.prepareStatement(sql);
			//System.out.println("id���� " + id);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			//�Ź���DB�� �α����� ���̵� ������
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
				
				System.out.println("(�Ź��� ��񿡼� ������� ���� : " + msdto + ")");
				
				sneakerList.add(msdto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return sneakerList;
	} //endListMySneaker
	
	//�Ź� �߰��ϴ� �Լ�
	public void insertSneaker(My_sneakerDTO mydto) {
		try {
			//DB ����
			con = getConn();			
			//System.out.println("try�������� ���´�.");
			//sql ����
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
			System.out.println("�Ź��忡 �߰��Ͽ����ϴ�!");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
	}
	
	//���̵� ���� member_id ������ ��� �� ����Ŀ�� � ������ �ִ��� ���ϴ� �Լ�
	public int countOf(String member_id) {
		int result = 0;
		try {
			//DB����
			con = getConn();
			//sql ���� �ۼ�
			sql = "select * from my_locker where member_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, member_id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				//sql ���� �ۼ�
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
	
	//���̵� ���� my_price �� �׼� ���ϴ� �Լ�
	public int sumOfmy_p(String member_id) {
		int result = 0;
		try {
			//DB����
			con = getConn();
			//sql ���� �ۼ�
			sql = "select * from my_locker where member_id = ?";	
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, member_id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				//sql ���� �ۼ�
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
	
	//���̵� ���� market_price �� �׼� ���ϴ� �Լ�
	public int sumOfmarket_p(String member_id) {
		int result = 0;
		try {
			//DB����
			con = getConn();
			//sql ���� �ۼ�
			sql = "select * from my_locker where member_id = ?";	
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, member_id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				//sql ���� �ۼ�
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

