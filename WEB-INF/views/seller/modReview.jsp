<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" 
    isELIgnored="false"  %>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	table {
		margin-left:auto;
		margin-right:auto;
		width:40%;
		border-collapse: collapse;
	}
	
	tr.line1 {
		border-top-color:gray;
		border-top-width:1px;
		border-top-style:dotted;
	}
	
	tr.line2 {
		border-bottom-color:gray;
		border-bottom-width:2px;
		border-bottom-style:solid;
	}
	
	.starImage {
		cursor:pointer;
	}
</style>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	function changeStar(num) {
		var num1=parseInt(num);
		for(i=1; i<=num1; i++) {
			var image=document.getElementById("star"+i);
			image.src="${contextPath}/resources/image/star.png";
		}
		for(i=num1+1; i<=5; i++) {
			var image=document.getElementById("star"+i);
			image.src="${contextPath}/resources/image/star2.png";
		}
		$("#star").val(num);
	}
	
	function modifyReview(obj) {
		if($("#content").val()=="") {
			alert("리뷰 내용을 입력해주세요.");
			return;
		}
		else if($("#content").val().length < 10) {
			alert("리뷰 내용을 더 입력해주세요.");
			return;	
		}
		else {
			obj.submit();
		}	
	}
</script>
</head>
<body>
  <h2 style="text-align:left;">상품 리뷰</h2>
  <form name="reviewForm" method="post" action="${contextPath}/seller/modifyReview">
	  <table>
	  	<tr class="line2">
	  		<td>
		  		${review.title }
		  	</td>
		  	<td style="text-align:end;"width="20%">
		  		${review.writedate }
		  	</td>
	  	</tr>
		<tr>
			<td colspan="2">별점
				<img src="${contextPath }/resources/image/star.png" width="20" height="20" id="star1" class="starImage" onclick="changeStar(1)" />
				<c:if test="${review.star == 1 }">
					<img src="${contextPath }/resources/image/star2.png" width="20" height="20" id="star2" class="starImage" onclick="changeStar(2)" />
					<img src="${contextPath }/resources/image/star2.png" width="20" height="20" id="star3" class="starImage" onclick="changeStar(3)" />
					<img src="${contextPath }/resources/image/star2.png" width="20" height="20" id="star4" class="starImage" onclick="changeStar(4)" />
					<img src="${contextPath }/resources/image/star2.png" width="20" height="20" id="star5" class="starImage" onclick="changeStar(5)" />
				</c:if>
				<c:if test="${review.star == 2 }">
					<img src="${contextPath }/resources/image/star.png" width="20" height="20" id="star2" class="starImage" onclick="changeStar(2)" />
					<img src="${contextPath }/resources/image/star2.png" width="20" height="20" id="star3" class="starImage" onclick="changeStar(3)" />
					<img src="${contextPath }/resources/image/star2.png" width="20" height="20" id="star4" class="starImage" onclick="changeStar(4)" />
					<img src="${contextPath }/resources/image/star2.png" width="20" height="20" id="star5" class="starImage" onclick="changeStar(5)" />
				</c:if>
				<c:if test="${review.star == 3 }">
					<img src="${contextPath }/resources/image/star.png" width="20" height="20" id="star2" class="starImage" onclick="changeStar(2)" />
					<img src="${contextPath }/resources/image/star.png" width="20" height="20" id="star3" class="starImage" onclick="changeStar(3)" />
					<img src="${contextPath }/resources/image/star2.png" width="20" height="20" id="star4" class="starImage" onclick="changeStar(4)" />
					<img src="${contextPath }/resources/image/star2.png" width="20" height="20" id="star5" class="starImage" onclick="changeStar(5)" />
				</c:if>			
				<c:if test="${review.star == 4 }">
					<img src="${contextPath }/resources/image/star.png" width="20" height="20" id="star2" class="starImage" onclick="changeStar(2)" />
					<img src="${contextPath }/resources/image/star.png" width="20" height="20" id="star3" class="starImage" onclick="changeStar(3)" />
					<img src="${contextPath }/resources/image/star.png" width="20" height="20" id="star4" class="starImage" onclick="changeStar(4)" />
					<img src="${contextPath }/resources/image/star2.png" width="20" height="20" id="star5" class="starImage" onclick="changeStar(5)" />
				</c:if>	
				<c:if test="${review.star == 5 }">
					<img src="${contextPath }/resources/image/star.png" width="20" height="20" id="star2" class="starImage" onclick="changeStar(2)" />
					<img src="${contextPath }/resources/image/star.png" width="20" height="20" id="star3" class="starImage" onclick="changeStar(3)" />
					<img src="${contextPath }/resources/image/star.png" width="20" height="20" id="star4" class="starImage" onclick="changeStar(4)" />
					<img src="${contextPath }/resources/image/star.png" width="20" height="20" id="star5" class="starImage" onclick="changeStar(5)" />
				</c:if>	
					
				<input type="hidden" value="${review.star }" id="star" name="star" />
			</td>
		</tr>
	  	<tr>
	  		<td colspan="2">
	  			<textarea id="content" name="content" rows="10" cols="60" maxlength="50" placeholder="10글자 이상 입력해주세요.">${review.content }</textarea>
	  		</td>
	  	</tr>
	  	<tr>
	  		<td colspan="2" style="text-align:center;"><input type="button" value="수정" onclick="modifyReview(this.form)" > </td>
	  	</tr>
	  </table>
  	  <input type="hidden" id="review_NO" name="review_NO" value="${review.review_NO }">
  </form>
  
</body>
</html>