<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

<input type="hidden" class="_c1name" value="${c1_name }">
<input type="hidden" class="_keyword" value="${keyword }">

<div class="sidenav">

 <c:if test="${not empty c1_name}">
 <a style="text-align: left; font-size: 15px;" onclick="location.href='/Rhymes/store/productList?c1_name=${c1_name}'">
 		<c:if test="${not empty keyword}">
 			<br>${keyword }&nbsp;&nbsp;for&nbsp;
 		</c:if>
 		<b>${c1_name }</b>
 		<hr width = "85%" color = "#DADCE0">
 </a>
 </c:if>
<c:if test="${empty c1_name}">
 <a>
<c:if test="${criterion eq 'company_search' }">
	<font style="font-size: 15px;"><b>${keyword }</b></font>
</c:if>
<c:if test="${criterion eq 'all_search' }">
	RESULT : <b>${keyword }</b>
</c:if>
	<hr width = "85%" color = "#DADCE0">
</a>
</c:if>
<c:if test="${empty keyword}">
    <a href="#">WHAT THEY WANT 16</a>
</c:if>    
  <c:forEach items="${cate2list }" var="cate2" varStatus="vs">
	  <input type="hidden" value="${cate2.c2_name }">
	  <button class="dropdown-btn" id="cate2Btn${cate2.c2_seq }" onclick="bring3cate(${cate2.c2_seq})" value="${cate2.c2_name }">
	  	${cate2.c2_name }<i class="fa fa-caret-down"></i>
	  </button>
	  <div class="dropdown-container" id="cate3zone${cate2.c2_seq }">
	    <!-- <a href="#">1</a> -->
	  </div>
  </c:forEach>
 
 <!-- C1_NAME���� �귣�� Ŭ���ؼ� ������ �� -->
 <c:forEach items="${cate1list }" var="b_cate1" varStatus="vs">
   <!-- 1�� ī�װ��� -->
   <button class="dropdown-btn" id="withoutC1C1list" value="${b_cate1.c1_name}" value2="${b_cate1.c1_seq}">
   		${b_cate1.c1_name }
    	<i class="fa fa-caret-down"></i>
   </button>
   <!-- 2�� ī�װ��� -->
   <div class="dropdown-container" id="withoutC1C2${b_cate1.c1_seq}">
   	
   	<!-- 3�� ī�װ��� -->
	<div class="dropdown-container" id="withoutC1C3${b_cate1.c1_seq }">
	   		
	</div>
   </div>
 </c:forEach>

  <br>
  <button class="dropdown-btn"><b>BRAND</b>
    <i class="fa fa-caret-down"></i>
  </button>
  <div class="dropdown-container">
    <c:forEach items="${clist }" var="co" varStatus="vs">
    	<a href="#" class="brandClick">${co }</a>
    </c:forEach>
  </div>
<br>
<a style="cursor: pointer;" class="search_btn">
	<font style="color:green">SEARCH</font> 
	<img src="https://cdn0.iconfinder.com/data/icons/it-hardware/100/search-512.png"
	style="width:15px; height:15px;">&nbsp;
</a>
<br><br>
</div>

<!-- �˻� modal -->
<div class='modal' id="search_modal">
	<div class="modal-content2">
		
		<div id="modal_s">
			
			<input type="radio" name='mwChk' id="mChk" class="_mwChk" style="display:none" value="MEN">
			<label for="mChk" class="mwRadioL" style="cursor: pointer; background-color: white;">MEN</label>
			
			<input type="radio" name='mwChk' id="wChk" class="_mwChk" style="display:none" value="WOMEN">
			<label for="wChk" class="mwRadioL" style="cursor: pointer; background-color: white;">WOMEN</label>
			
			<input type="text" id="keyword" style="widht:500px;" placeholder="SEARCH" onkeypress="if( event.keyCode==13 ){search();}">

			<img src="https://cdn0.iconfinder.com/data/icons/it-hardware/100/search-512.png" style="width:40px; height:40px; cursor:pointer;" onclick="search()">  <!-- id="m_search_btn" -->&nbsp;
		</div>
	
	</div>
</div>


<body>

<!-- �˻� -->
<form action="/Rhymes/store/productList" method="get" id='searchFrm'>
	<input type='hidden' name="criterion" value="all_search">	
	<input type="hidden" name="keyword" class="keyword" value="">
	<input type="hidden" name="c1_name" class="c1_name" value="">
</form>
<!-- �귣�� Ŭ�� -->
<form action="/Rhymes/store/productList" method="get" id='brandClickFrm'>
	<input type='hidden' name='keyword' value="" class="keyword">	
	<input type='hidden' name='criterion' value="company_search">
</form>
<!-- 3�� ī�װ��� Ŭ�� -->
<form action="/Rhymes/store/productList" method="get" id='c3ClickFrm'>
	<input type='hidden' name='c1_name' value="" class="c3_c1name">	
	<input type='hidden' name='c2_name' value="" class="c3_c2name">
	<input type='hidden' name='c3_name' value="" class="c3_c3name">
	<input type='hidden' name='keyword' value="" class="keyword">
</form>

<!--------------------- SCRIPTZONE ----------------------------------->
<script type="text/javascript">

//ī�װ��� ���� �˻���ٷ� ���ý� 1��ī�װ��� ���� �� 
//1�� ī�װ��� Ŭ�� -> 2�� ī�װ��� �ҷ�����
$(document).on('click', '#withoutC1C1list', function(){
	var c1_name = $(this).val();
	var c1_seq = $(this).attr("value2");
	var keyword = $("._keyword").val();
	
	$(".dropdown-btn2").remove();
		
	$.ajax({
        type:"get",
        data: "c1_name="+ c1_name +"&c1_seq=" + c1_seq +"&keyword=" + keyword,
        url:"/Rhymes/store/kCate2List",
        success:function( data ){
        	var obj = JSON.stringify(data);
			var arr = JSON.parse(obj);
			var arrLen = arr.length;
			//$("._cate3a"+c2_seq).remove();
			addkCate2(arr, arrLen, c1_seq, c1_name);
        },
        error:function(){
           alert("error!!"); 
        }
   })
	

});
function addkCate2(arr, arrLen, c1_seq, c1_name) {
	
	var str ="";
	for (var i = 0; i < arrLen; i++) {
		str += "<button class='dropdown-btn2' id='withoutC1C2list' c2name='"+arr[i].c2_name+"' ";
		str += "c2seq='"+arr[i].c2_seq+"' c1name='"+c1_name+"' c1seq='"+c1_seq+"'>";
		str += arr[i].c2_name;
		str += "<i class='fa fa-caret-down'></i>";
		str += "</button>";
	}
	$("#withoutC1C3" + c1_seq).append(str);
}


//ī�װ��� ���� �˻���ٷ� ���ý� 1��ī�װ��� ���� �� 
//2�� ī�װ��� Ŭ�� -> 3�� ī�װ��� �ҷ�����
$(document).on('click', '#withoutC1C2list', function(){
	var c1_name = $(this).attr("c1name");
	var c1_seq = $(this).attr("c1seq");
	var c2_name = $(this).attr("c2name");
	var c2_seq = $(this).attr("c2seq");
	var keyword2 = $("._keyword").val();
	
	$.ajax({
        type:"get",
        data: "c1_name="+ c1_name +"&c2_name=" + c2_name +"&keyword=" + keyword2,
        url:"/Rhymes/store/kCate3List",
        success:function( data ){
        	var obj = JSON.stringify(data);
			var arr = JSON.parse(obj);
			var arrLen = arr.length;
			//$("._cate3a"+c2_seq).remove();
			addkCate3(arr, arrLen, c1_name, c2_name, c2_seq, c1_seq);
        },
        error:function(){
           alert("error!!"); 
        }
   })
	
	
});
function addkCate3(arr, arrLen, c1_name, c1_seq, c2_name, c2_seq){
	//alert(c1_name);
	//alert(c2_name);
	var str ="";
	for (var i = 0; i < arrLen; i++) {
		str += "<a href='#' class='_cate3a"+c2_seq+"' id='cate3_btn' style='cursor:pointer;' c3_name='"+arr[i].c3_name+"' c2_name='"+c2_name+"'>";
		str += arr[i].c3_name;
		str += "</a>";
	}
	//alert(str);
	//alert(c1_seq);
	$("#withoutC1C2" + c1_seq).append(str);
	
}


// 3�� ī�װ��� Ŭ����
$(document).on('click', '#cate3_btn', function(){
	var c3_name = $(this).attr("c3_name");
	$(".c3_c3name").val(c3_name);
	var c2_name = $(this).attr("c2_name");
	$(".c3_c2name").val(c2_name);
	var c1_name = $("._c1name").val();
	$(".c3_c1name").val(c1_name);
	var keyword = $("._keyword").val();
	$(".keyword").val(keyword);
	
	$("#c3ClickFrm").submit();
	
	
	
});


/* 3��° ī�װ��� �ҷ����� */
function bring3cate(c2_seq){
	//var c2_name = $(this).val();
	//var c2_name = "";
	var c2_name = $("#cate2Btn"+c2_seq).val();
	//alert("C2NAME : " + c2_name);
	//alert(c2_seq);
	var c1_name = $("._c1name").val();
	//alert("C1NAME : " + c1_name);
	var keyword = $("._keyword").val();
	//alert("Ű���� : " + keyword);
	
	if(keyword == ''){
		$.ajax({
	        type:"get",
	        data: "c2_seq=" + c2_seq,
	        url:"/Rhymes/store/cate3List",
	        success:function( data ){
	        	var obj = JSON.stringify(data);
				var arr = JSON.parse(obj);
				var arrLen = arr.length;
				$("._cate3a"+c2_seq).remove();
				addCate3(arr, arrLen, c2_seq, c2_name);
	        },
	        error:function(){
	           alert("error!!"); 
	        }
	   })
	}else if(keyword != ''){
		$.ajax({
	        type:"get",
	        data: "c1_name="+ c1_name +"&c2_name=" + c2_name +"&keyword=" + keyword,
	        url:"/Rhymes/store/kCate3List",
	        success:function( data ){
	        	var obj = JSON.stringify(data);
				var arr = JSON.parse(obj);
				var arrLen = arr.length;
				$("._cate3a"+c2_seq).remove();
				addCate3(arr, arrLen, c2_seq, c2_name);
	        },
	        error:function(){
	           alert("error!!"); 
	        }
	   })
		
	}
}

function addCate3(arr, arrLen, c2_seq, c2_name) {
	
	var str ="";
	for (var i = 0; i < arrLen; i++) {
		str += "<a href='#' class='_cate3a"+c2_seq+"' id='cate3_btn' style='cursor:pointer;' c3_name='"+arr[i].c3_name+"' c2_name='"+c2_name+"'>";
		str += arr[i].c3_name;
		str += "</a>";
	}
	$("#cate3zone" + c2_seq).append(str);
}

function search(){
	var c1_name = $("input[name='mwChk']:checked").val();
	var keyword = $("#keyword").val();
	
	if(keyword != ""){
		if(keyword.length < 12){
			$(".c1_name").val(c1_name);
			$(".keyword").val(keyword);
			$("#searchFrm").submit();
		}else{
			alert("�˻�� �ʹ� ����");
		}
	}
}

// �˻���� ���� ����
$(document).on('click', '.mwRadioL', function(){
	$(".mwRadioL").attr('style', 'background-color:white');
	$(this).attr('style', 'background-color:#d7fd75');
		
});

/* �˻���� ���� �� Ŭ���� close */
$('body').click(function(e){
	 if($(".modal").css("display") == "block") {
        if(!$('.modal, .modal').has(e.target).length) { 
        	//$(".modal").css("display", "none");
        	$(".modal").fadeOut();
        	/* �˻�â �ʱ�ȭ */
        	$("#keyword").val('');
        	$("input:radio[name='mwChk']").prop("checked", false);
        	$(".mwRadioL").attr('style', 'background-color:white');
         } 
 	 }
});

/* �˻�(���)��ư Ŭ�� */
$(document).on('click', '.search_btn', function(){
	/* $("#search_modal").css("display", "block"); */
	$("#search_modal").fadeIn();
});

$(document).on('click', '.brandClick', function(){
	var c_name = $(this).html();
	$(".keyword").val(c_name);
	$("#brandClickFrm").submit();
});	

//* Loop through all dropdown buttons to toggle between hiding and showing its dropdown content - This allows the user to have multiple dropdowns without any conflict */
var dropdown = document.getElementsByClassName("dropdown-btn");
var i;

for (i = 0; i < dropdown.length; i++) {
  dropdown[i].addEventListener("click", function() {
	this.classList.toggle("active");
    var dropdownContent = this.nextElementSibling;
    
    if (dropdownContent.style.display === "block") {    	
      //dropdownContent.style.display = "none";
      $(this.nextElementSibling).fadeOut();
    } else {
      //$(".dropdown-container").attr('style', "display:none;");
      $(".dropdown-container").fadeOut();
      $(".dropdown-btn").attr('style', "background-color:white;");
      $(this).attr('style', "background-color:#d7fd75;");
      //dropdownContent.style.display = "block";
      $(this.nextElementSibling).fadeIn();
      
    }
  });
}

var dropdown = document.getElementsByClassName("dropdown-btn2");
var i;

for (i = 0; i < dropdown.length; i++) {
  dropdown[i].addEventListener("click", function() {
	this.classList.toggle("active");
    var dropdownContent = this.nextElementSibling;
    
    if (dropdownContent.style.display === "block") {    	
      //dropdownContent.style.display = "none";
      $(this.nextElementSibling).fadeOut();
    } else {
      //$(".dropdown-container").attr('style', "display:none;");
      $(".dropdown-container2").fadeOut();
      $(".dropdown-btn2").attr('style', "background-color:white;");
      $(this).attr('style', "background-color:#d7fd75;");
      //dropdownContent.style.display = "block";
      $(this.nextElementSibling).fadeIn();
      
    }
  });
}




/* ȸ���̸� sorting */
 function cnameMove(c_name){
	alert(c_name);
}

</script>
</body>