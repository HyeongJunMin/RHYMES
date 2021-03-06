 <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품조회</title>
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/css/admin/member/memberlist.css">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/css/admin/member/paging.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/companyadmin/productmanage/saleproductmanage.css">	
</head>

<!-- Begin Page Content -->
<div class="container-fluid">

	<!-- Page Heading -->
	<h1 class="h3 mb-2 text-gray-800">${c_name }</h1>
	<br>
	<!-- <p class="mb-4">회원조회, 수정, 정지</p> -->

	<!-- DataTales Example -->
	<div class="card shadow mb-4">
		<div class="card-header py-3">
			<h6 class="m-0 font-weight-bold text-primary">상품 관리 > <a href="/admin/company/saleproductmanage">SALE관리</a></h6>
		</div>
		<div class="card-body">
			<div class="table-responsive">
				<div class="row">
					<div class="col-sm-12 col-md-6">
						<div class="dataTables_length" id="dataTable_length">
								<%-- <select style="width: 100px;"
									name="recordCountPerPage" aria-controls="dataTable"
									onchange="dataTable_length()"
									class="custom-select custom-select-sm form-control form-control-sm">
									<option value="10"
										<c:out value="${recordCountPerPage == '10'? 'selected':'' }"/>>10</option>
									<option value="25"
										<c:out value="${recordCountPerPage == '25'? 'selected':'' }"/>>25</option>
									<option value="50"
										<c:out value="${recordCountPerPage == '50'? 'selected':'' }"/>>50</option>
									<option value="100"
										<c:out value="${recordCountPerPage == '100'? 'selected':'' }"/>>100</option>
								</select> --%>
								<select id="sorting" class="custome-select border-0 pr-3 searchSelect" onchange="sorting(this.value)" 
									style="width:auto; border-color: black; cursor:pointer; text-align: center;" >
									<option selected="selected" value="SEQ"
										<c:out value="${param.sorting == 'SEQ'? 'selected':'' }"/>>상품번호순</option>
									<option value="PRICEUP"
										<c:out value="${param.sorting == 'PRICEUP'? 'selected':'' }"/>>가격 ↑</option>
									<option value="PRICEDOWN"
										<c:out value="${param.sorting == 'PRICEDOWN'? 'selected':'' }"/>>가격 ↓</option>
									<option value="SALEUP"
										<c:out value="${param.sorting == 'SALEUP'? 'selected':'' }"/>>할인율 ↑</option>
									<option value="SALEDOWN"
										<c:out value="${param.sorting == 'SALEDOWN'? 'selected':'' }"/>>할인율 ↓</option>
								</select>
									<button type="button" onclick="location.href='/admin/company/saleproductmanage'"
								style="border: solid 1px #DADCE0; width:auto; border-radius: 5px; color:white; background-color: #5587ED;">
								전체 조회</button>&nbsp;
								<button type="button" onclick="location.href='/admin/company/saleproductmanage?criterion=c1_search&c1_name=MEN'"
								style="border: solid 1px #DADCE0; width:auto; border-radius: 5px; background-color: white;">
								MEN</button>
								<button type="button" onclick="location.href='/admin/company/saleproductmanage?criterion=c1_search&c1_name=WOMEN'"
								style="border: solid 1px #DADCE0; width:auto; border-radius: 5px; background-color: white;">
								WOMEN</button>
						</div>
					</div>
					<!-- 검색 -->
					<div class="col-sm-12 col-md-6">
						<div id="dataTable_filter" class="searchPosition dataTables_filter">
							
							<select class="custome-select border-0 pr-3 searchSelect" id="_select" style="width:auto; cursor: pointer; text-align: center;">
								<option selected value="all_search">전체</option>
								<option value="pname_search"
									<c:out value="${param.criterion == 'pname_search'? 'selected':'' }"/>>상품명</option>
								<option value="cpcode_search"
									<c:out value="${param.criterion == 'cpcode_search'? 'selected':'' }"/>>상품코드</option>
								
							</select> 
							<input type="search" id="keyword" name="s_keyword" class="searchText form-control-sm" placeholder=""
								aria-controls="dataTable" style="width: 150px" value="${param.keyword }">
							<button class="btn btn-primary" type="button">
								<i class="fas fa-search fa-sm" id="_btnSearch"></i>
							</button>
						</div>
					</div>
					<!-- /검색 -->

				</div>
				
				<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0" style="font-size: 13px;">
					<colgroup>
						
					</colgroup>
					<thead>
						<tr align="center">
							<!-- <th class="list_checkbox"><input type="checkbox"
								name='allckeck' onclick='allchecks(this.checked)' id='_allck'>
							</th> -->
							<!-- 2 -->
							<th class="">상품 번호</th>
							<!-- 3 -->
							<th class="">상품명</th>
							<th class="">상품 코드</th>
							<th class="">대분류</th>
							<!-- 8 -->
							<th class="">중분류</th>
							<!-- 9 -->
							<th class="">소분류</th>
							<!-- 12 -->
							<!-- 10 -->
							<th class="">색상</th>
							<th class="">등록일</th>
							<!-- 4 -->
							<th class="">현재 가격</th>
							<!-- 5 -->
							<th class="">SALE전 가격</th>
							<!-- 6 -->
							<th>할인율</th>
							<!-- 7 -->
							<!-- 11 -->
							
							<!-- 13 -->
							<th class="">SALE취소</th>
						</tr>
					</thead>

					<tbody>
						<c:if test="${empty plist }">
							<tr align="center">
								<td colspan="12" align="center">등록된 상품이 없습니다.</td>
							</tr>
						</c:if>
						<c:forEach var="pro" items="${plist }" varStatus="vs">
							<tr align="center" id="plist-tr${pro.p_seq }">
								<%-- <td class="list_checkbox"><input type="checkbox"name='allck' value="${p.seq }"></td> --%>
								<%-- <!-- 1 -->
								<td class="list_name">${pro.rnum }</td> --%>
								<!-- 2 -->
								<td class="list_rdate">${pro.p_seq }</td>
								<!-- 3 -->
								<td class="list_name">
									<a href="/admin/company/stocklist?p_seq=${pro.p_seq }">
									<strong>${pro.p_name }</strong></a>
								</td>
								<td class="">${pro.cp_code }</td>
								<!-- 7 -->
								<td class="">${pro.c1_name}</td>
								<!-- 8 -->
								<td class="">${pro.c2_name}</td>
								<!-- 9 -->
								<td class="">${pro.c3_name}</td>
								<!-- 10 -->
								<td class="">${pro.p_color }</td>
								<!-- 12 -->
								<td class="">${pro.rdate }</td>
								<!-- 4 -->
								<td>
									<fmt:formatNumber type="currency" currencySymbol="" value="${pro.p_price}" /> 원
								</td>
								<!-- 5 -->
								<td id="originPrice${pro.p_seq }" value="${pro.bfs_price}">
									<fmt:formatNumber type="currency" currencySymbol="" value="${pro.bfs_price}" /> 원
								</td>
								<!-- 6 -->
								<td class="" style="color:red;">
									<fmt:formatNumber value="${(1-(pro.p_price/pro.bfs_price))*100}" pattern=""></fmt:formatNumber>%
								</td>
								<!-- 11 -->
								
								<!-- 13 -->
								<td>
									<button type='button' class="salecancel-btn" value="${pro.p_seq }">적용 취소</button>									
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				</from>
				<div class="col-sm-12 col-md-7">
					<div class="dataTables_paginate paging_simple_numbers"
						id="dataTable_paginate">
						<!-- 페이징 -->
						<div id="paging_wrap">
							<jsp:include page="/WEB-INF/views/companyadmin/productmanage/productpaging.jsp"
								flush="false">
								<jsp:param name="pageNumber" value="${pageNumber }" />
								<jsp:param name="totalRecordCount" value="${totalRecordCount }" />
								<jsp:param name="pageCountPerScreen"
									value="${pageCountPerScreen }" />
								<jsp:param name="recordCountPerPage"
									value="${recordCountPerPage }" />
							</jsp:include>
						</div>
						<!-- 페이징끝 -->

					</div>
				</div>
			</div>
		</div>
	</div>

</div>
<!-- 상품리스트 검색/정렬/페이징 -->
<form action="/admin/company/saleproductmanage" method="get" id="plistFrm">
	<input type="hidden" name="pageNumber" id="_pageNumber" value="${pageNumber }">
	<input type="hidden" name="recordCountPerPage" id="_recordCountPerPage" value="${(empty recordCountPerPage)?0:recordCountPerPage }">
	<input type="hidden" name="criterion" id="frm_criterion" value="${param.criterion }">
	<input type="hidden" name="keyword" id="frm_keyword" value="${param.keyword }">
	<input type="hidden" name="sorting" id="form_sorting" value="${param.sorting }">	
</form>
<!-- 메시지 MODAL영역 -->
<div class="msgModal">
   <div class="msg-content">
      <span id="msg"></span>
   </div>
</div>

<!-- /.container-fluid -->

<!-- End of Main Content -->

<!--------------------------------- SCRIPT ZONE --------------------------------->
<script>

//SALE적용 취소
$('.salecancel-btn').click(function(){
	var p_seq = $(this).val();
	var p_price = $("#originPrice" + p_seq).attr("value");
		
	$.ajax({
        type:"get",
        data: "p_seq=" + p_seq + "&p_price=" + p_price,
        url:"/admin/company/salepriceupdatecancel",
        success:function( data ){
			 
        	$("#plist-tr" + p_seq).remove();
        	
        	//메시지 모달
		     $("#msg").html("<strong>SALE적용이 취소되었습니다.</strong>");
	      	 $(".msgModal").fadeIn();
	     	 setTimeout(function() {
	     		$(".msgModal").fadeOut();    	
	         },1000);			 
        },
        error:function(){
           alert("error!!"); 
        }
    })
});

//검색
$(document).on('click', '#_btnSearch', function(){
	var criterion = $("#_select").val();
	var keyword = $("#keyword").val();
	var sorting = $("#sorting").val();
	$("#frm_criterion").val(criterion);
	$("#frm_keyword").val(keyword);
	$("#frm_sorting").val(sorting);
		
	$("#plistFrm").submit();
});
// 정렬
function sorting(sorting){
	var criterion = $("#_select").val();
	var keyword = $("#keyword").val();
	var sorting = $("#sorting").val();
	$("#frm_criterion").val(criterion);
	$("#frm_keyword").val(keyword);
	$("#form_sorting").val(sorting);
		
	$("#plistFrm").submit();	
}
// 페이지 이동
function goPage( pageNumber ) {
	$("#_pageNumber").val(pageNumber);
	$("#plistFrm").submit();
}

</script>


</html>