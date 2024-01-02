<%@page import="menu.*"%>
<%@page import="category.*"%>
<%@page import="menu_image.*"%>
<%@page import="menu_option.*"%>
<%@page import="review_board.*"%>
<%@page import="order_detail.*"%>
<%@page import="java.util.List"%>
<%@page import="utils.JSFunction"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int menu_no = Integer.parseInt(request.getParameter("menu_no"));	// 메뉴 번호
	
	String sort_option = request.getParameter("sort_option");	// 리뷰 정렬 기준
	
	int page_no = 1;	// 페이지 번호
	if(request.getParameter("page_no") != null) {
		page_no = Integer.parseInt(request.getParameter("page_no"));
	}

	//DAO 생성 후 Oracle DB 연결
	MenuDAO menuDao = new MenuDAO(application);
	CategoryDAO categoryDao = new CategoryDAO(application);
	MenuImageDAO menuImageDao = new MenuImageDAO(application);
	MenuOptionDAO menuOptionDao = new MenuOptionDAO(application);	
	ReviewBoardDAO reviewBoardDao = new ReviewBoardDAO(application);
	OrderDetailDAO orderDetailDao = new OrderDetailDAO(application);
	
	MenuDTO menuDto = menuDao.getMenuDTO(menu_no);	// 메뉴 정보 조회
	CategoryDTO categoryDto = categoryDao.getCategoryDTO(menuDto.getCategory_id());					// 카테고리 정보 조회
	List<MenuImageDTO> menuImageDtoList = menuImageDao.getOneMenuImages(menu_no);					// 메뉴 이미지 목록
	List<MenuOptionDTO> menuOptiosDtoList = menuOptionDao.getOneMenuOptions(menu_no);				// 메뉴 옵션 목록
	
	List<ReviewBoardDTO> reviewBoardDtoList = null;
	if(sort_option == null || sort_option.equals("latest")) {	// 리뷰 목록 조회 - 최신순
		reviewBoardDtoList = reviewBoardDao.getOneMenuReviewsByLatest(menu_no);
	} else if(sort_option.equals("highest")) {	// 리뷰 목록 조회 - 별점높은순
		reviewBoardDtoList = reviewBoardDao.getOneMenuReviewsByHighest(menu_no);
	} else {	// 리뷰 목록 조회 - 별점낮은순
		reviewBoardDtoList = reviewBoardDao.getOneMenuReviewsByLowest(menu_no);
	}
	
	double averageRate = reviewBoardDao.getAverageRate(menu_no);									// 평균 별점 조회
	List<Integer> reviewCountByRate = reviewBoardDao.getCountByRate(menu_no);						// 별점별 리뷰 수
	List<Integer> optionNoList = orderDetailDao.getOneMenuReviewsOptionNo(menu_no);					// 작성된 리뷰에 해당되는 옵션 목록 (review_board에 옵션 정보가 없기 때문에 사용)

	// DB 연결 해제
	menuDao.close();
	categoryDao.close();
	menuImageDao.close();
	menuOptionDao.close();
	reviewBoardDao.close();
	orderDetailDao.close();
	
	// hidden 메뉴의 번호가 전달된 경우
	if(!categoryDto.getVisibility().equals("visible"))
		JSFunction.alertBack("조회 불가능한 상품입니다.", out);

	// food 메뉴의 번호가 전달된 경우 food_view 페이지로 리다이렉션 (실제 스타벅스는 이 부분 예외처리가 안 되어 있음)
	if(categoryDto.getType().equals("drink"))
		response.sendRedirect("drink_view.jsp?menu_no=" + menu_no);
	
	// 없는 메뉴 번호가 전달된 경우 - NullPointException 예외 발생하여 500 응답 -> error.jsp 자동 표시
	// => getMenuDTO의 결과로 먼저 비교한 후 error.jsp로 리다이렉션 시키는 편이 자원관리 측면에서 더 좋을 것으로 보임

	//menuDto.setStock(0); // 품절 테스트
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title><%=menuDto.getName_kor() %> | Ryanbucks Korea</title>
	
	<link href="/RYANBUCKS_v1.0/common/css/reset.css" rel="stylesheet"> <!-- 헤더, 푸터 -->
	<link href="/RYANBUCKS_v1.0/common/css/style_main.css" rel="stylesheet"> <!-- 헤더, 푸터 -->
	<link href="/RYANBUCKS_v1.0/common/css/style.css" rel="stylesheet">
	<link href="/RYANBUCKS_v1.0/common/css/style_menu_view.css" rel="stylesheet">
	<link href="/RYANBUCKS_v1.0/common/img/logo.png" rel="short icon" type="image/ico">
	
	<script src="https://code.jquery.com/jquery-latest.min.js"></script>	<!-- JQuery를 사용하기 위한 라이브러리 -->
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
						<img src="/RYANBUCKS_v1.0/non_co_img/sub_title/category_<%=menuDto.getCategory_id()%>_tit.png" alt="<%=categoryDto.getName() %>">
					</h2>
					<ul class="smap">
						<li><a href="/RYANBUCKS_v1.0/index.jsp"><img src="/RYANBUCKS_v1.0/common/img/icon_home.png" alt="홈으로"></a>
						</li>
						<li>
							<img class="arrow" src="/RYANBUCKS_v1.0/common/img/icon_arrow.png" alt="하위메뉴">
						</li>
						<li class="en">
							<a href="menu.jsp">MENU</a>
						</li>
						<li>
							<img class="arrow" src="/RYANBUCKS_v1.0/common/img/icon_arrow.png" alt="하위메뉴">
						</li>
						<li>
							<a href="food_list.jsp">푸드</a>
						</li>
						<li>
							<img class="arrow" src="/RYANBUCKS_v1.0/common/img/icon_arrow.png" alt="하위메뉴">
						</li>
						<li>
							<a href="food_list.jsp"><%=categoryDto.getName() %></a>
						</li>
						<li>
							<img class="arrow" src="/RYANBUCKS_v1.0/common/img/icon_arrow.png" alt="하위메뉴">
						</li>
						<li>
							<a href="javascript:void(0);" class="this"><%=menuDto.getName_kor() %></a>
						</li>
					</ul>
				</div>
			</div>
			<!-- // 서브 타이틀 -->
			
			<!-- 내용 -->
			<div class="content">
			
				<!-- 상세보기 -->
				<div class="menu_view_wrap">
					<!-- 메뉴 사진 -->
					<div class="menu_view_pic">
						<!-- 확대 이미지 -->
						<div class="menu_bic_pic">
							<p>
								<a href="#" tabindex="-1" aria-hidden="true" role="presentation">
									<img class="zoomImg" src="/RYANBUCKS_v1.0/non_co_img/menu/<%=menuImageDtoList.get(0).getFile_name() %>" alt="상세이미지">
								</a>
							</p>
						</div>
						<!-- // 확대 이미지 -->
						
						<!-- 썸네일 -->
						<div class="menu_thum_wrap">
							<ul class="menu_thum">
								<%for(int i=0; i<menuImageDtoList.size(); i++) { %>
								<li>
									<a href="javascript:void(0);" data-image="/RYANBUCKS_v1.0/non_co_img/menu/<%=menuImageDtoList.get(i).getFile_name() %>" class="gallery">
										<img src="/RYANBUCKS_v1.0/non_co_img/menu/<%=menuImageDtoList.get(i).getFile_name() %>" alt="상세이미지 <%=i+1 %>번">
									</a>
								</li>
								<%} %>
							</ul>
						</div>
						<!-- // 썸네일 -->
					</div>
					<!-- // 메뉴 사진 -->
					
					<!-- 메뉴 정보 -->
					<div class="menu_view_detail">
						<!-- 메뉴명 및 메뉴 설명 -->
						<div class="menu_info_wrap">
							<!-- 메뉴명 -->
							<h4>
								<%=menuDto.getName_kor() %><br>
								<span><%=menuDto.getName_eng() %></span>
							</h4>
							<!-- // 메뉴명 -->
							
							<!-- 메뉴 설명 -->
							<p class="description">
								<%=menuDto.getDescription() %>
							</p>
							<!-- // 메뉴 설명 -->
						</div>
						<!-- // 메뉴명 및 메뉴 설명 -->
						
						<!-- 판매가 -->
						<div class="sales_price_wrap">
							<dl>
								<dt>
									<strong>판매가</strong>
									<span class="price_info">(옵션 미적용가)</span>
								</dt>
								<dd>
									<strong>
										<span class="price"><%=String.format("%,d", menuDto.getSales_price()) %></span>
									</strong>
								</dd>
							</dl>
						</div>
						<!-- // 판매가 -->
						
						<!-- form -->
						<form method="post" name="submit_form">
							<input type="hidden" name="menu_no" value=<%=menuDto.getNo() %>>
							<% if(menuDto.getStock() != 0) { %>
							<!-- 주문 가능한 상태이면 -->
							<!-- 옵션 -->
							<% if(menuOptiosDtoList.size() != 0) { %>
							<div class="option_wrap">
								<select id="option_no" name="option_no" onchange="changeOption(this)">
									<% for(MenuOptionDTO menuOptionDto : menuOptiosDtoList) { 
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
									<%} %>
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
										<span class="price"><%=String.format("%,d", menuDto.getSales_price()) %></span>
									</strong>
								</dd>
							</dl>
						</div>
						<!-- // 총 상품 금액 -->
						
						<!-- 버튼 -->
						<div class="buttons_wrap">
							<!-- 장바구니 -->
							<div class="cart">
								<a href="javascript:void(0);" role="button" onclick="addCart()">
									<span>장바구니</span>
								</a>
							</div>
							<!-- // 장바구니 -->
							
							<!-- 주문하기 -->
							<div class="order">
								<a href="javascript:void(0);" role="button" onclick="order()">
									<span>주문하기</span>
								</a>
							</div>
							<!-- // 주문하기 -->
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
				<!-- // 상세보기 -->
				
				<!-- 리뷰 -->
				<div class="review_wrap">
					<!-- 타이틀 -->
					<div class="review_tit_wrap">
						<div class="review_tit_inner">
							<h4>
								리뷰<br>
								<span>실제 구매하신 분들이 작성하신 리뷰입니다.</span>
							</h4>
						</div>
					</div>
					<!-- // 타이틀 -->
					
					<%
					if(reviewBoardDtoList.size() != 0) {
					%>
					<!-- 작성된 리뷰가 있을 때 -->
					<!-- 리뷰 통계 -->
					<div class="review_stcs_wrap">
						<!-- 평균 별점 -->
						<div class="average_rate">
							<span class="title">구매자 총 평점</span>
							<div class="stcs_content">
								<div class="rate">
			        			<span style="width: <%=averageRate*20%>%"></span>
				    			</div>
				    			<div class="percent">
				    				<span><%=averageRate%></span><span class="max">/5</span>
				    			</div>
							</div>
			    		</div>
			    		<!-- // 평균 별점 -->
			    		
			    		<!-- 전체 리뷰 수 -->
			    		<div class="total_review_count_wrap">
			    			<span class="title">전체 리뷰 수</span>
			    			<div class="stcs_content">
			    				<img src="/RYANBUCKS_v1.0/non_co_img/review/icon_review.png">
			    				<span><%=String.format("%,d", reviewBoardDtoList.size())%></span>
			    			</div>
			    		</div>
			    		<!-- // 전체 리뷰 수 -->
			    		
			    		<!-- 별점 비율 -->
		    			<div class="graph_list_wrap">
		    				<span class="title">별점 비율</span>
		    				<ul class="stcs_content">
		    					<%
		    					for(int i=4; i>=0; i--) {
		    					%>
		    					<li>
									<span class="count"><%=reviewCountByRate.get(i) %></span>
									<div class="graph">
										<span style="height:<%= (reviewCountByRate.get(i) * 1.0 /reviewBoardDtoList.size())*100 %>%;"></span>
									</div>
									<span class="label"><%=i+1 %>점</span>
								</li>
		    					<%
		    					}
		    					%>
		    				</ul>
		    			</div>
			    		<!-- // 별점 비율 -->
						
					</div>
					<!-- // 리뷰 통계 -->
				
					<!-- 리뷰 목록 -->
					<div class="review_list_wrap">
					
						<!-- 정렬 기준 -->
						<div class="sort_option_wrap">
							<select onchange="changeSorting(this)">
								<option value="latest" <%=(sort_option == null || sort_option.equals("latest"))? "selected": "" %>>최신순</option>
								<option value="highest" <%=(sort_option != null && sort_option.equals("highest"))? "selected": "" %>>별점높은순</option>
								<option value="lowest" <%=(sort_option != null && sort_option.equals("lowest"))? "selected": "" %>>별점낮은순</option>
							</select>
						</div>
						<!-- // 정렬 기준 -->
						
						<!-- 목록 -->
						<div class="list_wrap">
							<ul>
							<%for(int i=(page_no - 1) * 10; i<=((reviewBoardDtoList.size() < page_no * 10)? reviewBoardDtoList.size()-1 : page_no * 10 - 1); i++) {%>
								<li>
									<div class="rate">
						        		<span style="width: <%=reviewBoardDtoList.get(i).getRate()*20%>%"></span>
						    		</div>
						    		
						    		<div class="review_detail">
						    			<%=reviewBoardDtoList.get(i).getMember_id() %> | <%=reviewBoardDtoList.get(i).getPost_date() %><br>
						    			<%
						    			if(menuOptiosDtoList.size() != 0) {
						    				boolean check = false;
							    			for(MenuOptionDTO menuOptionDto : menuOptiosDtoList) {
							    				if(menuOptionDto.getNo() == optionNoList.get(i)) {
													out.println(menuOptionDto.getOption1_value());
							    					
							    					// 옵션2가 있을 때만 출력
							    					if(menuOptionDto.getOption2_value() != null) {
							    						out.println(" | " + menuOptionDto.getOption2_value());
							    					}
							    					check = true;
							    					break;
							    				}
							    			}
							    			if(!check)
							    				out.println("현재 제공되지 않는 옵션입니다.");
						    			} else {
						    				out.println("옵션 없음");
						    			}
						    			%>
						    			<p>
						    				<%if(reviewBoardDtoList.get(i).getVisibility().equals("visible"))
						    					out.println(reviewBoardDtoList.get(i).getContent());
						    				else {
						    					out.println("<img src='/RYANBUCKS_v1.0/common/img/icon_alert.png'>");
						    					out.println("<strong>해당 리뷰는 관리자 권한에 의해 숨김 처리 되었습니다.</strong>");
						    				}
						    				%>
						    			</p>
						    		</div>
								</li>
							<%
							}
							%>
							</ul>
						</div>
						<!-- // 목록 -->
						
						<%if(reviewBoardDtoList.size() > 10) { %>
						<!-- 페이지 -->
						<%
						int endPage = (reviewBoardDtoList.size()) / 10 + ((reviewBoardDtoList.size() % 10 == 0)? 0 : 1);
						int thisStartPage = (page_no - 1) / 10 * 10 + 1;
						int thisEndPage = ((page_no - 1) / 10 + 1) * 10;
						
						if(reviewBoardDtoList.size() > 10) { %>
						<div class="pagination_wrap">
							<ul class="pager">
							<%if(page_no >= 11) { %>
								<li>
									<a href='javascript:void(0);' onclick="goPrevPageList()">
										<img alt='이전' src='/RYANBUCKS_v1.0/common/img/prev.jpg'>
									</a>
								</li>
							<%} %>
								
							<%for(int i = thisStartPage; i <= ((thisEndPage < endPage)? thisEndPage : endPage); i++) { %>
								
								<li <%=(i == page_no)? "class='active'" : "" %>>
									<a href='javascript:void(0);' onclick='changePage(<%=i %>)'><%=i %></a>
								</li>
							<%} %>
								
							<%if(thisEndPage < endPage) { %>
								<li>
									<a href='javascript:void(0);' onclick="goNextPageList()">
										<img alt='다음' src='/RYANBUCKS_v1.0/common/img/next.jpg'>
									</a>
								</li>
							<%} %>
							</ul>
						</div>
						<%
						}
						}
						%>
						
						<!-- // 페이지 -->
					</div>
					<!-- // 리뷰 목록 -->
					
					<%
					} else {
					%>
						<!-- 작성된 리뷰가 없을 때 -->
						<strong id="no_list">등록된 리뷰가 없습니다.</strong>
					<%
					}
					%>
					
				</div>
				<!-- // 리뷰 -->
			</div>
			<!-- // 내용 -->
		</div>
		<!-- // container -->
		<jsp:include page="/footer.jsp" />
	</div>
	<!-- // wrap -->

	<script>
		// 썸네일 클릭 시 클릭된 이미지를 확대 이미지 영역에 표시
		$(document).ready(function () {
			$(".gallery").on("click", function() {		// 클래스명이 gallery인 요소 클릭 시
				$(".gallery").removeClass("active");	// 클래스명이 gallery인 요소의 클래스에서 active를 제거
				$(this).addClass("active");				// 클릭된 요소의 클래스에는 active 추가
				
				var path = $(this).attr("data-image");	// 클릭된 이미지의 이미지 경로
				
				$(".zoomImg").attr("src", path);
			});
		});
	</script>
	<script>
		// 페이지 로드 시 실행되는 함수
    	window.onload = function () {
    		var selectOption = document.getElementById("option_no");
    		var selectedOption = selectOption.options[selectOption.selectedIndex];
    		var extraPrice = Number(selectedOption.getAttribute('data-option-price'));
    		var price = document.querySelector(".total_price_wrap .price");

    		price.innerHTML = (<%=menuDto.getSales_price()%> + extraPrice).toLocaleString('ko-KR');

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
			
			var selectOption = document.getElementById("option_no");
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
			
			var selectOption = document.getElementById("option_no");
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
			var totalPrice = (<%=menuDto.getSales_price()%> + extraPrice); // 옵션 변경 시에는 수량이 1이기 때문에 '* 1' 생략
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
		
		// 정렬 기준 변경 시
		function changeSorting(selectElement) {
			// selectElement는 select 요소를 나타냄 (*선택된 option 요소가 아님)
			// select 요소에서 option 선택 시 select 요소의 value는 선택된 옵션의 value가 됨

			var selectedOption = selectElement.selectedOptions[0];
    		var sort_option = selectedOption.value;
    		
    		location.href = "food_view.jsp?menu_no=" + <%=menuDto.getNo()%> + "&sort_option=" + sort_option;
    		// 정렬 기준 변경 시 리뷰 목록 페이지도 초기화됨
		}
		
		// 리뷰 목록 페이지 변경 시
		function changePage(page_no) {
			var URLSearch = new URLSearchParams(location.search);
			URLSearch.set('page_no', page_no);
			var newParam = URLSearch.toString();
			location.href = location.pathname + '?' + newParam;
		}
		
		// 리뷰 목록 페이지 이동 - "이전(<)" 버튼 클릭 시 
		function goPrevPageList() {
			var newPage = Math.floor(<%=page_no - 11 %> / 10) * 10 + 1;
			//console.log(newPage);
			
			var URLSearch = new URLSearchParams(location.search);
			URLSearch.set('page_no', newPage);
			var newParam = URLSearch.toString();
			window.open(location.pathname + '?' + newParam, '_self');
		}
		
		// 리뷰 목록 페이지 이동 - "다음(>)" 버튼 클릭 시 10(n+1) + 1 페이지로 이동
		function goNextPageList() {
			var newPage = Math.ceil(<%=page_no %> / 10) * 10 + 1;
			//console.log(newPage);
			
			var URLSearch = new URLSearchParams(location.search);
			URLSearch.set('page_no', newPage);
			var newParam = URLSearch.toString();
			window.open(location.pathname + '?' + newParam, '_self');
		}
		
	</script>
	
	<script>
		// 장바구니 추가 시
		function addCart() {
			var member_id = '<%=session.getAttribute("id") %>'.toString();
			//console.log(member_id);
			
			if(member_id == 'null') { // 로그인을 하지 않았을 경우
				if(confirm("로그인이 필요한 서비스입니다. 로그인 하시겠습니까?")) { // 확인
					location.href = "/RYANBUCKS_v1.0/login/login.jsp";
					return;
				}
				else {
					return;
				}
			}

	        document.submit_form.action = "/RYANBUCKS_v1.0/cart/cart_process.jsp"; //요청 보낼 주소
	        document.submit_form.submit();
		}
		
		// 주문 시
		function order() {
			var member_id = '<%=session.getAttribute("id") %>'.toString();
			//console.log(member_id);
			
			if(member_id == 'null') { // 로그인을 하지 않았을 경우
				if(confirm("로그인이 필요한 서비스입니다. 로그인 하시겠습니까?")) { // 확인
					location.href = "/RYANBUCKS_v1.0/login/login.jsp";
					return;
				}
				else {
					return;
				}
			}

	        // 호출 경로
	        var field = document.createElement("input");
	        field.setAttribute("type", "hidden");
	        field.setAttribute("name", "src");
	        field.setAttribute("value", "view");
	        document.submit_form.appendChild(field);
	
	        document.submit_form.action = "/RYANBUCKS_v1.0/cart/order_sheet.jsp"; //요청 보낼 주소
	        document.submit_form.submit();
		}
	</script>

</body>
</html>