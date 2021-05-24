<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Home</title>
<script>
	$(function() {
		$('.slide3 .slide-img:gt(0)').hide();
		setInterval(function() {
			if (!$('.slide3 .slide-img').is(':animated')) {
				$('.slide3 .slide-img').first().fadeOut(1000).next().fadeIn(
						1000).end().appendTo('.slide3 .slide-inner')
			}
		}, 1500)
		/* setInterval(function(){
		  if(!$('.slide3 .slide-img').is(':animated')){
		    $('.slide1 .slide-img').first().animate({'margin-left':'-700px'},2000,function(){
		      $(this).detach().appendTo('.slide1 .slide-inner').removeAttr('style');
		    })
		  }
		},1500) */
	});
</script>
<link rel="stylesheet" href="/peekaboo21/include/slide.css" />
</head>
<body>

	<P style="font-size: 150%;">
		안녕하세요 :)<br>손편지 프로젝트입니다.
	</P>
	<%-- <P>  The time on the server is ${serverTime}. </P> --%>

	<div class="slide3 slide">
		<div class="slide-inner">
			<img src="/peekaboo21/images/one.jpg" class="slide-img"> <img
				src="/peekaboo21/images/two.jpg" class="slide-img"> <img
				src="/peekaboo21/images/three.jpg" class="slide-img"> <img
				src="/peekaboo21/images/four.jpg" class="slide-img">
		</div>
	</div>
</body>
</html>
