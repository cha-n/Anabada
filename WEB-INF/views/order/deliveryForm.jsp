<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" 
    isELIgnored="false"  %>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
  <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html>
<meta charset="UTF-8">
<html lang="en">
  <head>
    <title>Anabada</title>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
   <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    
    <link href="https://fonts.googleapis.com/css?family=Poppins:200,300,400,500,600,700,800&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Lora:400,400i,700,700i&display=swap" rel="stylesheet">
   <link href="https://fonts.googleapis.com/css?family=Amatic+SC:400,700&display=swap" rel="stylesheet">

    <link href="<c:url value="resources/eunji/css/open-iconic-bootstrap.min.css" />" rel="stylesheet">
    <link href="<c:url value="resources/eunji/css/animate.css" />" rel="stylesheet">
    
   <link rel="stylesheet" href="${contextPath }/resources/eunji/css/open-iconic-bootstrap.min.css">
   <link rel="stylesheet" href="${contextPath }/resources/eunji/css/animate.css">
      
   <link rel="stylesheet" href="${contextPath }/resources/eunji/css/owl.carousel.min.css">
   <link rel="stylesheet" href="${contextPath }/resources/eunji/css/owl.theme.default.min.css">
   <link rel="stylesheet" href="${contextPath }/resources/eunji/css/magnific-popup.css">
   
   <link rel="stylesheet" href="${contextPath }/resources/eunji/css/aos.css">
   
   <link rel="stylesheet" href="${contextPath }/resources/eunji/css/ionicons.min.css">
   
   <link rel="stylesheet" href="${contextPath }/resources/eunji/css/bootstrap-datepicker.css">
   <link rel="stylesheet" href="${contextPath }/resources/eunji/css/jquery.timepicker.css">
   
      
   <link rel="stylesheet" href="${contextPath }/resources/eunji/css/flaticon.css">
   <link rel="stylesheet" href="${contextPath }/resources/eunji/css/icomoon.css">
   <link rel="stylesheet" href="${contextPath }/resources/eunji/css/style.css">
   
  </head>
<title>Insert title here</title>
<style>
   table {
      margin-left:auto;
      margin-right:auto;
      width:70%;
      border-collapse: collapse;
      text-align:center;
   }
   tr.line {
      border-bottom-color:gray;
      border-bottom-width:1px;
      border-bottom-style:solid;
   }
</style>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>

   function view_Detail(articleNO) { //판매글로 이동
      location.href = "${contextPath}/seller/viewArticle?articleNO="+ articleNO;
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
               //document.getElementById("a_warning").innerHTML="";
             }
           }).open();
   }
   
   function msg_Select() { //select 태그 보이게 하기
      var deliveryMsg=document.getElementById("deliveryMsg");
      if(deliveryMsg.options[deliveryMsg.selectedIndex].value=="0") {
         document.getElementById("MsgSpan").style.display="block";
         document.getElementById("MsgSpan").innerHTML="<input type='text' id='Msg' name='Msg' maxlength='35'>";
      }
      else {
         document.getElementById("MsgSpan").style.display="none";
         document.getElementById("MsgSpan").innerHTML="";
      }
   }
   
   
   function _pay(obj) {
      if($("#addressDetail").val()=="") {
         alert("상세주소를 입력해주세요.");
         $("#addressDetail").focus();
      }
      else if($("#_phone1").val()=="") {
         alert("핸드폰 번호를 입력해주세요.");
         $("#_phone1").focus();
      }
      else if($("#Msg").val()=="") {
         alert("배송 요청사항을 입력해주세요.");
         $("#Msg").focus();
      }
      else if(document.getElementById("pay_method").value=="") {
         alert("결제수단을 선택해주세요.");
      }
      
      else if($("#pay_method").val()=="무통장입금" && $("#depositName").val()=="") {
         alert("입금자명을 입력해주세요.");
         $("#depositName").focus();
      }
      else {
         $("#phoneNum").val($("#_phone1").val()+"-"+$("#_phone2").val()+"-"+$("#_phone3").val());
         
         var deliveryMsg=document.getElementById("deliveryMsg");
         var selectedMsg=deliveryMsg.options[deliveryMsg.selectedIndex].value;
         if(selectedMsg!=0) {
            $("#msg").val(selectedMsg);
         }
         else { //배송 요청사항이 직접입력일 때
            $("#msg").val($("#Msg").val());
         }
         
         if($("#pay_method").val()=="무통장입금") {
            var _bank=document.getElementById("_bank1");
            var bank=_bank.options[_bank.selectedIndex].value;
            $("#bank").val(bank);
         }
         
         if($("#pay_method").val()=="카드결제") {
            var _bank=document.getElementById("_bank2");
            var bank=_bank.options[_bank.selectedIndex].value;
            $("#bank").val(bank);
         }
         
         $.ajax({
            type:"post",
            async:false,
            url:"${contextPath}/order/addOrder",
            data:$("#deliveryForm").serialize(),
            success:function(data) {
               if(data!="") {
                  document.getElementById("resultOrderNO").value=data;
                  obj.submit();
               }
               else {
                  alert("오류가 발생했습니다.다시 시도해주세요.");
                  location.href='${contextPath}/main';
               }
            },
            error:function(data) {
               alert("오류가 발생했습니다.다시 시도해주세요.");
               location.href='${contextPath}/main';
            }
         });
      }
   }
   function open_Deposit() { //무통장입금 div 열기
      document.getElementById("depositButton").style.background="skyblue";
      document.getElementById("cardButton").style.background="lightgray";
      
      document.getElementById("cardDiv").style.display="none";
      document.getElementById("depositDiv").style.display="block";
      
      
      document.getElementById("depositSpan").innerHTML='<input type="hidden" id="bank" name="bank">';
      document.getElementById("depositNameSpan").innerHTML='<input type="text" size="6" id="depositName" name="depositName" maxlength="6">';
      document.getElementById("cardSpan").innerHTML="";
      $("#pay_method").val("무통장입금");
   }
   
   function open_Card() { //카드결제 div 열기
      document.getElementById("depositButton").style.background="lightgray";
      document.getElementById("cardButton").style.background="skyblue";
      
      document.getElementById("depositDiv").style.display="none";
      document.getElementById("cardDiv").style.display="block";
      
      
      document.getElementById("cardSpan").innerHTML='<input type="hidden" id="bank" name="bank">';
      document.getElementById("depositSpan").innerHTML="";
      document.getElementById("depositNameSpan").innerHTML="";
      $("#pay_method").val("카드결제");
   }
</script>
</head>
<body class="goto-here">
    <nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light" id="ftco-navbar">
       <div class="container">
         <a class="navbar-brand" href="${contextPath }/main">Anabada</a>
         <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav" aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
           <span class="oi oi-menu"></span> Menu
         </button>

         <div class="collapse navbar-collapse" id="ftco-nav">
           <ul class="navbar-nav ml-auto">
             <li class="nav-item active"><a href="${contextPath }/main" class="nav-link">Home</a></li>
             <li class="nav-item dropdown">
              <a class="nav-link dropdown-toggle" href="#" id="dropdown04" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Shop</a>
              <div class="dropdown-menu" aria-labelledby="dropdown04">
                 <a class="dropdown-item" href="${contextPath }/seller/listArticles">공동구매</a>
                 <a class="dropdown-item" href="${contextPath}/share/boardList">나눔</a>
                 <a class="dropdown-item" href="${contextPath }/board/boardList">판매</a>
                <a class="dropdown-item" href="${contextPath}/exchange/boardList">교환</a>
              </div>
            </li>
            
            <c:if test="${member ne null}">
            <li class="nav-item dropdown">
               <a class="nav-link dropdown-toggle" href="#" id="dropdown04" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">My Page</a>
                 <div class="dropdown-menu" aria-labelledby="dropdown04">
                    <a class="dropdown-item" href="${contextPath }/board/myBookmark">북마크</a>
                    <a class="dropdown-item" href="${contextPath }/board/myBoardList?user=${member.n_name}">내가 쓴 글</a>
                    <a class="dropdown-item" href="${contextPath}/listBox">메시지함</a>
                     <a class="dropdown-item" href="${contextPath}/order/myOrder">내 주문</a>
                  <a class="dropdown-item" href="${contextPath}/member/myInfo">내 정보</a>
                  <a class="dropdown-item" href="${contextPath}/seller/myReview">내 리뷰</a>
                 </div>
            </li>
            </c:if>
            
             <!-- <li class="nav-item cta cta-colored"><a href="cart.html" class="nav-link"><span class="icon-shopping_cart"></span>[0]</a></li> -->
           <c:if test="${member eq null}">
              <li class="nav-item"><a href="${contextPath }/member/loginForm" class="nav-link">Sign In / Sign Up</a></li> <!-- 로그인 url 링크-->
           </c:if>
           <c:if test="${member ne null}">
            <li class="nav-item"><a href="${contextPath }/cart/myCart" class="nav-link" >Cart</a></li> <!-- 회원가입 url 링크-->
              <li class="nav-item"><a href="${contextPath }/member/logout" class="nav-link">LogOut</a></li> <!-- 로그아웃 url 링크-->
           </c:if>
           </ul>
         </div>
       </div>
     </nav>
    <!-- END nav -->

    <div class="hero-wrap hero-bread" style="background-image: url('${contextPath }/resources/eunji/images/bg_1.jpg');">
      <div class="container">
        <div class="row no-gutters slider-text align-items-center justify-content-center">
          <div class="col-md-9 ftco-animate text-center">
             <p class="breadcrumbs"><span class="mr-2"><a href="index.html">Home</a></span> <span>Checkout</span></p>
            <h1 class="mb-0 bread">주문</h1>
          </div>
        </div>
      </div>
    </div>

    <section class="ftco-section">
      <div class="container">
        <div class="row justify-content-center">
          <div class="col-xl-7 ftco-animate">
                  <form name="deliveryForm" id="deliveryForm" method="post" action="${contextPath }/order/completed" class="billing-form">
                   <input type="hidden" name="resultOrderNO" id="resultOrderNO">
                     <h3 class="mb-4 billing-heading">주문 상세</h3>
                <div class="row align-items-end">
                   <div class="col-md-6">
                   <div class="form-group">
                      <label for="firstname">이름</label>
                     <input type="text" class="form-control" placeholder="${member.name }">
                   </div>
                 </div>
                <div class="w-100"></div>
                  <div class="col-md-6">
                     <div class="form-group">
                        <label for="country">주소</label>
                        <input type="text" class="form-control" placeholder="${member.address }">
                        <input type="hidden" name="address" id="address" value="${member.address }">
                     </div>
                  </div>
                  <div class="w-100"></div>
                  <div class="col-md-12">
                     <div class="form-group">
                      <label for="streetaddress">상세 주소</label>
                     <input type="text" class="form-control" name="addressDetail" id="addressDetail" placeholder="상세 주소를 입력하세요.">
                     <b id="a_warning"></b>
                   </div>
                  </div>
                  <div class="w-100"></div>
                  <div class="w-100"></div>
                  <div class="col-md-6">
                   <div class="form-group">
                      <label for="phone">전화 번호</label>
                     <input type="text" class="form-control" id="_phone1" placeholder="">
                     <input type="hidden" id="phoneNum" name="phoneNum">
                   </div>
                 </div>
                 <div class="col-md-12">
               <div class="form-group">
                  <label for="country">배송 시 요청 사항</label>
                  <div class="select-wrap">
                 <div class="icon"><span class="ion-ios-arrow-down"></span></div>
                 <select name="" id="deliveryMsg" class="form-control" onchange="msg_Select()">
                 <option value="요청 사항 없음">요청 사항 없음</option>
                  <option value="배송 전 연락바랍니다.">배송 전 연락바랍니다.</option>
                  <option value="부재중 일 시 연락 바랍니다.">부재중 일 시 연락 바랍니다. </option>
                  <option value="경비실에 보관 바랍니다.">경비실에 보관 바랍니다.</option>
                  <option value="문 앞에 보관 바랍니다.">문 앞에 보관 바랍니다.</option>
                  <option value="초인종을 대신 노크 바랍니다.">초인종을 대신 노크 바랍니다.</option>
                  <option value="무인 택배함에 보관 바랍니다.">무인 택배함에 보관 바랍니다.</option>
                 </select>
               </div>
               </div>
            </div>
                <div class="w-100"></div>
                <div class="col-md-12">
                </div>
               </div>
             </form><!-- END -->
               </div>
         <c:set var="resultPrice" value="0" />
           <c:forEach  var="cart" items="${cartList }" varStatus="num">
            <tr>
                 <td style="text-align:left;">
                    <input type="hidden" name="articleNO${num.count }" value="${cart.articleNO }">
                 </td>
                 <td>
                    <input type="hidden" id="quantity${num.count}" name="quantity${num.count}" value="${cart.quantity }">
                 </td>
                 <td>
                    <input type="hidden" name="price${num.count }" id="price${num.count }" value=${cart.articleVO.price * cart.quantity } />
                    <c:set var= "resultPrice" value="${resultPrice + cart.articleVO.price * cart.quantity}"/>
                 </td>
              </tr>
           </c:forEach>
               <div class="col-xl-5">
             <div class="row mt-5 pt-3">
                <div class="col-md-12 d-flex mb-5">
                   <div class="cart-detail cart-total p-3 p-md-4">
                      <h3 class="billing-heading mb-4">결제 정보</h3>
                      <p class="d-flex">
                            <span>금액</span>
                            <span>${resultPrice}원</span>
                         </p>
                         <p class="d-flex">
                            <span>배송료</span>
                            <span>2,500원</span>
                         </p>
                         <p class="d-flex">
                            <span>할인</span>
                            <span>0원</span>
                         </p>
                         <hr>
                         <p class="d-flex total-price">
                            <span>결제 금액</span>
                            <span>${resultPrice+2500 }원</span>
                         </p>
                        </div>
                </div>
                <input type="hidden" id="pay_method" name="pay_method">
                <div class="col-md-12">
                   <div class="cart-detail p-3 p-md-4">
                      <h3 class="billing-heading mb-4">결제 방법</h3>
                           <div class="form-group">
                              <div class="col-md-12">
                                 <div class="radio">
                                    <label><input type="radio" name="optradio" class="mr-2"> 무통장 입금</label>
                                 </div>
                              </div>
                           </div>
                           <div class="form-group">
                              <div class="col-md-12">
                                 <div class="radio">
                                    <label><input type="radio" name="optradio" class="mr-2"> 신용카드</label>
                                 </div>
                              </div>
                           </div>
                           <div class="form-group">
                              <div class="col-md-12">
                                 <div class="checkbox">
                                    <label><input type="checkbox" value="" class="mr-2">결제 정보 저장합니다.</label>
                                 </div>
                              </div>
                           </div>
                           <input type="button" class="btn btn-primary py-3 px-4" value="결제" onclick="_pay(this.form)">
                        </div>
                </div>
             </div>
          </div> <!-- .col-md-8 -->
        </div>
      </div>
    </section> <!-- .section -->

    <footer class="ftco-footer ftco-section">
      <div class="container">
         <div class="row">
            <div class="mouse" style="margin-top: 50px;">
                    <a href="#" class="mouse-icon">
                       <div class="mouse-wheel"><span class="ion-ios-arrow-up"></span></div>
                    </a>
                 </div>
         </div>
         <div class="col-md" style="margin-top: 50px;">
           <div class="ftco-footer-widget mb-4">
              <h2 class="ftco-heading-2">Have a Questions?</h2>
              <div class="block-23 mb-3">
               <ul>
                 <li><span class="icon icon-map-marker"></span><span class="text">인천광역시 연수구 송도1동 아카데미로 119</span></li>
                 <li><a href="#"><span class="icon icon-phone"></span><span class="text">010.3333.1532</span></a></li>
                 <li><a href="#"><span class="icon icon-envelope"></span><span class="text">anabada@gmail.com</span></a></li>
               </ul>
              </div>
           </div>
         </div>
        </div>
        <div class="row" style="margin-top: 100px; margin-bottom: 10px;">
         <div class="col-md-12 text-center">
           <p><!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                     Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="icon-heart color-danger" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
                     <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                    </p>
         </div>
        </div>
      </div>
     </footer>
    
  

  <!-- loader -->
  <div id="ftco-loader" class="show fullscreen"><svg class="circular" width="48px" height="48px"><circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee"/><circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#F96D00"/></svg></div>


  <script src="${contextPath }/resources/eunji/js/jquery.min.js"></script>
  <script src="${contextPath }/resources/eunji/js/jquery-migrate-3.0.1.min.js"></script>
  <script src="${contextPath }/resources/eunji/js/popper.min.js"></script>
  <script src="${contextPath }/resources/eunji/js/bootstrap.min.js"></script>
  <script src="${contextPath }/resources/eunji/js/jquery.easing.1.3.js"></script>
  <script src="${contextPath }/resources/eunji/js/jquery.waypoints.min.js"></script>
  <script src="${contextPath }/resources/eunji/js/jquery.stellar.min.js"></script>
  <script src="${contextPath }/resources/eunji/js/owl.carousel.min.js"></script>
  <script src="${contextPath }/resources/eunji/js/jquery.magnific-popup.min.js"></script>
  <script src="${contextPath }/resources/eunji/js/aos.js"></script>
  <script src="${contextPath }/resources/eunji/js/jquery.animateNumber.min.js"></script>
  <script src="${contextPath }/resources/eunji/js/bootstrap-datepicker.js"></script>
  <script src="${contextPath }/resources/eunji/js/scrollax.min.js"></script>
  <script src="${contextPath }/resources/eunji/js/main.js"></script>

  <script>
      $(document).ready(function(){

      var quantitiy=0;
         $('.quantity-right-plus').click(function(e){
              
              // Stop acting like a button
              e.preventDefault();
              // Get the field name
              var quantity = parseInt($('#quantity').val());
              
              // If is not undefined
                  
                  $('#quantity').val(quantity + 1);

                
                  // Increment
              
          });

           $('.quantity-left-minus').click(function(e){
              // Stop acting like a button
              e.preventDefault();
              // Get the field name
              var quantity = parseInt($('#quantity').val());
              
              // If is not undefined
            
                  // Increment
                  if(quantity>0){
                  $('#quantity').val(quantity - 1);
                  }
          });
          
      });
   </script>
    
  </body>
</html>