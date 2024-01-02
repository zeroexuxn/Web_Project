<%@page import="cart.*"%>
<%@page import="utils.JSFunction"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String member_id = session.getAttribute("id").toString();			// 회원 ID
	int menu_no = Integer.parseInt(request.getParameter("menu_no"));	// 메뉴 번호
	
	int option_no = 0;	// 옵션 번호 (*0번 옵션은 존재하지 않음)
	try {	// 옵션이 있는 메뉴인 경우 옵션 번호 저장
		option_no = Integer.parseInt(request.getParameter("option_no"));
		
	} catch(NumberFormatException e) {}	// 옵션이 없는 메뉴인 경우
	
	int quantity = Integer.parseInt(request.getParameter("quantity"));	// 수량
	
	// 정보 확인용 출력문
	//out.println("회원 id: " + member_id + "<br>");
	//out.println("메뉴 번호: " + menu_no  + "<br>");
	//out.println("옵션 번호: " + option_no + "<br>");
	//out.println("수량: " + quantity);
	
	// CartDTO 필드값 세팅
	CartDTO cartDto = new CartDTO();
	cartDto.setMember_id(member_id);
	cartDto.setMenu_no(menu_no);
	cartDto.setOption_no(option_no);
	cartDto.setQuantity(quantity);
	
	//DAO 생성 후 Oracle DB 연결
	CartDAO cartDao = new CartDAO(application);
	
	int result = cartDao.insertCartDto(cartDto);	// INSERT문 수행 결과

	// DB 연결 해제
	cartDao.close();
	
	//out.println("<script>alert('" + result +"');</script>");
	if(result == 1) {	// cart 테이블에 정상적으로 데이터가 추가된 경우
		JSFunction.confirmBack("장바구니에 메뉴를 담았습니다. 장바구니로 이동하시겠습니까?", "cart.jsp", out);
	} else {	// cart 테이블에 데이터를 추가하지 못한 경우
		JSFunction.alertBack("메뉴 담기에 실패했습니다.", out);
	}
%>