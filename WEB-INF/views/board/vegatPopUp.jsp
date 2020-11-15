<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" 
    isELIgnored="false"  %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>품목 선택</title>

    <link rel="stylesheet" href="${contextPath }/resources/eunji/css/ionicons.min.css">
	<link rel="stylesheet" href="${contextPath }/resources/eunji/css/style.css">

<style>
	input {
		font-size:17px;
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
	
	#selectedBox {
		margin:5% 0 5% 0;
	}
	
	#selectedTable {
		width:85%;
		background:#f1f1f1;
		margin-left:auto;
		margin-right:auto;
	}
</style>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	var jsonInfo;
	var arr=new Array();
	var cnt=0;
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
			   html +='<tr><td onclick="_viewInfo('+i+')">'+jsonInfo.keyword[i].name+'</td></tr>';
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
	function _viewInfo(i) { //선택했을 때
		if(document.getElementById('selectedBox').style.display=='none')
			document.getElementById('selectedBox').style.display='block';
	
		for(var k=0;k<cnt;k++) {
			if(arr[k]==jsonInfo.keyword[i].name) { //이미 선택했다면
				alert("이미 선택했습니다.");
				return;
			}
		}
		var html='<tr><td>'+jsonInfo.keyword[i].name+'</td>';
		html+='<td style="padding:3% 0 3% 0;"><input type="button" value="삭제" class="btn btn-black px-2 py-1" onclick="_deleteInfo(this,'+cnt+')" style="float:right;margin-right:5%;font-size:15px;"></td></tr>';
		$('#selectedTable').append(html);
		cnt++;
		arr.push(jsonInfo.keyword[i].name);
	}
	
	function _deleteInfo(obj,cnt) { //선택한 품목 삭제
		var tb=document.getElementById("selectedTable");
		var row=obj.parentElement.parentElement;
		delete arr[cnt]; //arr에서 cnt번째 삭제
		tb.deleteRow(row.rowIndex);
		if(tb.rows.length==0)
			document.getElementById('selectedBox').style.display='none';
		
	}
	
	function _finish() {
		var rows=document.getElementById("selectedTable").rows.length;
		var content=document.getElementById('selectedTable').innerHTML;
		var result='';
		if(rows==0) {
			alert('품목을 1개 이상 선택하세요.');
			return;
		}
		for(var i=0;i<rows;i++) {
			var idx1=content.indexOf("<td>");
			var idx2=content.indexOf("</td>");
			result+=content.substring(idx1+4,idx2);
			result+=',';
			content=content.substring(idx2+5,content.length);
			
			idx1=content.indexOf("</tr>");
			content=content.substring(idx1+5,content.length);
		}
		opener._getItem(result);
    	close();
	}
	
</script>
</head>
<body>
  <div style="padding:5%;">
  	<!-- 검색창 -->
	<div class="form-group" style="margin-bottom:0;">
		<span class="icon ion-ios-search" style="position:absolute;top:6.0%;right:45px;"></span>
		<input type="text" name="word" id="word" placeholder="채소, 과일 입력" onKeyUp="searchByKeyword()" style="width:100%;">
	</div>
	
	<!-- 검색 결과 -->
   	<div id="resultBox">
		<div id="result"></div>
   	</div>
   	
    <!-- 선택한 항목 -->
	<div id="selectedBox">
		<table id="selectedTable">
		</table>
	</div>
	<input type="button" class="btn btn-primary py-3 px-5" value="완료" onclick="_finish()" style="display:block;margin:3% auto 3% auto;">	
   </div>
</body>
</html>