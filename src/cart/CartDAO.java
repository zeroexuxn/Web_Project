package cart;

import java.util.List;
import java.util.Vector;

import javax.servlet.ServletContext;

import common.JDBConnect;

public class CartDAO extends JDBConnect {
	
	// 생성자
	public CartDAO(ServletContext application) {
		super(application);
		System.out.println("CartDAO -> 생성자 호출");
	}
	
	// CartDTO 객체를 받아 정보를 저장하는 메소드
	public int insertCartDto (CartDTO cartDto) {
		System.out.println("CartDAO -> insertCartDto 메소드 호출");
		
		// 결과값을 담을 변수
		int result = 0;
		
		// CartDTO 객체 정보 저장을 위한 쿼리문
		String query = "INSERT INTO cart";
		query += " VALUES(seq_cart_no.NEXTVAL, ?, ?, ?, ?)";
		System.out.println("SQL 쿼리문: " + query);
		
		try {
			// 동적 쿼리문 생성
			psmt = con.prepareStatement(query);
			
			// 칼럼 값 채우기
			psmt.setString(1, cartDto.getMember_id());
			psmt.setInt(2, cartDto.getMenu_no());
			
			if(cartDto.getOption_no() != 0) {
				psmt.setInt(3, cartDto.getOption_no());
			} else {
				psmt.setNull(3, java.sql.Types.INTEGER);
			}

			psmt.setInt(4, cartDto.getQuantity());
			
			// 동적 쿼리문 실행
			result = psmt.executeUpdate();
			
		} catch(Exception e) {
			System.out.println("CartDTO 정보를 저장하는 중 예외 발생함.");
			System.out.println("CartDAO -> insertCartDto 메소드 확인 바람");
			e.printStackTrace();
		}
		
		return result;
	}
	
	// 장바구니 관리 번호를 받아 해당되는 CartDTO를 반환하는 메소드
	public CartDTO getCartDTO (int no) {
		System.out.println("CartDAO -> getCartDto 메소드 호출");
		
		// 장바구니 관리 번호가 일치하는 CartDTO 변수 
		CartDTO cartDto = new CartDTO();
		
		// 장바구니 관리 번호가 일치하는 데이터를 얻어오는 쿼리문
		String query = "SELECT * FROM cart";
		query += " WHERE no = ?";
		System.out.println("SQL 쿼리문: " + query);
		
		try {
			// 동적 쿼리문 생성
			psmt = con.prepareStatement(query);
			
			// 칼럼 값 채우기
			psmt.setInt(1, no);
			
			// 동적 쿼리문 실행
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				cartDto.setNo(rs.getInt("no"));
				cartDto.setMember_id(rs.getString("member_id"));
				cartDto.setMenu_no(rs.getInt("menu_no"));
				cartDto.setOption_no(rs.getInt("option_no"));
				cartDto.setQuantity(rs.getInt("quantity"));
			}

		} catch(Exception e) {
			System.out.println("CartDTO 정보를 읽는 중 예외 발생함.");
			System.out.println("CartDAO -> getCartDto 메소드 확인 바람");
			e.printStackTrace();
		}
		
		return cartDto;
	}
	
	// 장바구니 관리 번호를 받아 해당되는 데이터를 삭제하는 메소드 (장바구니에 담겨 있던 상품의 주문이 완료된 경우에 호출)
	public int deleteCart(int no) {
		System.out.println("CartDAO -> deleteCart 메소드 호출");
		
		// 결과값을 담을 변수
		int result = 0;
		
		// 장바구니 관리 번호가 일치하는 데이터를 삭제하는 쿼리문
		String query = "DELETE FROM cart";
		query += " WHERE no = ?";
		System.out.println("SQL 쿼리문: " + query);
		
		try {
			// 동적 쿼리문 생성
			psmt = con.prepareStatement(query);
			
			// 칼럼 값 채우기
			psmt.setInt(1, no);
			
			// 동적 쿼리문 실행
			result = psmt.executeUpdate();
			
		} catch(Exception e) {
			System.out.println("장바구니 항목을 삭제하는 중 예외 발생함.");
			System.out.println("CartDAO -> deleteCart 메소드 확인 바람");
			e.printStackTrace();
		}
		
		return result;
	}
	
	public List<CartDTO> selectProduct(String m_id) {
		
		System.out.println("CartDAO -> selectProduct 메서드 실행됨.");
		
		// 메뉴 정보를 담을 변수
		List<CartDTO> cartList = new Vector<CartDTO>();
		
		// 메뉴 정보를 얻어오는 쿼리문 작성하기
		String query = "SELECT c.no, c.member_id, c.menu_no, c.option_no, c.quantity";
				query += " FROM cart c";
				query += " LEFT OUTER JOIN menu m";
				query += " ON c.menu_no = m.no";
				query += " WHERE m.visibility = 'visible' AND member_id = '" + m_id+"'";
				
		System.out.println("SQL 쿼리문: " + query);
		
		try {
			
			stmt = con.createStatement(); // 쿼리문을 생성함.
			rs = stmt.executeQuery(query); // 쿼리문을 실행함.
			
			while(rs.next()) { // 커서를 이동하면서
			
				
				CartDTO cartDto = new CartDTO();
				
				cartDto.setNo(rs.getInt("no"));
				cartDto.setMember_id(rs.getString("member_id"));
				cartDto.setMenu_no(rs.getInt("menu_no"));
				cartDto.setOption_no(rs.getInt("option_no"));
				cartDto.setQuantity(rs.getInt("quantity"));
				
				// 게시글 목록을 저정함.
				cartList.add(cartDto);
			
			}
			
			
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("상품 정보를 조회하는 중 예외 발생함.");
			System.out.println("CartDAO -> selectProduct 메서드 확인.");
			e.printStackTrace();
		}
		
		return cartList;
		
	}
	
	public int deleteProduct(int no) {
		
		System.out.println("CartDAO -> deleteProduct 메서드 실행됨.");
		
		// 삭제 결과를 담는 변수
		int result = 0;
		
		// 메뉴 정보를 얻어오는 쿼리문 작성하기
		String query = "DELETE FROM cart WHERE no = ?";
		
				
		System.out.println("SQL 쿼리문: " + query);
		
		try {
			
			psmt = con.prepareStatement(query);
			psmt.setInt(1, no);
			result = psmt.executeUpdate();
			
			
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("상품 정보를 삭제하는 중 예외 발생함.");
			System.out.println("CartDAO -> deleteProduct 메서드 확인.");
			e.printStackTrace();
		}
		
		return result;
		
	}
	
	// CartDTO 객체를 받아 정보를 저장하는 메소드
		public int UpdateProduct (CartDTO cartDto) {
			System.out.println("CartDAO -> UpdateProduct 메소드 호출");
			
			// 결과값을 담을 변수
			int result = 0;
			
			// CartDTO 객체 정보 저장을 위한 쿼리문
			String query = "UPDATE cart SET option_no = ?, quantity = ? WHERE no = ?";
			
			System.out.println("SQL 쿼리문: " + query);
			
			try {
				// 동적 쿼리문 생성
				psmt = con.prepareStatement(query);
				
				// 칼럼 값 채우기
				
				
				if(cartDto.getOption_no() != 0) {
					psmt.setInt(1, cartDto.getOption_no());
					System.out.println("getOption_no =======>" + cartDto.getOption_no());
				} else {
					psmt.setNull(1, java.sql.Types.INTEGER);
					
				}
				
				
				psmt.setInt(2, cartDto.getQuantity());
				System.out.println("getQuantity =======>" + cartDto.getQuantity());
				psmt.setInt(3, cartDto.getNo());
				System.out.println("getNo =======>" + cartDto.getNo());

				// 동적 쿼리문 실행
				result = psmt.executeUpdate();
				System.out.println("result =======>" + result);
				
				if (result == 1) {
		            System.out.println("제품 업데이트 성공");
		        } else {
		            System.out.println("제품 업데이트 실패");
		        }
				
			} catch(Exception e) {
				System.out.println("CartDTO 정보를 저장하는 중 예외 발생함.");
				System.out.println("CartDAO -> UpdateProduct 메소드 확인 바람");
				e.printStackTrace();
			}
			
			return result;
		}
	
}
