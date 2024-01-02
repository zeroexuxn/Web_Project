package review;

import java.util.List;
import java.util.Vector;

import javax.servlet.ServletContext;

import common.JDBConnect;

public class reviewsWriteableDAO extends JDBConnect {
	
	public reviewsWriteableDAO(ServletContext application) {
		super(application);
	}

	// 리뷰가 작성되어 있지 않은 메뉴만 가져오기
	public List<reviewsWriteableDTO> reviewNotWrite(String member_id) {
		
		System.out.println("reviewsWriteableDAO -> reviewNotWrite 메서드 실행됨.");
		
		// 리뷰가 작성되어 있지 않은 메뉴를 담을 변수
		List<reviewsWriteableDTO> vector = new  Vector<reviewsWriteableDTO>();
		
		// 리뷰가 작성되어 있지 않은 메뉴를 얻어오는 쿼리문 작성하기
		String query = "SELECT * FROM writeable_review WHERE member_id='"+ member_id + "'";
			   		
		
		try {
			stmt = con.createStatement(); 	// 쿼리문을 생성함
			rs = stmt.executeQuery(query);	// 쿼리문을 실행함.
			
			while(rs.next()) {	// 커서를 이동하면서
				
				reviewsWriteableDTO writeable_reviewDto = new reviewsWriteableDTO();
				
				writeable_reviewDto.setNo(rs.getInt("no"));
				
				writeable_reviewDto.setMenu_no(rs.getInt("menu_no"));
				
				writeable_reviewDto.setName_kor(rs.getString("name_kor"));
				
				writeable_reviewDto.setOption1_value(rs.getString("option1_value"));
				
				writeable_reviewDto.setOption2_value(rs.getString("option2_value"));
				
				writeable_reviewDto.setMember_id(rs.getString("member_id"));
				
				vector.add(writeable_reviewDto);
			}
			
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("리뷰를 작성하지 않은 메뉴를 조회하는 중 예외 발생함.");
			System.out.println("reviewsWriteableDAO -> reviewNotWrite 메서드 확인.");
			e.printStackTrace();
		}
		
		
		return vector;
		
	}

}
