<%@page import="com.board.OnFootDTO"%>
<%@page import="com.board.BoardDTO"%>
<%@page import="com.board.BoardDAO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title> SneakerHouse 착샷 갤러리</title>
<link rel="shortcut icon" href="/Project/images/icon/favicon.ico" />
<link rel="stylesheet" href="/Project/css/board/board.css">
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic|Nanum+Gothic+Coding&display=swap" rel="stylesheet">
<!-- Fontawesome 사이트에서 아이콘 쓰기 위한 스크립트 파일 -->
<script src="https://kit.fontawesome.com/febeeb992c.js" crossorigin="anonymous"></script>

</head>
<body>

	<%
		//session ID값 가져오기
		String member_id = (String) session.getAttribute("ID");
		
		//개수를 계산해오는 메서드 구현
		//Board DB처리 객체 생성 BoardDAO()
		BoardDAO bdao = new BoardDAO();
		String board_type = "착샷";
		int count = bdao.getSpecialBoardCount(board_type);
		
		//////////////////////////////////////////////////////
		//페이징 처리
		//한페이지에서 보여줄 글의 개수
		int pageSize = 16;
		
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

	<!-- Header -->
    <header> <jsp:include page="/include/header.jsp" /> </header>
    
    <!-- Main -->
    <div id="main_border">
    	 <!-- 게시판 -->
   		<div id="main_content">
    		<div id="bb_contentWrap">
    			<div id="bb_content" style="width: 1100px;">
    				<!-- 게시판 파트 -->
    				<div class="board_list">
    					<!-- 소제목 -->
    					<div class="sub_title" > 
    						<h2> 스니커 착샷 게시판 </h2> 
    					</div>
    					<!-- 메인게시판 테이블 -->
						<div class="base_table">
							<table class="main_table_collection">
						    		<% 
					    				List<BoardDTO> boardList = null;
				    					if(count != 0) { //DB안에 글이 있으면 보여지게 된다. 
				    					
				    						//DB에서 정보를 가져오기 (메서드)
				    						boardList = bdao.getSpecialBoardList(startRow, pageSize, board_type);
				    						
				    						//정보의 개수 만큼 페이지에 반복 출력
				    						int size = boardList.size();

											for(int i=0; i<size; i++) {
				    							BoardDTO bdto = boardList.get(i); //한칸을 꺼내서 RuBoardDTO 타입의 객체에 저장
				    							//썸네일 가지고 오는 함수
								    			OnFootDTO ofdto = bdao.substringimg(bdto.getBoard_type(), bdto.getRe_ref());
				    							
								    			String fullname = ofdto.getNewFileName();
				    							String src = "/Project/editorImageUpload/";
				    							int target_num = fullname.indexOf(src);
				    							String result;
				    							result = fullname.substring(target_num, (fullname.substring(target_num).indexOf("\" title")+target_num));
					    						System.out.println("최종 자른 이름:" + result);
					    			%>
									<div class="sub_photo">
										<ul>
											<li>
												<div class="thmb-wrapper">
													<!-- 글의 이미지 -->
													<div class="thmb">
														<div class="thmb-centered">
															<a href="Onfootboard_content.jsp?board_type=<%=bdto.getBoard_type()%>&re_ref=<%=bdto.getRe_ref()%>&pageNum=<%=pageNum%>&name=<%=bdto.getMember_id()%>"> 
																<img src="<%= result %>" style="object-fit:contain;"> 
															</a>
														</div>
													</div>
												</div>
												
												<!-- 글의 제목 -->
												<a href="Onfootboard_content.jsp?board_type=<%=bdto.getBoard_type()%>&re_ref=<%=bdto.getRe_ref()%>&pageNum=<%=pageNum%>&name=<%=bdto.getMember_id()%>" style="color: inherit; text-decoration: none;"> <strong> <%= bdto.getSubject() %> </strong></a>
												<p class="tx_member" style="font-size:14px;"> <%= bdto.getMember_id() %>
												<p class="tx_brief"> <%= bdto.getDate() %>  &nbsp; &middot; 조회 <%= bdto.getReadcount() %> </p>
											</li>
										</ul>
									</div>
						    		<%
				    						}
				    					}
						    		%>
					    		</tbody>
				    		</table>
						</div>
    				</div>
    				
    				<!-- 페이지 번호 파트 -->
			    	<div class="page_control">
			    		<%
			    			//페이징 처리
			    			//글이 있을때만 처리
			    			if(count != 0) {
			    				int pageCount = count/pageSize + (count%pageSize == 0 ? 0 : 1 ); 
			    				//예시) 글의 갯수가 14개/글 표시 10개 = 1.4 + (14개%10 나머지 4) == 0이 아니기 때문에 1 = 2.4 = 2
			    				
			    				//한페이지에서 보여줄 페이지수를 설정 (1~10 페이지가 생겨진다면 몇개를 보여줄것이냐)
			    				int pageBlock = 10;
			    				
			    				//시작하는 페이지 번호 계산
			    				int startPage = ((currentPage - 1)/pageBlock) * pageBlock + 1;
			    				
			    				//끝나는 페이지 번호 계산
			    				int endPage = currentPage + pageBlock -1;
			    				
			    				if(endPage > pageCount) {
			    					endPage = pageCount;
			    				}
			    				
								/////////////////////////////////////////////////////////////////////
								// 이전
								if(startPage > pageBlock) {
								%>
								<p> <a href="Onfootboard_list.jsp?pageNum=<%= startPage - pageBlock %>"> <i class="fas fa-angle-left"></i>  </a> </p>
								<%
								}
								
								// 1~10, 11~20, ....
								for(int i=startPage; i<=endPage; i++) {
								%>
								<ol>
									<li>
										<a href="Onfootboard_list.jsp?pageNum=<%=i%>"><%= i %> </a>
									</li>
								</ol>
								<%
								}
								
								//다음
								if(endPage < pageCount) {
								%>
								<p> <a href="Onfootboard_list.jsp?pageNum=<%= startPage + pageBlock %>"> <i class="fas fa-angle-right"></i> </a> </p>
								<%
								}
			    			}
			    		%>
			    	</div>	
			    	
			    	<!-- 게시판 글쓰기, 찾기 란 -->
			    	<div class="board_button">
			    		<!-- 글쓰기 버튼 란 -->
				    	<%
	    					//로그인이 되어있으면 '글쓰기'버튼 나타나게 하기
	    					if(member_id != null) {
	    				%>
	    				<span class="span_write_btn">
	    					<input type="button" value="글쓰기" class="write_btn" onclick="location.href='/Project/board/board_write.jsp?board_type=<%=board_type%>'">
	    				</span>
				    	<%
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