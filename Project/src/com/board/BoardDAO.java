package com.board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardDAO {
	
	//DB���� reference ����
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
			//System.out.println(" ����̹� �ε� & ��� ���� ����!! ");
		} catch (Exception e) {
			//System.out.println(" ����̹� & ��� ������ ����!! ");
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
	
/* ******************************************************************************************************************** 
/* 	�������� ���̴� �Լ���
 * *******************************************************************************************************************/
	
	//updateReadCount(): ��ȸ�� ���� �Լ� 
	public void updateReadCount(String board_type, int re_ref) {
		//DB ����
		con = getConn();
		try {
			//sql �ۼ�: num �ش��ϴ� �� ������ ��ȸ�� 1 ����
			sql = "update board_all set readcount = readcount + 1 where re_ref = ? AND board_type = ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, re_ref);
			pstmt.setString(2, board_type);
			//����
			pstmt.executeUpdate();	
			System.out.println(" (�� ��ȸ�� 1 ���� ����!) ");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
	}

	//getBoard() : ���� ������ �������� �Լ�
	public BoardDTO getBoardContent(String board_type, int re_ref) {
		BoardDTO bdto = null; //DTO ��ü�� ����
		
		//DB ����
		con = getConn();
		try {
			//sql ���� �ۼ�, select ���� �Ἥ ���� �� ��������
			sql = "select * from board_all where re_ref = ? AND board_type = ?";
		
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, re_ref);
			pstmt.setString(2, board_type);
			
			//����
			rs = pstmt.executeQuery();
			
			if(rs.next()){ //���� �ش� ���� ������
				bdto = new BoardDTO();
				
				//DB�� ������ -> BoardBean ���� ���� 
				bdto.setNum(rs.getInt("num"));
				bdto.setBoard_type(rs.getString("board_type"));
				bdto.setSubject(rs.getString("subject"));
				bdto.setContent(rs.getString("content"));
				bdto.setMember_id(rs.getString("member_id"));
				bdto.setReadcount(rs.getInt("readcount"));
				bdto.setRe_ref(rs.getInt("re_ref"));
				bdto.setRe_lev(rs.getInt("re_lev"));
				bdto.setRe_seq(rs.getInt("re_seq"));
				bdto.setDate(rs.getDate("date"));
				bdto.setIp(rs.getString("ip"));
				bdto.setFile(rs.getString("file"));	
				bdto.setLikecount(rs.getInt("likecount"));
				bdto.setLike_member(rs.getString("like_member"));
				
				//System.out.println("- ���� ��ȸ ���� : " + bdto.toString());
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return bdto;
	} //end of getBoard()
	
	//�ۼ����ϴ� �Լ�
	public int updateBoard(BoardDTO bdto) {
		int check = -1;
		try {
			//DB����
			con = getConn();
			//sql ����
			sql = "select member_id from board_all where board_type = ? AND re_ref = ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bdto.getBoard_type());
			pstmt.setInt(2, bdto.getRe_ref());
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				//�� ����
				if(bdto.getMember_id().equals(rs.getString("member_id"))) {					
					//�����ϰ��� �ϴ� ���� �ۼ��ڰ� �����ϴ� ����̶��
					sql = "update board_all set subject = ?, content = ? where board_type = ? AND re_ref = ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, bdto.getSubject());
					pstmt.setString(2, bdto.getContent());
					pstmt.setString(3, bdto.getBoard_type());
					pstmt.setInt(4, bdto.getRe_ref());
					
					check = pstmt.executeUpdate();
				} else {
					//�����ϰ��� �ϴ� ���� �ۼ��ڰ� �����ϴ� ����� �ƴ϶��
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
	
	
	
/* ******************************************************************************************************************** 
/*	��ü �� �Խ��� ���� �Լ��� 
 * *******************************************************************************************************************/
	
	//getBoardCount(): �� ������ ����ؼ� �������� �Լ� 
	public int getAllBoardCount() {
		int count = 0;
		try {
			//��� ����
			con=getConn();
			
			//sql ����
			sql = "select count(*) from board_all";
			
			//����
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			//ó��
			if(rs.next()) { //�����͸� ������
				count = rs.getInt(1);
			}
			//System.out.println(" (�� ���� ��� �Ϸ�) ");
		} catch (Exception e) {
			System.out.println(" (�� ���� ��� ����) ");
		} finally {
			closeDB();
		}
		return count;
	} //end of getBoardCount()
	
	//getBoardList(): DB�ȿ� ���� �������� �������� �Լ�
	public List<BoardDTO> getBoardList(int startRow, int pageSize) { //�ۿ� ���� ��� ������ �������� ������ list ��ü ����, List<BoardBean> = �� List �ȿ� BoardBean�� ���·θ� ������ �ٴϰڴٶ�� �ǹ�
		
		//Up-casting List��� �������̽��� ��ü�� ���� ���ϱ� �빮�� ArrayList��� ��ü�� �̿��ؼ� Upcasting �Ѵ�. (�ڵ����� ����ȯ�Ѵ�.) ��ĭ��ĭ�� RuBoadDTO ���·� ��������. �׸��� �� ��ĭ�ȿ��� RuBoadDTO�� �����Ͱ� ���ִ�.
		List<BoardDTO> boardList = new ArrayList<BoardDTO>(); 
		//List boardList2 = new ArrayList(); //��ĭ��ĭ�� Object Ÿ������ ���������. <> = generic, �ᵵ������ �������� �� �ȵǼ� ��������� ȣȯ�� ���������� �׷��� ������ ���޼����� ��Ȯ���� �ִ�. <> generic �������� ������ ������ ���̴°� ����. 
		
		try {
			//DB ����
			con = getConn();
			
			// sql 
				// - re_ref: �ֽű� ���� ���� 
				// - re_seq: ��� �׷캰�� ������������ ������ ������������
				// - limit ?, ? : �ʿ��� ������ŭ ©�� ��������
			sql = "select * from board_all order by num DESC, num limit ?, ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, startRow - 1); //������
			pstmt.setInt(2, pageSize);	//��� �����ð��� limit ?, ? = ? ���� ? ���� �����´ٴ� ���� 
			
			//����
			rs = pstmt.executeQuery();
			
			//��
			while(rs.next()) {
				BoardDTO bdto = new BoardDTO();
				//����
				bdto.setNum(rs.getInt("num")); 
				bdto.setBoard_type(rs.getString("board_type"));
				bdto.setSubject(rs.getString("subject"));
				bdto.setContent(rs.getString("content"));
				bdto.setMember_id(rs.getString("member_id"));
				bdto.setReadcount(rs.getInt("readcount"));
				bdto.setRe_ref(rs.getInt("re_ref"));
				bdto.setRe_lev(rs.getInt("re_lev"));
				bdto.setRe_seq(rs.getInt("re_seq"));
				bdto.setDate(rs.getDate("date"));
				bdto.setIp(rs.getString("ip"));
				bdto.setFile(rs.getString("file"));
				bdto.setLikecount(rs.getInt("likecount"));
				bdto.setLike_member(rs.getString("like_member"));

				//boardList ��ĭ�� RuBoardDtO ��ü 1�� ����
				boardList.add(bdto);
				
				//System.out.println("- ���� ��ȸ ���� : " + bdto.toString());
				
			} //while() end
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return boardList;
	}
	
/* ******************************************************************************************************************** 
/*	Ư�� �Խ��� ����(��� �Խ���&�߸� �Խ��� &���� ���) �Լ��� 
 * *******************************************************************************************************************/
	
	//�� ������ ����ؼ� �������� �Լ�
	public int getSpecialBoardCount(String board_type) {
		int count = 0;
		try {
			//��� ����
			getConn();
			
			//sql ����
			sql = "select count(*) from board_all where board_type = ?";
			
			//����
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, board_type);
			rs = pstmt.executeQuery();
			
			//ó��
			if(rs.next()) { //�����͸� ������
				count = rs.getInt(1);
			}
			//System.out.println(" (�� ���� ��� �Ϸ�) ");	
		} catch (Exception e) {
			System.out.println(" (�� ���� ��� ����) ");
		} finally {
			closeDB();
		}
		return count;
	}
	
	//Ư�� �Խ��� ����Ʈ �������� �Լ�
	public List<BoardDTO> getSpecialBoardList(int startRow, int pageSize, String board_type) {
				
		List<BoardDTO> boardList = new ArrayList<BoardDTO>(); 		
		
		try {
			//DB ����
			con = getConn();
			
			// sql 
			sql = "select * from board_all where board_type = ? order by re_ref desc, re_seq limit ?, ? ";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, board_type);
			pstmt.setInt(2, startRow - 1); //������
			pstmt.setInt(3, pageSize);	//��� �����ð��� limit ?, ? = ? ���� ? ���� �����´ٴ� ����
			
			//����
			rs = pstmt.executeQuery();
			
			//��
			while(rs.next()) {
				BoardDTO bdto = new BoardDTO();
				//����
				bdto.setNum(rs.getInt("num")); 
				bdto.setBoard_type(rs.getString("board_type"));
				bdto.setSubject(rs.getString("subject"));
				bdto.setContent(rs.getString("content"));
				bdto.setMember_id(rs.getString("member_id"));
				bdto.setReadcount(rs.getInt("readcount"));
				bdto.setRe_ref(rs.getInt("re_ref"));
				bdto.setRe_lev(rs.getInt("re_lev"));
				bdto.setRe_seq(rs.getInt("re_seq"));
				bdto.setDate(rs.getDate("date"));
				bdto.setIp(rs.getString("ip"));
				bdto.setFile(rs.getString("file"));
				bdto.setLikecount(rs.getInt("likecount"));
				bdto.setLike_member(rs.getString("like_member"));
	
				//boardList ��ĭ�� RuBoardDtO ��ü 1�� ����
				boardList.add(bdto);
				
				//System.out.println("��Ӻ��� ��񿡼� ������ �� ���� : " + bdto.toString());
				
			} //while() end
			System.out.println(" �� ����Ʈ �������� " + boardList.size()); //�ѹ��� 10���� �����ֱ�
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return boardList;
	}
	
	//Ư�� �Խ��� ����Ʈ �������� �Լ�
	public List<BoardDTO> getNoticeBoardList(int pageSize2, String board_type_notice) {

		List<BoardDTO> boardList = new ArrayList<BoardDTO>(); 		
		
		try {
			//DB ����
			con = getConn();
			
			// sql 
			sql = "select * from board_all where board_type = ? order by re_ref desc, re_ref limit ?, ? ";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, board_type_notice);
			pstmt.setInt(2, 0); 
			pstmt.setInt(3, pageSize2);	
			
			//����
			rs = pstmt.executeQuery();
			
			//��
			while(rs.next()) {
				BoardDTO bdto = new BoardDTO();
				//����
				bdto.setNum(rs.getInt("num")); 
				bdto.setBoard_type(rs.getString("board_type"));
				bdto.setSubject(rs.getString("subject"));
				bdto.setContent(rs.getString("content"));
				bdto.setMember_id(rs.getString("member_id"));
				bdto.setReadcount(rs.getInt("readcount"));
				bdto.setRe_ref(rs.getInt("re_ref"));
				bdto.setRe_lev(rs.getInt("re_lev"));
				bdto.setRe_seq(rs.getInt("re_seq"));
				bdto.setDate(rs.getDate("date"));
				bdto.setIp(rs.getString("ip"));
				bdto.setFile(rs.getString("file"));
				bdto.setLikecount(rs.getInt("likecount"));
				bdto.setLike_member(rs.getString("like_member"));
	
				//boardList ��ĭ�� RuBoardDtO ��ü 1�� ����
				boardList.add(bdto);
				
				//System.out.println("��Ӻ��� ��񿡼� ������ �� ���� : " + bdto.toString());
				
			} //while() end
			System.out.println(" �� ����Ʈ �������� " + boardList.size()); //�ѹ��� 10���� �����ֱ�
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return boardList;
	}

	
	//���&�߸� �Խ��ǿ� �� �߰��ϱ� �Լ�
	public boolean insertRuRelBoard(BoardDTO bdto) {
		boolean result = false;
		int re_ref = 0;
		
		try {
			//��� ����
			getConn();
			//select sql �ۼ�
			sql = "select max(re_ref) from sneakerhead.board_all where board_type = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bdto.getBoard_type());
			rs = pstmt.executeQuery();
			if(rs.next()) { //�����Ͱ� ������
				re_ref = rs.getInt(1) + 1;
			}
			
			//insert sql �ۼ�
			sql = "insert into board_all(num, member_id, board_type, subject, content, readcount, re_ref, re_lev, re_seq, date, ip, file, likecount, like_member) "
											+ "values(?, ?, ?, ?, ?, ?, ?, ?, ?, now(), ?, ?, ?, ?)";
			
			pstmt = con.prepareStatement(sql);
				
			pstmt.setInt(1, bdto.getNum());
			pstmt.setString(2, bdto.getMember_id());
			pstmt.setString(3, bdto.getBoard_type());		
			pstmt.setString(4, bdto.getSubject());		
			pstmt.setString(5, bdto.getContent());		
			pstmt.setInt(6, 0);		
			pstmt.setInt(7, re_ref);		
			pstmt.setInt(8, 0);
			pstmt.setInt(9, 0);
			pstmt.setString(10, bdto.getIp());
			pstmt.setString(11, bdto.getFile());
			pstmt.setInt(12, bdto.getLikecount());
			pstmt.setString(13, bdto.getLike_member());
			
			//����
			pstmt.executeUpdate();
			
			result = true;
			
			System.out.println("�Խ��� ������ �Ϸ�: " + result);
		} catch (Exception e) {
			System.out.println("�Խ��� �۾��� ����!");
			result = false;
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return result;
	}
	
	/* ******************************************************************************************************************** 
	/*	��Ÿ
	 * *******************************************************************************************************************/
	
	//����� ����� ���� ���� �ڸ��� ���� ���ϴ� �Լ�
	public OnFootDTO substringimg(String board_type, int re_ref) {
		OnFootDTO ofdto = new OnFootDTO(); //DTO ����
		
		try {
			con = getConn();
			//sql ����
			//sql = "select SUBSTRING_INDEX ( (select SUBSTRING_INDEX( ( select content from board_all where board_type = ? AND re_ref = ? AND content like '%/Project/editorImageUpload/%' ), '\"', 4)  ), '<p style=\"text-align: center;\"> <img src=\"', -1)";
			sql = "select content from board_all where board_type = ? AND re_ref = ? AND content like '%/Project/editorImageUpload/%'";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, board_type);
			pstmt.setInt(2, re_ref);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				//������ �߰��Ͽ��ٸ� 
				ofdto = new OnFootDTO();
				
				ofdto.setNewFileName(rs.getString(1));
				
				//System.out.println("�ڸ� ���� �̸��� ofdto ��ü�� ��Ҵ�!");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return ofdto;
	}
	
	
	
	
	
	
	
}
