<%@page import="java.io.Console"%>
<%@page import="java.sql.SQLException"%>
<%@page import="utils.JSFunction"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="common.JDBConnect"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
		
		//DB 연결
		JDBConnect jdbc = new JDBConnect(application);
		
		// 한글 인코딩
		request.setCharacterEncoding("utf-8");
		
		// member 테이블의 정보를 받는다.
		String name = request.getParameter("name");
		String id = request.getParameter("id");
    	String pwd = request.getParameter("password");
	    String birthString = request.getParameter("birth");
	    java.sql.Date birth = java.sql.Date.valueOf(birthString);
	    String gender = request.getParameter("gender");
		String usernameEmail = request.getParameter("usernameEmail");
		String domainEmail = request.getParameter("domainEmail");
		String email = usernameEmail+"@"+domainEmail;
		String countryTel = request.getParameter("countryTel");
		String areaTel = request.getParameter("areaTel");
		String userTel = request.getParameter("userTel");
		String tel = countryTel+"-"+areaTel+"-"+userTel;
	    java.sql.Date joinDate = new java.sql.Date(new java.util.Date().getTime());
	    String marketing_info_agree = request.getParameter("marketing_info_agree");
    	if (marketing_info_agree != null){
	    	marketing_info_agree = "Y";
	    }else{
	    	marketing_info_agree = "N";
	    }
	    
		// address 테이블의 정보를 받는다. 
		String category_address = "집";
		String post_code = request.getParameter("post_code");
		String road_address = request.getParameter("road_address");
	    String detail_address = request.getParameter("detail_address");
	    //String extra_address = request.getParameter("extra_address");
	    
    	// 회원가입 성공 여부 확인 (성공시 1)
		int memberResult = 0;
    	int addressResult = 0;
	    
	    try {
	    	
	        // Auto-commit을 false로 설정하여 수동으로 트랜잭션을 관리합니다.
	        jdbc.con.setAutoCommit(false);

	        // member 테이블에 데이터 삽입
			String memberSql = "INSERT INTO member (name, id, password, birth, gender, email, tel, marketing_info_agree, join_date) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
			PreparedStatement member_psmt = jdbc.con.prepareStatement(memberSql);
			
			member_psmt.setString(1, name);
			member_psmt.setString(2, id);
			member_psmt.setString(3, pwd);
			member_psmt.setDate(4, birth);
			member_psmt.setString(5, gender);
			member_psmt.setString(6, email);
			member_psmt.setString(7, tel);
			member_psmt.setString(8, marketing_info_agree);
			member_psmt.setDate(9, joinDate);
			
			memberResult = member_psmt.executeUpdate();

	        // address 테이블에 데이터 삽입
	        //String addressSql = "INSERT INTO address (id, category_address, post_code, road_address, detail_address, extra_address) VALUES (?, ?, ?, ?, ?, ?)";
	        String addressSql = "INSERT INTO address (id, name, post_code, road_address, detail_address) VALUES (?, ?, ?, ?, ?)";
			PreparedStatement address_psmt = jdbc.con.prepareStatement(addressSql);
			
			address_psmt.setString(1, id);
			address_psmt.setString(2, category_address);
			address_psmt.setString(3, post_code);
			address_psmt.setString(4, road_address);
			address_psmt.setString(5, detail_address);
			//address_psmt.setString(6, extra_address);

	        addressResult = address_psmt.executeUpdate();

	        // 모든 작업이 성공하면 커밋합니다.
	        jdbc.con.commit();
	        
	    } catch (SQLException e) {
	        // 에러가 발생하면 롤백합니다.
	        jdbc.con.rollback();
	        e.printStackTrace();
	    } finally {
	        // 트랜잭션 종료 후, 다시 auto-commit을 활성화합니다.
	        jdbc.con.setAutoCommit(true);

	        // 연결을 해제합니다.
	        jdbc.close();
	    }

	    // 페이지 이동
	    if (memberResult == 1 && addressResult == 1) {
	        JSFunction.alertLocation(name + "님의 가입을 환영합니다!", "./login.jsp", out);
	    } else {
	        JSFunction.alertBack("회원정보 입력에 실패하였습니다.", out);
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