<%@page import="event.*"%>
<%@page import="event_img.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	// 이벤트 상세보기 페이지에 동적으로 데이터 가져오기: 박수연(2023/11/01)
	int eventNo = Integer.parseInt(request.getParameter("event_no")); // event_list.jsp에서 전달된 이벤트 게시글 번호
	
	// DB 연결
	EventDAO eventDao = new EventDAO(application);
	EvtImgDAO evtImgDao = new EvtImgDAO(application);
	
	// 데이터 가져오기
	EventDTO eventDto = eventDao.getEventDTO(eventNo);
	EvtImgDTO evtImgDto = evtImgDao.selectEventImage(eventNo, "content");

	// DB 연결 해제
	eventDao.close();
	evtImgDao.close();

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이벤트 | Ryanbucks Korea</title>
	<link href="/RYANBUCKS_v1.0/common/css/reset.css" rel="stylesheet"> <!-- 헤더, 푸터 -->
	<link href="/RYANBUCKS_v1.0/common/css/style_main.css" rel="stylesheet"> <!-- 헤더, 푸터 -->
	<link href="/RYANBUCKS_v1.0/common/css/style.css" rel="stylesheet">
	<link href="/RYANBUCKS_v1.0/common/css/campaign_view_style.css" rel="stylesheet">
	<link href="/RYANBUCKS_v1.0/common/css/notice_view.css" rel="stylesheet">
	<link href="/RYANBUCKS_v1.0/common/css/jquery.bxslider.css" rel="stylesheet">
	<link href="/RYANBUCKS_v1.0/common/img/logo.png" rel="short icon" type="image/ico">
</head>
<body>
<jsp:include page="/header.jsp" />

	<div class="sub_tit_wrap">
		<div class="sub_tit_inner">
			<h2>
				<img src="/RYANBUCKS_v1.0/non_co_img/sub_title/campaign_tit.jpg" alt="이벤트">
			</h2>
			<ul class="smap">
				<li><a href="/RYANBUCKS_v1.0/index.jsp"><img src="/RYANBUCKS_v1.0/common/img/icon_home.png" alt="홈으로"></a>
				<li>
					<img class="arrow" src="/RYANBUCKS_v1.0/common/img/icon_arrow.png" alt="하위메뉴">
				</li>
				<li>
					<!-- 경로 지정 및 이미지 필요 --><a href="/RYANBUCKS_v1.0/event/campaign_list.jsp" class="this">이벤트</a>
				</li>
			</ul>		
		</div>
	</div>
	<!-- container 영역이 sub_tit_wrap 안에 있어서 밖으로 뻄: 박수연(2023/11/01) -->
	<div class="wn_cont">
		<section class="campaign_view_wrap">
			<header>
				<h3>
					<!-- 동적으로 이벤트 게시글 제목, 시작일, 종료일 가져오기: 박수연(2023/11/01) -->
					<%=eventDto.getTitle() %>
					<span class="date"><%=eventDto.getStartDate() %> ~ <%=eventDto.getEndDate() %></span>
				</h3>
			</header>
			<article class="campaign_view_info">
				<div class="campaign_view_info_inner">
					<img alt="이벤트 이미지" src="/RYANBUCKS_v1.0/non_co_img/event/<%=evtImgDto.getFileName()%>">
				</div>
				<div class="ev_seq_wrap"></div>
			</article>
			<div class="btn_campaign_wrap">
				<p class="btn_campaign_list">
					<a href="campaign_list.jsp">목록</a> <!-- 이벤트 목록 페이지 경로 추가: 박수연(2023/11/01) -->
				</p>
			</div>
		</section>
		<!--  <section class="img_campaign_wrap">
			<div class="campaign_list">
				<dl>
					<dt>진행 이벤트</dt>
					<dd>
						<section class="bnr_slider_wrap">
							<div class="bx-wrapper" style="max-width: 1100px;">
								<div class="bx-viewpoint" style="width: 100%; overflow: hidden; position: relative; height: 325px;">
								
								</div>
							</div>
						</section>
					</dd>
				</dl>
			</div>
		</section>-->
	</div>

<jsp:include page="/footer.jsp" />
</body>
</html>