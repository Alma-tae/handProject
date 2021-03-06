<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Product Edit</title>
<script>
	function product_delete() {
		if (confirm("삭제하시겠습니까?")) {
			document.form1.action = "/peekaboo21/shop/product/delete.do";
			document.form1.submit();
		}
	}
	
	function product_update() {
		var product_name = document.form1.product_name.value;
		var price = document.form1.price.value;
		var description = document.form1.description.value;
		if (product_name == "") {
			alert("상품명을 입력하세요.");
			document.form1.product_name.focus();
			return;
		}
		if (price == "") {
			alert("가격을 입력하세요.");
			document.form1.price.focus();
			return;
		}
		if (description == "") {
			alert("상품 설명을 입력하세요.");
			document.form1.description.focus();
			return;
		}
		document.form1.action = "/peekaboo21/shop/product/update.do";
		document.form1.submit();
	}
</script>
<style>
table {
	border-spacing: 30px;
	border-collapse: separate;
	background: transparent;
	margin-left: auto;
	margin-right: auto;
}

table td {
	background: transparent;
}
</style>
</head>
<body>
	<h2>Update products details</h2>
	<form id="form1" name="form1" method="post"
		enctype="multipart/form-data">
		<table border="0">
			<tr>
				<td>상품명</td>
				<td><input class="form-control" name="product_name" value="${dto.product_name}"></td>
			</tr>
			<tr>
				<td>가격</td>
				<td><input class="form-control" name="price" value="${dto.price}"></td>
			</tr>
			<tr>
				<td>상품 설명</td>
				<td><textarea rows="5" cols="60" class="form-control"
						name="description" id="description">${dto.description}</textarea></td>
			<tr>
				<td>상품 이미지</td>
				<td><img src="/peekaboo21/images/${dto.picture_url}" width="300px" height="300px"><br>
				<br> <input type="file" name="file1"></td>
			</tr>
		</table>
		<input type="hidden" name="product_id" value="${dto.product_id}">
		<input type="button" value="수정" class="btn btn-warning" onclick="product_update()"> &ensp; 
		<input type="button" value="삭제" class="btn btn-danger" onclick="product_delete()"> &ensp; 
		<input type="button" value="상품목록" class="btn btn-success"
			onclick="location.href='/peekaboo21/shop/product/list.do'">
	</form>
</body>
</html>