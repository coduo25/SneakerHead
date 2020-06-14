<%@page import="com.sneaker.mylocker.My_sneakerDTO"%>
<%@page import="com.sneaker.mylocker.My_sneakerDAO"%>
<%@page import="com.sneaker.SneakerDTO"%>
<%@page import="com.sneaker.SneakerDAO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title> SneakerHouse 나의신발장</title>
<link rel="shortcut icon" href="/Project/images/icon/favicon.ico" />
<link rel="stylesheet" href="/Project/css/member/my_locker.css">
<script src="https://kit.fontawesome.com/febeeb992c.js" crossorigin="anonymous"></script>
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic|Nanum+Gothic+Coding&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Oswald:700&display=swap" rel="stylesheet">
<script src="/Project/js/jquery-3.4.1.js"></script>
<script type="text/javascript">
	<%
		//한글처리
		request.setCharacterEncoding("UTF-8");
		
		//로그인이 안되어있다면
		String member_id = (String) session.getAttribute("ID");
		if( member_id == null) {
			response.sendRedirect("/Project/member/loginForm.jsp");
		}
		
		//My_snekaerDAO DB 처리객체 생성
		My_sneakerDAO mdao = new My_sneakerDAO();			
				
		//나의 신발장 안에 신발정보가 있다면 신발정보 전체 가져오기
		List sneakerList = null;
		sneakerList = mdao.getListMySneaker(member_id); 
	%>

	//jquery 구문
	$(document).ready(function(){
		
		//추가하기 버튼을 눌렸을때 신발 검색하는 란 popUp
		$('#table_add_tab').click(function() {
			$('#myPopUp').fadeToggle('slow');
			$('#model_name').focus();

			$(function(){
				var delay = (function(){
				var timer = 0;
				return function(callback, ms){
					clearTimeout (timer);
					timer = setTimeout(callback, ms);
					};
				})();

				$("#model_name").keyup(function() {
					delay(function(){
						search_ajax();
					}, 500 );
				});
			});

			function search_ajax() {
				// 키 입력 후 일정 시간 지나면 실행될 함수
				//사용자가 작성할 input 값
				var input = $('#model_name').val();
				
				if(input != '' && input != null){
					
					$('#popUpInfo2').hide(); 
					
					$.ajax({
						type:'get',
						url:'SearchAjax.jsp',
						data:'key='+input,
						dataType : "json",
						success:function(data){				
							
							var size = data[0].size;
							var result = data[0].brand;
							var result2 = data[1].brand;
							var result3 = data[2].brand;
							
							//DB에 입력한 정보가 없을시 입력했을시
							if(size == 0) {
								$('#popUpInfo').hide();
								$('#popUpInfo2').show(); 
								
								$("#searched_button").hide();
								$("#searched_button2").hide();
								$("#searched_button3").hide();
							}
							
							//사이즈가 1일때
							if(size == 1) {
								//alert("첫번째 조건");
								$('#popUpInfo').fadeIn('fast');
								
								// -----------------------첫번째 버튼 ----------------------------------------------------------------
								
								$("#searched_button").show();
								$("#searched_button2").hide();
								$("#searched_button3").hide();
								
								//Json 첫번째 파일을 html 코드에 뿌려주기 
								$('#sneaker_image').attr('src', '/Project/UploadImage/' + data[0].sneaker_image);
								$("input#json_brand").val(data[0].brand);
								$("input#json_sub_brand").val(data[0].sub_brand);
								$("input#json_brand_index").val(data[0].brand_index);
								$("input#json_modelname").val(data[0].model_name);
								$("input#json_colorway").val(data[0].model_colorway);

								//버튼을 클릭하였을때 두번째 popUp 창 팝업
								$('button#searched_button').click(function(){
									//찾기 팝업창 닫고
									$('#myPopUp').hide();

									//Json 첫번째 파일을 html 코드에 뿌려주기 - brand				
									$('#2sneaker_image').attr('src', '/Project/UploadImage/' + data[0].sneaker_image);
									$("input#sneaker_image").val(data[0].sneaker_image);
									$("input#json_brand").val(data[0].brand);
									$("input#json_sub_brand").val(data[0].sub_brand);
									$("input#json_brand_index").val(data[0].brand_index);
									$("input#json_modelname").val(data[0].model_name);
									$("input#json_stylecode").val(data[0].model_stylecode);
									$("input#json_colorway").val(data[0].model_colorway);
									$("input#json_originalPrice").val(data[0].original_price);
									$("input#json_marketPrice").val(data[0].market_price);
									
									//추가 정보 팝업창 열기
									$('#myPopUp2').show();
								});
							}
							
							//사이즈가 2일때
							if(size == 2) {
								//alert("첫번째 조건");
								$('#popUpInfo').fadeIn('fast');
								
								$("#searched_button").show();
								$("#searched_button2").show();
								$("#searched_button3").hide();
								
								// -----------------------첫번째 버튼 ----------------------------------------------------------------
								//Json 첫번째 파일을 html 코드에 뿌려주기 
								$('#sneaker_image').attr('src', '/Project/UploadImage/' + data[0].sneaker_image);
								$("input#json_brand").val(data[0].brand);
								$("input#json_sub_brand").val(data[0].sub_brand);
								$("input#json_brand_index").val(data[0].brand_index);
								$("input#json_modelname").val(data[0].model_name);
								$("input#json_colorway").val(data[0].model_colorway);
								
								$('#sneaker_image2').attr('src', '/Project/UploadImage/' + data[1].sneaker_image);
								$("input#json_brand2").val(data[1].brand);
								$("input#json_sub_brand2").val(data[1].sub_brand);
								$("input#json_brand_index2").val(data[1].brand_index);
								$("input#json_modelname2").val(data[1].model_name);
								$("input#json_colorway2").val(data[1].model_colorway);

								//버튼을 클릭하였을때 두번째 popUp 창 팝업
								$('button#searched_button').click(function(){
									//찾기 팝업창 닫고
									$('#myPopUp').hide();

									//Json 첫번째 파일을 html 코드에 뿌려주기 - brand				
									$('#2sneaker_image').attr('src', '/Project/UploadImage/' + data[0].sneaker_image);
									$("input#sneaker_image").val(data[0].sneaker_image);
									$("input#json_brand").val(data[0].brand);
									$("input#json_sub_brand").val(data[0].sub_brand);
									$("input#json_brand_index").val(data[0].brand_index);
									$("input#json_modelname").val(data[0].model_name);
									$("input#json_stylecode").val(data[0].model_stylecode);
									$("input#json_colorway").val(data[0].model_colorway);
									$("input#json_originalPrice").val(data[0].original_price);
									$("input#json_marketPrice").val(data[0].market_price);

									//추가 정보 팝업창 열기
									$('#myPopUp2').show();
								});
									
								$('button#searched_button2').click(function(){
									//찾기 팝업창 닫고
									$('#myPopUp').hide();
									
									$('#2sneaker_image').attr('src', '/Project/UploadImage/' + data[1].sneaker_image);
									$("input#sneaker_image").val(data[1].sneaker_image);
									$("input#json_brand").val(data[1].brand);
									$("input#json_sub_brand").val(data[1].sub_brand);
									$("input#json_brand_index").val(data[1].brand_index);
									$("input#json_modelname").val(data[1].model_name);
									$("input#json_stylecode").val(data[1].model_stylecode);
									$("input#json_colorway").val(data[1].model_colorway);
									$("input#json_originalPrice").val(data[1].original_price);
									$("input#json_marketPrice").val(data[1].market_price);
									
									//추가 정보 팝업창 열기
									$('#myPopUp2').show();
								});
							}
							
							//사이즈가 3이상일때
							if(size >= 3) {
								//alert("첫번째 조건");
								$('#popUpInfo').fadeIn('fast');
								
								$("#searched_button").show();
								$("#searched_button2").show();
								$("#searched_button3").show();
								
								// -----------------------첫번째 버튼 ----------------------------------------------------------------
								//Json 첫번째 파일을 html 코드에 뿌려주기 
								$('#sneaker_image').attr('src', '/Project/UploadImage/' + data[0].sneaker_image);
								$("input#json_brand").val(data[0].brand);
								$("input#json_sub_brand").val(data[0].sub_brand);
								$("input#json_brand_index").val(data[0].brand_index);
								$("input#json_modelname").val(data[0].model_name);
								$("input#json_colorway").val(data[0].model_colorway);
								
								$('#sneaker_image2').attr('src', '/Project/UploadImage/' + data[1].sneaker_image);
								$("input#json_brand2").val(data[1].brand);
								$("input#json_sub_brand2").val(data[1].sub_brand);
								$("input#json_brand_index2").val(data[1].brand_index);
								$("input#json_modelname2").val(data[1].model_name);
								$("input#json_colorway2").val(data[1].model_colorway);
								
								$('#sneaker_image3').attr('src', '/Project/UploadImage/' + data[2].sneaker_image);
								$("input#json_brand3").val(data[2].brand);
								$("input#json_sub_brand3").val(data[2].sub_brand);
								$("input#json_brand_index3").val(data[2].brand_index);
								$("input#json_modelname3").val(data[2].model_name);
								$("input#json_colorway3").val(data[2].model_colorway);

								//버튼을 클릭하였을때 두번째 popUp 창 팝업
								$('button#searched_button').click(function(){
									//찾기 팝업창 닫고
									$('#myPopUp').hide();

									//Json 첫번째 파일을 html 코드에 뿌려주기 - brand				
									$('#2sneaker_image').attr('src', '/Project/UploadImage/' + data[0].sneaker_image);
									$("input#sneaker_image").val(data[0].sneaker_image);
									$("input#json_brand").val(data[0].brand);
									$("input#json_sub_brand").val(data[0].sub_brand);
									$("input#json_brand_index").val(data[0].brand_index);
									$("input#json_modelname").val(data[0].model_name);
									$("input#json_stylecode").val(data[0].model_stylecode);
									$("input#json_colorway").val(data[0].model_colorway);
									$("input#json_originalPrice").val(data[0].original_price);
									$("input#json_marketPrice").val(data[0].market_price);

									//추가 정보 팝업창 열기
									$('#myPopUp2').show();
								});
									
								$('button#searched_button2').click(function(){
									//찾기 팝업창 닫고
									$('#myPopUp').hide();
									
									$('#2sneaker_image').attr('src', '/Project/UploadImage/' + data[1].sneaker_image);
									$("input#sneaker_image").val(data[1].sneaker_image);
									$("input#json_brand").val(data[1].brand);
									$("input#json_sub_brand").val(data[1].sub_brand);
									$("input#json_brand_index").val(data[1].brand_index);
									$("input#json_modelname").val(data[1].model_name);
									$("input#json_stylecode").val(data[1].model_stylecode);
									$("input#json_colorway").val(data[1].model_colorway);
									$("input#json_originalPrice").val(data[1].original_price);
									$("input#json_marketPrice").val(data[1].market_price);
									
									//추가 정보 팝업창 열기
									$('#myPopUp2').show();
								});
								
								$('button#searched_button3').click(function(){
									//찾기 팝업창 닫고
									$('#myPopUp').hide();
									
									//Json 첫번째 파일을 html 코드에 뿌려주기 - brand				
									$('#2sneaker_image').attr('src', '/Project/UploadImage/' + data[2].sneaker_image);
									$("input#sneaker_image").val(data[2].sneaker_image);
									$("input#json_brand").val(data[2].brand);
									$("input#json_sub_brand").val(data[2].sub_brand);
									$("input#json_brand_index").val(data[2].brand_index);
									$("input#json_modelname").val(data[2].model_name);
									$("input#json_stylecode").val(data[2].model_stylecode);
									$("input#json_colorway").val(data[2].model_colorway);
									$("input#json_originalPrice").val(data[2].original_price);
									$("input#json_marketPrice").val(data[2].market_price);
									
									//추가 정보 팝업창 열기
									$('#myPopUp2').show();
								});
							}
						}, error: function(){
							
						}
					});
				} 
					//아무것도 입력 안했을때
					else if(input == '' || input == null){
					//alert("아무것도 입력 안했을때");
					$('#popUpInfo').hide();
					$('#popUpInfo2').show(); 
					$.ajax({
						type:'get',
						url:'SearchAjax.jsp',
						data:'key='+input,
						dataType : "json",
						success:function(data){	
							//alert("갖다옴");
						}, error: function(){
							//alert("에러");	
						}
					});
				}
			}
		});
		
		// X 표시 눌렷을때 popUp 창 닫기
		$('#close').click(function() {
			$('#myPopUp').hide();
		});
		$('#close2').click(function() {
			$('#myPopUp2').hide();
		});
	});
	
	//신발 상태중 중고를 선택했을 시 '중고상태' 란 popup
	function displayUsedFunction(x) {
		if(x==1) {//중고를 선택했으시 
			document.getElementById("used_condition_div").style.display='block';
		} else if(x==0) {
			document.getElementById("used_condition_div").style.display='none';
		} 
		return;
	}
	
	//소유중인가요? 란 아니오 클릭시 popup
	function currentFunction(x) {
		if(x==1) {//아니오를 선택했을시 
			document.getElementById("fs_div").style.display='block';
		} else if(x==0) {
			document.getElementById("fs_div").style.display='none';
		} 
		return;
	}	

</script>

</head>
<body>
	
	<!-- Header -->
    <header> <jsp:include page="/include/header.jsp" /> </header>
	
	<div id="main_border">
		<div id="main_content">
			<div id="bb_contentWrap">
				<div id="bb_content">
					<!-- 신발장 게시판 파트 -->
					<div class="board_list">
						<!-- 소제목 -->
						<div class="sub_title"> 
							<h2> 나의 신발장  </h2> 
						</div>
						<!-- 메인게시판 테이블 -->
						<div class="base_table">
							<span class="span_add"> <button type="button" id="table_add_tab" class="table_add_tab"> 추가하기 </button> </span>
									<!-- ********************검색 PopUp 창********************************************************** -->
									<div id="myPopUp" class="popUp">
										<div class="popUp-content">
											<div class="popUp-content-header">
												<span class="popUp-span"> 신발 검색하기 </span>
												<span class="close" id="close" >&times;</span>
											</div>
											<div class="popUp-content-body">
												<!-- 제품 찾기 란 -->
												<form name="form" >
													<input class="input_sneaker" type="text" placeholder=" 찾고자 하는 브랜드, 이름, 모델명 ... 등" name="model_name" id="model_name">
													<!-- 찾고자 하는 제품 목록 창 PopUp -->
													<div id="popUpInfo" class="popUpInfo">
														<!-- InfoPopUp 내용 -->
														<div class="popUp-content" >
															<button type="button" class="searched_button" id="searched_button" style="display: none;">
																<div id="showList" class="showList">  
																	 <table class="json_table1" >
																	 	<tr> 
																	 		<td> <img id="sneaker_image" src="" width="150px" height="100px"> </td> 
																	 		<td> 
																	 			<input type="text" id="json_brand" style=" font-size: 15px;" readonly/> 
																	 			<input type="text" id="json_modelname" style="text-overflow: ellipsis; white-space: nowrap; overflow: hidden;" readonly/>
																	 			<input type="text" id="json_colorway" style="font-size: 15px;" readonly/>
																	 		</td>
																	 	</tr>
																	 </table>
																</div>
															</button>
															<button type="button" class="searched_button" id="searched_button2" style="display: none;">
																<div id="showList" class="showList">  
																	 <table class="json_table1" >
																	 	<tr> 
																	 		<td> <img id="sneaker_image2" src="" width="150px" height="100px"> </td> 
																	 		<td> 
																	 			<input type="text" id="json_brand2" style=" font-size: 15px;" readonly/> 
																	 			<input type="text" id="json_modelname2" style="text-overflow: ellipsis; white-space: nowrap; overflow: hidden;" readonly/>
																	 			<input type="text" id="json_colorway2" style="font-size: 15px;" readonly/>
																	 		</td>
																	 	</tr>
																	 </table>
																</div>
															</button>	
															<button type="button" class="searched_button" id="searched_button3" style="display: none;">
																<div id="showList" class="showList">  
																	 <table class="json_table1" >
																	 	<tr> 
																	 		<td> <img id="sneaker_image3" src="" width="150px" height="100px"> </td> 
																	 		<td> 
																	 			<input type="text" id="json_brand3" style=" font-size: 15px;" readonly/> 
																	 			<input type="text" id="json_modelname3" style="text-overflow: ellipsis; white-space: nowrap; overflow: hidden;" readonly/>
																	 			<input type="text" id="json_colorway3" style="font-size: 15px;" readonly/>
																	 		</td>
																	 	</tr>
																	 </table>
																</div>
															</button>		
														</div>
													</div>
													<!-- 찾고자 하는 제품 을 찾지 못했을때 나타나는 목록 창 PopUp -->
													<div id="popUpInfo2" class="popUpInfo">
														<!-- InfoPopUp 내용 -->
														<div class="popUp-content" >
															<div id="showList" class="showList" style="padding: 0; text-align: center;">  
																찾고자 하는 제품의 정보가 없습니다. 올바른 모델의 이름명을 작성해십시오.
															</div>
														</div>
													</div>
												</form>
											</div>
										</div>
									</div>
									<!-- ******************** 검색후 추가 정보 입력 창*************************************************** -->
									<div id="myPopUp2" class="popUp2">
										<div class="popUp-content2" id="popUp-content2">
											<div>
												<!-- 제목 & X 버튼 -->
												<div class="popUp-content-header">
													<span class="popUp-span"> 신발장에 추가하기 </span>
													<span class="close" id="close2">&times;</span>
												</div>
													
												<!-- 제품 추가 popUp 창 -->
												<form class="Sneaker_info_form" name="Sneaker_info_form" action="addPro.jsp" method="get">	
													
													<!-- 화면에 보여줄 필요는 없지만 form 태그로 데이터를 넘겨주기 위해선 value 값에 넣어야할 필요가 있기 때문에 input 태그를 써서 만들어야한다. -->
													<input type="hidden" name="member_id" value="<%= member_id %>"/>
														 
													<!-- 찾은 제품의 정보를 보여주는 상자 -->
													<div id="showList2" class="showList2">  
														 <table class="json_table2"> 
														 	<tr> <td colspan="2"> <img id="2sneaker_image" src="" width="450px" height="300px" style="padding-bottom: 10px;">  </td> </tr>
														 	<tr> <th> 브랜드 </th> <td> <input type="text" id="json_brand" name="brand" value="" readonly> </td> </tr>	
															 	<input type="hidden" id="sneaker_image" name="sneaker_image" value=""> 
															 	<input type="hidden" id="json_sub_brand" name="sub_brand" value=""> 
																<input type="hidden" id="json_brand_index" name="brand_index" value="">	
														 	<tr> <th> 모델명 </th> <td> <input type="text" id="json_modelname" name="model_name" value="" style="text-overflow: ellipsis; white-space: nowrap; overflow: hidden;" readonly> </td> </tr>
														 	<tr> <th> 스타일코드 </th> <td> <input type="text" id="json_stylecode" name="model_stylecode" value="" readonly> </td> </tr>
														 	<tr> <th> 컬러코드 </th> <td> <input type="text" id="json_colorway" name="model_colorway" value="" readonly> </td> </tr>
														 	<tr> <th> 발매가 </th> <td> <input type="text" id="json_originalPrice" name="original_price" value="" readonly> </td> </tr>
														 		<input type="hidden" id="json_marketPrice" name="market_price" value="">					 	
														 </table>
													</div>
													
													<div class="additional_info">
														<div class="size_div"> 
															<span> 사이즈  </span> <br> 
															<select name="my_size"> 
																<option value="0"> 사이즈 선택 </option>
																<option value="220"> 220 </option>
																<option value="225"> 225 </option>
																<option value="230"> 230 </option>
																<option value="235"> 235 </option>
																<option value="240"> 240 </option>
																<option value="245"> 245 </option>
																<option value="250"> 250 </option>
																<option value="255"> 255 </option>
																<option value="260"> 260 </option>
																<option value="265"> 265 </option>
																<option value="270"> 270 </option>
																<option value="275"> 275 </option>
																<option value="280"> 280 </option>
																<option value="285"> 285 </option>
																<option value="290"> 290 </option>
																<option value="295"> 295 </option>
																<option value="300"> 300 </option>
																<option value="305"> 305 </option>
																<option value="310"> 310 </option>
															</select>
														</div>
														
														<div class="price_div"> 
															<span> 구입 가격 </span>  <br>
															<input class="my_input" type="text" placeholder="구입 가격" name="my_price"> 
														</div>
															
														<div class="condition_div">  
															<span> 상태 </span> <br>
															<input type="radio" name="my_condition" value="새상품" onclick="displayUsedFunction(0)"> 새상품 <input type="radio" name="my_condition" value="중고" id="used" onclick="displayUsedFunction(1)" > 중고 
														</div>
														
															<div class="used_condition_div" id="used_condition_div" style="display:none"> 
																<span> 중고 상태  </span> <br>
																<select name="my_usedRate"> 
																	<option value="9.5"> 9.5/10 </option>
																	<option value="9"> 9/10 </option>
																	<option value="8.5"> 8.5/10 </option>
																	<option value="8"> 8/10 </option>
																	<option value="7.5"> 7.5/10 </option>
																	<option value="7"> 7/10 </option>
																	<option value="6"> 6/10 </option>
																	<option value="5"> 5/10 </option>
																	<option value="4"> 4/10 </option>
																	<option value="3"> 3/10 </option>
																	<option value="2"> 2/10 </option>
																	<option value="1"> 1/10 </option>
																</select>
															</div>
														
														<div class="purchasingRoute_div"> 
															<span> 구입 경로 </span> <br> 
															<input type="radio" name="my_purchasing_route" value="정식발매"> 정식발매  <input type="radio" name="my_purchasing_route" value="리셀"> 리셀  <input type="radio" name="my_purchasing_route" value="선물"> 선물 <input type="radio" name="pR" value="기타"> 기타  
														</div>
														
														<div class="current_status"> 
															<span> 현재 소유 중인가? </span> <br>
															<input type="radio" name="my_status" value="O" onclick="currentFunction(0)"> 예 <input type="radio" id="CS_nobutton" name="my_status" value="X" onclick="currentFunction(1)"> 아니오 															
														</div>
														
															<div class="future_status" style="display:none" id="fs_div"> 
																<span> 처분 경로 </span> <br>
																<input type="radio" name="my_future_status" value="리셀함"> 리셀함 <input type="radio" name="my_future_status" value="선물함"> 선물함 <input type="radio" name="my_future_status" value="기타"> 기타
															</div>
													</div>
													<!-- 추가하기 버튼 -->
													<div style="border-top: 1px solid #dfdfdf; padding:0;">
														<input type="submit" value="추가하기" id="final_locker_button">
													</div>  
												</form>
											</div>
										</div>
									</div>
							<table class="main_table_collection">
								<!-- 게시판의 헤더 -->
								<thead>
									<tr class="header_table_collection">
										<th class="tImg"> 이미지 </th>
										<th class="tName"> 모델명 </th>
										<th class="tSize"> 사이즈 </th>
										<th class="tCondition"> 상태 </th>
										<th class="tPrice"> 구입가격 </th>
										<th class="tMPrice" style="background-color: #e3e3e3;"> 현재시세 <i class="fas fa-caret-down"></i> </th>
										<th class="tPurchasing"> 구입경로 </th>
										<th class="tCurrent"> 이득/손실 </th>
									</tr>
								</thead>
								<%
									//총 가지고 있는 신발 갯수 구하는 함수
									int amountOfSneaker = mdao.countOf(member_id);
									
									//총 구매액 구하는 함수
									int sumOfmy_price = mdao.sumOfmy_p(member_id);
									
									//총 시장가 구하는 함수
									int sumOfmarket_price = mdao.sumOfmarket_p(member_id);
									
								
									//만약 신발리스트가 null이 아니면 
									if(sneakerList != null) {
										for(int i=0; i<sneakerList.size(); i++) {
											My_sneakerDTO msdto = (My_sneakerDTO) sneakerList.get(i);
								
											String imgFile = "/Project/UploadImage/" + msdto.getSneaker_image();
											
											int gain = msdto.getMarket_price() - msdto.getMy_price();
											
											System.out.println(imgFile);						
								%>
								<tbody>
									<tr class="content_table_collection">
										<td> <img src=" <%= imgFile %>" width="150px" height="100px" ></td>
										<td style="font-weight:bold; font-size: 17px;"> <%= msdto.getModel_name() %> </td>
										<td> <%= msdto.getMy_size() %> </td>
										<td> <%= msdto.getMy_condition() %> </td>
										<td style="font-weight:bold;"> ￦<%= String.format("%,d", msdto.getMy_price()) %> </td>
										<td style="font-weight:bold; background-color: #e3e3e3;">  ￦<%= String.format("%,d", msdto.getMarket_price()) %> <br> </td>								
										<td> <%= msdto.getMy_purchasing_route() %> </td>
										<td style="color: #009F62; font-weight:bold;"> (+<%= String.format("%,d", gain) %>) </td>
									</tr>
								</tbody>
								<%
										}
									}
								%>
									<tr class="content_table_collection">
										<td class="total_table"> Totals </td>
										<td class="total_table"> <%= amountOfSneaker %> items  </td>
										<td class="total_table" colspan="2">  </td>
										<td class="total_table"> ￦<%= String.format("%,d", sumOfmy_price) %> </td>
										<td class="total_table"> ￦<%= String.format("%,d", sumOfmarket_price) %> </td>
										<td class="total_table"> </td>
										<td class="total_table" style="color: #009F62;"> (￦<%= String.format("%,d", (sumOfmarket_price-sumOfmy_price)) %>) </td>
									</tr>
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