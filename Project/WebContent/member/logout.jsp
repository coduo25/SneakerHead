<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<script type="text/javascript">
		var result = confirm("로그아웃 하시겠습니까?");
		if(result) {
			alert("로그아웃에 성공하였습니다.");
			<%
				session.invalidate();
			%>
			location.href="/Project/index.jsp";
		}
		else {
			alert("로그아웃에 실패하였습니다.");
			history.back();
		}
	</script>

</body>
</html>