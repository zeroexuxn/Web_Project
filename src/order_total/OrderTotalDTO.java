package order_total;

public class OrderTotalDTO {
	private String id;
	private java.sql.Timestamp order_date;
	private String member_id;
	private String recipient_name;
	private String recipient_tel;
	private String recipient_email;
	private String type;
	private String post_code;
	private String road_address;
	private String detail_address;
	private String pickup_branch;
	private java.sql.Timestamp pickup_time;
	private int amount;
	private String pay_method;
	private String card_name;
	private String card_no;
	private String card_quota;
	private String auth_code;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public java.sql.Timestamp getOrder_date() {
		return order_date;
	}
	public void setOrder_date(java.sql.Timestamp order_date) {
		this.order_date = order_date;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getRecipient_name() {
		return recipient_name;
	}
	public void setRecipient_name(String recipient_name) {
		this.recipient_name = recipient_name;
	}
	public String getRecipient_tel() {
		return recipient_tel;
	}
	public void setRecipient_tel(String recipient_tel) {
		this.recipient_tel = recipient_tel;
	}
	public String getRecipient_email() {
		return recipient_email;
	}
	public void setRecipient_email(String recipient_email) {
		this.recipient_email = recipient_email;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getPost_code() {
		return post_code;
	}
	public void setPost_code(String post_code) {
		this.post_code = post_code;
	}
	public String getRoad_address() {
		return road_address;
	}
	public void setRoad_address(String road_address) {
		this.road_address = road_address;
	}
	public String getDetail_address() {
		return detail_address;
	}
	public void setDetail_address(String detail_address) {
		this.detail_address = detail_address;
	}
	public String getPickup_branch() {
		return pickup_branch;
	}
	public void setPickup_branch(String pickup_branch) {
		this.pickup_branch = pickup_branch;
	}
	public java.sql.Timestamp getPickup_time() {
		return pickup_time;
	}
	public void setPickup_time(java.sql.Timestamp pickup_time) {
		this.pickup_time = pickup_time;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	public String getPay_method() {
		return pay_method;
	}
	public void setPay_method(String pay_method) {
		this.pay_method = pay_method;
	}
	public String getCard_name() {
		return card_name;
	}
	public void setCard_name(String card_name) {
		this.card_name = card_name;
	}
	public String getCard_no() {
		return card_no;
	}
	public void setCard_no(String card_no) {
		this.card_no = card_no;
	}
	public String getCard_quota() {
		return card_quota;
	}
	public void setCard_quota(String card_quota) {
		this.card_quota = card_quota;
	}
	public String getAuth_code() {
		return auth_code;
	}
	public void setAuth_code(String auth_code) {
		this.auth_code = auth_code;
	}
}
