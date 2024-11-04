<%@page import="shop.dao.ProductRepository"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	ProductRepository priy = new ProductRepository();
	String id = request.getParameter("id");
	
	int result = priy.delete(id);
	if(result>0){
		System.out.println(id+"를 삭제 성공");
	}else{
		System.err.println(id+"를 삭제 실패");
	}

	response.sendRedirect("products.jsp");
	
%>