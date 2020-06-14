<%@page import="com.member.MemberDAO"%>
<%@page import="com.member.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title> 회원수정</title>
<link rel="shortcut icon" href="/Project/images/icon/favicon.ico" />
<link rel="stylesheet" href="/Project/css/member/joinForm.css">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	
	//중복체크 및  조건에 부합했을때의 결과값을 담기위한 변수들
	var emailCheck;
	var passCheck;
	var passDoubleCheck;
	
	//비밀번호 유효성검사 함수
	function checkValidPW() {
		//비밀번호 조건에 부합하지 않으면
		if(!/^(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,25}$/.test($('#pass').val())){            
	        $('#pwConstraintMsg').text('사용 할 수 없는 비밀번호 입니다.').css({'color':'red', 'font-size':12});
	        $('#pass').val($('#pass').val()).focus();
	        passCheck = false;
	    } 
		//비밀번호 조건에 부합한다면
		else if(/^(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,25}$/.test($('#pass').val())) {
	    	$('#pwConstraintMsg').text('✔').css({'color':'green', 'font-size':16});
	    	passCheck = true;
	    }
	}
	
	//비밀번호와 비밀번호확인란이 같은지 검사하는 함수
	function checkSamePW() {
		//비밀번호와 비밀번호확인란이 같지 않으면
		if(document.updateForm.pass.value != document.updateForm.user_pass_confirm.value ){
			$('#pwConfirmMsg').text(' 비밀번호가 다릅니다.').css({'color':'red', 'font-size':12});
			$('#user_pass_confirm').val($('#user_pass_confirm').val()).focus();
			passDoubleCheck = false;
        }
		//비밀번호와 비밀번호확인란이 같으면
		else {
	    	$('#pwConfirmMsg').text('✔').css({'color':'green', 'font-size':16});	
	    	passDoubleCheck = true;
	    }
	}

	//주소 API
	function sample4_execDaumPostcode() {
	    new daum.Postcode({
	        oncomplete: function(data) {
	            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	            var addr = ''; // 주소 변수
	            var extraAddr = ''; // 참고항목 변수
	
	            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                addr = data.roadAddress;
	            } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                addr = data.jibunAddress;
	            }
	
	            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	            if(data.userSelectedType === 'R'){
	                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                    extraAddr += data.bname;
	                }
	                // 건물명이 있고, 공동주택일 경우 추가한다.
	                if(data.buildingName !== '' && data.apartment === 'Y'){
	                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                }
	                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                if(extraAddr !== ''){
	                    extraAddr = ' (' + extraAddr + ')';
	                }
	                // 조합된 참고항목을 해당 필드에 넣는다.
	                document.getElementById("addr3").value = extraAddr;
	            
	            } else {
	                document.getElementById("addr3").value = '';
	            }
	
	            // 우편번호와 주소 정보를 해당 필드에 넣는다.
	            document.getElementById('postcode').value = data.zonecode;
	            document.getElementById("addr1").value = addr;
	            // 커서를 상세주소 필드로 이동한다.
	            document.getElementById("addr2").focus();
	        }
	    }).open();
	}

	//모든정보가 입력되고 함수들이 true인 경우 회원가입 하나라도 false이면 submit X
    function checkAllValue() {
    	
    	// ---------------------비밀번호---------------------------------------------------------------------
    	//비밀번호 값이 입력되지 않았다면
    	if(!document.updateForm.pass.value){
    		alert("필수 항목을 입력해주세요.");  
    	    document.updateForm.pass.focus();   
    	    return false;
    	}
    	//비밀번호 값이 입력되었다면
    	else if(document.updateForm.pass.value) {
    		//passCheck 변수가 false이면 함수 멈춤
    		if(passCheck == false) {
    			alert("조건에 맞는 비밀번호를 입력해주세요.");
    			document.updateForm.pass.focus(); 
    			return false;
    		} 
    	}
    	
    	// ---------------------비밀번호체크란---------------------------------------------------------------------
    	//비밀번호체크 값이 입력되지 않았다면
    	if(!document.updateForm.user_pass_confirm.value){
    		alert("비밀번호 체크란을 입력하세요"); 
    	    document.updateForm.user_pass_confirm.focus();   
    	    return false;
    	}
    	//비밀번호체크 값이 입력되었다면
    	else if(document.updateForm.user_pass_confirm.value) {
    		//passDoubleCheck 변수가 false이면 함수 멈춤
    		if(passDoubleCheck == false) {
    			document.updateForm.user_pass_confirm.focus();
    			alert("비밀번호 확인란이 같지 않습니다.");
    			return false;
    		} 
    	}
    	
    	// ---------------------이름---------------------------------------------------------------------
    	//이름 값이 입력되지 않았다면
    	if(!document.updateForm.name.value){
    		alert("필수 항목을 입력해주세요.");  
    	    document.updateForm.name.focus();   
    	    return false; 
    	}
    	
    	// ---------------------주소---------------------------------------------------------------------
    	//주소 값이 입력되지 않았다면
    	if(!document.updateForm.postcode.value || !document.updateForm.addr1.value || !document.updateForm.addr3.value){
    		alert("필수 항목을 입력해주세요.");  
    		sample4_execDaumPostcode();
    	    return false; 
    	}
    	
    	// ---------------------휴대전화---------------------------------------------------------------------
    	//휴대전화값이 입력되지 않앗다면
    	if(!document.updateForm.mobile2.value){
    		alert("필수 항목을 입력해주세요.");
    		document.updateForm.mobile2.focus();   
    	    return false; 
    	}
    	if(!document.updateForm.mobile3.value){
    		alert("필수 항목을 입력해주세요.");
    		document.updateForm.mobile3.focus();   
    	    return false; 
    	}
    	
    	//수정 최종확인
    	var updateCheck = confirm("정보를 수정하시겠습니까?");
    	if(!updateCheck) {
    		return false;
    	}
    }
    
    //탈퇴하기 버튼 눌렸을때
    function memberDelAction() {
    	// ---------------------비밀번호---------------------------------------------------------------------
    	//비밀번호 값이 입력되지 않았다면
    	if(!document.updateForm.pass.value){
    		alert("비밀번호를 입력하세요");  //메시지 표시
    	    document.updateForm.pass.focus();   
    	    return false;
    	}
    	//비밀번호 값이 입력되었다면
    	else if(document.updateForm.pass.value) {
    		//비밀번호 값이 조건에 부합하지 않는다면
    		if(!/^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,25}$/.test($('#pass').val())) {
    			alert("비밀번호가 조건에 맞지 않습니다")
    			document.updateForm.pass.focus();   
        	    return false;
    		}
    	}
    	
    	// ---------------------비밀번호체크란---------------------------------------------------------------------
    	//비밀번호체크 값이 입력되지 않았다면
    	if(!document.updateForm.user_pass_confirm.value){
    		alert("비밀번호 체크란을 입력하세요");  //메시지 표시
    	    document.updateForm.user_pass_confirm.focus();   
    	    return false;
    	}
    	//비밀번호체크 값이 입력되었다면
    	else if(document.updateForm.user_pass_confirm.value) {
    		//비밀번호와 비밀번호 체크값이 동일하지 않다면
    		if(document.updateForm.pass.value != document.updateForm.user_pass_confirm.value) {
    			alert("동일한 비밀번호를 입력하세요")
    			document.updateForm.user_pass_confirm.focus();   
        	    return false;
    		}
    	}
		
    	//탈퇴하기 최종확인란 True 이면 삭제 Pro로 넘어가기/False이면 함수 멈춤
    	var deleteCheck = confirm("모든 정보를 삭제하고 탈퇴 하시겠습니까?");
    	if(deleteCheck) {
    		//위 모든 함수가 전부 true이면
       		$.ajax({
           		type:"post",
           		url:"/Project/member/deletePro.jsp",
           		data:{"id":$('#member_id').val(), "pass":$('#pass').val()},
           		success:function(data) {
           			if($.trim(data) == "YES") {
           				alert("회원님의 모든 데이터를 삭제하고 탈퇴 성공하셨습니다.");
          		     	location.href='/Project/main/main.jsp';
          		     	return true;
           			} else if($.trim(data) == "PASS") {
           				alert("올바른 비밀번호를 입력해주세요.");
           				return false;
           			} else {
           				alert("존재하지 않는 아이디입니다.");
           				return false;
           			}
           		}, error: function(data) {
           			alert("실패");
           		}
           	});
    	} else {
    		return false;
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

</head>
<body>

	<!-- Header -->
    <header> <jsp:include page="/include/header.jsp" /> </header>

	<!-- Main -->
	<div id="something">
		<div id ="wrap">
			<div id="container">
				<div id="contents1">
					<!-- 소제목 부분 -->
					<div class="titleArea">
						<h2> 회원 정보 수정 </h2>
					</div>
					<!-- 회원가입 form 부분 -->
					<form id="joinForm" name="updateForm" action="/Project/member/updatePro.jsp" method="post" onsubmit="return checkAllValue()">
						<div class="xans-member-join">
							<h3> 기본 정보</h3>
							<p class="required"> <img src="http://img.echosting.cafe24.com/skin/base/common/ico_required.gif" alt="필수"> 필수입력사항 </p>
							<div class="ec-base-table typeWrite">
								<table border="1" summary>
									<tbody>
										<tr> 
											<th scope="row"> 아이디 <img src="http://img.echosting.cafe24.com/skin/base/common/ico_required.gif" alt="필수" > </th> 
											<td> <input type="text" id="member_id" name="id" class="inputTypeText" value="<%= mdto.getId() %>" readonly> (영문 소문자/숫자를 포함, 4~16자) &nbsp; <span id="idConstraintMsg"></span> </td>
										</tr>
										<tr> 
											<th scope="row"> 비밀번호 <img src="http://img.echosting.cafe24.com/skin/base/common/ico_required.gif" alt="필수" > </th> 
											<td> <input type="password" id="pass" name="pass" class="inputTypeText" onkeyup="checkValidPW()"> (영문 대소문자/숫자/특수문자 3가지 이상 조합, 8자리 이상) &nbsp; <span id="pwConstraintMsg"></span> </td>
										</tr>
										<tr> 
											<th scope="row"> 비밀번호 확인 <img src="http://img.echosting.cafe24.com/skin/base/common/ico_required.gif" alt="필수" > </th> 
											<td> <input type="password" id="user_pass_confirm" name="user_pass_confirm" onkeyup="checkSamePW()" class="inputTypeText"> &nbsp; <span id="pwConfirmMsg"></span> </td>
										</tr>
										<tr>
											<th scope="row"> 이름 <img src="http://img.echosting.cafe24.com/skin/base/common/ico_required.gif" alt="필수" > </th>
											<td> <input type="text" name="name" id="name" maxlength="20" value="<%= mdto.getName() %>" > </td>
										</tr>
										<tr>
											<th scope="row"> 주소 <img src="http://img.echosting.cafe24.com/skin/base/common/ico_required.gif" alt="필수" > </th>
											<td> 
												<input type="text" id="postcode" name="postcode" value="<%= mdto.getPostcode() %>" onclick="sample4_execDaumPostcode()" > <img src="http://img.echosting.cafe24.com/skin/base_ko_KR/member/btn_zipcode.gif" onclick="sample4_execDaumPostcode()"> 
												<br>
												<input type="text" id="addr1" name="addr1" value="<%= mdto.getAddr1() %>"> 기본 도로명 
												<br>
												<input type="text" id="addr3" name="addr3" value="<%= mdto.getAddr3() %>"> <input type="text" id="addr2" name="addr2" <% if(mdto.getAddr1() == null) { %> value="" <% } else { %> value="<%= mdto.getAddr2() %>" <% } %>> 상세주소
											</td>
										</tr>
										<tr>
											<th scope="row"> 휴대전화 <img src="http://img.echosting.cafe24.com/skin/base/common/ico_required.gif" alt="필수" > </th>
											<td> 
												<select id="mobile1" name="mobile1" value="<%= mdto.getMobile1() %>">
													<option value="010"> 010 </option>
													<option value="011"> 011 </option>
													<option value="016"> 016 </option>
													<option value="017"> 017</option>
													<option value="018"> 018 </option>
													<option value="019"> 019 </option>
												</select> 
												-
												<input type="text" id="mobile2" name="mobile2" maxlength="4" value="<%= mdto.getMobile2() %>">
												-
												<input type="text" id="mobile3" name="mobile3" maxlength="4" value="<%= mdto.getMobile3() %>">
											</td>
										</tr>
										<tr>
											<th scope="row"> 이메일 <img src="http://img.echosting.cafe24.com/skin/base/common/ico_required.gif" alt="필수" > </th>
											<td> <input type="text" id="email" name="email" value="<%= mdto.getEmail() %>" readonly> <span id="emailMsg"></span> </td>
										</tr>
									</tbody>
								</table>
							</div>
							<!-- 회원가입/회원가입 취소 버튼 -->
							<div class="ec-base-button">
								<span class="btbt5"> 
									<input class="rkd" type="submit" value="수정하기"> 
								</span>
								<span class="btbt5"> 
									<input class="rkd2" type="reset" value="수정하기 취소" onclick="joinCancel()"> 
								</span>
								
								<!-- 탈퇴하기 버튼 -->
								<span class="gRight">
									<a href="" onclick="memberDelAction()">
										<img src="http://img.echosting.cafe24.com/skin/base_ko_KR/member/btn_modify_out.gif" alt="회원탈퇴">
									</a>
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