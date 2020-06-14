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
	
	//DB관련 reference 선언
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
	
/* ******************************************************************************************************************** 
/* 	공통으로 쓰이는 함수들
 * *******************************************************************************************************************/
	
	//updateReadCount(): 조회수 변경 함수 
	public void updateReadCount(String board_type, int re_ref) {
		//DB 연결
		con = getConn();
		try {
			//sql 작성: num 해당하는 글 정보중 조회수 1 증가
			sql = "update board_all set readcount = readcount + 1 where re_ref = ? AND board_type = ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, re_ref);
			pstmt.setString(2, board_type);
			//실행
			pstmt.executeUpdate();	
			System.out.println(" (글 조회수 1 증가 성공!) ");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
	}

	//getBoard() : 글의 내용을 가져오는 함수
	public BoardDTO getBoardContent(String board_type, int re_ref) {
		BoardDTO bdto = null; //DTO 객체를 비우고
		
		//DB 연결
		con = getConn();
		try {
			//sql 구문 작성, select 구문 써서 정보 다 가져오기
			sql = "select * from board_all where re_ref = ? AND board_type = ?";
		
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, re_ref);
			pstmt.setString(2, board_type);
			
			//실행
			rs = pstmt.executeQuery();
			
			if(rs.next()){ //만약 해당 글이 있으면
				bdto = new BoardDTO();
				
				//DB의 정보들 -> BoardBean 으로 전달 
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
				
				//System.out.println("- 정보 조회 성공 : " + bdto.toString());
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return bdto;
	} //end of getBoard()
	
	//글수정하는 함수
	public int updateBoard(BoardDTO bdto) {
		int check = -1;
		try {
			//DB연결
			con = getConn();
			//sql 구문
			sql = "select member_id from board_all where board_type = ? AND re_ref = ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bdto.getBoard_type());
			pstmt.setInt(2, bdto.getRe_ref());
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				//글 있음
				if(bdto.getMember_id().equals(rs.getString("member_id"))) {					
					//수정하고자 하는 글의 작성자가 수정하는 사람이라면
					sql = "update board_all set subject = ?, content = ? where board_type = ? AND re_ref = ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, bdto.getSubject());
					pstmt.setString(2, bdto.getContent());
					pstmt.setString(3, bdto.getBoard_type());
					pstmt.setInt(4, bdto.getRe_ref());
					
					check = pstmt.executeUpdate();
				} else {
					//수정하고자 하는 글의 작성자가 수정하는 사람이 아니라면
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
/*	전체 글 게시판 관련 함수들 
 * *******************************************************************************************************************/
	
	//getBoardCount(): 글 개수를 계산해서 가져오는 함수 
	public int getAllBoardCount() {
		int count = 0;
		try {
			//디비 연결
			con=getConn();
			
			//sql 구문
			sql = "select count(*) from board_all";
			
			//실행
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			//처리
			if(rs.next()) { //데이터를 꺼내서
				count = rs.getInt(1);
			}
			//System.out.println(" (글 개수 계산 완료) ");
		} catch (Exception e) {
			System.out.println(" (글 개수 계산 오류) ");
		} finally {
			closeDB();
		}
		return count;
	} //end of getBoardCount()
	
	//getBoardList(): DB안에 글의 정보들을 가져오는 함수
	public List<BoardDTO> getBoardList(int startRow, int pageSize) { //글에 대한 모든 정보를 가져가기 때문에 list 객체 쓰기, List<BoardBean> = 이 List 안에 BoardBean의 형태로만 가지고 다니겠다라는 의미
		
		//Up-casting List라는 인터페이스는 객체를 생성 못하기 대문에 ArrayList라는 객체를 이용해서 Upcasting 한다. (자동으로 형변환한다.) 한칸한칸을 RuBoadDTO 형태로 가져간다. 그리고 그 한칸안에는 RuBoadDTO의 데이터가 들어가있다.
		List<BoardDTO> boardList = new ArrayList<BoardDTO>(); 
		//List boardList2 = new ArrayList(); //한칸한칸에 Object 타입으로 만들어진다. <> = generic, 써도되지만 나온지가 얼마 안되서 어느정도는 호환이 가능하지만 그래도 오류나 경고메세지가 뜰확률이 있다. <> generic 형식으로 쓰려고 습관을 들이는게 좋다. 
		
		try {
			//DB 연결
			con = getConn();
			
			// sql 
				// - re_ref: 최신글 가장 위쪽 
				// - re_seq: 답글 그룹별로 내림차순정렬 순서는 오름차순으로
				// - limit ?, ? : 필요한 개수만큼 짤라서 가져가기
			sql = "select * from board_all order by num DESC, num limit ?, ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, startRow - 1); //시작행
			pstmt.setInt(2, pageSize);	//몇개씩 가져올건지 limit ?, ? = ? 부터 ? 까지 가져온다는 문법 
			
			//실행
			rs = pstmt.executeQuery();
			
			//비교
			while(rs.next()) {
				BoardDTO bdto = new BoardDTO();
				//저장
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

				//boardList 한칸에 RuBoardDtO 객체 1개 저장
				boardList.add(bdto);
				
				//System.out.println("- 정보 조회 성공 : " + bdto.toString());
				
			} //while() end
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return boardList;
	}
	
/* ******************************************************************************************************************** 
/*	특정 게시판 관련(루머 게시판&발매 게시판 &착샷 등등) 함수들 
 * *******************************************************************************************************************/
	
	//글 갯수를 계산해서 가져오는 함수
	public int getSpecialBoardCount(String board_type) {
		int count = 0;
		try {
			//디비 연결
			getConn();
			
			//sql 구문
			sql = "select count(*) from board_all where board_type = ?";
			
			//실행
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, board_type);
			rs = pstmt.executeQuery();
			
			//처리
			if(rs.next()) { //데이터를 꺼내서
				count = rs.getInt(1);
			}
			//System.out.println(" (글 개수 계산 완료) ");	
		} catch (Exception e) {
			System.out.println(" (글 개수 계산 오류) ");
		} finally {
			closeDB();
		}
		return count;
	}
	
	//특정 게시판 리스트 가져오는 함수
	public List<BoardDTO> getSpecialBoardList(int startRow, int pageSize, String board_type) {
				
		List<BoardDTO> boardList = new ArrayList<BoardDTO>(); 		
		
		try {
			//DB 연결
			con = getConn();
			
			// sql 
			sql = "select * from board_all where board_type = ? order by re_ref desc, re_seq limit ?, ? ";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, board_type);
			pstmt.setInt(2, startRow - 1); //시작행
			pstmt.setInt(3, pageSize);	//몇개씩 가져올건지 limit ?, ? = ? 부터 ? 까지 가져온다는 문법
			
			//실행
			rs = pstmt.executeQuery();
			
			//비교
			while(rs.next()) {
				BoardDTO bdto = new BoardDTO();
				//저장
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
	
				//boardList 한칸에 RuBoardDtO 객체 1개 저장
				boardList.add(bdto);
				
				//System.out.println("루머보드 디비에서 가지고 온 값들 : " + bdto.toString());
				
			} //while() end
			System.out.println(" 글 리스트 가져오기 " + boardList.size()); //한번에 10개씩 보여주기
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return boardList;
	}
	
	//특정 게시판 리스트 가져오는 함수
	public List<BoardDTO> getNoticeBoardList(int pageSize2, String board_type_notice) {

		List<BoardDTO> boardList = new ArrayList<BoardDTO>(); 		
		
		try {
			//DB 연결
			con = getConn();
			
			// sql 
			sql = "select * from board_all where board_type = ? order by re_ref desc, re_ref limit ?, ? ";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, board_type_notice);
			pstmt.setInt(2, 0); 
			pstmt.setInt(3, pageSize2);	
			
			//실행
			rs = pstmt.executeQuery();
			
			//비교
			while(rs.next()) {
				BoardDTO bdto = new BoardDTO();
				//저장
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
	
				//boardList 한칸에 RuBoardDtO 객체 1개 저장
				boardList.add(bdto);
				
				//System.out.println("루머보드 디비에서 가지고 온 값들 : " + bdto.toString());
				
			} //while() end
			System.out.println(" 글 리스트 가져오기 " + boardList.size()); //한번에 10개씩 보여주기
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return boardList;
	}

	
	//루머&발매 게시판에 글 추가하기 함수
	public boolean insertRuRelBoard(BoardDTO bdto) {
		boolean result = false;
		int re_ref = 0;
		
		try {
			//디비 연결
			getConn();
			//select sql 작성
			sql = "select max(re_ref) from sneakerhead.board_all where board_type = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bdto.getBoard_type());
			rs = pstmt.executeQuery();
			if(rs.next()) { //데이터가 있으면
				re_ref = rs.getInt(1) + 1;
			}
			
			//insert sql 작성
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
			
			//실행
			pstmt.executeUpdate();
			
			result = true;
			
			System.out.println("게시판 글저장 완료: " + result);
		} catch (Exception e) {
			System.out.println("게시판 글쓰기 오류!");
			result = false;
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return result;
	}
	
	/* ******************************************************************************************************************** 
	/*	기타
	 * *******************************************************************************************************************/
	
	//썸네일 만들기 위한 제목 자르기 구문 구하는 함수
	public OnFootDTO substringimg(String board_type, int re_ref) {
		OnFootDTO ofdto = new OnFootDTO(); //DTO 비우고
		
		try {
			con = getConn();
			//sql 구문
			//sql = "select SUBSTRING_INDEX ( (select SUBSTRING_INDEX( ( select content from board_all where board_type = ? AND re_ref = ? AND content like '%/Project/editorImageUpload/%' ), '\"', 4)  ), '<p style=\"text-align: center;\"> <img src=\"', -1)";
			sql = "select content from board_all where board_type = ? AND re_ref = ? AND content like '%/Project/editorImageUpload/%'";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, board_type);
			pstmt.setInt(2, re_ref);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				//구문을 발견하였다면 
				ofdto = new OnFootDTO();
				
				ofdto.setNewFileName(rs.getString(1));
				
				//System.out.println("자른 파일 이름을 ofdto 객체에 담았다!");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return ofdto;
	}
	
	
	
	
	
	
	
}
