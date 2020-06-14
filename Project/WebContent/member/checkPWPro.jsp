<%@page import="com.member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <%
	    request.setCharacterEncoding("UTF-8");
		
		String member_id = request.getParameter("member_id");
		String pass = request.getParameter("pass");

		String str = "";
		
		MemberDAO mdao = new MemberDAO();
		int check = mdao.checkMemberPW(member_id, pass);
		
		if(check == 1) {
			str = "YES";
			out.print(str);
		}
		else {
			str = "NO";
			out.print(str);
		}
    %>
    