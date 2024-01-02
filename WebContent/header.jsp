<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
	<!-- header 전체 -->
	<div id="mstopWrap">
		<div id="gnb">
			<div class="sub_gnb_wrap">
			<!-- header 중간부분(양옆 여백 제외) -->
			<div class="sub_gnb_wrap_inner">
				<!-- 로고 -->
				<h1 class="logo">
					<a href="/RYANBUCKS_v1.0/index.jsp" title="라이언벅스 메인페이지">라이언벅스 코리아</a>
				</h1>
				<!-- //로고 -->
				<!-- 상단 nav -->
				<nav class="util_nav">
					<ul>
						<%if(session.getAttribute("id") != null) { %>
						<!-- 로그인 상태(로그인 프로세스 완성하고 주석 풀기 -->
						<li class="util_nav01">
							<a href="/RYANBUCKS_v1.0/login/logout_process.jsp">Sign Out</a>
						</li>
						<!-- // 로그인 상태 -->
						
						<%} else {%>
						<!-- 로그아웃 상태 -->
						<li class="util_nav01 sign_in">
							<a href="/RYANBUCKS_v1.0/login/login.jsp">Sign In</a>
						</li>
						
						<li class="util_nav02">
							<a href="/RYANBUCKS_v1.0/login/join.jsp">Join</a>
						</li>
						<!-- // 로그아웃 상태 -->
						
						<%} %>
						<li class="util_nav03">
							<a href="/RYANBUCKS_v1.0/my_ryanbucks/index.jsp"">My Ryanbucks</a>
						</li>
					</ul>
				</nav>
				
				<!-- 장바구니 버튼 -->
				<p class="btn_cart">
					<a href="/RYANBUCKS_v1.0/cart/cart.jsp" role="button">
						<img alt="장바구니" src="/RYANBUCKS_v1.0/common/img/icon_cart.png">
					</a>
				</p>
				<!-- //장바구니 버튼 -->
				
				<!-- //상단 nav -->
			</div>
			<!-- //header 중간부분(양옆 여백 제외) -->
			<!-- 하단 nav -->
			<nav class="sub_gnb_nav">
				<div class="sub_gnb_nav_inner">
					<ul>
						<!-- INFORM -->
						<li class="gnb_nav01">
							<h2>
								<a href="/RYANBUCKS_v1.0/info/sitemap.jsp">INFO</a>
							</h2>
							
						</li>
						<!-- //INFORM -->
						<!-- COFFEE -->
						<li class="gnb_nav02">
							<h2>
								<a href="/RYANBUCKS_v1.0/coffee/coffee.jsp">COFFEE</a>
							</h2>
							
						</li>
						<!-- //COFFEE -->
						<!-- MENU -->
						<li class="gnb_nav03">
							<h2>
								<a href="/RYANBUCKS_v1.0/menu/menu.jsp">MENU</a>
							</h2>
							
						</li>
						<!-- //MENU -->
						<!-- EVENT -->
						<li class="gnb_nav04">
							<h2>
								<a href="/RYANBUCKS_v1.0/event/campaign_list.jsp">EVENT</a>
							</h2>

						</li>
						<!-- //EVENT -->
						<!-- NOTICE -->
						<li class="gnb_nav05">
							<h2>
								<a href="/RYANBUCKS_v1.0/notice/notice_list.jsp">NOTICE</a>
							</h2>
						</li>
						<!-- //EVENT -->
					</ul>
				</div>
			</nav>
			<!-- //하단 nav -->
			</div>
		</div>
	</div>
	<!-- //header 전체 -->

	</script>