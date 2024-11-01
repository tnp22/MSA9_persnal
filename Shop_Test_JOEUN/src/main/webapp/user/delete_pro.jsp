<%@page import="shop.dao.UserRepository"%>
<%@page import="shop.dto.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- <jsp:useBean id="userDAO" class="shop.dao.UserRepository" /> --%>

<%
// 회원 정보 수정 처리

String loginId = (String) session.getAttribute("loginId");
UserRepository userDAO = new UserRepository();


int result = userDAO.delete(loginId);
if (result > 0 ){
	//자동 로그인, 토큰 쿠키 삭제
		// - 인증 토큰 삭제
		Cookie cookieRememberMe = new Cookie("rememberMe","");
		Cookie cookieToken = new Cookie("token","");
		cookieRememberMe.setPath("/");
		cookieToken.setPath("/");
		// 쿠키 전달
		cookieRememberMe.setMaxAge(0);
		cookieToken.setMaxAge(0);
		response.addCookie(cookieRememberMe);
		response.addCookie(cookieToken);
		loginId = (String) session.getAttribute("loginId");
		if(loginId != null){
			int deleted= userDAO.deleteToken(loginId);
			if(deleted>0) System.out.println("인증 토큰 데이터 삭제 성공!");
			else System.out.println("인증 토큰 데이터 삭제 실패!");
		}
		// 세션 무효화
		session.invalidate();
	
	
    response.sendRedirect("complete.jsp?msg=3");
} else {
    response.sendRedirect("update.jsp");
}
%>
