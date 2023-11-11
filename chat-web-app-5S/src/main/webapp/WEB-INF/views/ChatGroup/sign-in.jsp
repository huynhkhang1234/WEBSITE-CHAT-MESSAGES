<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<title>Poly chat</title>
<meta name="description" content="#">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<!-- Bootstrap core CSS -->
<link href="<c:url value="/static/dist/css/lib/bootstrap.min.css" />"
	type="text/css" rel="stylesheet">
<link href="<c:url value="/static/dist/css/swipe.min.css" />"
	type="text/css" rel="stylesheet">
<link href="<c:url value="/static/dist/img/favicon.png" />"
	type="image/png" rel="icon">
	<!-- File JavaScript riêng -->
<script type="text/javascript"
	src="<c:url value="/static/js/ShowAnnotation.js" />" charset="utf-8"></script>
<!-- Bao gồm thư viện SweetAlert2 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@9">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body class="start" style="font-family: 'Times New Roman', Times, serif">

	<%
	Object annotationLG = request.getAttribute("annotationLG");
	%>

	<script>
 	var annotationLGValue = '<%=annotationLG%>';

		if (annotationLGValue == 1) {

		} else if (annotationLGValue == 2) {
			showAnnotation('Đăng nhập thất bại',
					'Vui lòng kiểm tra lại thông tin bạn đã nhập', 0);
			console.log('Print: dung khi dang nhap sai thong tin');
		} else if (annotationLGValue == 3) {
			showAnnotation('Đăng nhập thất bại',
					'Rất tiếc. Tài khoản của bạn đã bị khóa', 0);
			console.log('Print: dung khi dang nhap dung nhung tk bi khoa');
		} else if (annotationLGValue == 5) {
			showAnnotation('Đăng kí tài khoản thành công',
					'', 1);
			
		} else {
			console.log('Không cần thông báo');
			console.log('Print: nothing');
		}
	</script>

	<main>
		<div class="layout">
			<!-- Start of Sign In -->
			<div class="main order-md-1">
				<div class="start">
					<div class="container">
						<div class="col-md-12">
							<div class="content">
								<h1>Đăng nhập</h1>
								<!-- <label class="btn btn-image" for="attach"> 
									<i class="fa fa-file"></i></label> -->

						<!-- 		<div class="third-party">
									<button class="btn item bg-blue">
										<i class="material-icons">pages</i>
									</button>
									<button class="btn item bg-teal">
										<i class="material-icons">party_mode</i>
									</button>
									<button class="btn item bg-purple">
										<i class="material-icons">whatshot</i>
									</button>
								</div> -->
								<!--  <p>Hoặc bắt đầu với email của bạn:</p> -->
								<form action="<c:url value="/login" />" method="POST">
									<div class="form-group">
										<input type="text" name="username" id="inputUsername"
											class="form-control" placeholder="Tài khoản" required>
										<button class="btn icon">
											<i class="material-icons">person_outline</i>
										</button>
									</div>
									<div class="form-group">
										<input type="password" name="password" id="inputPassword"
											class="form-control" placeholder="Password" required>
										<button class="btn icon">
											<i class="material-icons">lock_outline</i>
										</button>
									</div>
									<button type="submit" class="btn button">Đăng nhập</button>
									<div class="callout">
										<span>Bạn không có tài khoản? <a href="sign-up.html">Tạo
												tài khoản</a></span>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- End of Sign In -->
			<!-- Start of Sidebar -->
			<div class="aside order-md-2">
				<div class="container">
					<div class="col-md-12">
						<div class="preference">						
							<img
								style="width: 544px; margin-left: -106px;"
								src="<c:url value='/static/images/logo5s.png' />" alt="Logo">
								<span>
								<h1>Chat Unity</h1>
								<span>Được thiêt kế bởi nhóm: 5S POLY</span>
								</span>
								
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
