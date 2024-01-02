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
	
	//session에 있는 id 정보를 받는다
	String id = (String) session.getAttribute("id");
	String password = request.getParameter("password");
	
	try {
	
	  // member의 비밀번호 업데이트
	  String modifyPwdSql = "UPDATE member SET password = ? WHERE id = ?";
	  PreparedStatement member_psmt = jdbc.con.prepareStatement(modifyPwdSql);
	
	  member_psmt.setString(1, password); // password를 첫 번째로 설정
	  member_psmt.setString(2, id); // id를 두 번째로 설정
	
	  int rowsAffected = member_psmt.executeUpdate();
	
	  System.out.println(id);
	  System.out.println(password);
	  System.out.println(rowsAffected);
	
	  if (rowsAffected > 0) {
	      JSFunction.alertLocation("비밀번호가 변경되었습니다. 다시 로그인 해주세요.", "../login/logout_process.jsp", out);
	  } else {
	      JSFunction.alertBack("오류가 발생하여 비밀번호 변경이 실패하였습니다. 다시 시도해주세요.", out);
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