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

		//board_update.jsp 페이지에서 전달된 정보를 DB에 저장

		//넘어온 파라미터값들 저장
		String pageNum = request.getParameter("pageNum");	//클릭한 글의 pageNum

		//전달정보 (글번호(re_ref), 글쓴이, 제목, 내용) => 액션태그에 저장
	%>
		<jsp:useBean id="bdto" class="com.board.BoardDTO" />
		<jsp:setProperty property="*" name="bdto" />
	<%
		//BoardDAO 객체 생성
		BoardDAO bdao = new BoardDAO();

		int check = bdao.updateBoard(bdto);
		
		//--------------board_type이 '발매'이면 -----------------------------------------------------------------------------------------------------------------
		if(bdto.getBoard_type().equals("발매")) {
			if (check == 1) {
		%>
			<script type="text/javascript">
				alert("발매 글 수정 완료 ");
				location.href="/Project/board/Relboard/Relboard_list.jsp?pageNum=<%=pageNum%>";
			</script>
		<%
			} else if (check == 0) {
		%>
			<script type="text/javascript">
				alert(" 수정하고자 하는 사람이 로그인된 사람이 아닙니다. ");
				history.back();
			</script>
		<%
			} else { // check == -1
		%>
			<script type="text/javascript">
				alert(" DB 오류  ");
				history.back();
			</script>
		<%
			}
		}
		//--------------board_type이 '루머'이면 -----------------------------------------------------------------------------------------------------------------
		else if(bdto.getBoard_type().equals("루머")) {
			if (check == 1) {
		%>
			<script type="text/javascript">
				alert("루머 글 수정 완료 ");
				location.href="/Project/board/Ruboard/Ruboard_list.jsp?pageNum=<%=pageNum%>";
			</script>
		<%
			} else if (check == 0) {
		%>
			<script type="text/javascript">
				alert(" 수정하고자 하는 사람이 로그인된 사람이 아닙니다. ");
				history.back();
			</script>
		<%
			} else { // check == -1
		%>
			<script type="text/javascript">
				alert(" DB 오류  ");
				history.back();
			</script>
		<%
			}
		}
		//--------------board_type이 '착샷'이면 -----------------------------------------------------------------------------------------------------------------
		else if(bdto.getBoard_type().equals("착샷")) {
			if (check == 1) {
		%>
			<script type="text/javascript">
				alert("착샷 글 수정 완료 ");
				location.href="/Project/board/Onfootboard/Onfootboard_list.jsp?pageNum=<%=pageNum%>";
			</script>
		<%
			} else if (check == 0) {
		%>
			<script type="text/javascript">
				alert(" 수정하고자 하는 사람이 로그인된 사람이 아닙니다. ");
				history.back();
			</script>
		<%
			} else { // check == -1
		%>
			<script type="text/javascript">
				alert(" DB 오류  ");
				history.back();
			</script>
		<%
			}
		}
		//--------------board_type이 '신발장'이면 -----------------------------------------------------------------------------------------------------------------
		else if(bdto.getBoard_type().equals("신발장")) {
			if (check == 1) {
		%>
			<script type="text/javascript">
				alert("신발장 글 수정 완료 ");
				location.href="/Project/board/Lockerboard/Lockerboard_list.jsp?pageNum=<%=pageNum%>";
			</script>
		<%
			} else if (check == 0) {
		%>
			<script type="text/javascript">
				alert(" 수정하고자 하는 사람이 로그인된 사람이 아닙니다. ");
				history.back();
			</script>
		<%
			} else { // check == -1
		%>
			<script type="text/javascript">
				alert(" DB 오류  ");
				history.back();
			</script>
		<%
			}
		}
		//--------------board_type이 '셀럽들'이면 -----------------------------------------------------------------------------------------------------------------
		else if(bdto.getBoard_type().equals("셀럽들")) {
			if (check == 1) {
		%>
			<script type="text/javascript">
				alert("셀럽들 글 수정 완료 ");
				location.href="/Project/board/Celeboard/Celeboard_list.jsp?pageNum=<%=pageNum%>";
			</script>
		<%
			} else if (check == 0) {
		%>
			<script type="text/javascript">
				alert(" 수정하고자 하는 사람이 로그인된 사람이 아닙니다. ");
				history.back();
			</script>
		<%
			} else { // check == -1
		%>
			<script type="text/javascript">
				alert(" DB 오류  ");
				history.back();
			</script>
		<%
			}
		}
		//--------------board_type이 '공지'이면 -----------------------------------------------------------------------------------------------------------------
		else if(bdto.getBoard_type().equals("공지")) {
			if (check == 1) {
		%>
			<script type="text/javascript">
				alert("공지 글 수정 완료 ");
				location.href="/Project/board/Noticeboard/Noticeboard_list.jsp?pageNum=<%=pageNum%>";
			</script>
		<%
			} else if (check == 0) {
		%>
			<script type="text/javascript">
				alert(" 수정하고자 하는 사람이 로그인된 사람이 아닙니다. ");
				history.back();
			</script>
		<%
			} else { // check == -1
		%>
			<script type="text/javascript">
				alert(" DB 오류  ");
				history.back();
			</script>
		<%
			}
		}
		
		
		
		
		%>
		
		
		

</body>
</html>