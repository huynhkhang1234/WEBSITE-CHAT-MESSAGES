<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>
</head>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" />
<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js"
	integrity="sha512-GsLlZN/3F2ErC5ifS5QtgpiJtWd43JWSuIgh7mbzZ8zBps+dvLusV+eNQATqgA/HdeKFVgA5v3S/cIrLF7QnIg=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@9">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

  body {
	display: flex;
	align-items: center;
/* 	justify-content: center; */
	/* height: 100vh; */
	background: -webkit-linear-gradient(left, #25c481, #25b7c4);
} 

h1 {
	text-align: center;
	color: yellow;
	font-size: 2rem;
}

 #priceLevel {
	display: flex;
	margin: auto;
	padding: 7px 20px;
	border-radius: 4px;
	margin-top: 10px;
	margin-bottom: 25px;
	font-size: 1.5rem;
	text-align: center;
	background-color: rgb(190, 51, 51);
	color: #fff;
} 

table {
background: -webkit-linear-gradient(left, #25c481, #25b7c4);
	text-align: center;
	font-size: 2.4rem;
	border-collapse: collapse; */
	border: 1px solid rgb(223, 212, 212);
	width: 100%;
} 

 table th {
	color: chartreuse;
	padding-top: 14px;
	padding-bottom: 14px;
	font-size: 18px;
}  

 
table thead {
	background-color: #25c481;
} 

 tfoot th:first-child {
	color: #fff;
	animation-name: showColor;
	animation-duration: 4s;
	animation-timing-function: ease;
	animation-iteration-count: 3;
	animation-direction: alternate-reverse;
} 

 tbody tr {
	letter-spacing: 1px;
	font-size: 20px;
	color: blanchedalmond;
	padding: 4px 0px;
}  

tfoot tr {
	font-size: 20px;
	color: black;
}

.container {
    /* position: fixed; */
    top: 0;
    left: 0;
    width: 100%;
}
.row {
    position: relative;
}

.col-12 {
    position: sticky;
    top: 0; 
}

</style>

<body>

	<div class="container"
		style="width: 210mm; background: -webkit-linear-gradient(left, #25c481, #25b7c4);">
		<div class="row "
			style="text-align: center; background: -webkit-linear-gradient(left, #25c481, #25b7c4);">
			<div class="col-12" style="display: flex;">
				<div class="col-1">
					<img src="<c:url value='/static/images/pdf.png' />" class="logo"
						style="width: 72px; margin-left: 30px; margin-top: 12px">
						<a 	href="<c:url value="/index"/>" style="color: yellow; text-decoration: underline;"> Trở về</a>
				</div>
				
				<div
					style="margin-left: 91px; padding-top: 15px; font-size: 18px; display: flex; align-items: center; justify-content: space-evenly; width: 100%">
					<span style="color: yellow;"> DANH SÁCH THÔNG TIN TÀI KHOẢNG USER  
						</span> <br> <span><button
							style="background: aquamarin; color: blue; padding: 10px; border-radius: 18px; border: none;"
							class="print">Xuất file PDF</button></span>
				</div>
			</div>
			<div class="col-12">

				<p class="bill"
					style="font-size: 20px; margin-top: -12px; color: blanchedalmond;">DANH SÁCH</p>
			</div>
		</div>
		<div class="tt"
			style="margin-top: 11px; font-size: 18px; color: palegreen; text-align: left; letter-spacing: 2px;">	
		</div>
		<div class="row">
			<div class="col-12">
				<table class="table">
					<thead>
						<tr style="text-align: center;">
							<th style="text-align: center;">Số thứ tự</th>
							<th style="text-align: center;">Họ và tên</th>
							<th>Vai trò</th>
							<th>Trạng thái</th>
						</tr>
					</thead>
					<tbody style="text-align: center;">
						<c:forEach var="item" items="${listUserBill}" varStatus="loop">
							<tr>
									<td>${loop.index + 1}</td>
								<td>${item.getUsername() }</td>
									<td>${item.isAdmin()?'Admin':'User' }</td>
							<td>${item.getIs_active()?'Hoạt động':'Đã khóa' }</td>
								
							</tr>							
						</c:forEach>
					</tbody>																								
				</table>
				
			</div>		
		</div>
	</div>
	
	<script src="https:code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>

        let div = document.querySelector(".table");
        let btn = document.querySelector(".print");
        var opt = {
            filename: 'Danh-sach-thong-tin-tai-khoang.pdf',
            margin: 1,
            pageWidth: 5000,

        };
        btn.addEventListener("click", function (event) {
    	    event.preventDefault(); // Ngăn chặn hành vi mặc định của nút

    	    Swal.fire({
    	        title: 'Bạn chắc chắn xuất file PDF?',
    	        text: '',
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
    	                        Swal.fire('Xuất file thành công ', '', 'success').then((result) => {
    	                            if (result.isConfirmed) {     	                            	
    	                               html2pdf().set(opt).from(div).save()
    	                               setTimeout(function() {
    	             					    // tiến hành lệnh tiếp theo ở đây sau khi chờ 5 giây
    	             					    window.location.replace("/chat-web-app/index");
    	             					    someOtherFunction();
    	             					  }, 4000);
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
</html>