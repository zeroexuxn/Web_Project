<%@page import="java.sql.Timestamp"%>
<%@page import="java.time.format.DateTimeFormatter" %>
<%@page import="java.time.LocalDateTime"%>
<%@page import="utils.JSFunction"%>
<%@page import="java.util.Random"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Vector"%>
<%@page import="order_detail.*"%>
<%@page import="order_total.*"%>
<%@page import="menu.*"%>
<%@page import="menu_option.*"%>
<%@page import="cart.*"%>

<%@page import="common.JDBConnect" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf-8");

	// 주문 번호
	String order_id = DateTimeFormatter.ofPattern("yyyyMMddHHmmss").format(LocalDateTime.now()) + String.format("%04d", new Random().nextInt(10000));
	//out.println("주문번호: " + order_id + "<br>");

	// 회원 ID
	String member_id = session.getAttribute("id").toString();
	//out.println("회원 ID: " + member_id + "<br>");

	// 수령인 이름
	String recipient_name = request.getParameter("recipient_name");
	//out.println("수령인 이름: " + recipient_name + "<br>");
	
	// 수령인 연락처
	String recipient_tel = request.getParameter("tel_first") + "-" + request.getParameter("tel_middle") + "-" + request.getParameter("tel_last");
	//out.println("수령인 연락처: " + recipient_tel + "<br>");
	
	// 수령인 이메일
	String recipient_email = null;
	if(request.getParameter("email_id") != "") {
		recipient_email = request.getParameter("email_id") + "@" + request.getParameter("email_domain");
	}
	//out.println("수령인 이메일: " + recipient_email + "<br>");
	
	// 주문 유형
	String order_type = request.getParameter("order_type");
	//out.println("주문 유형: " + order_type + "<br>");
	
	String branch = null;
	Timestamp pickup_time = null;
	String post_code = null;
	String road_address = null;
	String detail_address = null;

	// 픽업 정보
	if(order_type.equals("pickup")) {
		// 픽업 지점
		branch = request.getParameter("branch");
		//out.println("픽업 지점: " + branch + "<br>");
		
		// 픽업 시간
		String pickup_time_str = request.getParameter("date") + " " + String.format("%02d", Integer.parseInt(request.getParameter("hour"))) + ":"
						+ String.format("%02d", Integer.parseInt(request.getParameter("minutes"))) + ":00.000";		// 문자열을 LocalDateTime으로 형변환하는 문제가 있어 ":00.000" 추가
		
		// 문자열을 LocalDateTime 형식으로 변환한 후 TimeStamp 형식으로 저장
	    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.SSS");
	    LocalDateTime pickup_time_localDateTime = LocalDateTime.parse(pickup_time_str, formatter);
	    pickup_time = Timestamp.valueOf(pickup_time_localDateTime);
	    
		//out.println("픽업 시간: " + pickup_time + "<br>");
		
	} else { // 배송지 정보
		
		if(request.getParameter("address").equals("existed")) {	// 기본 배송지
			post_code = request.getParameter("existed_post_code");
			road_address = request.getParameter("existed_road_address");
			detail_address = request.getParameter("existed_detail_address");
			
			//out.println("기본 배송지: [" + post_code + "] " + road_address + " " + detail_address + "<br>");
		} else {
			post_code = request.getParameter("new_post_code");
			road_address = request.getParameter("new_road_address");
			detail_address = request.getParameter("new_detail_address") + request.getParameter("new_extra_address");
			
			//out.println("신규 배송지: [" + post_code + "] " + road_address + " " + detail_address + "<br>");
		}
	}

	// 결제수단
	String pay_method = request.getParameter("pay_method");
	//out.println("결제수단: " + pay_method + "<br>");
	
	// 카드사명 (최대 20글자)
	String[] card_name_list = {"비씨", "국민", "하나", "삼성", "신한", "현대", "롯데", "씨티", "농협", "우리"}; // 제휴되어 있는 카드사 목록
	int size = card_name_list.length;
	String card_name = card_name_list[new Random().nextInt(size)];	// 제휴되어 있는 카드사 중 하나
	//out.println("카드사명: " + card_name + "<br>");
	
	// 카드번호
	String card_no = String.format("%06d", new Random().nextInt(100000)) + "******" + String.format("%04d", new Random().nextInt(1000));
	//out.println("카드번호: " + card_no + "<br>");
	
	// 할부개월
	String card_quota = "00";	// 할부개월 00 고정
	//out.println("할부개월: " + card_quota + "<br>");
	
	// 승인번호
	String auth_code = String.format("%08d", new Random().nextInt(10000000));
	//out.println("승인번호: " + auth_code + "<br>");


	//DAO 생성 후 Oracle DB 연결
	MenuDAO menuDao = new MenuDAO(application);
	MenuOptionDAO menuOptionDao = new MenuOptionDAO(application);
	CartDAO cartDao = new CartDAO(application);
	OrderTotalDAO orderTotalDao = new OrderTotalDAO(application);
	OrderDetailDAO orderDetailDao = new OrderDetailDAO(application);
	
	// AutoCommit 끄기
	// order_total 테이블에 주문 번호가 없는 경우 order_detail 테이블에 데이터 insert가 불가능하기 때문에 OrderTotalDAO는 AutoCommit을 끌 수 없음
	menuDao.con.setAutoCommit(false);
	menuOptionDao.con.setAutoCommit(false);
	cartDao.con.setAutoCommit(false);
	orderDetailDao.con.setAutoCommit(false);

	
	String src = request.getParameter("src");		// order_sheet.jsp 호출 경로 (view 또는 cart)
	//out.println("호출지: " + src + "<br>");
	
	List<OrderDetailDTO> orderDetailDtoList = new Vector<OrderDetailDTO>();		// 주문할 메뉴 목록을 저장할 변수
	String[] order_menus = null;
	
	// xxxx_view.jsp에서 바로 주문으로 진행한 경우: 주문할 메뉴가 1개
	if(src.equals("view")) {
		int menu_no = Integer.parseInt(request.getParameter("menu_no"));
		//out.println("메뉴 번호: " + menu_no + "<br>");
		
		int option_no = 0;	// 옵션 번호 (*0번 옵션은 존재하지 않음)
		try {
			// 옵션이 있는 메뉴인 경우 옵션 번호 저장
			option_no = Integer.parseInt(request.getParameter("option_no"));
		} catch(NumberFormatException e) {}	// 옵션이 없는 메뉴인 경우
		//out.println("옵션 번호: " + option_no + "<br>");
		
		int quantity = Integer.parseInt(request.getParameter("quantity"));
		//out.println("수량: " + quantity + "<br>");
		
		OrderDetailDTO orderDetailDto = new OrderDetailDTO();		// 주문할 메뉴 정보를 담는 OrderDetailDTO 객체
		
		orderDetailDto.setMenu_no(menu_no);		// 메뉴 번호
		orderDetailDto.setOption_no(option_no);	// 옵션 번호
		orderDetailDto.setQuantity(quantity);	// 수량
		
		orderDetailDtoList.add(orderDetailDto);	// 리스트에 추가

	} else if(src.equals("cart")) { // cart.jsp에서 주문을 진행한 경우: 장바구니 관리 번호를 받음, 주문할 메뉴가 1개 이상
		order_menus = request.getParameterValues("order_menus");
		
		// 장바구니 관리 번호 이용해서 메뉴 번호, 옵션 번호, 소계 금액 가져오기
		for(String str : order_menus) {
			
			int cart_no = Integer.parseInt(str);
			//out.println("장바구니 관리번호: " + cart_no + "<br>");
			
			OrderDetailDTO orderDetailDto = new OrderDetailDTO();
			CartDTO cartDto = cartDao.getCartDTO(Integer.parseInt(str));
			
			orderDetailDto.setMenu_no(cartDto.getMenu_no());		// 메뉴 번호
			orderDetailDto.setOption_no(cartDto.getOption_no());	// 옵션 번호
			orderDetailDto.setQuantity(cartDto.getQuantity());		// 수량
			
			orderDetailDtoList.add(orderDetailDto);		// 리스트에 추가
		}
	}

	// 총 거래 금액
	int amount = 0;
	
	for(OrderDetailDTO orderDetailDto : orderDetailDtoList) {
		orderDetailDto.setOrder_id(order_id);	// 주문번호
		
		// 메뉴 번호 이용해서 메뉴 판매가 가져오기
		int sales_price = menuDao.getSalesPrice(orderDetailDto.getMenu_no());
		orderDetailDto.setMenu_price(sales_price);
		
		// 옵션 번호 이용해서 옵션 가격 가져오기
		int option_price = menuOptionDao.getPrice(orderDetailDto.getOption_no());
		orderDetailDto.setOption_price(option_price);
		
		amount += (sales_price + option_price) * orderDetailDto.getQuantity();
	}
	
	
	// order_total
	OrderTotalDTO orderTotalDto = new OrderTotalDTO();
	orderTotalDto.setId(order_id);
	orderTotalDto.setMember_id(member_id);
	orderTotalDto.setRecipient_name(recipient_name);
	orderTotalDto.setRecipient_tel(recipient_tel);
	orderTotalDto.setRecipient_email(recipient_email);
	orderTotalDto.setType(order_type);
	orderTotalDto.setPost_code(post_code);
	orderTotalDto.setRoad_address(road_address);
	orderTotalDto.setDetail_address(detail_address);
	orderTotalDto.setPickup_branch(branch);
	orderTotalDto.setPickup_time(pickup_time);
	orderTotalDto.setAmount(amount);
	orderTotalDto.setPay_method(pay_method);
	orderTotalDto.setCard_name(card_name);
	orderTotalDto.setCard_no(card_no);
	orderTotalDto.setCard_quota(card_quota);
	orderTotalDto.setAuth_code(auth_code);
	

	boolean order_total_update_check = true;
	boolean update_check = true;
	
	// order_total
	if (orderTotalDao.insertOrderTotalDTO(orderTotalDto) != 1) {
		order_total_update_check = false;
		update_check = false;
	}
	
	if(update_check) {
		orderTotalDao.con.commit();	// order_total 업데이트가 성공이면 커밋
		
		System.out.println("==================================> " + orderDetailDtoList.size());
		
		for(OrderDetailDTO orderDetailDto : orderDetailDtoList) {
			// order_detail : insert 실패 시 반복문 종료
			if(orderDetailDao.insertOrderDtailDTO(orderDetailDto) != 1) {
				update_check = false;
				break;
			}
			
			// menu : update 실패 시 반복문 종료
			if(menuDao.updateStock(orderDetailDto.getMenu_no(), -orderDetailDto.getQuantity()) != 1) {
				update_check = false;
				break;
			}
			
			// menu_option : update 실패 시 반복문 종료
			if(orderDetailDto.getOption_no() != 0 && menuOptionDao.updateStock(orderDetailDto.getOption_no(), -orderDetailDto.getQuantity()) != 1) {
				update_check = false;
				break;
			}
		}
	}

	// cart : delete 실패 시 
	if(update_check && src.equals("cart")) {
		for(String str : order_menus) {
			int cart_no = Integer.parseInt(str);
				
			if(cartDao.deleteCart(cart_no) != 1) {
				update_check = false;
				break;
			}
		}
	}


	// 모든 업데이트 성공 시
	if(update_check) {
		System.out.println("모든 업데이트 성공!");
		
		// 수동으로 커밋
		menuDao.con.commit();
		menuOptionDao.con.commit();
		cartDao.con.commit();
		orderDetailDao.con.commit();
		
		response.sendRedirect("order_finish.jsp?order_id=" + orderTotalDto.getId());
		
	} else { // 한 번이라도 업데이트 실패 시
		// 롤백
		menuDao.con.rollback();
		menuOptionDao.con.rollback();
		cartDao.con.rollback();
		orderDetailDao.con.rollback();
		
		// insert된 order_total 데이터가 있다면 삭제
		if(order_total_update_check) {
			orderTotalDao.deleteOrderTotal(orderTotalDto.getId());
		}
		
		JSFunction.alertBack("주문 처리에 실패하였습니다.", out);
	}
	
	// DB 연결 해제
	menuDao.close();
	menuOptionDao.close();
	cartDao.close();
	orderTotalDao.close();
	orderDetailDao.close();
%>