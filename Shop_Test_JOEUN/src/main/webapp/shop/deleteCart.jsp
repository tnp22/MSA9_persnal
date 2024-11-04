<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="shop.dao.ProductRepository"%>
<%@page import="shop.dto.Product"%>
<%@page import="java.util.ArrayList"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	
	
String pdId = request.getParameter("cartId");
	
if(pdId.equals("all")){
	session.removeAttribute("cartList");
	List<Product> cartList = new ArrayList();
	session.setAttribute("cartList",cartList);
	response.sendRedirect("cart.jsp");
	return ;
}
	
ProductRepository priy = new ProductRepository();

List<Product> cartList = (ArrayList) session.getAttribute("cartList");

Product pd = priy.getProductById(pdId);


if(cartList==null){
	cartList = new ArrayList();
	session.setAttribute("cartList",cartList);
	response.sendRedirect("cart.jsp");
	return;
}
else{
	Iterator<Product> iterator = cartList.iterator();
	while (iterator.hasNext()) {
		Product cart = iterator.next();
        if (cart.getProductId().equals(pdId)) {
            iterator.remove(); // 안전하게 삭제
        }
    }
	session.setAttribute("cartList",cartList);
}
response.sendRedirect("cart.jsp");
%>