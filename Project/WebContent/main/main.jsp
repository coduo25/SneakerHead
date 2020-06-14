<%@page import="com.board.OnFootDTO"%>
<%@page import="com.board.BoardDTO"%>
<%@page import="com.board.BoardDAO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head> 
<title> SneakerHouse </title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="shortcut icon" href="/Project/images/icon/favicon.ico" />
<link rel="stylesheet" href="/Project/css/main.css">
<link rel="stylesheet" href="/Project/css/bootstrap.css">
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic|Nanum+Gothic+Coding&display=swap" rel="stylesheet">
<!-- Fontawesome 사이트에서 아이콘 쓰기 위한 스크립트 파일 -->
<script src="https://kit.fontawesome.com/febeeb992c.js" crossorigin="anonymous"></script>

<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="../js/bootstrap.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>

<script type="text/javascript">
	var index = 0;
	window.onload = function() {
		slideShow();
	}
	
	function slideShow() {
		var i;
		var x = document.getElementsByClassName("slide1");
		for(i=0;i<x.length;i++) {
			x[i].style.display = "none";
		}
		index++;
		if(index > x.length) {
			index = 1;
		}
		x[index-1].style.display = "block";
		setTimeout(slideShow, 5000);
	}
</script>

	<%
		//session ID값 가져오기
		String member_id = (String) session.getAttribute("ID");
		
		//개수를 계산해오는 메서드 구현
		//Board DB처리 객체 생성 BoardDAO()
		BoardDAO bdao = new BoardDAO();
		String board_type = "발매";
		int count = bdao.getSpecialBoardCount(board_type);
		
		//////////////////////////////////////////////////////
		//페이징 처리
		//한페이지에서 보여줄 글의 개수
		int pageSize = 8;
		
		//페이지 정보
		String pageNum = request.getParameter("pageNum");
		
		if(pageNum == null) { //데이터를 가지고 올때 항상 Null인지 아닌지 확인해야하는 습관을 들여야한다. 
			pageNum = "1";	//최신페이지를 보여주는 동작
		}
		
		//첫행 계산
		int currentPage = Integer.parseInt(pageNum);
		int startRow = (currentPage - 1) * pageSize + 1;
		//////////////////////////////////////////////////////
	%>

<body>
    <!-- Header -->
    <header> <jsp:include page="/include/header.jsp" /> </header>

	<!-- Main -->
    <div id="main_border">
    
		<div id="slider">
			<div id="box">
				<img class="slide1" src="/Project/images/main/scott dunk banner.jpg" style="display:none;">
				<a href="https://xxblue.com" target="_blank"> <img class="slide1" src="/Project/images/main/XXBLUE banner.jpg" style="display:none;"> </a>
				<a href="https://www.nike.com/kr/launch/t/men/fw/basketball/CT8480-001/shpz30/air-jordan-5-retro-sp"  target = "_blank"> <img class="slide1" src="/Project/images/main/offwhite jordan 52.jpg" style="display:none;"> </a>
			</div>
		</div>
   		
		<!-- 게시판 -->
   		<div id="main_content">
   		
   			<!-- 게시판 파트 -->
    		<div id="bb_contentWrap">
				<div id="bb_content">		
	   				<div class="board_list">
	   					<!-- 메인게시판 테이블 -->
						<div class="base_table">
							<table class="main_table_collection">
								<thead>
									<tr class="header_table_collection">
						    			<th colspan="5" style="padding-left: 12px;"> <i class="fas fa-align-justify"></i> &nbsp; 발매정보게시판 <a href="/Project/board/Relboard/Relboard_list.jsp" style=" float: right; padding-right: 12px; color: inherit; text-decoration: none;">  <i class="fas fa-plus"></i> 더보기  </a> </th>
						    			
					    			</tr>
								</thead>
								
					    		<tbody>
					    			<!-- 게시판 글 리스트 뿌리기  -->
						    		<%
					    				List<BoardDTO> boardList = null;
				    					if(count != 0) { //DB안에 글이 있으면 보여지게 된다. 
				    						//DB에서 정보를 가져오기 (메서드)
				    						boardList = bdao.getSpecialBoardList(startRow, pageSize, board_type);
				    						//정보의 개수 만큼 페이지에 반복 출력
				    						int size = boardList.size();
											for(int i=0; i<size; i++) {
				    							BoardDTO bdto = boardList.get(i); //한칸을 꺼내서 RuBoardDTO 타입의 객체에 저장
					    			%>
						    		<tr class="content_table_collection">
						    			<td> <%= bdto.getRe_ref() %>  </td>
						    			<td class="main_content"><a href="/Project/board/Relboard/Relboard_content.jsp?board_type=<%=bdto.getBoard_type()%>&re_ref=<%=bdto.getRe_ref()%>&pageNum=<%=pageNum%>&name=<%=bdto.getMember_id()%>"> <span class="main_Rel_title"> <%= bdto.getSubject() %> </span> </a> </td>
						    			<td> <%= bdto.getMember_id() %> </td>
						    			<td> <%= bdto.getDate() %> </td>
						    			<td> <%= bdto.getReadcount() %> </td>
						    		</tr>
						    		<%
				    						}
				    					}
						    		%>
					    		</tbody>
				    		</table>
						</div>
	   				</div>
   				</div>
    		</div>
    		
    		<!-- 동영상 파트 -->
	    	<div id="vid_contentWrap">
	    		<div id="bb_content">		
	   				<div class="board_list">
	   					<!-- 메인게시판 테이블 -->
						<div class="base_table">
							<table class="main_table_collection">
								<thead>
									<tr class="header_table_collection">
						    			<th style="padding-left: 12px;"> <i class="fas fa-video"></i> &nbsp; 스니커 영상 </th>
					    			</tr>
								</thead>
								<tbody>
									<tr> 
										<td> <iframe width="635" height="322" src="https://www.youtube.com/embed/BTbIiKH2Ews" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe> </td>
									</tr>
								</tbody>
				    		</table>
						</div>
	   				</div>
   				</div>
	    	</div>
	    	
	    <%		
			//개수를 계산해오는 메서드 구현
			String board_type2 = "착샷";
			int count2 = bdao.getSpecialBoardCount(board_type2);
			
			//////////////////////////////////////////////////////
			//페이징 처리
			//한페이지에서 보여줄 글의 개수
			int pageSize2 = 6;
			
			//페이지 정보
			String pageNum2 = request.getParameter("pageNum");
			
			if(pageNum2 == null) { //데이터를 가지고 올때 항상 Null인지 아닌지 확인해야하는 습관을 들여야한다. 
				pageNum2 = "1";	//최신페이지를 보여주는 동작
			}
			
			//첫행 계산
			int currentPage2 = Integer.parseInt(pageNum2);
			int startRow2 = (currentPage2 - 1) * pageSize2 + 1;
			//////////////////////////////////////////////////////
		%>
	    	
	    	<!-- 착샷 갤러리 파트 -->
	    	<div id="img_contentWrap">
    			<div id="bb_content">
    				<!-- 게시판 파트 -->
    				<div class="board_list">
    					<!-- 메인게시판 테이블 -->
						<div class="base_table">
							<table class="main_table_collection">
								<thead>
									<tr class="header_table_collection">
						    			<th style="padding-left: 12px;" colspan="2"> <i class="fas fa-images"></i> &nbsp; 스니커 착샷 갤러리 <a href="/Project/board/Onfootboard/Onfootboard_list.jsp" style="float: right; color: inherit; text-decoration: none; padding-right: 12px;"> <i class="fas fa-plus"></i> 더보기 </a>   </th>
					    			</tr>
								</thead>
							</table>
			    				<% 
				    				List<BoardDTO> boardList2 = null;
			    					if(count != 0) { //DB안에 글이 있으면 보여지게 된다. 
			    					
			    						//DB에서 정보를 가져오기 (메서드)
			    						boardList2 = bdao.getSpecialBoardList(startRow2, pageSize2, board_type2);
			    						
			    						//정보의 개수 만큼 페이지에 반복 출력
			    						int size = boardList2.size();

										for(int i=0; i<size; i++) {
			    							BoardDTO bdto = boardList2.get(i); //한칸을 꺼내서 RuBoardDTO 타입의 객체에 저장
			    							//썸네일 가지고 오는 함수
							    			OnFootDTO ofdto = bdao.substringimg(bdto.getBoard_type(), bdto.getRe_ref());
			    							
							    			String fullname = ofdto.getNewFileName();
			    							String src = "/Project/editorImageUpload/";
			    							int target_num = fullname.indexOf(src);
			    							String result;
			    							result = fullname.substring(target_num, (fullname.substring(target_num).indexOf("\" title")+target_num));
			    				%>
			    						<div class="sub_photo">
											<ul>
												<li>
													<div class="thmb-wrapper">
														<!-- 글의 이미지 -->
														<div class="thmb">
															<div class="thmb-centered">
																<a href="/Project/board/Onfootboard/Onfootboard_content.jsp?board_type=<%=bdto.getBoard_type()%>&re_ref=<%=bdto.getRe_ref()%>&pageNum=<%=pageNum%>&name=<%=bdto.getMember_id()%>"> 
																	<img src="<%= result %>" style="object-fit:contain;"> 
																</a>
															</div>
														</div>
													</div>
													
													<!-- 글의 제목 -->
													<a href="/Project/board/Onfootboard/Onfootboard_content.jsp?board_type=<%=bdto.getBoard_type()%>&re_ref=<%=bdto.getRe_ref()%>&pageNum=<%=pageNum%>&name=<%=bdto.getMember_id()%>" style="color: inherit; text-decoration: none;"> <strong> <%= bdto.getSubject() %> </strong></a>
													<p class="tx_member" style="font-size:14px;"> <%= bdto.getMember_id() %>
													<p class="tx_brief"> <%= bdto.getDate() %>  &nbsp; &middot; 조회 <%= bdto.getReadcount() %> </p>
												</li>
											</ul>
										</div>
					    		<%
			    						}
			    					}
					    		%>
						</div>
    				</div>
    			</div>
			</div>
			
		<%		
			//개수를 계산해오는 메서드 구현
			String board_type3 = "신발장";
			int count3 = bdao.getSpecialBoardCount(board_type3);
			
			//////////////////////////////////////////////////////
			//페이징 처리
			//한페이지에서 보여줄 글의 개수
			int pageSize3 = 6;
			
			//페이지 정보
			String pageNum3 = request.getParameter("pageNum");
			
			if(pageNum3 == null) { //데이터를 가지고 올때 항상 Null인지 아닌지 확인해야하는 습관을 들여야한다. 
				pageNum3 = "1";	//최신페이지를 보여주는 동작
			}
			
			//첫행 계산
			int currentPage3 = Integer.parseInt(pageNum3);
			int startRow3 = (currentPage3 - 1) * pageSize3 + 1;
			//////////////////////////////////////////////////////
		%>
			
			<!-- 신발장 갤러리 파트 -->
	    	<div id="locker_contentWrap">
    			<div id="bb_content">
    				<!-- 게시판 파트 -->
    				<div class="board_list">
    					<!-- 메인게시판 테이블 -->
						<div class="base_table">
							<table class="main_table_collection">
								<thead>
									<tr class="header_table_collection">
						    			<th style="padding-left: 12px;" colspan="2"> <i class="fas fa-images"></i> &nbsp; 스니커 신발장 갤러리 <a href="/Project/board/Lockerboard/Lockerboard_list.jsp" style="float: right; color: inherit; text-decoration: none; padding-right: 12px;"> <i class="fas fa-plus"></i> 더보기 </a>   </th>
					    			</tr>
								</thead>
							</table>
			    				<% 
				    				List<BoardDTO> boardList3 = null;
			    					if(count != 0) { //DB안에 글이 있으면 보여지게 된다. 
			    					
			    						//DB에서 정보를 가져오기 (메서드)
			    						boardList3 = bdao.getSpecialBoardList(startRow3, pageSize3, board_type3);
			    						
			    						//정보의 개수 만큼 페이지에 반복 출력
			    						int size = boardList3.size();

										for(int i=0; i<size; i++) {
			    							BoardDTO bdto = boardList3.get(i); //한칸을 꺼내서 RuBoardDTO 타입의 객체에 저장
			    							//썸네일 가지고 오는 함수
							    			OnFootDTO ofdto = bdao.substringimg(bdto.getBoard_type(), bdto.getRe_ref());
			    							
							    			String fullname = ofdto.getNewFileName();
			    							String src = "/Project/editorImageUpload/";
			    							int target_num = fullname.indexOf(src);
			    							String result;
			    							result = fullname.substring(target_num, (fullname.substring(target_num).indexOf("\" title")+target_num));
			    				%>
			    						<div class="sub_photo">
											<ul>
												<li>
													<div class="thmb-wrapper">
														<!-- 글의 이미지 -->
														<div class="thmb">
															<div class="thmb-centered">
																<a href="/Project/board/Lockerboard/Lockerboard_content.jsp?board_type=<%=bdto.getBoard_type()%>&re_ref=<%=bdto.getRe_ref()%>&pageNum=<%=pageNum%>&name=<%=bdto.getMember_id()%>"> 
																	<img src="<%= result %>" style="object-fit:contain;"> 
																</a>
															</div>
														</div>
													</div>
													
													<!-- 글의 제목 -->
													<a href="/Project/board/Lockerboard/Lockerboard_content.jsp?board_type=<%=bdto.getBoard_type()%>&re_ref=<%=bdto.getRe_ref()%>&pageNum=<%=pageNum%>&name=<%=bdto.getMember_id()%>" style="color: inherit; text-decoration: none;"> <strong> <%= bdto.getSubject() %> </strong></a>
													<p class="tx_member" style="font-size:14px;"> <%= bdto.getMember_id() %>
													<p class="tx_brief"> <%= bdto.getDate() %>  &nbsp; &middot; 조회 <%= bdto.getReadcount() %> </p>
												</li>
											</ul>
										</div>
					    		<%
			    						}
			    					}
					    		%>
						</div>
    				</div>
    			</div>
			</div>

    </div>

	<!-- FOOTER -->
	<footer> <jsp:include page="/include/footer.jsp"/> </footer>
	
</body>

</html>