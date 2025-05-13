<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- jQuery CDN 추가 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
	<form id="form1" action="/continentList" method="get">
		<select id="continent" name="continent">
			<option value="">:::대륙선택:::</option>
			<c:forEach var="continent" items="${continentList}">
				<option value="${continent.continentNo}">${continent.continentName}</option>
			</c:forEach>
		</select> 
		<select id="country" name="country">
			<option value="">:::나라선택:::</option>
		</select> 
		<select id="city" name="city">
			<option value="">:::도시선택:::</option>
		</select>
	</form>

	<script>
		$('#continent').on('change', function() {
			let continentVal = $(this).val();
			if (continentVal === '') {
				alert('대륙 선택하세요');
				return;
			}

			// 나라 목록 Ajax
			$.ajax({
				url: '/cntList/' + continentVal,
				method: 'GET',
				dataType: 'json',
				success: function(result) {
					$('#country').empty().append('<option value="">:::나라선택:::</option>');
					$('#city').empty().append('<option value="">:::도시선택:::</option>');
					$.each(result, function(index, item) {
						let option = $('<option>', {
							value: item.countryNo,\
							text: item.countryName
						});
						$('#country').append(option);
					});
				},
				error: function(err) {
					console.log("에러 발생:", err);
				}
			});
		});

		$('#country').on('change', function() {
			let countryVal = $(this).val();
			if (countryVal === '') {
				alert('나라를 선택하세요');
				return;
			}

			// 도시 목록 Ajax
			$.ajax({
				url: '/cityList/' + countryVal,
				method: 'GET',
				dataType: 'json',
				success: function(result) {
					$('#city').empty().append('<option value="">:::도시선택:::</option>');
					$.each(result, function(index, item) {
						let option = $('<option>', {
							value: item.cityNo,
							text: item.cityName
						});
						$('#city').append(option);
					});
				},
				error: function(err) {
					console.log("에러 발생:", err);
				}
			});
		});
	</script>
</body>
</html>
