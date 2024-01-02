package order_detail;

import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.servlet.ServletContext;

import common.JDBConnect;

public class OrderDetailDAO extends JDBConnect {
	
	// 생성자
	public OrderDetailDAO(ServletContext application) {
		super(application);
		System.out.println("OrderDetailDAO -> 생성자 호출");
	}
	
	// 메뉴 번호를 받아 해당 메뉴에 대해 작성된 리뷰 목록이 있는 경우의 옵션 번호 목록을 반환하는 메소드
	public List<Integer> getOneMenuReviewsOptionNo(int menu_no) {
		System.out.println("OrderDetailDAO -> getOneMenuReviewsOptionNo 메소드 호출");
		
		// 옵션 번호 목록을 담을 변수
		List<Integer> oneMenuReviewsOptionNo = new Vector<Integer>();
		
		// 옵션 번호 목록을 얻어오는 쿼리문
		String query = "SELECT option_no FROM order_detail";
		query += " WHERE menu_no=? and review_post_no IS NOT NULL";
		query += " ORDER BY review_post_no DESC";
		System.out.println("SQL 쿼리문: " + query);
		
		try {
			// 동적 쿼리문 생성
			psmt = con.prepareStatement(query);
			
			// 칼럼 값 채우기
			psmt.setInt(1, menu_no);
			
			// 동적 쿼리문 실행
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				int option_no;	// 옵션 번호가 저장될 변수
				
				option_no = rs.getInt("option_no");		// 옵션 번호

				oneMenuReviewsOptionNo.add(option_no);	// 리스트에 추가
			}
			
		} catch(Exception e) {
			System.out.println("옵션 번호 목록을 조회하는 중 예외 발생함.");
			System.out.println("OrderDetailDAO -> getOneMenuReviewsOptionNo 메소드 확인 바람");
			e.printStackTrace();
		}
		
		return oneMenuReviewsOptionNo;
	}
	
	// OrderDetailDTO 객체를 받아 insert하는 메소드
	public int insertOrderDtailDTO(OrderDetailDTO orderDetailDto) {
		System.out.println("OrderDetailDAO -> insertOrderDtailDTO 메소드 호출");
		
		// 결과값을 담을 변수
		int result = 0;
		
		// OrderDetailDTO 객체 정보 저장을 위한 쿼리문
		String query = "INSERT INTO order_detail(no, order_id, menu_no, menu_price, option_no, option_price, quantity)";
		query += " VALUES(seq_order_detail_no.NEXTVAL, ?, ?, ?, ?, ?, ?)";
		System.out.println("SQL 쿼리문: " + query);
		
		try {
			// 동적 쿼리문 생성
			psmt = con.prepareStatement(query);
			
			// 칼럼 값 채우기
			psmt.setString(1, orderDetailDto.getOrder_id());
			psmt.setInt(2, orderDetailDto.getMenu_no());
			psmt.setInt(3, orderDetailDto.getMenu_price());
			
			if(orderDetailDto.getOption_no() != 0) {
				psmt.setInt(4, orderDetailDto.getOption_no());
			} else {
				psmt.setNull(4, java.sql.Types.INTEGER);
			}
		
			psmt.setInt(5, orderDetailDto.getOption_price());
			psmt.setInt(6, orderDetailDto.getQuantity());
			
			// 동적 쿼리문 실행
			result = psmt.executeUpdate();
			
		} catch(Exception e) {
			System.out.println("OrderDetailDTO 정보를 저장하는 중 예외 발생함.");
			System.out.println("OrderDetailDAO -> insertOrderDtailDTO 메소드 확인 바람");
			e.printStackTrace();
		}
		
		return result;
	}
	
	
	public int reviewNumberUpdate(int review_post_no, int no) {
		System.out.println("OrderDetailDAO -> reviewNumberUpdate 메서드 실행됨.");
		
		// 수정 결과를 담는 변수
		int result = 0;
		
		// 
		String query = "UPDATE order_detail";
			   query += " SET review_post_no=? WHERE no=?";
		
		try {
		
			// 동적 쿼리문을 생성함.
			psmt = con.prepareStatement(query);
			
			// 컬럼의 값을 채워줌.
			psmt.setInt(1, review_post_no);
			psmt.setInt(2, no);
			
			// 동적 쿼리문을 실행함.
			result = psmt.executeUpdate();
			
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("게시글의 제목 및 내용을 수정하는 중 예외 발생함.");
			System.out.println("OrderDetailDAO -> reviewNumberUpdate 메서드 확인.");
			e.printStackTrace();
		}
		
		return result;
	}
	
	//주문번호를 입력받아 해당 주문의 상세 내역 목록을 리스트로 반환하는 메소드
	public List<OrderDetailDTO> selectList(Map<String, Object>map, String orderId){
		System.out.println("OrderDetailDAO.selectList 메소드 실행");
		
		//주문 상세 내역을 담을 리스트
		List<OrderDetailDTO> bbs=new Vector<OrderDetailDTO>();
		
		//주문 상세 내역을 얻어오는 쿼리문 작성
		String query="select * from order_detail where order_id = '"+orderId+"'";
		
		try {
			stmt=con.createStatement();// 쿼리문 생성
			rs=stmt.executeQuery(query);// 쿼리문 실행
			while(rs.next()) {//커서를 이동 (다음줄이 비어있지 않을 때까지)
				//주문 상세 내역 한 행을 DTO에 저장
				OrderDetailDTO orderDetailDto=new OrderDetailDTO();
				
				//관리번호(no) 저장
				orderDetailDto.setNo(rs.getInt("no"));
				//주문번호(order_id) 저장
				orderDetailDto.setOrder_id(rs.getString("order_id"));
				//메뉴번호(menu_no) 저장
				orderDetailDto.setMenu_no(rs.getInt("menu_no"));
				//메뉴가격(menu_price) 저장
				orderDetailDto.setMenu_price(rs.getInt("menu_price"));
				//옵션번호(option_no) 저장
				orderDetailDto.setOption_no(rs.getInt("option_no"));
				//옵션가격(option_price) 저장
				orderDetailDto.setOption_price(rs.getInt("option_price"));
				//수량(quantity) 저장
				orderDetailDto.setQuantity(rs.getInt("quantity"));
				//리뷰번호(review_no) 저장
				orderDetailDto.setReview_post_no(rs.getInt("review_post_no"));
				
				bbs.add(orderDetailDto);
			}
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("주문 상세 내역 조회 중 에러 발생!!");
			System.out.println("에러 발생 위치: OrderDetailDAO.selectList 메소드");
			e.printStackTrace();
		}
		
		return bbs;
	}
	
	
	//주문번호를 입력받아 주문 상세 내역 정보를 보여주는 메소드
	public OrderDetailDTO selectDetailList(String orderId) {
		System.out.println("OrderDetailDAO.selectDetailList 메소드 실행");
		
		//주문 상세 내역을 저장할 객체
		OrderDetailDTO orderDetailDto=new OrderDetailDTO();
		
		//주문번호를 입력받아 해당 주문의 상세 내역 정보를 얻어올 쿼리문 작성
		String query="select * from order_detail where order_id = ?";
		
		try {
			//동적 쿼리문 생성
			psmt=con.prepareStatement(query);
			
			//칼럼 값 집어넣기
			psmt.setString(1, orderId);
			
			//동적 쿼리문 실행
			rs=psmt.executeQuery();
			
			//해당 주문 상세 내역 존재 확인
			if (rs.next()) {//해당 주문 상세 내역이 존재하면
				//관리번호(no) 저장
				orderDetailDto.setNo(rs.getInt("no"));
				//주문번호(order_id) 저장
				orderDetailDto.setOrder_id(rs.getString("order_id"));
				//메뉴번호(menu_no) 저장
				orderDetailDto.setMenu_no(rs.getInt("menu_no"));
				//메뉴가격(menu_price) 저장
				orderDetailDto.setMenu_price(rs.getInt("menu_price"));
				//옵션번호(option_no) 저장
				orderDetailDto.setOption_no(rs.getInt("option_no"));
				//옵션가격(option_price) 저장
				orderDetailDto.setOption_price(rs.getInt("option_price"));
				//수량(quantity) 저장
				orderDetailDto.setQuantity(rs.getInt("quantity"));
				//리뷰번호(review_no) 저장
				orderDetailDto.setReview_post_no(rs.getInt("review_post_no"));
				
			}
			
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("주문 상세 목록 확인중 에러 발생!!");
			System.out.println("에러 발생 위치: OrderDetailDAO.selectDetailList 메소드");
			e.printStackTrace();
		}
		
		return orderDetailDto;
	}
	
	//주문 상품 수를 구하는 메소드
	public int selectCount(Map<String, Object> map, String orderId) {
		System.out.println("OrderDetailDAO.selectCount 메소드 실행");
		
		//주문 상품 수를 저장할 변수
		int totalCount=0;
		
		//주문 상품 수를 구하는 쿼리문 작성
		String query="select count(*) from order_detail where order_id='"+orderId+"'";
		
		try {
			stmt=con.createStatement();// 쿼리문 생성
			rs=stmt.executeQuery(query);// 쿼리문 실행
			rs.next();// 커서 첫번째 행으로 이동
			totalCount=rs.getInt(1);// 첫번째 칼럼 저장
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("주문 상품 수를 구하는 중 에러 발생!!");
			System.out.println("에러 발생 위치: OrderDetailDAO.selectCount 메소드");
			e.printStackTrace();
		}
		
		return totalCount;
	}
	
	
}
