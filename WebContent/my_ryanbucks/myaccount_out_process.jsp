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
		
		// session에 있는 id 정보를 받는다
		String id = (String) session.getAttribute("id");
	    
	    try {

	    	// member의 회원탈퇴 날짜 업데이트
	    	String outAddressSql = "UPDATE member SET out_date = sysdate WHERE id = ?";
	    	PreparedStatement member_psmt = jdbc.con.prepareStatement(outAddressSql);

	    	member_psmt.setString(1, id);
			
	    	int rowsAffected = member_psmt.executeUpdate();
			
	    	System.out.println(id);
	    	System.out.println(rowsAffected);
	    	
	    	if (rowsAffected > 0) {
	    	    JSFunction.alertLocation("회원탈퇴가 완료되었습니다.", "../login/logout_process.jsp", out);
	    	} else {
	    		JSFunction.alertBack("오류가 발생하여 회원탈퇴가 실패하였습니다. 다시 시도해주세요.", out);
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