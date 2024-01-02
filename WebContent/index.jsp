<%@page import="cart.CartDTO"%>
<%@page import="java.util.List"%>
<%@page import="cart.CartDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Ryanbucks Korea</title>
	<link href="/RYANBUCKS_v1.0/common/css/reset.css" rel="stylesheet"> <!-- 헤더, 푸터 -->
	<link href="/RYANBUCKS_v1.0/common/css/style_main.css" rel="stylesheet"> <!-- 헤더, 푸터 -->
	<link href="/RYANBUCKS_v1.0/common/css/style_main_newProm.css" rel="stylesheet">
	<link href="/RYANBUCKS_v1.0/common/img/logo.png" rel="short icon" type="image/ico">
	
	<style type="text/css">
		.main-visual_wrap {height: 32vw; background-image: url("./non_co_img/main/2023_disney2_top_bg.jpg");}
		.main-visual_wrap .main-visual_inner {max-width: 100%;}
		.main-visual_slogan, .btn_slogan {position: absolute; width: 25.6%; left: 10%;}
		.main-visual_slogan {top: 36%;}
		.btn_slogan {z-index: 10; top: 60%; text-align: center;}
		.btn_slogan a {width: 24%; margin: 0 auto; color: #401b0d; border: 2px solid #401b0d;
		transition: background-color .7s, color .7s, border-color .7s; -webkit-transition:background-color .7s, 
		color .7s, border-color .7s; text-decoration: none;}
		.btn_slogan a:hover {background-color: #401b0d; color: #fff; text-decoration: underline;}
		
		.main-visual_set {height: 100%;}
		.set_01 {z-index: 9; top: 10.8%; left: 36%; width: 17.3%;}
		.set_02 {z-index: 8; top: 47%; left: 65.7%; width: 16.5%;}
		.set_03 {z-index: 6; top: 19%; right: 28%; width: 16%;}
		
		.set_common: after {display: none;}
		
		#favWrap {background: url("./non_co_img/main/230921_1_pc_pick_bg.jpg") center center fixed no-repeat #45434c; 
		background-size: auto 87%; height: 800px; padding: 0; position: relative; background-position: bottom;}
		.fav_img {top: 100px; right: -163px; width: 912px; height: 575px; background-image: url("./non_co_img/main/2023_disney2_pick_img.png");}
	</style>
</head>
<body>
<div id="wrap">
<jsp:include page="/header.jsp" />

	<!-- 메인페이지 -->
	<div id="container">
		<!-- 메인페이지 배너 -->
		<div id="topWrap">
			<div class="main-visual_wrap">
				<div class="main-visual_inner">
					<div class="main-visual_slogan" style="opacity:1;">
						<img src="/RYANBUCKS_v1.0/non_co_img/main/2023_disney2_top_logo.png" alt="LOVE ME" class="pc-slogan">
					</div>
					<div class="main-visual_set">
						<div class="set_common set_01" style="opacity: 1;">
							<img src="/RYANBUCKS_v1.0/non_co_img/main/2023_disney2_top_drink1.png" alt="미니 블루베리 요거트 프라푸치노" class="pc-drink">
						</div>
						<div class="set_common set_02" style="opacity: 1;">
							<img src="/RYANBUCKS_v1.0/non_co_img/main/2023_disney2_top_drink2.png" alt="블랙 글레이즈드 라떼" class="pc-drink">
						</div>
						<div class="set_common set_03" style="opacity: 1;">
							<img src="/RYANBUCKS_v1.0/non_co_img/main/2023_disney2_top_drink3.png" alt="마롱 헤이즐넛 라떼" class="pc-drink">
						</div>
					</div>
					<div class="btn_slogan" style="opacity: 1;">
							<a href="/RYANBUCKS_v1.0/event/campaign_view.jsp?event_no=1">자세히 보기</a>
					</div>
				</div>
			</div>
		</div>
		<!-- //메인페이지 배너 -->
	
		<!-- 리워드 배너 -->
		
		<!-- 로그아웃 상태 -->
		
		<% if(session.getAttribute("id") == null) { %>
		 <section class="new-rewards_wrap">
			<div class="new-rewards_inner">
				<div class="new-rewards_logo">
					<img src="./non_co_img/main/logo_rewards.png" alt="Ryanbucks Rewards">
				</div>
				<div class="new-rewards_conts">
					<div class="info-cont">
						<div class="info-cont_txt">
							<h2>
								라이언벅스만의 특별한 혜택,
								<br class="pc-br">
								<strong>라이언벅스 리워드</strong>
							</h2>
							<p>
								<strong>라이언벅스 회원이세요?</strong>
								로그인을 통해 나만의 라이언벅스를 확인해보세요.
								<br>
								<strong>라이언벅스 회원이 아니세요?</strong>
								회원가입하고 라이언벅스의 혜택을 즐기세요.
								
							</p>
						</div>
						<div class="btn-signin_group">
							<a href="/RYANBUCKS_v1.0/login/join.jsp" class="btn-signin_join">회원가입</a>
							<a href="/RYANBUCKS_v1.0/login/login.jsp" class="btn-signin_login">로그인
							</a>
						</div>
					</div>
				</div>
			</div>
		</section> 
		<!-- // 로그아웃 상태 -->
		<% } else { %>
		<!-- 로그인 상태 -->
		<div class="line_msr">
			<div class="line_msr_wrap msr_new">
				<div class="msr_lead">
					<a href="./my_ryanbucks/index.jsp">
						<p class="icon_msr_cup"></p>
						<div class="msr_info_area">
							<p class="msr_lead_txt">
								<span class="user_greet_txt">
									<strong><%=session.getAttribute("name") %></strong>님, 안녕하세요!
								</span>
								<span class="userNextStarTxt">
									<em>혜택에 편리함까지 더한</em>
									라이언벅스 리워드를 즐겨보세요.
								</span>
							</p>
						</div>
					</a>
				</div>
			</div>
		</div>
		<!-- // 로그인 상태 -->
		<%} %>
		<!-- //리워드 배너 -->
		<!-- fav 배너 -->
		<section id="favWrap" class="winter_fav_bg">
			<div class="wrap_inner">
				<div class="fav_prod_txt01" style="opacity: 1; left: 200px;">PICK YOUR FAVORITE</div>
				<div class="fav_prod_txt02" style="opacity: 1; left: 92px;">
					"다양한 메뉴를 라이언벅스에서 즐겨보세요. 라이언벅스만의 특별함을 겸험할 수 있는 최상의 선택 음료,
					라이언벅스 커피와 황벽한 어울림을 자랑하는 푸드, 다양한 시도와 디자인으로 가치를 더하는 상품"
				</div>
				<div class="fav_img"></div>
				<div class="btn_fav_prod" style="opacity: 1;">
					<a href="/RYANBUCKS_v1.0/menu/menu.jsp"> 자세히 보기</a>
				</div>
			</div>
		</section>
		<!-- //fav 배너 -->
	</div>
	<!-- //메인페이지 -->	
<jsp:include page="footer.jsp" />
</div>
</body>
</html>