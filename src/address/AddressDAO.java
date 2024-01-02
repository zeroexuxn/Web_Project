package address;

import java.util.List;
import java.util.Vector;

import javax.servlet.ServletContext;

import common.JDBConnect;

public class AddressDAO extends JDBConnect {

	// 생성자
	public AddressDAO(ServletContext application) {
		super(application);
		System.out.println("AddressDAO -> 생성자 호출");
	}
	
	// 회원 ID를 받아 해당 회원의 주소 1건을 반환하는 메소드
	public AddressDTO getAddressDto(String id) {
		System.out.println("AddressDAO -> getAddressDto 메소드 호출");
		
		// 주소 정보를 담을 변수
		AddressDTO addressDto = new AddressDTO();
		
		// 회원의 주소 목록을 얻어오는 쿼리문
		String query = "SELECT * FROM address";
		query += " WHERE id = ?";
		System.out.println("SQL 쿼리문: " + query);
		
		try {
			// 동적 쿼리문 생성
			psmt = con.prepareStatement(query);
			
			// 칼럼 값 채우기
			psmt.setString(1, id);
			
			// 동적 쿼리문 실행
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				addressDto.setId(rs.getString("id"));							// id
				addressDto.setName(rs.getString("name"));						// 주소지명
				addressDto.setPost_code(rs.getString("post_code"));				// 우편번호
				addressDto.setRoad_address(rs.getString("road_address"));		// 도로명 주소
				addressDto.setDetail_address(rs.getString("detail_address"));	// 상세 주소
			}
			
		} catch(Exception e) {
			System.out.println("주소 목록을 조회하는 중 예외 발생함.");
			System.out.println("AddressDAO -> getAddressDto 메소드 확인 바람");
			e.printStackTrace();
		}
		
		return addressDto;
	}
	
	
	// 회원 ID를 받아 해당 회원의 주소 목록을 반환하는 메소드
	public List<AddressDTO> getAddressList(String id) {
		System.out.println("AddressDAO -> getAddressList 메소드 호출");
		
		// 회원의 주소 목록을 담을 변수
		List<AddressDTO> addressList = new Vector<AddressDTO>();
		
		// 회원의 주소 목록을 얻어오는 쿼리문
		String query = "SELECT * FROM address";
		query += " WHERE id = ?";
		System.out.println("SQL 쿼리문: " + query);
		
		try {
			// 동적 쿼리문 생성
			psmt = con.prepareStatement(query);
			
			// 칼럼 값 채우기
			psmt.setString(1, id);
			
			// 동적 쿼리문 실행
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				AddressDTO addressDto = new AddressDTO();	// 주소 정보가 담길 객체
				
				addressDto.setId(rs.getString("id"));		// id
				addressDto.setName(rs.getString("name"));	// 주소지명
				addressDto.setPost_code(rs.getString("post_code"));				// 우편번호
				addressDto.setRoad_address(rs.getString("road_address"));		// 도로명 주소
				addressDto.setDetail_address(rs.getString("detail_address"));	// 상세 주소
				
				addressList.add(addressDto);	// 리스트에 추가
			}
			
		} catch(Exception e) {
			System.out.println("주소 목록을 조회하는 중 예외 발생함.");
			System.out.println("AddressDAO -> getAddressList 메소드 확인 바람");
			e.printStackTrace();
		}
		
		return addressList;
	}
	
	
}
