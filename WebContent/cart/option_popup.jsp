<%@page import="menu_option.MenuOptionDTO"%>
<%@page import="java.util.List"%>
<%@page import="menu.MenuDTO"%>
<%@page import="menu_option.MenuOptionDAO"%>
<%@page import="menu.MenuDAO"%>
<%@page import="cart.CartDAO"%>
<%@page import="cart.CartDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
int no = Integer.parseInt(request.getParameter("no"));
/* System.out.println("no ============> " + no); */
CartDAO cartDao = new CartDAO(application);
MenuDAO menuDao = new MenuDAO(application);
MenuOptionDAO menuOptionDao = new MenuOptionDAO(application);	

CartDTO cart = cartDao.getCartDTO(no);
List<MenuDTO> menuDto2 = menuDao.getMenuDTO();	// 메뉴 정보 조회
List<MenuOptionDTO> menuOptiosDtoList = menuOptionDao.getCartMenuOptions();

cartDao.close();
menuDao.close();
menuOptionDao.close();

%>
<!DOCTYPE html>
<html>
<head>

<link href="/RYANBUCKS_v1.0/common/css/style_optionPopup.css" rel="stylesheet">
<link href="/RYANBUCKS_v1.0/common/css/reset.css" rel="stylesheet">
<link href="/RYANBUCKS_v1.0/common/img/logo.png" rel="short icon" type="image/ico">
<meta charset="UTF-8">
<title>주문 수정</title>
</head>
<body>
	<!-- wrap -->
	<div id="wrap">
	
		<!-- container -->
		<div id="container">

			<!-- 내용 -->
			<div class="content">
		
					<!-- 메뉴 정보 -->
					<div class="menu_view_detail">
					
						<!-- 메뉴명 -->
						<div class="menu_info_wrap">
							<h4>
							<%
							for(MenuDTO menu : menuDto2){
								if(cart.getMenu_no() == menu.getNo()){
							%>
									<input type="hidden" name = "no" value="<%= cart.getNo() %>">
									<%=menu.getName_kor() %><br>
							</h4>
						</div>
						<!-- // 메뉴명 -->
						
						<!-- 판매가 -->
						<div class="sales_price_wrap">
							<dl>
								<dt>
									<strong>판매가</strong>
									<span class="price_info">(옵션 미적용가)</span>
								</dt>
								<dd>
									<strong>
										<span class="price"><%=String.format("%,d", menu.getSales_price()) %></span>
									</strong>
								</dd>
							</dl>
						</div>
						<!-- // 판매가 --> 
						
					  <!-- form -->
						<form method="get" name="submit_form" action="update_process.jsp">
							<input type="hidden" name="no" value=<%=cart.getNo() %>>
							<% if(menu.getStock() != 0) { %>
							<!-- 주문 가능한 상태이면 -->
							
							<!-- 옵션 -->
							<% if(menuOptiosDtoList.size() != 0) { %>
							<div class="option_wrap">
								<select id="select_option" name="select_option" onchange="changeOption(this)">
										<% for(MenuOptionDTO menuOptionDto : menuOptiosDtoList) { 
											if(menu.getNo() == menuOptionDto.getMenu_no()) {
												
											int option_no = menuOptionDto.getNo();
											
											// 옵션1
											String option1 = menuOptionDto.getOption1_value();
											
											// 옵션2
											String option2 = (menuOptionDto.getOption2_name() != null)? " | " + menuOptionDto.getOption2_value() : "";
		
											// 추가 금액
											int option_price = menuOptionDto.getPrice();
											String option_text = option1 + option2 + " (" + String.format("%+,d", option_price) + "원)";
		
											// 품절 여부에 따른 속성, 텍스트 처리
											String option_attribute = "";
											int option_stock = menuOptionDto.getStock();
											
											if(option_stock == 0) {
												option_attribute = "class='sold_out' disabled";
												option_text += " (품절)";
											}
										%>
									
										<option value="<%=option_no %>" data-option-price=<%=option_price %> data-option-stock=<%=option_stock %> <%=option_attribute %>><%=option_text %></option>
										<%} }%>
								</select>
							</div>
							<%} %>
							<!-- // 옵션 -->
							
							<!-- 주문 수량 -->
							<div class="quantity_wrap">
								<input type="button" id="decrease_quantity" value="-" onclick="decreaseQuantity()" disabled>
								<input type="number" id="quantity" name="quantity" value="1" readonly>
								<input type="button" id="increase_quantity" value="+" onclick="increaseQuantity()">
							</div>
							<!-- // 주문 수량 -->
							
						</form>
						<!-- // form -->
						
						<!-- 총 상품 금액 -->
						<div class="total_price_wrap">
							<dl>
								<dt>
									<strong>총 주문 금액</strong>
								</dt>
								<dd>
									<span class="price_info">총 주문 수량 <span>1</span>개&nbsp; |&nbsp;</span>
									<strong>
										<span class="price"><%=String.format("%,d", menu.getSales_price()) %></span>
									</strong>
								</dd>
							</dl>
						</div>
						<!-- // 총 상품 금액 --> 
						
						<!-- 버튼 -->
						<div class="buttons_wrap">
							<!-- 취소하기 -->
							<div class="cart">
								<a href="javascript:void(0);" role="button" onclick="window.close();">
									<span>취소하기</span>
								</a>
							</div>
							<!-- // 취소하기 -->
							
							<!-- 수정하기 -->
							<div class="order">
								<a href="javascript:void(0);" role="button" onclick="Update()">
									<span>수정하기</span>
								</a>
							</div>
							<!-- // 수정하기 -->
						</div>
						<!-- // 버튼 -->
						
						<%
						} else {
						%>
						<!-- 주문 불가능한 상태이면 -->
						<strong id="all_sold_out">
							이 메뉴는 현재 주문하실 수 없는 메뉴입니다.<br>
							<span>(재입고 시 구매가능)</span>
						</strong>
						<% } %>
						
					</div>
					<!-- // 메뉴 정보 --> 
				
			</div>
			<!-- // 내용 -->
			
		</div>
		<!-- // container -->
		
	</div>
	<!-- // wrap -->

	
	 <script>
		// 페이지 로드 시 실행되는 함수
    	window.onload = function () {
    		var selectOption = document.getElementById("select_option");
    		var selectedOption = selectOption.options[selectOption.selectedIndex];
    		var extraPrice = Number(selectedOption.getAttribute('data-option-price'));
    		var price = document.querySelector(".total_price_wrap .price");

    		price.innerHTML = (<%=menu.getSales_price()%> + extraPrice).toLocaleString('ko-KR');

    		var stock = Number(selectedOption.getAttribute('data-option-stock'));
    		if(stock == 1) {
    			//console.log("수량 증가 버튼 비활성화");
				document.getElementById("increase_quantity").disabled = true;
    		}
		}
	
		// 수량 감소 버튼 클릭 시
		function decreaseQuantity() {
			var newQuantity = Number(document.getElementById("quantity").value) - 1; // 수량 -1
			//console.log(newQuantity);
			document.getElementById("quantity").value = newQuantity;
			document.querySelector(".total_price_wrap .price_info span").innerHTML = newQuantity;

			if(newQuantity == 1) { // 바뀐 수량이 1이면
				//console.log("수량 감소 버튼 비활성화");
				document.getElementById("decrease_quantity").disabled = true;
			}
			
			var selectOption = document.getElementById("select_option");
    		var selectedOption = selectOption.options[selectOption.selectedIndex];
    		var stock = Number(selectedOption.getAttribute('data-option-stock'));
    		
    		if(newQuantity < stock) {
    			//console.log("수량 증가 버튼 활성화");
				document.getElementById("increase_quantity").disabled = false;
    		}
    		
			// 총 금액 = (판매가 + 옵션 가격) * 수량
			var oldTotalPrice = Number(document.querySelector(".total_price_wrap .price").innerHTML.split(",").join(""));
			//alert(oldTotalPrice);
			var newTotalPrice = (oldTotalPrice / (newQuantity+1)) * newQuantity;
			document.querySelector(".total_price_wrap .price").innerHTML = newTotalPrice.toLocaleString('ko-KR'); // 인자로 전달한 Locale의 표현 방식으로 숫자를 출력 (미국, 한국은 3자리마다 콤마 사용)
		}
		
		// 수량 증가 버튼 클릭 시
		function increaseQuantity() {
			var newQuantity = Number(document.getElementById("quantity").value) + 1; // 수량 +1
			//console.log(newQuantity);
			document.getElementById("quantity").value = newQuantity; 
			document.querySelector(".total_price_wrap .price_info span").innerHTML = newQuantity;

			if(newQuantity >= 2) { // 바뀐 수량이 2 이상이면
				//console.log("수량 감소 버튼 활성화");
				document.getElementById("decrease_quantity").disabled = false;
			}
			
			var selectOption = document.getElementById("select_option");
    		var selectedOption = selectOption.options[selectOption.selectedIndex];
    		var stock = Number(selectedOption.getAttribute('data-option-stock'));
    		
    		if(newQuantity == stock) {
    			//console.log("수량 증가 버튼 비활성화");
				document.getElementById("increase_quantity").disabled = true;
    		}
			
			
			// 총 금액 = (판매가 + 옵션 가격) * 수량
			var oldTotalPrice = Number(document.querySelector(".total_price_wrap .price").innerHTML.split(",").join(""));
			//alert(oldTotalPrice);
			var newTotalPrice = (oldTotalPrice / (newQuantity-1)) * newQuantity;
			document.querySelector(".total_price_wrap .price").innerHTML = newTotalPrice.toLocaleString('ko-KR'); // 인자로 전달한 Locale의 표현 방식으로 숫자를 출력 (미국, 한국은 3자리마다 콤마 사용)
		}
		
		// 옵션 변경 시
		function changeOption(selectElement) {
			// selectElement는 select 요소를 나타냄 (*선택된 option 요소가 아님)
			// select 요소에서 option 선택 시 select 요소의 value는 선택된 옵션의 value가 됨
			
			var selectedOption = selectElement.selectedOptions[0];						// 선택된 옵션을 받아옴 (다중 선택이 가능한 경우가 있기 때문에 [0] 인덱스 지정)
    		var extraPrice = Number(selectedOption.getAttribute('data-option-price'));	// 옵션 금액
			// console.log(extraPrice);	// 옵션 금액 확인용    
    		
			// 수량 정보는 1로 초기화
    		document.getElementById("quantity").value = 1; 
    		document.querySelector(".total_price_wrap .price_info span").innerHTML = 1;
			
			// 수량 감소 버튼 비활성화
			document.getElementById("decrease_quantity").disabled = true;
			
			// 총 금액 = (판매가 + 옵션 가격) * 수량
			var totalPrice = (<%=menu.getSales_price()%> + extraPrice); // 옵션 변경 시에는 수량이 1이기 때문에 '* 1' 생략
			document.querySelector(".total_price_wrap .price").innerHTML = totalPrice.toLocaleString('ko-KR'); // 인자로 전달한 Locale의 표현 방식으로 숫자를 출력 (미국, 한국은 3자리마다 콤마 사용)
			
			var stock = Number(selectedOption.getAttribute('data-option-stock'));
    		if(stock == 1) {
    			//console.log("수량 증가 버튼 비활성화");
				document.getElementById("increase_quantity").disabled = true;
    		} else {
    			//console.log("수량 증가 버튼 활성화");
				document.getElementById("increase_quantity").disabled = false;
    		}			
		}
	</script>  
	
	<script>
	// 수정하기 클릭했을 때
	function Update() {
		document.submit_form.action = "update_process.jsp"; //요청 보낼 주소
        document.submit_form.submit();
		
		}
	</script>
	
<% } } %>
</body>
</html> 