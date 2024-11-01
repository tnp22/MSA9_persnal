<!-- 
	회원 가입 처리
 -->
<%@page import="shop.dao.UserRepository"%>
<%@page import="shop.dto.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String id = request.getParameter("id");
	String passwd = request.getParameter("pw");
	String name = request.getParameter("name");
	String gender = request.getParameter("gender");
	String year = request.getParameter("year");
	String month = request.getParameter("month");
	String day = request.getParameter("day");
	String birth = (year+"/"+month+"/"+day);
	String email1 = request.getParameter("email1");
	String email2 = request.getParameter("email2");
	String mail = (email1+"@"+email2);
	String phone = request.getParameter("phone");
	String address = request.getParameter("address");
	
	// 회원 가입 요청
	User user = User.builder()
						.id(id)
						.password(passwd)
						.name(name)
						.gender(gender)
						.birth(birth)
						.mail(mail)
						.phone(phone)
						.address(address)
						.build();
	
	UserRepository userService = new UserRepository();
	int result = userService.insert(user);
	
	// 회원가입 성공
	if( result>0 ) {
		response.sendRedirect("complete.jsp?msg=1");				// 메인화면으로 이동
	}
	// 회원가입 실패
	else {
		response.sendRedirect("join.jsp?error=0");	// 다시 회원가입페이지로 (에러포함)
	}
	
%>
    