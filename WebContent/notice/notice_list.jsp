<%@page import="notice.NoticeDTO"%>
<%@page import="notice.NoticeDAO" %>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//로그인 화면에서 전달받은 회원id
	//String id=request.getParameter("id");
	//String id="user01";
	
	//DAO를 생성한 후 Oracle DB에 연결
	NoticeDAO noticeDao=new NoticeDAO(application);
	
	//검색 조건 MAP에 저장
	Map<String, Object> param = new HashMap<String, Object>();
	String search_word = request.getParameter("search_word");

	//검색 조건이 있는지 판별
	if (search_word != null) { // 검색어 입력했으면
    	param.put("search_word", search_word);
	}
	
	//게시글 수 확인
	int totalCount=noticeDao.selectCount(param);
	
	//게시글 목록 확인
	List<NoticeDTO> bbs=noticeDao.selectlist(param);
	
	//Oracle DB 연결 해제
	noticeDao.close();
	%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 | Ryanbucks Korea</title>
	<link href="/RYANBUCKS_v1.0/common/css/reset.css" rel="stylesheet"> <!-- 헤더, 푸터 -->
	<link href="/RYANBUCKS_v1.0/common/css/style_main.css" rel="stylesheet"> <!-- 헤더, 푸터 -->
	<link href="/RYANBUCKS_v1.0/common/css/style.css" rel="stylesheet">
	<link href="/RYANBUCKS_v1.0/common/css/notice_style.css" rel="stylesheet">
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
<!-- subtitle end -->
<!-- container -->
<div id="container">
	<!-- 게시판 내용 -->
	<div class="notice_wrap">
		<!-- 검색 영역 -->
		<form method="get">
		<div class="news_sch_wrap">
			<p>
				<label for="sch_bar" class="ally">검색어</label>
				<input type="text" name="search_word" id="sch_bar" placeholder="검색어를 입력해주세요.">
				<button type="submit" class="newBoardSearchBtn">검색</button>
			</p>
		</div>
		</form>
		<!-- 검색 영역 end -->
		<!-- 공지사항 게시판 -->
		<table summary="공지사항" class="notice_tb">
			<caption class="hid">공지사항 번호, 제목, 날짜, 조회수 테이블</caption>
			<colgroup>
				<col width="5.45454%">
				<col width="74.5454%">
				<col width="10.90909%">
				<col width="*">
			</colgroup>
			<!-- header -->
			<thead>
				<tr>
					<th scope="col">NO</th>
					<th scope="col">제목</th>
					<th scope="col">날짜</th>
					<th scope="col">조회수</th>
				</tr>
			</thead>
			<!-- header end -->
			<tbody id="notice">
				<!-- 게시글 없는 경우 -->
				<%
				
				if(totalCount==0){
				%>
				<tr>
					<td colspan="5" align="center">등록된 게시글이 없습니다.</td>
				</tr>
				<%
				} else {
					
					for(NoticeDTO noticeDto : bbs){
				%>
				<!-- 게시글 있는 경우 -->
				<tr>
					<td><%= noticeDto.getNo() %></td>
					<td class="left">
						<a href="/RYANBUCKS_v1.0/notice/notice_view.jsp?no=<%= noticeDto.getNo() %>"><%= noticeDto.getTitle() %></a>
					</td>
					<td><%= noticeDto.getPostDate() %></td>
					<td><%= noticeDto.getVisitCount() %></td>
				</tr>
					<%   }// end for
				} // end else%>
				
			</tbody>
		</table>
		<!-- /공지사항 게시판 -->
		<!-- 관리자 아이디로 로그인 시 글쓰기 버튼 출력 -->
		<%
		if(session.getAttribute("id") != null && session.getAttribute("id").equals("admin")){
		%>
		<table class="writeBtn">
			<tr align="right">
				<td>
					<button type="button" onclick="location.href='notice_write.jsp'">작성</button>
				</td>
			</tr>
		</table>
		<%
		}
		%>	
		<!-- /글쓰기 버튼 -->
		<ul class="m_notice_list" id="m_notice_list"></ul>
		<!-- 페이지 수 선택 -->
		<!--  
		<div class="news_pagination">
			<ul class="pager">
				<li class="active">
					<a href="javascript:void(0)">1</a>
				</li>
				<li>
					<a href="javascript:void(0)">2</a>
				</li>
				<li>
					<a href="javascript:void(0)">3</a>
				</li>
				<li>
					<a href="javascript:void(0)">4</a>
				</li>
				<li>
					<a href="javascript:void(0)">5</a>
				</li>
				<li>
					<a href="javascript:void(0)">6</a>
				</li>
				<li>
					<a href="javascript:void(0)">7</a>
				</li>
				<li>
					<a href="javascript:void(0)">8</a>
				</li>
				<li>
					<a href="javascript:void(0)">9</a>
				</li>
				<li>
					<a href="javascript:void(0)">10</a>
				</li>
				<li class="control">
					<a href="javascript:void(0)">
						<img alt="앞으로" src="">
					</a>
				</li>
			</ul>
		</div>-->
		<!-- 페이지 수 선택 end -->
	</div>
	<!-- 게시판 내용 end -->
</div>
<!-- container end -->
<jsp:include page="/footer.jsp" />

</body>
</html>