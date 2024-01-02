package menu_option;

import java.util.List;
import java.util.Vector;

import javax.servlet.ServletContext;

import common.JDBConnect;
import order_detail.OrderDetailDTO;

public class MenuOptionDAO extends JDBConnect {
	
	// 생성자
	public MenuOptionDAO(ServletContext application) {
		super(application);
		System.out.println("MenuOptionDAO -> 생성자 호출");
	}
	
	// 메뉴 번호를 받아 해당 상품의 옵션 목록을 반환하는 메소드
	public List<MenuOptionDTO> getOneMenuOptions (int menu_no) {
		System.out.println("MenuOptionDAO -> getOneMenuOptions 메소드 호출");
		
		// 옵션 목록을 담을 변수
		List<MenuOptionDTO> oneMenuOptions = new Vector<MenuOptionDTO>();
		
		// 옵션 목록을 얻어오는 쿼리문
		String query = "SELECT * FROM menu_option";
		query += " WHERE menu_no=? AND visibility IS NOT NULL AND visibility='visible'";
		System.out.println("SQL 쿼리문: " + query);
		
		try {
			// 동적 쿼리문 생성
			psmt = con.prepareStatement(query);
			
			// 칼럼 값 채우기
			psmt.setInt(1, menu_no);
			
			// 동적 쿼리문 실행
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				MenuOptionDTO menuOptionDto = new MenuOptionDTO();	// 메뉴 옵션 정보가 담길 객체
				
				menuOptionDto.setNo(rs.getInt("no"));							// 옵션 번호
				menuOptionDto.setMenu_no(rs.getInt("menu_no"));					// 메뉴 번호
				menuOptionDto.setOption1_name(rs.getString("option1_name"));	// 옵션1 이름
				menuOptionDto.setOption1_value(rs.getString("option1_value"));	// 옵션1 값
				menuOptionDto.setOption2_name(rs.getString("option2_name"));	// 옵션2 이름
				menuOptionDto.setOption2_value(rs.getString("option2_value"));	// 옵션2 값
				menuOptionDto.setPrice(rs.getInt("price"));						// 옵션 가격
				menuOptionDto.setStock(rs.getInt("stock"));						// 옵션 재고
				menuOptionDto.setVisibility(rs.getString("visibility"));		// 옵션 표시 여부

				oneMenuOptions.add(menuOptionDto);	// 리스트에 추가
			}
			
		} catch(Exception e) {
			System.out.println("메뉴 옵션 목록을 조회하는 중 예외 발생함.");
			System.out.println("MenuOptionDAO -> getOneMenuOptions 메소드 확인 바람");
			e.printStackTrace();
		}
		
		return oneMenuOptions;
	}
	
	// OrderDetail 객체의 리스트를 받아 옵션 번호가 일치하는 MenuOptionDTO 리스트를 반환하는 메소드
	public List<MenuOptionDTO> getMenuOptionDTOList(List<OrderDetailDTO> orderDetailDtoList) {
		System.out.println("MenuOptionDAO -> getMenuOptionDTOList 메소드 호출");
		
		// 메뉴 이미지 목록을 담을 변수
		List<MenuOptionDTO> menuOptionDtoList = new Vector<MenuOptionDTO>();
		
		// 옵션 번호가 일치하는 데이터를 찾는 쿼리문
		String query = "SELECT * from menu_option";
		query += " WHERE no = ?";
		System.out.println("SQL 쿼리문: " + query);
		
		for(OrderDetailDTO orderDetailDto : orderDetailDtoList) {
			try {
				if(orderDetailDto.getOption_no() == 0) {
					menuOptionDtoList.add(null);	// 리스트에 추가
				}
				
				// 동적 쿼리문 생성
				psmt = con.prepareStatement(query);
				
				// 칼럼 값 채우기
				psmt.setInt(1, orderDetailDto.getOption_no());
				
				// 동적 쿼리문 실행
				rs = psmt.executeQuery();
		
				// 각 옵션번호는 PK이므로 반복문 사용 안함
				if(rs.next()) {
					MenuOptionDTO menuOptionDto = new MenuOptionDTO();	// 메뉴 옵션 객체
					
					menuOptionDto.setNo(rs.getInt("no"));							// 옵션 번호
					menuOptionDto.setMenu_no(rs.getInt("menu_no"));					// 메뉴 번호
					menuOptionDto.setOption1_name(rs.getString("option1_name"));	// 옵션1 이름
					menuOptionDto.setOption1_value(rs.getString("option1_value"));	// 옵션1 값
					menuOptionDto.setOption2_name(rs.getString("option2_name"));	// 옵션2 이름
					menuOptionDto.setOption2_value(rs.getString("option2_value"));	// 옵션2 값
					menuOptionDto.setPrice(rs.getInt("price"));						// 옵션 가격
					menuOptionDto.setStock(rs.getInt("stock"));						// 옵션 재고
					menuOptionDto.setVisibility(rs.getString("visibility"));		// 옵션 표시 여부
					
					menuOptionDtoList.add(menuOptionDto);	// 리스트에 추가
				}
				
			} catch(Exception e) {
				System.out.println("메뉴 옵션 목록을 조회하는 중 예외 발생함.");
				System.out.println("MenuOptionDAO -> getMenuOptionDTOList 메소드 확인 바람");
				e.printStackTrace();
			}
		}
		
		return menuOptionDtoList;
	}
	
	// 옵션 번호를 받아 해당 옵션의 가격을 반환하는 메소드
	public int getPrice(int no) {
		System.out.println("MenuOptionDAO -> getPrice 메소드 호출");
		
		// 옵션 가격을 담을 변수
		int price = 0;
		
		// 옵션 번호가 일치하는 메뉴의 가격을 받아오는 쿼리문
		String query = "SELECT price FROM menu_option WHERE no=?";
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
				price = rs.getInt("price");
			}
			
		} catch(Exception e) {
			System.out.println("메뉴 가격을 조회하는 중 예외 발생함.");
			System.out.println("MemuDAO -> getSalesPrice 메소드 확인 바람");
			e.printStackTrace();
		}
		
		return price;
	}
	
	// 옵션 번호와 수량 변경량을 받아 해당 옵션의 재고를 변경하는 메소드
	public int updateStock(int no, int quantity) {
		System.out.println("MenuOptionDAO -> updateStock 메소드 호출 " + no + " /// " + quantity);
		
		// 결과값을 담을 변수
		int result = 0;
		
		// 옵션 번호가 일치하는 메뉴의 재고를 변경하는 쿼리문
		String query = "UPDATE menu_option SET stock = stock + ?";
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
			System.out.println("옵션 수량을 변경하는 중 예외 발생함.");
			System.out.println("MenuOptionDAO -> updateStock 메소드 확인 바람");
			e.printStackTrace();
		}
		
		return result;
	}

	// 카트 번호를 받아 해당 상품의 옵션 목록을 반환하는 메소드
	public List<MenuOptionDTO> getCartMenuOptions () {
		System.out.println("MenuOptionDAO -> getCartMenuOptions 메소드 호출");
		
		// 옵션 목록을 담을 변수
		List<MenuOptionDTO> CartMenuOptions = new Vector<MenuOptionDTO>();
		
		// 옵션 목록을 얻어오는 쿼리문
		String query = "SELECT * FROM menu_option";
		query += " WHERE visibility IS NOT NULL AND visibility='visible'";
		System.out.println("SQL 쿼리문: " + query);
		
		try {
			// 동적 쿼리문 생성
			psmt = con.prepareStatement(query);
			
			
			// 동적 쿼리문 실행
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				MenuOptionDTO menuOptionDto = new MenuOptionDTO();	// 메뉴 옵션 정보가 담길 객체
				
				menuOptionDto.setNo(rs.getInt("no"));							// 옵션 번호
				menuOptionDto.setMenu_no(rs.getInt("menu_no"));					// 메뉴 번호
				menuOptionDto.setOption1_name(rs.getString("option1_name"));	// 옵션1 이름
				menuOptionDto.setOption1_value(rs.getString("option1_value"));	// 옵션1 값
				menuOptionDto.setOption2_name(rs.getString("option2_name"));	// 옵션2 이름
				menuOptionDto.setOption2_value(rs.getString("option2_value"));	// 옵션2 값
				menuOptionDto.setPrice(rs.getInt("price"));						// 옵션 가격
				menuOptionDto.setStock(rs.getInt("stock"));						// 옵션 재고
				menuOptionDto.setVisibility(rs.getString("visibility"));		// 옵션 표시 여부

				CartMenuOptions.add(menuOptionDto);	// 리스트에 추가
			}
			
		} catch(Exception e) {
			System.out.println("메뉴 옵션 목록을 조회하는 중 예외 발생함.");
			System.out.println("MenuOptionDAO -> getCartMenuOptions 메소드 확인 바람");
			e.printStackTrace();
		}
		
		return CartMenuOptions;
	}
	
	//옵션 번호를 입력받아 해당 메뉴 옵션 객체를 반환하는 메소드
	public MenuOptionDTO getMenuOptionDto(int optionNo) {
		System.out.println("MenuOptionDAO.getMenuOptionDto 메소드 실행");
		
		//메뉴 옵션 정보를 담을 객체
		MenuOptionDTO menuOptionDto=new MenuOptionDTO();
		
		//메뉴 번호가 일치하는 메뉴 옵션 정보 불러오는 쿼리문 작성
		String query="select * from menu_option where no=?";
		
		try {
			// 동적 쿼리문 생성
			psmt = con.prepareStatement(query);
			
			// 칼럼 값 채우기
			psmt.setInt(1, optionNo);
			
			// 동적 쿼리문 실행
			rs = psmt.executeQuery();

			
			if(rs.next()) {
				//옵션 번호 저장
				menuOptionDto.setNo(rs.getInt("no"));
				//메뉴 번호 저장
				menuOptionDto.setMenu_no(rs.getInt("menu_no"));
				//옵션1 이름 저장
				menuOptionDto.setOption1_name(rs.getString("option1_name"));
				//옵션1 값 저장
				menuOptionDto.setOption1_value(rs.getString("option1_value"));
				//옵션2 이름 저장
				menuOptionDto.setOption2_name(rs.getString("option2_name"));
				//옵션2 값 저장
				menuOptionDto.setOption2_value(rs.getString("option2_value"));
				//옵션 가격 저장
				menuOptionDto.setPrice(rs.getInt("price"));
				//옵션 재고 저장
				menuOptionDto.setStock(rs.getInt("stock"));
				//표시 여부 저장
				menuOptionDto.setVisibility(rs.getString("visibility"));
			}
			
		} catch(Exception e) {
			System.out.println("옵션 정보를 조회하는 중 예외 발생함.");
			System.out.println("MemuOptionDAO -> getMenuOptionDTO 메소드 확인 바람");
			e.printStackTrace();
		}
		
		return menuOptionDto;
	}

}
