<%@page import="com.member.MemberDAO"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="javax.mail.Transport"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.Address"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.Session"%>
<%@page import="com.member.SMTPAuthenticatior"%>
<%@page import="javax.mail.Authenticator"%>
<%@page import="java.util.Properties"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<%
		request.setCharacterEncoding("UTF-8");
	
		String email = request.getParameter("email");
		String to = "coduo27@gmail.com";
		
		//System.out.println("email 값: " + email + ", to값: " + to);
	  
		Properties prop = new Properties(); 
		prop.put("mail.smtp.host", "smtp.gmail.com"); 
		prop.put("mail.smtp.port", 465); 
		prop.put("mail.smtp.auth", "true"); 
		prop.put("mail.smtp.ssl.enable", "true"); 
		prop.put("mail.smtp.ssl.trust", "smtp.gmail.com");
		  
		try{
		    Authenticator auth = new SMTPAuthenticatior();
		    Session ses = Session.getInstance(prop, auth);
		    
		   	String subject = "★★  Sneaker House 일원이 되신걸 진심으로 축하드립니다 ★★";
		   	String content = "Sneaker House 일원이 되신걸 진심으로 축하드립니다";
		    
		    ses.setDebug(true);
		    MimeMessage msg = new MimeMessage(ses); // 메일의 내용을 담을 객체 
		 
		    msg.setSubject(subject); //  제목
		 
		    StringBuffer buffer = new StringBuffer();
		    buffer.append("본인 이메일 주소 : ");
		    buffer.append(email+"<br>");   
		    buffer.append("제목 : ");
		    buffer.append(subject+"<br>");
		    buffer.append("내용 : ");
		    buffer.append(content+"<br>");
		    Address fromAddr = new InternetAddress(to);
		    msg.setFrom(fromAddr); 
		 
		    Address toAddr = new InternetAddress(email);
		    msg.addRecipient(Message.RecipientType.TO, toAddr); // 받는 사람
		     
		    msg.setContent(buffer.toString(), "text/html;charset=UTF-8"); // 내용
		    Transport.send(msg); // 전송  
		 
		} catch(Exception e){
		    e.printStackTrace();
		    return;
		}

	%>
