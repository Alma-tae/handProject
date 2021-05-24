<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<link rel="stylesheet" href="/peekaboo21/libs/css/bootstrap.css">
<title>Insert title here</title>
<%@ include file="../views/include/factor.jsp"%>
<style>
#header {
	width: 100%;
	height: 150px;
	text-align: center;
	background-color: #B5D4FC;
	padding: 15px 0px;
}

#left {
	float: left;
	width: 15%;
	background-color: gray;
}

#main {
	float: left;
	width: 100%;
	text-align: center;
	vertical-align: middle;
	padding: 50px 0px;
	background-color: #D9DCF7;
}

#footer {
	width: 100%;
	height: 50px;
	text-align: center;
	background-color: orange;
	clear: both;
	padding: 10px 0px;
}

#left, #main {
	min-height: 600px;
}
</style>
</head>
<body>
	<div style="width: 100%; height: 100%;">
		<div id="header">
			<tiles:insertAttribute name="header" />
			<%@ include file="../views/include/menu.jsp"%></div>
		<%--  <div id="left"><tiles:insertAttribute name="left" /></div> --%>
		<div id="main">
			<tiles:insertAttribute name="body" />
		</div>
		<div id="footer">
			<tiles:insertAttribute name="footer" />
		</div>
	</div>

	<script type="text/javascript">
		$(function() {

		});
	</script>
</body>
<script src="/peekaboo21/libs/jquery-3.6.0.min.js"></script>
<script src="/peekaboo21/libs/js/bootstrap.min.js"></script>
</html>