<%@page import="shop.dao.ProductRepository"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="shop.dto.Product"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String pdId = request.getParameter("cartId");
ProductRepository priy = new ProductRepository();
Product pd = priy.getProductById(pdId);
List<Product> cartList = null;
cartList = (ArrayList) session.getAttribute("cartList");

if(cartList==null){
	cartList = new ArrayList();
}

boolean res=true;
for (Product cart : cartList) {
    if(cart.getProductId().equals(pdId)){
    	cart.setQuantity(cart.getQuantity()+1);
    	res=false;
    }
}
if(res){
	if(pd!=null){
		pd.setQuantity(pd.getQuantity()+1);
	}
	cartList.add(pd);
}

if(cartList != null){
	session.setAttribute("cartList",cartList);
}
response.sendRedirect("product.jsp?id="+pdId);	
%>