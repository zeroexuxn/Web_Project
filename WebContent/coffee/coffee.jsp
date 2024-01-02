<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>COFFEE | Ryanbucks Korea</title>
	<link href="/RYANBUCKS_v1.0/common/css/reset.css" rel="stylesheet"> <!-- 헤더, 푸터 -->
	<link href="/RYANBUCKS_v1.0/common/css/style_main.css" rel="stylesheet"> <!-- 헤더, 푸터 -->
	<link href="/RYANBUCKS_v1.0/common/css/style_coffee.css" rel="stylesheet">
	<link href="/RYANBUCKS_v1.0/common/img/logo.png" rel="short icon" type="image/ico">
</head>
<body>
<jsp:include page="/header.jsp" />
<div id="container">

	<!-- sub_tit_wrap -->
	<div class="sub_tit_wrap">
		<div class="sub_tit_inner">
			<h2>
				<img src="/RYANBUCKS_v1.0/non_co_img/sub_title/coffee_tit.jpg" alt="COFFEE">
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
					<a href="javascript:void(0)" class="this">COFFEE</a>
				</li>
			</ul>
		</div>
	</div>	<!-- //sub_tit_wrap -->
	
	<!-- coffee_hs_wrap, 커피 이야기 -->
	<section class="coffee_hs_wrap">
		<div class="coffee_wrap_inner">
			<p class="coffee_hs_txt">
				<img class="w_pic" src="/RYANBUCKS_v1.0/non_co_img/coffee/coffee_story_txt.png" alt=" 커피 이야기 한 잔의 완벽한 커피를 위한 스타벅스의 여정 커피 농장에서부터 당신의 취향에 꼭 맞춘 한 잔의 커피가 되기까지. 스타벅스의 커피 이야기를 만나보세요.">
			</p>
			<div class="coffee_hs_btn">
				<a href="/RYANBUCKS_v1.0/coffee/coffee_story.jsp">자세히 보기</a>
			</div>
		</div>	<!-- //coffee_wrap_inner -->
	</section>	<!-- //coffee_hs_wrap -->
	
	
	<!-- coffee_espresso_wrap, 에스프레소 음료 -->
	<section class="coffee_espresso_wrap">
		<div class="coffee_wrap_inner">
			<p class="coffee_espresso_txt">
				<img class="w_pic" src="/RYANBUCKS_v1.0/non_co_img/coffee/coffee_espresso_txt.png" alt="에스프레소 음료 스타벅스만의 특별한 에스프레소로 만들어진 음료 순수하고 강렬한 에스프레소 풍미의 도피오, 완벽하게 만들어진 부드러운 크림 블렌드의 라떼 등 에스프레소로 즐길 수 있는 음료들을 만나보세요.">
			</p>
			<div class="coffee_espresso_btn">
				<a href="/RYANBUCKS_v1.0/coffee/espresso.jsp">자세히 보기</a>
			</div>
		</div>	<!-- //coffee_wrap_inner -->
	</section>	<!-- //coffee_espresso_wrap -->

</div> <!-- //container -->
<jsp:include page="/footer.jsp" />
</body>
</html>