package com.sneaker;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@WebServlet("/UploadServlet")
public class UploadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		PrintWriter out = response.getWriter();	
		
		ServletContext context = getServletContext(); //어플리케이션에 대한 정보를 ServletContext 객체가 갖게 됨. 
		String saveDir = context.getRealPath("/UploadImage"); //절대경로를 가져옴
		int maxSize = 3*1024*1024; // 3MB
		String encoding = "euc-kr";
		
		//ServletFileUploadisMultipartContent(request)를 사용하면 boolean 타입으로 넘어오는 Form태그의 전송방식을 확인할 수 있다.
		boolean isMulti = ServletFileUpload.isMultipartContent(request);
		
		if (isMulti) {
		
			MultipartRequest multi = new MultipartRequest(request, saveDir, maxSize, encoding, new DefaultFileRenamePolicy());
			
			//form태그에서 넘어온 값 받기
			String brand = multi.getParameter("brand");
			String sub_brand = multi.getParameter("sub_brand");
			String brand_index = multi.getParameter("brand_index");
			
			String fileName =  multi.getOriginalFileName("sneaker_image");
			String fileRealName = multi.getFilesystemName("sneaker_image");
			
			String model_stylecode = multi.getParameter("model_stylecode");
			String model_name = multi.getParameter("model_name");
			String model_colorway = multi.getParameter("model_colorway");
			String original_price =  multi.getParameter("original_price");
			String market_price = multi.getParameter("market_price");
			
		    System.out.println("절대경로>> " + saveDir);
			System.out.println("파일명: " + fileName);
			System.out.println("실제서버에 업로드될 파일명: " + fileRealName) ;
		    
			//SneakerDAO 객체 생성
			SneakerDAO sdao = new SneakerDAO();
			
			String moveUrL = "";
			
		    try {
		        int result = sdao.insertSneaker(brand, sub_brand, brand_index, fileName, fileRealName, model_stylecode, model_name, model_colorway, original_price, market_price);
		        if (result > 0) {
		            System.out.println("저장완료");
		            response.sendRedirect("/Project/admin/admin_page.jsp");
		        } else {
		            System.out.println("저장실패");
		        }
		    } catch (Exception e) {
		        e.printStackTrace();
		    }
		} else {
		    System.out.println("일반 전송 Form입니다");
		}
	}
}
