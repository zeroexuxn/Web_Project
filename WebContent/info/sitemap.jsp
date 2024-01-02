<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>사이트맵 | Ryanbucks Korea</title>
	
	<link href="/RYANBUCKS_v1.0/common/css/reset.css" rel="stylesheet"> <!-- 헤더, 푸터 -->
	<link href="/RYANBUCKS_v1.0/common/css/style_main.css" rel="stylesheet"> <!-- 헤더, 푸터 -->
	<link href="/RYANBUCKS_v1.0/common/css/style.css" rel="stylesheet">
	<link href="/RYANBUCKS_v1.0/common/css/style_info.css" rel="stylesheet">
	<link href="/RYANBUCKS_v1.0/common/img/logo.png" rel="short icon" type="image/ico">
</head>
<body>
	<!-- wrap -->
	<div id="wrap">
		<jsp:include page="/header.jsp" />
		<!-- container -->
		<div id="container">
			<!-- 서브 타이틀 -->
			<div class="ms_sub_tit_wrap">
				<div class="ms_sub_tit_bg">
					<div class="ms_sub_tit_inner">
						<h2>
							<img src="/RYANBUCKS_v1.0/non_co_img/sub_title/sitemap_tit.png" alt="사이트맵">
						</h2>
						<ul class="smap">
							<li><a href="/RYANBUCKS_v1.0/index.jsp"><img src="/RYANBUCKS_v1.0/common/img/icon_home_w.png" alt="홈으로"></a>
							</li>
							<li>
								<img class="arrow" src="/RYANBUCKS_v1.0/common/img/icon_arrow_w.png" alt="하위메뉴">
							</li>
							<li>
								<a href="/RYANBUCKS_v1.0/info/sitemap.jsp" class="en">INFO</a>
							</li>
							<li>
								<img class="arrow" src="/RYANBUCKS_v1.0/common/img/icon_arrow_w.png" alt="하위메뉴">
							</li>
							<li>
								<a href="javascript:void(0);" class="this">사이트맵</a>
							</li>
						</ul>
					</div>
				</div>
			</div>
			<!-- // 서브 타이틀 -->
			
			<!-- 내용 -->
			<div class="ms_cont_wrap">
				<!-- ms_cont -->
				<div class="ms_cont">
					<p class="sitemap_tit">라이언벅스 코리아 사이트 맵입니다.</p>
					
					<table summary="사이트맵" class="sitemap">
						<caption class="hid">사이트맵 테이블</caption>
						
						<tr>
							<th class="fth" scope="row"><a href="javascript:void(0);">INFO</a></th>
							<td class="ftd">
								<ul class="sitemap">
									<li>
										<dl>
											<dt><a href="/RYANBUCKS_v1.0/info/sitemap.jsp">사이트맵</a></dt>
										</dl>
									</li>
								</ul>
							</td>
						</tr>

						<tr>
							<th scope="row"><a href="/RYANBUCKS_v1.0/coffee/coffee.jsp">COFFEE</a></th>
							<td>
								<ul class="sitemap">
									<li>
										<dl>
											<dt><a href="/RYANBUCKS_v1.0/coffee/coffee_story.jsp">커피 이야기</a>
										</dl>
									</li>
									<li>
										<dl>
											<dt><a href="/RYANBUCKS_v1.0/coffee/espresso.jsp">에스프레소 음료</a>
										</dl>
									</li>
								</ul>
							</td>
						</tr>
						
						<tr>
							<th scope="row"><a href="/RYANBUCKS_v1.0/menu/menu.jsp">MENU</a></th>
							<td>
								<ul class="sitemap">
									<li>
										<dl>
											<dt><a href="/RYANBUCKS_v1.0/menu/drink_list.jsp">음료</a>
										</dl>
									</li>
									<li>
										<dl>
											<dt><a href="/RYANBUCKS_v1.0/menu/food_list.jsp">푸드</a>
										</dl>
									</li>
								</ul>
							</td>
						</tr>
						
						<tr>
							<th scope="row"><a href="/RYANBUCKS_v1.0/event/campaign_list.jsp">EVENT</a></th>
							<td>
								<ul class="sitemap">
									<li>
										<dl>
											<dt><a href="/RYANBUCKS_v1.0/event/campaign_list.jsp">진행중인 이벤트</a></dt>
										</dl>
									</li>
									<li>
										<dl>
											<dt><a href="/RYANBUCKS_v1.0/event/campaign_ended_list.jsp">종료된 이벤트</a></dt>
										</dl>
									</li>
								</ul>
							</td>
						</tr>
						
						<tr>
							<th scope="row"><a href="/RYANBUCKS_v1.0/notice/notice_list.jsp">NOTICE</a></th>
							<td>
								<ul class="sitemap">
									<li>
										<dl>
											<dt><a href="/RYANBUCKS_v1.0/notice/notice_list.jsp">공지사항</a></dt>
										</dl>
									</li>
								</ul>
							</td>
						</tr>
						
						<tr>
							<th scope="row"><a href="/RYANBUCKS_v1.0/my_ryanbucks/index.jsp">MY<br>RYANBUCKS</a></th>
							<td>
								<ul class="sitemap">
									<li>
										<dl>
											<dt><a href="javascript:void(0);">개인정보관리</a></dt>
											<dd><a href="/RYANBUCKS_v1.0/my_ryanbucks/myaccount_info.jsp">- 개인정보 확인 및 수정 </a></dd>
											<dd><a href="/RYANBUCKS_v1.0/my_ryanbucks/myaccount_out.jsp">- 회원 탈퇴 </a></dd>
											<dd><a href="/RYANBUCKS_v1.0/my_ryanbucks/myaccount_pwd.jsp">- 비밀번호 변경 </a></dd>
										</dl>
									</li>
									<li>
										<dl>
											<dt><a href="/RYANBUCKS_v1.0/my_ryanbucks/order_list.jsp">주문내역</a></dt>	
										</dl>
									</li>
									<li>
										<dl>
											<dt><a href="/RYANBUCKS_v1.0/review/review.jsp">리뷰 관리</a></dt>
										</dl>
									</li>
								</ul>
							</td>
						</tr>
						
						<tr>
							<th scope="row"><a href="/RYANBUCKS_v1.0/login/login.jsp">LOGIN</a></th>
							<td>
								<ul class="sitemap">
									<li>
										<dl>
											<dt><a href="/RYANBUCKS_v1.0/login/login.jsp">로그인</a></dt>
										</dl>
									</li>
									<li>
										<dl>
											<dt><a href="/RYANBUCKS_v1.0/login/find_id.jsp">아이디 찾기</a></dt>
										</dl>
									</li>
									<li>
										<dl>
											<dt><a href="/RYANBUCKS_v1.0/login/find_pwd.jsp">비밀번호 찾기</a></dt>
										</dl>
									</li>
									<li>
										<dl>
											<dt><a href="/RYANBUCKS_v1.0/login/join.jsp">회원가입</a></dt>
										</dl>
									</li>
								</ul>
							</td>
						</tr>
						
						<tr>
							<th scope="row"><a href="/RYANBUCKS_v1.0/cart/cart.jsp">CART</a></th>
							<td>
								<ul class="sitemap">
									<li>
										<dl>
											<dt><a href="/RYANBUCKS_v1.0/cart/cart.jsp">장바구니</a></dt>
										
										</dl>
									</li>
									<li>
										<dl>
											<dt><a href="/RYANBUCKS_v1.0/cart/cart.jsp">주문</a></dt>
										</dl>
									</li>
								</ul>
							</td>
						</tr>
					</table>
				</div>
				<!-- // ms_cont -->
			</div>
			<!-- // 내용 -->
		</div>
		<!-- // container -->
		<jsp:include page="/footer.jsp" />
	</div>
	<!-- // wrap -->
</body>
</html>