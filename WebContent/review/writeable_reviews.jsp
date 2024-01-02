<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
    int no = Integer.parseInt(request.getParameter("no"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰쓰기 | RYANBUCKS Korea</title>
<link href="/RYANBUCKS_v1.0/common/css/style_popup.css" rel="stylesheet">
<link href="/RYANBUCKS_v1.0/common/css/reset.css" rel="stylesheet">
<link href="/RYANBUCKS_v1.0/common/img/logo.png" rel="short icon" type="image/ico">
<script src="https://code.jquery.com/jquery-latest.min.js"></script>	<!-- JQuery를 사용하기 위한 라이브러리 -->
</head>
<body>
	<!-- review_content -->
	<div id="review_content">
		<header class="header_included_part">
			<h1 class="header">
				<span class="header_tit">리뷰쓰기</span>
			</h1>
			<a href="javascript:window.close()" role="button" class="x_button">
				<span class="blind">닫기</span>
			</a>
		</header>
		
		<div class="container">
			<h3 class="blind">상품 리뷰 작성</h3>
			<!-- sub_detail, 상품 리뷰 작성 -->
			<form class="reviewform" name="reviewform" id="reviewform" method="post" action="writeable_reviews_process.jsp">
				<div class="star_select_part">
					<strong class="pro_question">
						상품은 만족하셨나요?
					</strong>
			
					<input type="hidden" name="no" value=<%= no %>>
			
					<div class="star_sub">
						<div class="star">
							<fieldset>
								<input type="radio" name="reviewStar" value="5" id="rate1" ><label for="rate1">⭐</label>
								<input type="radio" name="reviewStar" value="4" id="rate2"><label for="rate2">⭐</label>
								<input type="radio" name="reviewStar" value="3" id="rate3"><label for="rate3">⭐</label>
								<input type="radio" name="reviewStar" value="2" id="rate4"><label for="rate4">⭐</label>
								<input type="radio" name="reviewStar" value="1" id="rate5"><label for="rate5">⭐</label>
							</fieldset>
						</div>
						<div class="star_content">선택하세요.</div>
					</div>
				</div>
				<div class="review_part">
					<strong class="pro_question">
						리뷰를 남겨주세요.
					</strong>
					<div class="review_text_part">
						<div class="review_text">
							<label for="review_input" class="review_input" ></label>
							<textarea class="content" name="content" id="content" cols="30" style="height: 92px" placeholder="솔직한 리뷰를 남겨주세요."></textarea>
						</div>
						<div class="number_of_characters">
							<span style="color:#aaa;" id="counter">(0 / 1,000)</span>
						</div>
					</div>	
				</div>
				<div class="cr_part">
					<div class="button">
						<a href="javascript:window.close()" role="button">
							<span class="cancel">취소</span>
						</a>
					</div>
					<div class="button">
						<input type="submit" class="register" id="register" value="등록" disabled/>
					</div>
				</div>
			</form>
		</div>
	</div>
<!-- //review_content -->

<script>
$('.content').keyup(function (e) {
	let content = $(this).val();
    
    // 글자수 세기
    if (content.length == 0 || content == '') {
    	$('#counter').html("0" / 1000);    //글자수 실시간 카운팅
    } else {
    	$('#counter').html("("+content.length+" / 1000)");
    }
    
    // 글자수 제한
    if (content.length > 1000) {
    	// 1000자 부터는 타이핑 되지 않도록
        $(this).val($(this).val().substring(0, 1000));
        $('#counter').html("("+(content.length-1)+" / 1000)");
        // 1000자 넘으면 알림창 뜨도록
        alert('글자수는 1000자까지 입력 가능합니다.');
    };
});
</script>

<script>
// 별점과 글 작성을 한 경우에만 등록 버튼을 활성화 처리

// 별점 요소, 글 작성 요소, 버튼 요소를 가져온다.
const starRadios = document.querySelectorAll('input[type="radio"][name="reviewStar"]');
const content = document.getElementById("content");
const register = document.getElementById("register");

// 별점이 선택되었는지를 체크하는 함수
function isChecked(radios) {
    for (const radio of radios) {
        if (radio.checked) {
            return true;
        }
    }
    return false;
}

// 입력 상태를 확인하고 버튼 활성화 여부를 업데이트하는 함수
function checkInput() {
	// 별점이 선택되고 글 내용이 비어 있지 않은 경우
    if (isChecked(starRadios) && content.value.trim() !== "") {
        register.removeAttribute("disabled");		// 등록 버튼 활성화
    } else {
        register.setAttribute("disabled", "true");	// 등록 버튼 비활성화
    }
}

// 별점 요소의 변경 이벤트를 감지하고 checkInput 함수를 호출
starRadios.forEach(function(radio) {
    radio.addEventListener('change', checkInput);
});

// 글 작성 요소의 입력 이벤트를 감지하고 checkInput 함수를 호출
content.addEventListener("input", checkInput);
</script>

</body>
</html>