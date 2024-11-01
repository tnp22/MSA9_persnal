<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Shop</title>
	<jsp:include page="/layout/meta.jsp" /> <jsp:include page="/layout/link.jsp" />
</head>
<body>   
	
	<jsp:include page="/layout/header.jsp" />
	<div class="px-4 py-5 mt-5 text-center">
		<h1 class="display-5 fw-bold text-body-emphasis">회원 가입</h1>
	</div>
	
	<!-- 회원 가입 영역 -->
	<div class="container shop p-5 mb-5" >
		<form action="join_pro.jsp" onsubmit="return checkJoin()" name="joinForm" method="post" >
		
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-4" id="">아이디</label>
				<input type="text" class="form-control col-md-8" 
					   name="id" placeholder="아이디" required>
			</div>
			
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-4" id="">비밀번호</label>
				<input type="password" class="form-control col-md-8" 
					   name="pw" placeholder="비밀번호" required>
			</div>
			
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-4" id="">비밀번호 확인</label>
				<input type="password" class="form-control col-md-8" 
					   name="pw_confirm" placeholder="비밀번호 확인" required>
			</div>
			
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-4" id="">이름</label>
				<input type="text" class="form-control col-md-8" 
					   name="name" placeholder="이름" required>
			</div>
			
			<div class="input-group mb-3 row">
				<div class="col-md-4 p-0">
					<label class="input-group-text" id="">성별</label>
				</div>
				<div class="col-md-8 d-flex align-items-center">
					<div class="radio-box d-flex">
						<div class="radio-item mx-3">
							<input type="radio" class="form-check-input" name="gender" value="여" id="gender-female"> 
							<label for="gender-female">여자</label>
						</div>
						
						<div class="radio-item mx-3">
							<input type="radio" class="form-check-input " name="gender" value="남" id="gender-male"> 
							<label for="gender-male">남자</label>
						</div>
						
					</div>
				</div>
			</div>
			
			
			<div class="input-group mb-3 row">
				<div class="col-md-4 p-0">
					<label class="input-group-text" id="">생일</label>
				</div>
				<div class="col-md-8 p-0">
					<div class="row d-flex justify-content-between w-100 m-0">
						<div class="col-4 col-md-4 px-0">
							<input type="text" class="form-control" name="year" placeholder="출생년도 " size="6" />
						</div>
						
						<div class="col-4 col-md-4 pr-0">
							<select name="month" class="h-100 form-select" >
								<option value="01">1월</option>
								<option value="02">2월</option>
								<option value="03">3월</option>
								<option value="04">4월</option>
								<option value="05">5월</option>
								<option value="06">6월</option>
								<option value="07">7월</option>
								<option value="08">8월</option>
								<option value="09">9월</option>
								<option value="10">10월</option>
								<option value="11">11월</option>
								<option value="12">12월</option>
							</select>
						</div>
						
						<div class="col-4 col-md-4 px-0">
							<input type="text" class="form-control" name="day" placeholder="일자" size="4" />
						</div>
					</div>
				</div>
			</div>
			
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-4" id="">이메일</label>
				
				<div class="row justify-content-between col-md-8 align-items-center p-0">
					<div class="col-sm-5 col-md-5 px-0">
						<input type="text" class="form-control" 
							   name="email1" placeholder="이메일">
					</div>
					<div class="d-none d-sm-block col-sm-auto col-auto px-0 text-center">
						@
					</div>
					<div class="col-sm-6 col-md-6 px-0">
						<select name="email2" class="form-select">
							<option value="naver.com">naver.com</option>
							<option value="gmail.com">gmail.com</option>
							<option value="kakao.com">kakao.com</option>
						</select>
					</div>
				</div>
			</div>
			
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-4" id="">전화번호</label>
				<input type="text" class="form-control col-md-8" 
					   name="phone" placeholder="전화번호">
			</div>
			
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-4" id="">주소</label>
				<input type="text" class="form-control col-md-8" 
					   name="address" placeholder="주소">
			</div>
			
			
			<div class="d-grid gap-2 mt-5 mb-5 d-md-flex justify-content-md-between">
				<a href="javascript: history.back()" class="btn btn-lg btn-secondary">취소</a>
				<input type="submit" class="btn btn-lg btn-primary" value="가입" />
			</div>	
			
			
		</form>
	
	</div>
	
	
	<jsp:include page="/layout/footer.jsp" />
	<jsp:include page="/layout/script.jsp" />
	
		<script>
	
		// 회원가입 유효성 검사
		function checkJoin() {
			let form = document.joinForm	// name이 joinForm 인 폼 요소를 가져옴
			
			let id = form.id.value
			let pw = form.pw.value
			let pw_confirm = form.pw_confirm.value
			
			let regExpName = /^[가-힣]*$/
			let regExpId = /^[a-zA-Zㄱ-ㅎㅏ-ㅣ가-힣]+$/
			let regExpPw = /^(?=.*[!@#$%^&*()_+=-])[가-힣a-zA-Z0-9!@#$%^&*()_+=-]*$/

			let regExpDay = /^[0-9]{2,}$/
			
			// alert(id)
			// alert(pw)
			
			// 1. 아이디는 필수값, 6~20자 이내
			// 아이디 입력여부 검증
			if( id == "" ) {
				alert('아이디를 입력해주세요')
				form.id.focus()			// id input 태그에 포커스
				return false
			}
			
			if( !regExpId.test(id) ) {
				alert('영문자 또는 한글로 시작하시오.')
				return false
			}
			
/* 			// 아이디 글자 수 검증
			if( id.length < 6 || id.length > 20 ) {
				alert('아이디는 6~20자 이내로 입력 가능합니다.')
				form.id.select()		// id 입력 값을 선택
				return false
			} */
			// 2. 비밀번호는 필수값, 6자 이상
			// 비밀번호 입력여부 검증
			if( pw == "" ) {
				alert('비밀번호를 입력해주세요')
				form.pw.focus()			// id input 태그에 포커스
				return false
			}
			
 			if( !regExpPw.test(pw) ) {
				alert('최소 하나의 특수문자를 사용하시오')
				return false
			} 
			
			// 비밀번호 글자 수 검증
			if( pw.length < 6 ) {
				alert('비밀번호는 6자 이상으로 입력해야합니다.')
				form.pw.focus()		// id 입력 값을 선택
				return false
			}
			
			if( pw !== pw_confirm ) {
				alert('확인 비번이 다릅니다')
				form.pw_confirm.select()		// id 입력 값을 선택
				return false
			}
			

			
			
			let name = form.name.value
			
			if( name == "" ) {
				alert('이름을 입력해주세요')
				form.name.focus()
				return false
			}
			
			if( !regExpName.test(name) ) {
				alert('이름은 한글만 가능합니다.')
				return false
			}
			
/* 			// isNaN() : 숫자가 아니면 true
			if( !isNaN( name.substr(0, 1) ) ) {
				alert('이름은 숫자로 시작할 수 없습니다.')
				form.name.select()
				return false
			} */
			
			let year = form.year.value
			
			// isNaN() : 숫자가 아니면 true
			if( year === "" || isNaN(year) ) {
				alert('year는 숫자로만 구성되어야합니다.')
				form.year.select()
				return false
			}
			
			let day = form.day.value
			if( !regExpDay.test(day) ) {
				alert('두 글자 이상 숫자')
				return false
			}
			// isNaN() : 숫자가 아니면 true
			if(day === "" || isNaN(day) || day>31 ) {
				alert('day는 숫자로만 구성되어야합니다 또는 31 초과')
				form.day.select()
				return false
			}
			let phone = form.phone.value
			// isNaN() : 숫자가 아니면 true
			if(phone === "" || isNaN(phone) ) {
				alert('전화번호는 숫자로만 구성되어야합니다.')
				form.phone.select()
				return false
			}
			

			return true
		}
	</script>
	
</body>
</html>








