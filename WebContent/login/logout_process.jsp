<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//방법1. 회원정보 속성 삭제
session.removeAttribute("id");
session.removeAttribute("name");

//속성 삭제 후 페이지 이동
response.sendRedirect("login.jsp");
%>