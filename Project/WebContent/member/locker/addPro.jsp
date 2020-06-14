<%@page import="com.sneaker.SneakerDTO"%>
<%@page import="com.sneaker.SneakerDAO"%>
<%@page import="com.sneaker.mylocker.My_sneakerDAO"%>
<%@page import="com.sneaker.mylocker.My_sneakerDTO"%>
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
		request.setCharacterEncoding("UTF-8"); 
	
		//전달되는 파라미터 값 저장 -> 자바빈 객체를 활용하여 액션태그로 저장
		%>
			<jsp:useBean id="mydto" class="com.sneaker.mylocker.My_sneakerDTO" />
			<jsp:setProperty name="mydto" property="*" />
		<%
		System.out.println("(" + mydto.toString() + ")");
		
		//My_sneaker DB 처리 객체 생성
		My_sneakerDAO mydao = new My_sneakerDAO();
		
		//insertSneaker 메서드 호출 
		mydao.insertSneaker(mydto);
		
		//페이지 이동 -> my_locker.jsp
	%>
	
	<script type="text/javascript">
		alert("신발장에 추가하였습니다.");
		location.href="my_locker.jsp";
	</script>

</body>
</html>