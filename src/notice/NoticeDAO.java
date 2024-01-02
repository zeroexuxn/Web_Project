package notice;


import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.servlet.ServletContext;

import common.JDBConnect;

public class NoticeDAO extends JDBConnect {
	
	//생성자
	public NoticeDAO(ServletContext application) {
		super(application);
		// TODO Auto-generated constructor stub
	}
	
	//게시글 목록을 리스트로 반환하는 메소드
	public List<NoticeDTO> selectlist(Map<String, Object> map){
		System.out.println("noticeDAO.selectlist 메소드 실행");
		
		//게시글 목록을 담을 변수
		List<NoticeDTO> bbs=new Vector<NoticeDTO>();
		
		//게시글 목록을 얻어오는 쿼리문 작성
		String query="select * from notice_board";
		if(map.get("search_word")!=null) {//검색어가 있을 경우
			query+=" where title like '%"+map.get("search_word")+"%' order by no desc";
		}else {//검색어가 없을 경우
			query+=" order by no desc";
		}
		
		try {
			stmt=con.createStatement();//쿼리문 생성
			rs=stmt.executeQuery(query);//쿼리문 실행
			while(rs.next()) {//커서 이동 (다음줄이 비어있지 않으면)
				
				//게시글 한 행의 내용 noticeDTO에 저장
				NoticeDTO noticeDto=new NoticeDTO();
				//게시글 번호(no) 저장
				noticeDto.setNo(rs.getInt("no"));
				//제목(title) 저장
				noticeDto.setTitle(rs.getString("title"));
				//내용(content) 저장
				noticeDto.setContent(rs.getString("content"));
				//등록일(postDate) 저장
				noticeDto.setPostDate(rs.getDate("post_date"));
				//조회수(visitCount) 저장
				noticeDto.setVisitCount(rs.getInt("visit_count"));
				//표시 여부(visibility) 저장
				noticeDto.setVisibility(rs.getString("visibility"));
				
				//게시글 목록 저장
				bbs.add(noticeDto);
			}
		} catch (Exception e) {//오류 발생 시
			// TODO: handle exception
			System.out.println("게시글 목록 조회 중 에러 발생!!");
			System.out.println("에러 발생 위치: noticeDAO.selectList 메소드");
			e.printStackTrace();
		}
		
		return bbs;
	}
	
	//게시글 수를 얻어오는 메소드
	public int selectCount(Map<String, Object> map) {
		
		System.out.println("NoticeDAO.selectCount 메소드 실행");
		
		//게시글 수를 담을 변수
		int totalCount=0;
		
		//게시글 수를 얻어오는 쿼리문 작성
		String query="select count(*) from notice_board";
		if(map.get("search_word")!=null) {//검색어가 있으면
			query+=" where title like '%"+map.get("search_word")+"%'";
		}
		
		try {
			stmt=con.createStatement();// 쿼리문 생성
			rs=stmt.executeQuery(query);// 쿼리문 실행
			rs.next();// 커서 첫번째 행으로 이동
			totalCount=rs.getInt(1);// 첫번째 칼럼 저장
			
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("게시물 수를 구하는 중 에러 발생!!");
			System.out.println("에러 발생 위치: NoticeDAO.selectCount 메소드");
			e.printStackTrace();
		}
		
		System.out.println("totalCount: "+totalCount);
		return totalCount;
	}
	
	//글 번호를 입력받아 해당 게시글 내용 보여주는 메소드
	public NoticeDTO selectDetailList(int no) {
		
		System.out.println("NoticeDAO.selectDetailList 메소드 실행");
		
		//게시글 상세내용을 저장하는 객체
		NoticeDTO noticeDto=new NoticeDTO();
		
		// 글 번호를 입력받아 게시물 번호를 얻어오는 쿼리문 작성
		String query="select * from notice_board where no=?";
		
		try {
			
			//동적 쿼리문 생성
			psmt=con.prepareStatement(query);
			
			//칼럼 값 넣기
			psmt.setInt(1, no);
			
			//동적 쿼리문 실행
			rs=psmt.executeQuery();
			
			//해당하는 게시글 존재유무 확인
			if (rs.next()) {//게시글이 존재한다면
				//게시글 번호(no) 저장
				noticeDto.setNo(rs.getInt("no"));
				//제목(title) 저장
				noticeDto.setTitle(rs.getString("title"));
				//내용(content) 저장
				noticeDto.setContent(rs.getString("content"));
				//등록일(postDate) 저장
				noticeDto.setPostDate(rs.getDate("post_date"));
				//조회수(visitCount) 저장
				noticeDto.setVisitCount(rs.getInt("visit_count"));
				//표시 여부(visibility) 저장
				noticeDto.setVisibility(rs.getString("visibility"));
			}
			
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("게시글 상세내용 확인중 에러 발생!!");
			System.out.println("에러 발생 위치: NoticeDAO.selectDetailList 메소드");
			e.printStackTrace();
		}
		
		return noticeDto;
	}
	
	//클릭한 게시글 조회수 1 증가시키는 메소드
	public int updateVisitCount(int num) {
		
		System.out.println("NoticeDAO.updateVisitCount 메소드 실행");
		
		// 조회수 1 증가한 결과를 담는 변수 
		int result=0;
		
		// 조회수 1씩 증가하는 쿼리문 작성
		String query="update notice_board set visit_count=visit_count+1 where no=?";
		
		try {
			// 동적 쿼리문 생성
			psmt=con.prepareStatement(query);
			
			// 칼럼 값 넣기
			psmt.setInt(1, num);
			
			// 동적 쿼리문 실행
			result=psmt.executeUpdate();
			
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("조회수 수정중 에러 발생!!");
			System.out.println("에러 발생 위치: NoticeDAO.updateVisitCount 메소드");
			e.printStackTrace();
		}
		
		return result;
	}
	
	//글 번호를 입력받아 해당 게시글 삭제
	public int deleteList(int no) {
		System.out.println("NoticeDAO.deleteList 메소드 실행");
		
		//삭제 결과 담을 변수
		int result=0;
		
		// 글 번호를 입력받아 해당 게시글 삭제하는 쿼리문 작성
				String query="delete from notice_board where num=?";
				
				System.out.println("sql query: "+query);
				
				try {
					// 동적 쿼리문 생성
					psmt=con.prepareStatement(query);
					
					// 칼럼 값 넣기
					psmt.setInt(1, no);
					
					System.out.println("no: "+no);
					
					// 동적 쿼리문 실행
					result=psmt.executeUpdate();
					
				} catch (Exception e) {
					// TODO: handle exception
					System.out.println("게시물 삭제중 에러 발생!!");
					System.out.println("에러 발생 위치: NoticeDAO.deleteList 메소드");
					e.printStackTrace();
				}
				
				return result;		
	}
	
	// 게시글의 제목 및 내용 수정
	public int updateList(int no, String title, String content) {
			
			System.out.println("NoticeDAO.updateList 메소드 실행");
			
			// 수정 결과를 담는 변수
			int result=0;
			
			// 글 번호를 입력받아 해당 게시글을 수정하는 쿼리문 작성
			String query="update notice_board set title=?, content=? where num=?";
			
			System.out.println("sql query: "+query);
			System.out.println("new title: "+title);
			System.out.println("new content: "+content);
			System.out.println("no: "+no);
			
			try {
				// 동적 쿼리문 생성
				psmt=con.prepareStatement(query);
				
				// 칼럼 값 넣기
				psmt.setString(1, title);
				psmt.setString(2, content);
				psmt.setInt(3, no);
				
				// 동적 쿼리문 실행
				result=psmt.executeUpdate();
				
			} catch (Exception e) {
				// TODO: handle exception
				System.out.println("게시물 수정중 에러 발생!!");
				System.out.println("에러 발생 위치: NoticeDAO.updateList 메소드");
				e.printStackTrace();
			}
			
			return result;
		}
	
}
