<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MENU | Ryanbucks Korea</title>
<link href="/RYANBUCKS_v1.0/common/css/reset.css" rel="stylesheet"> <!-- 헤더, 푸터 -->
<link href="/RYANBUCKS_v1.0/common/css/style_main.css" rel="stylesheet"> <!-- 헤더, 푸터 -->
<link href="/RYANBUCKS_v1.0/common/css/style_menu.css" rel="stylesheet">
<link href="/RYANBUCKS_v1.0/common/img/logo.png" rel="short icon" type="image/ico">
</head>
<body>
<jsp:include page="/header.jsp" />
<div id="container">
	<!-- sub_tit_wrap -->
	<div class="sub_tit_wrap">
		<div class="sub_tit_inner">
			<h2>
				<img src="/RYANBUCKS_v1.0/non_co_img/sub_title/menu_tit.jpg" alt="MENU">
			</h2>
			<ul class="smap">
				<li>
					<a href="/RYANBUCKS_v1.0/index.jsp">
						<img src="/RYANBUCKS_v1.0/common/img/icon_home.png" alt="홈으로">
					</a>
				</li>
				<li>
					<img class="arrow" src="/RYANBUCKS_v1.0/common/img/icon_arrow.png" alt="하위메뉴">
				</li>
				<li class="en">
					<a href="javascript:void(0)" class="this">MENU</a>
				</li>
			</ul>
		</div>
	</div>	<!-- //sub_tit_wrap -->
	
	<!-- menu_drink_section, 음료 -->
	<div class="menu_drink_section">
		<div class="menu_section_inner">
			<div class="menu_drink_txt01">
				<img class="w_pic" src="/RYANBUCKS_v1.0/non_co_img/sub_title/drink_txt.png" alt="음료 바리스타의 숙련된 기술로 취향까지 담은 음료를 경험해 보세요. 한 잔의 음료에 원하시는 취향과 스타벅스 경험까지 모두 담았습니다.">
			</div>
			<div class="menu_drink_btn01">
				<a href="drink_list.jsp" title="라이언벅스 음료 자세히 보기">자세히 보기</a>
			</div>
		</div>	<!-- //menu_section_inner -->
	</div>	<!-- //menu_drink_section -->
	
	<!-- menu_food_section, 푸드 -->
	<div class="menu_food_section">
		<div class="menu_section_inner">
			<div class="menu_food_txt01">
				<img class="w_pic" src="/RYANBUCKS_v1.0/non_co_img/sub_title/food_txt.png" alt="푸드 신선한 식재료로 만든 다양한 푸드를 소개합니다. 간편하면서 영양 가득한 스타벅스 푸드가 당신의 완벽한 하루를 채워 드립니다.">
			</div>
			<div class="menu_food_btn01">
				<a href="food_list.jsp" title="라이언벅스 푸드 자세히 보기">자세히 보기</a>
			</div>
		</div>	<!-- //menu_section_inner -->
	</div>	<!-- //menu_food_section -->
</div>	
<!-- //container -->	
<jsp:include page="/footer.jsp" />
</body>
</html>