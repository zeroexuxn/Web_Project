<%@page import="member.*"%>
<%@page import="address.*"%>
<%@page import="menu.*"%>
<%@page import="menu_image.*"%>
<%@page import="menu_option.*"%>
<%@page import="order_detail.*"%>
<%@page import="cart.*"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Vector"%>
<%@page import="java.time.LocalDate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String member_id = session.getAttribute("id").toString();		// 회원 ID
	String src = request.getParameter("src");						// order_sheet.jsp 호출 경로 (view 또는 cart)
	
	List<OrderDetailDTO> orderDetailDtoList = new Vector<OrderDetailDTO>();		// 주문할 메뉴 목록을 저장할 변수
	
	if(src.equals("view")) {	// drink_view.jsp, food_view.jsp에서 넘어오는 경우: 주문할 메뉴가 1개
		OrderDetailDTO orderDetailDto = new OrderDetailDTO();		// 주문할 메뉴 정보를 담는 OrderDetailDTO 객체
		
		orderDetailDto.setMenu_no(Integer.parseInt(request.getParameter("menu_no")));	// 메뉴 번호
		
		int option_no = 0;	// 옵션 번호 (*0번 옵션은 존재하지 않음)
		try {	// 옵션이 있는 메뉴인 경우 옵션 번호 저장
			option_no = Integer.parseInt(request.getParameter("option_no"));

		} catch(NumberFormatException e) {}	// 옵션이 없는 메뉴인 경우
		orderDetailDto.setOption_no(option_no);
		
		orderDetailDto.setQuantity(Integer.parseInt(request.getParameter("quantity")));			// 수량

		orderDetailDtoList.add(orderDetailDto);		// 리스트에 추가
		
	} else if(src.equals("cart")) {	// cart.jsp에서 넘어오는 경우: 장바구니 관리 번호를 받음, 주문할 메뉴가 1개 이상
		String[] order_menus = request.getParameterValues("order_menus");	// order_menus는 장바구니 관리 번호를 가짐
		
		//DAO 생성 후 Oracle DB 연결
		CartDAO cartDao = new CartDAO(application);
		
		for(String str : order_menus) {
			OrderDetailDTO orderDetailDto = new OrderDetailDTO();	// 주문할 메뉴 정보를 담는 OrderDetailDTO 객체
			
			CartDTO cartDto = cartDao.getCartDTO(Integer.parseInt(str));
			
			orderDetailDto.setMenu_no(cartDto.getMenu_no());
			orderDetailDto.setOption_no(cartDto.getOption_no());
			orderDetailDto.setQuantity(cartDto.getQuantity());
			
			orderDetailDtoList.add(orderDetailDto);		// 리스트에 추가
		}
		
		// DB 연결 해제
		cartDao.close();
	}
	
	//DAO 생성 후 Oracle DB 연결
	MenuDAO menuDao = new MenuDAO(application);
	MenuImageDAO menuImageDao = new MenuImageDAO(application);
	MenuOptionDAO menuOptionDao = new MenuOptionDAO(application);
	MemberDAO memberDao = new MemberDAO(application);
	
	List<MenuDTO> menuDtoList = menuDao.getMenuDTOList(orderDetailDtoList);
	List<MenuImageDTO> menuImageDtoList = menuImageDao.getMenuImageDTOList(orderDetailDtoList);
	List<MenuOptionDTO> menuOptionDtoList = menuOptionDao.getMenuOptionDTOList(orderDetailDtoList);
	String member_name = memberDao.getName(member_id);
	String member_tel = memberDao.getTel(member_id);
	String member_email = memberDao.getEmail(member_id);
	
	// DB 연결 해제
	menuDao.close();
	menuOptionDao.close();
	menuImageDao.close();
	memberDao.close();
	
	//DAO 생성 후 Oracle DB 연결
	AddressDAO addressDao = new AddressDAO(application);
	
	AddressDTO addressDto = addressDao.getAddressDto(member_id);		// 회원 주소 목록 가져오기

	// DB 연결 해제
	addressDao.close();

	String selectableFirstDate = LocalDate.now().plusDays(1).toString(); // +1일
	String selectableLastDate = LocalDate.now().plusDays(7).toString(); // +7일
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>주문하기 | Ryanbucks Korea</title>
	
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
						<li><a href="/RYANBUCKS_v1.0/index.jsp"><img src="/RYANBUCKS_v1.0/common/img/icon_home.png" alt="홈으로"></a>
						</li>
						<li>
							<img class="arrow" src="/RYANBUCKS_v1.0/common/img/icon_arrow.png" alt="하위메뉴">
						</li>
						<li>
							<a href="/RYANBUCKS_v1.0/my_ryanbucks/cart.jsp">장바구니</a>
						</li>
						<li>
							<img class="arrow" src="/RYANBUCKS_v1.0/common/img/icon_arrow.png" alt="하위메뉴">
						</li>
						<li>
							<a href="javascript:void(0);" class="this">주문</a>
						</li>
						<li>
							<img class="arrow" src="/RYANBUCKS_v1.0/common/img/icon_arrow.png" alt="하위메뉴">
						</li>
						<li>
							<a href="javascript:void(0);" class="next">완료</a>
						</li>
					</ul>
				</div>
			</div>
			<!-- // 서브 타이틀 -->
			
			<!-- 내용 -->
			<div class="content">
				<!-- form -->
				<form method="post" name="submit_form" action="order_process.jsp" onsubmit="return validateForm(this);">
				
				<input type="hidden" name="src" value=<%=src %>>
				
				<%
				if(src.equals("view")) {
				%>
					<input type="hidden" name="menu_no" value=<%=orderDetailDtoList.get(0).getMenu_no() %>>
					<input type="hidden" name="option_no" value=<%=orderDetailDtoList.get(0).getOption_no() %>>
					<input type="hidden" name="quantity" value=<%=orderDetailDtoList.get(0).getQuantity() %>>
				<%
				}
				%>

				<!-- 주문할 메뉴 목록 -->
				<div class="order_menu_list_wrap">
					<table>
						<tr>
							<th>NO</th>
							<th colspan="2">메뉴 정보</th>
							<th>금액</th>
							<th>수량</th>
							<th>소계금액</th>
						</tr>
						<%
						int total_price = 0;
						for(int i=0; i<orderDetailDtoList.size(); i++) {
							String file_name = menuImageDtoList.get(i).getFile_name();
							String name_kor = menuDtoList.get(i).getName_kor();
							
							String option_detail = "";
							int option_price = 0;
							
							if(menuOptionDtoList.get(i) != null) {
								if(menuOptionDtoList.get(i).getOption1_value() != null)
									option_detail += menuOptionDtoList.get(i).getOption1_value();
								if(menuOptionDtoList.get(i).getOption2_value() != null)
									option_detail += " | " + menuOptionDtoList.get(i).getOption2_value();
								
								option_price = menuOptionDtoList.get(i).getPrice();
								option_detail += "(+" + option_price + "원)";
							}
							
							int quantity = orderDetailDtoList.get(i).getQuantity();
							int price = menuDtoList.get(i).getSales_price() + option_price;
							
							total_price += price * quantity;
						%>
						<tr>
							<!-- 인덱스 -->
							<td class="index">
								<%=i+1 %>
							</td>
							<!-- // 인덱스 -->
						
							<!-- 썸네일 -->
							<td class="menu_tumnail">
								<a href="/RYANBUCKS_v1.0/menu/drink_view.jsp?menu_no=<%=menuDtoList.get(i).getNo() %>">
									<img src="/RYANBUCKS_v1.0/non_co_img/menu/<%=file_name %>" alt=<%=name_kor %>>
								</a>
							</td>
							<!-- // 썸네일 -->
							
							<!-- 메뉴 정보 -->
							<td class="menu_detail">
								<a href="/RYANBUCKS_v1.0/menu/drink_view.jsp?menu_no=<%=menuDtoList.get(i).getNo() %>">
									<strong><%=name_kor %></strong><br>
								</a>
								<%=option_detail %>
								
								<%
								if(src.equals("cart")) {
									String[] order_menus = request.getParameterValues("order_menus");
								%>
									<input type="checkbox" name="order_menus" value=<%=order_menus[i] %> checked>
								<%
								}
								%>
							</td>
							<!-- // 메뉴 정보 -->
							
							<!-- 가격 -->
							<td class="price">
								<%=String.format("%,d", price) %>원
							</td>
							<!-- // 가격 -->
							
							<!-- 수량 -->
							<td>
								<%=String.format("%,d", quantity) %>
							</td>
							<!-- // 수량 -->
							
							<!-- 소계 금액 -->
							<td class="subtotal_price">
								<strong><%=String.format("%,d", (price * quantity)) %>원</strong>
							</td>
							<!-- //소계 금액 -->
						</tr>
						<%
						}
						%>
						<!-- 합계 금액 -->
						<tr>
							<td colspan="3" class="total_price_label">
								<strong>총 상품 금액</strong>
							</td>
							<td colspan="3" class="total_price">
								<strong><%=String.format("%,d", total_price) %>원</strong>
							</td>
						</tr>
						<!-- // 합계 금액 -->
					</table>

				</div>
				<!-- // 주문할 메뉴 목록 -->
				
				<!-- 정보 입력 -->
				<div class="input_info_wrap">
					<!-- 수령인 정보 -->
					<div class="recipient_info_wrap">
						<fieldset>
							<legend>수령인 정보</legend>
							<table>
								<tr>
									<td><label for="name">이름</label><span class="necessary">(*필수)</span></td>
									<td><input type="text" name="recipient_name" id="name" maxlength=10 placeholder="최대 10자리" value=<%=member_name %>></td>
								</tr>
								<tr>
									<td><label for="tel_first">연락처<span class="necessary">(*필수)</span></label></td>
									<td>
										<select name="tel_first" id="tel_first">
											<option value="010" <%=(member_tel.substring(0, 3).equals("010")? "selected" : "") %>>010</option>
											<option value="011" <%=(member_tel.substring(0, 3).equals("011")? "selected" : "") %>>011</option>
											<option value="016" <%=(member_tel.substring(0, 3).equals("016")? "selected" : "") %>>016</option>
											<option value="017" <%=(member_tel.substring(0, 3).equals("017")? "selected" : "") %>>017</option>
											<option value="019" <%=(member_tel.substring(0, 3).equals("019")? "selected" : "") %>>019</option>
										</select>
										-
										<input type="number" name="tel_middle" id="tel_middle" maxlength="4" oninput="numberMaxLength(this);" placeholder="4자리" value=<%=member_tel.substring(4, 8) %>>
										-
										<input type="number" name="tel_last" id="tel_last" maxlength="4" oninput="numberMaxLength(this);" placeholder="4자리" value=<%=member_tel.substring(9, 13) %>>
									</td>
								</tr>
								<tr>
									<td><label for="email_id">이메일</label></td>
									<td>
										<input type="text" name="email_id" id="email_id" maxlength=20 placeholder="최대 20자리" value=<%=(member_email != null)? member_email.split("@")[0] : "" %>>
										@
										<select name="email_domain" id="email_domain">
											<option value="naver.com" <%=(member_email != null && member_email.split("@")[1].equals("naver.com"))? "selected"  : "" %>>naver.com</option>
											<option value="gmail.com" <%=(member_email != null && member_email.split("@")[1].equals("gmail.com"))? "selected"  : "" %>>gmail.com</option>
											<option value="hanmail.net" <%=(member_email != null && member_email.split("@")[1].equals("hanmail.com"))? "selected"  : "" %>>hanmail.net</option>
										</select>
									</td>
								</tr>
							</table>
						</fieldset>
					</div>
					<!-- // 수령인 정보 -->
					
					<!-- 주문 유형 -->
					<div class="order_type_wrap">
						<fieldset>
					    	<legend>주문 유형</legend>
					    	<input type="radio" name="order_type" id="order_type_pickup" value="pickup" checked><label for="order_type_pickup">픽업</label>
					    	<input type="radio" name="order_type" id="order_type_shipping" value="shipping"><label for="order_type_shipping">배송</label>
					    </fieldset>
					</div>
					<!-- // 주문 유형 -->
				
					<!-- 픽업 정보 -->
					<div class="pickup_info_wrap">
						<fieldset>
							<legend>픽업 정보</legend>
							<table>
								<tr>
									<td><label for="branch">픽업 지점</label></td>
									<td>
										<select name="branch" id="branch">
											<option value="상봉점">상봉점</option>
											<option value="중랑점">중랑점</option>
											<!-- 지점 목록을 위한 테이블 생성 시 value에는 지점 고유 번호, innterHTML에는 지점명 -->
										</select>
									</td>
								</tr>
								<tr>
									<td><label for="hour">픽업 시간</label></td>
									<td>
										<input type="date" name="date" value=<%=selectableFirstDate %> min=<%=selectableFirstDate %> max=<%=selectableLastDate %>>
										<select name="hour" id="hour">
											<%
											for(int i=9; i<22; i++) {
												out.println("<option value=" + i + ">" + i + "</option>");
											}
											%>
										</select>
										<select name="minutes" id="minutes"> <!-- input type=time은 시간 선택이 직관적이지 않아서 선택 안함 -->
											<%
											for(int i=0; i<60; i=i+10) {
												out.println("<option value=" + i + ">" + String.format("%02d", i) +"</option>");
											}
											%>
										</select>
										
										<span class="info">*주문일 기준 익일 ~ 7일 이내에만 픽업 주문이 가능합니다.</span>
										
									</td>
								</tr>
							</table>
						</fieldset>
					</div>
					<!-- // 픽업 정보 -->
				
					<!-- 배송지 정보 -->
					<div class="shipping_info_wrap">
						<fieldset>
							<legend>배송지 정보</legend>
							<%
							String new_address_checked = "";
							
							if(addressDto.getId() != null) {	// 등록된 주소가 있는 경우에만
							%>
								<input type="radio" name="address" id="existed" value="existed" checked><label for="exist">기본 배송지</label>
							<%
							} else {
								new_address_checked = "checked";
							}
							%>
					    	<input type="radio" name="address" id="new" value="new" <%=new_address_checked %>><label for="new">신규 배송지</label>
							
							<%
							if(addressDto.getId() != null) {	// 등록된 주소가 있는 경우에만
							%>
								<!-- 기본 배송지 -->
								<div class="existed_address">
								
								<input type="text" name="existed_post_code" id="existed_post_code" class="post_code" value=<%=addressDto.getPost_code() %> readonly>
				  				<input type="text" name="existed_road_address" id="existed_road_address" class="road_address" value="<%=addressDto.getRoad_address() %>" readonly>
				  				<input type="text" name="existed_detail_address" id="existed_detail_address" class="detail_address" value="<%=(addressDto.getDetail_address() == null)? "" : addressDto.getDetail_address() %>" readonly>
								<input type="button" id="address_list" onclick="addressPopup()" value="주소 목록">
								</div>
								<!-- // 기본 배송지 -->
							<%
							}
							%>
							
							<!-- 신규 배송지 -->
							<div class="new_address">
								<input type="text" name="new_post_code" id="post_code" class="post_code" placeholder="우편번호" readonly>
								<input type="button" id="search_address" onclick="execDaumPostcode()" value="검색">
								<br>
				  				<input type="text" name="new_road_address" id="road_address" class="road_address" placeholder="도로명주소" readonly>
				  				<input type="text" name="new_detail_address" id="detail_address" class="detail_address" maxlength=33 placeholder="상세주소(최대 20자리)">
				  				<input type="text" name="new_extra_address" id="extra_address" readonly>
							</div>
							<!-- // 신규 배송지 -->
						</fieldset>
					</div>
					<!-- // 배송지 정보 -->
					
					<!-- 결제 수단 -->
					<div class="pay_method">
						<fieldset>
							<legend>결제 수단</legend>
							<input type="radio" name="pay_method" id="card" value="CARD" checked><label for="card">신용카드</label><br>
						</fieldset>
					</div>
					<!-- // 결제 수단 -->
				</div>
				<!-- // 정보 입력 -->
			
				<!-- 약관 및 결제 -->
				<div class="terms_and_pay_wrap">
					<input type="checkbox" name="agree_terms"><a href="javascript:void(0);" onclick="showTerms()">개인정보 수집 및 이용 동의</a><span class="necessary">(*필수)</span><br>
					<input type="submit" value="결제하기"><br>
					<span class="info">*주문 완료 후 주문 변경 또는 취소는 불가합니다.</span>
				</div>
				<!-- // 약관동의 및 결제 -->
				</form>
				<!-- // form -->
			</div>	
			<!-- // 내용 -->
		</div>
		<!-- // container -->
		<jsp:include page="/footer.jsp" />
	</div>
	<!-- // wrap -->
	
	<!-- 개인정보 수집 및 이용 동의 약관 -->
	<div id="terms_wrap">
		<div class="body">
			<span class="close_button">&times;</span>
			<h3>개인정보 수집 및 이용 동의</h3>
			<p>1. 수집하는 개인정보 항목<br>이름, 연락처, 이메일, 주소, 주문정보, 결제정보, 회원정보</p>
			<p>2. 수집하는 개인정보 이용 목적</p>
	      	<ul>
	      		<li>주문 상품 준비</li>
	      		<li>고객상담 및 불만처리/부정이용 방지 등의 고객관리비</li>
	      		<li>서비스 개선·통계·분석</li>
	      	</ul>
	      	<p class="period">3. 개인정보의 보유 및 이용기간 : 회원 탈퇴 혹은 개인정보 수집 및 이용 동의 철회 시까지</p>
	      	<p>위 개인정보 제공 동의에 거부할 권리가 있으나, 거부 시 상품 구매가 제한될 수 있습니다.</p>
		</div>
	</div>
	<!-- // 개인정보 수집 및 이용 동의 약관 -->
	
	<script>
		const pickupRadio = document.getElementById('order_type_pickup');
		const shippingRadio = document.getElementById('order_type_shipping');
		
		// 주문 유형 - 픽업 선택 시
		pickupRadio.addEventListener('change', function() {
		    if(this.checked) {
		    	document.querySelector(".pickup_info_wrap").style.display = "block";	// 픽업 정보 영역 보임
		    	document.querySelector(".shipping_info_wrap").style.display = "none";	// 배송지 정보 영역 숨김
		      }
		});
		
		// 주문 유형 - 배송 선택 시
		shippingRadio.addEventListener('change', function() {
		    if(this.checked) {
		    	document.querySelector(".pickup_info_wrap").style.display = "none";		// 픽업 정보 영역 숨김
		    	document.querySelector(".shipping_info_wrap").style.display = "block";	// 배송지 정보 영역 보임
		      }
		});
	</script>
	
	<script>
		// 숫자 입력 자리수 제한
		function numberMaxLength(e){
			if(e.value.length > e.maxLength){
				e.value = e.value.slice(0, e.maxLength);
			}
		}
		
		var winRef;
		
		// 주소 목록 팝업 호출
		function addressPopup() {
			var url = "address_list_popup.jsp?member_id=" + '<%=member_id %>';
			
			if(winRef == null) {
				winRef = window.open(url, 'popupName', 'width=450, height=600, resizable=no, scrollbars=no, status=no;' );
			
			} else {
		        if (winRef.closed == false) {
		            winRef.focus();	// 팝업 창을 다시 활성화
		        } else {
		            winRef = window.open(url, 'popupName', 'width=450, height=600, resizable=no, scrollbars=no, status=no;');
		        }
		    }
		}
	</script>
	
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
		// 다음 우편번호 서비스(API)
		function execDaumPostcode() {
			new daum.Postcode({
        		oncomplete: function(data) {
	            	// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분
	
					// 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
					var roadAddr = data.roadAddress; // 도로명 주소 변수
					var extraRoadAddr = ''; // 참고 항목 변수
	
	            	// 법정동명이 있을 경우 추가
		            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
		                extraRoadAddr += data.bname;
		            }
					
		            // 건물명이 있고, 공동주택일 경우 추가한다.
		            if(data.buildingName !== '' && data.apartment === 'Y') {
		               extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
		            }
		            
		            // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
		            if(extraRoadAddr !== '') {
		                extraRoadAddr = ' (' + extraRoadAddr + ')';
		            }
	
		            // 우편번호와 주소 정보를 해당 필드에 넣는다.
		            document.getElementById('post_code').value = data.zonecode;
		            document.getElementById("road_address").value = roadAddr;
	            
		            // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
		            if(roadAddr !== ''){
		                document.getElementById("extra_address").value = extraRoadAddr;
		            } else {
		                document.getElementById("extra_address").value = '';
		            }
        		}
    		}).open();
		}
	</script>
	
	<script>
		// 약관 내용 출력
		function showTerms() {
			const modal = document.getElementById("terms_wrap");
			const closeBtn = document.querySelector("#terms_wrap .close_button");
			
			modal.style.display = "block";	// 약관 내용이 개재된 영역을 화면에 보여줌
			
			closeBtn.onclick = function() {	// 닫기(x) 클릭 시 화면에서 숨김
				modal.style.display = "none";
			}
			
			window.onclick = function(event) {	// 약관 동의 영역 밖을 클릭한 경우 화면에서 숨김
				if (event.target == modal) {
					modal.style.display = "none";
				}
			}
		}
	</script>
	
	<script>
		// form 제출 전 검증
		function validateForm(form) {
			// 수령인 이름를 입력하지 않았을 때
			if(!form.recipient_name.value) {
				alert("수령인 이름을 입력해주세요.");
				form.recipient_name.focus();
				return false;
			}
			
			// 수령인 연락처를 입력하지 않았을 때
			if(!form.tel_middle.value) {
				alert("수령인 연락처를 입력해주세요.");
				form.tel_middle.focus();
				return false;
			} else if(!form.tel_last.value) {
				alert("수령인 연락처를 입력해주세요.");
				form.tel_last.focus();
				return false;
			}
			
			// 수령인 연락처가 올바르지 않을 때
			if(form.tel_middle.value.length != 4) {
				alert("수령인 연락처가 올바르지 않습니다.");
				form.tel_middle.focus();
				return false;
			} else if(form.tel_last.value.length != 4) {
				alert("수령인 연락처가 올바르지 않습니다.");
				form.tel_last.focus();
				return false;
			}
			
			// 신규 배송지 주소를 입력하지 않았을 때
			if(form.order_type.value == 'shipping' && form.address.value == 'new' && !form.new_post_code.value) {
				alert("배송지 주소를 입력해주세요.");
				form.new_post_code.focus();
				return false;
			}
			
			// 약관동의란에 체크하지 않은 경우
			if(!form.agree_terms.checked) {
				alert("약관에 동의해주세요.");
				form.agree_terms.focus();
				return false;
			}
		}
	</script>

</body>
</html>