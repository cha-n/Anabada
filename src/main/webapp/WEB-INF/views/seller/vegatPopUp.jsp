<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" 
    isELIgnored="false"  %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>품목 선택</title>

    <link rel="stylesheet" href="${contextPath }/resources/eunji/css/ionicons.min.css">
	<link rel="stylesheet" href="${contextPath }/resources/eunji/css/style.css">
<style>
	input {
		font-size:17px;
		height:40px ! important;
	}
	td {
		padding:1% 0% 1% 2%;
		cursor:pointer;
	}
	#resultBox {
		border-style:solid;
		border-width:1.5px;
		border-color:#bcd79c;
		display:none;
	}

</style>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	function searchByKeyword() {
		var word=$('#word').val();
		if(word=='') {
			document.getElementById('resultBox').style.display='none';
			return;
		}
		$.ajax({
			type : "get",
			async : true, //비동기
			url : "${contextPath}/board/searchVegatsByKeyword",
			data : {keyword:word},
			success : function(data) {
			    jsonInfo = JSON.parse(data);
			    _viewList(jsonInfo);
			},
			error : function(data) {
				alert("에러가 발생했습니다.");
			},
			complete : function(data, textStatus) {
			}
		});
	}
	function _viewList(jsonInfo) {
		var count = jsonInfo.keyword.length;
		if(count > 0) {
		    var html = '<table style="width:100%;">';
		    for(var i in jsonInfo.keyword) {
			   html +='<tr><td onclick="_selectItem('+i+')">'+jsonInfo.keyword[i].name+'</td></tr>';
		    }
		    html+='</table>';
		    var listView = document.getElementById('result');
		    listView.innerHTML = html;
		    document.getElementById('resultBox').style.display='block';
		}
		else {
			document.getElementById('resultBox').style.display='none';
		} 
	}
	function _selectItem(i) { //선택했을 때	
		opener._getItem(jsonInfo.keyword[i].name);
		close();

	}
	
</script>
</head>
<body>
  <div style="padding:5%;">
  	<!-- 검색창 -->
	<div class="form-group" style="margin-bottom:0;">
		<span class="icon ion-ios-search" style="position:absolute;top:7.5%;right:45px;"></span>
		<input type="text" name="word" id="word" placeholder="채소, 과일 입력" onKeyUp="searchByKeyword()" class="form-control">
	</div>
	
	<!-- 검색 결과 -->
   	<div id="resultBox">
		<div id="result"></div>
   	</div>

   </div>
</body>
</html>