<%@page import="shop.dao.ProductRepository"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.ArrayList"%>
<%@page import="shop.dto.Product"%>
<%@page import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String pdId = request.getParameter("id");
	ProductRepository priy = new ProductRepository();
	Product pd = null;
	List<Product> cartList = null;
	cartList = (ArrayList) session.getAttribute("cartList");
	
	if(cartList==null){
		cartList = new ArrayList();
	}
	
	pd = priy.getProductById(pdId);
	boolean res=true;
    for (Product cart : cartList) {
        if(cart.getProductId().equals(pdId)){
        	cart.setQuantity(cart.getQuantity()+1);
        	res=false;
        }
    }
    if(res){
    	pd.setQuantity(pd.getQuantity()+1);
    	cartList.add(pd);
    }
	
	if(cartList != null){
		session.setAttribute("cartList",cartList);
	}
	response.sendRedirect("products.jsp");	
%>