<%@page import="com.board.BoardDTO"%>
<%@page import="com.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title> SneakerHouse 글수정</title>
<link rel="shortcut icon" href="/Project/images/icon/favicon.ico" />
<link rel="stylesheet" href="/Project/css/board/board.css">
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic|Nanum+Gothic+Coding&display=swap" rel="stylesheet">
<!-- SmartEditor를 사용하기 위해서 다음 js파일을 추가 (경로 확인) -->
<script type="text/javascript" src="/Project/se2/js/HuskyEZCreator.js" charset="utf-8"></script>
<!-- jQuery를 사용하기위해 jQuery라이브러리 추가 -->
<script type="text/javascript" src="http://code.jquery.com/jquery-1.9.0.min.js"></script>

<script type="text/javascript">
	//(모든게시판) 글쓰기 눌렸을때
	var oEditors = [];
	$(function(){
	      nhn.husky.EZCreator.createInIFrame({
	          oAppRef: oEditors,
	          elPlaceHolder: "ir1", //textarea에서 지정한 id와 일치해야 합니다. 
	          //SmartEditor2Skin.html 파일이 존재하는 경로
	          sSkinURI: "/Project/se2/SmartEditor2Skin.html",  
	          htParams : {
	              // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
	              bUseToolbar : true,             
	              // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
	              bUseVerticalResizer : true,     
	              // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
	              bUseModeChanger : true,         
	              fOnBeforeUnload : function(){          
	              }
	          }, 
	          fOnAppLoad : function(){
	              //기존 저장된 내용의 text 내용을 에디터상에 뿌려주고자 할때 사용
	              oEditors.getById["ir1"].exec("PASTE_HTML", [""]);
	          },
	          fCreator: "createSEditor2"
	      });
	      //저장버튼 클릭시 form 전송
	      $("#save").click(function(){
	          oEditors.getById["ir1"].exec("UPDATE_CONTENTS_FIELD", []);
	          $("#fr").submit();
	      });    
	});

	$(function(){
		//jsp페이지에서 받은 board_type Parameter 값을 javascript에서 쓰기
		var boardtype_val = "<%= request.getParameter("board_type") %>";
		$("select#select_board_type").val(boardtype_val).prop("selected", true); //board_type 값 자동 selected 하기 
	});

</script>
</head>
<body>
	<%
		//한글처리
		request.setCharacterEncoding("UTF-8");
	
		//글 보기 페이지에서 보내준 데이터 값 받아서 저장하기
		String member_id = (String) session.getAttribute("ID"); 		//넘어온 세션값 아이디 값 저장
		String board_type = request.getParameter("board_type"); 		//넘어온 board_type의 값
		int re_ref = Integer.parseInt(request.getParameter("re_ref")); 	//넘어온 re_ref 값
		String pageNum = request.getParameter("pageNum");				//클릭한 글의 pageNum
		
		//세션값이 없을 경우 로그인 페이지로 이동
		if(member_id == null) {
			response.sendRedirect("/Project/member/loginForm.jsp");
		}
		
		//BoardDAO 객체를 만들어서 글 정보를  페이지에 출력
		BoardDAO bdao = new BoardDAO();
		BoardDTO bdto = bdao.getBoardContent(board_type, re_ref);
	%>
	
	<!-- Header -->
	<header> <jsp:include page="/include/header.jsp" /> </header>
	
	<!-- 게시판 글쓰기 form -->
	<div id="main_border">
		<!-- 글쓰기 란 -->
		<div id="main_content">
			<div id="bb_contentWrap">
				<div id="bb_write_content">
					<!-- 글쓰기 영역 -->
					<div class="content_table">
						<form action="/Project/board/board_updatePro.jsp?pageNum=<%=pageNum%>" method="post" name="fr" class="bbwrite_table" enctype="application/x-www-form-urlencoded" id="write_form">
							<input type="hidden" name="re_ref" value="<%= bdto.getRe_ref() %>">
							<input type="hidden" name="member_id" value="<%= bdto.getMember_id() %>">
							<input type="hidden" name="board_type" value="<%= bdto.getBoard_type() %>">
							<div>
								<table>
									<tbody>
										<tr>
											<th scope="row"> 게시판 </th>
											<td> 
												<select id="select_board_type" name="board_type" disabled> 
													<option> 게시판선택 </option>
													<option value="발매"> 발매게시판 </option>
													<option value="루머"> 루머게시판 </option>
													<option value="착샷"> 스니커착샷게시판 </option>
													<option value="신발장"> 신발장게시판 </option>
													<option value="셀럽들"> 셀럽들게시판 </option>
													<option value="공지"> 공지게시판 </option>
												</select> 
											</td>  
										</tr>
										<tr>
											<th scope="row"> 제목 </th>
											<td > <input class="subject" type="text" name="subject" value="<%=bdto.getSubject()%>"> </td>  
										</tr>	
<!-- 										<tr> -->
<!-- 											<th scope="row"> 업로드 </th> -->
<!-- 											<td> <button type="button" class="upload_button" href="#"> 파일찾기 </button> </td> -->
<!-- 										</tr> -->
										<tr>
											<th> 글 내용 </th>
											<td> <textarea class="ta_content" name="content" id="ir1"><%=bdto.getContent()%></textarea> </td>
										</tr>
									</tbody>
								</table>
							</div>
							
							<!-- 글쓰기 버튼 영역  -->
							<div class="table_submit">
								<span class="span_write_btn">
		    						<input type="submit" value="수정하기" class="write_btn" id="save">
		    					</span>
							</div>
							
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	
	<!-- FOOTER -->
	<footer> <jsp:include page="/include/footer.jsp"/> </footer>

</body>
</html>