<%@page import="notice.NoticeDTO"%>
<%@page import="notice.NoticeDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%
	// 글 목록에서 클릭한 글 번호 받아오기
	int no=Integer.parseInt(request.getParameter("no"));

	// 글 번호로 읽어올 DAO 생성
	NoticeDAO noticeDao=new NoticeDAO(application);
	
	// 게시글 내용 가져와 DTO에 저장
	NoticeDTO noticeDto=noticeDao.selectDetailList(no);
	
	// 윗글 게시글 내용 저장 
	NoticeDTO topNotice=noticeDao.selectDetailList(no+1);
	
	// 아랫글 게시글 내용 저장
	NoticeDTO botNotice=noticeDao.selectDetailList(no-1);
	
	// 게시글 조회수 1씩 증가
	int result=noticeDao.updateVisitCount(no);
		
	// 테스트용
	if(result!=1){// 조회수 증가 실패했을 경우
		//System.out.println("notice_view.jsp 확인 요망");
	}
	
	// DB 연결 해제
	noticeDao.close();
	
	%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 | Ryanbucks Korea</title>
<link href="/RYANBUCKS_v1.0/common/css/reset.css" rel="stylesheet"> <!-- 헤더, 푸터 -->
<link href="/RYANBUCKS_v1.0/common/css/style_main.css" rel="stylesheet"> <!-- 헤더, 푸터 -->
<link href="/RYANBUCKS_v1.0/common/css/notice_style.css" rel="stylesheet">
<link href="/RYANBUCKS_v1.0/common/css/notice_view_style.css" rel="stylesheet">
<link href="/RYANBUCKS_v1.0/common/img/logo.png" rel="short icon" type="image/ico">
</head>
<body>
<jsp:include page="/header.jsp" />
	<div class="sub_tit_wrap">
		<div class="sub_tit_inner">
			<h2>
				<img src="/RYANBUCKS_v1.0/non_co_img/sub_title/notice_tit.jpg" alt="공지사항">
			</h2>
			<ul class="smap">
				<li><a href="/RYANBUCKS_v1.0/index.jsp"><img src="/RYANBUCKS_v1.0/common/img/icon_home.png" alt="홈으로"></a>
				</li>
				<li>
					<img class="arrow" src="/RYANBUCKS_v1.0/common/img/icon_arrow.png" alt="하위메뉴">
				</li>
				<li>
					<!-- 경로 지정 및 이미지 필요 --><a href="/RYANBUCKS_v1.0/notice/notice_list.jsp" class="this">공지사항</a>
				</li>
			</ul>
		</div>
	</div>
	<div id="container">
		<div class="wn_cont">
			<section class="notice_view_wrap">
				<header>
					<h3>
						<%= noticeDto.getTitle() %>
						<span class="date"></span>
					</h3>
				</header>
				<article class="notice_view_info">
					<div class="notice_view_info_inner">
						<div>
							<span><%= noticeDto.getContent().replaceAll("\n", "<br>") %></span>
						</div>
						<div>
							<span></span>
						</div>
						<div>
							<span></span>
						</div>
					</div>
				</article>
				<div class="btn_notice_wrap">
					<p class="btn_notice_list">
						<a href="notice_list.jsp">목록</a>
					</p>
				</div>
			</section>
			<table summary="새소식 윗글, 아랫글" class="pn_content_tb">
				<caption class="hid">새소식 윗글, 아랫글</caption>
				<colgroup>
					<col width="18.181818%">
					<col width="89.818182%">
				</colgroup>
				<tbody id="next">
					<tr>
						<th class="fth" scope="row" id="next_title">윗글</th>
						<%
						if(topNotice.getTitle()==null){//윗글이 없으면
						%>
						<td class="ftd">
							해당 글이 없습니다.
						</td>
						<%
						}else{
						%>
						<td class="ftd">
							<a href="/RYANBUCKS_v1.0/notice/notice_view.jsp?no=<%= topNotice.getNo() %>"><%= topNotice.getTitle() %></a>
						</td>
						<%} %>
					</tr>
					<tr>
						<th class="lth" scope="row" id="prev_title">아랫글</th>
						<%
						if(botNotice.getTitle()==null){//아랫글이 없으면
						%>
						<td class="ltd">
							해당 글이 없습니다.
						</td>
						<%
						}else{
						%>
						<td class="ltd">
							<a href="/RYANBUCKS_v1.0/notice/notice_view.jsp?no=<%= botNotice.getNo() %>"><%= botNotice.getTitle() %></a>
						</td>
						<%
						}
						%>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
<jsp:include page="/footer.jsp" />
</body>
</html>