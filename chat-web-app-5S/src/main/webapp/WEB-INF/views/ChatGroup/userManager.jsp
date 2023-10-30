<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Quản lí danh sách nhóm</title>
    <meta name="description" content="#">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link href="<c:url value="/static/dist/css/lib/bootstrap.min.css" />" type="text/css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@9">
    <script type="text/javascript" src="<c:url value="/static/js/ShowAnnotation.js" />" charset="utf-8"></script>
    <style>
        body {
            font-family: 'Roboto', sans-serif;
        }

        .main {
            order: 1;
        }

        .start.row {
            justify-content: center;
        }

        .text-center {
            text-align: center;
        }

        .custom-button {
            margin: 10px;
        }
    </style>
</head>
<body class="start">
<% Object showAnno = request.getAttribute("showAnno"); %>
<script>
    var rqValue = '<%=showAnno%>';
    if (rqValue == 0) {

    } else if (rqValue == 1) {
        showAnnotation('Thay đổi thành công', 'Đã khóa tài khoản người dùng!', 1);
    } else if (rqValue == 3) {
        showAnnotation('Không hợp lệ', 'Bạn không thể khóa chính mình!', 0);
    } else {
        showAnnotation('Thay đổi thành công', 'Đã mở khóa tài khoản người dùng!', 1);
    }
</script>
<main >
    <div class="main" style="padding-top: 60px;">
        <div class="start row">
        		<a href="<c:url value="/index"/>" class="back-button">
					<i class="fas fa-long-arrow-alt-left" style="font-size: 24px; padding: 15px;"></i>
		        </a>
            <div class="col-sm-9 text-dark">
                <h1 class="text-center" >Danh sách người dùng</h1>
                <form action="UploadServlet" method="post" enctype="multipart/form-data">
                    Chọn tệp Excel: <input type="file" name="file" />
                    <input type="submit" value="Tải lên" />
                </form>
                <a href="<c:url value="/bill"/>" class="float-right">
	                    <button class="btn btn-primary custom-button"><i class="fas fa-print"></i></button>
	                </a>
                
                
                    <button id="blockButton" class="btn btn-success custom-button">Khóa tất cả</button>
                    <button id="UnblockButton" class="btn btn-danger custom-button">Mở khóa tất cả</button>
              
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
                                <td class="text-center">
                                    <c:choose>
                                        <c:when test="${item.getIs_active()}">
                                            <form action="#" method="post">
                                                <button formaction="<c:url value="/userManager/${item.getUsername() }"/>" class="btn btn-success" type="submit">
                                                    <i class="fas fa-unlock-alt"></i>
                                                </button>
                                            </form>
                                        </c:when>
                                        <c:otherwise>
                                            <form action="#" method="post">
                                                <button formaction="<c:url value="/userManager/${item.getUsername() }"/>" class="btn btn-danger" type="submit">
                                                    <i class="fas fa-lock"></i>
                                                </button>
                                            </form>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                    
                </table>
            </div>
            
        </div>
        
    </div>
    
</main>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
<script src="https://kit.fontawesome.com/1654745691.js" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
<script>
    document.getElementById("blockButton").addEventListener("click", function (event) {
        event.preventDefault();

        Swal.fire({
            title: 'Xác nhận khóa tất cả các thành viên',
            text: 'Bạn có chắc chắn muốn vô hiệu hóa tất cả người dùng không?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: 'Có',
            cancelButtonText: 'Không',
        }).then((result) => {
            if (result.isConfirmed) {
                var xhr = new XMLHttpRequest();
                xhr.open("GET", "<c:url value='/userBlock' />", true);
                xhr.onreadystatechange = function () {
                    if (xhr.readyState === 4) {
                        if (xhr.status === 200) {
                            Swal.fire('Đã khóa tất cả thành viên', '', 'success').then((result) => {
                                if (result.isConfirmed) {
                                    window.location.href = "<c:url value='/userManager' />";
                                }
                            });
                        } else {
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

    document.getElementById("UnblockButton").addEventListener("click", function (event) {
        event.preventDefault();

        Swal.fire({
            title: 'Xác nhận mở khóa tất cả thành viên',
            text: 'Bạn có chắc chắn muốn mở khóa tất cả thành viên không?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: 'Có',
            cancelButtonText: 'Không',
        }).then((result) => {
            if (result.isConfirmed) {
                var xhr = new XMLHttpRequest();
                xhr.open("GET", "<c:url value='/userUnblock' />", true);
                xhr.onreadystatechange = function () {
                    if (xhr.readyState === 4) {
                        if (xhr.status === 200) {
                            Swal.fire('Đã mở khóa tất cả thành viên', '', 'success').then((result) => {
                                if (result.isConfirmed) {
                                    window.location.href = "<c:url value='/userManager' />";
                                }
                            });
                        } else {
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
