<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
	$(function()){
		$('h1').text('hello');
		$('#target').text('hi');
		$('.g1').text('bye');
		%('div:even').each(function(i,e){
			$(this).addClass('redtxt');
		}); 
		$('#btn').click(function(){
			alert('버턴 클릭');=
		});
	});
	</script>
</head>
<body>
<h1></h1>
<h2 id ="target"></h2>

<p class="g1"></p>
<div>1</div>
<div>2</div>
<div>3</div>
<div>4</div>
<div>5</div>

<input type="checkbox" class="ck" value="1" checked>one<br>
<input type="checkbox" class="ck" value="1" >two<br>
<input type="checkbox" class="ck" value="1" >three<br>
<input type="checkbox" class="ck" value="1" >four<br>
<input type="checkbox" class="ck" value="1" >five<br>

</body>
</body>
</html>
