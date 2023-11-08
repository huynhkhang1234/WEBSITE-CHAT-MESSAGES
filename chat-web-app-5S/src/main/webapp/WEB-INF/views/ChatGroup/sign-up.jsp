<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<title>Đăng ký</title>
<meta name="description" content="#">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link href="<c:url value="/static/dist/css/lib/bootstrap.min.css" />"
	type="text/css" rel="stylesheet">
<link href="<c:url value="/static/dist/css/swipe.min.css" />"
	type="text/css" rel="stylesheet">
<link href="<c:url value="/static/dist/img/favicon.png" />"
	type="image/png" rel="icon">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- File JavaScript riêng -->
<script type="text/javascript"
	src="<c:url value="/static/js/ShowAnnotation.js" />" charset="utf-8"></script>
</head>

<body class="start" style="font-family: 'Times New Roman', Times, serif">
	<%
	Object annotationLG = request.getAttribute("annotationLG");
	%>

	<script>
 	var annotationLGValue = '<%=annotationLG%>';
 	
		if(annotationLGValue == 1){
			showAnnotation('Tên tài khoản đã tồn tại',
					'Vui lòng kiểm tra lại thông tin bạn đã nhập', 0);
			annotationLGValue = 0;
		}
		
			
	</script>
	
	<main>
		<div class="layout">
			<!-- Start of Sign Up -->
			<div class="main order-md-2">
				<div class="start">
					<div class="container">
						<div class="col-md-12">
							<div class="content">
								<h1 class="name">Tạo tài khoản</h1>
								<!-- <div class="third-party">
									<button class="btn item bg-blue">
										<i class="material-icons">pages</i>
									</button>
									<button class="btn item bg-teal">
										<i class="material-icons">party_mode</i>
									</button>
									<button class="btn item bg-purple">
										<i class="material-icons">whatshot</i>
									</button>
								</div>	 -->

								<form class="signup"
									action="<c:url value="/users-rest-controller" />" method="POST"
									enctype="multipart/form-data">


									<div class="form-parent">
										<div class="form-group">
											<input type="text" id="inputName" name="username"
												class="form-control" placeholder="Tên tài khoản" required>
											<button class="btn icon">
												<i class="material-icons">person_outline</i>
											</button>
										</div>

										<div class="form-group">
											<input style="padding-top: 10px; padding-left: 17px;"
												type="file" name="avarta" id="inputName"
												class="form-control" placeholder="Chọn avatar">

										</div>
									</div>

									<div class="form-group">
										<input type="password" id="inputPassword" name="password"
											class="form-control" placeholder="Mật khẩu" required>
										<button class="btn icon">
											<i class="material-icons">lock_outline</i>
										</button>
									</div>
									
									<div class="form-parent">
										<div class="form-group" style="width: 200px;">
											<select class="form-control" id="selectBoxGender"
												name="gender" required>
												<option value="true">Nam</option>
												<option value="false">Nữ</option>
												<option value="khac">Khác</option>
											</select>
											<button class="btn icon">
												<i class="material-icons">view_list</i>
											</button>
										</div>
										<div class="form-group" style="width: 250px;">
											<select class="form-control" id="selectBoxGender"
												name="isAdmin" required>
												<option value="false">User</option>
												<option value="true">Admin</option>
											</select>
											<button class="btn icon">
												<i class="material-icons">view_list</i>
											</button>
										</div>
									</div>
									<button type="submit" class="btn button">Đăng ký</button>
									<div class="callout">
										<span>Bạn đã có tài khoản? <a href="sign-in.html">Đăng
												nhập</a></span>
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
							<img style="width: 544px; margin-left: -106px;"
								src="<c:url value='/static/images/logo5s.png' />" alt="Logo">
						</div>
					</div>
				</div>
			</div>
			<!-- End of Sidebar -->
		</div>
		<!-- Layout -->
	</main>
	<!-- Bootstrap core JavaScript
		================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
	<script type="text/javascript"
		src="<c:url value="/static/dist/js/jquery-3.3.1.slim.min.js" />"
		charset="utf-8"
		integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
		crossorigin="anonymous"></script>
	<script>
		window.jQuery
				|| document
						.write('<script  src="<c:url value="/static/dist/js/vendor/jquery-slim.min.js"/>" charset="utf-8" ><\/script>')
	</script>
	<script type="text/javascript"
		src="<c:url value="/static/dist/js/vendor/popper.min.js" />"
		charset="utf-8"></script>
	<script type="text/javascript"
		src="<c:url value="/stactic/dist/js/bootstrap.min.js" />"
		charset="utf-8"></script>
</body>


</html>