<%@page import="shop.dto.Product"%>
<%@page import="java.util.List"%>
<%@page import="shop.dao.ProductRepository"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/layout/jstl.jsp"%>
<%@ include file="/layout/meta.jsp"%>
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
		ProductRepository priy = new ProductRepository();
		List<Product> prList = null;
		prList = priy.list();
		int prCount = prList.size();
	%>

	<jsp:include page="/layout/header.jsp" />



	<div class="px-4 py-5 my-5 text-center">
		<h1 class="display-5 fw-bold text-body-emphasis">상품 편집</h1>
		<div class="col-lg-6 mx-auto">
			<p class="lead mb-4">쇼핑몰 상품 목록 입니다.</p>
			<div class="d-grid gap-2 d-sm-flex justify-content-sm-center">
			
				<a href="add.jsp" class="btn btn-primary btn-lg px-4 gap-3">상품 등록</a>
				<!-- [NEW] 상품 편집 버튼 추가 -->
				<a href="products.jsp" class="btn btn-success btn-lg px-4 gap-3">상품 목록</a>
				
			</div>
		</div>
	</div>
	
	<div class="container mb-5">
		<div class="row gy-4">
		
			<% for(int i=0;i<prCount;i++){ %>
			
				<div class="col-md-6 col-xl-4 col-xxl-3">
					<div class="card p-3">
						<!-- 이미지 영역 -->
						<div class="img-content">
							<img src="img?id=<%=prList.get(i).getProductId()%>" class="w-100 p-2" />
						</div>
						<!-- 컨텐츠 영역 -->
						<div class="content">
							<h3 class="text-center"><%=prList.get(i).getName() %></h3>
							<p><%=prList.get(i).getDescription() %></p>
							<p class="text-end price">₩ <%=prList.get(i).getUnitPrice() %></p>
							<p class="d-flex justify-content-end">
								<!-- [NEW] 수정 버튼으로 변경 -->
								<a href="./update.jsp?id=<%=prList.get(i).getProductId()%>"
										   class="btn btn-primary mx-2">수정</a>
								<!-- [NEW] 삭제 버튼 추가 -->

								<a href="javascript:;"
										   class="btn btn-danger mx-2"
										   onclick="deleteProduct(<%=prList.get(i).getProductId()%>)">삭제</a>
							</p>
						</div>						
					</div>
				</div>
			
				<%} %>
			
		</div>
	</div>
	
	
	<jsp:include page="/layout/footer.jsp" />
	<jsp:include page="/layout/script.jsp" />
	
	<script>
		function deleteProduct(productId) {
			// alert(productId)
			let check = confirm('정말로 삭제하시겠습니까?')
			if( check ) {
				location.href = 'delete_pro.jsp?id=' + productId
			} 
		}
	</script>
</body>
</html>





