<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<title>로그인 | Ryanbucks Korea</title>
<link href="../common/css/reset.css" rel="stylesheet"> <!-- 헤더, 푸터 -->
<link href="../common/css/style_main.css" rel="stylesheet"> <!-- 헤더, 푸터 -->
<link href="/RYANBUCKS_v1.0/common/img/logo.png" rel="short icon" type="image/ico">
	<script>
		function validateForm(form){
			
			// 아이디를 입력하지 않았을 때
			if(!form.user_id.value){
				alert("아이디를 입력하세요.");
				form.user_id.focus();
				return false; //로그인이 실패시 다음단계로 안넘어가도록
			}
			// 패스워드를 입력하지 않았을 때
			if(!form.user_pass.value){
				alert("패스워드를 입력하세요.");
				form.user_pass.focus();
				return false; //로그인이 실패시 다음단계로 안넘어가도록
			}
			
		}
	</script>
	<jsp:include page="/header.jsp" />
<link href="../common/css/login_style.css" rel="stylesheet">

	<%
	//로그아웃 했을 때
	if(session.getAttribute("id")== null && session.getAttribute("out_date")== null){
	%>
	<!-- 로그인 -->
	<div class="login_wrap">
		<form method="get" action="login_process.jsp" onsubmit="return validateForm(this);" class="login_form"> <!-- validate -->
		<!-- 이미지 -->
		<div class="logo_img"></div>
		<!-- /이미지 -->
		<!-- 환영합니다 -->
		<p class="text_welcome">
			<span>Welcome!</span> 라이언벅스에 오신 것을 환영합니다.
		</p>
		<!-- /환영합니다 -->
		<div class = "input_box">
			<!-- 아이디 -->
			<input class = "input_text_box"  id="txt_user_id" name="id" type="text" maxlength="20" placeholder="아이디를 입력해 주세요." required="required">
			<br/>
			<!-- /아이디 -->
			<!-- 패스워드 -->
			<input class = "input_text_box"  id="txt_user_pwd" name="password" type="password" maxlength="20" placeholder="비밀번호를 입력해 주세요." required="required" autocomplete="off">
			<br/>
			<!-- 로그인 하기 -->
				<!--  <button type="button" onclick="href=javascript:void(0)">로그인</button> -->
			<input class = "login_btn" type=submit value="로그인">
			<!-- /로그인 하기 -->
		</div>
		<div class="login_btn_wrap">
			<ul>
				<li><a href="join.jsp" id="join_btn">회원가입</a></li>
				<li><a href="find_id.jsp" id="find_id_btn">아이디 찾기</a></li>
				<li><a href="find_pwd.jsp" id="find_pwd_btn">비밀번호 찾기</a></li>
			</ul>
		</div>	
		</form>
	</div>
	<!-- 로그인 -->
	<%
    } else if (session.getAttribute("id") == null && session.getAttribute("out_date") != null) {
	%>
	    <script>
	        JSPFunction.alertBack("회원탈퇴한 회원은 로그인 할 수 없습니다.", out);
	    </script>
	<%
	    } else {
	%>
		<script>
	        location.href="/RYANBUCKS_v1.0/index.jsp";
	    </script>
	<%
	    }
	%>
<jsp:include page="/footer.jsp" />


