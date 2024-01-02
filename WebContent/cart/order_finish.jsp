<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="order_total.*"%>
<%

	String order_id = request.getParameter("order_id");

	//DAO 생성 후 Oracle DB 연결
	OrderTotalDAO orderTotalDao = new OrderTotalDAO(application);
	
	// 데이터 불러오기
	OrderTotalDTO orderTotalDto = orderTotalDao.getOrderTotalDTO(order_id);
	
	// DB 연결 해제
	orderTotalDao.close();

%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>주문 완료 | Ryanbucks Korea</title>
	
	<link href="/RYANBUCKS_v1.0/common/css/reset.css" rel="stylesheet"> <!-- 헤더, 푸터 -->
	<link href="/RYANBUCKS_v1.0/common/css/style_main.css" rel="stylesheet"> <!-- 헤더, 푸터 -->
	<link href="/RYANBUCKS_v1.0/common/css/style.css" rel="stylesheet">
	<link href="/RYANBUCKS_v1.0/common/css/style_order.css" rel="stylesheet">
	<link href="/RYANBUCKS_v1.0/common/img/logo.png" rel="short icon" type="image/ico">
</head>
<body>
	<!-- wrap -->
	<div id="wrap">
		<jsp:include page="/header.jsp" />
		<!-- container -->
		<div id="container">
			<!-- 서브 타이틀 -->
			<div class="sub_tit_wrap">
				<div class="sub_tit_inner">
					<h2>
						<img src="/RYANBUCKS_v1.0/non_co_img/sub_title/order_tit.png" alt="주문">
					</h2>
					<ul class="smap">
						<li><a href="#"><img src="/RYANBUCKS_v1.0/common/img/icon_home.png" alt="홈으로"></a>
						</li>
						<li>
							<img class="arrow" src="/RYANBUCKS_v1.0/common/img/icon_arrow.png" alt="하위메뉴">
						</li>
						<li>
							<a href="/RYANBUCKS_v1.0/cart/cart.jsp">장바구니</a>
						</li>
						<li>
							<img class="arrow" src="/RYANBUCKS_v1.0/common/img/icon_arrow.png" alt="하위메뉴">
						</li>
						<li>
							<a href="javascript:void(0);" class="prev">주문</a>
						</li>
						<li>
							<img class="arrow" src="/RYANBUCKS_v1.0/common/img/icon_arrow.png" alt="하위메뉴">
						</li>
						<li>
							<a href="javascript:void(0);" class="this">완료</a>
						</li>
					</ul>
				</div>
			</div>
			<!-- // 서브 타이틀 -->
			
			<!-- 내용 -->
			<div class="content">
				<!-- 헤더 -->
				<header>
					<h3>주문이 정상적으로 완료되었습니다.</h3>
					주문 내역은 [My Ryanbucks > 주문 내역]에서 확인하실 수 있습니다.
				</header>
				<!-- // 헤더 -->
				
				<!-- 주문 정보 -->
				<div class="order_info">
					<table>
						<tr>
							<th>주문번호</th>
							<td><%=order_id %></td>
						</tr>
						
						<%if(orderTotalDto.getType().equals("pickup")) { %>
						<!-- 픽업 주문인 경우 -->
						<tr>
							<th>픽업 지점</th>
							<td><%=orderTotalDto.getPickup_branch() %></td>
						</tr>
						<tr>
							<th>픽업 시간</th>
							<td><%=new SimpleDateFormat("yyyy-MM-dd HH:mm").format(orderTotalDto.getPickup_time()) %></td>
						</tr>
						
						<%} else { %>
						<!-- 배송 주문인 경우 -->
						<tr>
							<th>배송지 주소</th>
							<td>[<%=orderTotalDto.getPost_code() %>] <%=orderTotalDto.getRoad_address() %> <%= orderTotalDto.getDetail_address() %></td>
						</tr>
						
						<%} %>
					</table>
				</div>
				<!-- // 주문 정보 -->
				
				<!-- 버튼 -->
				<div class="buttons_wrap">
					<!-- 메인 화면으로 이동하기 -->
					<div class="main">
						<a href="/RYANBUCKS_v1.0/index.jsp" role="button">
							<span>메인 화면으로 이동하기</span>
						</a>
					</div>
					<!-- // 메인 화면으로 이동하기 -->

					<!-- My Ryanbucks로 이동하기 -->
					<div class="my_ryanbucks">
						<a href="/RYANBUCKS_v1.0/my_ryanbucks/index.jsp" role="button">
							<span>My Ryanbucks로 이동하기</span>
						</a>
					</div>
					<!-- // My Ryanbucks로 이동하기 -->
				</div>
				<!-- // 버튼 -->
				
			</div>
			<!-- // 내용 -->
		</div>
		<!-- // container -->
	</div>
	<jsp:include page="/footer.jsp" />
	<!-- // wrap -->
</body>
</html>