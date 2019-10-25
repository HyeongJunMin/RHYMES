<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

<pre style="font-size: 12px;font-family: 'Noto Sans'; line-height:1.8em; color: #4c4c4c" >
<strong>PRODUCT REVIEW</strong>
-상품에 대한 문의를 남기는 공간입니다. 해당 게시판의 성격과 다른 글은 사전동의 없이 담당 게시판으로 이동될 수 있습니다.
-배송관련, 주문(취소/교환/환불)관련 문의 및 요청사항은 rhymes 내 1:1 문의에 남겨주세요.
</pre>



<form action="reviewlist" name="frmForm1" id="_frmFormSearch" method="POST">
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>        

    
<table class="list_table" style="width:100%" >
<colgroup>
	<col width="100"><col width="600"><col width="100"><col width="100"><col width="100">
</colgroup>
<thead>
<tr>
	<th>번호</th><th>제목</th><th>작성자</th><th>작성일</th><th>도움돼요</th>
</tr> 
</thead>

<tbody>
<c:if test="${empty previewlist }">
	<tr>
		<td colspan="5">등록된 후기가 없습니다.</td>
	</tr>
</c:if>
<c:forEach var="review" items="${previewlist }" varStatus="vs">
<tr class="_hover_tr">
	<td>${vs.count }</td>
	<td style="text-align: left;" onclick="reviewdetail(${review.seq})">
			${review.title }
	</td> 
	<td>
		${review.userid }
	</td>
	<td>
		${fn:substring(review.rdate,0,10)}
	</td>
	<td>
		${review.likes_cnt }
	</td>
	
</tr>
<tr class="detail" id='detail${review.seq}'>
	<td colspan="5" align="left">
	<div>
	${review.p_name }
	${review.content }
	</div>
	<div style="float: right;">
	<input type="button" id="_btnthis" class="likebtn1" value="도움돼요👍🏻" >
	</div>
	</td>
</tr>
</c:forEach>

<tr>
<th colspan="5" align="center">
<!-- 페이징 -->
<div id="paging_wrap"> 
	<jsp:include page="/WEB-INF/views/store/productqna/product_paging.jsp" flush="false">
		<jsp:param name="pageNumber" value="${pageNumber }"/>
		<jsp:param name="totalRecordCount" value="${totalRecordCount }"/>
		<jsp:param name="pageCountPerScreen" value="${pageCountPerScreen }"/>
		<jsp:param name="recordCountPerPage" value="${recordCountPerPage }"/>
	</jsp:include>
	<!-- hidden 을 통해서 값을 넘겨주기 -->
		<input type="hidden" name="pageNumber" id="_pageNumber" value="0"> 
		<input type="hidden" name="recordCountPerPage" id="_recordCountPerPage" value="${(empty recordCountPerPage)?0:recordCountPerPage }">	
</div>
<!-- 페이징끝 --> 
</th>
</tr>

</tbody>
</table>

</form>

<script type="text/javascript">
/* 클릭시 내용보이기 */
$(".detail").hide();

function reviewdetail(seq){
	
	if($("#detail"+seq).css("display")=="none"){
		$(".detail").hide();
		$("#detail"+seq).show();
	
	}else{
		$("#detail"+seq).hide();
	}
}


function goPage( pageNumber ) {
	
	$("#_pageNumber").val(pageNumber);  // 들어오는 값을 가져옴 
	$("#_frmFormSearch").attr("action", "faqlist").submit(); //
	
}



$('.likebtn1').click(function() {
	var color = $(this).css("background-color");
	
	if(color == "rgb(255, 255, 255)")
	$(this).css("background-color", "rgb(207, 236, 64)");
	
	
	else
	$(this).css("background-color", "rgb(255,255,255)");
	});


</script>