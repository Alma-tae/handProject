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
			//alert('누름')
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

	pharmacy_list(1);
	function pharmacy_list(page) {
		$.ajax({
				url : 'post/postOffice',
				data : {
						pageNo : page
					},
				success : function(data) {
						console.log(data)
						var tag = "<table class='postOffice'>"
								+ '<tr><th class="w-px200">우체국명</th><th class="w-px140" >전화번호</th><th>주소</th></tr>';

						$(data.item).each(
							function() {
									tag += "<tr>" + "<td><a class='map' data-x=" + this.XPos + " data-y=" + this.YPos + ">"
										+ this.yadmNm + "</a></td><td>" + this.addr + "</td><td class='left'>" + this.addr
										+ "</td>" + "</tr>";
										});

						tag += "</table>";
						$('#data-list').html(tag);
						makePage(data.count, page);
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
	<div class="btnSet dataOption">
		<a class="btn-fill">우체국 조회</a> <a class="btn-empty">유기 동물 조회</a>
	</div>

	<div id="data-list" style="margin: 20px 0 auto"></div>

	<div class="btnSet">
		<div class="page-list"></div>
	</div>

	<div id="map-background"></div>
	<div id="map"></div>
</body>
</html>