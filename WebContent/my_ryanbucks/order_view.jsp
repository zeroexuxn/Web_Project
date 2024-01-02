<%@page import="menu_option.MenuOptionDTO"%>
<%@page import="menu_option.MenuOptionDAO"%>
<%@page import="menu.MenuDTO"%>
<%@page import="menu.MenuDAO"%>
<%@page import="order_total.OrderTotalDAO"%>
<%@page import="order_total.OrderTotalDTO" %>
<%@page import="order_detail.OrderDetailDAO"%>
<%@page import="order_detail.OrderDetailDTO" %>
<%@page import="menu_image.MenuImageDAO" %>
<%@page import="menu_image.MenuImageDTO" %>
<%@page import="java.text.DecimalFormat" %>
<%@page import="java.util.List"%>
<%@page import="java.util.Map" %>
<%@page import="java.util.HashMap"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String member_id = "";
	if(session.getAttribute("id") == null)
		response.sendRedirect("../login/login.jsp");
	else
		member_id = session.getAttribute("id").toString();
%>

   <%
 	//금액 표시 형식
 	DecimalFormat df = new DecimalFormat("#,###");   
   
	//주문 내역 목록에서 클릭한 주문번호 가져오기
	String orderId=request.getParameter("id");
   
   	Map<String, Object> param=new HashMap<String, Object>();

	//주문번호로 읽어올 DAO 생성
	OrderDetailDAO orderDetailDao=new OrderDetailDAO(application);
	OrderTotalDAO orderTotalDao=new OrderTotalDAO(application);
	
	//주문 상세 내역 내용 가져와 DTO에 저장
	OrderDetailDTO orderDetailDto=orderDetailDao.selectDetailList(orderId);
	
	//주문 정보를 가져와 DTO에 저장
	OrderTotalDTO orderTotalDto=orderTotalDao.selectDetailList(orderId, member_id);
	
	//주문 상세 내역의 메뉴 수
	int menuCount=orderDetailDao.selectCount(param, orderId);
	
	//주문 내역 목록 리스트 확인
	List<OrderDetailDTO> bbs=orderDetailDao.selectList(param, orderId);
	
	// DB 연결 해제
	orderDetailDao.close();
	
	%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 내역 | Ryanbucks Korea</title>
<link href="/RYANBUCKS_v1.0/common/css/reset.css" rel="stylesheet"> <!-- 헤더, 푸터 -->
<link href="/RYANBUCKS_v1.0/common/css/style_main.css" rel="stylesheet"> <!-- 헤더, 푸터 -->
<link href="/RYANBUCKS_v1.0/common/css/notice_style.css" rel="stylesheet">
<link href="/RYANBUCKS_v1.0/common/css/order_view_style.css" rel="stylesheet">
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
					<img src="/RYANBUCKS_v1.0/non_co_img/sub_title/order_detail_tit.png" alt="주문내역">
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
						<a href="/RYANBUCKS_v1.0/my_ryanbucks/order_list.jsp" class="this">주문내역</a>
					</li>
					<li>
						<img class="arrow" src="/RYANBUCKS_v1.0/common/img/icon_arrow_w.png" alt="하위메뉴">
					</li>
					<li>
						<a href="javascript:void(0);" class="this">주문상세</a>
					</li>
				</ul>
			</div>
		</div>
	</div>
	<!-- // 서브 타이틀 -->

<!-- container -->
<div id="container">
	<!-- //content -->
	<div class="content">
		<!-- order_view_wrap -->
		<div class="order_view_wrap">
			<!-- 안내 메시지 -->
			<div class="guide_msg">
				주문번호: <%=orderTotalDto.getId() %>
			</div>
			<!-- // 안내 메시지 -->
			
			<!-- 주문상품정보 -->
			<table summary="주문상품정보" class="order_view_tb">
				<caption class="hid">상품이미지, 상품정보, 판매가, 수량, 소계 금액 테이블</caption>
				<caption class="order_view_tb_head">주문상품정보</caption>
				<colgroup>
					<col width="10%">
					<col width="40%">
					<col width="10%">
					<col width="10%">
					<col width="20%">
				</colgroup>
				<thead>
					<tr>
						<th scope="col"></th>
						<th scope="col">상품정보</th>
						<th scope="col">판매가</th>
						<th scope="col">수량</th>
						<th scope="col">소계금액</th>
					</tr>
				</thead>
				<tbody id="order_view">
					<%
					for(OrderDetailDTO orderDetailDTO : bbs){
						
						MenuImageDAO menuImageDao=new MenuImageDAO(application);
						
						MenuDAO menuDao=new MenuDAO(application);
						
						MenuOptionDAO menuOptionDao=new MenuOptionDAO(application);
						
						//메뉴 이미지 파일명을 가져오기 위한 객체
						MenuImageDTO menuImageDto=menuImageDao.selectDetailMenuImage(orderDetailDTO.getMenu_no());
						//메뉴 이름을 가져오기 위한 객체
						MenuDTO menuDto=menuDao.getMenuDTO(orderDetailDTO.getMenu_no());
						//옵션 정보를 가져오기 위한 객체
						MenuOptionDTO menuOptionDto=menuOptionDao.getMenuOptionDto(orderDetailDTO.getOption_no());
						
					%>
					<tr>
						<td><!-- 이미지 넣아야함 --><img src="/RYANBUCKS_v1.0/non_co_img/menu/<%=menuImageDto.getFile_name() %>" alt="상품이미지"></td>
						<td><!-- 이름이랑 메뉴번호 매핑 --><%= menuDto.getName_kor() %>
							<%
							if(orderDetailDTO.getOption_no()!=0){//옵션 번호가 0이 아니면 (옵션이 있으면) 
								
							%>
								<br>
								<%=menuOptionDto.getOption1_value() %>
								<%
								if(menuOptionDto.getOption2_name()!=null){//옵션2 이름이 null이 아니면
								%>
								
								 | <%=menuOptionDto.getOption2_value() %>
						<%		}
							}
						%>
						</td>
						<td><%= df.format(orderDetailDTO.getMenu_price()) %>원</td>
						<td><%= orderDetailDTO.getQuantity() %></td>
						<td><%= df.format(orderDetailDTO.getMenu_price()+orderDetailDTO.getOption_price()) %>원</td>
					</tr>
					<%} %>
	
				</tbody>
			</table>
			<!-- /주문상품정보 -->
			<!-- 총 결제 금액 -->
			<div class="total_payment">
	    		<p id="order_info">
	        		<span id="order_count">주문상품수 <strong><%= menuCount %></strong></span>
	        		<span id="total_amount">총 결제 금액 <strong><%= df.format(orderTotalDto.getAmount()) %>원</strong></span>
	    		</p>
			</div>
			<!-- 총 결제 금액 -->
			<!-- 구매자 정보 -->
			<table class="info_tb">
				<caption class="order_view_tb_head">구매자 정보</caption>
				<colgroup>
					<col width="15%">
					<col width="35%">
					<col width="15%">
					<col width="35%">
				</colgroup>
				<tr>
					<td class="weight" scope="col">구매자명</td>
					<td scope="col"><%=orderTotalDto.getRecipient_name() %></td>
					<td class="weight" scope="col">연락처</td>
					<td scope="col"><%=orderTotalDto.getRecipient_tel() %></td>
				</tr>
				<tr>
					<td class="weight" scope="col">이메일 주소</td>
					<td scope="col" colspan="3">
					<%
					if(orderTotalDto.getRecipient_email()==null){
					%>
					-
					<%
					}else{
					%>
					<%=orderTotalDto.getRecipient_email() %>
					<%
					}
					%>
					</td>
					<td></td>
					<td></td>
				</tr>
			</table>
			<!-- /구매자 정보 -->
			<!-- 결제 정보 -->
			<table class="info_tb">
				<caption class="order_view_tb_head">결제 정보</caption>
				<colgroup>
					<col width="15%">
					<col width="35%">
					<col width="15%">
					<col width="35%">
				</colgroup>
				<tr>
					<td class="weight" scope="col">결제방법</td>
					<td scope="col"><%=orderTotalDto.getPay_method() %></td>
					<td class="weight" scope="col">카드정보</td>
					<td scope="col"><%=orderTotalDto.getCard_name() %> <%=orderTotalDto.getCard_no() %></td>
				</tr>
				<tr>
					<td class="weight" scope="col">할부개월</td>
					<td scope="col">
					<%
					if(orderTotalDto.getCard_quota().equals("00")){
					%>
					일시불
					<%
					}else{
					%>
					<%=orderTotalDto.getCard_quota() %>
					<%
					} 
					%>
					</td>
					<td class="weight" scope="col">승인번호</td>
					<td scope="col"><%=orderTotalDto.getAuth_code() %></td>
				</tr>
			</table>
			<!-- /결제 정보 -->
			<%
			if(orderTotalDto.getType().equals("shipping")) {
			%>
			<!-- 배송지 정보 -->
			<table class="info_tb">
				<caption class="order_view_tb_head">배송지 정보</caption>
				<colgroup>
					<col width="15%">
					<col width="85%">
				</colgroup>
				<tr>
					<td class="weight" scope="col">주소</td>
					<td scope="col">[<%=orderTotalDto.getPost_code() %>] <%=orderTotalDto.getRoad_address() %> <%= orderTotalDto.getDetail_address() %></td>				
				</tr>
			</table>
			<!-- /배송지 정보 -->
			<%} else {%>
			<!-- 픽업 정보 -->
			<table class="info_tb">
				<caption class="order_view_tb_head">픽업 정보</caption>
				<colgroup>
					<col width="15%">
					<col width="35%">
					<col width="15%">
					<col width="35%">
				</colgroup>
				<tr>
					<td class="weight" scope="col">지점명</td>
					<td scope="col"><%=orderTotalDto.getPickup_branch() %></td>
					<td class="weight" scope="col">픽업 시간</td>
					<td scope="col"><%=new SimpleDateFormat("yyyy-MM-dd HH:mm").format(orderTotalDto.getPickup_time()) %></td>				
				</tr>
			</table>
			<!-- /픽업 정보 -->
			<%} %>
		</div>
		<!-- /order_view_wrap -->
		
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