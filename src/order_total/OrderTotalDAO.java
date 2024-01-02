package order_total;

import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.servlet.ServletContext;

import common.JDBConnect;

public class OrderTotalDAO extends JDBConnect {
	
	// 생성자
	public OrderTotalDAO(ServletContext application) {
		super(application);
	}
	
	// OrderTotalDTO 객체를 받아 DB에 insert하는 메소드
	public int insertOrderTotalDTO(OrderTotalDTO orderTotalDto) {
		System.out.println("OrderTotalDAO -> insertOrderTotalDTO 메소드 호출");
		
		// 결과값을 담을 변수
		int result = 0;
		
		// OrderTotalDTO 객체 정보 저장을 위한 쿼리문
		String query = "INSERT INTO order_total";
		query += "(id, member_id, recipient_name, recipient_tel, recipient_email, type, post_code, road_address, detail_address, pickup_branch, pickup_time,";
		query += " amount, pay_method, card_name, card_no, card_quota, auth_code)";
		query += " VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		System.out.println("SQL 쿼리문: " + query);
		
		try {
			// 동적 쿼리문 생성
			psmt = con.prepareStatement(query);
			
			// 칼럼 값 채우기
			psmt.setString(1, orderTotalDto.getId());
			psmt.setString(2, orderTotalDto.getMember_id());
			psmt.setString(3, orderTotalDto.getRecipient_name());
			psmt.setString(4, orderTotalDto.getRecipient_tel());
			psmt.setString(5, orderTotalDto.getRecipient_email());
			psmt.setString(6, orderTotalDto.getType());
			psmt.setString(7, orderTotalDto.getPost_code());
			psmt.setString(8, orderTotalDto.getRoad_address());
			psmt.setString(9, orderTotalDto.getDetail_address());
			psmt.setString(10, orderTotalDto.getPickup_branch());
			psmt.setTimestamp(11, orderTotalDto.getPickup_time());
			psmt.setInt(12, orderTotalDto.getAmount());
			psmt.setString(13, orderTotalDto.getPay_method());
			psmt.setString(14, orderTotalDto.getCard_name());
			psmt.setString(15, orderTotalDto.getCard_no());
			psmt.setString(16, orderTotalDto.getCard_quota());
			psmt.setString(17, orderTotalDto.getAuth_code());
			
			// 동적 쿼리문 실행
			result = psmt.executeUpdate();
			
		} catch(Exception e) {
			System.out.println("OrderTotalDTO 정보를 저장하는 중 예외 발생함.");
			System.out.println("OrderTotalDAO -> insertOrderTotalDTO 메소드 확인 바람");
			e.printStackTrace();
		}
		
		return result;
	}
	
	// 주문번호를 받아 해당되는 데이터를 삭제하는 메소드 - 데이터 불일치 문제 해결 목적
	public int deleteOrderTotal(String id) {
		System.out.println("OrderTotalDAO -> deleteOrderTotal 메소드 호출");
		
		// 결과값을 담을 변수
		int result = 0;
		
		// 주문번호가 일치하는 데이터를 삭제하기 위한 쿼리문
		String query = "DELETE FROM order_total";
		query += " WHERE id = ?";
		System.out.println("SQL 쿼리문: " + query);
		
		try {
			// 동적 쿼리문 생성
			psmt = con.prepareStatement(query);
			
			// 칼럼 값 채우기
			psmt.setString(1, id);
			
			// 동적 쿼리문 실행
			result = psmt.executeUpdate();
			
		} catch(Exception e) {
			System.out.println("order_total 데이터를 삭제하는 중 예외 발생함.");
			System.out.println("OrderTotalDAO -> deleteOrderTotal 메소드 확인 바람");
			e.printStackTrace();
		}
		
		return result;
	}
	
	//주문 목록을 리스트로 가져오는 메소드
	public List<OrderTotalDTO> selectList(Map<String, Object> map, String memberId){
		System.out.println("OrderTotalDAO.selectList 메소드 실행");
		
		//주문 목록 리스트를 담을 변수
		List<OrderTotalDTO> bbs=new Vector<OrderTotalDTO>();
		
		//주문 목록을 얻어오는 쿼리문 작성
		String query="select * from order_total where member_id = '"+memberId+"'";
		if(map.get("sch_type")!=null && map.get("sch_payMethod")!=null) {//주문 유형과 결제 수단 검색 조건이 모두 있는 경우
			query+=" and type like '%"+map.get("sch_type")+"%' and pay_method like '%"+map.get("sch_payMethod")+"%' order by order_date desc";			
		}else if(map.get("sch_type")!=null) {//주문 유형 검색 조건만 있는 경우
			query+=" and type like '%"+map.get("sch_type")+"%' order by order_date desc";
		}else if(map.get("sch_payMethod")!=null) {//결제 수단 검색 조건만 있는 경우
			query+=" and pay_method like '%"+map.get("sch_payMethod")+"%' order by order_date desc";
		}else {// 검색 조건이 없는 경우
			query+=" order by order_date desc";
		}
		
		try {
			stmt=con.createStatement();// 쿼리문 생성
			rs=stmt.executeQuery(query);// 쿼리문 실행
			while(rs.next()){// 커서를 이동 (다음줄이 비어있지 않을 때까지)
				
				//주문내역 한 행의 내용을 DTO에 저장
				OrderTotalDTO orderTotalDto=new OrderTotalDTO();
				//주문번호(id) 저장
				orderTotalDto.setId(rs.getString("id"));
				//주문 일시(order_date) 저장
				orderTotalDto.setOrder_date(rs.getTimestamp("order_date"));
				//회원ID (member_id) 저장
				orderTotalDto.setMember_id(rs.getString("member_id"));
				//수령인 이름(recipient_name) 저장
				orderTotalDto.setRecipient_name(rs.getString("recipient_name"));
				//수령인 연락처(recipient_tel) 저장
				orderTotalDto.setRecipient_tel(rs.getString("recipient_tel"));
				//수령인 이메일(recipient_email) 저장
				orderTotalDto.setRecipient_email(rs.getString("recipient_email"));
				//주문 유형(type) 저장
				orderTotalDto.setType(rs.getString("type"));
				//우편 번호(post_code) 저장
				orderTotalDto.setPost_code(rs.getString("post_code"));
				//도로명 주소(road_address) 저장
				orderTotalDto.setRoad_address(rs.getString("road_address"));
				//상세 주소(detail_address) 저장
				orderTotalDto.setDetail_address(rs.getString("detail_address"));
				//픽업 지점(pickup_branch) 저장
				orderTotalDto.setPickup_branch(rs.getString("pickup_branch"));
				//픽업 시간(pickup_time) 저장
				orderTotalDto.setPickup_time(rs.getTimestamp("pickup_time"));
				//총 거래 금액(amount) 저장
				orderTotalDto.setAmount(rs.getInt("amount"));
				//결제 수단(pay_method) 저장
				orderTotalDto.setPay_method(rs.getString("pay_method"));
				//카드사명(card_name) 저장
				orderTotalDto.setCard_name(rs.getString("card_name"));
				//카드 번호(card_no) 저장
				orderTotalDto.setCard_no(rs.getString("card_no"));
				//할부 개월(card_quota) 저장
				orderTotalDto.setCard_quota(rs.getString("card_quota"));
				//승인 번호(auth_code) 저장
				orderTotalDto.setAuth_code(rs.getString("auth_code"));
				
				//주문내역 목록 저장
				bbs.add(orderTotalDto);
			}
						
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("주문 내역 목록 조회 중 에러 발생!!");
			System.out.println("에러 발생 위치: OrderTotalDAO.selectList 메소드");
			e.printStackTrace();
		}
		
		return bbs;
	}
	
	//주문 내역 목록 수를 얻어오는 메소드
	public int selectCount(Map<String, Object> map, String memberId) {
		System.out.println("OrderTotalDAO.selectCount 메소드 실행");
		
		//주문 목록 수를 담을 변수
		int totalCount=0;
		
		//주문 목록 수를 얻어오는 쿼리문 작성
		String query="select count(*) from order_total where member_id = '"+memberId+"'";
		if(map.get("sch_type")!=null && map.get("sch_payMethod")!=null) {//주문 유형과 결제 수단 검색 조건이 모두 있는 경우
			query+=" and type like '%"+map.get("sch_type")+"%' and pay_method like '%"+map.get("sch_payMethod")+"%'";			
		}else if(map.get("sch_type")!=null) {//주문 유형 검색 조건만 있는 경우
			query+=" and type like '%"+map.get("sch_type")+"%'";
		}else if(map.get("sch_payMethod")!=null) {//결제 수단 검색 조건만 있는 경우
			query+=" and pay_method like '%"+map.get("sch_payMethod")+"%'";
		}
		
		try {
			stmt=con.createStatement();// 쿼리문 생성
			rs=stmt.executeQuery(query);// 쿼리문 실행
			rs.next();// 커서 첫번째 행으로 이동
			totalCount=rs.getInt(1);// 첫번째 칼럼 저장
			
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("주문 내역 목록 수를 구하는 중 에러 발생!!");
			System.out.println("에러 발생 위치: OrderTotalDAO.selectCount 메소드");
			e.printStackTrace();
		}
		
		System.out.println("totalCount: "+totalCount);
		return totalCount;
	}
	
	//주문번호를 입력받아 해당 주문 내역의 상세 정보를 보여주기
	public OrderTotalDTO selectDetailList(String id, String memberId) {
		System.out.println("OrderTotalDAO.selectDetailList 메소드 실행");
		
		//주문목록 상세 정보를 저장하기 위한 객체
		OrderTotalDTO orderTotalDto=new OrderTotalDTO();
		
		//주문번호를 입력받아 주문 내역 정보를 얻어오는 쿼리문 작성
		String query="select * from order_total where member_id = ? and id = ?";
		
		try {
			// 동적 쿼리문 생성
			psmt=con.prepareStatement(query);
			
			// 칼럼 값 넣기
			psmt.setString(1, memberId);
			psmt.setString(2, id);
			
			
			System.out.println("주문 번호: "+id);
			
			// 동적 쿼리문 실행
			rs=psmt.executeQuery();
			
			// 해당하는 주문내역 존재 유무 확인
			if (rs.next()) {// 주문내역이 존재한다면
				//주문번호(id) 저장
				orderTotalDto.setId(rs.getString("id"));
				//주문 일시(order_date) 저장
				orderTotalDto.setOrder_date(rs.getTimestamp("order_date"));
				//회원ID (member_id) 저장
				orderTotalDto.setMember_id(rs.getString("member_id"));
				//수령인 이름(recipient_name) 저장
				orderTotalDto.setRecipient_name(rs.getString("recipient_name"));
				//수령인 연락처(recipient_tel) 저장
				orderTotalDto.setRecipient_tel(rs.getString("recipient_tel"));
				//수령인 이메일(recipient_email) 저장
				orderTotalDto.setRecipient_email(rs.getString("recipient_email"));
				//주문 유형(type) 저장
				orderTotalDto.setType(rs.getString("type"));
				//우편 번호(post_code) 저장
				orderTotalDto.setPost_code(rs.getString("post_code"));
				//도로명 주소(road_address) 저장
				orderTotalDto.setRoad_address(rs.getString("road_address"));
				//상세 주소(detail_address) 저장
				orderTotalDto.setDetail_address(rs.getString("detail_address"));
				//픽업 지점(pickup_branch) 저장
				orderTotalDto.setPickup_branch(rs.getString("pickup_branch"));
				//픽업 시간(pickup_time) 저장
				orderTotalDto.setPickup_time(rs.getTimestamp("pickup_time"));
				//총 거래 금액(amount) 저장
				orderTotalDto.setAmount(rs.getInt("amount"));
				//결제 수단(pay_method) 저장
				orderTotalDto.setPay_method(rs.getString("pay_method"));
				//카드사명(card_name) 저장
				orderTotalDto.setCard_name(rs.getString("card_name"));
				//카드 번호(card_no) 저장
				orderTotalDto.setCard_no(rs.getString("card_no"));
				//할부 개월(card_quota) 저장
				orderTotalDto.setCard_quota(rs.getString("card_quota"));
				//승인 번호(auth_code) 저장
				orderTotalDto.setAuth_code(rs.getString("auth_code"));
				
			}
			
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("주문목록 상세내용 확인중 에러 발생!!");
			System.out.println("에러 발생 위치: OrderTotalDAO.selectDetailList 메소드");
			e.printStackTrace();
		}
		
		return orderTotalDto;
	}
	
	//주문번호를 입력받아 해당 주문 내역의 상세 정보를 보여주기
	public OrderTotalDTO getOrderTotalDTO(String id) {
		System.out.println("OrderTotalDAO.getOrderTotalDTO 메소드 실행");
		
		//주문목록 상세 정보를 저장하기 위한 객체
		OrderTotalDTO orderTotalDto = new OrderTotalDTO();
		
		//주문번호를 입력받아 주문 내역 정보를 얻어오는 쿼리문 작성
		String query="SELECT * FROM order_total";
		query += " WHERE id = ?";
		System.out.println("SQL 쿼리문: " + query);
		
		try {
			// 동적 쿼리문 생성
			psmt=con.prepareStatement(query);
			
			// 칼럼 값 넣기
			psmt.setString(1, id);
			
			// 동적 쿼리문 실행
			rs = psmt.executeQuery();
			
			// 해당하는 주문내역 존재 유무 확인
			if (rs.next()) {// 주문내역이 존재한다면
				//주문번호(id) 저장
				orderTotalDto.setId(rs.getString("id"));
				//주문 일시(order_date) 저장
				orderTotalDto.setOrder_date(rs.getTimestamp("order_date"));
				//회원ID (member_id) 저장
				orderTotalDto.setMember_id(rs.getString("member_id"));
				//수령인 이름(recipient_name) 저장
				orderTotalDto.setRecipient_name(rs.getString("recipient_name"));
				//수령인 연락처(recipient_tel) 저장
				orderTotalDto.setRecipient_tel(rs.getString("recipient_tel"));
				//수령인 이메일(recipient_email) 저장
				orderTotalDto.setRecipient_email(rs.getString("recipient_email"));
				//주문 유형(type) 저장
				orderTotalDto.setType(rs.getString("type"));
				//우편 번호(post_code) 저장
				orderTotalDto.setPost_code(rs.getString("post_code"));
				//도로명 주소(road_address) 저장
				orderTotalDto.setRoad_address(rs.getString("road_address"));
				//상세 주소(detail_address) 저장
				orderTotalDto.setDetail_address(rs.getString("detail_address"));
				//픽업 지점(pickup_branch) 저장
				orderTotalDto.setPickup_branch(rs.getString("pickup_branch"));
				//픽업 시간(pickup_time) 저장
				orderTotalDto.setPickup_time(rs.getTimestamp("pickup_time"));
				//총 거래 금액(amount) 저장
				orderTotalDto.setAmount(rs.getInt("amount"));
				//결제 수단(pay_method) 저장
				orderTotalDto.setPay_method(rs.getString("pay_method"));
				//카드사명(card_name) 저장
				orderTotalDto.setCard_name(rs.getString("card_name"));
				//카드 번호(card_no) 저장
				orderTotalDto.setCard_no(rs.getString("card_no"));
				//할부 개월(card_quota) 저장
				orderTotalDto.setCard_quota(rs.getString("card_quota"));
				//승인 번호(auth_code) 저장
				orderTotalDto.setAuth_code(rs.getString("auth_code"));
				
			}
			
		} catch (Exception e) {
			System.out.println("order total 데이터를 조회하는 중 예외 발생함.");
			System.out.println("OrderTotalDAO -> getOrderTotalDTO 메소드 확인 바람");
			e.printStackTrace();
		}
		
		return orderTotalDto;
	}
}
