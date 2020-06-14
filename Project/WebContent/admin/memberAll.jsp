<%@page import="com.member.MemberDAO"%>
<%@page import="com.member.MemberDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title> 관리자페이지 - 전체회원보기 </title>
<link rel="shortcut icon" href="/Project/images/icon/favicon.ico" />
<link rel="stylesheet" href="/Project/css/main.css">
</head>
<body>
	 <!-- Header -->
    <header> <jsp:include page="/include/header.jsp" /> </header>
    
    <!-- Main -->
    <div id="main_border">
   		<div id="main_content">
    		<div id="bb_contentWrap" style="width:100%;">
    			<div style="margin: 20px 0">
    				<button onclick="location.href='/Project/admin/admin_page.jsp'"> 뒤로가기 </button>
    			</div>
    		
				<div id="bb_content">		
	   				<div class="board_list">
	   					<!-- 회원테이블 -->
						<div class="base_table">
							<table class="main_table_collection">
								<thead>
									<tr class="header_table_collection">
						    			<th> 아이디 </th>
						    			<th> 비밀번호 </th>
						    			<th> 이름 </th>
						    			<th> 주소 </th>
						    			<th> 번호 </th>
						    			<th> 이메일 </th>
						    			<th> 가입일자 </th>
					    			</tr>
								</thead>
								<tbody>
					    			<!-- 회원 리스트 뿌리기  -->
						    		<%
					    				MemberDAO mdao = new MemberDAO();
						    			List<MemberDTO> memberList = null;
					    				memberList = mdao.getAllMember();
					    				int size = memberList.size();
					    				for(int i=0; i<size; i++) {
					    					MemberDTO mdto = memberList.get(i);
					    			%>
						    		<tr class="content_table_collection">
						    			<td> <%= mdto.getId() %> </td>
						    			<td> <%= mdto.getPass() %> </td>
						    			<td> <%= mdto.getName() %> </td>
						    			<td> <%= mdto.getFulladd() %> </td>
						    			<td> <%= mdto.getFullphone() %> </td>
						    			<td> <%= mdto.getEmail() %> </td>
						    			<td> <%= mdto.getReg_date() %> </td>
						    		</tr>
						    		<%
					    				}
						    		%>
					    		</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
    
    <!-- FOOTER -->
	<footer> <jsp:include page="/include/footer.jsp"/> </footer>

</body>
</html>