<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="utf-8">
	<title>Quên mật khẩu</title>
	<meta name="description" content="#">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<!-- Bootstrap core CSS -->
	<link href="<c:url value="/static/dist/css/lib/bootstrap.min.css" />" type="text/css" rel="stylesheet">
	<!-- Swipe core CSS -->
	<link href="<c:url value="/static/dist/css/swipe.min.css" />" type="text/css" rel="stylesheet">
	<!-- Favicon -->
	<link href="<c:url value="/static/dist/img/favicon.png" />" type="image/png" rel="icon">	
	<!--sử dụng icon-->
	<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
</head>

<body class="start" style="font-family: 'Times New Roman', Times, serif">
	<main>
		<div class="layout">
			<!-- Start of Sign Up -->
			<div class="main order-md-2">
				<div class="start">
					<div class="container">
						<div class="col-md-12">
							<div class="content">
								<h1 class="name">Quên mật khẩu</h1>
								<div class="third-party">
									<button class="btn item bg-blue">
										<i class="material-icons">pages</i>
									</button>
									<button class="btn item bg-teal">
										<i class="material-icons">party_mode</i>
									</button>
									<button class="btn item bg-purple">
										<i class="material-icons">whatshot</i>
									</button>
								</div>
								<p>Hoặc bắt đầu với email của bạn:</p>
								
								<form class="signup">
										<div class="form-group">
											<input type="email" id="inputEmail" class="form-control"
												placeholder="Địa chỉ email" required>
											<button class="btn icon"><i class="material-icons">mail_outline</i></button>
										</div>

									<button type="submit" class="btn button" formaction="">Gửi</button>
									<div class="callout">
										<span>Bạn đã có tài khoản? <a href="sign-in.html">Đăng nhập</a></span>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- End of Sign Up -->
			<!-- Start of Sidebar -->
			<div class="aside order-md-1">
				<div class="container">
					<div class="col-md-12">
						<div class="preference">
							<h2>Chào mừng bạn</h2>
							<p>Đăng nhập ngay để không bỏ lỡ những điều thú vị.</p>
							
							<a  href="<c:url value="/users/login"/>" class="btn button">Đăng nhập</a> <br> <br>							
							<a  href="<c:url value="/users/changepass"/>" class="btn button">Đổi mật khẩu</a>
						</div>
					</div>
				</div>
			</div>
			<!-- End of Sidebar -->
		</div> <!-- Layout -->
	</main>
	<!-- Bootstrap core JavaScript
		================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
<script type="text/javascript"
		 src="<c:url value="/static/dist/js/jquery-3.3.1.slim.min.js" />" charset="utf-8" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
	<script>window.jQuery || document.write('<script  src="<c:url value="/static/dist/js/vendor/jquery-slim.min.js"/>" charset="utf-8" ><\/script>')</script>
	<script type="text/javascript"
		 src="<c:url value="/static/dist/js/vendor/popper.min.js" />" charset="utf-8" ></script>
	<script type="text/javascript"
		  src="<c:url value="/stactic/dist/js/bootstrap.min.js" />" charset="utf-8" ></script>
</body>


</html>