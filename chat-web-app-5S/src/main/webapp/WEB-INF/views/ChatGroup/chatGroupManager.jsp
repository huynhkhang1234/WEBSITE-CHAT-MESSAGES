<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Quản lí người dùng</title>
    <meta name="description" content="#">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link href="<c:url value="/static/dist/css/lib/bootstrap.min.css" />" type="text/css" rel="stylesheet">
    <link href="<c:url value="/static/dist/css/changepass.css" />" type="text/css" rel="stylesheet">
    <link href="<c:url value="/static/dist/img/favicon.png" />" type="image/png" rel="icon">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@9">
    <script type="text/javascript" src="<c:url value="/static/js/ShowAnnotation.js" />" charset="utf-8"></script>
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
<body>
<%
	Object showAnno = request.getAttribute("showAnno");
	%>

	<script>
	 	var rqValue = '<%=showAnno%>
		';

		if (rqValue == 0) {

		} else if (rqValue == 1) {
			showAnnotation('Thay đổi thành công',
					'Đã khóa tài khoản người dùng!', 1);
		} else {
			showAnnotation('Thay đổi thành công',
					'Đã mở khóa tài khoản người dùng!', 1);
		}
	</script>
<main class="container">
    <div class="row">
        <div class="col-sm-12">
            <a href="<c:url value="/index"/>" class="back-button">
		<i class="fas fa-long-arrow-alt-left" style="font-size: 24px; padding: 15px;"></i>
            </a>
            <h1 class="page-title">Danh sách nhóm cấm chat</h1>
            <button id="blockButton" class="btn btn-success custom-button">Khóa chat tất cả</button>
            <button id="UnblockButton" class="btn btn-danger custom-button">Mở khóa chat tất cả</button>
            <table class="table table-bordered">
                <thead class="thead-dark">
                    <tr>
                        <th>STT</th>
                        <th>Tên nhóm</th>
                        <th>Trạng thái</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${listU}" var="item" varStatus="loop">
                        <tr>
                            <td>${loop.index + 1}</td>
                            <td>${item.getName()}</td>
                            <td>
    <span class="${item.getIsActive().trim() == '0' ? 'badge-danger lock-icon' : 'btn btn-success unlock-icon'}">
        <i class="${item.getIsActive().trim() == '0' ? '' : ''}"></i>
        ${item.getIsActive().trim() == '0' ? 'Đã khóa' : 'Hoạt động'}
    </span>
</td>

                            <td>
                                <form action="#" method="post">
                                    <button formaction="<c:url value="/userManager/group/${item.getName()}"/>" class="btn btn-sm">
                                        <i class="${item.getIsActive().trim() == '0' ? 'fas fa-lock lock-icon' : 'fas fa-unlock-alt unlock-icon'}"></i>
                                    </button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</main>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
<script src="https://kit.fontawesome.com/1654745691.js" crossorigin="anonymous"></script>

<script>
document.getElementById("blockButton").addEventListener("click", function (event) {
    event.preventDefault(); // Ngăn chặn hành vi mặc định của nút

    Swal.fire({
        title: 'Xác nhận khóa tất cả chat nhóm',
        text: 'Bạn có chắc chắn muốn khóa tất cả chat không?',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonText: 'Có',
        cancelButtonText: 'Không',
    }).then((result) => {
        if (result.isConfirmed) {
            // Nếu người dùng xác nhận khóa, thực hiện gửi yêu cầu lên máy chủ
            var xhr = new XMLHttpRequest();
            xhr.open("GET", "<c:url value='/chatBlock' />", true);
            xhr.onreadystatechange = function () {
                if (xhr.readyState === 4) {
                    if (xhr.status === 200) {
                        // Nếu khóa tài khoản thành công, hiển thị thông báo
                        Swal.fire('Khóa chat thành công', '', 'success').then((result) => {
                            if (result.isConfirmed) {
                                // Sau khi đóng thông báo thành công, có thể thực hiện các hành động khác
                                // Chẳng hạn, chuyển đến một trang khác
                                window.location.href = "<c:url value='/userManager/group' />";
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
        title: 'Xác nhận mở khóa tất cả chat',
        text: 'Bạn có chắc chắn muốn mở khóa tất cả chat không?',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonText: 'Có',
        cancelButtonText: 'Không',
    }).then((result) => {
        if (result.isConfirmed) {
            // Nếu người dùng xác nhận khóa, thực hiện gửi yêu cầu lên máy chủ
            var xhr = new XMLHttpRequest();
            xhr.open("GET", "<c:url value='/chatUnBlock' />", true);
            xhr.onreadystatechange = function () {
                if (xhr.readyState === 4) {
                    if (xhr.status === 200) {
                        // Nếu khóa tài khoản thành công, hiển thị thông báo
                        Swal.fire('Mở khóa chat thành công', '', 'success').then((result) => {
                            if (result.isConfirmed) {
                                // Sau khi đóng thông báo thành công, có thể thực hiện các hành động khác
                                // Chẳng hạn, chuyển đến một trang khác
                                window.location.href = "<c:url value='/userManager/group' />";
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
