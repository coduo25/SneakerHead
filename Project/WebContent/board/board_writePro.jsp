<%@page import="com.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<%
		//한글처리
		request.setCharacterEncoding("UTF-8");
	
		//전달된 정보를 저장 후 사용 (자바빈 객체 생성)
		%>
			<jsp:useBean id="bdto" class="com.board.BoardDTO" />
			<jsp:setProperty property="*" name="bdto"/>
		<%
		
		//board_write.jsp 페이지에서 전달된 작성글에 대한 정보를 처리
		bdto.setMember_id((String)session.getAttribute("ID"));
		bdto.setBoard_type(request.getParameter("board_type"));
		
		bdto.setSubject(request.getParameter("subject"));
		bdto.setContent(request.getParameter("content"));
		
		System.out.println(bdto.toString());
		
		//ip 정보 추가 저장
		bdto.setIp(request.getRemoteAddr());
		
		//DB 처리객체 - RuBoardDAO()
		BoardDAO bdao = new BoardDAO();
		
		//만약 넘어온 board_type 값이 '발매'이면
		if(bdto.getBoard_type().equals("발매")) {
			//insertBoard(); 글 추가하기
			boolean result = bdao.insertRuRelBoard(bdto); 
			if(result) {
				%>
				<script type="text/javascript">
					var check = confirm("글을 작성하시겠습니까?");
					if(check) {
						location.href="/Project/board/Relboard/Relboard_list.jsp";
					} else {
						history.back();
					}
					
				</script>
				<%
			} else {
				%>
					<script type="text/javascript">
						alert("발매 게시판에 글쓰기 실패하였습니다.");
						history.back();
					</script>
				<%
			}
		}
		//만약 넘어온 board_type 값이 '루머'이면
		else if(bdto.getBoard_type().equals("루머")) {
			//insertBoard(); 글 추가하기
			boolean result = bdao.insertRuRelBoard(bdto); 
			if(result) {
				%>
				<script type="text/javascript">
					confirm("글을 작성하시겠습니까?");
					location.href="/Project/board/Ruboard/Ruboard_list.jsp";
				</script>
				<%
			} else {
				%>
					<script type="text/javascript">
						alert("루머 게시판에 글쓰기 실패하였습니다.");
						history.back();
					</script>
				<%
			}
		}
		//만약 넘어온 board_type 값이 '착샷'이면
		else if(bdto.getBoard_type().equals("착샷")) {
			//insertBoard(); 글 추가하기
			boolean result = bdao.insertRuRelBoard(bdto); 
			if(result) {
				%>
				<script type="text/javascript">
					confirm("글을 작성하시겠습니까?");
					location.href="/Project/board/Onfootboard/Onfootboard_list.jsp";
				</script>
				<%
			} else {
				%>
					<script type="text/javascript">
						alert("착샷 게시판에 글쓰기 실패하였습니다.");
						history.back();
					</script>
				<%
			}
		}
		//만약 넘어온 board_type 값이 '신발장'이면
		else if(bdto.getBoard_type().equals("신발장")) {
			//insertBoard(); 글 추가하기
			boolean result = bdao.insertRuRelBoard(bdto); 
			if(result) {
				%>
				<script type="text/javascript">
					confirm("글을 작성하시겠습니까?");
					location.href="/Project/board/Lockerboard/Lockerboard_list.jsp";
				</script>
				<%
			} else {
				%>
					<script type="text/javascript">
						alert("신발장 게시판에 글쓰기 실패하였습니다.");
						history.back();
					</script>
				<%
			}
		}
		//만약 넘어온 board_type 값이 '셀럽들'이면
		else if(bdto.getBoard_type().equals("셀럽들")) {
			//insertBoard(); 글 추가하기
			boolean result = bdao.insertRuRelBoard(bdto); 
			if(result) {
				%>
				<script type="text/javascript">
					confirm("글을 작성하시겠습니까?");
					location.href="/Project/board/Celeboard/Celeboard_list.jsp";
				</script>
				<%
			} else {
				%>
					<script type="text/javascript">
						alert("셀럽들 게시판에 글쓰기 실패하였습니다.");
						history.back();
					</script>
				<%
			}
		}
		//만약 넘어온 board_type 값이 '공지'이면
		else if(bdto.getBoard_type().equals("공지")) {
			//insertBoard(); 글 추가하기
			boolean result = bdao.insertRuRelBoard(bdto); 
			if(result) {
				%>
				<script type="text/javascript">
					confirm("글을 작성하시겠습니까?");
					location.href="/Project/board/Noticeboard/Noticeboard_list.jsp";
				</script>
				<%
			} else {
				%>
					<script type="text/javascript">
						alert("공지 게시판에 글쓰기 실패하였습니다.");
						history.back();
					</script>
				<%
			}
		}
	%>

</body>
</html>