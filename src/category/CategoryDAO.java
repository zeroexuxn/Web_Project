package category;

import java.util.List;
import java.util.Vector;

import javax.servlet.ServletContext;

import common.JDBConnect;

public class CategoryDAO extends JDBConnect {

	// 생성자
	public CategoryDAO(ServletContext application) {
		super(application);
	}
		
	// 유형 불러오기(drink or food)
	public List<CategoryDTO> categoryTypeImport(String type) {
		System.out.println(type);
		
		System.out.println("CategoryDAO -> categoryTypeImport 메서드 실행됨.");
		
		// 유형을 담을 변수
		List<CategoryDTO> vector = new  Vector<CategoryDTO>();
		
		// 유형을 얻어오는 쿼리문 작성하기
		String query = "SELECT * FROM category";
		
		if(type != null) {
			query += " WHERE type='" + type + "'";
		}
		
		try {
			stmt = con.createStatement(); 	// 쿼리문을 생성함
			rs = stmt.executeQuery(query);	// 쿼리문을 실행함.
			
			while(rs.next()) {	// 커서를 이동하면서
				
				CategoryDTO categoryDto = new CategoryDTO();
				
				categoryDto.setId(rs.getString("id"));
				
				categoryDto.setType(rs.getString("type"));
				
				categoryDto.setName(rs.getString("name"));
				
				categoryDto.setVisibility(rs.getString("visibility"));;	
				
				vector.add(categoryDto);
			}
			
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("카테고리를 조회하는 중 예외 발생함.");
			System.out.println("CategoryDAO -> categoryTypeImport 메서드 확인.");
			e.printStackTrace();
		}
		return vector;
		
	}

	// 카테고리 ID를 받아 해당 카테고리 정보를 반환하는 메소드
	public CategoryDTO getCategoryDTO(String id) {
		System.out.println("CategoryDAO -> getCategoryDTO 메소드 호출");
		
		// 카테고리 정보가 담길 CategoryDTO 객체
		CategoryDTO categoryDto = new CategoryDTO();
		
		// 카테고리 ID가 일치하는 메뉴를 찾는 쿼리문
		String query = "SELECT * FROM category WHERE id=?";
		System.out.println("SQL 쿼리문: " + query);
		
		try {
			// 동적 쿼리문 생성
			psmt = con.prepareStatement(query);
			
			// 칼럼 값 채우기
			psmt.setString(1, id);
			
			// 동적 쿼리문 실행
			rs = psmt.executeQuery();

			// PK로 설정된 id를 이용해 조회할 경우 반환되는 튜플은 1개이므로 반복(while)문으로 데이터를 가져올 필요 없음
			if(rs.next()) {
				categoryDto.setId(rs.getString("id"));					// 카테고리 id
				categoryDto.setType(rs.getString("type"));				// 메뉴 유형
				categoryDto.setName(rs.getString("name"));				// 카테고리명
				categoryDto.setVisibility(rs.getString("visibility"));	// 표시 여부
			}
			
		} catch(Exception e) {
			System.out.println("카테고리 정보를 조회하는 중 예외 발생함.");
			System.out.println("CategoryDAO -> getCategoryDTO 메소드 확인 바람");
			e.printStackTrace();
		}
		
		return categoryDto;
	}
	
}
