<%@page import="shop.dto.Product"%>
<%@page import="java.util.List"%>
<%@page import="shop.dao.OrderRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/layout/meta.jsp"%>
<%
	
	// 비회원 주문 내역 세션에 등록 처리
	
	String phone = request.getParameter("phone");
	String orderPw = request.getParameter("orderPw");
	
	session.setAttribute("orderPhone",phone);
	session.setAttribute("orderPw",orderPw);
	
	response.sendRedirect(root + "/user/order.jsp");

%>