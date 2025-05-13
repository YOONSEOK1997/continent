<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>회원가입</title>
  <!-- Bootstrap 5 CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Bootstrap Icons -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

  <style>
    body {
      background: linear-gradient(to right, #e0ecff, #f8fbff);
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      font-family: 'Segoe UI', sans-serif;
    }
    .card {
      width: 100%;
      max-width: 600px;
      border: none;
      border-radius: 20px;
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
      overflow: hidden;
    }
    .card-header {
      background: linear-gradient(to right, #3b8dff, #78baff);
      color: white;
      text-align: center;
      padding: 1.5rem;
    }
    .form-control:focus {
      box-shadow: 0 0 0 0.2rem rgba(59, 141, 255, 0.25);
      border-color: #3b8dff;
    }
    .form-icon {
      width: 2rem;
      text-align: center;
    }
    .input-group-text {
      background-color: #f0f4ff;
      border: none;
    }
  </style>

  <script>
    $(function () {
      $('#sn2').blur(function () {
        const sn1 = $('#sn1').val();
        const sn2 = $('#sn2').val();
        if (sn1.length !== 6 || sn2.length !== 7 || isNaN(sn1) || isNaN(sn2)) {
          alert("주민번호 형식을 확인하세요.");
          return;
        }

        const fullSn = sn1 + sn2;

        $.ajax({
          url: 'http://localhost:9999/isSn/' + fullSn,
          type: 'get',
          success: function (data) {
            if (data === true || data === 'true') {
              alert('주민번호 인증 성공');

              let genderCode = Number(sn2.substr(0, 1));
              $('#gender').val(genderCode % 2 === 0 ? '여' : '남');

              let yearPrefix = ([1, 2, 5, 6].includes(genderCode)) ? 1900 :
                               ([3, 4, 7, 8].includes(genderCode)) ? 2000 : null;

              if (!yearPrefix) {
                alert("알 수 없는 주민번호 형식입니다.");
                return;
              }

              let birthYear = yearPrefix + Number(sn1.substr(0, 2));
              let age = new Date().getFullYear() - birthYear;
              $('#age').val(age);
            } else {
              alert('주민번호 인증 실패');
            }
          },
          error: function (err) {
            console.log("에러 발생:", err);
          }
        });
      });

      $('#idckBtn').click(function () {
        const id = $('#idck').val();
        if (!id) {
          alert('ID를 입력해주세요.');
          return;
        }

        $.ajax({
          url: '/isId/' + id,
          type: 'get',
          success: function (data) {
            if (data === true || data === 'true') {
              alert('이미 사용중인 아이디입니다.');
            } else {
              alert('사용 가능한 아이디입니다.');
              $('#id').val(id);
            }
          },
          error: function (err) {
            console.log("에러 발생:", err);
          }
        });
      });

      $('#btn').click(function () {
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
  <div class="card">
    <div class="card-header">
      <h2><i class="bi bi-person-plus-fill me-2"></i>회원가입</h2>
    </div>
    <div class="card-body px-4 py-4">
      <div class="mb-3">
        <label class="form-label">주민번호</label>
        <div class="row g-2">
          <div class="col-6">
            <div class="input-group">
              <span class="input-group-text"><i class="bi bi-credit-card"></i></span>
              <input type="text" id="sn1" class="form-control" placeholder="앞 6자리" value="121212">
            </div>
          </div>
          <div class="col-6">
            <div class="input-group">
              <span class="input-group-text">-</span>
              <input type="text" id="sn2" class="form-control" placeholder="뒤 7자리" value="3434343">
            </div>
          </div>
        </div>
      </div>

      <div class="mb-3">
        <label class="form-label">ID 중복 확인</label>
        <div class="input-group">
          <span class="input-group-text"><i class="bi bi-person-badge"></i></span>
          <input type="text" id="idck" class="form-control" placeholder="사용할 아이디 입력">
          <button type="button" id="idckBtn" class="btn btn-outline-primary">중복검사</button>
        </div>
      </div>

      <form id="joinForm" action="/joinMember" method="post">
        <div class="mb-3">
          <label class="form-label">성별</label>
          <input type="text" id="gender" name="gender" class="form-control" readonly>
        </div>
        <div class="mb-3">
          <label class="form-label">나이</label>
          <input type="text" id="age" name="age" class="form-control" readonly value="0">
        </div>
        <div class="mb-3">
          <label class="form-label">아이디</label>
          <input type="text" id="id" name="id" class="form-control" readonly>
        </div>
        <div class="mb-3">
          <label class="form-label">비밀번호</label>
          <input type="password" id="pw" name="pw" class="form-control" placeholder="비밀번호 입력">
        </div>
        <div class="mb-4">
          <label class="form-label">비밀번호 확인</label>
          <input type="password" id="pw2" name="pw2" class="form-control" placeholder="비밀번호 재입력">
        </div>
        <div class="d-grid">
          <button type="button" id="btn" class="btn btn-primary btn-lg">
            <i class="bi bi-check-circle me-2"></i>회원가입 완료
          </button>
        </div>
      </form>
    </div>
  </div>
</body>
</html>
