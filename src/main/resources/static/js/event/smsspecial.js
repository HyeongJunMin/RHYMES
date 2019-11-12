/**
 * 
 */
$(function(){
	// ajax 통신을 위한 csrf 설정
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$(document).ajaxSend(function(e, xhr, options) {
		xhr.setRequestHeader(header, token);
	});
	
	//text 입력 이벤트
	$("#smsid").keyup(function(){
		var valueLength = $(this).val().length;
		
		if(valueLength < 1 ){
			$("#btnSubmit").attr('disabled', 'disabled');
		}else{
			$("#btnSubmit").removeAttr('disabled');
		}
	});
	
	//아이디 입력 버튼 클릭 이벤트
	$("#btnSubmit").click(function(){
		$.ajax({
			type : 'get',
			url : "http://192.168.0.10:9091/common/idCheck.do",
			dataType : "json",
			data : {
				id : $("#smsid").val()
			},
			async: true,
			success : function(data) {
				console.log('load ok ' + data );
				if( 'true' === data.trim ){
					//리턴이 true이면 없는 아이디
					console.log('존재하지 않는 아이디. : ' + data);
				}else{
					//리턴이 false이면 존재하는 아이디
					console.log('존재하는 아이디. : ' + data);
				}
			},
			error : function(err) {
				console.log('connect eror');
			}
		});
	});
});