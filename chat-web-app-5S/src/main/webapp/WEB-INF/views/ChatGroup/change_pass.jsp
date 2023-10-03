<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
		<meta charset="utf-8">
		<title>Đổi mật khẩu</title>
		<meta name="description" content="#">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<link href="<c:url value="/static/dist/css/lib/bootstrap.min.css" />" type="text/css" rel="stylesheet">
		<link href="<c:url value="/static/dist/css/swipe.min.css" />" type="text/css" rel="stylesheet">
      	<link href="<c:url value="/static/dist/css/changepass.css" />" type="text/css" rel="stylesheet">
		<link href="<c:url value="/static/dist/img/favicon.png" />" type="image/png" rel="icon">	
	</head>
	<body class="start" style="font-family: 'Times New Roman', Times, serif">
		<main>  
			<div class="layout">
				<!-- Start of Sign In -->
				<div class="main order-md-1">
					<div class="start">
						<div class="container">
							<div class="col-md-12">
								<div class="content">
                                    <div id="border">
                                        <h3 style="color: black;">Đổi mật khẩu</h3>
									<form>
										<!-- <div class="form-group">
											<input type="text" id="inputEmail" class="form-control" placeholder="Nhập tài khoản" required>
											<button class="btn icon"><i class="material-icons">mail_outline</i></button>
										</div> -->
										<div class="form-group">
											<input type="password" id="inputPassword" class="form-control" placeholder="Nhập mật khẩu hiện tại" required>
											<button class="btn icon"><i class="material-icons">lock_outline</i></button>
										</div>
                                        <div class="form-group">
											<input type="password" id="inputPassword" class="form-control" placeholder="Nhập mật khẩu mới" required>
											<button class="btn icon"><i class="material-icons">lock_outline</i></button>
										</div>
                                        <div class="form-group">
											<input type="password" id="inputPassword" class="form-control" placeholder="Xác nhận mật khẩu mới" required>
											<button class="btn icon"><i class="material-icons">lock_outline</i></button>
										</div>
										<button type="submit" class="btn button" formaction="index.html">Đổi mật khẩu</button>
									</form>
                                    </div>
								</div>
							</div>
						</div>
					</div>
				</div>
				
			</div> <!-- Layout -->
		</main>
		<!-- Bootstrap core JavaScript
		================================================== -->
		<!-- Placed at the end of the document so the pages load faster -->
		<script type="text/javascript"
		 src="<c:url value="/static/dist/js/jquery-3.3.1.slim.min.js" />" charset="utf-8" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
		<script>window.jQuery || document.write('<script src="<c:url value="/static/dist/js/vendor/jquery-slim.min.js"><\/script>')</script>
		<script	type="text/javascript"
		 src="<c:url value="/static/dist/js/jquery-3.3.1.slim.min.js" />"></script>
		<script 
		src="<c:url value="static/dist/js/bootstrap.min.js" />" ></script>
	</body>

</html>