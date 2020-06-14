<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title> SneakerHouse 관리자페이지 </title>
<link rel="shortcut icon" href="/Project/images/icon/favicon.ico" />
<link rel="stylesheet" href="/Project/css/main.css">
<title>Insert title here</title>

	<%
		//관리자 계정으로 로그인이 안되었을시
		String admin = (String) session.getAttribute("ID");
		if( admin == null) {
			response.sendRedirect("/Project/member/loginForm.jsp");
		}
	%>
	
</head>
<body>

	<!-- Header -->
    <header> <jsp:include page="/include/header.jsp" /> </header>

	<!-- Main Content -->
	<!-- Main -->
    <div id="main_border">
    	 <!-- 게시판 -->
   		<div id="main_content">
    		<div id="bb_contentWrap">
				<h2> 관리자 권한 페이지 </h2>
				<ul>
					<li style="margin: 20px;"> <a href="memberAll.jsp"> 전체 회원 관리 </a> <br> </li>
					<li style="margin: 20px;"> <a href="add_NewSneaker.jsp"> 새로운 신발 SneaekrDB에 추가하기 </a> </li>
				</ul> 
			</div>
		</div>
	</div>

	<!-- FOOTER -->
	<footer> <jsp:include page="/include/footer.jsp"/> </footer>
	

</body>
</html>