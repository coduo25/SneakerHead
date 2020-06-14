<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title> SneakerHouse 로그인</title>
<link rel="shortcut icon" href="/Project/images/icon/favicon.ico" />
<link rel="stylesheet" href="/Project/css/member/loginForm.css">
</head>
<body>
	<!-- 로그인 페이지 화면 --> 
	<!-- Header -->
    <header> <jsp:include page="/include/header.jsp" /> </header>

	<div id="main_content"> 
		<div id="contentWrap">
				<div id="content">
					<div id="loginWrap">	
						<div id="page-body"> 
							
							<div class="mlog-sign">
								<div class="mlog">
									<!-- 로그인 영역 -->
									<h3> 회원 로그인 </h3>
									<p>
										가입하신 아이디와 비밀번호를 입력해주세요. <br>
										비밀번호는 대소문자를 구분합니다. <br>
									</p>
									<fieldset>
										<form action="loginPro.jsp" method="post" name="form1">
											<legend> member login </legend>
											<ul class="frm-list">
												<li class="id">
<!-- 													<label> 아이디 </label> -->
													<input type="text" name="id" class="MS_login_id" onblur="document.form1.passwd.focus();" placeholder="MEMBER ID" maxlength="20" autofocus required>
												</li>
												<li class="pwd">
<!-- 													<label> PASSWORD </label> -->
													<input type="password" name="pass" class="MS_login_pw" placeholder="PASSWORD" maxlength="20" required>
											</ul>
											<div class="btn-mlog">
												<input type="submit" value="LOG-IN" class="CSSbuttonBlack">
											</div>
										</form>
									</fieldset>
<!-- 									<form action="loginPro.jsp" method="post"> -->
<!-- 										<input type="text" name="id"> <br>  -->
<!-- 										<input type="password" name="pass"> <br> -->
<!-- 										<input type="submit" value="LOG-IN"> -->
<!-- 									</form> -->
							
								</div>

								
								<div class="sign">
									<!-- 회원가입 영역 -->
									<h3> 회원가입 </h3>
									<dl> 
										<dt> 아직 회원이 아니신가요? <br>
										회원가입을 하시면 다양한 혜택을 편리하게 이용하실 수 있습니다. 
										</dt>
										<dd>
											<a href="joinForm.jsp" class="CSSbuttonWhite"> JOIN-US </a>
										</dd>
									</dl>
									<dl>
										<dt> 아이디 혹은 비밀번호를 잊으셨나요? <br>
										간단한 정보를 입력 후 잃어버린 정보를 찾으실 수 있습니다. 
										</dt>
										<dd>
											<a href="" class="CSSbuttonWhite"> ID/PASSWORD(미정) </a>
										</dd>
									</dl>
								</div>
								
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


