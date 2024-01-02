package review_board;

import java.util.List;
import java.util.Vector;

import javax.servlet.ServletContext;

import common.JDBConnect;

public class ReviewBoardDAO extends JDBConnect {
	
	// 생성자
	public ReviewBoardDAO(ServletContext application) {
		super(application);
		System.out.println("ReviewBoardDAO -> 생성자 호출");
	}
	
	// 메뉴 번호를 받아 해당 메뉴에 대해 작성된 리뷰 목록을 최신순으로 반환하는 메소드
	public List<ReviewBoardDTO> getOneMenuReviewsByLatest(int menu_no) {
		System.out.println("ReviewBoardDAO -> getOneMenuReviewsByLatest 메소드 호출");
		
		// 리뷰 목록을 담을 변수
		List<ReviewBoardDTO> oneMenuReviews = new Vector<ReviewBoardDTO>();
		
		// 리뷰 목록을 얻어오는 쿼리문
		String query = "SELECT * FROM review_board";
		query += " WHERE no IN";
		query += " (SELECT review_post_no FROM order_detail WHERE menu_no=? and review_post_no IS NOT NULL)";
		query += " ORDER BY post_date DESC";
		System.out.println("SQL 쿼리문: " + query);
		
		try {
			// 동적 쿼리문 생성
			psmt = con.prepareStatement(query);
			
			// 칼럼 값 채우기
			psmt.setInt(1, menu_no);
			
			// 동적 쿼리문 실행
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				ReviewBoardDTO reviewBoardDto = new ReviewBoardDTO();	// 메뉴 이미지 정보가 담길 객체
				
				reviewBoardDto.setNo(rs.getInt("no"));						// 리뷰 번호
				reviewBoardDto.setPost_date(rs.getDate("post_date"));		// 게시일
				reviewBoardDto.setRate(rs.getInt("rate"));					// 별점
				reviewBoardDto.setContent(rs.getString("content"));			// 내용
				reviewBoardDto.setVisibility(rs.getString("visibility"));	// 표시 여부
				reviewBoardDto.setMember_id(rs.getString("member_id"));		// 회원 id
				
				oneMenuReviews.add(reviewBoardDto);	// 리스트에 추가
			}
			
		} catch(Exception e) {
			System.out.println("리뷰 목록을 조회하는 중 예외 발생함.");
			System.out.println("ReviewBoardDAO -> getOneMenuReviewsByLatest 메소드 확인 바람");
			e.printStackTrace();
		}
		
		return oneMenuReviews;
	}

	// 메뉴 번호를 받아 해당 메뉴에 대해 작성된 리뷰 목록을 별점높은순으로 반환하는 메소드
	public List<ReviewBoardDTO> getOneMenuReviewsByHighest(int menu_no) {
		System.out.println("ReviewBoardDAO -> getOneMenuReviewsByHighest 메소드 호출");
		
		// 리뷰 목록을 담을 변수
		List<ReviewBoardDTO> oneMenuReviews = new Vector<ReviewBoardDTO>();
		
		// 리뷰 목록을 얻어오는 쿼리문
		String query = "SELECT * FROM review_board";
		query += " WHERE no IN";
		query += " (SELECT review_post_no FROM order_detail WHERE menu_no=? and review_post_no IS NOT NULL)";
		query += " ORDER BY rate DESC";
		System.out.println("SQL 쿼리문: " + query);
		
		try {
			// 동적 쿼리문 생성
			psmt = con.prepareStatement(query);
			
			// 칼럼 값 채우기
			psmt.setInt(1, menu_no);
			
			// 동적 쿼리문 실행
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				ReviewBoardDTO reviewBoardDto = new ReviewBoardDTO();	// 메뉴 이미지 정보가 담길 객체
				
				reviewBoardDto.setNo(rs.getInt("no"));						// 리뷰 번호
				reviewBoardDto.setPost_date(rs.getDate("post_date"));		// 게시일
				reviewBoardDto.setRate(rs.getInt("rate"));					// 별점
				reviewBoardDto.setContent(rs.getString("content"));			// 내용
				reviewBoardDto.setVisibility(rs.getString("visibility"));	// 표시 여부
				reviewBoardDto.setMember_id(rs.getString("member_id"));		// 회원 id
				
				oneMenuReviews.add(reviewBoardDto);	// 리스트에 추가
			}
			
		} catch(Exception e) {
			System.out.println("리뷰 목록을 조회하는 중 예외 발생함.");
			System.out.println("ReviewBoardDAO -> getOneMenuReviewsByHighest 메소드 확인 바람");
			e.printStackTrace();
		}
		
		return oneMenuReviews;
	}
	
	// 메뉴 번호를 받아 해당 메뉴에 대해 작성된 리뷰 목록을 별점낮은순으로 반환하는 메소드
	public List<ReviewBoardDTO> getOneMenuReviewsByLowest(int menu_no) {
		System.out.println("ReviewBoardDAO -> getOneMenuReviewsByLowest 메소드 호출");
		
		// 리뷰 목록을 담을 변수
		List<ReviewBoardDTO> oneMenuReviews = new Vector<ReviewBoardDTO>();
		
		// 리뷰 목록을 얻어오는 쿼리문
		String query = "SELECT * FROM review_board";
		query += " WHERE no IN";
		query += " (SELECT review_post_no FROM order_detail WHERE menu_no=? and review_post_no IS NOT NULL)";
		query += " ORDER BY rate ASC";
		System.out.println("SQL 쿼리문: " + query);
		
		try {
			// 동적 쿼리문 생성
			psmt = con.prepareStatement(query);
			
			// 칼럼 값 채우기
			psmt.setInt(1, menu_no);
			
			// 동적 쿼리문 실행
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				ReviewBoardDTO reviewBoardDto = new ReviewBoardDTO();	// 메뉴 이미지 정보가 담길 객체
				
				reviewBoardDto.setNo(rs.getInt("no"));						// 리뷰 번호
				reviewBoardDto.setPost_date(rs.getDate("post_date"));		// 게시일
				reviewBoardDto.setRate(rs.getInt("rate"));					// 별점
				reviewBoardDto.setContent(rs.getString("content"));			// 내용
				reviewBoardDto.setVisibility(rs.getString("visibility"));	// 표시 여부
				reviewBoardDto.setMember_id(rs.getString("member_id"));		// 회원 id
				
				oneMenuReviews.add(reviewBoardDto);	// 리스트에 추가
			}
			
		} catch(Exception e) {
			System.out.println("리뷰 목록을 조회하는 중 예외 발생함.");
			System.out.println("ReviewBoardDAO -> getOneMenuReviewsByLowest 메소드 확인 바람");
			e.printStackTrace();
		}
		
		return oneMenuReviews;
	}
	
	// 메뉴 번호를 받아 해당 메뉴에 대한 평균 별점을 반환하는 메소드
	public double getAverageRate(int menu_no) {
		System.out.println("ReviewBoardDAO -> getAverageRate 메소드 호출");
		
		// 평균 별점을 담을 변수
		double averageRate = 0;
		
		// 평균 별점을 구하는 쿼리문 (소수점 첫째 자리까지만)
		String query = "SELECT TRUNC(avg(rate), 1) FROM review_board";
		query += " WHERE no IN";
		query += " (SELECT review_post_no FROM order_detail WHERE menu_no=? and review_post_no IS NOT NULL)";
		System.out.println("SQL 쿼리문: " + query);
		
		try {
			// 동적 쿼리문 생성
			psmt = con.prepareStatement(query);
			
			// 칼럼 값 채우기
			psmt.setInt(1, menu_no);
			
			// 동적 쿼리문 실행
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				averageRate = rs.getDouble(1);
			}
			
		} catch(Exception e) {
			System.out.println("평균 별점을 조회하는 중 예외 발생함.");
			System.out.println("ReviewBoardDAO -> getOneMenuReviews 메소드 확인 바람");
			e.printStackTrace();
		}
		
		return averageRate;
	}
	
	// 메뉴 번호를 받아 해당 메뉴에 대한 별점별 리뷰 수를 반환하는 메소드
	public List<Integer> getCountByRate(int menu_no) {
		System.out.println("ReviewBoardDAO -> getCountByRate 메소드 호출");
		
		// 별점별 리뷰 개수 목록을 담을 변수
		List<Integer> reviewCountByRate = new Vector<Integer>();
		
		// 평균 별점을 구하는 쿼리문 (소수점 첫째 자리까지만)
		String query = "SELECT COUNT(*) FROM review_board";
		query += " WHERE rate = ?";
		query += " AND no in (SELECT review_post_no FROM order_detail WHERE menu_no=? and review_post_no IS NOT NULL)";
		
		System.out.println("SQL 쿼리문: " + query);
		
		try {
			for (int i=1; i<=5; i++) {
				// 동적 쿼리문 생성
				psmt = con.prepareStatement(query);
				
				// 칼럼 값 채우기
				psmt.setInt(1,  i);
				psmt.setInt(2, menu_no);
				
				// 동적 쿼리문 실행
				rs = psmt.executeQuery();
				
				if(rs.next()) {
					reviewCountByRate.add(rs.getInt(1));
				}
				
			}
		} catch(Exception e) {
				System.out.println("별점별 리뷰 수를 조회하는 중 예외 발생함.");
				System.out.println("ReviewBoardDAO -> getCountByRate 메소드 확인 바람");
				e.printStackTrace();
		}
		
		return reviewCountByRate;
	}
	
	// 작성된 리뷰
	public int insertContent(ReviewBoardDTO ReviewBoardDto) {
	
		System.out.println("ReviewBoardDAO -> insertContent 메서드 실행됨.");
		
		// 리뷰 작성 성공 여부 확인 (성공시 리뷰관리번호)
		int result = 0;
		
		String query = "INSERT INTO review_board (no, rate, content, member_id)";
			   query += " VALUES(";
			   query += "seq_review_board_no.nextval, ?, ?, ?)";
		
			   System.out.println("SQL 쿼리문: " + query);
	
		try {
			
			// 동적 쿼리문을 생성함.
			psmt = con.prepareStatement(query);
			
			// 컬럼의 값을 채워줌.
			psmt.setInt(1, ReviewBoardDto.getRate());
			psmt.setString(2, ReviewBoardDto.getContent());
			psmt.setString(3, ReviewBoardDto.getMember_id());
			
			// 동적 쿼리문을 실행함.
			result = psmt.executeUpdate();
			
			System.out.println("별점: " + ReviewBoardDto.getRate());
			System.out.println("내용: " + ReviewBoardDto.getContent());
			System.out.println("작성자: " + ReviewBoardDto.getMember_id());
			
			System.out.println("동적 쿼리 실행 결과: " + result);
			
			if (result == 1) {
				stmt = con.createStatement(); 	// 쿼리문을 생성함
				rs = stmt.executeQuery("select seq_review_board_no.CURRVAL FROM DUAL");
				if (rs.next()) {
					return rs.getInt(1);
				}
			}
			
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("게시글을 삽입 중 예외 발생함.");
			System.out.println("ReviewBoardDAO -> insertContent 메서드 확인.");
			System.out.println("동적 쿼리 실행 결과: " + result);
			e.printStackTrace();
		}
		
		return 0;
	}
	
	// 별점, 내용을 업데이트하기
	public int reviewUpdate(int rate, String content) {

		System.out.println("ReviewBoardDAO -> reviewUpdate 메서드 실행됨.");
		
		// 수정 결과를 담는 변수
		int result = 0;
		
		// 글 번호를 입력받아 해당 게시글을 수정하는 쿼리문 작성하기
		String query = "UPDATE review_board";
		query += " SET rate=?, content=?";
		query += " WHERE num=?";
	
		System.out.println("SQL 쿼리문: " + query);
		System.out.println("content: " + content);
	
		try {
		
			// 동적 쿼리문을 생성함.
			psmt = con.prepareStatement(query);
			
			// 컬럼의 값을 채워줌.
			psmt.setInt(1, rate);
			psmt.setString(2, content);
			
			// 동적 쿼리문을 실행함.
			result = psmt.executeUpdate();
			
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("게시글의 제목 및 내용을 수정하는 중 예외 발생함.");
			System.out.println("ReviewBoardDAO -> reviewUpdate 메서드 확인.");
			e.printStackTrace();
		}
		
		return result;
	}

}
