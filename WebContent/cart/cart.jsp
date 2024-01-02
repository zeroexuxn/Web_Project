<%@page import="menu_option.MenuOptionDTO"%>
<%@page import="menu_image.MenuImageDTO"%>
<%@page import="menu.MenuDTO"%>
<%@page import="menu_option.MenuOptionDAO"%>
<%@page import="menu_image.MenuImageDAO"%>
<%@page import="menu.MenuDAO"%>
<%@page import="cart.CartDTO"%>
<%@page import="java.util.List"%>
<%@page import="cart.CartDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
String member_id = "";
if(session.getAttribute("id") == null)
	response.sendRedirect("../login/login.jsp");
else
	member_id = session.getAttribute("id").toString();

CartDAO cartDao = new CartDAO(application);
MenuDAO menuDao = new MenuDAO(application);
MenuImageDAO menuImageDao = new MenuImageDAO(application);
MenuOptionDAO menuOptionDao = new MenuOptionDAO(application);

List<CartDTO> cartList = cartDao.selectProduct(member_id);
List<MenuDTO> menuDto2 = menuDao.getMenuDTO();	// 메뉴 정보 조회
List<MenuImageDTO> menuImageDtoList = menuImageDao.getOneMenuImages();			// 메뉴 이미지 목록
List<MenuOptionDTO> menuOptiosDtoList = menuOptionDao.getCartMenuOptions();		// 메뉴 옵션 목록

//Oracle DB 연결 해제함.
cartDao.close();
menuDao.close();
menuImageDao.close();
menuOptionDao.close();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니 | Ryanbucks Korea</title>
<link href="/RYANBUCKS_v1.0/common/css/reset.css" rel="stylesheet">
<link href="/RYANBUCKS_v1.0/common/css/style_main.css" rel="stylesheet">
<link href="/RYANBUCKS_v1.0/common/css/style_cart.css" rel="stylesheet">
<link href="/RYANBUCKS_v1.0/common/img/logo.png" rel="short icon" type="image/ico">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.2.0.min.js"></script>

</head>
<body>
<div id="wrap">
	<%@ include file="/header.jsp"%>

		<!-- 메인 화면 -->
		<div class="container">

			<!-- lnb -->
			<div class="lnb">
				<div class="inner-lnb">
					<div class="tab_menu" role="tablist">
						<button type="button" class="tab">장바구니</button>
					</div>
					<ul class="smap">
						<li><a href="/RYANBUCKS_v1.0/index.jsp"> <img
								src="/RYANBUCKS_v1.0/common/img/icon_home.png" alt="홈으로">
						</a></li>
						<li><img class="arrow"
							src="/RYANBUCKS_v1.0/common/img/icon_arrow.png" alt="하위메뉴"></li>
						<li><a href="javascript:void(0);" class="this">장바구니</a></li>
					</ul>
				</div>
			</div>
			<!-- //lnb -->

			<!-- 장바구니에 담긴 상품이 없을 때 -->
			<%
			if(cartList.size() == 0) {
			%>
			<div class="no_product">
			<% 
				out.println("장바구니에 담긴 상품이 없습니다.");
			%>
			</div>
			<!-- //장바구니에 담긴 상품이 없을 때 -->
			
			
			<!-- 장바구니에 상품이 담겼을 때 -->
			<%
			} else {
			
			%>

			
			<form method="post" action="order_sheet.jsp" id="form" name="frmView" onsubmit="return validateForm(this)">
			
				<!-- 선택 부분 -->
				<input type="hidden" name="src" value="cart">
				<div class="check_all">
					<div class="fixed_area">
						<div class="inner-check_all">
							<div class="check_box">
								<div class="btn_check" role="button">
									<span class="all-check"> 
										<svg width="16" height="16" viewBox="0 0 16 16" fill="none" class="ico_check">
											<path
												d="M12.945 4L14.1 5.154 6.387 12.8 2 8.4l1.155-1.153 3.232 3.246L12.945 4z" fill="#C7CACD">
											</path>
										</svg>
									</span> 전체 선택
								</div>
							</div>
							<button type="button" class="btn_delete" onclick="deleteList(this)">
								<svg width="16" height="16" viewBox="0 0 16 16" fill="none" class="ico_delete">
									<path
										d="M13 2.5l.707.707-4.646 4.647 4.646 4.646-.707.707-4.646-4.646-4.647 4.646L3 12.5l4.647-4.646L3 3.207l.707-.707 4.647 4.647L13 2.5z" fill="#BDC0C6">
									</path>
								</svg>
								선택 삭제
							</button>
						</div>
					</div>
				</div>
				<!-- //선택 부분 -->

				<!-- 상품 정보 -->
				<div class="contents">
					<%
					for (CartDTO dto : cartList) {
						for (MenuDTO menu : menuDto2) {
							if (dto.getMenu_no() == menu.getNo()) {
					%>

					<div class="store_container">
						<div class="store_card">
							<div class="products_info">
								<div class="inner-product">
									<div class="inner-product_info">
										<div class="cell">
											<div class="product_description">
												<div class="check-product">
													<button type="button" class="btn_check" role="checkbox">
														<input type="checkbox" name="order_menus" id="order_menus_<%=dto.getNo() %>" value=<%=dto.getNo() %> style="display:hidden">
														<label for="order_menus"> 
															<%
																String zero = "no";
																if(menu.getStock() == 0){
																	zero = "zero";
																}
															%>
															<span class="check <%=zero %>">
																<svg width="16" height="16" viewBox="0 0 16 16" fill="none" class="ico_check">
																	<path
																		d="M12.945 4L14.1 5.154 6.387 12.8 2 8.4l1.155-1.153 3.232 3.246L12.945 4z" fill="#C7CACD">
																	</path>
																</svg>
															</span>
														</label>
													</button>
												</div>
												<div class="inner-product-one">
													<!-- 메뉴 이미지 -->
													<div class="thumb">
														<% 
															for (MenuImageDTO menuImage : menuImageDtoList) {
																if (dto.getMenu_no() == menuImage.getMenu_no()) {
														%>
														<a href="/RYANBUCKS_v1.0/menu/drink_view.jsp?menu_no=<%=dto.getMenu_no()%>"> 
														  <img src="/RYANBUCKS_v1.0/non_co_img/menu/<%=menuImage.getFile_name()%>" alt="상품 이미지"> 
														</a>
															<% 
																}  
															} 
															%>
													</div>
													<!-- // 메뉴 이미지 -->
													
													<div class="info_area">
														<% 
															if(menu.getStock() != 0) {
														%>
																<!-- 메뉴명 -->
																<div class="title" >
																	<%=menu.getName_kor()%>
																</div>
																<!-- // 메뉴명 -->
																
																<!-- 단가 -->
																<div class="price">
																	<%=String.format("%,d", menu.getSales_price())%>원
																</div>
																<!-- // 단가 -->
																			
															<%
																int optionPrice = 0;
																
																if (dto.getOption_no() != 0) {
																	for(MenuOptionDTO menuOption : menuOptiosDtoList) {
																		if(dto.getOption_no() == menuOption.getNo()) {
																			optionPrice = menuOption.getPrice();
															%>
																			<!-- 옵션 -->
																			<div class="option">
																			 	<%=menuOption.getOption1_value()%>
																				|
																				<%
																					if(menuOption.getOption2_value() != (null)) {
																				%>
																						<%=menuOption.getOption2_value()%>
																				<%
																					}
																				%>
																				(<%=String.format("%+,d", menuOption.getPrice())%>원)
																				<!-- // 옵션 -->
																			</div>
																			<%
																			break;
																		}
																		
																	}
																	
																} else {
																	%>
																	<div class="option">
																 	 옵션 없음
																	<!-- // 옵션 -->
																</div>
																<% 
																}
																%>
																<!-- 수량 -->			
																<div class="quantity">
																	<%=dto.getQuantity()%>
																</div>
																<!-- // 수량 -->	
																
																<!-- 주문 수정 버튼 -->
																<div class="option-button">
																	<button type="button" class="option-button-select" value=<%=dto.getNo() %> onclick="Option(this)">
																		주문 수정
																	</button>	
																</div>
																<!-- // 주문 수정 버튼 -->
																
																<!-- 총 결제 금액 -->
																<div class="total_price">
																	<%=String.format("%,d", dto.getQuantity() * (menu.getSales_price() + optionPrice))%>원
																</div>
																<!-- // 총 결제 금액 -->
														<%  
							
															} else {%>
																<div class="stockzero">
																<% 
																	out.println("해당 상품은 재고가 존재하지 않습니다.");
																%>
																</div>
																<% 
															}
														
							} 
						}
					%>

													</div>

													<button type="button" class="x-delete" role="button" value=<%=dto.getNo() %> onclick="deleteOne(this)">
														X
													</button> 
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<%
					}
					%>
					<div class="order-product">
						<button class="add-button" type="button" onclick="location.href='../menu/menu.jsp';">메뉴 추가</button>
						<input type="submit" value="주문하기" class="pay-button">
					</div>
				</div>
				<!-- //상품 정보 -->
				
			</form>
			<%
			}
			%>
			<!-- // 장바구니에 상품이 담겼을 때 -->
		</div>
		<!-- //메인 화면 -->

	

	<script>
		/* 전체 선택 버튼을 클릭했을 때  */
		var selected_length = $(".check.checked").length; // 체크 상태인 상품 수
		var checkbox_length = $(".check").length; // 장바구니에 담겨있는 상품 수(체크 활성화용)
		var stockzero = $(".check.zero").length; // 제고가 0인 상품 수
		var count = $(".store_container").length; // 장바구니에 담겨있는 상품 수(상품 삭제용)

		$(function() {
			$(".all-check").click(
					function() {
						// 장바구니에 담겨있는 상품의 수가 0이거나 재고가 0인 상품만 담겨있을 때
						if (checkbox_length == 0 || checkbox_length == stockzero) {
							$(".all-check").removeClass("checked");
						}
						// 장바구니에 담겨있는 상품의 수가 0이 아닐 때
						else { 
							// 전체 선택 상태가 체크가 되지 않은 상태일 때 클릭했다면 checked
							if ($(".all-check").attr("class") == "all-check") {
								$(".all-check").addClass("checked");
								$(".check").addClass("checked");

								/* alert(checkbox_length); */
								<%
								for(CartDTO cartDto : cartList) {
								%>
									$("#order_menus_" +<%=cartDto.getNo() %>).prop("checked", true);
								<%
								}
								%>
								
								$(".check.zero").removeClass("checked");
								$(".check.zero").parent().prev().prop("checked", false);
							}

							// 전체 선택 상태가 체크가 된 상태일 때 클릭했다면 모든 체크박스의 checked 해제
							else {
								$(".all-check").removeClass("checked");
								$(".check").removeClass("checked");
								$("#order_menus").prop("checked", false);
								<%
								for(CartDTO cartDto : cartList) {
								%>
									$("#order_menus_" +<%=cartDto.getNo() %>).prop("checked", false);
								<%
								}
								%>
							}

						} 
						// 체크 상태인 상품 수 반영
						selected_length = $(".check.checked").length;
					});
		});

		/* 개별 선택 */
		$(function() {
			$(".check").click(function() {

				// 재고가 0인 상품은 체크박스를 선택할 수 없도록 설정
				if($(this).attr("class") == "check zero") {
					$(this).removeClass("checked");
					$(this).parent().prev().prop("checked", false);
					$(".all-check").removeClass("checked");
					
				// 재고가 0이 아닌 상품의 체크박스 설정	
				} else {
					// 체크되지 않은 체크박스를 클릭했을 때
					if ($(this).attr("class") == "check no") {
						$(this).addClass("checked");
						$(this).parent().prev().prop("checked", true);
						selected_length += 1;
					// 체크된 체크박스를 클릭했을 때
					} else {
						$(this).removeClass("checked");
						$(this).parent().prev().prop("checked", false);
						selected_length -= 1;
					}
				}
				
				// 체크 상태인 상품 수와 장바구니에 있는 상품의 수가 동일할 경우(재고가 0인 상품 제외), 전체 선택 체크박스를 체크 상태로 설정
				// selected_length != 0 --> 장바구니에 재고가 0인 상품만 들어있다면 0(selected_length) == 0(checkbox_length-stockzero)이 성립되어서 전체 선택 버튼이 체크 상태로 바뀜
				// 그를 방지하지 위해 조건문 추가함.
				if (selected_length == (checkbox_length-stockzero) && selected_length != 0) {
					$(".all-check").addClass("checked");
				} else {
					$(".all-check").removeClass("checked");
				}

			});

		});

		/* 선택 삭제 */
		$(function() {
			$(".btn_delete").click(function() {

				// 체크 상태인 상품들을 장바구니에서 삭제
				$(".check.checked").parentsUntil("#form").remove();
				$(".check").removeClass("checked");
				checkbox_length = $(".check").length;
				selected_length = $(".check.checked").length;

				// 전체 선택 버튼 체크 해제
				$(".all-check").removeClass("checked");
				/* alert(selected_length); */
			});
		});

		/* X 삭제 */
		$(function() {
			$(".x-delete").click(function() {
				// 각 상품의 X 버튼을 클릭했을 때 장바구니에서 해당 상품 삭제
				$(this).parentsUntil("#form").remove();
				checkbox_length = $(".check").length;
				selected_length = $(".check.checked").length;

				// 장바구니에 상품이 없는 경우 전체 선택 버튼 체크 해제
				if (checkbox_length == 0) {
					$(".all-check").removeClass("checked");
				}
				/* alert(checkbox_length); */

			});
		});
		
		function validateForm(form) {
			// 상품을 선택하지 않았을 때
			if(selected_length == 0) {
				alert("상품을 선택해주세요.");
				return false;
			}
		}
	</script>

	<script>
		
			// X 버튼을 클릭했을 때 상품 삭제 DB 반영
			function deleteOne(button) {
				// 장바구니에 상품이 없거나 선택한 상품이 없는 경우를 제외하고 실행
				
					location.href = "delete_process.jsp?type=single&no=" + button.value;
				
			}
	
			function deleteList() {
				if(checkbox_length != 0 || selected_length != 0) {
					var field = document.createElement("input");
					field.setAttribute("type", "hidden");
					field.setAttribute("name", "type");
					field.setAttribute("value", "multi");
					document.frmView.appendChild(field);
		
					document.frmView.method = "post";
					document.frmView.action = "delete_process.jsp";
					document.frmView.submit();
				}
			}
	
	</script>
	
	<script>
		// 주문 수정 버튼 클릭했을 때
		function Option(button) {
			window.open("option_popup.jsp?no=" + button.value, "optionPopup",
			"width=470, height=550, top=300, left=1000");
		}

		function OptionList() {

			var field = document.createElement("input");
			field.setAttribute("type", "hidden");
			field.setAttribute("name", "no");
			field.setAttribute("value", button.value);
			document.frmView.appendChild(field);

			document.frmView.method = "post";
			document.frmView.action = "option_popup.jsp";
			document.frmView.submit();
		}
	</script>

</div>
<%@ include file="/footer.jsp"%>
</body>
</html>