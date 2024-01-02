<%@page import="order_total.OrderTotalDAO"%>
<%@page import="order_total.OrderTotalDTO" %>
<%@page import="java.text.DecimalFormat" %>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String member_id = "";
	if(session.getAttribute("id") == null)
		response.sendRedirect("../login/login.jsp");
	else
		member_id = session.getAttribute("id").toString();
	
	//금액 표시 형식
	DecimalFormat df = new DecimalFormat("#,###");
	//DAO를 생성한 후 Oracle DB에 연결
	OrderTotalDAO orderTotalDao=new OrderTotalDAO(application);
	
	//검색 조건 MAP에 저장
	Map<String, Object> param = new HashMap<String, Object>();
	String orderType = request.getParameter("sch_type");
	String transactionType=request.getParameter("sch_payMethod");
	
	//검색 조건이 있는지 판별
	if ("sch_type" != null) { // 검색어 입력했으면
    	param.put("sch_type", orderType);
	}
	
	if("sch_payMethod" != null){
		param.put("sch_payMethod", transactionType);
	}
	
	//게시글 수 확인
	int totalCount=orderTotalDao.selectCount(param, member_id);			//id 받아와야함
	
	//게시글 목록 확인
	List<OrderTotalDTO> bbs=orderTotalDao.selectList(param, member_id);	//id 받아와야함
	
	//Oracle DB 연결 해제
	orderTotalDao.close();
	%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문내역 | Ryanbucks Korea</title>
<link href="/RYANBUCKS_v1.0/common/css/reset.css" rel="stylesheet"> <!-- 헤더, 푸터 -->
<link href="/RYANBUCKS_v1.0/common/css/style_main.css" rel="stylesheet"> <!-- 헤더, 푸터 -->
<link href="/RYANBUCKS_v1.0/common/css/notice_style.css" rel="stylesheet">
<link href="/RYANBUCKS_v1.0/common/css/order_list_style.css" rel="stylesheet">
<link href="/RYANBUCKS_v1.0/common/css/style.css" rel="stylesheet">
<link href="/RYANBUCKS_v1.0/common/img/logo.png" rel="short icon" type="image/ico">
</head>
<body>
<jsp:include page="/header.jsp" />

	<!-- 서브 타이틀 -->
	<div class="ms_sub_tit_wrap">
		<div class="ms_sub_tit_bg">
			<div class="ms_sub_tit_inner">
				<h2>
					<img src="/RYANBUCKS_v1.0/non_co_img/sub_title/order_list_tit.png" alt="주문내역">
				</h2>
				<ul class="smap">
					<li><a href="/RYANBUCKS_v1.0/index.jsp"><img src="/RYANBUCKS_v1.0/common/img/icon_home_w.png" alt="홈으로"></a>
					</li>
					<li>
						<img class="arrow" src="/RYANBUCKS_v1.0/common/img/icon_arrow_w.png" alt="하위메뉴">
					</li>
					<li>
						<a href="/RYANBUCKS_v1.0/my_ryanbucks/index.jsp" class="en">My Ryanbucks</a>
					</li>
					<li>
						<img class="arrow" src="/RYANBUCKS_v1.0/common/img/icon_arrow_w.png" alt="하위메뉴">
					</li>
					<li>
						<a href="javascript:void(0);" class="this">주문내역</a>
					</li>
				</ul>
			</div>
		</div>
	</div>
	<!-- // 서브 타이틀 -->

	<!-- container -->
	<div id="container">
		<!-- content -->
		<div class="content">
			<!-- order_list_wrap -->
			<div class="order_list_wrap">
				<!-- search_option_wrap -->
				<div class="search_option_wrap">
					<!-- 기간 체크박스 -->
					<!--  <p>기간별</p>
					<form method="get" action="CheckboxServlet" class="period">
						<input type="radio" name="period" value="1개월">1개월
						<input type="radio" name="period" value="3개월">3개월
						<input type="radio" name="period" value="6개월">6개월
						<input type="radio" name="period" value="6개월이전">6개월 이전
					</form>-->
					<!-- /기간 체크박스 -->
					<!-- 주문유형, 거래유형 리스트박스 -->
					<form method="post">
	    				<div class="order_type">
	        				<label for="order_type">주문유형</label> 
	        				<select id="order_type" name="sch_type" size="1">
	        					<option value="" disabled selected>전체보기</option>
	            				<option value="pickup">픽업</option>
	            				<option value="shipping">배달</option>
	        				</select>
	    				</div>
	    				<div class="transaction_type">
	        				<label for="transaction_type">거래유형</label> 
	        				<select id="transaction_type" name="sch_payMethod" size="1">
	        					<option value="" disabled selected>전체보기</option>
	           				 	<option value="CARD">카드</option>
	
	        				</select>						
	    				</div>
	    				<div class="smbtn"><input type="submit" value="확인"></div>
	    				
					</form>
					<!-- /주문유형, 거래유형 리스트박스 -->
				</div>
				<!-- /search_option_wrap -->
				
				<!-- 안내 메시지 -->
				<div class="guide_msg">
					[주문번호]를 클릭하시면 주문상세를 확인하실 수 있습니다.
				</div>
				<!-- // 안내 메시지 -->
				
				<!-- 주문내역 리스트 -->
				<table summary="주문내역" class="order_list_tb">
					<caption class="hid">주문번호, 주문일시, 지점, 주문유형, 총 거래 금액 테이블</caption>
					<colgroup>
						<col width="30%">
						<col width="30%">
						
						<col width="15%">
						<col width="25%">
					</colgroup>
					<thead>
						<tr>
							<th scope="col">주문번호</th>
							<th scope="col">주문일시</th>
							
							<th scope="col">주문유형</th>
							<th scope="col">총 거래 금액</th>
						</tr>					
					</thead>
					<tbody>
						<%
						if(totalCount==0){						
						
						%>
						<tr>
							<td colspan="5" align="center">주문내역이 없습니다.</td>
						</tr>
						<%
						}else{
							
							for(OrderTotalDTO orderTotalDto : bbs){					
						%>
						<tr>
							<td>
								<a href="order_view.jsp?id=<%= orderTotalDto.getId() %>"><%= orderTotalDto.getId() %></a>
							</td>
							<td><%=new SimpleDateFormat("yyyy-MM-dd HH:mm:SS").format(orderTotalDto.getOrder_date()) %></td>
							<td><%= orderTotalDto.getType().equals("pickup")?"픽업":"배송"%></td>
							<td><%=	df.format(orderTotalDto.getAmount())%>원</td>
						</tr>
						<%
							}//end of for
						}//end of if
						%>
	
					</tbody>
				</table>
				<!-- /주문내역 리스트 -->
			</div>
			<!-- /order_list_wrap -->
			
			<div class="navigation_wrap">
				<jsp:include page="/my_ryanbucks/navigation.jsp" />
			</div>
		</div>
		<!-- //content -->
	</div>
	<!-- /container -->
	<jsp:include page="/footer.jsp" />
</body>
</html>