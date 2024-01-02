<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="utils.JSFunction"%>
<title>회원가입 | Ryanbucks Korea</title>

<link href="../common/css/reset.css" rel="stylesheet"> <!-- 헤더, 푸터 -->
<link href="../common/css/style_main.css" rel="stylesheet"> <!-- 헤더, 푸터 -->
<link href="/RYANBUCKS_v1.0/common/img/logo.png" rel="short icon" type="image/ico">

	<script type="text/javascript">
	    function updateDomain() {
	        var selectedDomain = document.getElementById("selectDomainEmail").value;
	        document.getElementById("domainEmail").value = selectedDomain;
	    }
	</script>
	<script>
		function checker() {
		    var pwd = document.getElementById("password").value;
		    var cpwd = document.getElementById("check_password").value;
		    var submit_button = document.getElementById("subB");
		    var check_td = document.getElementById("check_td");
	
		    if (cpwd == "") {
		        check_td.innerHTML = "";
		    } else if (pwd == cpwd) {
		        check_td.innerHTML = "<font color='green'>일치</font>";
		        submit_button.disabled = false;
		    } else {
		        check_td.innerHTML = "<font color='red'>불일치</font>";
		        submit_button.disabled = true;
		    }
		}
	</script>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
	    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
	    function sample4_execDaumPostcode() {
	        new daum.Postcode({
	            oncomplete: function(data) {
	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var roadAddr = data.roadAddress; // 도로명 주소 변수
	                var extraRoadAddr = ''; // 참고 항목 변수
	
	                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                    extraRoadAddr += data.bname;
	                }
	                // 건물명이 있고, 공동주택일 경우 추가한다.
	                if(data.buildingName !== '' && data.apartment === 'Y'){
	                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                }
	                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                if(extraRoadAddr !== ''){
	                    extraRoadAddr = ' (' + extraRoadAddr + ')';
	                }
	
	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                document.getElementById('sample4_postcode').value = data.zonecode;
	                document.getElementById("sample4_roadAddress").value = roadAddr;
	                
	                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
	                if(roadAddr != ''){
	                    document.getElementById("sample4_extraAddress").value = extraRoadAddr;
	                } else {
	                    document.getElementById("sample4_extraAddress").value = '';
	                }

	            }
	        }).open();
	    }
	</script>
	<script>
		function backhome(){// 이미지를 클릭했을 때 실행할 함수
	        window.location.href = 'login.jsp'; // ./login/login.jsp 로 이동
		}
	</script>
	<jsp:include page="/header.jsp" />
	<link href="../common/css/join_style.css" rel="stylesheet" class="join_form">
	<div class="join_wrap">
		<!-- 이미지 -->
		<div class="logo_img" onclick="backhome()"></div>
		<!-- /이미지 -->
		<!-- 환영합니다 -->
		<p class="text_justjoin">회원가입</p>
		<p class="text_guide">
			회원가입을 위한 정보 입력 및 약관 동의를 진행합니다.
		</p>
		<!-- 2. 게시물 목록 -->
		<form action="join_process.jsp" method="post">
		    <table class="main_table">
		        <tr>
		            <td class="first_table">
		                <div class="label-group">
		                    <label for="name">이름</label>
		                </div>
		            </td>
		            <td class="second_table">
		                <input type="text" class="input_box" id="name" name="name" required>
		            </td>
		        </tr>
		        <tr>
		            <td class="first_table">
		                <div class="label-group">
		                    <label for="id">아이디</label>
		                </div>
		            </td>
		            <td class="second_table">
		                <input type="text" class="input_box" id="id" name="id" required>
		            </td>
		        </tr>
		        <tr>
		            <td class="first_table">
		                <div class="label-group">
		                    <span>비밀번호</span>
		                </div>
		            </td>
		            <td class="second_table">
		                <input type="password" class="input_box" id="password" name="password" onkeyup="checker()" required>
		            </td>
		        </tr>
		        <tr>
		            <td class="first_table">
		                <div class="label-group">
		                    <label for="check_password">비밀번호 확인</label>
		                </div>
		            </td>
		            <td class="second_table">
		                <input type="password" class="input_box" id="check_password" onkeyup="checker()" required>
		            	<label id="check_td"></label>
		            </td> 
		        </tr>
		        <tr>
		            <td class="first_table">
		                <div class="label-group">
		                    <label for="birth">생년월일 / 성별</label>
		                </div>
		            </td>
		            <td class="second_table">
		                <input type="date" class="input_box" id="birth" name="birth">
		         		<label>남<input type="radio" class="birth_radio_btn" name="gender" value="M" required></label>
						<label>여<input type="radio" class="birth_radio_btn" name="gender" value="F" required></label>
		            
		            </td>
		        </tr>
		        <tr>
		            <td class="first_table">
		                <div class="label-group">
		                    <label for="email">이메일</label>
		                </div>
		            </td>
		            <td class="second_table">
		                <input type="text" class="input_box" id="usernameEmail" name="usernameEmail">
		                @
		                <input type="text" class="input_box" id="domainEmail" name="domainEmail">
						<select name="selectDomainEmail" class="select_box" id="selectDomainEmail" onchange="updateDomain()">
						    <option value="naver.com">naver.com</option>
						    <option value="gmail.com">gmail.com</option>
						    <option value="hanmail.net">hanmail.net</option>
						</select>
		            </td>
		        </tr>
		        <tr>
		            <td class="first_table">
		                <div class="label-group">
		                    <label for="phone">연락처</label>
		                </div>
		            </td>
		            <td class="second_table">
		            	<select class="select_box" id="countryTel" name="countryTel" required>
					        <option value="010">010</option>
					        <option value="011">011</option>
					        <option value="016">016</option>
					        <option value="010">017</option>
					        <option value="011">019</option>
						</select>
						-
						<input type="text" class="input_box" id="areaTel" name="areaTel" required>
						-
    					<input type="text" class="input_box" id="userTel" name="userTel" required>
		            </td>
		        </tr>
		        <tr>
		            <td class="first_table">
		                <div class="label-group">
		                    <label for="post_code">주소</label>
		                </div>
		            </td>
		            <td class="second_table">
		                <input type="text" class="input_box" id="sample4_postcode" placeholder="우편번호" name="post_code" onclick="sample4_execDaumPostcode()">
		                <input type="button" class="input_box" id="sample4_btn" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
		                <input type="text" class="input_box" id="sample4_roadAddress" placeholder="도로명주소" name="road_address" onclick="sample4_execDaumPostcode()">
		                <span id="guide" style="color:#999;display:none"></span>
		                <br>
						<input type="text" class="input_box" id="sample4_detailAddress" placeholder="상세주소" name="detail_address" >
						<input type="text" class="input_box" id="sample4_extraAddress" placeholder="참고항목" name="extra_address" onclick="sample4_execDaumPostcode()">
		            </td>
		        </tr>
		        <tr>
		        	<td colspan="2">
		        		<div class="table_agree">
		        			<span class="agree-check"><input type="checkbox" name="mem_agreement" id="mem_agreement" class="mem" required></span>
							<h5 class="text_agree">홈페이지 이용약관 동의<span class="type_green">(필수)</span></h5>
							<a href="javascript:void(0)" target="_blank">약관 전체보기 <img src="//image.aladin.co.kr/img/account/2019/new_window.png" alt="새창열기"></a>
						</div>
					</td>
				<tr>
					<td colspan="2">	
						<div class="table_agree">
							<span class="agree-check"><input type="checkbox" name="mem_purpose" id="mem_purpose" class="mem" required></span>
							<h5 class="text_agree">개인정보 수집 및 동의<span class="type_green">(필수)</span></h5>
							<a href="javascript:void(0)" target="_blank">약관 전체보기 <img src="//image.aladin.co.kr/img/account/2019/new_window.png" alt="새창열기"></a>
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<div class="table_agree">
							<span class="agree-check"><input type="checkbox" name="marketing_info_agree" id="marketing_info_agree" class="mem"></span>
							<h5 class="text_agree">광고성 정보 수신동의<span class="type_green">(선택)</span></h5>
							<a href="javascript:void(0)" target="_blank">약관 전체보기 <img src="//image.aladin.co.kr/img/account/2019/new_window.png" alt="새창열기"></a>
						</div>
					</td>
				</tr>
				<tr>
				    <td colspan="2">
				        <input type=submit class="join_btn" onclick="joinChecker()" id="subB" value="가입">
				    </td>
				</tr>
			</table>
		</form>
	</div>
<jsp:include page="/footer.jsp" />	
