<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false"  %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>닉네임 수정</title>
<link rel="stylesheet" href="${contextPath }/resources/eunji/css/style.css">

<style>
	input {
		font-size:15px;
	}
</style>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	function _checkName() { //닉네임 중복 검사
	    var n_name=$("#_n_name").val();
	    if (n_name==''){
	    	alert("닉네임을 입력하세요.");
	    }
	    else {
		    $.ajax({
		       type:"post",
		       async:false,
		       url:"${contextPath}/member/checkName",
		       data: {n_name : n_name},
		       success:function (data){
		          if(data=='false') {
		       	    alert("사용할 수 있는 닉네임입니다.");
		       	    $('#nameBtn').prop("disabled", true);
		       	    $('#_n_name').prop("disabled", true);
		       	    $('#n_name').val(n_name);
		          }
		          else {
		        	  alert("사용할 수 없는 닉네임입니다.");
		          }
		       },
		       error:function(data,textStatus){
		          alert("오류가 발생했습니다. 다시 시도해주세요.");
		       },
		       complete:function(data,textStatus){
		       }
		    });
	    }
	}

	function _send() {
		var n_name=$("#_n_name").val();
		if(n_name=='')
			alert("닉네임을 입력해주세요.");
		else {
			document.frm.submit();
			alert("닉네임을 등록하였습니다.");
	    	opener.window.location.reload();
	    	close();
		}
	}
</script>
</head>
<body>
<div style="width:90%;">
    <form name="frm" method="post" action="${contextPath}/member/updateName">
    	<div class="col text-center">
		<div class="form-group" style="float:left; margin-right:10px">
            <input type="text" id="_n_name" value="${member.n_name }" width="75%" class="form-control" >
		</div>
		</div>
		<div>
			<input type="button" id="nameBtn" value="중복확인" onclick="_checkName()" class="btn btn-black py-2 px-4">
			<input type="hidden" name="n_name" id="n_name">
			<input type="hidden" name="id" id="id" value="${member.id }">
        </div>

		<br>
		<div class="col text-center">
			<div class="form-group">
				<input type="button" value="변경" onclick="_send()" class="btn py-2 px-4 btn-primary">
			</div>
		</div>
	</form>
  </div>
</body>
</html>
