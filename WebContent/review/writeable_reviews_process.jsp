<%@ page import="review_board.*" %>
<%@ page import="order_detail.OrderDetailDAO" %>
<%@ page import="utils.JSFunction" %>
<%@ page import="review.*" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <% 
	 System.out.println("writeable review process 호출 =================");

 	// POST방식으로 보내는 값이 '한글'일 경우 깨지지 않게 전달하기 위해 사용
	request.setCharacterEncoding("utf-8");
 	 	
 	// 작성하는 폼으로부터 파라미터 (별점, 내용) 저장하기
 	int no = Integer.parseInt(request.getParameter("no")); 
 	
 	int rate = Integer.parseInt(request.getParameter("reviewStar"));
	String content = request.getParameter("content");
 	System.out.println("no: " + no);
 
 	// DB에 저장하기 위한 DTO 객체 생성하기
 	ReviewBoardDTO ReviewBoardDto = new ReviewBoardDTO();	
 	
 	// 내용을 DTO 객체에 저장하기
 	// writeReviewDto.setMember_id(session.getAttribute("member_id").toString());
 	ReviewBoardDto.setRate(rate);
 	ReviewBoardDto.setContent(content);
 	
 	// 임의 값 
 	ReviewBoardDto.setMember_id("user01");
 	
 	// DAO 객체를 사용하여 DB에 저장하기
 	ReviewBoardDAO ReviewBoardDao = new ReviewBoardDAO(application);
 	int result = ReviewBoardDao.insertContent(ReviewBoardDto);
 	System.out.println(result);
 	
 	OrderDetailDAO orderdetailDao = new OrderDetailDAO(application);
 	int orderupdate = orderdetailDao.reviewNumberUpdate(result, no);
 	System.out.println("result ===>" + result + "no ===> " + no );
 	
 	String msg = "";
 	if(orderupdate == 1) {
 		msg = "리뷰 등록 완료!";
 	} else {
 		msg = "리뷰 등록 실패";
 	}

 	// DB 연결 해제하기
	ReviewBoardDao.close();
	orderdetailDao.close();

 %>    

<div class="complete">
	<button onclick="finish()" class="finish"><%= msg %></button>
	<img src="/RYANBUCKS_v1.0/common/img/ryan.gif" alt="라이언">
</div>

<script>
	function finish() {
		opener.parent.location.reload();
		window.close();
	}
</script>

<link href="/RYANBUCKS_v1.0/common/css/reset.css" rel="stylesheet">
<link href="/RYANBUCKS_v1.0/common/css/style_popup.css" rel="stylesheet">