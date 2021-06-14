<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	$('.dataOption a').click(function() {
		//이미 선택된 내용에 대해서는 적용하지 않으려면
		if ($(this).hasClass('btn-empty')) {
			alert('누름')
			$('.dataOption a').removeClass();
			$(this).addClass('btn-fill');
			var idx = $(this).index();
			$('.dataOption a:not(:eq(' + idx + '))').addClass('btn-empty');

			if (idx == 0) {
				pharmacy_list();
			} else {
				animal_list();
			}
		}
	});

	pharmacy_list();
	function pharmacy_list() {
		$.ajax({
			url : 'post/postOffice',
			success : function() {

			},
			error : function(text, req) {
				alert(text + " : " + req.status)
			}
		});
	}

	function animal_list() {

	}
</script>
</head>
<body>
	<h3>공공 데이터</h3>
	<div class="btnSet">
		<a class="btn-fill">우체국 조회</a> 
		<a class="btn-fill">유기 동물 조회</a>
	</div>

	<div id="data-list" style="margin: 20px 0 auto"></div>
</body>
</html>