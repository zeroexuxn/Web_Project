<%@ page import="menu.*" %>
<%@ page import="menu_image.*" %>
<%@ page import="category.*" %>
<%@ page import="review.*" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
 <%
 	String member_id = "";
	if(session.getAttribute("id") == null)
		response.sendRedirect("../login/login.jsp");
	else
		member_id = session.getAttribute("id").toString();
 	
	// DAO를 생성한 후 Oracle DB에 연결하기
  	reviewsWriteableDAO reviewDao = new reviewsWriteableDAO(application);	
   	MenuImageDAO menuimageDao = new MenuImageDAO(application);	
   	MenuDAO menuDao = new MenuDAO(application);					
   	
   	// 작성 가능한 리뷰 확인
   	List<reviewsWriteableDTO> reviewNotWrite = reviewDao.reviewNotWrite(member_id);
   	List<MenuImageDTO> menuImgList = menuimageDao.selectList();
   	List<MenuDTO> menuId = menuDao.menuCategoryIdImport(null);
   	
   	// Oracle DB 연결 해제하기
   	reviewDao.close(); 
   	menuimageDao.close();
   	
   	System.out.println("호출");
%>    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 관리 | RYANBUCKS Korea</title>
<link href="/RYANBUCKS_v1.0/common/css/reset.css" rel="stylesheet"> <!-- 헤더, 푸터 -->
<link href="/RYANBUCKS_v1.0/common/css/style_main.css" rel="stylesheet"> <!-- 헤더, 푸터 -->
<link href="/RYANBUCKS_v1.0/common/css/style_writeable_review.css" rel="stylesheet">
<link href="/RYANBUCKS_v1.0/common/img/logo.png" rel="short icon" type="image/ico">
<script src="https://code.jquery.com/jquery-latest.min.js"></script>	<!-- JQuery를 사용하기 위한 라이브러리 -->
</head>
<body>
<jsp:include page="/header.jsp" />
<div id="container">	
	<header class="ms_sub_tit_wrap">
		<div id="sub_tit_bg">
				<!-- 서브 타이틀 -->
				<!-- <div class="sub_tit_wrap"> -->
					<div class="sub_tit_inner">
						<h2>
							<img src="/RYANBUCKS_v1.0/non_co_img/sub_title/review_tit.png" alt="작성 가능한 리뷰">
						</h2>
						<ul class="smap">
							<li>
								<a href="/RYANBUCKS_v1.0/index.jsp">
									<img src="/RYANBUCKS_v1.0/common/img/icon_home_2.png" alt="홈으로">
								</a>
							</li>
							<li>
								<img class="arrow" src="/RYANBUCKS_v1.0/common/img/icon_arrow_2.png" alt="하위메뉴">
							</li>
							<li class="en">
								<a href="/RYANBUCKS_v1.0/my_ryanbucks/index.jsp">My Ryanbucks</a>
							</li>
							<li>
								<img class="arrow" src="/RYANBUCKS_v1.0/common/img/icon_arrow_2.png" alt="하위메뉴">
							</li>
							<li>
								<a href="javascript:void(0)" class="this">리뷰 관리</a>
							</li>
						</ul>
					</div>	
				<!-- </div> -->
		<!-- //서브 타이틀 -->
		</div>
	</header>
	<div class="ms_content_wrap">
		<jsp:include page="/my_ryanbucks/navigation.jsp" />
		<div style="width:850px; height:700px">
			<%
				if(reviewNotWrite.size() == 0) {
				%>
				<h2 class="no_writeable_review">
				<% 
					out.println("작성 가능한 리뷰가 없습니다.");
				%>
				</h2>
				<%
				} else {
				
			%>
			<ul class="writeable_reviews_list">
				<li class="writeable_reviews">
				<%
					for(reviewsWriteableDTO reviewDto : reviewNotWrite) { 
					for (MenuImageDTO menuImgDto : menuImgList) {
						//out.println(menuImgDto.getMenu_no() + " : " + reviewDto.getMenu_no() + "<br>");
				         if (menuImgDto.getMenu_no() == reviewDto.getMenu_no()) {
				        	 System.out.println("menuImgDto.getMenu_no() =======> " + menuImgDto.getMenu_no());
				        	 System.out.println("reviewDto.getMenu_no() =======> " + reviewDto.getMenu_no());
				%>
					<div class="product_content">
						<div class="product_img">
							<a href="../menu/drink_view.jsp?menu_no=<%= menuImgDto.getMenu_no() %>">
								<img class="pro_img" src="/RYANBUCKS_v1.0/non_co_img/menu/<%=menuImgDto.getFile_name() %>" alt="<%= reviewDto.getName_kor() %>">
							</a>
						</div>
						
						<div class="purchase_product">
							<a href="../menu/drink_view.jsp?menu_no=<%= menuImgDto.getMenu_no() %>" class="purchase_name"><%= reviewDto.getName_kor() %></a>
							<p class="purchase_option">
							<% if (reviewDto.getOption1_value() == null) { %>
								옵션 없음
							<% } else { %>
								<%= reviewDto.getOption1_value() %>
							<% if (reviewDto.getOption2_value() != null) { %>
								| <%= reviewDto.getOption2_value() %>
							<% } } %>
								</p>
						</div>
						<div class="create_a_review">
							<a onclick="popupOpen(<%= reviewDto.getNo()%>)" id="review <%= reviewDto.getNo()%>" class="review" role="button" title="리뷰 작성">리뷰 작성</a>
						</div>
					</div>
					<% break; } } } } %>
				</li>	
			</ul>
		</div>
	</div>
</div>
<!-- //container -->
<jsp:include page="/footer.jsp" />

<script>
// 작은 썸네일 클릭 시 클릭된 이미지를 큰 썸네일에 표시
 	$(document).ready(function () {
		$(".review").on("click", function() {			// 클래스명이 "review"인 요소에 클릭 이벤트가 발생하면
			$(".review").removeClass("selected");				// 클래스명이 "review"인 요소의 클래스에서 "selected"를 제거하고
			$(this).addClass("selected");					// 클릭 이벤트가 발생한 요소의 클래스에 "selected" 추가
		});
	});
</script> 


<script>
var winRef;

function popupOpen(no){
	var url ="writeable_reviews.jsp?no=" + no;
	
        winRef = window.open(url, 'popupName', 'width=450, height=550, resizable=no, scrollbars=yes, status=no;' );
}	 
</script> 
	
</body>
</html>