<%@page import="com.sneaker.SneakerDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title> 관리자페이지 - 신발추가하기 </title>
<link rel="shortcut icon" href="/Project/images/icon/favicon.ico" />
<link rel="stylesheet" href="/Project/css/main.css">
<style>
	form ul { list-style: none;}
	form ul li { margin: 15px;}
</style>
	<%
		String admin = (String) session.getAttribute("ID");
		if( admin == null) {
			response.sendRedirect("/Project/member/loginForm.jsp");
		}
	%>
</head>
<body>

	<!-- Header -->
	<header>
		<jsp:include page="/include/header.jsp" />
	</header>
	<!-- Main -->
    <div id="main_border">
   		<div id="main_content">
    		<div id="bb_contentWrap" style="width:100%;">
				<div style="margin: 20px 0">
			    	<button onclick="location.href='/Project/admin/admin_page.jsp'"> 뒤로가기 </button>
			    </div>

				<div id="bb_content">		
	   				<div class="board_list">
						<h2>새로운 신발 추가하기 페이지</h2> <br>
						<fieldset> 
							<legend> 기본정보 & 이미지 업로드 하기 </legend>
							<form action="/Project/UploadServlet" method="post" enctype="multipart/form-data">
								<ul>
									<li> 브랜드 : <input type="text" name="brand"> </li>
									<li> 서브 브랜드 : <input type="text" name="sub_brand"> </li>
									<li> 브랜드인덱스 : <input type="text" name="brand_index"> </li>
									<li> 스니커이미지 : <input type="file" name="sneaker_image"> </li>
									<li> 스타일 넘버 : <input type="text" name="model_stylecode"> </li>
									<li> 모델명 : <input type="text" name="model_name"> </li>
									<li> 컬러명 : <input type="text" name="model_colorway"> </li>
									<li> 발매가 : <input type="text" name="original_price"> </li>
									<li> 시장가 : <input type="text" name="market_price"> </li>
									<li> <input type="submit" value="추가하기"> </li>
								</ul>
								
							</form>
						</fieldset>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- FOOTER -->
	<footer>
		<jsp:include page="/include/footer.jsp" />
	</footer>


</body>
</html>