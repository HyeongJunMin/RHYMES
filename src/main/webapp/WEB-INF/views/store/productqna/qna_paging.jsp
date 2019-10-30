<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	int totalRecordCount;	//전체 글수 23 -> 3페이지
	int pageNumber;			//현재 페이지 0~9	[1]~[10]
	int pageCountPerScreen;	// 스크린당 페이지 수 = 10
	int recordCountPerPage;	// 페이지당 글 수 = 10
	
	//

	
	String st1 = request.getParameter("totalRecordCount");
	if(st1 == null || "".equals(st1)) totalRecordCount = 1;
	else			totalRecordCount = Integer.parseInt(st1);
	
	String st2 = request.getParameter("pageNumber");
	if(st2 == null || "".equals(st2)) pageNumber = 1;
	else			pageNumber = Integer.parseInt(st2);
	
	String st3 = request.getParameter("pageCountPerScreen");
	if(st3 == null || "".equals(st3)) pageCountPerScreen = 1;
	else			pageCountPerScreen = Integer.parseInt(st3);
	
	String st4 = request.getParameter("recordCountPerPage");
	if(st4 == null || "".equals(st4)) recordCountPerPage = 1;
	else			recordCountPerPage = Integer.parseInt(st4);
	
	// 총페이지 수
	int totalPageCount = totalRecordCount / recordCountPerPage;
	//	2						23		/	10
	if((totalRecordCount % recordCountPerPage)!= 0){
		totalPageCount++;			//  -> 3페이지로 늘어남
	}
	
	// 시작페이지 [1]	[11]	[21]	<<[1][2][3]...[10]>>
	int screenStartPageIndex = ((pageNumber + 1)	/ pageCountPerScreen) * pageCountPerScreen;
	//			0					10						10					*10
	
	// 끝페이지	[10] [20] [30]
	int screenEndPageIndex = (((pageNumber + 1)	/ pageCountPerScreen) * pageCountPerScreen) + pageCountPerScreen;
	
	// 끝페이지는 다시 계산
	if(screenEndPageIndex > totalPageCount){
		screenEndPageIndex = totalPageCount;
	}
	
	if((pageNumber + 1) % pageCountPerScreen == 0){
		screenStartPageIndex = ((pageNumber + 1 ) / pageCountPerScreen * pageCountPerScreen ) - pageCountPerScreen;
		
		screenEndPageIndex = pageNumber + 1; 	//0 => 1 9 => 10
	}
	
	
	
%>


<div align="center" id="ff">
	<nav aria-label="Page navigation example">
	<!-- << -->
	<ul class="pagination">
		<li class="page-item">
	      <a href="#_product_qna" class="page-link"  title="처음페이지" onclick="getProductQna('0')">
	        <span aria-hidden="true">&laquo;</span>
	        <span class="sr-only">Previous</span>
	      </a>
	    </li>
	
	
	<!-- < -->
	<%
	if(screenStartPageIndex > 1){
		%>
		<span style="font-size: 12pt; color: #000000; border:#D8D8D8 1px solid; padding: 5px">
		<a href="#_product_qna" title="이전페이지" onclick="getProductQna('<%=screenStartPageIndex-1 %>)">
			<img alt="" src="../img/customer-img/arrow_back.gif" style="width: 9px; height: 9px">
		</a>
		</span>
		<% 
	}
	%>
	
	<!--[1] 2 [3] -->
	
	<%
	for(int i = screenStartPageIndex; i<screenEndPageIndex; i++){

		if(i == pageNumber){	// 현재페이지
			
		%>
		<li class="page-item"><a class="page-link" href="#_product_qna" style="color: red;" ><%=i+1 %></a></li>
		
		<% 
		}else{	// 그외의 페이지들
			
			%>
			<li class="page-item"><a class="page-link" href="#_product_qna" onclick="getProductQna(<%=i %>);"><%=i+1 %></a></li>
	<%
		}
	}
	%>
	
	<!-- > -->
	<%
	if(screenEndPageIndex < totalPageCount){	// [11][12][13] >
		%>
		<span style="font-size: 12pt; color: #000000; border:#D8D8D8 1px solid; padding: 5px">
		<a href="#_product_qna" title="다음페이지" onclick="getProductQna(<%=screenEndPageIndex %>);">
			<img alt="" src="../img/customer-img/arrow_next.gif" style="width: 9px; height: 9px;">
		</a>
		</span>
		<%
	}
	int end_page = 0;
	if(totalPageCount > 0){
		end_page = totalPageCount - 1;
	}
	%>
	<!-- >> -->
	<li class="page-item">
	      <a href="#_product_qna" class="page-link" title="마지막페이지" onclick="getProductQna(<%=end_page %>)">
	        <span aria-hidden="true">&raquo;</span>
	        <span class="sr-only">Next</span>
	      </a>
	    </li>
	  </ul>
	</nav>
</div>
    