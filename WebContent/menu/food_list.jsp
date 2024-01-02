<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="menu_image.*"%>
<%@ page import="menu.*" %>
<%@ page import="category.*" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <%   
	//DAO를 생성한 후 Oracle DB에 연결하기
	CategoryDAO categoryDao = new CategoryDAO(application);		// 카테고리 DAO
	MenuDAO menuDao = new MenuDAO(application);					// 메뉴 DAO
	MenuImageDAO menuimageDao = new MenuImageDAO(application);	// 메뉴 이미지 DAO

	List<CategoryDTO> categoryType = categoryDao.categoryTypeImport("food");	
	List<MenuDTO> menuId = menuDao.menuCategoryIdImport(null);
	List<MenuDTO> newmenu = menuDao.newMenuImport("food");
	List<MenuImageDTO> menuImgList = menuimageDao.selectList();
			
	// Oracle DB 연결 해제하기
	categoryDao.close(); 
	menuDao.close();
	menuimageDao.close();
 %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>푸드 | Ryanbucks Korea</title>
<link href="/RYANBUCKS_v1.0/common/css/reset.css" rel="stylesheet"> <!-- 헤더, 푸터 -->
<link href="/RYANBUCKS_v1.0/common/css/style_main.css" rel="stylesheet"> <!-- 헤더, 푸터 -->
<link href="/RYANBUCKS_v1.0/common/css/style_drink_food_list.css" rel="stylesheet">
<link href="/RYANBUCKS_v1.0/common/img/logo.png" rel="short icon" type="image/ico">
<script src="https://code.jquery.com/jquery-latest.min.js"></script>	<!-- JQuery를 사용하기 위한 라이브러리 -->
</head>
<body>
<jsp:include page="/header.jsp" />
<!-- container -->
<div id="container">
	<!-- 서브 타이틀 -->
	<div class="sub_tit_wrap">
		<div class="sub_tit_inner">
			<h2>
				<img src="/RYANBUCKS_v1.0/non_co_img/sub_title/food_tit.jpg" alt="푸드">
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
					<a href="menu.jsp">MENU</a>
				</li>
				<li>
					<img class="arrow" src="/RYANBUCKS_v1.0/common/img/icon_arrow.png" alt="하위메뉴">
				</li>
				<li>
					<a href="food_list.jsp" class="this">푸드</a>
				</li>
			</ul>
		</div>	
	</div>
	<!-- //서브 타이틀 -->
	
	<div class="content">
		<!-- product_kind_wrap, 분류 보기 -->
		<div class="product_kind_wrap">
			<p class="tit">분류보기</p>
			<div class="product_kind_btn">
				<a href="javascript:void(0)" role="button">
					<img src="/RYANBUCKS_v1.0/common/img/list_up_btn.png" alt="분류보기 메뉴 접기" class="kind_btn_img">
				</a>
			</div>
		<div class="product_toggle_wrap" display="block">
				<dl class="product_kind_tab">
					<dt class="dt1">
						<a href="javascript:void(0)" id="categoryTab" class="tab selected" role="button" title="카테고리별 푸드선택">카테고리</a>
					</dt>
					<dd id="panel" style="display:block">
						<div class="product_select_wrap">
							<form method="post">
								<fieldset>
									<legend class="hid">푸드 카테고리 별 분류 보기</legend>
									<ul class="cate_list mCustomScrollbar _mCS_1 mCS_no_scrollbar">
										<div id="mCSB_1" class="mCustomScrollBox mCS-light mCSB_vertical mCSB_inside" tabindex="0">
											<div id="mCSB_1_container" class="mCSB_container mCS_y_hidden mCS_no_scrollbar_y" style="position:relative; top:0; left:0;" dir="ltr">
												<li><input style="vertical-align:middle;" type="checkbox" name="product_all" id="product_all" checked="checked"> 
													<label for="product_all">전체 상품보기</label>
												<% 
												for(CategoryDTO categoryDto : categoryType) {
												%>
											
												<li><input style="vertical-align:middle;" type="checkbox" name="<%= categoryDto.getName() %>" id="<%= categoryDto.getId() %>" > 
													<label for="<%= categoryDto.getId() %>"><%= categoryDto.getName() %></label>
													
												</li>
												
												<% } %>
											</div>
												<div id="mCSB_1_scrollbar_vertical" class="mCSB_scrollTools mCSB_1_scrollbar mCS-light mCSB_scrollTools_vertical" style="display: none;">
													<div class="mCSB_draggerContainer">
														<div id="mCSB_1_dragger_vertical" class="mCSB_dragger" style="position: absolute; min-height: 30px; height: 0px; top: 0px;" oncontextmenu="return false;">
															<div class="mCSB_dragger_bar" style="line-height: 30px;">
															</div>
														</div>
													<div class="mCSB_draggerRail"></div>
												</div>
											</div>
										</div>
									</ul>
								</fieldset>
							</form>
						</div>
					</dd>
					<dt class="dt2">
						<a href="javascript:void(0)" id="themeTab" title="테마별 푸드보기" class="tab">신메뉴</a>
					</dt>
					<dd class="panel" style="display:none">
						<ul class="cate_list service_bn">
							<li>
								<a href="javascript:void(0)" role="button">
									<img src="/RYANBUCKS_v1.0/non_co_img/menu/seasonmenu.jpg" alt="시즌 프로모션" data-sbseq="W0000462" style="width: 335px; height: 90px">
								</a>
							</li>
						</ul>
					</dd>
				</dl>
			</div>
		</div>
		<!-- //product_kind_wrap, 분류 보기 -->
		
		<!-- product_result_wrap product_result_wrap01, 푸드 리스트(카테고리 별) -->
		<div class="product_result_wrap product_result_wrap01" id="category_list" style="display:block;">
			<div class="product_view_tab_wrap">
				<dl class="product_view_tab product_view_tab01">
					<dd>
						<div class="product_list">
							<dl>
								<% 
									for(CategoryDTO categoryDto : categoryType) {
								%>					
								<dt class="<%= categoryDto.getId() %> bread" style="display:;">
									<a href="javascript:void(0);"><%= categoryDto.getName() %></a>
								</dt>
								<dd class="<%= categoryDto.getId() %> bread" style="display:;">
									<ul class="product_bakery">
										<li class="menuDataSet" new="Y" sell recomm="0" sold="N" premier="N">
									 		<dl class="image_grid">
									 		 	<% 
												    for (MenuDTO menuDto : menuId) {
												        if (menuDto.getCategory_id().equals(categoryDto.getId())) {
												 %>	
												 <% 
												 	for (MenuImageDTO menuImgDto : menuImgList) {
												        if (menuImgDto.getMenu_no() == menuDto.getNo()) { 
												  %>
									 			 <div class="image_item">
										         	<a href="food_view.jsp?menu_no=<%= menuDto.getNo() %>" class="goFoodView">
										            	<img src="/RYANBUCKS_v1.0/non_co_img/menu/<%=menuImgDto.getFile_name() %>" alt="<%= menuDto.getName_kor() %>">
										            </a>
										                 <dd><%= menuDto.getName_kor() %></dd>
										             </div>
										             <%	
												         }	
												       }
											          }
											       }
											    %>
									 		</dl>
									 	</li>
									</ul>
								</dd>
								<% } %>
							</dl>
						</div>
						<!-- product_no_result, 검색 결과 없을 때 -->
						<div class="product_no_result" style="display:none;">
						</div>
						<!-- //product_no_result, 검색 결과 없을 때 -->
					</dd>
				</dl>
			</div>
		</div>
		<!-- //product_result_wrap product_result_wrap01, 푸드 리스트(카테고리 별) -->
		
		<!-- product_result_wrap product_result_wrap02, 푸드 리스트(신메뉴) -->
		<div class="product_result_wrap product_result_wrap02" id="new_list" style="display:none;">
			<div class="product_view_tab_wrap">
				<dl class="product_view_tab product_view_tab02">
					<dt style="display:none;"></dt>
					<dd>
						<div class="product_list">
							<dl>
								<dd>
									<ul>
										<li>
											<dl class="image_grid">
												<% 
													// 3개월전 날짜를 계산한다.
													Calendar calendar = Calendar.getInstance();
													calendar.setTime(new Date());
													calendar.add(Calendar.MONTH, -3);
													Date threeMonthsAgo = calendar.getTime();

												     for (MenuDTO menuDto : newmenu) {
												         if (menuDto.getRegist_date().before(threeMonthsAgo)) {
												   %>	
												   		<p class="no_newmenu">해당 메뉴가 없습니다.</p>
												   <% break; } else { %>
												   <% for (MenuImageDTO menuImageDto : menuImgList) {
												         if (menuImageDto.getMenu_no() == menuDto.getNo()) { 
												    %>
												         
										             <div class="image_item">
										                 <a href="food_view.jsp?menu_no=<%= menuDto.getNo() %>" class="goFoodView">
										                     <img src="/RYANBUCKS_v1.0/non_co_img/menu/<%=menuImageDto.getFile_name() %>" alt="<%= menuDto.getName_kor() %>">
										                 </a>
										                 <dd><%= menuDto.getName_kor() %></dd>
										             </div>
										            <%		}
												         }
											           }
											       }
										    		%> 
											</dl>
										</li>
									</ul>
								</dd>
							</dl>
						</div>
					</dd>
				</dl>
			</div>
		</div>
		<!-- //product_result_wrap product_result_wrap02, 푸드 리스트(신메뉴) -->
	</div>
</div>
<!-- //container -->
<jsp:include page="/footer.jsp" />
<script>	 
	 $(document).ready(function () {
			$(".product_kind_btn").click(function() {			// 클래스명이 "product_kind_btn"인 요소에 클릭 이벤트가 발생하면
				var toggle_wrap = $(".product_toggle_wrap");
				var img = $(".kind_btn_img");					// 현재 클릭된 요소를 선택
				
				if (toggle_wrap.css("display") === "block") { 
					toggle_wrap.css("display", "none");
	            } else {
	            	toggle_wrap.css("display", "block");
	            }
				
				if (img.attr("src") === "/RYANBUCKS_v1.0/common/img/list_down_btn.png") {	// 기존 이미지 경로
					img.attr("src", "/RYANBUCKS_v1.0/common/img/list_up_btn.png"); 			// 새 이미지 경로로 변경
		        } else {
		        	img.attr("src", "/RYANBUCKS_v1.0/common/img/list_down_btn.png");		
		        }
			});
		});
	</script>
	<script>
		// 작은 썸네일 클릭 시 클릭된 이미지를 큰 썸네일에 표시
		$(document).ready(function () {
			$(".tab").on("click", function() {			// 클래스명이 "tab"인 요소에 클릭 이벤트가 발생하면
				$(".tab").removeClass("selected");		// 클래스명이 "tab"인 요소의 클래스에서 "active"를 제거하고
				$(this).addClass("selected");			// 클릭 이벤트가 발생한 요소의 클래스에 "active" 추가
			});
		});
		
	</script>
	
	<script>
		 $(document).ready(function() {
		        $("#categoryTab").on("click",function() {
		        	$(".tab").removeClass("selected");		
					$(this).addClass("selected");			
		    	            
		            $("#panel").css("display", "block");			// 카테고리 푸드 종류
		            $(".panel").css("display", "none");				// 신메뉴 카테고리 
		            $("#category_list").css("display", "block");	// 카테고리 푸드 리스트
		            $("#new_list").css("display", "none");			// 신메뉴 푸드 리스트
		        });
		        
		        $("#themeTab").on("click",function() {
		        	$(".tab").removeClass("selected");		
					$(this).addClass("selected");			
					
		            // 형제 요소 선택
		            $("#panel").css("display", "none");				// 카테고리 푸드 종류
		            $(".panel").css("display", "block");			// 신메뉴 카테고리 
		            $("#category_list").css("display", "none");		// 카테고리 푸드 리스트
		            $("#new_list").css("display", "block");			// 신메뉴 푸드 리스트
		        });	
		    });
	</script>
	
	<script>
	// 해당 카테고리의 메뉴들만 출력하기
	$(document).on('click', "#mCSB_1_container input[type=checkbox]", function(){
	    if(this.checked) {
	        const checkboxes = $("#mCSB_1_container input[type=checkbox]");
	        var id = $(this).attr("id");
			var checked = $(this).prop('checked');
	        for(let ind = 0; ind < checkboxes.length; ind++){
	            checkboxes[ind].checked = false;
	        }
	         if (checked && id == 'product_all') {
				$("dt.bread").css("display", "block");
				$("dd.bread").css("display", "block");
					
			} else {
				$("dt.bread").css("display", "none");
				$("dd.bread").css("display", "none");
			} 
	         
			if (checked ) {
				$("dt."+id).css("display", "block");
				$("dd."+id).css("display", "block");
			} else {
				$("dt.bread").css("display", "none");
				$("dd.bread").css("display", "none");
			}  
			this.checked = true;
	    } else {
	        this.checked = false;
	    }
	});  
	
	</script>
	
</body>
</html>