<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int status = response.getStatus();

	if(status == 404) {
		System.out.println("404 에러가 발생했습니다. 파일 경로를 확인해주세요.");
	} else if(status == 405) {
		System.out.println("405 에러가 발생했습니다. 요청 방식(method)을 확인해주세요.");
	} else if(status == 500) {
		System.out.println("500 에러가 발생했습니다. 소스 코드에 오류가 없는지 확인해 주세요.");
	}
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Ryanbucks Korea</title>
	
	<link href="/RYANBUCKS_v1.0/common/css/reset.css" rel="stylesheet">
	<link href="/RYANBUCKS_v1.0/common/css/style_error.css" rel="stylesheet">
	<link href="/RYANBUCKS_v1.0/common/img/logo.png" rel="short icon" type="image/ico">
</head>
<body>
	<div id="wrap">
		<!-- container -->
		<div id="container">
			<div class="unusual_contact_wrap">
				<strong class="unusual_contact_emphasis">서비스 <span class="t_006633">이용에 불편</span>을 드려 죄송합니다.</strong>
				<p>요청한 웹페이지의 이름이 바뀌었거나 현재 <strong>사용할 수 없거나 삭제</strong>되었습니다.<br>입력하신 주소가 정확한지 <strong>다시 한번 확인해보시기 바랍니다.</strong></p>
				<ul class="unusual_contact_btns">
					<li><a href="/RYANBUCKS_v1.0/index.jsp">메인 페이지로 이동</a></li>
				</ul>
			</div>
		</div>
		<!-- // container-->
	</div>
</body>
</html>