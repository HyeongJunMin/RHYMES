<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

<table class="detail_table">
<col width="100"><col width="200"><col width="100"><col width="300">

<tr>
	<th>����</th>
	<td colspan="3">${noticedto.title }</td>
</tr>

<tr>
	<th>�ۼ���</th>
	<td colspan="3">${noticedto.id }</td>
</tr>

<tr>
	<th>�ۼ���</th>
	<td>${noticedto.wdate }</td>
	<th>��ȸ��</th>
	<td>${noticedto.readcount }</td>
</tr>
<tr>
	<td colspan="4">
	<div style="white-space:pre-line;">
	<img alt="" src="../upload/customer/${noticedto.filename }" style="height: 30%">
	${noticedto.content }
	</td>
	</div>
</tr>

</table>


<!-- ����������ư -->

<div>
<!-- �ھ��±� �߰��ϱ� -->
	<span class="button blue">
		<button type="button" class="btn" onclick="NoticeDelete('${noticedto.seq }')">����</button>
	</span>
	<span class="button blue">
		<button type="button" class="btn" onclick="NoticeUpdate('${noticedto.seq }')">����</button>
	</span>

</div>
<br><br><br>
<table class="before_table">
<col width="50"><col width="650">

<!-- ������ -->
<c:if test="${empty beforedto}">
</c:if>
<c:if test="${!empty beforedto}">
<tr style="border-top: 3px solid #E0FF8B;">
	<td style="border-right: 1px solid #EFEFEF;">������<img alt="" src="../img/customer-img/up.png" height="18px;" width="18px;" align="right" style="padding-right: 5px"> </td>
	<td><a href="noticedetail?seq=${beforedto.seq}">${beforedto.title }</a></td>
</tr>
</c:if>


<!-- ������ -->
<c:if test="${empty afterdto}">
</c:if>
<c:if test="${!empty afterdto}">
<tr style="border-bottom: 3px solid #E0FF8B;">
	<td style="border-right: 1px solid #EFEFEF;">������<img alt="" src="../img/customer-img/down.png" height="18px;" width="18px;" align="right" style="padding-right: 5px"></td>
	<td><a href="noticedetail?seq=${afterdto.seq}">${afterdto.title }</a></td>
</tr>
</c:if>
</table>


<script type="text/javascript">

function NoticeDelete( seq ) {
	location.href = "noticedelete?seq=" + seq;
}
function NoticeUpdate( seq ) {
	location.href = "noticeupdate?seq=" + seq;
}

</script>    