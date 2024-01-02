<%@page import="java.sql.Date"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="utils.JSFunction"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="common.JDBConnect"%>
<%@page import="member.MemberDTO"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");

    //DB 연결
    JDBConnect jdbc = new JDBConnect(application);

    // member 테이블의 정보를 받는다.
    String name= request.getParameter("name");
    String out_date = request.getParameter("out_date");
    String id = request.getParameter("id");
    String password = request.getParameter("password");

    try {

        // member 테이블에 데이터 검색
        String loginSql = "SELECT id,name,out_date FROM member WHERE id=? AND password=?";
        PreparedStatement login_psmt = jdbc.con.prepareStatement(loginSql);

        login_psmt.setString(1, id);
        login_psmt.setString(2, password);

        ResultSet resultSet = login_psmt.executeQuery();

        // 결과가 없으면 Alert 띄우기
        if (!resultSet.next()) {
            JSFunction.alertBack("아이디와 비밀번호를 정확하게 입력해주세요.", out);
        } else {
            // 로그인 성공
            String retrievedId = resultSet.getString("id");
            String retrievedName = resultSet.getString("name");
            String retrievedOutDate = resultSet.getString("out_date");
            if(retrievedOutDate != null){
                JSFunction.alertLocation("탈퇴한 회원은 로그인 할 수 없습니다.", "./login.jsp", out);
            } else {
                // 로그인 성공 후 작업 수행
                session.setAttribute("id", retrievedId);
        		session.setAttribute("name", retrievedName);
                response.sendRedirect("login.jsp");
                JSFunction.alertLocation(retrievedName + "님을 환영합니다.", "./login.jsp", out);
            }
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
