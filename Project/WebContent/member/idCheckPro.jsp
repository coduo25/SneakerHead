<%@page import="com.member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<%
		request.setCharacterEncoding("UTF-8");
	
		String member_id = request.getParameter("member_id");
		boolean check = false;
		String str = "";

		MemberDAO mdao = new MemberDAO();
		check = mdao.idDoubleCheck(member_id);
		
		//아이디가 DB에 이미 존재하면
		if(check) {
			//이미 존재하는 계정
			str = "NO";
			out.print(str);
		}
		//아이디가 DB에 없으면
		else {
			//사용 가능한 계정
			str = "YES";
			out.print(str);
		}
	%>