<%@page import="utils.JSFunction"%>
<%@page import="cart.CartDTO"%>
<%@page import="cart.CartDAO"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
System.out.println("=================여기부터 delete_menu==============");


String type = request.getParameter("type");

// 선택 삭제를 클릭했을 때 체크 상태인 상품이 한 개일 때
if(type.equals("single")) {
	int no = Integer.parseInt(request.getParameter("no"));	
	
	System.out.println("no ============> " + no);
	CartDAO cartDao = new CartDAO(application);

	int result = cartDao.deleteProduct(no);
	
	cartDao.close();

	if(result == 1) {
		response.sendRedirect("cart.jsp");
	} else {
		JSFunction.alertBack("메뉴 삭제하기에 실패하였습니다.", out);
	}
}

//선택 삭제를 클릭했을 때 체크 상태인 상품이 여러 개일 때
else {
	String[] menu_no2 = request.getParameterValues("order_menus");
	if(menu_no2 != null) {
		/* String[] menu_no2 = request.getParameterValues("order_menus"); */
		
		System.out.println(menu_no2.length);
		
		
		
		boolean check = true; // 성공: true, 실패: false => 하나라도 삭제 실패하면 false
		
		System.out.println((menu_no2 == null)? "null임": "null 아님");
				
		for(String str : menu_no2) {
			System.out.println("--> " + str);
			
			int no = Integer.parseInt(str);	
			
			System.out.println("no ============> " + no);
			CartDAO cartDao = new CartDAO(application);
	
			int result = cartDao.deleteProduct(no);
			
			cartDao.close();
	
			if(result != 1) {
				JSFunction.alertBack("메뉴 삭제하기에 실패하였습니다.", out);
			}
			
		}
		response.sendRedirect("cart.jsp");
	}
	
	JSFunction.alertBack("상품을 선택해주세요", out);
		
}
%>
