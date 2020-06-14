<%@page import="com.board.BoardDTO"%>
<%@page import="com.board.BoardDAO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title> SneakerHouse 발매루머</title>
<link rel="shortcut icon" href="/Project/images/icon/favicon.ico" />
<link rel="stylesheet" href="/Project/css/board/board.css">
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic|Nanum+Gothic+Coding&display=swap" rel="stylesheet">
<!-- Fontawesome 사이트에서 아이콘 쓰기 위한 스크립트 파일 -->
<script src="https://kit.fontawesome.com/febeeb992c.js" crossorigin="anonymous"></script>

</head>
<body>

	<%
		//session ID값 가져오기
		String member_id = (String) session.getAttribute("ID");
		
		//개수를 계산해오는 메서드 구현
		//Board DB처리 객체 생성 BoardDAO()
		BoardDAO bdao = new BoardDAO();
		String board_type = "루머";
		int count = bdao.getSpecialBoardCount(board_type);
		
		//공지사항 글 개수를 계산해오는 메서드 구현
		String board_type_notice = "공지";
		int count2 = bdao.getSpecialBoardCount(board_type_notice);
		
		//////////////////////////////////////////////////////
		//페이징 처리
		//한페이지에서 보여줄 글의 개수
		int pageSize = 10;
		int pageSize2 = 5; //한페이지에 공지사항 보여줄 글의 개수 
		
		//페이지 정보
		String pageNum = request.getParameter("pageNum");
		
		if(pageNum == null) { //데이터를 가지고 올때 항상 Null인지 아닌지 확인해야하는 습관을 들여야한다. 
			pageNum = "1";	//최신페이지를 보여주는 동작
		}
		
		//첫행 계산
		int currentPage = Integer.parseInt(pageNum);
		int startRow = (currentPage - 1) * pageSize + 1;
		//////////////////////////////////////////////////////
	%>

	<!-- Header -->
    <header> <jsp:include page="/include/header.jsp" /> </header>
    
    <!-- Main -->
    <div id="main_border">
    	 <!-- 게시판 -->
   		<div id="main_content">
    		<div id="bb_contentWrap">
    			<div id="bb_content">
    				<!-- 게시판 파트 -->
    				<div class="board_list">
    					<!-- 소제목 -->
    					<div class="sub_title"> 
    						<h2> 루머/미정 게시판 </h2> 
    					</div>
    					<!-- 메인게시판 테이블 -->
						<div class="base_table">
							<table class="main_table_collection">
								<!-- 게시판의 헤더 -->
								<thead>
									<tr class="header_table_collection">
						    			<th class="tNum"> 번호 </th>
						    			<th class="tSub"> 제목 </th>
						    			<th class="tName"> 작성자 </th>
						    			<th class="tDate"> 날짜 </th>
						    			<th class="tRead"> 조회수 </th>
					    			</tr>
								</thead>
					    		<tbody>
					    			<!-- 공지게시판의 글들 -->
					    			<%
						    			List<BoardDTO> boardList_notice = null;
				    					if(count2 != 0) { //DB안에 글이 있으면 보여지게 된다. 
				    						//DB에서 정보를 가져오기 (메서드)
				    						boardList_notice = bdao.getNoticeBoardList(pageSize2, board_type_notice);
				    						//정보의 개수 만큼 페이지에 반복 출력
				    						int size = boardList_notice.size();
											for(int i=0; i<size; i++) {
				    							BoardDTO bdto = boardList_notice.get(i); //한칸을 꺼내서 RuBoardDTO 타입의 객체에 저장
					    			%>
					    			<tr class="content_table_collection">
						    			<td> <strong class="board-tag-txt"> <span class="inner"> <%= bdto.getBoard_type() %> </span> </strong> </td>
						    			<td class="main_content"><a href="/Project/board/Noticeboard/Noticeboard_content.jsp?board_type=<%=bdto.getBoard_type()%>&re_ref=<%=bdto.getRe_ref()%>&pageNum=<%=pageNum%>&name=<%=bdto.getMember_id()%>&previous_board_type=<%= board_type %>" style="color: #ff4e59; font-weight: bold;"> <%= bdto.getSubject() %> </a> </td>
						    			<td> <%= bdto.getMember_id() %> </td>
						    			<td> <%= bdto.getDate() %> </td>
						    			<td> <%= bdto.getReadcount() %> </td>
					    			</tr>
						    		<%
				    						}
				    					}
						    		%>
						    		
					    			<!-- 게시판 글 리스트 뿌리기  -->
						    		<%
					    				List<BoardDTO> boardList = null;
				    					if(count != 0) { //DB안에 글이 있으면 보여지게 된다. 
				    						//DB에서 정보를 가져오기 (메서드)
				    						boardList = bdao.getSpecialBoardList(startRow, pageSize, board_type);
				    						//정보의 개수 만큼 페이지에 반복 출력
				    						int size = boardList.size();
											for(int i=0; i<size; i++) {
				    							BoardDTO bdto = boardList.get(i); //한칸을 꺼내서 RuBoardDTO 타입의 객체에 저장
					    			%>
						    		<tr class="content_table_collection">
						    			<td> <%= bdto.getRe_ref() %>  </td>
						    			<td class="main_content"><a href="Ruboard_content.jsp?board_type=<%=bdto.getBoard_type()%>&re_ref=<%=bdto.getRe_ref()%>&pageNum=<%=pageNum%>&name=<%=bdto.getMember_id()%>"> <%= bdto.getSubject() %> </a> </td>
						    			<td> <%= bdto.getMember_id() %> </td>
						    			<td> <%= bdto.getDate() %> </td>
						    			<td> <%= bdto.getReadcount() %> </td>
						    		</tr>
						    		<%
				    						}
				    					}
						    		%>
					    		</tbody>
				    		</table>
						</div>
    				</div>
    				
    				<!-- 페이지 번호 파트 -->
			    	<div class="page_control">
			    		<%
			    			//페이징 처리
			    			//글이 있을때만 처리
			    			if(count != 0) {
			    				int pageCount = count/pageSize + (count%pageSize == 0 ? 0 : 1 ); 
			    				//예시) 글의 갯수가 14개/글 표시 10개 = 1.4 + (14개%10 나머지 4) == 0이 아니기 때문에 1 = 2.4 = 2
			    				
			    				//한페이지에서 보여줄 페이지수를 설정 (1~10 페이지가 생겨진다면 몇개를 보여줄것이냐)
			    				int pageBlock = 10;
			    				
			    				//시작하는 페이지 번호 계산
			    				int startPage = ((currentPage - 1)/pageBlock) * pageBlock + 1;
			    				
			    				//끝나는 페이지 번호 계산
			    				int endPage = currentPage + pageBlock -1;
			    				
			    				if(endPage > pageCount) {
			    					endPage = pageCount;
			    				}
			    				
								/////////////////////////////////////////////////////////////////////
								// 이전
								if(startPage > pageBlock) {
								%>
								<p> <a href="Ruboard_list.jsp?pageNum=<%= startPage - pageBlock %>"> <i class="fas fa-angle-left"></i>  </a> </p>
								<%
								}
								
								// 1~10, 11~20, ....
								for(int i=startPage; i<=endPage; i++) {
								%>
								<ol>
									<li>
										<a href="Ruboard_list.jsp?pageNum=<%=i%>"><%= i %> </a>
									</li>
								</ol>
								<%
								}
								
								//다음
								if(endPage < pageCount) {
								%>
								<p> <a href="Ruboard_list.jsp?pageNum=<%= startPage + pageBlock %>"> <i class="fas fa-angle-right"></i> </a> </p>
								<%
								}
			    			}
			    		%>
			    	</div>	
			    	
			    	<!-- 게시판 글쓰기, 찾기 란 -->
			    	<div class="board_button">
			    		<!-- 글쓰기 버튼 란 -->
				    	<%
	    					//로그인이 되어있으면 '글쓰기'버튼 나타나게 하기
	    					if(member_id != null) {
	    				%>
	    				<span class="span_write_btn">
	    					<input type="button" value="글쓰기" class="write_btn" onclick="location.href='/Project/board/board_write.jsp?board_type=<%=board_type%>'">
	    				</span>
				    	<%
				    		}
				    	%>
			    	</div>
			    	
    			</div>
    		</div> 
    	</div>
    </div>
    
    <!-- FOOTER -->
	<footer> <jsp:include page="/include/footer.jsp"/> </footer>
	
</body>
</html>