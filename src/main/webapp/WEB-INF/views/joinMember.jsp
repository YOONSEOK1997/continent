<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script>
  $(function() {
    // 주민번호 확인
    $('#sn2').blur(function() {
      const sn1 = $('#sn1').val();
      const sn2 = $('#sn2').val();

      // 유효성 검사
      if (sn1.length !== 6 || sn2.length !== 7 || isNaN(sn1) || isNaN(sn2)) {
        alert("주민번호 형식을 확인하세요.");
        return;
      }

      const fullSn = sn1 + sn2;

      $.ajax({
        url: 'http://localhost:9999/isSn/' + fullSn,
        type: 'get',
        success: function(data) {
          alert(data);
          if (data === true || data === 'true') {
            alert('주민번호 인증 성공');

            // 성별 계산
            let genderCode = Number(sn2.substr(0, 1));
            $('#gender').val(genderCode % 2 === 0 ? '여' : '남');

            // 출생년도 계산
            let yearPrefix;
            if (genderCode === 1 || genderCode === 2 || genderCode === 5 || genderCode === 6) {
              yearPrefix = 1900;
            } else if (genderCode === 3 || genderCode === 4 || genderCode === 7 || genderCode === 8) {
              yearPrefix = 2000;
            } else {
              alert("알 수 없는 주민번호 형식입니다.");
              return;
            }

            let birthYear = yearPrefix + Number(sn1.substr(0, 2));
            let thisYear = new Date().getFullYear();
            let age = thisYear - birthYear;
            $('#age').val(age);
          } else {
            alert('주민번호 인증 실패');
          }
        },
        error: function(err) {
          console.log("에러 발생:", err);
        }
      });
    });

    // ID 중복 체크
    $('#idckBtn').click(function() {
      const id = $('#idck').val();
      if (!id) {
        alert('ID를 입력해주세요.');
        return;
      }

      $.ajax({
        url: '/isId/' + id,
        type: 'get',
        success: function(data) {
          if (data === true || data === 'true') {
            alert('이미 사용중인 아이디입니다.');
          } else {
            alert('사용 가능한 아이디입니다.');
            $('#id').val(id);
          }
        },
        error: function(err) {
          console.log("에러 발생:", err);
        }
      });
    });

    // 회원가입 버튼
    $('#btn').click(function() {
      if ($('#pw').val() !== $('#pw2').val()) {
        alert('비밀번호가 일치하지 않습니다.');
        return;
      }
      $('#joinForm').submit();
      alert('회원가입이 완료되었습니다.');
    });
  });
</script>

</head>
<body>
	<h1>회원가입</h1>

	<hr>
	<h2>주민번호확인</h2>
	<table border="1">
		<tr>
			<th>주민번호</th>
			<td>
				<input type="text" id="sn1" value="121212"> -
				<input type="text" id="sn2" value="3434343">
			</td>
		</tr>
	</table>

	<hr>
	<h2>ID 검색</h2>
	<table border="1">
		<tr>
			<th>ID 검색</th>
			<td>
				<input type="text" id="idck">
				<button type="button" id="idckBtn">ID 검색</button>
			</td>
		</tr>
	</table>

	<hr>
	<form id="joinForm" action="/joinMember" method="post">
		<table border="1">
			<tr>
				<th>성별</th>
				<td><input type="text" id="gender" name="gender" readonly></td>
			</tr>
			<tr>
				<th>나이</th>
				<td><input type="text" id="age" name="age" readonly value="0"></td>
			</tr>
			<tr>
				<th>아이디</th>
				<td><input type="text" id="id" name="id" readonly></td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td>
					<input type="password" id="pw" name="pw">
					확인 - <input type="password" id="pw2" name="pw2">
				</td>
			</tr>
		</table>
		<button type="button" id="btn">회원가입</button>
	</form>
</body>
</html>
