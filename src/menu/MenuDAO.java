package menu;

import java.util.List;
import java.util.Vector;

import javax.servlet.ServletContext;

import common.JDBConnect;
import order_detail.OrderDetailDTO;

public class MenuDAO extends JDBConnect {
	
	// 생성자
	public MenuDAO(ServletContext application) {
		super(application);
	}
	
	// 카테고리 Id를 리스트로 반환한다. (ex. cold_brew, espresso ...)
	public List<MenuDTO> menuCategoryIdImport(String category_id) {
				
		System.out.println("MenuDAO -> menuCategoryIdImport 메서드 실행됨.");
		
		// 카테고리 Id를 담을 변수
		List<MenuDTO> vector = new  Vector<MenuDTO>();
		
		// 카테고리 Id를 얻어오는 쿼리문 작성하기
		String query = "SELECT * FROM menu";
		
		if(category_id != null) {
			query += " WHERE category_id='" + category_id + "'";
		}
		query += " ORDER BY no";
		
		
		try {
			stmt = con.createStatement(); 	// 쿼리문을 생성함
			rs = stmt.executeQuery(query);	// 쿼리문을 실행함.
			
			while(rs.next()) {	// 커서를 이동하면서
				
				MenuDTO menuDto = new MenuDTO();
				
				menuDto.setNo(rs.getInt("no"));
				
				menuDto.setName_kor(rs.getString("name_kor"));
				
				menuDto.setName_eng(rs.getString("name_eng"));
				
				menuDto.setDescription(rs.getString("description"));	
				
				menuDto.setSales_price(rs.getInt("sales_price"));
				
				menuDto.setStock(rs.getInt("stock"));
				
				menuDto.setVisibility(rs.getString("visibility"));
				
				menuDto.setCategory_id(rs.getString("category_id"));
				
				menuDto.setRegist_date(rs.getDate("regist_date"));
				
				vector.add(menuDto);
			}
			
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("카테고리를 조회하는 중 예외 발생함.");
			System.out.println("MenuDAO -> menuCategoryIdImport 메서드 확인.");
			e.printStackTrace();
		}
		return vector;
		
	}
	
	
	// 신메뉴를 리스트로 반환한다.
	public List<MenuDTO> newMenuImport(String type) {
				
		System.out.println("MenuDAO -> newMenuImport 메서드 실행됨.");
		
		// 신메뉴를 담을 변수
		List<MenuDTO> vector = new  Vector<MenuDTO>();
		
		// 신메뉴를 얻어오는 쿼리문 작성하기
		String query = "SELECT * FROM menu";
			   query += " WHERE regist_date > (sysdate-90)";
			   query += " AND category_id";
			   query += " IN (SELECT id FROM category WHERE type='" + type + "')";
		
		try {
			stmt = con.createStatement(); 	// 쿼리문을 생성함
			rs = stmt.executeQuery(query);	// 쿼리문을 실행함.
			
			while(rs.next()) {	// 커서를 이동하면서
				
				MenuDTO menuDto = new MenuDTO();
				
				menuDto.setNo(rs.getInt("no"));
				
				menuDto.setName_kor(rs.getString("name_kor"));
				
				menuDto.setName_eng(rs.getString("name_eng"));
				
				menuDto.setDescription(rs.getString("description"));	
				
				menuDto.setSales_price(rs.getInt("sales_price"));
				
				menuDto.setStock(rs.getInt("stock"));
				
				menuDto.setVisibility(rs.getString("visibility"));
				
				menuDto.setCategory_id(rs.getString("category_id"));
				
				menuDto.setRegist_date(rs.getDate("regist_date"));
				
				vector.add(menuDto);
			}
			
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("카테고리를 조회하는 중 예외 발생함.");
			System.out.println("MenuDAO -> newMenuImport 메서드 확인.");
			e.printStackTrace();
		}
		return vector;
		
	}
	
	// 메뉴 번호를 받아 해당 상품의 정보를 반환하는 메소드
	public MenuDTO getMenuDTO(int no) {
		System.out.println("MemuDAO -> getMenuDTO 메소드 호출");
		
		// 메뉴 정보가 담길 MenuDTO 객체
		MenuDTO menuDto = new MenuDTO();
		
		// 상품 번호가 일치하는 메뉴를 찾는 쿼리문
		String query = "SELECT * FROM menu WHERE no=?";
		System.out.println("SQL 쿼리문: " + query);
		
		try {
			// 동적 쿼리문 생성
			psmt = con.prepareStatement(query);
			
			// 칼럼 값 채우기
			psmt.setInt(1, no);
			
			// 동적 쿼리문 실행
			rs = psmt.executeQuery();

			// PK로 설정된 no를 이용해 조회할 경우 반환되는 튜플은 1개이므로 반복(while)문으로 데이터를 가져올 필요 없음
			if(rs.next()) {
				menuDto.setNo(rs.getInt("no"));							// 메뉴 번호
				menuDto.setName_kor(rs.getString("name_kor"));			// 메뉴명(한글)
				menuDto.setName_eng(rs.getString("name_eng"));			// 메뉴명(영어)
				menuDto.setDescription(rs.getString("description"));	// 메뉴 설명
				menuDto.setSales_price(rs.getInt("sales_price"));		// 판매가
				menuDto.setStock(rs.getInt("stock"));					// 재고
				menuDto.setVisibility(rs.getString("visibility"));		// 표시 여부
				menuDto.setCategory_id(rs.getString("category_id"));	// 카테고리 id
				menuDto.setRegist_date(rs.getDate("regist_date"));		// 등록일
			}
			
		} catch(Exception e) {
			System.out.println("메뉴 정보를 조회하는 중 예외 발생함.");
			System.out.println("MemuDAO -> getMenuDTO 메소드 확인 바람");
			e.printStackTrace();
		}
		
		return menuDto;
	}

	// OrderDetail 객체의 리스트를 받아 해당 메뉴 번호가 일치하는 MenuDTO 리스트를 반환하는 메소드
	public List<MenuDTO> getMenuDTOList(List<OrderDetailDTO> orderDetailDtoList) {
		System.out.println("MemuDAO -> getMenuDTOList 메소드 호출");
		
		// 메뉴 정보 목록을 담을 변수
		List<MenuDTO> menuDtoList = new Vector<MenuDTO>();
		
		// 메뉴 번호가 일치하는 메뉴를 찾는 쿼리문
		String query = "SELECT * FROM menu WHERE no=?";
		System.out.println("SQL 쿼리문: " + query);
		
		for(OrderDetailDTO orderDetailDto : orderDetailDtoList) {
			try {
				// 동적 쿼리문 생성
				psmt = con.prepareStatement(query);
				
				// 칼럼 값 채우기
				psmt.setInt(1, orderDetailDto.getMenu_no());
				
				// 동적 쿼리문 실행
				rs = psmt.executeQuery();
				
				// PK로 설정된 no를 이용해 조회할 경우 반환되는 튜플은 1개이므로 반복(while)문으로 데이터를 가져올 필요 없음
				if(rs.next()) {
					MenuDTO menuDto = new MenuDTO();	// 메뉴 정보를 담을 MenuDTO 객체
					
					menuDto.setNo(rs.getInt("no"));							// 메뉴 번호
					menuDto.setName_kor(rs.getString("name_kor"));			// 메뉴명(한글)
					menuDto.setName_eng(rs.getString("name_eng"));			// 메뉴명(영어)
					menuDto.setDescription(rs.getString("description"));	// 메뉴 설명
					menuDto.setSales_price(rs.getInt("sales_price"));		// 판매가
					menuDto.setStock(rs.getInt("stock"));					// 재고
					menuDto.setVisibility(rs.getString("visibility"));		// 표시 여부
					menuDto.setCategory_id(rs.getString("category_id"));	// 카테고리 id
					menuDto.setRegist_date(rs.getDate("regist_date"));		// 등록일
					
					menuDtoList.add(menuDto);	// 리스트에 추가
				}
				
			} catch(Exception e) {
				System.out.println("메뉴 목록을 조회하는 중 예외 발생함.");
				System.out.println("MemuDAO -> getMenuDTOList 메소드 확인 바람");
				e.printStackTrace();
			}
		}
		
		return menuDtoList;
	}
	
	// 메뉴 번호를 받아 해당 메뉴의 판매가를 반환하는 메소드
	public int getSalesPrice(int no) {
		System.out.println("MemuDAO -> getSalesPrice 메소드 호출");
		
		// 메뉴 가격을 담을 변수
		int sales_price = 0;
		
		// 메뉴 번호가 일치하는 메뉴의 가격을 받아오는 쿼리문
		String query = "SELECT sales_price FROM menu WHERE no=?";
		System.out.println("SQL 쿼리문: " + query);
		
		try {
			// 동적 쿼리문 생성
			psmt = con.prepareStatement(query);
			
			// 칼럼 값 채우기
			psmt.setInt(1, no);
			
			// 동적 쿼리문 실행
			rs = psmt.executeQuery();

			// PK로 설정된 no를 이용해 조회할 경우 반환되는 튜플은 1개이므로 반복(while)문으로 데이터를 가져올 필요 없음
			if(rs.next()) {
				sales_price = rs.getInt("sales_price");
			}
			
		} catch(Exception e) {
			System.out.println("메뉴 가격을 조회하는 중 예외 발생함.");
			System.out.println("MemuDAO -> getSalesPrice 메소드 확인 바람");
			e.printStackTrace();
		}
		
		return sales_price;
	}
	
	// 메뉴 번호와 수량 변경량을 받아 해당 메뉴의 재고를 변경하는 메소드
	public int updateStock(int no, int quantity) {
		System.out.println("MemuDAO -> updateStock 메소드 호출");
		
		// 결과값을 담을 변수
		int result = 0;
		
		// 메뉴 번호가 일치하는 메뉴의 재고를 변경하는 쿼리문
		String query = "UPDATE menu SET stock = stock + ?";
		query += " WHERE no = ?";
		System.out.println("SQL 쿼리문: " + query);
		
		try {
			// 동적 쿼리문 생성
			psmt = con.prepareStatement(query);
			
			// 칼럼 값 채우기
			psmt.setInt(1, quantity);
			psmt.setInt(2, no);

			// 동적 쿼리문 실행
			result = psmt.executeUpdate();
			
		} catch(Exception e) {
			System.out.println("메뉴 수량을 변경하는 중 예외 발생함.");
			System.out.println("MemuDAO -> updateStock 메소드 확인 바람");
			e.printStackTrace();
		}
		
		return result;
	}
	
	// 메뉴 번호를 받아 해당 상품의 정보를 반환하는 메소드
	public List<MenuDTO> getMenuDTO() {
		System.out.println("MemuDAO -> getMenuDTO 메소드 호출");

		List<MenuDTO> getMenuDTO = new Vector<MenuDTO>();

		// 상품 번호가 일치하는 메뉴를 찾는 쿼리문
		String query = "SELECT * FROM menu WHERE visibility = 'visible'";
		System.out.println("SQL 쿼리문: " + query);

		try {
			// 동적 쿼리문 생성
			psmt = con.prepareStatement(query);

			// 동적 쿼리문 실행
			rs = psmt.executeQuery();

			// PK로 설정된 no를 이용해 조회할 경우 반환되는 튜플은 1개이므로 반복(while)문으로 데이터를 가져올 필요 없음
			while (rs.next()) {
				MenuDTO menuDto = new MenuDTO();

				menuDto.setNo(rs.getInt("no")); // 메뉴 번호
				menuDto.setName_kor(rs.getString("name_kor")); // 메뉴명(한글)
				menuDto.setName_eng(rs.getString("name_eng")); // 메뉴명(영어)
				menuDto.setDescription(rs.getString("description")); // 메뉴 설명
				menuDto.setSales_price(rs.getInt("sales_price")); // 판매가
				menuDto.setStock(rs.getInt("stock")); // 재고
				menuDto.setVisibility(rs.getString("visibility")); // 표시 여부
				menuDto.setCategory_id(rs.getString("category_id")); // 카테고리 id
				menuDto.setRegist_date(rs.getDate("regist_date")); // 등록일

				getMenuDTO.add(menuDto);
			}

		} catch (Exception e) {
			System.out.println("메뉴 정보를 조회하는 중 예외 발생함.");
			System.out.println("MemuDAO -> getMenuDTO 메소드 확인 바람");
			e.printStackTrace();
		}

		return getMenuDTO;
	}
}
