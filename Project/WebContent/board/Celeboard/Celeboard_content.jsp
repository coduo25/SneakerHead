<%@page import="com.board.BoardDTO"%>
<%@page import="com.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title> SneakerHouse 셀럽들</title>
<link rel="shortcut icon" href="/Project/images/icon/favicon.ico" />
<link rel="stylesheet" href="/Project/css/board/board.css">
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic|Nanum+Gothic+Coding&display=swap" rel="stylesheet">
</head>
<body>

	<%
		//한글처리
		request.setCharacterEncoding("UTF-8");
	
		//Celeboard_list에서 넘어온 값들 받기
		String member_id = (String) session.getAttribute("ID");			//로그인된 사용자의 아이디
		String name = request.getParameter("name");						//글쓴이의 아이디
		String board_type = request.getParameter("board_type");			//클릭한 글의 타입
		int re_ref = Integer.parseInt(request.getParameter("re_ref"));	//클릭한 글의 re_ref 값
    	String pageNum = request.getParameter("pageNum");				//클릭한 글의 pageNum
		
		//DB 처리객체
		BoardDAO bdao = new BoardDAO();
		
		//게시판 글의 조회수를 1증가 시키는 메서드, updateReadCount(해당글의 번호)
		bdao.updateReadCount(board_type, re_ref); 
		
		//re_ref에 해당하는 글정보를 가져오는 메서드를 사용하여 정보를 BoardDTO 객체에 담기
		BoardDTO bdto = bdao.getBoardContent(board_type, re_ref);
	%>
	
	<!-- Header -->
    <header> <jsp:include page="/include/header.jsp" /> </header>
    
    <div id="main_border">
		<!-- 글쓰기 란 -->
		<div id="main_content">
			<div id="bb_contentWrap">
				<div id="bb_content">
					<!-- 글 정보 영역 -->
					<div class="content_table">
						<form action="#" method="post" name="fr" class="bbwrite_table" enctype="application/x-www-form-urlencoded">	
							<div>
								<table>
									<tbody>
										<tr>
											<th scope="row"> 제목 </th>
											<td colspan="2"> <%= bdto.getSubject() %> </td>  
										</tr>	
										<tr>
											<th scope="row"> 작성자 </th>
											<td> <%= bdto.getMember_id() %> </td>
										</tr>
										<tr>
											<th scope="row"> 작성일 </th>
											<td> <%= bdto.getDate() %> </td>
										</tr>
										<tr>
											<th colspan="2">
												<!-- 글 내용 -->
												<div class="content_detail" style="width:800px; margin-left:auto; margin-right:auto;">
													<p style="text-align: center;"> <%= bdto.getContent() %> </p>
												</div> 
											</th>
										</tr>
									</tbody>
								</table>
							</div>
							
							<!-- 글쓰기, 수정, 삭제 버튼 영역 -->
							<div class="table_submit">
								<%
									//글쓴이와 로그인한 사용자가 같은 사람일 경우
									if(member_id != null) {
										if(member_id.equals(name)) {
								%>
									<span class="gLeft">
										<input type="button" value="삭제" >	
									</span>
									<span class="gRight">
										<input class="gRight_List" type="button" value="목록" onclick="location.href='Celeboard_list.jsp?pageNum=<%=pageNum%>';">
										<input class="gRight_Update" type="button" value="수정" onclick="location.href='/Project/board/board_update.jsp?pageNum=<%=pageNum%>&board_type=<%=bdto.getBoard_type()%>&re_ref=<%=bdto.getRe_ref()%>';">		
									</span>
								<%
										} else {
								%>
										<span class="gRight">
											<input class="gRight_List" type="button" value="목록" onclick="location.href='Celeboard_list.jsp?pageNum=<%=pageNum%>';">
										</span>
								<%
										} 
									} else if(member_id == null) {
								%>
									<span class="gRight">
										<input class="gRight_List" type="button" value="목록" onclick="location.href='Celeboard_list.jsp?pageNum=<%=pageNum%>';">
									</span>
								<%
									}
								%>

							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
    
    <!-- FOOTER -->
	<footer> <jsp:include page="/include/footer.jsp"/> </footer>
	
</body>
</html>