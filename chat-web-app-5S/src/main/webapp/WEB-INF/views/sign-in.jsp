<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<c:url value='/static/dist/css/lib/bootstrap.min.css' />">
<link rel="stylesheet" href="<c:url value='/static/dist/css/swipe.min.css' />">
<link rel="icon" type="image/png" href="<c:url value='/static/dist/img/favicon.png' />">
</head>
<body class="start">
		<main>
			<div class="layout">
				<!-- Start of Sign In -->
				<div class="main order-md-1">
					<div class="start">
						<div class="container">
							<div class="col-md-12">
								<div class="content">
									<h1>Sign in to Swipe</h1>
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
									<p>or use your email account:</p>
									<form>
										<div class="form-group">
											<input type="email" id="inputEmail" class="form-control" placeholder="Email Address" required>
											<button class="btn icon"><i class="material-icons">mail_outline</i></button>
										</div>
										<div class="form-group">
											<input type="password" id="inputPassword" class="form-control" placeholder="Password" required>
											<button class="btn icon"><i class="material-icons">lock_outline</i></button>
										</div>
										<button type="submit" class="btn button" formaction="index-2.html">Sign In</button>
										<div class="callout">
											<span>Don't have account? <a href="sign-up.html">Create Account</a></span>
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
								<h2>Hello, Friend!</h2>
								<p>Enter your personal details and start your journey with Swipe today.</p>
								<a href="sign-up.html" class="btn button">Sign Up</a>
							</div>
						</div>
					</div>
				</div>
				<!-- End of Sidebar -->
			</div> <!-- Layout -->
		</main>
<script src="<c:url value='/static/dist/js/jquery-3.3.1.slim.min.js' />"></script>
<script>
    if (!window.jQuery) {
        document.write('<script src="/static/dist/js/vendor/jquery-slim.min.js"><\/script>');
    }
</script>

<script src="/static/dist/js/vendor/popper.min.js"></script>
<script src="/static/dist/js/swipe.min.js"></script>
<script src="/static/dist/js/bootstrap.min.js"></script>

</body>
</html>