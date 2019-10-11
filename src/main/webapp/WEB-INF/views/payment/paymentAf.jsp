<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
// 결제금액
String paid_amount = request.getParameter("paid_amount");
// 아임포트 거래 고유 번호
String imp_uid = request.getParameter("imp_uid");
// 결제상태
String status = request.getParameter("status");
// 결제수단
String pay_method = request.getParameter("pay_method");
// 거래 매출 전표
String receipt_url = request.getParameter("receipt_url");
// 주문명
String buyer_name = request.getParameter("buyer_name");
// 주소
String buyer_postcode = request.getParameter("buyer_postcode");



String vbank_num = "";
String vbank_date = "";
String vbank_holder = "";
String vbank_name = "";

if(!request.getParameter("vbank_num").equals("undefined")){
	// 가상계좌
	vbank_num = request.getParameter("vbank_num");
	// 가상계좌 입금기한
	vbank_date = request.getParameter("vbank_date");
	// 가상계좌 예금주
	vbank_holder = request.getParameter("vbank_holder");
	// 가상계좌 은행명
	vbank_name = request.getParameter("vbank_name");
}
request.setAttribute("vbank_num", vbank_num);
request.setAttribute("receipt_url", receipt_url);



// 결제 상태를 알기 쉽게 바꾸기
if(status.equals("ready")){
	status = "미결제";
}else if(status.equals("paid")){
	status = "결제완료";
}else if(status.equals("cancelled")){
	status = "결제취소, 부분취소포함";
}else if(status.equals("failed")){
	status = "결제실패";
}

// 결제수단을 알기 쉽게 바꾸기
if(pay_method.equals("card")){
	pay_method = "신용카드";
}else if(pay_method.equals("trans")){
	pay_method = "실시간계좌이체";
}else if(pay_method.equals("vbank")){
	pay_method = "무통장입금";
}else if(pay_method.equals("phone")){
	pay_method = "휴대폰소액결제";
}else if(pay_method.equals("point")){
	pay_method = "카카오페이";
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

결제 완료창입니다<br><br>

주문자 이름 : <%=buyer_name %><br>
우편번호 : <%=buyer_postcode %><br><br>

결제금액 : <%=paid_amount %>원<br>
결제고유번호 : <%=imp_uid %><br>
결제상태 : <%=status %><br>
결제수단 : <%=pay_method %><br>
<a href="${receipt_url }">매출전표 확인하기</a><br><br>

<c:if test="${fn:length(vbank_num) eq 14 }">
가상계좌 은행명 : <%=vbank_name %><br>
가상계좌 : <%=vbank_num %><br>
가상계좌 입금기한 : <%=vbank_date %><br>
가상계좌 예금주 : <%=vbank_holder %>
</c:if>
<br><br>


<div>
<div>주문상품</div>
<div>결제방법</div>
<div>주문자정보</div>
<div>배송지정보</div>
<div>완료안내문</div>
</div>



<input type="button" onclick="location.href='/main'" value="메인으로">
<input type="button" onclick="location.href='/Rhymes/ordercheck'" value="주문내역확인">



</body>
</html>


