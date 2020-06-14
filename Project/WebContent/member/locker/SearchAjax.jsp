<%@page import="java.util.List"%>
<%@page import="com.sneaker.mylocker.My_sneakerDAO"%>
<%@page import="com.sneaker.SneakerDTO"%>
<%@page import="com.sneaker.SneakerDAO"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<%
		//Sneaker_library DB에서 기본 신발정보 가져오기
		//한글처리
		request.setCharacterEncoding("UTF-8");
	
		//검색창에서 검색한 key value값을 넘겨 받는다.
		String key = request.getParameter("key");
		
		System.out.println("입력한 key값: " + key);

		SneakerDAO sdao = new SneakerDAO();
		//Sneaker_library 객체 생성
		List<SneakerDTO> sneakerList = null;
		sneakerList = sdao.searchSneaker(key);
		int size = sneakerList.size();
		System.out.println("저장된 list의 size값: " + size);
		
		SneakerDTO sdto = new SneakerDTO();
		SneakerDTO sdto2 = new SneakerDTO();
		SneakerDTO sdto3 = new SneakerDTO();

		if(size == 1) {
			 sdto = sneakerList.get(0);
		} else if (size == 2) {
			 sdto = sneakerList.get(0);
			 sdto2 = sneakerList.get(1);
		} else if (size >= 3) {
			 sdto = sneakerList.get(0);
			 sdto2 = sneakerList.get(1);
			 sdto3 = sneakerList.get(2);
		}

	%>

	[
		{
		 "size" : " <%= size %> ",
		 "brand" : " <%=sdto.getBrand() %>",
		 "sub_brand" : " <%= sdto.getSub_brand() %>",
		 "brand_index" : " <%=sdto.getBrand_index() %>",
		 "model_name" : "<%=sdto.getModel_name() %>",
		 "sneaker_image" : "<%=sdto.getSneaker_image() %>",
		 "model_stylecode" : "<%=sdto.getModel_stylecode() %>",
		 "model_colorway" : "<%=sdto.getModel_colorway() %>",
		 "original_price" : "<%=sdto.getOriginal_price() %>",
		 "market_price" : "<%=sdto	.getMarket_price() %>"
		 },
		 {
		 "brand" : " <%=sdto2.getBrand() %>",
		 "sub_brand" : " <%= sdto2.getSub_brand() %>",
		 "brand_index" : " <%=sdto2.getBrand_index() %>",
		 "model_name" : "<%=sdto2.getModel_name() %>",
		 "sneaker_image" : "<%=sdto2.getSneaker_image() %>",
		 "model_stylecode" : "<%=sdto2.getModel_stylecode() %>",
		 "model_colorway" : "<%=sdto2.getModel_colorway() %>",
		 "original_price" : "<%=sdto2.getOriginal_price() %>",
		 "market_price" : "<%=sdto2.getMarket_price() %>"
		 },
		 {
		 "brand" : " <%=sdto3.getBrand() %>",
		 "sub_brand" : " <%= sdto3.getSub_brand() %>",
		 "brand_index" : " <%=sdto3.getBrand_index() %>",
		 "model_name" : "<%=sdto3.getModel_name() %>",
		 "sneaker_image" : "<%=sdto3.getSneaker_image() %>",
		 "model_stylecode" : "<%=sdto3.getModel_stylecode() %>",
		 "model_colorway" : "<%=sdto3.getModel_colorway() %>",
		 "original_price" : "<%=sdto3.getOriginal_price() %>",
		 "market_price" : "<%=sdto3.getMarket_price() %>"
		 }	
	]	
	
