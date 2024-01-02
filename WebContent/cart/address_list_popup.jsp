<%@page import="address.*"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String member_id = request.getParameter("member_id");

	//DAO 생성 후 Oracle DB 연결
	AddressDAO addressDao = new AddressDAO(application);
	
	List<AddressDTO> addressDtoList = addressDao.getAddressList(member_id);		// 회원 주소 목록 가져오기
	
	// DB 연결 해제
	addressDao.close();
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>주소 목록 | RYANBUCKS Korea</title>
	
	<link href="/RYANBUCKS_v1.0/common/css/reset.css" rel="stylesheet">
	<link href="/RYANBUCKS_v1.0/common/img/logo.png" rel="short icon" type="image/ico">
	
	<style>
	h2.title {
		padding: 16px 0px 15px;
	    font-size: 18px;
	    line-height: 25px;
	    text-align: center;
	    border-bottom: 1px solid #e3e3e3;
	}
	
	ul.list_wrap {
		margin: 0 20px;
	}
	
	ul.list_wrap li {
		padding: 20px 0;
		line-height: 20px;
		font-size: 14px;
	}
	
	ul.list_wrap div {
		margin-bottom: 5px;
	}
	
	ul.list_wrap li strong {
		font-size: 16px;
	}
	
	ul.list_wrap a {
		vertical-align: text-bottom;
		padding: 3px 8px;
	    text-align: center;
	    border: 1px solid #006633;
	    border-radius: 4px;
	    box-sizing: border-box;
	    background: #fff;
    	color: #000000;
	}
	
	
	</style>
</head>
<body>
	<h2 class="title">주소 목록</h2>
	<ul class="list_wrap" >
		<%
		for(AddressDTO addressDto : addressDtoList) { %>
			<li>
				<div>
					<strong><%=addressDto.getName() %></strong>
					<a href="javascript:void(0);" role="button" onclick="select('<%=addressDto.getPost_code() %>', '<%=addressDto.getRoad_address() %>', '<%=addressDto.getDetail_address() %>')">
						<span>선택</span>
					</a>
				</div>
				[<%=addressDto.getPost_code() %>]<br>
				<%=addressDto.getRoad_address() %> <%=(addressDto.getDetail_address() == null)? "" : addressDto.getDetail_address() %>
			</li>
		<%
		}
		%>
	</ul>
	
	<script>
		function select(post_code, road_address, detail_address) {
			opener.document.getElementById("existed_post_code").value = post_code;
			opener.document.getElementById("existed_road_address").value = road_address;
			
			
			if(detail_address == "null") {
				opener.document.getElementById("existed_detail_address").value = "";
			} else {
				opener.document.getElementById("existed_detail_address").value = detail_address;
			}
			
			
			console.log(detail_address);

			window.close();
		}
	
	</script>
	
</body>
</html>