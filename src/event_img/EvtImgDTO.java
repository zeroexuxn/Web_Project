package event_img;

public class EvtImgDTO {
	
	private int eventPostNo;		//이벤트 게시글 번호
	private String fileName;		//파일 이름
	private String type;			//파일 유형(썸네일 or 내용)
	
	//getter & setter 메소드
	public int getEventPostNo() {
		return eventPostNo;
	}
	public void setEventPostNo(int eventPostNo) {
		this.eventPostNo = eventPostNo;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	
	

}
