<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="/Project/css/include/header.css">
<link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Racing+Sans+One&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Anton&display=swap" rel="stylesheet">

	<%
		String id = (String) session.getAttribute("ID");
		if(id  == null) {
			response.sendRedirect("/Project/member/loginForm.jsp");
		}	
	%>

</head>

	<!-- 전체 해더 -->
	<div id="header">
		<!-- 첫번째 해더 -->
		<div id="first_header"> 
			<div class="inner">
				<!-- 보드들 모은 파트 (왼쪽 상단) -->
				<div class="upboard">
					<ul>
						<li> <a href="/Project/board/Noticeboard/Noticeboard_list.jsp"> 공지사항 </a> </li>
						<li> <a href="#">  Q/A  </a> </li>
						<li> <a href="#"> 이벤트 </a> </li>
						<li> <a href="/Project/board/board_allList.jsp" style="color:#151192; font-weight: bold;"> 전체 글보기 </a> </li>
					</ul>
				</div>
				<!-- 로그인 파트 (오른쪽 상단) -->
				<div class="uplogin">
					<ul>
						<%
							//만약 로그인이 안되어있다면 밑에 메뉴들을 보여주고
							if( id == null) {
						%>
							<li> <a href="/Project/member/joinForm.jsp"> 회원가입 </a> </li>
							<li> <a href="/Project/member/loginForm.jsp"> 로그인 </a> </li>
						<%
							//만약 로그인한 사람이 'admim(관리자)'라면 
							} else if( id.equals("admin")) {
						%>
							<li> <a href="/Project/admin/admin_page.jsp" style="color: #00BB36; font-weight: bold;"> (관리자 권한 페이지로 바로가기) </a> </li>
							<li> <a href="/Project/member/locker/my_locker.jsp" style="color: #FE9501; font-weight: bold;"> 나의 신발장 </a> </li>
							<li> <a href="/Project/member/updatePwCheckForm.jsp"> 회원정보 수정 </a> </li>
							<li> <a href="/Project/member/logout.jsp"> 로그아웃 </a> </li>
						<%
							//관리자 외에 일반 사용자가 로그인 하였다면 밑에 메뉴들을 보여줘라
							} else {
						%>
							<li> <a href="/Project/member/locker/my_locker.jsp" style="color: #FE9501; font-weight: bold;"> 나의 신발장 </a> </li>
							<li> <a href="/Project/member/updatePwCheckForm.jsp"> 회원정보 수정 </a> </li>
							<li> <a href="/Project/member/logout.jsp"> 로그아웃 </a> </li>
						<%
							}
						%>
					</ul>
				</div>
			</div>		
		</div>
		
		<!-- 로고   style="background-image: url('/Project/images/main_banner.jpg'); filter: brightness(50%);" --> 
		<div>
			<div id="logo">
					<a href="/Project/index.jsp"> sneaker House </a>
			</div>
		</div>
		
		<!-- 두번째 해더  -->
		<div id="topmenu" style="position: relative; top: 0px;">
			<div id="category">
				<div class="position">
					<ul>
						<li> <a href="#"> 발매정보 </a> 
								<div class="sub-category">
									<ul>
										<li> <a href="/Project/board/Relboard/Relboard_list.jsp"> 확정/예정 </a> </li>
										<li> <a href="/Project/board/Ruboard/Ruboard_list.jsp"> 루머/미정 </a> </li>
									</ul>
								</div>
						</li>
						<li> <a href="#"> 캘린더(미정) </a> </li>
						<li> <a href="#"> 정/가품(미정) </a> 
								<div class="sub-category">
									<ul>
										<li> <a href="#"> 상세정보 </a> </li>
										<li> <a href="#"> 문의하기 </a> </li>
									</ul>
								</div>
						</li>
						<li> <a href="#"> 착샷/신발장 </a> 
								<div class="sub-category">
									<ul>
										<li> <a href="/Project/board/Onfootboard/Onfootboard_list.jsp"> 스니커착샷 </a>  </li>
										<li> <a href="/Project/board/Lockerboard/Lockerboard_list.jsp"> 신발장 </a>  </li>
										<li> <a href="/Project/board/Celeboard/Celeboard_list.jsp"> 셀럽들 </a>  </li>
									</ul>
								</div>
						</li>
						<li> <a href="#"> 장터(미정) </a> 
								<div class="sub-category">
									<ul>
										<li> <a href="#"> 나이키/조던 </a> </li>
										<li> <a href="#"> 아디다스 </a> </li>
										<li> <a href="#"> 타브랜드 </a>  </li>
									</ul>
								</div>
						</li>
					</ul>
				</div>
			</div>
		</div>	
	</div>

</html>