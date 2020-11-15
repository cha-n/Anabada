<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" 
    isELIgnored="false"  %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장소 변경</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<link rel="stylesheet" href="${contextPath }/resources/eunji/css/style.css">
<style>
	.text1 {
		width:400px;
		font-size:15px;
	}
</style>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script> 
<script>
	function _sendLocat() {
		if($('#dong_name').val()!='') {
			var area=$('select[name=area]').val();
			var dong_name=$('#dong_name').val();
			var dong=$('select[name=dong]').val();
			var locat=area+" "+dong_name+dong;
			opener._getLocat(locat);
	    	close();
		}
		else {
			alert("[동,면,읍]의 이름을 입력해주세요.")
		}
	}
</script>
</head>
<body>
	<div style="font-size:17px;text-align:center;margin:3rem 0 3rem 0;">
	<select name="area" id="area" style="font-size:17px;width:80px;height:30px;">
		<option value="서울">서울</option>
		<option value="인천">인천</option>
		<option value="대전">대전</option>
		<option value="부산">부산</option>
		<option value="광주">광주</option>
		<option value="울산">울산</option>
		<option value="대구">대구</option>
		<option value="세종">세종</option>
		<option value="경기">경기</option>
		<option value="강원">강원</option>
		<option value="충북">충북</option>
		<option value="충남">충남</option>
		<option value="전남">전남</option>
		<option value="경북">경북</option>
		<option value="경남">경남</option>
		<option value="제주">제주</option>
	</select>
	
	<input type="text" name="dong_name" width="200px" id="dong_name" style="font-size:17px;height:31px;">
	<select name="dong" id="dong" style="font-size:17px;height:30px;">
		<option value="읍">읍</option>
		<option value="면">면</option>
		<option value="동">동</option>
	</select>
	
	<input type="button" value="완료" onclick="_sendLocat()" style="font-size:17px;" class="btn btn-primary py-1 px-3">
	</div>
</body>
</html>