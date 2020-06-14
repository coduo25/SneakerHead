<%@page import="com.member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<%
		request.setCharacterEncoding("UTF-8");
	
		String email = request.getParameter("email");
		boolean check = false;
		String str = "";

		MemberDAO mdao = new MemberDAO();
		check = mdao.emailDoubleCheck(email);
		
		//이메일이 DB에 이미 존재하면
		if(check) {
			//이미 존재하는 이메일
			str = "NO";
			out.print(str);
		}
		//이메일이 DB에 없으면
		else {
			//사용 가능한 이메일
			str = "YES";
			out.print(str);
		}
	%>
