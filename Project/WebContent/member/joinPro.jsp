<%@page import="java.sql.Timestamp"%>
<%@page import="com.member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>

	<%
		request.setCharacterEncoding("UTF-8");
	%>
		<jsp:useBean id="mdto" class="com.member.MemberDTO"/>
		<jsp:setProperty property="*" name="mdto"/>
	<%
		//주소값 하나의 값으로 만들기
		mdto.setFulladd(mdto.getPostcode() + " " +  mdto.getAddr1() + " " + mdto.getAddr2() + " " + mdto.getAddr3());
		
		//휴대전화 하나의 값으로 만들기
		mdto.setFullphone(mdto.getMobile1() + " " + mdto.getMobile2() + " " + mdto.getMobile3());
		
		//현 시스템의 시간정보를 저장
		mdto.setReg_date(new Timestamp(System.currentTimeMillis()));
		
		//MemberDAO 객체 생성
		MemberDAO mdao = new MemberDAO();
		mdao.insertMember(mdto); //받아온 인수들 MemberDB에 저장하기 함수
	%>

	<script type="text/javascript">
		alert("회원가입을 성공하였습니다.");
		location.href="/Project/member/loginForm.jsp";
	</script>

</body>
</html>