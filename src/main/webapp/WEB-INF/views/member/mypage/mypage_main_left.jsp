<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
<sec:authentication property="principal" var="prc"/>
<% String ctx = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="<%=ctx%>/css/member/mypage/mypage_main_left.css">
<script type="text/javascript" src="<%=ctx%>/js/member/mypage/mypage_main_left.js"></script>
</head>

<c:set var="menuName" value="${fn:split('주문 내역,찜 목록,상품후기,적립금,쿠폰,쪽지함,내 판매목록,교환/환불,개인 정보 수정',',')}" />

<div class="mypage_main_left_title" align="left">
	<h3>마이페이지</h3>	
</div>

<!-- 권한검사 -->
<c:set var="isSeller" value="false"/>
<c:forEach items="${prc.authorities  }" var="auth">
	<c:if test="${auth == 'ROLE_SELLER' }"><c:set var="isSeller" value="true"/></c:if>
</c:forEach>


<div class="btn-group-vertical" id="_left_title_btns" align="left">
	<c:forEach items="${menuName }" var="name" varStatus="i" step="1">
		<c:choose>
			<c:when test="${name == '내 판매목록' }">
				<c:if test="${isSeller == true }">
					<button type="button" class="btn btn-default btn_inner" id="_left_btn_${i.index }">
						<div align="left" class="btn_inner_title" id="_left_title_btn_${i.index }">${name }</div>
						<div align="right" class="btn_inner_ico"><i class="fas fa-angle-right"></i></div>		
					</button>		
				</c:if>
			</c:when>
			<c:otherwise>
				<button type="button" class="btn btn-default btn_inner" id="_left_btn_${i.index }">
					<div align="left" class="btn_inner_title" id="_left_title_btn_${i.index }">${name }</div>
					<div align="right" class="btn_inner_ico"><i class="fas fa-angle-right"></i></div>		
				</button>
			</c:otherwise>
		</c:choose>
		
		
	</c:forEach>	
</div>
<form action="/logout" method="post" style="margin-top: 100px;">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	<input type="submit" value="로그아웃" class="btn btn-rhy-full">
</form>
<script>
function checkused() {
	
	var id ="${userloginid}";	// js파일에서는 el tag를 스크립트창에서 사용하지 못하여 이렇게 했습니다ㅠㅠ
	$.ajax({
		url:"/used/getSeller",
		type:"get",
		data:{
			s_id:id
		},
		success:function(data){
			var count = parseInt(data);
			if(count > 0){
				location.href="myused";
			} else {
				alert("판매자 등록이 필요합니다");
			}
		},
		error:function(e){
			alert(e);
		}	
	})		
}
</script>
</html>

