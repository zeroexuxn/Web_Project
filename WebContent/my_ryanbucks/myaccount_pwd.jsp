<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<title>My Ryanbucks | Ryanbucks Korea</title>

<link href="../common/css/reset.css" rel="stylesheet"> <!-- 헤더, 푸터 -->
<link href="../common/css/style_main.css" rel="stylesheet"> <!-- 헤더, 푸터 -->
<link href="/RYANBUCKS_v1.0/common/img/logo.png" rel="short icon" type="image/ico">
	<script>
		function checker() {
		    var pwd = document.getElementById("password").value;
		    var cpwd = document.getElementById("check_password").value;
		    var submit_button = document.getElementById("subB");
		    var check_td = document.getElementById("check_td");
	
		    if (cpwd == "") {
		        check_td.innerHTML = "";
		    } else if (pwd == cpwd) {
		        check_td.innerHTML = "<font color='green'>일치</font>";
		        submit_button.disabled = false;
		    } else {
		        check_td.innerHTML = "<font color='red'>불일치</font>";
		        submit_button.disabled = true;
		    }
		}
	</script>
	<script>
		function backhome(){// 이미지를 클릭했을 때 실행할 함수
	        window.location.href = '../login/login.jsp'; // ./login/login.jsp 로 이동
		}
	</script>
	<jsp:include page="/header.jsp" />
	<link href="../common/css/myaccount_pwd_style.css" rel="stylesheet">
	<%
    // 로그아웃 했을 때
    if(session.getAttribute("id") == null) {
	%>
		<script>window.location.href = '../login/login.jsp';</script>
	<%
	    } else {
	%>
	<div class="myaccount_pwd_wrap">
	<!-- 2. 게시물 목록 -->
		<form action="myaccount_pwd_process.jsp" method="post" class="myaccount_pwd_form">
		<!-- 이미지 -->
		<div class="logo_img" onclick="backhome()"></div>
		<!-- /이미지 -->
		<!-- 환영합니다 -->
		<p class="text_justmyaccountpwd"><span><%=session.getAttribute("id") %></span>님의 비밀번호를 변경합니다.</p>
		<p class="text_guide">
		새로 사용할 비밀번호를 등록해주세요.
		</p>
		<table class="main_table">
			<tr>
	            <td class="first_table">
	                <div class="label-group">
	                    <label for="password">비밀번호</label>
	                </div>
	            </td>
	            <td class="second_table">
	                <input type="password" class="input_box" id="password" name="password" onkeyup="checker()" required>
	            </td>
	        </tr>
	        <tr>
	            <td class="first_table">
	                <div class="label-group">
	                    <label for="check_password">비밀번호 확인</label>
	                </div>
	            </td>
	            <td class="second_table">
	                <input type="password" class="input_box" id="check_password" onkeyup="checker()" required>
	            	<label id="check_td"></label>
	            </td> 
	        </tr>
	        <tr>
				<td colspan="2">
					<input type=submit value="비밀번호 변경" id="myaccount_pwd_btn">
				</td>
			</tr>
		</table>
		</form>
    </div>
	<% } %>
<jsp:include page="/footer.jsp" />
