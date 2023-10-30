<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="<c:url value="/static/css/style.css" />">
<link rel="icon" type="image/png" href="<c:url value="/static/images/icon.jpg" />">

<title>${title}</title>
<link href="<c:url value="/static/dist/css/lib/bootstrap.min.css" />"
	type="text/css" rel="stylesheet">
<!-- Swipe core CSS -->
<link href="<c:url value="/static/dist/css/swipe.min.css" />"
	type="text/css" rel="stylesheet">
<!-- Favicon -->
<link href="<c:url value="/static/dist/img/favicon.png" />"
	type="image/png" rel="icon">
<link rel="stylesheet"
	href="<c:url value="/static/dist/css/Styles.css" />">

<link
	href="//maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"
	rel="stylesheet">

<link rel="stylesheet" href="<c:url value="/static/css/chat.css" />">

<!-- File JavaScript riêng -->
<script type="text/javascript"
	src="<c:url value="/static/js/ShowAnnotation.js" />" charset="utf-8"></script>
<!-- Bao gồm thư viện SweetAlert2 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@9">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <style>
        .container {
            background-image: url('your-background-image-url.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
        }
        .form-container {
            background-color: rgba(255, 255, 255, 0.9); /* Semi-transparent white background */
            border-radius: 10px;
            padding: 20px;
        }
        .tab-control-btn {
            background-color: #007BFF; /* Blue color for the tab button */
            color: #fff; /* White text color */
            padding: 10px;
            border-radius: 5px;
        }
        .register-form {
            padding: 20px;
            border: 1px solid #ccc; /* Gray border around the form */
            border-radius: 10px;
        }
        .txt-input {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc; /* Gray border for input fields */
            border-radius: 5px;
        }
        .gender-select {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc; /* Gray border for select field */
            border-radius: 5px;
        }
        .image-profile {
            width: 150px;
            height: 150px;
            border-radius: 50%; /* Round image profile */
            border: 2px solid #007BFF; /* Blue border around the image */
        }
        .image-file {
            display: none; /* Hide the file input */
        }
        .choose-image-label {
            background-color: #007BFF; /* Blue color for the label background */
            color: #fff; /* White text color */
            padding: 10px;
            border-radius: 5px;
            cursor: pointer; /* Change cursor to pointer on hover */
        }
        #updateButton {
            background-color: #007BFF;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
        }
        #updateButton:hover {
            background-color: #0056b3; /* Darker blue color on hover */
        }
        .choose-image-label {
        background-color: #007BFF;
        color: #fff;
        padding: 10px;
        border-radius: 5px;
        cursor: pointer;
        text-align: center; /* Center text within the label */
        display: block; /* Make it a block element */
        margin: 10px auto; /* Center it horizontally */
    }
    </style>
		<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
		
</head>
<body>

 
        <!-- Rest of your HTML content -->
    <div class="container">
    
            <div class="form-container">
            <div class="tab-control">
                <h3 class="tab-control-btn register">Cập Nhật Tài Khoản</h3>
            </div>
            <div class="register-form form active">
                <form action="<c:url value="/users/update" />" enctype="multipart/form-data" method="POST">
                    <c:choose>
                        <c:when test="${user.username != null}">
                            <input type="text" class="txt-input border" name="username" value="${user.username}" readonly>
                        </c:when>
                        <c:otherwise>
                            <input type="text" class="txt-input border" name="username" placeholder="Username">
                        </c:otherwise>
                    </c:choose>
                    <input type="password" class="txt-input border" placeholder="Password" name="password">
                    <select name="gender" class="gender-select">
                        <option value="true">Hoạt Động</option>
                    </select>
                    <label for="image" class="choose-image-label">Chọn Ảnh</label>
                    <input type="file" accept="image/*" name="avatar" id="image" class="image-file">
                    <img src="<c:url value="/static/images/user-male.jpg" />" class="image-profile" alt="">
                    <input type="hidden" name="action" value="updateUser">
                    <button type="submit" class="btn btn-primary" id="updateButton">${btnSubmit} Cập Nhật Tài Khoản</button>
                </form>
            </div>
        </div>
    </div>
    <div id="updateSuccess" style="display: none;" class="alert alert-success">
        Cập nhật thành công!
    </div>


<script
		src="<c:url value="/static/js/user-form.js" />" charset="utf-8"></script> 
		<script type="text/javascript">
		console.log('test')
		window.onload = function() {
			var imageFile = document.querySelector(".image-profile");

			document.querySelector(".image-file").addEventListener("change", function(e) {
				imageFile.src = URL.createObjectURL(e.target.files[0]);
			});

			document.querySelector(".gender-select").addEventListener("change", function(e) {
				if (e.target.value == "true") {
					document.querySelector(".image-profile").src = window.location.origin + "/chat-web-app/static/images/user-male.jpg";
				} else {
					document.querySelector(".image-profile").src = window.location.origin + "/chat-web-app/static/images/user-female.jpg";
				}
			});
		}
				</script>
<script>
document.getElementById('image').addEventListener('change', function() {
    const imageFile = this.files[0];

    if (imageFile) {
        const reader = new FileReader();
        reader.onload = function(e) {
            const imagePreview = document.querySelector('.image-profile');
            imagePreview.src = e.target.result;
        };
        reader.readAsDataURL(imageFile);
    }
});
</script>

<script>
document.getElementById("updateButton").addEventListener("click", function (event) {
    event.preventDefault(); // Ngăn chặn hành vi mặc định của form submission

    Swal.fire({
        title: 'Xác nhận cập nhật',
        text: 'Bạn có muốn cập nhật tài khoản không?',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonText: 'Có',
        cancelButtonText: 'Không',
    }).then((result) => {
        if (result.isConfirmed) {
            // Lấy dữ liệu từ form (username, password, gender, avatar)
            var formData = new FormData(document.querySelector("form"));

            // Sử dụng AJAX để gửi dữ liệu lên máy chủ
            var xhr = new XMLHttpRequest();
            xhr.open("POST", "<c:url value='/users/update' />", true);
            xhr.onreadystatechange = function () {
                if (xhr.readyState === 4) {
                    if (xhr.status === 200) {
                        // Nếu cập nhật thành công, hiển thị thông báo
                        Swal.fire('Cập nhật thành công', '', 'success').then((result) => {
                            if (result.isConfirmed) {
                                // Sau khi đóng thông báo thành công, chuyển đến trang "index"
                            	   window.location.href = "<c:url value='/users/logout' />";
                            }
                        });
                    } else {
                        // Xử lý trường hợp nếu có lỗi
                        Swal.fire('Lỗi', 'Có lỗi xảy ra khi cập nhật tài khoản.', 'error');
                    }
                }
            };
            xhr.send(formData);
        } else {
            // Người dùng từ chối cập nhật, không làm gì cả
        }
    });
});
</script>
	<script src="dist/js/jquery-3.3.1.slim.min.js"
		integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
		crossorigin="anonymous"></script>
	<script>
		var isAdmin = ${currentUser.isAdmin()};

		window.jQuery
				|| document
						.write('<script src="dist/js/vendor/jquery-slim.min.js"><\/script>')

		function w3_open() {
			document.getElementById("sidebar").style.width = "50%";
			document.getElementById("sidebar").style.visibility = "visible";
			document.getElementById("openNav").style.display = 'none';
		}

		function w3_close() {
			document.getElementById("chat1").style.marginLeft = "0%";
			document.getElementById("sidebar").style.visibility = "hidden";
			document.getElementById("openNav").style.display = "inline-block";
		}
		function toggleSidebar(id) {

			var sidebarToggled = false; // Biến cờ để kiểm soát việc toggle sidebar
			var links = document.querySelectorAll('.clickdouble');
			var sidebar = document.getElementById("sidebar");

			links.forEach(function(link) {
				link.addEventListener('dblclick', function() {
					if (!sidebarToggled) { // Kiểm tra biến cờ

						// Ngăn chặn hành vi mặc định của liên kết				          
						sidebar.classList.toggle("active");
						sidebarToggled = true;

					}
				});
			});

			// Thêm sự kiện double-click listener cho tất cả các phần tử có class "myLink"

			var member = document.getElementById('membersModal');
			var dis = document.getElementById('discussionsModal');
			var notifications = document.getElementById('notificationModal');
			var setting = document.getElementById('settings');
			if (id === 'members') {
				if (members.classList.contains("active")) {
					// Nếu có class "active", thực hiện xử lý tương ứng
					sidebar.classList.toggle("active");
				}

				if (dis != null) {
					dis.classList.remove("active");
					dis.classList.remove("show");
				}
				if (notifications != null) {
					notifications.classList.remove("active");
					notifications.classList.remove("show");
				}
				if (setting != null) {
					setting.classList.remove("active");
					setting.classList.remove("show");
				}

				member.classList.add("active");
				member.classList.add("show");

			}

			if (id === 'discussions') {
				if (discussions.classList.contains("active")) {
					// Nếu có class "active", thực hiện xử lý tương ứng
					sidebar.classList.toggle("active");
				}
				if (member != null) {
					member.classList.remove("active");
					member.classList.remove("show");
				}
				if (notifications != null) {
					notifications.classList.remove("active");
					notifications.classList.remove("show");
				}
				if (setting != null) {
					setting.classList.remove("active");
					setting.classList.remove("show");
				}
				dis.classList.add("active");
				dis.classList.add("show");

			}

			if (id === 'notifications') {
				if (notifications.classList.contains("active")) {
					// Nếu có class "active", thực hiện xử lý tương ứng
					sidebar.classList.toggle("active");
				}
				if (member != null) {
					member.classList.remove("active");
					member.classList.remove("show");
				}
				if (dis != null) {
					dis.classList.remove("active");
					dis.classList.remove("show");
				}

				if (setting != null) {
					setting.classList.remove("active");
					setting.classList.remove("show");
				}
				notifications.classList.add("active");
				notifications.classList.add("show");
			}

			if (id === 'setting') {
				if (setting.classList.contains("active")) {
					// Nếu có class "active", thực hiện xử lý tương ứng
					sidebar.classList.toggle("active");
				}
				if (member != null) {
					member.classList.remove("active");
					member.classList.remove("show");
				}
				if (dis != null) {
					dis.classList.remove("active");
					dis.classList.remove("show");
				}
				if (notifications != null) {
					notifications.classList.remove("active");
					notifications.classList.remove("show");
				}

				setting.classList.add("active");
				setting.classList.add("show");
			}

		}

		function activateTab(tabId) {
			// Xóa lớp "active" từ tất cả các tab
			var tabs = document.querySelectorAll(".nav.nav-tab.menu a");
			tabs.forEach(function(tab) {
				tab.classList.remove("active");
			});

			// Đặt lớp "active" cho tab được chọn
			var selectedTab = document
					.querySelector('a[href="#' + tabId + '"]');
			//	selectedTab.classList.add("active");
		}

		function visitPage() {

		}

		var modal = document.getElementById('myModal');
		var openModalBtn = document.getElementById('openModalBtn');
		var closeModalBtn = document.getElementById('closeModalBtn');

		openModalBtn.onclick = function() {
			modal.style.display = 'block';
		}

		closeModalBtn.onclick = function() {
			modal.style.display = 'none';
		}

		// Đóng modal khi người dùng nhấn ra bên ngoài nội dung modal
		window.onclick = function(event) {
			if (event.target == modal) {
				modal.style.display = 'none';
			}
		}
		var liked = false;
	<script src="<c:url value="/static/dist/js/vendor/popper.min.js"/>"></script>
	<%-- <script src="<c:url value="/static/dist/js/swipe.min.js" />"></script> --%>
	<script src="<c:url value="/static/dist/js/bootstrap.min.js" />"></script>
	<script src="<c:url value="/static/dist/js/srcipt.js" />"></script>
	<!-- <script>
			function scrollToBottom(el) { el.scrollTop = el.scrollHeight; }
			scrollToBottom(document.getElementById('content'));
		</script>  -->
	<script type="text/javascript"
		src="<c:url value="/static/js/chatbox.js" />" charset="utf-8"></script>

<!-- <script >
var xhr = new XMLHttpRequest();
xhr.open("POST", "<c:url value='/index' />", true);
xhr.onreadystatechange = function () {
    if (xhr.readyState === 4) {
        if (xhr.status === 200) {
            // Nếu cập nhật thành công, hiển thị thông báo
            document.getElementById("updateSuccess").style.display = "block";
        } else {
            // Xử lý trường hợp nếu có lỗi
            // Ví dụ: bạn có thể hiển thị một thông báo lỗi khác
            alert("Có lỗi xảy ra khi cập nhật tài khoản.");
        }
    }
};
xhr.send(formData);


</script> -->
</body>
</html>