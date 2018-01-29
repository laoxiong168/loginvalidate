
<html>
<head>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<title>登录</title>

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
				<font size="6">系统登录&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font>
			</h1>
			<script type="text/javascript">
				function login() {
					//这是使用ajax的方式提交
					$.ajax({
								type : 'post',
								url : '/sms/login.do',
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
										window.location.href = "/sms/settings.do";
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
					onsubmit="return check();" style="width:250px;" >

					<div class="modal-body">
						<div class="input-group">
							<span class="input-group-addon">账号：</span> <input type="text"
								id="userName" class="form-control" placeholder="请输入账号">

						</div>

						<div class="input-group" style="margin-top: 5px;">
							<span class="input-group-addon">密码：</span> <input type="password"
								id="password" class="form-control" placeholder="请输入密码">
						</div>


						<div id="btn_area">
							<input type="text" id="VerificationCode" name="VerificationCode"
								class="form-control" placeholder="请输入验证码" class="verify"
								style="width: 110px;margin-top: 5px;margin-right: 10px;float: left;">
						</div>
						<div style="display: inline-block;">
							<a href="javascript:void(0);" onclick="VerificationCode()"> <img
								id="randCodeImage" alt="验证码" src="VerificationCode/generate.do"
								width="100" height="45" />
							</a>
						</div>

						<div>
							<input type="button" value="登录" name="btnSubmit" onclick="login();"
								class="btn btn-default" id="btnSubmit" 
								style="margin-top: 5px; width: 220px;">
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






























