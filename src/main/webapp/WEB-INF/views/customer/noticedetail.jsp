<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>


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
	<img alt="" src="../upload/${noticedto.filename }" style="height: 30%">
	${noticedto.content }
	</td>
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
</body>
</html>



<script type="text/javascript">

function NoticeDelete( seq ) {
	location.href = "noticedelete?seq=" + seq;
}
function NoticeUpdate( seq ) {
	location.href = "noticeupdate?seq=" + seq;
}

</script>    