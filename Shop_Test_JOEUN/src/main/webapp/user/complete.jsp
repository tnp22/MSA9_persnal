<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Shop</title>
	<jsp:include page="/layout/meta.jsp" />
	<jsp:include page="/layout/link.jsp" />
</head>
<body>   
	<% String root = request.getContextPath(); 
		int msg =Integer.parseInt(request.getParameter("msg"));
		String loginId = (String) session.getAttribute("loginId");
	%>
	
	<jsp:include page="/layout/header.jsp" />
	<div class="px-4 py-5 my-5 text-center">
		<h1 class="display-5 fw-bold text-body-emphasis">회원 정보</h1>
		
	</div>
	<!-- 회원 가입/수정/탈퇴 완료 -->
	<div class="container mb-5 text-center">
		<%if(msg==0){%>
				<p class="display-6 fw-bold text-body-emphasis fs-25"><%=loginId%>님 환영합니다.</p>
		<%} else if(msg==1){%>
				<p class="display-6 fw-bold text-body-emphasis fs-25">회원가입을 환영합니다.</p>
				<br>
		<%	}else if(msg==2){%>
				<p class="display-5 fw-bold text-body-emphasis fs-25">회원 정보가 수정되었습니다.</p>
				<br>
		<%	}else if(msg==3){%>
				<p class="display-5 fw-bold text-body-emphasis fs-25">회원 정보가 삭제되었습니다.</p>
				<br>
		<%	}%>
		<a href="../index.jsp" class="btn btn-lg btn-primary">메인으로</a>
	</div>
	
	<jsp:include page="/layout/footer.jsp" />
	<jsp:include page="/layout/script.jsp" />
</body>
</html>







