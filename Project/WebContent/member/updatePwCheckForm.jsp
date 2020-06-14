<%@page import="com.member.MemberDTO"%>
<%@page import="com.member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<title> 회원수정 - 비밀번호 확인</title>
<link rel="shortcut icon" href="/Project/images/icon/favicon.ico" />
<link rel="stylesheet" href="/Project/css/member/joinForm.css">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>
<script type="text/javascript">

	var passCheck;

	//기존의 비밀번호가 맞는지 체크하는 함수
	function checkCorrectPW() {
		$.ajax({
			type:"post",
			url:"/Project/member/checkPWPro.jsp",
			data: { "member_id":$('#member_id').val(),"pass":$('#pass').val()},
			success: function(data) {
				if($.trim(data) == "YES") {
					passCheck = true;
				} else {
					passCheck = false;
				}
			}, error: function(data) {
				alert("에러");
			}
		});
	}
	
	//비밀번호를 올바르게 썼다면 넘어가기/아니면 함수 멈춤
	function checkAllValue() {
		//비밀번호 값이 입력되지 않았다면
    	if(!document.updateForm.pass.value){
    		alert("비밀번호를 입력해주세요.");  
    	    document.updateForm.pass.focus();   
    	    return false;
    	}
    	//비밀번호 값이 입력되었다면
    	else if(document.updateForm.pass.value) {
    		//passCheck 변수가 false이면 함수 멈춤
    		if(passCheck == false) {
    			alert("비밀번호가 맞지 않습니다.");
    			document.updateForm.pass.focus(); 
    			return false;
    		} 
    	}
	}

	
	//수정하기 취소 버튼 눌렸을시 메인페이지로 돌아가기
	function joinCancel() {
		location.href="/Project/index.jsp";
	}

</script>

	<%
		request.setCharacterEncoding("UTF-8");
	
		String member_id = (String) session.getAttribute("ID");
		
		if(member_id == null) {
			response.sendRedirect("/Project/member/loginForm.jsp");
		}
	
		MemberDAO mdao = new MemberDAO();
		MemberDTO mdto = mdao.getMemberInfo(member_id);	
	%>
<body>

<!-- Header -->
    <header> <jsp:include page="/include/header.jsp" /> </header>

	<!-- Main -->
	<div id="something">
		<div id ="wrap">
			<div id="container">
				<div id="contents1" style="width: 400px;">
					<!-- 소제목 부분 -->
					<div class="titleArea">
						<h2> 회원 아이디/비밀번호 확인 </h2>
					</div>
					<!-- 아이디/비밀번호 form 부분 -->
					<form id="joinForm" name="updateForm" action="/Project/member/updateForm.jsp" method="post" onsubmit="return checkAllValue()">
						<div class="xans-member-join">
							<div class="ec-base-table typeWrite">
								<table border="1" summary>
									<tbody>
										<tr> 
											<th scope="row"> 아이디 <img src="http://img.echosting.cafe24.com/skin/base/common/ico_required.gif" alt="필수" > </th> 
											<td> <input type="text" id="member_id" name="id" class="inputTypeText" value="<%= mdto.getId() %>" readonly> </td>
										</tr>
										<tr> 
											<th scope="row"> 비밀번호 <img src="http://img.echosting.cafe24.com/skin/base/common/ico_required.gif" alt="필수" > </th> 
											<td> <input type="password" id="pass" name="pass" class="inputTypeText" onkeyup="checkCorrectPW()"> </td>
										</tr>
										<input type="hidden" name="name" id="name" maxlength="20" value="<%= mdto.getName() %>">
										<input type="hidden" id="postcode" name="postcode" value="<%= mdto.getPostcode() %>" >
										
										<input type="hidden" id="addr1" name="addr1" value="<%= mdto.getAddr1() %>">
										<input type="hidden" id="addr2" name="addr2" value="<%= mdto.getAddr2() %>">
										<input type="hidden" id="addr3" name="addr3" value="<%= mdto.getAddr3() %>">
										
										<input type="hidden" id="mobile1" name="mobile1" value="<%= mdto.getMobile1() %>">
										<input type="hidden" id="mobile2" name="mobile2" maxlength="4" value="<%= mdto.getMobile2() %>">
										<input type="hidden" id="mobile3" name="mobile3" maxlength="4" value="<%= mdto.getMobile3() %>">
										
										<input type="hidden" id="email" name="email" value="<%= mdto.getEmail() %>">
										
									</tbody>
								</table>
							</div>
							<!-- 확인/ 취소 버튼 -->
							<div class="ec-base-button">
								<span class="btbt5"> 
									<input class="rkd" type="submit" value="수정하기"> 
								</span>
								<span class="btbt5"> 
									<input class="rkd2" type="reset" value="수정하기 취소" onclick="joinCancel()"> 
								</span>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	
	<!-- FOOTER -->
	<footer> <jsp:include page="/include/footer.jsp"/> </footer>

</body>
</html>