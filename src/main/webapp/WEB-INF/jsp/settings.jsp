
<html>
<head>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<title>设置</title>

<%-- <link rel="stylesheet" type="text/css" href="<%=basePath%>css/base.css"> --%>
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/login.css">
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>css/bootstrap.css">
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>css/bootstrapValidator.min.css">
<link rel="stylesheet"
	href="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="http://tjs.sjs.sinajs.cn/open/api/js/wb.js?appkey=2885420509"
	type="text/javascript" charset="utf-8"></script>
<script
	src="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<script src="http://cdn.bootcss.com/blueimp-md5/1.1.0/js/md5.js"></script>


</head>
<body>
	<canvas id="canvas"></canvas>
	<base id="baseUrl" href="<%=basePath%>+" /"/>
	<div class="wrap"
		style="position: fixed; top: 0px; left: 0px; right: 0px; bottom: 0px; margin-top: 90px; margin-left: 35px;">
		<header>
				<h1>
				<font size="6">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;短信设置</font>
			</h1>
			<script type="text/javascript">
				function login() {
					//这是使用ajax的方式提交
					$.ajax({
								type : 'post',
								url : '/api/login.do',
								//data:$('#loginInputForm').serialize(),
								data : {
									'userName' : $("#userName").val(),
									'password' : $("#password").val(),
									'randomCode' : $("#VerificationCode").val(),
								},
								dataType : 'json',
								success : function(obj) {
									var rad = Math.floor(Math.random()
											* Math.pow(10, 8));
									if (obj && obj.success == 'true') {
										window.location.href = 'Uase/login.action';
									} else {
										<%-- var token="<%=session.getAttribute("token")%>"; --%>
										alert(obj.msg+"  token:"+obj.token);
										document.getElementById("verification_Code").innerHTML = obj.msg;
										//uuuy是随便写的一个参数名称，后端不会做处理，作用是避免浏览器读取缓存的链接
										$("#randCodeImage").attr(
												"src",
												"VerificationCode/generate.do?uuuy="
														+ rad);
										$("#VerificationCode").val("").focus(); // 清空并获得焦点
									}
								}
							});
				}

				/**
				 *验证码刷新
				 */
				function VerificationCode() {
			
					var rad = Math.floor(Math.random() * Math.pow(10, 8));
					//uuuy是随便写的一个参数名称，后端不会做处理，作用是避免浏览器读取缓存的链接
					$("#randCodeImage").attr("src",
							"VerificationCode/generate.do?uuuy=" + rad);
					
				
				}
			</script>
		</header>








		<section>
	
			<div class="input-chunk">
				<form id="myform" name="myform" action="/api/uploadExcel.do"
					method="post" enctype="multipart/form-data"
					onsubmit="return check();" style="width:350px;" >

					<div class="modal-body">
						<div class="input-group">
							<span class="input-group-addon">电话号码：</span> <input type="text"
								id="userName" class="form-control" placeholder="请输入电话号码">

						</div>

						<div class="input-group" style="margin-top: 5px;">
							<span class="input-group-addon">&nbsp;&nbsp;&nbsp;节点一：</span> <input type="password"
								id="password" class="form-control" placeholder="编辑内容">
						</div>
						<div class="input-group" style="margin-top: 5px;">
							<span class="input-group-addon">&nbsp;&nbsp;&nbsp;节点二：</span> <input type="password"
								id="password" class="form-control" placeholder="编辑内容">
						</div>



						<div>
							<input type="button" value="发送" name="btnSubmit" onclick="login();"
								class="btn btn-default" id="btnSubmit" 
								style="margin-top: 5px; width: 330px;">
						</div>






					</div>
				</form>
			</div>


		</section>
	</div>


	<script type="text/javascript"
		src="<%=basePath%>/js/jquery-1.10.2.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>/js/login.js"></script>
	<script type="text/javascript"
		src="<%=basePath%>/js/bootstrapValidator.min.js"></script>
</body>
</html>






























