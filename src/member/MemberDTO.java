package member;

public class MemberDTO {

	private String id;
	private String password;
	private String name;
	private java.sql.Date join_date;
	private String email;
	private String tel;
	private java.sql.Date out_date;
	private String gender;
	private java.sql.Date birth;
	private String marketing_info_agree;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public java.sql.Date getJoin_date() {
		return join_date;
	}
	public void setJoin_date(java.sql.Date join_date) {
		this.join_date = join_date;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public java.sql.Date getOut_date() {
		return out_date;
	}
	public void setOut_date(java.sql.Date out_date) {
		this.out_date = out_date;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public java.sql.Date getBirth() {
		return birth;
	}
	public void setBirth(java.sql.Date birth) {
		this.birth = birth;
	}
	public String getMarketing_info_agree() {
		return marketing_info_agree;
	}
	public void setMarketing_info_agree(String marketing_info_agree) {
		this.marketing_info_agree = marketing_info_agree;
	}
}
