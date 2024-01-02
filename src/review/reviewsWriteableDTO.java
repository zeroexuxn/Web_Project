package review;

public class reviewsWriteableDTO {

	// 멤버 변수 선언
	private int no;
	private int menu_no;
	private String name_kor;		// 메뉴명
	private String option1_value;	// 옵션1	(ICE, HOT)
	private String option2_value;	// 옵션2	(Tall, Grande, Venti)
	private String member_id;
	
	// getter setter 메서드
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	
	public int getMenu_no() {
		return menu_no;
	}
	public void setMenu_no(int menu_no) {
		this.menu_no = menu_no;
	}
	public String getName_kor() {
		return name_kor;
	}
	public void setName_kor(String name_kor) {
		this.name_kor = name_kor;
	}
	
	public String getOption1_value() {
		return option1_value;
	}
	public void setOption1_value(String option1_value) {
		this.option1_value = option1_value;
	}
	public String getOption2_value() {
		return option2_value;
	}
	public void setOption2_value(String option2_value) {
		this.option2_value = option2_value;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	
}
