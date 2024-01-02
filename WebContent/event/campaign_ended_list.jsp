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


	//DB 연결
	EventDAO eventDao = new EventDAO(application);
	EvtImgDAO evtImgDao = new EvtImgDAO(application);
	
	//이벤트 목록 확인
	List<EventDTO> bbs = eventDao.selectEndedList();
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
					<a href="campaign_list.jsp">진행중인 이벤트</a>
				</h3>
				<article style="display:block;">
					<div class="campaign_list">
						<dl>
							<dd>
								<ul>
									<%
									if(bbs.size()==0){
									%>
									<li>
										<dl>
											<dt>해당 이벤트가 없습니다.</dt>
										</dl>
									</li>
									<% 	
									}
									%>

									<%
									
									EvtImgDAO evtImgDao2=new EvtImgDAO(application);
									for(int i=0; i<bbs.size(); i++) {
									%>
									<li>
										<dl>
											<dt>
												<a href="campaign_view.jsp?event_no=<%=bbs.get(i).getNo() %>" class="goPromotionView">
												<% System.out.println(bbs.get(i).getNo()); %>
												<!-- <a href="javascript:void(0);" class="goPromotionView"> <!--  prod="" 속성 삭제: 박수연(2023/11/01) -->
													<img src="/RYANBUCKS_v1.0/non_co_img/event/<%=evtImgDao2.selectEventImage(bbs.get(i).getNo(), "thumnail").getFileName() %>" alt="진행중인 이벤트 <%=i%>">
													<% System.out.println(evtImgDao2.selectEventImage(bbs.get(i).getNo(), "thumnail").getFileName()); %>
												</a>
											</dt>
											<dd>
												<h4><%=bbs.get(i).getTitle() %></h4>
												<p class="date"><%=bbs.get(i).getStartDate() %> ~ <%=bbs.get(i).getEndDate() %></p>
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
					<a class="on" href="javascript:void(0);">종료된 이벤트</a>
				</h3>
			</section>
		</div>
	</div>

	<jsp:include page="/footer.jsp" />


</body>
</html>