<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>Quản lí danh sách nhóm</title>
<meta name="description" content="#">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link href="<c:url value="/static/dist/css/lib/bootstrap.min.css" />"
	type="text/css" rel="stylesheet">
<link href="<c:url value="/static/dist/css/swipe.min.css" />"
	type="text/css" rel="stylesheet">
<link href="<c:url value="/static/dist/css/changepass.css" />"
	type="text/css" rel="stylesheet">
<link href="<c:url value="/static/dist/img/favicon.png" />"
	type="image/png" rel="icon">

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
<script type="text/javascript"
	src="<c:url value="/static/js/ShowAnnotation.js" />" charset="utf-8"></script>
<!-- Bao gồm thư viện SweetAlert2 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@9">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
 <style>
       body {
    font-family: 'Roboto', sans-serif;
}


        .container {
            margin-top: 50px;
        }

        .custom-button {
            background-color: #007BFF;
            color: #fff;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-right: 10px;
        }

        .custom-button:last-child {
            margin-right: 0;
        }

        .back-button {
            font-size: 18px;
            text-decoration: none;
            color: #007BFF;
            margin-right: 10px;
        }

        .back-button i {
            margin-right: 5px;
        }

        .page-title {
            font-size: 24px;
            font-weight: bold;
        }

        .table {
            margin-top: 20px;
        }

        .table th, .table td {
            text-align: center;
        }

/*         .lock-icon { */
/* 	    color: red; /* Đổi màu chữ thành màu đỏ */  */
/* } */
/* 		.unlock-icon { */
/*     color: green; /* Đổi màu chữ thành màu xanh lá cây */ */
/* } */

    </style>
</head>
<body class="start" style="font-family: 'Times New Roman', Times, serif">

	<%
	Object showAnno = request.getAttribute("showAnno");
	%>

	<script>
	 	var rqValue = '<%=showAnno%>';

		if (rqValue == 0) {

		} else if (rqValue == 1) {
			showAnnotation('Thay đổi thành công',
					'Đã khóa tài khoản người dùng!', 1);
		}else if (rqValue == 3) {
			showAnnotation('Không hợp lệ',
					'Bạn không thể khóa chính mình!', 0);
		} else {
			showAnnotation('Thay đổi thành công',
					'Đã mở khóa tài khoản người dùng!', 1);
		}
	</script>

	<main>
		<!-- Start of Sign In -->
		<div class="main order-md-1">
			<div class="start row">
				<div class="col-sm-9 text-dark">
					<span style="text-align: center;">
						<h1>Danh sách người dùng</h1>
						<button id="blockButton">Khóa tất cả</button>
					    <button id="UnblockButton">Mở khóa tất cả</button>
					    <form action="UploadServlet" method="post" enctype="multipart/form-data">
    Chọn tệp Excel: <input type="file" name="file" />
    <input type="submit" value="Tải lên" />
	</form>
						 <a style="font-size: 18px"
						href="<c:url value="/index"/>">					
							<button style="font-size: 18px" 
								class="btn button w-100">Trở lại</button>
					</a>		
					<a href="<c:url value="/bill"/>" >
						<button>
						<i class="fa fa-print" aria-hidden="true"></i>
						</button>
					</a>			
					
					</span>

					<table class="table table-bordered">
						<thead>
							<tr class="font-weight-bold text-center">
								<th>STT</th>
								<th>Username</th>
								<th>Role</th>
								<th>Trạng thái</th>
								<th>Act</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${listU}" var="item" varStatus="loop">
								<tr>
									<td>${loop.index + 1}</td>
									<td>${item.getUsername() }</td>
									<td>${item.isAdmin()?'Admin':'User' }</td>
									<td>${item.getIs_active()?'Hoạt động':'Đã khóa' }</td>
									<td class="text-center"><c:choose>
											<c:when test="${item.getIs_active()}">
												<%--   <a href="<c:url value="${item.getUsername() }"/>">
											               <i class="fas fa-lock"></i>
											            </a> --%>
												<form action="#" method="post">
												
												<button
														formaction="<c:url value="/userManager/${item.getUsername() }"/>"
														class="btn" type="submit">
														<i class="fas fa-unlock-alt"></i>
													</button>
													
												</form>
											</c:when>
											<c:otherwise>
												<form action="#" method="post">
													<button
														formaction="<c:url value="/userManager/${item.getUsername() }"/>"
														class="btn" type="submit">
														<i class="fas fa-lock"></i>
													</button>
												</form>
											</c:otherwise>
										</c:choose></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>

	</main>
	<!-- Bootstrap core JavaScript
		================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
	<%--<script type="text/javascript"
		 src="<c:url value="/static/dist/js/jquery-3.3.1.slim.min.js" />" charset="utf-8" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
		<script>window.jQuery || document.write('<script src="<c:url value="/static/dist/js/vendor/jquery-slim.min.js"><\/script>')</script>
		<script	type="text/javascript"
		 src="<c:url value="/static/dist/js/jquery-3.3.1.slim.min.js" />"></script>--%>
	<script src="<c:url value="/static/dist/js/bootstrap.min.js" />"></script>
	
	<script>
	document.getElementById("blockButton").addEventListener("click", function (event) {
	    event.preventDefault(); // Ngăn chặn hành vi mặc định của nút

	    Swal.fire({
	        title: 'Xác nhận khóa tất cả các thành viên',
	        text: 'Bạn có chắc chắn muốn vô hiệu hóa tất cả người dùng không?',
	        icon: 'warning',
	        showCancelButton: true,
	        confirmButtonText: 'Có',
	        cancelButtonText: 'Không',
	    }).then((result) => {
	        if (result.isConfirmed) {
	            // Nếu người dùng xác nhận khóa, thực hiện gửi yêu cầu lên máy chủ
	            var xhr = new XMLHttpRequest();
	            xhr.open("GET", "<c:url value='/userBlock' />", true);
	            xhr.onreadystatechange = function () {
	                if (xhr.readyState === 4) {
	                    if (xhr.status === 200) {
	                        // Nếu khóa tài khoản thành công, hiển thị thông báo
	                        Swal.fire('Đã khóa tất cả thành viên', '', 'success').then((result) => {
	                            if (result.isConfirmed) {
	                                // Sau khi đóng thông báo thành công, có thể thực hiện các hành động khác
	                                // Chẳng hạn, chuyển đến một trang khác
	                                window.location.href = "<c:url value='/userManager' />";
	                            }
	                        });
	                    } else {
	                        // Xử lý trường hợp nếu có lỗi khi khóa tài khoản
	                        Swal.fire('Lỗi', 'Có lỗi xảy ra khi khóa tài khoản.', 'error');
	                    }
	                }
	            };
	            xhr.send();
	        } else {
	            // Người dùng từ chối khóa, không làm gì cả
	        }
	    });
	});
	// bấm vô ko khóa tài khoảng.
	
	document.getElementById("UnblockButton").addEventListener("click", function (event) {
	    event.preventDefault(); // Ngăn chặn hành vi mặc định của nút

	    Swal.fire({
	        title: 'Xác nhận mở khóa tất cả thành viên',
	        text: 'Bạn có chắc chắn muốn mở khóa tất cả thành viên không?',
	        icon: 'warning',
	        showCancelButton: true,
	        confirmButtonText: 'Có',
	        cancelButtonText: 'Không',
	    }).then((result) => {
	        if (result.isConfirmed) {
	            // Nếu người dùng xác nhận khóa, thực hiện gửi yêu cầu lên máy chủ
	            var xhr = new XMLHttpRequest();
	            xhr.open("GET", "<c:url value='/userUnblock' />", true);
	            xhr.onreadystatechange = function () {
	                if (xhr.readyState === 4) {
	                    if (xhr.status === 200) {
	                        // Nếu khóa tài khoản thành công, hiển thị thông báo
	                        Swal.fire('Đã mở khóa tất cả thành viên', '', 'success').then((result) => {
	                            if (result.isConfirmed) {
	                                // Sau khi đóng thông báo thành công, có thể thực hiện các hành động khác
	                                // Chẳng hạn, chuyển đến một trang khác
	                                window.location.href = "<c:url value='/userManager' />";
	                            }
	                        });
	                    } else {
	                        // Xử lý trường hợp nếu có lỗi khi khóa tài khoản
	                        Swal.fire('Lỗi', 'Có lỗi xảy ra khi khóa tài khoản.', 'error');
	                    }
	                }
	            };
	            xhr.send();
	        } else {
	            // Người dùng từ chối khóa, không làm gì cả
	        }
	    });
	});

</script>
</body>

</html>