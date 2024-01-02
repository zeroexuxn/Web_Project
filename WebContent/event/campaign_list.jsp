<%@page import="event.EventDTO"%>
<%@page import="event.EventDAO" %>
<%@page import="event_img.EvtImgDAO" %>
<%@page import="event_img.EvtImgDTO" %>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	/* 
	!구현 담당자 필독!
	
	시간 상의 이유로 EventDTO와 EvtImgDTO의 no(게시글 번호) 확인 프로세스는 없음
	
	=> SELECT 쿼리 수행할 때 ORDER BY절이 없으면 기본적으로 INSERT된 순서로 반환되기 때문에
	이벤트 게시글 INSERT 순서대로 이벤트 이미지를 INSERT 해준 경우에는 문제가 없지만 아닌 경우에는 이벤트 게시글과 썸네일이 일치하지 않는 문제 발생
	
	evtImgDto.getEventPostNo() 메소드랑 반복문 이용해서 찾거나 (*menu_list.jsp 방식)
	EventDTO 타입의 리스트 객체를 파라미터로 받는 메소드에서 list에서 나타나는 순서대로 list에 append 하거나 (*MenuImageDAO의 getMenuImageDTOList() 메소드 방식)
	*/

	//DB 연결
	EventDAO eventDao = new EventDAO(application);
	EvtImgDAO evtImgDao = new EvtImgDAO(application);
	
	//이벤트 목록 확인
	List<EventDTO> bbs = eventDao.selectlist();
	List<EvtImgDTO> bbs_image = evtImgDao.selectList();
	System.out.println(bbs.size());
	
	// DB 연결 해제: 박수연(2023/11/01)
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
<link href="/RYANBUCKS_v1.0/common/css/campaign_list_style.css" rel="stylesheet">
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
					<!-- 경로 지정 및 이미지 필요 --><a href="javascript:void(0);" class="this">이벤트</a>
				</li>
			</ul>		
		</div>
	</div>
	<!-- container 영역이 sub_tit_wrap 안에 있어서 밖으로 뻄: 박수연(2023/11/01) -->
	<div id="container">
		<div class="wn_cont">
			<section class="campaign_wrap">
				<div class="box_bg"></div>
				<!-- 진행중인 이벤트 목록 -->
				<h3 class="campaign_progress">
					<a class="on" href="javascript:void(0);">진행중인 이벤트</a>
				</h3>
				<article style="display:block;">
					<div class="campaign_list">
						<dl>
							<dd>
								<ul>
									<!-- 동적으로 이벤트 게시글 제목, 시작일, 종료일 가져오기: 박수연(2023/11/01) -->
									<%
									
									EvtImgDAO evtImgDao2=new EvtImgDAO(application);
									for(EventDTO eventDto : bbs) {
									%>
									<li>
										<dl>
											<dt>
												<a href="campaign_view.jsp?event_no=<%=eventDto.getNo() %>" class="goPromotionView">
												<% System.out.println(eventDto.getNo()); %>
												<!-- <a href="javascript:void(0);" class="goPromotionView"> <!--  prod="" 속성 삭제: 박수연(2023/11/01) -->
													<img src="/RYANBUCKS_v1.0/non_co_img/event/<%=evtImgDao2.selectEventImage(eventDto.getNo(), "thumnail").getFileName() %>" alt="진행중인 이벤트">
													<% System.out.println(evtImgDao2.selectEventImage(eventDto.getNo(), "thumnail").getFileName()); %>
													
												</a>
											</dt>
											<dd>
												<h4><%=eventDto.getTitle() %></h4>
												<p class="date"><%=eventDto.getStartDate() %> ~ <%=eventDto.getEndDate() %></p>
											</dd>
										</dl>
									</li>
								<%
								}
									
									evtImgDao2.close();
								%>
								</ul>
							</dd>
						</dl>
					</div>
				</article>
				<!-- 진행중인 이벤트 목록 end -->
				<h3 class="campaign_end">
					<a href="campaign_ended_list.jsp">종료된 이벤트</a>
				</h3>
			</section>
		</div>
	</div>

	<jsp:include page="/footer.jsp" />
</body>
</html>