<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" 
    isELIgnored="false"  %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login</title>
<link rel="stylesheet" href="${contextPath }/resources/eunji/css/login/style.css?ver=3">

<script  src="http://code.jquery.com/jquery-latest.min.js"></script> 
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript">
	function _checkId() { //아이디 중복 검사
	    var id=$("#_id").val();
	    if (id==''){
	    	alert("아이디를 입력하세요.");
	    }
	    else if (id.length < 4) {
	    	alert("아이디는 영문 4자리 이상입니다.")
	    }
	    else {
		    $.ajax({
		       type:"post",
		       async:false,  
		       url:"${contextPath}/member/checkId",
		       data: {id : id},
		       success:function (data){
		          if(data=='false') {
		       	    alert("사용할 수 있는 아이디입니다.");
		       	    $('#idBtn').prop("disabled", true);
		       	    $('#_id').prop("disabled", true);
		       	    $('#id').val(id);
		       		document.getElementById("i_warning").innerHTML="";
		          }
		          else {
		        	  alert("사용할 수 없는 아이디입니다.");
		          }
		       },
		       error:function(data){
		          alert("오류가 발생했습니다. 다시 시도해주세요.");
		       },
		       complete:function(data){
		       }
		    });
	    }
	}
	
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
		       	 	document.getElementById("n_warning").innerHTML="";
		          }
		          else {
		        	  alert("사용할 수 없는 닉네임입니다.");
		          }
		       },
		       error:function(data){
		          alert("오류가 발생했습니다. 다시 시도해주세요.");
		       },
		       complete:function(data){
		       }
		    });
	    }
	}
	function _findAddress() { //주소 찾기
		new daum.Postcode({
			oncomplete: function(data) {
			      var roadAddr = data.roadAddress; // 도로명 주소 변수
			      var extraRoadAddr = ''; // 도로명 조합형 주소 변수
			      // 법정동명이 있을 경우 추가한다. (법정리는 제외)
			      // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
			      if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
			        extraRoadAddr += data.bname;
			      }
			      // 건물명이 있고, 공동주택일 경우 추가한다.
			      if(data.buildingName !== '' && data.apartment === 'Y'){
			        extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
			      }
			      // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
			      if(extraRoadAddr !== ''){
			        extraRoadAddr = ' (' + extraRoadAddr + ')';
			      }
			      // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
			      if(roadAddr !== ''){
			        roadAddr += extraRoadAddr;
			      }
			      // 우편번호와 주소 정보를 해당 필드에 넣는다.
			      document.getElementById('_address').value = roadAddr;
			      document.getElementById('address').value = roadAddr;
			      document.getElementById("a_warning").innerHTML="";
			    }
			  }).open();
	}
	
	function _checkNAME() { //이름이 안비어있는지 확인
		var name=document.getElementById("name").value;
		if(name!="" && name!=null) {
			document.getElementById("nn_warning").innerHTML="";
		}
	}
	
	function _pwdCheck() {//비밀번호가 일치하는지 확인
		  var pwd1=document.getElementById("pwd1").value;
		  var pwd2=document.getElementById("pwd2").value;
		  if(pwd1=="" || pwd2=="") {
			  document.getElementById("p_warning").innerHTML="";
			  document.getElementById("p1_warning").innerHTML="";
			  $('#pwdCheck').val('x');
		  }
		  
		  else if(pwd1!=pwd2) {
			  document.getElementById("p_warning").innerHTML="<br><font color=#FF9090 size=2.5pt>비밀번호가 일치하지 않습니다.</font>";
			  document.getElementById("p1_warning").innerHTML="";
			  $('#pwdCheck').val('x');
		  }
		  else if(pwd1==pwd2) {
			  document.getElementById("p_warning").innerHTML="<br><font color=#487BE1 size=2.5pt>비밀번호가 일치합니다.</font>";
			  document.getElementById("p1_warning").innerHTML="";
			  $('#pwdCheck').val('o');
		  }
	  }
	
	function _send(obj) {
		if(document.getElementById("_id").disabled==false) {
			$("#_id").focus();
			document.getElementById("i_warning").innerHTML="<font color=#FF9090 size=2.5pt>아이디를 입력해주세요.</font>";
		}
		else if(document.getElementById("name").value=="" || document.getElementById("name").value==null) {
			$("#name").focus();
			document.getElementById("nn_warning").innerHTML="<font color=#FF9090 size=2.5pt>이름을 입력해주세요.</font>";
		}
		else if(document.getElementById("_n_name").disabled==false) {
			$("#_n_name").focus();
			document.getElementById("n_warning").innerHTML="<font color=#FF9090 size=2.5pt>닉네임을 입력해주세요.</font>";
		}
		else if(document.getElementById("pwdCheck").value=='x') {
			if(document.getElementById("pwd1").value=='') {
				$("#pwd1").focus();
				document.getElementById("p1_warning").innerHTML="<br><font color=#FF9090 size=2.5pt>비밀번호를 입력해주세요.</font>";
			}
			else if(document.getElementById("pwd2").value=='') {
				$("#pwd2").focus();
				document.getElementById("p_warning").innerHTML="<br><font color=#FF9090 size=2.5pt>비밀번호를 입력해주세요.</font>";
			}
		}
		else if(document.getElementById("_address").value=='') {
			document.getElementById("a_warning").innerHTML="<font color=#FF9090 size=2.5pt>주소를 입력해주세요.</font>";
		}
		else {
			 obj.submit();
		}
		
	}
	
	function _login() {
		var id=$('#id_login').val();
		var pwd=$('#pwd_login').val();
		if(id=='') {
			alert("아이디를 입력해주세요.");
		}
		else if(pwd=='') {
			alert("비밀번호를 입력해주세요.");
		}
		else {
			$.ajax({
				type:"post",
			    async:false,  
			 	url:"${contextPath}/member/login",
			    data: {id : id,
			    	   pwd : pwd
			    },
			    success:function (data){
			    	if(data=='false') {
			    		alert("아이디나 비밀번호가 틀립니다.");
			    		$('#id_login').val('');
			    		$('#pwd_login').val('');
			    	}
			    	else {
			    		var action=$('#action').val();
			    		if(action=='')
			    			location.href='${contextPath}/main'; //메인
			    		else
			    			location.href='${contextPath}'+action;	
			    	}
			    },
			    error:function(data){
			    	alert("오류가 발생했습니다. 다시 시도해주세요.");
			    },
				complete:function(data){
				}
			});
		}
	}
</script>
</head>
<body>
	<div class="wrap">
		<div class="form-wrap">
			<div class="button-wrap">
            	<div id="btn"></div>
                <button type="button" class="togglebtn" onclick="login()">SIGN IN</button>
                <button type="button" class="togglebtn" onclick="register()">SIGN UP</button>
            </div>
			<!-- 로그인 -->
			<form name="addForm" id="login" class="input-group" method="post" action="${contextPath}/member/addMember">
			<input type="hidden" value="${action }" id="action">

	  		<input type="text" placeholder="아이디" id="id_login" name="id_login" class="input-field" maxlength="10" style="width:100%;">
			<input type="password" placeholder="비밀번호" id="pwd_login" name="pwd_login" class="input-field" maxlength="30" style="width:100%;">
			<br><br>
	  	  	<input type="button" class="submit" value="로그인" onclick="_login()" value="SIGN IN">
			</form>
			
            <!-- 회원가입 -->
			<form name="addForm" id="register" class="input-group" method="post" action="${contextPath}/member/addMember">
				<input type="text" class="input-field" id="_id" placeholder="영문 4자리 이상 아이디">
				<input type="hidden" name="id" id="id">
				<input type="button" id="idBtn" value="중복확인" onclick="_checkId()" style="background:#000000;border:1px solid #000000;color:#fff;border-radius:30px;padding:1%;font-size:12px;cursor:pointer;">
				<b id="i_warning"></b>
				<br>
				
				<input type="text" class="input-field" name="name" id="name" placeholder="이름" onkeyup="_checkNAME()" style="margin-right:20%;">
				<b id="nn_warning"></b>
				<br>
				
				<input type="text" class="input-field" id="_n_name" placeholder="닉네임">
				<input type="hidden" name="n_name" id="n_name">
				<input type="button" id="nameBtn" value="중복확인" onclick="_checkName()" style="background:#000000;border:1px solid #000000;color:#fff;border-radius:30px;padding:1%;font-size:12px;cursor:pointer;">
				<b id="n_warning"></b>
				<br>
		
			  	<input type="password" class="input-field" id="pwd1" name="pwd" placeholder="비밀번호" onkeyup="_pwdCheck()">
			  	<b id="p1_warning"></b>
				<br>
				
			  	<input type="password" class="input-field" id="pwd2" placeholder="비밀번호 확인" onkeyup="_pwdCheck()">
			  	<b id="p_warning"></b>
			  	<br>
			  	
			  	<input type="text" class="input-field" id="_address" placeholder="주소" disabled>
			  	<input type="hidden" name="address" id="address">
			  	<input type="button" value="주소찾기" onclick="_findAddress()" style="background:#000000;border:1px solid #000000;color:#fff;border-radius:30px;padding:1%;font-size:12px;cursor:pointer;">
			  	<br>
			  	<b id="a_warning"></b>
			  	<br>
			  	<input type="button" class="submit" value="SIGN UP" onclick="_send(this.form)">
				<input type="hidden" id="pwdCheck" value="x">
			</form>
			
		</div>
	</div>
	<script>
		var x = document.getElementById("login");
        var y = document.getElementById("register");
        var z = document.getElementById("btn");
                
        function login(){
        	x.style.left = "50px";
            y.style.left = "450px";
            z.style.left = "0";
        }

        function register(){
        	x.style.left = "-400px";
            y.style.left = "50px";
            z.style.left = "110px";
        }
    </script>
</body>
</html>