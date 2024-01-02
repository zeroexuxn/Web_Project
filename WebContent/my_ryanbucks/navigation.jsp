<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<link href="/RYANBUCKS_v1.0/common/css/style_navbar.css" rel="stylesheet">
<link href="/RYANBUCKS_v1.0/common/css/reset.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-latest.min.js"></script>	<!-- JQuery를 사용하기 위한 라이브러리 -->

<!-- ryanbucks_page_nav -->
<nav class="ms_nav">
	<ul>
		<li class="review_page">
			<a href="javascript:void(0)" class="show">개인정보관리
				<span class="arrow_down">
					<img class="img" src="/RYANBUCKS_v1.0/common/img/arrow_down.png">
				</span>
			</a>
			<ul class="sub_tit" style="display:">
				<li>
					<a href="/RYANBUCKS_v1.0/my_ryanbucks/myaccount_info.jsp">개인정보 확인 및 수정</a>
				</li>
				<li>
					<a href="/RYANBUCKS_v1.0/my_ryanbucks/myaccount_out.jsp">탈퇴</a>
				</li>
				<li>
					<a href="/RYANBUCKS_v1.0/my_ryanbucks/myaccount_pwd.jsp">비밀번호 변경</a>
				</li>
			</ul>
		</li>
		<li class="review_page">
			<a href="/RYANBUCKS_v1.0/my_ryanbucks/order_list.jsp">주문 내역</a>
		</li>
		<li class="review_page">
			<a href="/RYANBUCKS_v1.0/review/review.jsp">작성 가능한 리뷰</a>
		</li>
	</ul>
</nav>
<!-- //ryanbucks_page_nav -->


<script>
 $(document).ready(function () {
	 console.log("msg");
		$(".show").click(function() {			// 클래스명이 "show"인 요소를 클릭하면
			$(".sub_tit").slideDown(1000);		// 하위 타이틀 보여주기
			$(".img").attr("src", "/RYANBUCKS_v1.0/common/img/arrow_up.png"); 
		
		$(".show").click(function() {		
			$(".sub_tit").slideUp(1000);			// 하위 타이틀 숨기기
			$(".img").attr("src", "/RYANBUCKS_v1.0/common/img/arrow_down.png"); 
			
			});
		});
	});
</script>
