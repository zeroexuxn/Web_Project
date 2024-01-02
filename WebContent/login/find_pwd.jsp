<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<title>비밀번호 찾기 | Ryanbucks Korea</title>

<link href="../common/css/reset.css" rel="stylesheet"> <!-- 헤더, 푸터 -->
<link href="../common/css/style_main.css" rel="stylesheet"> <!-- 헤더, 푸터 -->
<link href="/RYANBUCKS_v1.0/common/img/logo.png" rel="short icon" type="image/ico">
<jsp:include page="/header.jsp" />
<link href="../common/css/find_pwd_style.css" rel="stylesheet">


<!-- 비밀번호 찾기 -->
<div class="find_pwd_wrap">
	<form action="find_pwd_process.jsp" method="post" class="find_pwd_form">
		<script>
			function backhome(){// 이미지를 클릭했을 때 실행할 함수
		        window.location.href = 'login.jsp'; // ./login/login.jsp 로 이동
			}
		</script>
		<!-- 이미지 -->
		<div class="logo_img" onclick="backhome()"></div>
		<!-- /이미지 -->
		<!-- 환영합니다 -->
		<p class="text_justfindpwd">비밀번호가 기억나지 않으신가요?</p>
		<p class="text_guide">
		아이디과 연락처를 입력하시면 비밀번호를 찾아드립니다.
		</p>
		<table>
			<tr>
				<td class="first_table">
					<!-- 아이디 -->
					<div class="label-group">
				    	<label for="id">아이디</label>
				    </div>
				</td>
				<td class="second_table">
					<input class="input_box" id="id" name="id" type="text" maxlength="20" placeholder="아이디를 입력해 주세요." required>
					<br>
				</td>
			<tr>
				<td class="first_table">
					<!-- /아이디 -->
					<!-- 연락처 -->
					<div class="label-group">
					    <label for="areaTel">연락처</label>
					</div>
				</td>
				<td class="second_table">
					    <select class="input_box" id="countryTel" name="countryTel" required>
					       <option value="010">010</option>
					       <option value="011">011</option>
					       <option value="016">016</option>
					       <option value="010">017</option>
					       <option value="011">019</option>
						</select>
						-
						<input type="text" class="input_box" id="areaTel" name="areaTel" required>
						-
						<input type="text" class="input_box" id="userTel" name="userTel" required>
					    <!-- /연락처 -->
				</td>
			<tr>
				<td colspan="2">
					<input type=submit value="비밀번호 찾기" id="find_pwd_btn">
				</td>
			</tr>
		</table>
	</form>
</div>
<!-- /비밀번호 찾기 -->
<jsp:include page="/footer.jsp" />