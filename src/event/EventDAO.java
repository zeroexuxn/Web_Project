package event;

import java.util.List;

import java.util.Vector;

import javax.servlet.ServletContext;

import common.JDBConnect;


public class EventDAO extends JDBConnect{

	//생성자
	public EventDAO(ServletContext application) {
		super(application);
		// TODO Auto-generated constructor stub
	}
	
	//진행중인 이벤트 목록을 리스트로 반환하는 메소드
	public List<EventDTO> selectlist(){
		System.out.println("EventDAO.selectlist 메소드 실행");
		
		//게시글 목록을 담을 변수
		List<EventDTO> bbs=new Vector<EventDTO>();
		
		//게시글 목록을 얻어오는 쿼리문 작성
		String query="select * from event_board where end_date > sysdate";
		
		try {
			stmt=con.createStatement();//쿼리문 생성
			rs=stmt.executeQuery(query);//쿼리문 실행
			while(rs.next()) {//커서 이동 (다음줄이 비어있지 않으면)
				
				//게시글 한 행의 내용 EventDTO에 저장
				EventDTO eventDto=new EventDTO();
				//이벤트 번호(no) 저장
				eventDto.setNo(rs.getInt("no"));
				//이벤트 제목(title) 저장
				eventDto.setTitle(rs.getString("title"));
				//작성자ID (member_id) 저장
				eventDto.setMemberId(rs.getString("member_id"));
				//등록일(post_date) 저장
				eventDto.setPostDate(rs.getDate("post_date"));
				//조회수(visit_count) 저장
				eventDto.setVisitCoutn(rs.getInt("visit_count"));
				//표시 여부(visibility) 저장
				eventDto.setVisibility(rs.getString("visibility"));
				//시작일(start_date) 저장
				eventDto.setStartDate(rs.getDate("start_date"));
				//종료일(end_date) 저장
				eventDto.setEndDate(rs.getDate("end_date"));
				
				
				//게시글 목록 저장
				bbs.add(eventDto);
			}
		} catch (Exception e) {//오류 발생 시
			// TODO: handle exception
			System.out.println("이벤트 목록 조회 중 에러 발생!!");
			System.out.println("에러 발생 위치: EventDAO.selectList 메소드");
			e.printStackTrace();
		}
		
		return bbs;
	}
	
	//종료된 이벤트 목록을 리스트로 반환하는 메소드
	public List<EventDTO> selectEndedList(){
		System.out.println("EventDAO.selectEndedlist 메소드 실행");
		
		//게시글 목록을 담을 변수
		List<EventDTO> bbs=new Vector<EventDTO>();
		
		//게시글 목록을 얻어오는 쿼리문 작성
		String query="select * from event_board where end_date < sysdate";
		
		try {
			stmt=con.createStatement();//쿼리문 생성
			rs=stmt.executeQuery(query);//쿼리문 실행
			while(rs.next()) {//커서 이동 (다음줄이 비어있지 않으면)
				
				//게시글 한 행의 내용 EventDTO에 저장
				EventDTO eventDto=new EventDTO();
				//이벤트 번호(no) 저장
				eventDto.setNo(rs.getInt("no"));
				//이벤트 제목(title) 저장
				eventDto.setTitle(rs.getString("title"));
				//작성자ID (member_id) 저장
				eventDto.setMemberId(rs.getString("member_id"));
				//등록일(post_date) 저장
				eventDto.setPostDate(rs.getDate("post_date"));
				//조회수(visit_count) 저장
				eventDto.setVisitCoutn(rs.getInt("visit_count"));
				//표시 여부(visibility) 저장
				eventDto.setVisibility(rs.getString("visibility"));
				//시작일(start_date) 저장
				eventDto.setStartDate(rs.getDate("start_date"));
				//종료일(end_date) 저장
				eventDto.setEndDate(rs.getDate("end_date"));
				
				
				//게시글 목록 저장
				bbs.add(eventDto);
			}
		} catch (Exception e) {//오류 발생 시
			// TODO: handle exception
			System.out.println("이벤트 목록 조회 중 에러 발생!!");
			System.out.println("에러 발생 위치: EventDAO.selectEndedList 메소드");
			e.printStackTrace();
		}
		
		return bbs;
	}
	
	//이벤트 번호를 받아서 해당 이벤트 정보를 담은 객체 반환 메소드
	public EventDTO getEventDTO(int eventNo) {
		System.out.println("EventDAO.getEventDTO 메소드 실행");
		
		//이벤트 정보가 담길 객체
		EventDTO eventDto=new EventDTO();
		
		//이벤트 번호가 일치하는 이벤트를 찾는 쿼리문 작성
		String query="select * from event_board where no=?";
		
		try {
			//동적 쿼리문 생성
			psmt=con.prepareStatement(query);
						
			//칼럼 값 채우기
			psmt.setInt(1, eventNo);
						
			//동적 쿼리문 실행
			rs=psmt.executeQuery();
			
			//해당 이벤트 존재유무 확인
			if (rs.next()) {
				//이벤트 번호 저장
				eventDto.setNo(rs.getInt("no"));
				//이벤트 제목 저장
				eventDto.setTitle(rs.getString("title"));
				//작성자 ID 저장
				eventDto.setMemberId(rs.getString("member_id"));
				//등록일 저장
				eventDto.setPostDate(rs.getDate("post_date"));
				//조회수 저장
				eventDto.setVisitCoutn(rs.getInt("visit_count"));
				//표시 여부 저장
				eventDto.setVisibility(rs.getString("visibility"));
				//시작일 저장
				eventDto.setStartDate(rs.getDate("start_date"));
				//종료일 저장
				eventDto.setEndDate(rs.getDate("end_date"));
			}
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("이벤트 객체 반환중 에러 발생!!");
			System.out.println("에러 발생 위치: EventDAO.getEventDTO 메소드");
			e.printStackTrace();
		}
		
		return eventDto;
	}
	
	//이벤트 번호를 전달받은 이벤트의 조회수 1씩 증가시키는 메소드
	public int updateVisitCount(int eventNo) {
		System.out.println("EventDAO.updateVisitCount 메소드 실행");
		
		//조회수 증가 결과를 담을 변수
		int result=0;
		
		//조회수를 1 증가시키는 쿼리문 작성
		String query="update event_board set visit_count=visit_count+1 where no=?";
		
		try {
			// 동적 쿼리문 생성
			psmt=con.prepareStatement(query);
			
			// 칼럼 값 넣기
			psmt.setInt(1, eventNo);
			
			// 동적 쿼리문 실행
			result=psmt.executeUpdate();
			
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("조회수 수정중 에러 발생!!");
			System.out.println("에러 발생 위치: EventDAO.updateVisitCount 메소드");
			e.printStackTrace();
		}
		
		return result;
	}
	
	

}
