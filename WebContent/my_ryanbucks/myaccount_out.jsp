<%@page import="utils.JSFunction"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<meta charset="UTF-8">

<title>My Ryanbucks | Ryanbucks Korea</title>

<link href="../common/css/reset.css" rel="stylesheet"> <!-- 헤더, 푸터 -->
<link href="../common/css/style_main.css" rel="stylesheet"> <!-- 헤더, 푸터 -->
<link href="/RYANBUCKS_v1.0/common/img/logo.png" rel="short icon" type="image/ico">
<script>
    function outChecker() {
        var out_agree = document.getElementById("out_agree").checked;
        
        if (out_agree) {
             form.submit(); // 값 전달
        } else {
            alert('모든 필수 항목에 동의해주세요.');
        }
    }
</script>
<script>
    function backhome(){
        window.location.href = '../login/login.jsp';
    }
</script>

<jsp:include page="/header.jsp" />
<link href="../common/css/myaccount_out_style.css" rel="stylesheet">
<%
    // 로그아웃 했을 때
    if(session.getAttribute("id") == null) {
%>
	<script>window.location.href = '../login/login.jsp';</script>
<%
    } else {
%>

<div class="myaccount_out_wrap">
	<form method="post" action="myaccount_out_process.jsp" name="frmOut" onsubmit="return validateForm(this);" class="myaccount_out_form"> <!-- validate -->
		<!-- 이미지 -->
		<div class="logo_img" onclick="backhome()"></div>
		<!-- /이미지 -->
		<!-- 환영합니다 -->
		<p class="text_justaccountout">회원탈퇴</p>
	    <div>
	        <div class="container">
	            <table>
	                <tr>
	                    <td>
	                        <label id="out_terms_text">회원탈퇴시 유의사항</label><br>
	                        <textarea id="out_terms" name="terms" rows="10" cols="50" readonly>
								RYANBUCKS 회원탈퇴 약관
								
								이 약관은 RYANBUCKS 회원탈퇴 절차 및 조건을 규정합니다.
								
								회원탈퇴 절차
								
								회원은 서비스 내 "회원탈퇴" 기능을 이용하여 탈퇴할 수 있습니다.
								탈퇴 시, 회원정보와 관련된 모든 데이터는 영구적으로 삭제됩니다.
								회원탈퇴 시 유의사항
								
								회원탈퇴 시, 현재 진행 중인 서비스는 모두 중단되며, 이전 내역은 복구할 수 없습니다.
								탈퇴 이후 재가입을 원할 경우, 새로운 회원정보로 가입해야 합니다.
								책임 및 보안
								
								회원은 탈퇴 전에 개인정보의 보안을 유지해야 합니다. 탈퇴 후 발생하는 문제에 대한 책임은 회원 본인에게 있습니다.
								기타
								
								본 약관은 언제든지 수정될 수 있으며, 수정 시 본 페이지에 공지됩니다.
								회원은 변경된 약관을 숙지하고 동의하여야 다시 가입할 수 있습니다.
							</textarea>
	                    </td>
	                </tr>
	                <tr>
	                    <td id="myaccount_out_check">
	                    	<input type="checkbox" name="out_agree" id="out_agree" class="mem" required>
	                    	<label id="out_agree_text">모든 회원탈퇴 절차 및 유의사항을 숙지하였으며, 이에 동의합니다.</label>
	                    </td>    
	                </tr>
	                <tr>
	                    <td colspan="2" class="myaccount_out_agree_btn_table">
	                        <input type=submit onclick="outChecker()" value="회원 탈퇴" id="myaccount_out_agree_btn">
	                    </td>
	                </tr>
	            </table>
	        </div>
	    </div>
    </form>
</div>
<%
	}
%>

<jsp:include page="/footer.jsp" />