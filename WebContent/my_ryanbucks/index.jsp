<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	if(session.getAttribute("id") == null)
		response.sendRedirect("../login/login.jsp");
%>
<title>My Ryanbucks | Ryanbucks Korea</title>

<link href="../common/css/reset.css" rel="stylesheet"> <!-- 헤더, 푸터 -->
<link href="../common/css/style_main.css" rel="stylesheet"> <!-- 헤더, 푸터 -->
<link href="../common/css/myaccount_index_style.css" rel="stylesheet">
<link href="/RYANBUCKS_v1.0/common/img/logo.png" rel="short icon" type="image/ico">
<jsp:include page="/header.jsp" />
<div id="container">	
	<header class="ms_sub_tit_wrap">
		<div id="sub_tit_bg">
				<!-- 서브 타이틀 -->
				<!-- <div class="sub_tit_wrap"> -->
					<div class="sub_tit_inner">
						<h2>
							<img src="/RYANBUCKS_v1.0/non_co_img/sub_title/my_ryanbucks_tit.png" alt="My Ryanbucks">
						</h2>
						<ul class="smap">
							<li>
								<a href="/RYANBUCKS_v1.0/index.jsp">
									<img src="/RYANBUCKS_v1.0/common/img/icon_home_2.png" alt="홈으로">
								</a>
							</li>
							<li>
								<img class="arrow" src="/RYANBUCKS_v1.0/common/img/icon_arrow_2.png" alt="하위메뉴">
							</li>
							<li class="en">
								<a href="#">My Ryanbucks</a>
							</li>
						</ul>
					</div>	
				<!-- </div> -->
		<!-- //서브 타이틀 -->
		</div>
	</header>
	<div class="ms_content_wrap">
		<jsp:include page="/my_ryanbucks/navigation.jsp" />
		<div class="info" style="width:850px; height:700px">
			<img src="/RYANBUCKS_v1.0/common/img/ryan2.png" alt="라이언">
			<p class="user_info">
				<strong><%=session.getAttribute("name") %></strong>님, 안녕하세요!
			</p>
		</div>
	</div>
</div>
<!-- //container -->
<jsp:include page="/footer.jsp" />