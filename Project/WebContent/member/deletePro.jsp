<%@page import="com.member.MemberDTO"%>
<%@page import="com.member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<%
		request.setCharacterEncoding("UTF-8");

		String member_id = request.getParameter("id");
		String pass = request.getParameter("pass");
	
		System.out.println("넘어온 값 확인, 아이디: " + member_id + ", 비밀번호: " + pass);
	
		MemberDAO mdao = new MemberDAO();
		String str = "";

		//비밀번호 체크
		int check = mdao.deleteMember(member_id, pass);
		System.out.println("check 값: " + check);
		
		if(check == 1) {
			//세션 초기화
			session.invalidate();
			str = "YES";
			out.print(str);
		} else if(check == 0) {
			str = "PASS";
			out.print(str);
		} else if(check == -1) {
			str = "NO";
			out.print(str);
		}
		
	%>
