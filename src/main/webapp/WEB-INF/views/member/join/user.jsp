<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>개인회원 회원가입</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script>
// 	폼값 검증
	function validateForm(form) {
		if (form.id.value == '') {
			alert("아이디를 입력하세요.");
			form.id.focus();
			return false;
		}
	    if (form.idCheck.value !== "check") {
	        alert("아이디 중복체크를 진행하세요.");
	        form.idCheckBtn.focus();
	        return false;
	    }
		if (form.password.value == '') {
			alert("비밀번호를 입력하세요.");
			form.password.focus();
			return false;
		}
		if (form.password.value != form.passwordCheck.value) {
	        alert("비밀번호가 일치하지 않습니다.");
	        form.passwordCheck.focus();
	        return false;
	    } 
		var password_pattern =  /^[a-zA-Z0-9]{8,20}$/;
		if (!password_pattern.test(form.password.value)) {
		    alert("비밀번호는 영문자와 숫자가 포함되어야 하며, 8~20자여야 합니다.");
		    form.password.focus();
		    return false;
		}
		if (form.password.value == form.id.value) {
		    alert("비밀번호와 아이디는 일치할 수 없습니다.");
		    form.password.focus();
		    return false;
		}
		
		if (form.name.value == '') {
			alert("이름을 입력하세요.");
			form.name.focus();
			return false;
		}
		if (form.nickname.value == '') {
			alert("닉네임을 입력하세요.");
			form.name.focus();
			return false;
		}
		if (form.tel.value == '') {
			alert("전화번호를 입력하세요.");
			form.tel.focus();
			return false;
		}
		if (form.email.value == '') {
			alert("이메일을 입력하세요.");
			form.email.focus();
			return false;
		}
		if (form.address.value == '') {
			alert("주소를 입력하세요.");
			form.address.focus();
			return false;
		}
		if (form.rrn.value == '') {
			alert("주민등록번호를 입력하세요.");
			form.rrn.focus();
			return false;
		}
		
	    if (!form.terms1.checked) {
	        alert("약관에 동의해야 합니다.");
	        return false;
	    }
	    if (!form.terms2.checked) {
	        alert("약관에 동의해야 합니다.");
	        return false;
	    }
		return true;
	}
	
	
	// 아이디 중복 확인
	$(function() {
	    $.ajaxSetup({
	        url: "../../member/join/checkId.do",
	        dataType: "text",
	    });

	    $("#idCheckBtn").click(function() {
	        var join_id = $('input[name="id"]').val();
		  	var id_pattern =  /^[a-zA-Z0-9]{6,15}$/;
		  	
	      	// 아이디가 패턴에 맞지않으면 반려
	        if (!id_pattern.test(join_id)) {
	        	alert("아이디는 영문자와 숫자만 포함되어야 합니다.");
	        	$('input[name="id"]').focus();
		        return false;
	        }

	        $.ajax({
	            data: { join_id: join_id },
	            success: function(responseData) {
	                if (responseData === "0") {
	                    $("#idCheckResult").css("color","green").text("사용가능한 아이디");
	                    $('input[name="idCheck"]').val("check");
	                } else {
	                    $("#idCheckResult").css("color","red").text("사용할 수 없는 아이디");
	                    $('input[name="idCheck"]').val("unCheck");
	                }
	            },
	            error: function(errData) {
	                alert("실패: " + errData.status + " - " + errData.statusText);
	            }
	        });
	    });
	});

	
    // 닉네임 랜덤 생성
    $("#randomNickname").click(function() {
        $.ajax({
            url: "../../member/join/getNick.do",
            success: function(responseData) {
                // 서버에서 반환한 랜덤 문자열을 nickname 입력란에 설정
                $('input[name="nickname"]').val(responseData);
            },
            error: function(errData) {
                alert("닉네임 생성 실패: " + errData.status + " - " + errData.statusText);
            }
        });
    });
	
</script>
</head>
<body>
	<h2>개인회원 등록</h2>
	<form name="joinFrm" method="post" action="../../member/join/user.do" onsubmit="return validateForm(this);">
	<table border="1">
		<tr>
			<th>아이디</th>
			<td>
				<input type="text" name="id" value="" placeholder="아이디"/>
				<button type="button" name="idCheckBtn" id="idCheckBtn">중복 확인</button>
            	<span id="idCheckResult"></span><br> 
				<!-- 아이디 중복 확인 여부를 위한 hidden input태그 -->
            	<input type="hidden" name="idCheck" value="unCheck" />
			</td>
		</tr>
		<tr>
			<th>비밀번호</th>
			<td><input type="password" name="password" value="" placeholder="비밀번호"/></td>
		</tr>
		<tr>
			<th>비밀번호 확인</th>
			<td><input type="password" name="passwordCheck" value="" placeholder="비밀번호 확인"/></td>
		</tr>
		<tr>
			<th>이름</th>
			<td><input type="text" name="name" value="" placeholder="이름"/></td>
		</tr>
		<tr>
			<th>닉네임</th>
			<td>
				<input type="text" name="nickname" value="" placeholder="닉네임"/>
				<button type="button" name="randomNickname" id="randomNickname">닉네임 생성</button>
			</td>
			
		</tr>
		<tr>
			<th>전화번호</th>
			<td><input type="tel" name="tel" value="" placeholder="ex) 010-0000-0000"/></td>
		</tr>
		<tr>
			<th>이메일</th>
			<td><input type="email" name="email" value="" placeholder="ex) abcd@naver.com"/></td>
		</tr>
		<tr>
			<th>주소</th>
			<td><input type="text" name="address" value="" placeholder="주소"/></td>
		</tr>
		<tr>
			<th>주민등록번호</th>
			<td><input type="text" name="rrn" value="" placeholder="주민등록번호"/></td>
		</tr>
		<tr>
		    <th>약관동의</th>
		    <td>
		        <p>약관1 (필수)</p>
		        <input type="checkbox" name="terms1" value="yes" />
		        <p>약관2 (필수)</p>
		        <input type="checkbox" name="terms2" value="yes" />
		    </td>
		</tr>
	</table>
	<input type="submit" value="회원가입" />
	</form>
</body>
</html>