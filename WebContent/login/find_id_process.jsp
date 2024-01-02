<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="utils.JSFunction"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="common.JDBConnect"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
		//DB 연결
		JDBConnect jdbc = new JDBConnect(application);

		//한글 인코딩
		request.setCharacterEncoding("utf-8");

		// member 테이블의 정보를 받는다.
		String name = request.getParameter("name");
		String countryTel = request.getParameter("countryTel");
		String areaTel = request.getParameter("areaTel");
		String userTel = request.getParameter("userTel");
		String tel = countryTel+"-"+areaTel+"-"+userTel;
		
	    try {

	        // member 테이블에 데이터 검색
			String memberSql = "SELECT id FROM member WHERE name=? AND tel=?";
			PreparedStatement member_psmt = jdbc.con.prepareStatement(memberSql);
			
			member_psmt.setString(1, name);
			member_psmt.setString(2, tel);
			
			ResultSet resultSet = member_psmt.executeQuery();
			
			
			
			// 결과가 없으면 Alert 띄우기
		    if (!resultSet.next()) {
		    	JSFunction.alertBack("연락처를 정확하게 입력해주세요.", out);
		    } else {
		    	String id = resultSet.getString("id");
		    	JSFunction.alertLocation(name + "님의 아이디는 " + id + "입니다.", "./login.jsp", out);
		    }
			
	    } catch (SQLException e) {
	        // 에러가 발생하면 롤백합니다.
	        jdbc.con.rollback();
	        e.printStackTrace();
	    } finally {
	    	
	        // 연결을 해제합니다.
	        jdbc.close();
	    }

	%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>