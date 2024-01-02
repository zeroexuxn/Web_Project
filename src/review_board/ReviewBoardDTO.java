package review_board;

public class ReviewBoardDTO {
	private int no;
	private java.sql.Date post_date;
	private int rate;
	private String content;
	private String visibility;
	private String member_id;
	
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public java.sql.Date getPost_date() {
		return post_date;
	}
	public void setPost_date(java.sql.Date post_date) {
		this.post_date = post_date;
	}
	public int getRate() {
		return rate;
	}
	public void setRate(int rate) {
		this.rate = rate;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getVisibility() {
		return visibility;
	}
	public void setVisibility(String visibility) {
		this.visibility = visibility;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
}
