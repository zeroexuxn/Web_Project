package member;

import javax.servlet.ServletContext;

import common.JDBConnect;

public class MemberDAO extends JDBConnect {
	
	// 생성자
	public MemberDAO(ServletContext application) {
		super(application);
	}
	
	// 회원 Id를 받아 해당 회원의 이름을 반환하는 메소드
	public String getName(String id) {
		System.out.println("MemberDAO -> getName 메서드 실행됨.");
		
		String name = ""; // 이름을 저장할 변수
		
		// 회원 이름을 얻어오는 쿼리문 작성하기
		String query = "SELECT name FROM member";
		query += " WHERE id = ?";
		System.out.println("SQL 쿼리문: " + query);
		
		try {
			// 동적 쿼리문 생성
			psmt = con.prepareStatement(query);
			
			// 칼럼 값 채우기
			psmt.setString(1, id);
			
			// 동적 쿼리문 실행
			rs = psmt.executeQuery();
			
			// PK로 설정된 no를 이용해 조회할 경우 반환되는 튜플은 1개이므로 반복(while)문으로 데이터를 가져올 필요 없음
			if(rs.next()) {
				name = rs.getString("name");
			}
			
		} catch(Exception e) {
			System.out.println("이름을 조회하는 중 예외 발생함.");
			System.out.println("MemberDAO -> getName 메소드 확인 바람");
			e.printStackTrace();
		}
		
		return name;
	}

	// 회원 Id를 받아 해당 회원의 연락처를 반환하는 메소드
	public String getTel(String id) {
		System.out.println("MemberDAO -> getTel 메서드 실행됨.");
		
		String tel = ""; // 연락처를 저장할 변수
		
		// 연락처를 얻어오는 쿼리문 작성하기
		String query = "SELECT tel FROM member";
		query += " WHERE id = ?";
		System.out.println("SQL 쿼리문: " + query);
		
		try {
			// 동적 쿼리문 생성
			psmt = con.prepareStatement(query);
			
			// 칼럼 값 채우기
			psmt.setString(1, id);
			
			// 동적 쿼리문 실행
			rs = psmt.executeQuery();
			
			// PK로 설정된 no를 이용해 조회할 경우 반환되는 튜플은 1개이므로 반복(while)문으로 데이터를 가져올 필요 없음
			if(rs.next()) {
				tel = rs.getString("tel");
			}
			
		} catch(Exception e) {
			System.out.println("연락처를 조회하는 중 예외 발생함.");
			System.out.println("MemberDAO -> getTel 메소드 확인 바람");
			e.printStackTrace();
		}

		return tel;
	}
	
	// 회원 Id를 받아 해당 회원의 이메일 주소를 반환하는 메소드
	public String getEmail(String id) {
		System.out.println("MemberDAO -> getEmail 메서드 실행됨.");
		
		String email = ""; // 이메일 주소를 저장할 변수
		
		// 이메일 주소를 얻어오는 쿼리문 작성하기
		String query = "SELECT email FROM member";
		query += " WHERE id = ?";
		System.out.println("SQL 쿼리문: " + query);
		
		try {
			// 동적 쿼리문 생성
			psmt = con.prepareStatement(query);
			
			// 칼럼 값 채우기
			psmt.setString(1, id);
			
			// 동적 쿼리문 실행
			rs = psmt.executeQuery();
			
			// PK로 설정된 no를 이용해 조회할 경우 반환되는 튜플은 1개이므로 반복(while)문으로 데이터를 가져올 필요 없음
			if(rs.next()) {
				email = rs.getString("email");
			}
			
		} catch(Exception e) {
			System.out.println("이메일 주소를 조회하는 중 예외 발생함.");
			System.out.println("MemberDAO -> getEmail 메소드 확인 바람");
			e.printStackTrace();
		}
		
		return email;
	}
}
