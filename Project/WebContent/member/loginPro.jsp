<%@page import="com.member.MemberDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

</head>
<body>

	<%
		request.setCharacterEncoding("UTF-8");
		
		//로그인한 아이디와 비밀번호 파라미터 값 가져오기
		String id = request.getParameter("id");
		String pw = request.getParameter("pass");
		
		// DB 작업 처리  DAO 객체를 생성 
		MemberDAO mdao = new MemberDAO();
		
		// 전달받은 ID,PASS를 가지고 해당 회원이 로그인 처리 
		// 1) ID 존재 유무
		// 2) 비밀번호가 같은가 
		// 3) 로그인 상태 -> 세션값 생성 -> main 페이지 이동
		//  결과  1 -로그인 상태, 0- 비밀번호 오류, -1 - 아이디없음
		
		int check = mdao.idCheck(id, pw);
		if (check == 1) {
			//로그인 완료
			session.setAttribute("ID", id);
			//response.sendRedirect(arg0); - javascript 코드랑 같이 쓸수 없다. Java코드를 먼저 읽고, html코드를 읽고, javascript코드를 읽는다.
			%>
				<script type="text/javascript">
					alert("로그인 완료되었습니다.");
					location.href="/Project/index.jsp";
				</script>
			<%
		}
		else if(check == 0) {
			%>
			<script type="text/javascript">
				alert("비밀번호가 틀립니다.");
				history.back();
			</script>
		<%
		}
		else if(check == -1) {
			%>
			<script type="text/javascript">
				var result = confirm("존재하지 않는 아이디입니다. 회원가입 하시겠습니까?");
				
				if(result) {
					location.href="/Project/member/joinForm.jsp?member_id=<%= id %> ";
				} else {
					history.back();
				}
			</script>
		<%
		}
	%>
	

</body>
</html>