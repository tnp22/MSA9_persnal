<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="shop.dto.Product"%>
<%@page import="shop.dao.ProductRepository"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Shop</title>
	<jsp:include page="/layout/meta.jsp" />
	<jsp:include page="/layout/link.jsp" />
	
</head>
<body>   
	<%
		//String pdId = request.getParameter("id");
		ProductRepository priy = new ProductRepository();
		Product pd = null;
		List<Product> cartList = null;
		int cartCount = 0;
		cartList = (ArrayList) session.getAttribute("cartList");
		cartCount = cartList.size();
		
	%>
	<jsp:include page="/layout/header.jsp" />

	<div class="px-4 py-5 my-5 text-center">
		<h1 class="display-5 fw-bold text-body-emphasis">장바구니</h1>
		<div class="col-lg-6 mx-auto">
			<p class="lead mb-4">장바구니 목록 입니다.</p>
		</div>
	</div>
	
	<!-- 장바구니 영역 -->
	<div class="container order">
		<!-- 장바구니 목록 -->
		<table class="table table-striped table-hover table-bordered text-center align-middle">
			<thead>
				<tr class="table-primary">
					<th>상품</th>
					<th>가격</th>
					<th>수량</th>
					<th>소계</th>
					<th>비고</th>
				</tr>
			</thead>
			<tbody>
			
			<%
			int cartSum=0;
			for(int i=0;i<cartCount;i++){
				cartSum+=cartList.get(i).getUnitPrice() * cartList.get(i).getQuantity();
			%>
 				<tr>
 					<td><%=cartList.get(i).getName()%></td>
 					<td><%=cartList.get(i).getUnitPrice()%></td>
 					<td><%=cartList.get(i).getQuantity()%></td>
 					<td><%=cartList.get(i).getUnitPrice() * cartList.get(i).getQuantity()%></td>
 					<td><a href="deleteCart.jsp?cartId=<%=cartList.get(i).getProductId()%>" class="btn btn-lg btn-danger ">삭제</a></td>
 				</tr>
			<%
				}
			%>
			</tbody>
			
			<tfoot>
				<%
					if(cartCount==0){
				%>
				<tr>
					<td colspan="5">추가된 상품이 없습니다.</td>	
				</tr>
				<%
					}
				%>
			</tfoot>
		</table>
	
		<!-- 버튼 영역 -->
		<div class="d-flex justify-content-between align-items-center p-3">
			<a href="deleteCart.jsp?cartId=all" class="btn btn-lg btn-danger ">전체삭제</a>
			<a href="javascript:;" class="btn btn-lg btn-primary" 
			 data-cart-count="<%=cartCount%>" 
			 data-cart-sum="<%=cartSum%>"
			onclick="order(this)">주문하기</a>
		</div>
	</div>
	
	<jsp:include page="/layout/footer.jsp" />
	<jsp:include page="/layout/script.jsp" />
	
	<script>
	 
		function order(element) {
			let cartCount = parseInt(element.getAttribute('data-cart-count'), 10);
		    let cartSum = element.getAttribute('data-cart-sum');
			if( cartCount == 0 ) {
				alert('장바구니에 담긴 상품이 없습니다.')
				return
			}
			let msg = '총 ' + cartCount + '종류의 상품목록을 주문합니다. \n총 주문금액 : ' + cartSum;
			let check = confirm(msg)
			if( check ) {
				location.href = 'ship.jsp';
			}
			
		}
	</script>
</body>
</html>

















