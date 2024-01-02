package event;

public class EventDTO {
	
	//이벤트 게시글 변수
	private int no;						//이벤트 번호
	private String title;				//이벤트명
	private String memberId;			//작성자
	private java.sql.Date postDate;		//작성일
	private int visitCoutn;				//조회수
	private String visibility;			//표시 여부
	private java.sql.Date startDate;	//시작일
	private java.sql.Date endDate;		//종료일
	
	//getter & setter 메소드
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public java.sql.Date getPostDate() {
		return postDate;
	}
	public void setPostDate(java.sql.Date postDate) {
		this.postDate = postDate;
	}
	public int getVisitCoutn() {
		return visitCoutn;
	}
	public void setVisitCoutn(int visitCoutn) {
		this.visitCoutn = visitCoutn;
	}
	public String getVisibility() {
		return visibility;
	}
	public void setVisibility(String visibility) {
		this.visibility = visibility;
	}
	public java.sql.Date getStartDate() {
		return startDate;
	}
	public void setStartDate(java.sql.Date startDate) {
		this.startDate = startDate;
	}
	public java.sql.Date getEndDate() {
		return endDate;
	}
	public void setEndDate(java.sql.Date endDate) {
		this.endDate = endDate;
	}
	
	
	

}
