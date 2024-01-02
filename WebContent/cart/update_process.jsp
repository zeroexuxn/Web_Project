<%@page import="cart.*"%>
<%@page import="utils.JSFunction"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	int no = Integer.parseInt(request.getParameter("no"));	// cart 번호
	int option_no = 0;	// 옵션 번호 (*0번 옵션은 존재하지 않음)
	try {	// 옵션이 있는 메뉴인 경우 옵션 번호 저장
		option_no = Integer.parseInt(request.getParameter("select_option"));
		
	} catch(NumberFormatException e) {}	// 옵션이 없는 메뉴인 경우
	
	int quantity = Integer.parseInt(request.getParameter("quantity"));	// 수량
	
	// CartDTO 필드값 세팅
	CartDTO cartDto = new CartDTO();
	cartDto.setNo(no);
	cartDto.setOption_no(option_no);
	cartDto.setQuantity(quantity);
	
	//DAO 생성 후 Oracle DB 연결
	CartDAO cartDao = new CartDAO(application);
	
	int result = cartDao.UpdateProduct(cartDto);	// UPDATE문 수행 결과

	// DB 연결 해제
	cartDao.close();
	
	//out.println("<script>alert('" + result +"');</script>");
	if(result == 1) {	// cart 테이블에 정상적으로 데이터가 추가된 경우
		%>
		<script type="text/javascript">

		opener.document.location.reload();

		self.close();

		</script>
		<%
	} else {	// cart 테이블에 데이터를 추가하지 못한 경우
		JSFunction.alertBack("주문 수정을 실패했습니다.", out);
	}
%>