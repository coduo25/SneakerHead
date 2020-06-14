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
		
		ServletContext context = getServletContext(); //���ø����̼ǿ� ���� ������ ServletContext ��ü�� ���� ��. 
		String saveDir = context.getRealPath("/UploadImage"); //�����θ� ������
		int maxSize = 3*1024*1024; // 3MB
		String encoding = "euc-kr";
		
		//ServletFileUploadisMultipartContent(request)�� ����ϸ� boolean Ÿ������ �Ѿ���� Form�±��� ���۹���� Ȯ���� �� �ִ�.
		boolean isMulti = ServletFileUpload.isMultipartContent(request);
		
		if (isMulti) {
		
			MultipartRequest multi = new MultipartRequest(request, saveDir, maxSize, encoding, new DefaultFileRenamePolicy());
			
			//form�±׿��� �Ѿ�� �� �ޱ�
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
			
		    System.out.println("������>> " + saveDir);
			System.out.println("���ϸ�: " + fileName);
			System.out.println("���������� ���ε�� ���ϸ�: " + fileRealName) ;
		    
			//SneakerDAO ��ü ����
			SneakerDAO sdao = new SneakerDAO();
			
			String moveUrL = "";
			
		    try {
		        int result = sdao.insertSneaker(brand, sub_brand, brand_index, fileName, fileRealName, model_stylecode, model_name, model_colorway, original_price, market_price);
		        if (result > 0) {
		            System.out.println("����Ϸ�");
		            response.sendRedirect("/Project/admin/admin_page.jsp");
		        } else {
		            System.out.println("�������");
		        }
		    } catch (Exception e) {
		        e.printStackTrace();
		    }
		} else {
		    System.out.println("�Ϲ� ���� Form�Դϴ�");
		}
	}
}
