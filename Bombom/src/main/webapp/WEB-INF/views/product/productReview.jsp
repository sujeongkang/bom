<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }" />

<style>
/*상품문의 박스 스타일*/
div.wrap-category {
	margin: 7px 0px 7px 0px;
	text-align: left;
}
.span_textarea {
	position: relative;
	padding: 8px;
	width: auto;
	border: lightslategray 1px solid;
	border-radius: 4px;
	display: inline-block;
	width: 100%;
	height: 200px;
}
textarea {
	width: 99%;
	height: 80%;
	resize: none;
	border: none;
}
textarea:focus {
	outline: none;
}
textarea.inqContent {
	width: 100%;
	height: 100%;
	resize: none;
	border: none;
	margin: 7px 0 7px 0;
}
textarea.answer {
	width: 100%;
	height: 100%;
	resize: none;
	border: none;
	margin: 7px 0 7px 0;
}
/* 별점 css */
.rating .rate_radio {
	position: relative;
	display: inline-block;
	z-index: 20;
	opacity: 0.001;
	width: 20px;
	height: 20px;
	background-color: #fff;
	cursor: pointer;
	vertical-align: top;
	/* 체크박스 안 보이게  */
	display: none;
}
.rating .rate_radio+label {
	position: relative;
	display: inline-block;
	/* margin-left: -4px; */
	margin: 0 0 -4px -3px;
	z-index: 10;
	width: 20px;
	height: 20px;
	background-image: url('../resources/images/product/starblank.png');
	background-repeat: no-repeat;
	background-size: 20px 20px;
	cursor: pointer;
	background-color:
}
.rating .rate_radio:checked+label {
	background-image: url('../resources/images/product/star.png');
}


/* 구매평 */
.review_span {
	height: 250px;
}
#review_textarea {
	height: 50%;
}
.accordion_title {
	display: flex;
	position: relative;
}
.plusminus::before {
	content: '';
	display: block;
	width: 24px;
	height: 3px;
	background-color: #45A663;
	position: absolute;
	right: 0;
	transform: rotate(90deg);
	transition: .5s;
	margin: 10px;
}
.plusminus::after {
	content: '';
	display: block;
	width: 24px;
	height: 3px;
	background-color: #45A663;
	position: absolute;
	right: 0;
	transform: rotate(0deg);
	margin: 10px;
}
.plusminus.active::before {
	transform: rotate(0deg);
}
.accordion_title:hover {
	cursor: pointer;
}
.accordion_title {
	margin: 10px;
}
.accordion_title:active .shortContent {
	style: none;
}
.accordion_content {
	display: block;
	margin: 0;
	height: 0;
	overflow: hidden;
	transition: .5s;
}
.accordion_content.show {
	margin: 10px;
}
.accordion_wrap {
	border-color: #E2E2E2;
	list-style: none;
	border-width: 1px 0 0 0;
	border-style: solid;
	padding: 0px;
}
.accordion_inner {
	border-color: #E2E2E2;
	list-style: none;
	border-width: 0 0 1px 0;
	border-style: solid;
	margin: 10px 0 0 0;
}
.pageBar{
	text-align: center;
}

#uploadImage1:hover{
	cursor:pointer;
}
#uploadImage2:hover{
	cursor:pointer;
}
</style>

	    	<!-- 구매평 시작 -->
		    	<input type="hidden" id="pdtNo" value="${pdtNo }"/>
			        <!--구매평 작성창-->
			        <form name="frm_review" action="${path}/review/insertReview" method="post" enctype="multipart/form-data" onsubmit="return fn_reviewCheck()" >
				        <div class="writebox_wrap container" style="float:none; margin:10px 0 10px 0;">
				            <button type="button" class="btn btn-success showBox">구매평 작성</button>
					        <div class="wrap-category" style="display:none;">
						        <span class="span_textarea review_span">
							        <textarea name="revContent" id="review_textarea" placeholder="구매평을 입력해주세요" onKeyUp="javascript:fnChkByte2(this,'500')"></textarea>
							        <div class="imgPreview" style="height:30%;"></div>
							        <div class="wrap_bottom">
							        <div style="float:left;left:0;bottom:0;">
							        	<!-- 업로드 사진 -->
							       		<img id="uploadImage1" src="${path}/resources/images/product/gallery.png" style="width:25px;height:25px;">&nbsp;
							       		<input type="file" id="upload1" name="upload1" accept="image/gif, image/jpeg, image/png" style="display:none;">
							       		<!-- 별점 -->
								        <div class="rating" style="display:inline-block;">
											<!-- 해당 별점을 클릭하면 해당 별과 그 왼쪽의 모든 별의 체크박스에 checked 적용 -->
											<input type="checkbox" id="rating1" name="rating" class="rate_radio" value="1">
											<label for="rating1"></label>
											<input type="checkbox" id="rating2" name="rating" class="rate_radio" value="2">
											<label for="rating2"></label>
											<input type="checkbox" id="rating3" name="rating" class="rate_radio" value="3">
											<label for="rating3"></label>
											<input type="checkbox" id="rating4" name="rating" class="rate_radio" value="4">
											<label for="rating4"></label>
											<input type="checkbox" id="rating5" name="rating" class="rate_radio" value="5">
											<label for="rating5"></label>
										</div>
									</div>
									<div style="float:right;">
									<span id="byteInfo2">0</span>/500bytes
										<!-- 로그인 한 사람 및 구매한 사람만 구매평 등록가능-->
								        <c:if test="${loginMember!=null }">
								        	<input type="hidden" name="pdtNo" value="${pdtNo}">
								        	<input type="hidden" name="memNo" value="${loginMember.memNo}">
								        	<input type="hidden" name="revScore">
								        	<input type="hidden" name="orderNo">
								        	<input type="submit" class="btn btn-success textCheck" value="등록" style="right:0;">
								        </c:if>
								        <c:if test="${loginMember==null }">
								        	<input type="button" class="btn btn-success loginCheck" value="등록" style="right:0;">
								        </c:if>
						        	</div>
						        	</div>
						        </span>
					        </div>
				        </div>
			        </form><!-- 구매평 작성창 끝 -->
			        
			        <!-- 구매평 게시글 -->
			        <div id="result">
			        	<div class="container">
				        	 <c:if test="${not empty reviewlist }">	
				        		 <ul class="accordion_wrap">
					        		 <c:forEach items="${reviewlist}" var="r">
									    <li class="accordion_inner">
									    <!-- 타이틀 -->
									      <div class="accordion_title">
									      	<div class="col-9">
									      		<!-- 별점 불러오기 -->
									      		<c:forEach begin="1" end="${r.revScore}" step="1" varStatus="vs"> 
									      			<img src="${path}/resources/images/product/star.png" style="width:20px;height:20px;margin:0 0 5px -3px;">
									      		</c:forEach>
									      		<c:forEach begin="1" end="${5-r.revScore}" step="1">
									      		 	<img src="${path}/resources/images/product/starblank.png" style="width:20px;height:20px;margin:0 0 5px -3px;">
									      		</c:forEach>
										      	<span><c:out value="${r.revScore}"/></span><br>
										      	<img src="${path }/resources/upload/profile/${r.memPro}" style="max-width:30px; height:30px;border-radius:50%;">&nbsp;
											      <span><strong><c:out value="${r.memNick}" /></strong></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span><fmt:formatDate type="both" timeStyle="short" value="${r.revDate }"/></span><br>
											     <c:out value="${r.revContent}"/>
									      	</div>
									      	<div class="col-2"><c:if test="${r.revImage!=null }"><img src="${path}/resources/upload/review/${r.revImage }" style="height:100%;"/></c:if></div>
									      	<div class="col-1 plusminus"></div>
									      </div>
									      <!-- 상세보기 -->
									      <div class="accordion_content">
									      	<div>
										        <!-- 작성자와 로그인한 사람이 같을경우 수정, 삭제 버튼 생성 -->
										        <c:if test="${loginMember.memNo==r.memNo }">
										        	<div style="display:inline-block;float:right;">
										        		<input type="hidden" name="revNo" value="${r.revNo}">
											        	<input type="button" class="btn btn-outline-success btn-sm updateView" data-toggle="modal" data-target="#updateReview" value="수정">
											        	<span style="display:none"><c:out value="${r.revNo}"/></span>
													    <span style="display:none"><c:out value="${r.memNick}"/></span>
													    <span style="display:none"><c:out value="${r.revScore}"/></span>
													    <span style="display:none"><c:out value="${r.revContent}"/></span>
													    <span style="display:none"><c:out value="${r.revImage}"/></span>
													    <span style="display:none"><fmt:formatDate type="both" timeStyle="short" value="${r.revDate }"/></span>
													    <span style="display:none"><c:out value="${r.memPro}"/></span>
						        						<input type="button" class="btn btn-outline-success btn-sm deleteReviewCk" data-confirm="구매평을 삭제하시겠습니까?" value="삭제">
										        	</div>
										        </c:if>
										        <br><br>
										        <c:if test="${r.revImage!=null }"><img src="${path}/resources/upload/review/${r.revImage }" style="max-width:40%; height:auto;min-width:auto;"/></c:if>
									      	</div>
									      </div>
									    </li>
									</c:forEach>    
								</ul>
								<div class="pageBar">
									<span>${pageBar }</span>
						    	</div>
							</c:if>
							<c:if test="${empty reviewlist }">
						    	등록된 구매평이 없습니다
						    </c:if>		    
			        	</div>
			        </div>
		    	</div><!-- 구매평 끝 -->
		    	
		    	<!-- 구매평 수정 모달창 -->
		   <div class="modal fade" id="updateReview">
		    <div class="modal-dialog modal-dialog-centered">
		      <div class="modal-content">
		      
		        <!-- Modal Header -->
		        <div class="modal-header">
		          <h4 class="modal-title">구매평 수정하기</h4>
		          <button type="button" class="close" data-dismiss="modal">X</button>
		        </div>
		        
		        <!-- Modal body -->
			        <div class="modal-body container">
			        	<!-- 구매평 내용 -->
			        	<form name="frm_inquiry" action="${path}/review/updateReview" method="post" enctype="multipart/form-data">
				        	<img id="memProimg">
				        	<strong><span class="memNick"></span></strong>&nbsp;&nbsp;<span class="revDate"></span>&nbsp;&nbsp;&nbsp;&nbsp;
							<div style="display:inline-block;">
								<input type="hidden" class="revNo" name="revNo" />
								<input type="hidden" name="pdtNo" value="${pdtNo}"/>
								<input type="hidden" class="revScore" name="revScore">
								<input type="hidden" class="revImage" name="revImage">
					        	<input type="submit" class="btn btn-outline-success btn-sm" value="수정완료">
				        	</div>
				        	<span class="span_textarea" style="margin: 10px 0 0 0;">
							    <textarea class="revContent" name="revContent" style="height:50%;" onKeyUp="javascript:fnChkByte3(this,'500')"></textarea>
							    	<div id="uploadPreview" style="height:30%;"><img id="imgPreview" style="height:30%;"></div>
							        <div class="wrap_bottom">
							        <div style="float:left;left:0;bottom:0;">
							        	<!-- 업로드 사진 -->
							       		<img id="uploadImage2" src="${path}/resources/images/product/gallery.png" style="width:25px;height:25px;">&nbsp;
							       		<input type="file" id="upload2" name="upload2" accept="image/gif, image/jpeg, image/png" style="display:none;">
							       		<!-- 별점 -->
								        <div class="rating" style="display:inline-block;">
											<!-- 해당 별점을 클릭하면 해당 별과 그 왼쪽의 모든 별의 체크박스에 checked 적용 -->
											<input type="checkbox" id="revrating1" name="revrating" class="rate_radio" value="1">
											<label for="revrating1"></label>
											<input type="checkbox" id="revrating2" name="revrating" class="rate_radio" value="2">
											<label for="revrating2"></label>
											<input type="checkbox" id="revrating3" name="revrating" class="rate_radio" value="3">
											<label for="revrating3"></label>
											<input type="checkbox" id="revrating4" name="revrating" class="rate_radio" value="4">
											<label for="revrating4"></label>
											<input type="checkbox" id="revrating5" name="revrating" class="rate_radio" value="5">
											<label for="revrating5"></label>
										</div>
									</div>
									<div style="float:right;">
									<span id="byteInfo3" style="display:none;">0</span><!-- /500bytes -->
						        	</div>
						        	</div>
						    </span>
					    </form>
			        </div>
		        
		      </div>
		    </div>
		  
<script>
	//구매평 아코디언
	window.onload = init();
	function init() {
	    const accordion_items = document.querySelectorAll(".accordion_title");
	    for (var i = 0; i < accordion_items.length; i++) {
	      accordion_items[i].addEventListener("click", function () {
	        this.nextElementSibling.classList.toggle("show");
	        this.classList.toggle("active");
	        if (this.classList.contains("active")) {
	          this.nextElementSibling.style.height =
	            this.nextElementSibling.children[0].clientHeight + 40 + "px";
	        } else {
	          this.nextElementSibling.style.height = 0;
	        }
	      });
	    }
	  }
	
	
	//구매평 작성 클릭 시 이벤트
	$(function() {
		$(".showBox").click(function() {
			
			//구매평 작성 전 로그인 한 사람이 구매한 지 확인!!!
			$.ajax({
				url:"${path}/review/selectOrder",
				data:{pdtNo:$("#pdtNo").val(), memNo:"${loginMember.memNo}"},
				type:"get",
				dataType:"text", //String 형으로 가져올 때
				success:data=>{
					console.log("야야야!!!"+data); 
					
					if(data!=""){
						let orderNo = $("input[name='orderNo']").val(data);
						//상품문의 클릭 시 박스 보였다가 안보였다가 이벤트
						if ($(this).next().css("display") == "none") {
							$(this).next().show(1000);
						} else {
							$(this).next().hide(1000);
						}
					}else{
						swal("상품평은 구매한 경우에만 작성하실 수 있습니다");
						return false;
					}
				}
			});
			
		});
	});
	
	
	//구매평 수정창 클릭시 모달창 띄움
	$(".updateView").click(function(){
		 let wrap = $(this).parent();
		 let choice = wrap.children("span");
		 
		 let revNo = choice.eq(0).text();
		 let memNick = choice.eq(1).text();
		 let revScore = choice.eq(2).text();
		 let revContent = choice.eq(3).text();
		 let revImage = choice.eq(4).text();
		 let revDate = choice.eq(5).text();
		 let memPro = choice.eq(6).text();
		 
		 $(".revNo").val(revNo);
		 $(".memNick").text(memNick);
		 $(".revScore").val(revScore);
		 $(".revContent").text(revContent);
		 $(".revImage").val(revImage);
		 
		 //별점이 있을경우 모달창에 별점 checked
		 for(var i=1; i<=revScore; i++){
			 $("input:checkbox[name='revrating']").each(function(){
				if(this.value==i){
				 this.checked = true;
				}
			 });
		 }
		 
		 //이미지가 있을경우 모달창에 이미지 넣어두기
		 if(revImage!=""){
			 $("#imgPreview").prop("src","${path}/resources/upload/review/"+revImage);
			 $("#imgPreview").prop("style","height:100%;");
			 $("input[name='upload2']").val(revImage);
		 }else{
			 $("#imgPreview").hide();
		 }
		 
		 $(".revDate").text(revDate);
		 $("#memProimg").prop("src","${path}/resources/upload/profile/"+memPro);
		 $("#memProimg").prop("style","max-width:30px; height:30px;border-radius:50%;");
	});
	
	//구매평 Byte 수 체크 제한
	function fnChkByte2(obj, maxByte) {
	  var str = obj.value;
	  var str_len = str.length;
	  var rbyte = 0;
	  var rlen = 0;
	  var one_char = "";
	  var str2 = "";
	  for(var i = 0; i<str_len; i++) {
	    one_char = str.charAt(i);
	    if(escape(one_char).length > 4) {
	      rbyte += 3; //한글2Byte
	    }else{
	      rbyte++; //영문 등 나머지 1Byte
	    }
	    if(rbyte <= maxByte){
	      rlen = i + 1; //return할 문자열 갯수
	    }
	  }
	  if(rbyte > maxByte) {
	    // alert("한글 "+(maxByte/2)+"자 / 영문 "+maxByte+"자를 초과 입력할 수 없습니다.");
	    swal("메세지는 최대 " + maxByte + "byte를 초과할 수 없습니다.");
	    str2 = str.substr(0, rlen); //문자열 자르기
	    obj.value = str2;
	    fnChkByte2(obj, maxByte);
	  }else{
	    document.getElementById("byteInfo2").innerText = rbyte;
	  }
	} 
	
	//구매평 수정하기 Byte 수 체크 제한
	function fnChkByte3(obj, maxByte) {
	  var str = obj.value;
	  var str_len = str.length;
	  var rbyte = 0;
	  var rlen = 0;
	  var one_char = "";
	  var str2 = "";
	  for(var i = 0; i<str_len; i++) {
	    one_char = str.charAt(i);
	    if(escape(one_char).length > 4) {
	      rbyte += 3; //한글2Byte
	    }else{
	      rbyte++; //영문 등 나머지 1Byte
	    }
	    if(rbyte <= maxByte){
	      rlen = i + 1; //return할 문자열 갯수
	    }
	  }
	  if(rbyte > maxByte) {
	    // alert("한글 "+(maxByte/2)+"자 / 영문 "+maxByte+"자를 초과 입력할 수 없습니다.");
	    swal("메세지는 최대 " + maxByte + "byte를 초과할 수 없습니다.");
	    str2 = str.substr(0, rlen); //문자열 자르기
	    obj.value = str2;
	    fnChkByte3(obj, maxByte);
	  }else{
	    document.getElementById("byteInfo3").innerText = rbyte;
	  }
	} 


	//구매평 페이징
	$(function(){
		$(".pageBar").click(e=>{
			//console.log($(e.target).val());
			$.ajax({
				url:"${path}/product/productReviewAjax",
				data:{cPage:"${cPage}",numPerpage:"${numPerPage}",pdtNo:"${pdtNo}"},
				type:"get",
				dataType:"html",
				success:data=>{
					//console.log(data);
					$("#result").html("");
					$("#result").html(data);
				}
			});
		});
	});

	
	//별점선택
	$(document).ready(function(){
		$("input[name=rating]").click(function(){
			if($(this).find("rate_radio")){
				rating.setRate(parseInt($(this).val()));
				//별점 점수
				console.log(rating.rate);
				$("input[type=hidden][name=revScore]").val(rating.rate);
			}
		});
	});
	
	//별점선택 안 했을 시 알림, 리뷰 5자 미만 시 알림
	function fn_reviewCheck(){
		if($("#review_textarea").val().length<5){
			swal("상품평을 5글자 이상 입력해주세요");
			return false;
		}
		if(rating.rate==0){
			swal("별점을 선택해주세요")
			return false;
		}
		
	}
	
	//구매평 사진 클릭 시 업로드 새창뜨기
	$("#uploadImage1").click(function(){
		$("#upload1").click();
	});
		
	$("#upload1").change(e => {
			let reader = new FileReader();
			reader.onload = e =>{
				let img = $("<img>").attr({"src":e.target.result,"style":"width:70px;height:auto"});
				
				$(".imgPreview").html("");
				$(".imgPreview").append(img);
			}
			reader.readAsDataURL($(e.target)[0].files[0]);
	});	
	
	
	//구매평 삭제, 구매평 지우려면 revNo가 필요할 것 같은데?
	$(".deleteReviewCk").on("click",function(e){
		e.preventDefault();
		var choice = confirm($(this).attr('data-confirm'));
		if(choice){
			let revNo = $(event.target).parents().children('input[name=revNo]').val();
			let pdtNo = $("#pdtNo").val();
			location.replace("${path}/review/deleteReview?revNo="+revNo+"&pdtNo="+pdtNo);
		}	
	});	
	
	//구매평 수정화면 사진 클릭 시 업로드 새창뜨기
	$("#uploadImage2").click(function(){
		$("#upload2").click();
	});
			
	$("#upload2").change(e => {
		let reader = new FileReader();
		reader.onload = e =>{
			let img = $("<img>").attr({"src":e.target.result,"style":"height:100%"});
			$("#uploadPreview").html("");
			$("#uploadPreview").append(img);
	   	}
		reader.readAsDataURL($(e.target)[0].files[0]);
	});	    
</script>		  