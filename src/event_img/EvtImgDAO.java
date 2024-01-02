package event_img;

import java.util.List;
import java.util.Vector;

import javax.servlet.ServletContext;

import common.JDBConnect;

public class EvtImgDAO extends JDBConnect {

	public EvtImgDAO(ServletContext application) {
		super(application);
		// TODO Auto-generated constructor stub
	}
	
	//썸네일 리스트로 반환하는 메소드 
	public List<EvtImgDTO> selectList(){
		System.out.println("EvtImgDAO.selectList 메소드 실행");
		
		//썸네일 리스트를 담을 변수
		List<EvtImgDTO> bbs=new  Vector<EvtImgDTO>();
		
		//썸네일 리스트 가져올 쿼리문 작성
		String query="select * from event_image where type='thumnail'";
		
		try {
			stmt=con.createStatement();//쿼리문 생성
			rs=stmt.executeQuery(query);//쿼리문 실행
			while(rs.next()) {//커서 이동 (다음줄이 비어있지 않으면)
				
				//게시글 한 행의 내용 noticeDTO에 저장
				EvtImgDTO evtImgDto=new EvtImgDTO();
				//이벤트 번호 저장
				evtImgDto.setEventPostNo(rs.getInt("event_post_no"));
				//파일명 저장
				evtImgDto.setFileName(rs.getString("file_name"));
				//유형 저장
				evtImgDto.setType(rs.getString("type"));
				
				//게시글 목록 저장
				bbs.add(evtImgDto);
			}
		} catch (Exception e) {//오류 발생 시
			// TODO: handle exception
			System.out.println("썸네일 목록 조회 중 에러 발생!!");
			System.out.println("에러 발생 위치: EvtImgDAO.selectList 메소드");
			e.printStackTrace();
		}
		
		return bbs;				
				
	}
	
	//이벤트 번호와 타입을 입력받아 해당 이벤트 번호를 가진 이벤트 이미지 객체를 반환하는 메소드
	public EvtImgDTO selectEventImage(int eventNo, String type) {
		System.out.println("EvtImgDAO.selectDetailEventImage 메소드 실행");
			
		//반환할 이벤트 이미지 객체
		EvtImgDTO evtImgDto=new EvtImgDTO();
			
		//해당 이벤트 이미지 정보를 불러올 쿼리문 작성
		// 조건절 no에서 event_post_no로 수정: 박수연(2023/11/01)
		String query="select * from event_image where event_post_no=? and type=?";
			
		try {
				
			//동적 쿼리문 생성
			psmt=con.prepareStatement(query);
				
			//칼럼 값 집어넣기
			psmt.setInt(1, eventNo);
			psmt.setString(2, type);
				
				
			//동적 쿼리문 실행
			rs=psmt.executeQuery();
				
			//해당 메뉴 이미지 정보 존재 유무 확인
			if(rs.next()) {
				//이벤트 번호 저장
				evtImgDto.setEventPostNo(rs.getInt("event_post_no"));
				//파일명 저장
				evtImgDto.setFileName(rs.getString("file_name"));
				//유형 저장
				evtImgDto.setType(rs.getString("type"));
			}
				
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("이벤트 이미지 정보 확인중 에러 발생!!");
			System.out.println("에러 발생 위치: EvtImgDAO.selectDetailEventImage 메소드");
			e.printStackTrace();
		}
			
		return evtImgDto;
			
	}
	
	
	

	
}
