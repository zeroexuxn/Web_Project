package menu_image;

import java.util.List;
import java.util.Vector;

import javax.servlet.ServletContext;

import common.JDBConnect;
import order_detail.OrderDetailDTO;

public class MenuImageDAO extends JDBConnect {
	// 생성자
	public MenuImageDAO(ServletContext application) {
		super(application);
	}

	// 대표 이미지 불러오기
	public List<MenuImageDTO> selectList() {
			
		System.out.println("MenuImageDTO -> selectList 메서드 실행됨.");
		
		// 카테고리 Id를 담을 변수
		List<MenuImageDTO> vector = new  Vector<MenuImageDTO>();
		
		// 카테고리 Id을 얻어오는 쿼리문 작성하기
		String query = "SELECT * FROM menu_image";
		query += " WHERE type='representative'";
		
		
		try {
			stmt = con.createStatement(); 	// 쿼리문을 생성함
			rs = stmt.executeQuery(query);	// 쿼리문을 실행함.
			
			while(rs.next()) {	// 커서를 이동하면서
				
				MenuImageDTO menuimageDto = new MenuImageDTO();
				
				menuimageDto.setMenu_no(rs.getInt("menu_no"));
				menuimageDto.setFile_name(rs.getString("file_name"));				
				menuimageDto.setType(rs.getString("type"));
				
				vector.add(menuimageDto);
			}
			
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("카테고리를 조회하는 중 예외 발생함.");
			System.out.println("MenuImageDAO -> selectList 메서드 확인.");
			e.printStackTrace();
		}
		return vector;
		
	}

	
	// 메뉴 번호를 받아 해당 메뉴의 이미지를 목록을 반환하는 메소드
	public List<MenuImageDTO> getOneMenuImages(int menu_no) {
		System.out.println("MenuImageDAO -> getOneMenuImages 메소드 호출");
		
		// 메뉴 이미지 목록을 담을 변수
		List<MenuImageDTO> oneMenuImages = new Vector<MenuImageDTO>();
		
		// 메뉴 이미지 목록을 얻어오는 쿼리문
		String query = "SELECT * FROM menu_image";
		query += " WHERE menu_no=?";
		query += " ORDER BY type";
		System.out.println("SQL 쿼리문: " + query);
		
		try {
			// 동적 쿼리문 생성
			psmt = con.prepareStatement(query);
			
			// 칼럼 값 채우기
			psmt.setInt(1, menu_no);
			
			// 동적 쿼리문 실행
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				MenuImageDTO menuImageDto = new MenuImageDTO();	// 메뉴 이미지 정보가 담길 객체
				
				menuImageDto.setMenu_no(rs.getInt("menu_no"));			// 메뉴 번호
				menuImageDto.setFile_name(rs.getString("file_name"));	// 이미지 파일명
				menuImageDto.setType(rs.getString("type"));				// 이미지 타입
				
				oneMenuImages.add(menuImageDto);	// 리스트에 추가
			}
			
		} catch(Exception e) {
			System.out.println("메뉴 이미지 목록을 조회하는 중 예외 발생함.");
			System.out.println("MenuImageDAO -> getOneMenuImages 메소드 확인 바람");
			e.printStackTrace();
		}
		
		return oneMenuImages;
	}
	
	// OrderDetail 객체의 리스트를 받아 해당 메뉴 번호가 일치하는 MenuImageDTO 리스트를 반환하는 메소드
	public List<MenuImageDTO> getMenuImageDTOList(List<OrderDetailDTO> orderDetailDtoList) {
		System.out.println("MenuImageDAO -> getMenuImageDTOList 메소드 호출");
		
		// 메뉴 이미지 목록을 담을 변수
		List<MenuImageDTO> menuDtoList = new Vector<MenuImageDTO>();
		
		// 메뉴 번호가 일치하는 메뉴 대표 이미지를 찾는 쿼리문
		String query = "SELECT * FROM menu_image";
		query += " WHERE menu_no = ? AND type='representative'";
		System.out.println("SQL 쿼리문: " + query);
		
		for(OrderDetailDTO orderDetailDto : orderDetailDtoList) {
			try {
				// 동적 쿼리문 생성
				psmt = con.prepareStatement(query);
				
				// 칼럼 값 채우기
				psmt.setInt(1, orderDetailDto.getMenu_no());
				
				// 동적 쿼리문 실행
				rs = psmt.executeQuery();
				
				// 각 메뉴번호는 PK이고, 메뉴별 대표 이미지는 1개이므로 반복문(while)은 사용하지 않음
				if(rs.next()) {
					MenuImageDTO menuImageDto = new MenuImageDTO();	// 메뉴 이미지 정보를 담을 MenuImageDTO 객체
					
					menuImageDto.setMenu_no(rs.getInt("menu_no"));
					menuImageDto.setFile_name(rs.getString("file_name"));
					menuImageDto.setType(rs.getString("type"));
					
					menuDtoList.add(menuImageDto);	// 리스트에 추가
				}
				
			} catch(Exception e) {
				System.out.println("메뉴 이미지 목록을 조회하는 중 예외 발생함.");
				System.out.println("MenuImageDAO -> getMenuImageDTOList 메소드 확인 바람");
				e.printStackTrace();
			}
			
		}

		return menuDtoList;
	}
	
	// 메뉴 번호를 받아 해당 메뉴의 이미지를 목록을 반환하는 메소드
	public List<MenuImageDTO> getOneMenuImages() {
		System.out.println("MenuImageDAO -> getOneMenuImages 메소드 호출");
		
		// 메뉴 이미지 목록을 담을 변수
		List<MenuImageDTO> oneMenuImages = new Vector<MenuImageDTO>();
		
		// 메뉴 이미지 목록을 얻어오는 쿼리문
		String query = "SELECT * FROM menu_image";
			   query += " WHERE type='representative'";
		System.out.println("SQL 쿼리문: " + query);
		
		try {
			// 동적 쿼리문 생성
			psmt = con.prepareStatement(query);
			
			// 칼럼 값 채우기
			
			// 동적 쿼리문 실행
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				MenuImageDTO menuImageDto = new MenuImageDTO();	// 메뉴 이미지 정보가 담길 객체
				
				menuImageDto.setMenu_no(rs.getInt("menu_no"));			// 메뉴 번호
				menuImageDto.setFile_name(rs.getString("file_name"));	// 이미지 파일명
				menuImageDto.setType(rs.getString("type"));				// 이미지 타입
				
				oneMenuImages.add(menuImageDto);	// 리스트에 추가
			}
			
		} catch(Exception e) {
			System.out.println("메뉴 이미지 목록을 조회하는 중 예외 발생함.");
			System.out.println("MenuImageDAO -> getOneMenuImages 메소드 확인 바람");
			e.printStackTrace();
		}
		
		return oneMenuImages;
	}
	
	//메뉴 번호를 입력받아 해당 메뉴 이미지 객체를 반환하는 메소드
	public MenuImageDTO selectDetailMenuImage(int menuNo) {
		System.out.println("MenuImageDAO.selectDetailMenuImage 메소드 실행");
		
		//메뉴 이미지 상세정보를 담을 객체
		MenuImageDTO menuImageDto=new MenuImageDTO();
		
		//메뉴번호를 입력받아 해당 메뉴 이미지 불러올 쿼리문 작성
		String query="select * from menu_image where menu_no=? and type='representative'";
		
		try {
			
			//동적 쿼리문 생성
			psmt=con.prepareStatement(query);
			
			//칼럼 값 집어넣기
			psmt.setInt(1, menuNo);
			
			//동적 쿼리문 실행
			rs=psmt.executeQuery();
			
			//해당 메뉴 이미지 정보 존재 유무 확인
			if(rs.next()) {
				//메뉴 번호 저장
				menuImageDto.setMenu_no(rs.getInt("menu_no"));
				//파일명 저장
				menuImageDto.setFile_name(rs.getString("file_name"));
				//유형 저장
				menuImageDto.setType(rs.getString("type"));
			}
			
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("메뉴 이미지 정보 확인중 에러 발생!!");
			System.out.println("에러 발생 위치: MenuImageDAO.selectDetailMenuImage 메소드");
			e.printStackTrace();
		}
		
		return menuImageDto;
		
	}
	
}