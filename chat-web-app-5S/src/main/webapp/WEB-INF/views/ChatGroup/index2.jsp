<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<%

response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
%>

<head>
<meta charset="utf-8">
<title>Poly Chat</title>
<meta name="description" content="#">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<!-- Bootstrap core CSS -->
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
  		<script type="text/javascript" src="<c:url value="/static/js/ShowAnnotation.js" />" charset="utf-8"></script>
  		<!-- Bao gồm thư viện SweetAlert2 -->
	    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@9">
	    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
	    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>

<body style="font-family: 'Times New Roman', Times, serif">

	 <% 
	    Object annotationLG = request.getAttribute("annotationLG");
	   %>
	
    <script>
 	var annotationLGValue = '<%= annotationLG %>';
      
       	if(annotationLGValue==1){
       		showAnnotation('Đăng nhập thành công', 'Chào mừng bạn đến chơiii', 1);
       	}else if(annotationLGValue==2){
       		
       	}else{
       		console.log('Không cần thông báo');
       		console.log('Print nothing ');
       	}
    </script>
    
	<main>
		<div class="layout">
			<!-- Start of Navigation -->
			<div class="navigation">
				<div class="container">
					<div class="inside">
						<div class="nav nav-tab menu">
							<button class="btn">
								<img class="avatar-xl"
									src="<c:url value="/static/data/${currentUser.username}/${currentUser.avatar}" />"
									alt="avatar">
							</button>
							<a style="cursor: pointer;" id="members"
								onclick="toggleSidebar(this.id)" data-toggle="tab"
								class="show active "><i onclick="chatOne(this)"
								class="material-icons clickdouble">account_circle</i></a> <a
								style="cursor: pointer;" id="discussions"
								onclick="toggleSidebar(this.id)" data-toggle="tab" class="show"><i
								class="material-icons clickdouble" onclick="chatGroup(this)">chat_bubble_outline</i></a>
								<c:if test="${currentUser.isAdmin()}">
							<a href="<c:url value="/users/register"/>" style="cursor: pointer;" id="notifications"
								onclick="toggleSidebar(this.id)" data-toggle="tab"
								class="f-grow1 show">
								<i class="material-icons">group_add</i>
								</a>	
								</c:if>
							
							<input type="checkbox" id="darkModeToggle" hidden=""> <label
								for="darkModeToggle"><i class="material-icons">brightness_2</i></label>
							<a id="setting" onclick="toggleSidebar(this.id)"
								data-toggle="tab"><i class="material-icons">settings</i></a> <a
								href="<c:url value="/users/logout"/>" class="btn power"
								onclick="visitPage();"> <i class="material-icons">power_settings_new</i>
							</a>
						</div>
					</div>
				</div>
			</div>
			<!-- End of Navigation -->
			<div class="sidebar" id="sidebar">
				<div class="container">
					<div class="col-md-12">
						<div class="tab-content">
							<!-- Start of Contacts -->
							<div class="tab-pane fade active show" id="membersModal">
								<div class="search" style="cursor: text;">
									<form class="form-inline position-relative">
										<input type="text" class="form-control" id="people"
											placeholder="Tìm kiếm..." onkeyup="searchUser(this)">
										<button id="search" type="button" class="btn btn-link loop">
											<i style="position: absolute; left: 20px; top: 1px;"
												class="material-icons">search</i>
										</button>
									</form>
								</div>
								<div class="list-group sort">
									<button class="btn filterMembersBtn active show"
										data-toggle="list" data-filter="all">Tất cả</button>
									<button class="btn filterMembersBtn" data-toggle="list"
										data-filter="online">Online</button>
									<button class="btn filterMembersBtn" data-toggle="list"
										data-filter="offline">Offline</button>
								</div>
								<div class="contacts">
									<h1 class="name">Liên hệ</h1>
									<p id="username" style="display: none">${user.username}</p>
									<p id="userAvatar" style="display: none">
										<c:url value="/static/images/anh2.jpg" />
									</p>
									<div class="list-group" id="contacts" role="tablist">
										<c:forEach var="friend" items="${friends}">
											<a id="${friend.username }" onclick="setReceiver(this);"
												class="filterMembers all online contact" data-toggle="list">
												<img id="img-${friend.username}" class="avatar-md"
												src="<c:url value="/static/data/${friend.username}/${friend.avatar}" />"
												data-toggle="tooltip" data-placement="top" title="Janette"
												alt="avatar"> <%-- <div class="status" id="status-${friend.username}"
													class="user-img-dot">
													<i class="material-icons online">fiber_manual_record</i>
												</div> --%>
												<div id="status-${friend.username}" class="user-img-dot"></div>
												<div class="data">
													<h5>${friend.username}</h5>
													<p>Bạc Liêu, VIệt Nam</p>
												</div>


											</a>
										</c:forEach>

									</div>
								</div>
							</div>
							<!-- End of Contacts -->
							<!-- Start of Discussions -->							
							<div id="discussionsModal" class="tab-pane fade ">
								<div class="search">
									<form class="form-inline position-relative">
										<input type="text" class="form-control" id="people"
											placeholder="Tìm kiếm..." onkeyup="searchUser(this)">
										<button id="searchGroup" type="button"
											class="btn btn-link loop">
											<i class="material-icons">search</i>
										</button>
									</form>
									<c:if test="${currentUser.isAdmin()}">
										<button class="btn create" data-toggle="modal"
											data-target="#exampleModalCenter">
											<i data-id="add-group" onclick="showAddGroup(this, true)"
												class="material-icons">person_add</i>
										</button>
									</c:if>

								</div>
								<div class="list-group sort">
									<button class="btn filterDiscussionsBtn active show"
										data-toggle="list" data-filter="all">Tất cả</button>
									<button class="btn filterDiscussionsBtn" data-toggle="list"
										data-filter="read">Đọc</button>
									<button class="btn filterDiscussionsBtn" data-toggle="list"
										data-filter="unread">Chưa đọc</button>
								</div>
								<div class="discussions">
									<h1 class="name">Discussions</h1>

									</span>
									<div class="list-group" id="discussionsChats" role="tablist">
										<!-- thẻ chứa nhóm -->
										<!-- Nội dung đoạn chat  -->
									</div>
								</div>
							</div>
							<!-- End of Discussions -->
							<!-- Start of Notifications -->
						
							<!-- End of Notifications -->
							<!-- Start of Notifications Settings -->
							<div class="category">
								<!-- <a href="#" class="title collapsed" id="headingThree"
									data-toggle="collapse" data-target="#collapseThree"
									aria-expanded="true" aria-controls="collapseThree"> <i
									class="material-icons md-30 online">notifications_none</i>
									<div class="data">
										<h5>Thông báo</h5>
										<p>Bật hoặc tắt thông báo</p>
									</div> <i class="material-icons">keyboard_arrow_right</i>
								</a> -->
								<div class="collapse" id="collapseThree"
									aria-labelledby="headingThree" data-parent="#accordionSettings">
									<div class="content no-layer">
										<div class="set">
											<div class="details">
												<h5>Thông báo trên màn hình</h5>
												<p>Bạn có thể thiết lập Vuốt để nhận thông báo khi có
													tin nhắn mới.</p>
											</div>
											<label class="switch"> <input type="checkbox" checked>
												<span class="slider round"></span>
											</label>
										</div>
										<div class="set">
											<div class="details">
												<h5>Huy hiệu tin nhắn chưa đọc</h5>
												<p>Nếu được bật, biểu tượng ứng dụng Vuốt sẽ hiển thị
													huy hiệu màu đỏ khi bạn có tin nhắn chưa đọc.</p>
											</div>
											<label class="switch"> <input type="checkbox" checked>
												<span class="slider round"></span>
											</label>
										</div>
										<div class="set">
											<div class="details">
												<h5>Thanh tác vụ nhấp nháy</h5>
												<p>Thấp nháy ứng dụng Vuốt trên thiết bị di động trên
													thanh tác vụ khi bạn có thông báo mới.</p>
											</div>
											<label class="switch"> <input type="checkbox">
												<span class="slider round"></span>
											</label>
										</div>
										<div class="set">
											<div class="details">
												<h5>Âm thanh thông báo</h5>
												<p>Đặt ứng dụng để cảnh báo bạn qua âm thanh thông báo
													khi bạn có tin nhắn chưa đọc.</p>
											</div>
											<label class="switch"> <input type="checkbox" checked>
												<span class="slider round"></span>
											</label>
										</div>
										<div class="set">
											<div class="details">
												<h5>Rung</h5>
												<p>Rung khi nhận tin nhắn mới (Đảm bảo hệ thống rung
													cũng được bật).</p>
											</div>
											<label class="switch"> <input type="checkbox">
												<span class="slider round"></span>
											</label>
										</div>
										<div class="set">
											<div class="details">
												<h5>Bật đèn</h5>
												<p>Khi ai đó gửi tin nhắn cho bạn, bạn sẽ nhận được cảnh
													báo qua đèn thông báo.</p>
											</div>
											<label class="switch"> <input type="checkbox">
												<span class="slider round"></span>
											</label>
										</div>
									</div>
								</div>
							</div>
							<!-- End of Notifications Settings -->
							<!-- Start of Settings -->
							<div class="tab-pane fade " id="settings">
								<div class="settings">
									<div class="profile">
										<img class="avatar-xl"
											src="<c:url value="/static/dist/img/avatars/avatar-male-1.jpg" />"
											alt="avatar">
										<h1>
											<a href="#">Bảo Khang</a>
										</h1>
										<span>Đồng Tháp, Việt Nam</span>
										<div class="stats">
											<div class="item">
												<h2>122</h2>
												<h3>Bạn</h3>
											</div>
											<div class="item">
												<h2>305</h2>
												<h3>Trò chuyện</h3>
											</div>
											<div class="item">
												<h2>1538</h2>
												<h3>Bài viết</h3>
											</div>
										</div>
									</div>
									<div class="categories" id="accordionSettings">
										<h1 class="name">Cài đặt</h1>
										<!-- Start of My Account -->
										<div class="category">
											<a href="#" class="title collapsed" id="headingOne"
												data-toggle="collapse" data-target="#collapseOne"
												aria-expanded="true" aria-controls="collapseOne"> <i
												class="material-icons md-30 online">person_outline</i>
												<div class="data">
													<h5>Tài khoản của tôi</h5>
													<p>Cập nhật chi tiết hồ sơ của bạn</p>
												</div> <i class="material-icons">keyboard_arrow_right</i>
											</a>
											<div class="collapse show" id="collapseOne"
												aria-labelledby="headingOne"
												data-parent="#accordionSettings">
												<div class="content">
													<div class="upload">
														<div class="data">
															<img class="avatar-xl"
																src="dist/img/avatars/avatar-male-1.jpg" alt="image">
															<label> <input type="file"> <span
																class="btn button">Tải hình đại diện</span>
															</label>
														</div>
														<p>Để có kết quả tốt nhất, hãy sử dụng hình ảnh có
															kích thước tối thiểu 256px x 256px ở định dạng .jpg hoặc
															.png!</p>
													</div>
													<form>
														<div class="parent">
															<div class="field">
																<label for="firstName">Họ <span>*</span></label> <input
																	type="text" class="form-control" id="firstName"
																	placeholder="Họ" required>
															</div>
															<div class="field">
																<label for="lastName">Tên<span>*</span></label> <input
																	type="text" class="form-control" id="lastName"
																	placeholder="Tên" required>
															</div>
														</div>
														<div class="field">
															<label for="email">Email <span>*</span></label> <input
																type="email" class="form-control" id="email"
																placeholder="Nhập địa chỉ email của bạn" required>
														</div>
														<div class="field">
															<label for="password">Mật Khẩu</label> <input
																type="password" class="form-control" id="password"
																placeholder="Nhập mật khẩu mới" required>
														</div>
														<div class="field">
															<label for="location">Đại chỉ</label> <input type="text"
																class="form-control" id="location"
																placeholder="Nhập địa chỉ của bạn" required>
														</div>
														<button class="btn btn-link w-100">Xóa tài khoản</button>
														<button type="submit" class="btn button w-100">Áp
															dụng</button>
													</form>
												</div>
											</div>
										</div>
										<!-- End of My Account -->
										<!-- Start of Chat History -->
										<div class="category">
											<a href="#" class="title collapsed" id="headingTwo"
												data-toggle="collapse" data-target="#collapseTwo"
												aria-expanded="true" aria-controls="collapseTwo"> <i
												class="material-icons md-30 online">mail_outline</i>
												<div class="data">
													<h5>Trò chuyện</h5>
													<p>Kiểm tra lịch sử trò chuyện của bạn</p>
												</div> <i class="material-icons">keyboard_arrow_right</i>
											</a>
											<div class="collapse" id="collapseTwo"
												aria-labelledby="headingTwo"
												data-parent="#accordionSettings">
												<div class="content layer">
													<div class="history">
														<p>Khi bạn xóa lịch sử cuộc trò chuyện, tin nhắn sẽ bị
															xóa khỏi thiết bị của bạn.</p>
														<p>Tin nhắn sẽ không bị xóa trên thiết bị của những
															người mà bạn đã trò chuyện cùng.</p>
														<div class="custom-control custom-checkbox">
															<input type="checkbox" class="custom-control-input"
																id="same-address"> <label
																class="custom-control-label" for="same-address">Ẩn
																sẽ xóa lịch sử trò chuyện của bạn khỏi danh sách gần
																đây.</label>
														</div>
														<div class="custom-control custom-checkbox">
															<input type="checkbox" class="custom-control-input"
																id="save-info"> <label
																class="custom-control-label" for="save-info">Xóa
																sẽ xóa lịch sử trò chuyện của bạn khỏi thiết bị.</label>
														</div>
														<button type="submit" class="btn button w-100">Xoá</button>
													</div>
												</div>
											</div>
										</div>
										<!-- End of Chat History -->
										<!-- Start of Notifications Settings -->
										<div class="category">
											<a href="#" class="title collapsed" id="headingThree"
												data-toggle="collapse" data-target="#collapseThree"
												aria-expanded="true" aria-controls="collapseThree">
												 <i
												class="material-icons md-30 online">notifications_none</i>
												
												<div class="data">
													<h5>Thông báo</h5>
													<p>Bật hoặc tắt thông báo</p>
												</div> <i class="material-icons">keyboard_arrow_right</i>
											</a>
											<div class="collapse" id="collapseThree"
												aria-labelledby="headingThree"
												data-parent="#accordionSettings">
												<div class="content no-layer">
													<div class="set">
														<div class="details">
															<h5>Thông báo trên màn hình</h5>
															<p>Bạn có thể thiết lập Vuốt để nhận thông báo khi có
																tin nhắn mới.</p>
														</div>
														<label class="switch"> <input type="checkbox"
															checked> <span class="slider round"></span>
														</label>
													</div>
													<div class="set">
														<div class="details">
															<h5>Huy hiệu tin nhắn chưa đọc</h5>
															<p>Nếu được bật, biểu tượng ứng dụng Vuốt sẽ hiển thị
																huy hiệu màu đỏ khi bạn có tin nhắn chưa đọc.</p>
														</div>
														<label class="switch"> <input type="checkbox"
															checked> <span class="slider round"></span>
														</label>
													</div>
													<div class="set">
														<div class="details">
															<h5>Thanh tác vụ nhấp nháy</h5>
															<p>Thấp nháy ứng dụng Vuốt trên thiết bị di động trên
																thanh tác vụ khi bạn có thông báo mới.</p>
														</div>
														<label class="switch"> <input type="checkbox">
															<span class="slider round"></span>
														</label>
													</div>
													<div class="set">
														<div class="details">
															<h5>Âm thanh thông báo</h5>
															<p>Đặt ứng dụng để cảnh báo bạn qua âm thanh thông
																báo khi bạn có tin nhắn chưa đọc.</p>
														</div>
														<label class="switch"> <input type="checkbox"
															checked> <span class="slider round"></span>
														</label>
													</div>
													<div class="set">
														<div class="details">
															<h5>Rung</h5>
															<p>Rung khi nhận tin nhắn mới (Đảm bảo hệ thống rung
																cũng được bật).</p>
														</div>
														<label class="switch"> <input type="checkbox">
															<span class="slider round"></span>
														</label>
													</div>
													<div class="set">
														<div class="details">
															<h5>Bật đèn</h5>
															<p>Khi ai đó gửi tin nhắn cho bạn, bạn sẽ nhận được
																cảnh báo qua đèn thông báo.</p>
														</div>
														<label class="switch"> <input type="checkbox">
															<span class="slider round"></span>
														</label>
													</div>
												</div>
											</div>
										</div>
										<!-- End of Notifications Settings -->
										<!-- Start of Connections -->
										<div class="category">
											<a href="#" class="title collapsed" id="headingFour"
												data-toggle="collapse" data-target="#collapseFour"
												aria-expanded="true" aria-controls="collapseFour"> <i
												class="material-icons md-30 online">sync</i>
												<div class="data">
													<h5>Kết nối</h5>
													<p>Đồng bộ hóa tài khoản xã hội của bạn</p>
												</div> <i class="material-icons">keyboard_arrow_right</i>
											</a>
											<div class="collapse" id="collapseFour"
												aria-labelledby="headingFour"
												data-parent="#accordionSettings">
												<div class="content">
													<div class="app">
														<img src="dist/img/integrations/slack.svg" alt="app">
														<div class="permissions">
															<h5>Skrill</h5>
															<p>Đọc, viết, bình luận</p>
														</div>
														<label class="switch"> <input type="checkbox"
															checked> <span class="slider round"></span>
														</label>
													</div>
													<div class="app">
														<img src="dist/img/integrations/dropbox.svg" alt="app">
														<div class="permissions">
															<h5>Dropbox</h5>
															<p>Đọc, viết, tải lên</p>
														</div>
														<label class="switch"> <input type="checkbox"
															checked> <span class="slider round"></span>
														</label>
													</div>
													<div class="app">
														<img src="dist/img/integrations/drive.svg" alt="app">
														<div class="permissions">
															<h5>Google Drive</h5>
															<p>Chưa đặt quyền</p>
														</div>
														<label class="switch"> <input type="checkbox">
															<span class="slider round"></span>
														</label>
													</div>
													<div class="app">
														<img src="dist/img/integrations/trello.svg" alt="app">
														<div class="permissions">
															<h5>Trello</h5>
															<p>Chưa đặt quyền</p>
														</div>
														<label class="switch"> <input type="checkbox">
															<span class="slider round"></span>
														</label>
													</div>
												</div>
											</div>
										</div>
										<!-- End of Connections -->

										<!-- Start of Language -->
										<div class="category">
											<a href="#" class="title collapsed" id="headingSix"
												data-toggle="collapse" data-target="#collapseSix"
												aria-expanded="true" aria-controls="collapseSix"> <i
												class="material-icons md-30 online">language</i>
												<div class="data">
													<h5>Ngôn ngữ</h5>
													<p>Chọn ngôn ngữ ưa thích</p>
												</div> <i class="material-icons">keyboard_arrow_right</i>
											</a>
											<div class="collapse" id="collapseSix"
												aria-labelledby="headingSix"
												data-parent="#accordionSettings">
												<div class="content layer">
													<div class="language">
														<label for="country">Ngôn ngữ</label> <select
															class="custom-select" id="country" required>
															<option value="">Chọn một ngôn ngữ...</option>
															<option>English, UK</option>
															<option>Việt Nam, VN</option>
														</select>
													</div>
												</div>
											</div>
										</div>
										<!-- End of Language -->
										<!-- Start of Privacy & Safety -->
										<div class="category">
											<a href="<c:url value="/users/changepass"/>" class="title collapsed" id="headingSeven"
												data-toggle="collapse" data-target="#collapseSeven"
												aria-expanded="true" aria-controls="collapseSeven"> <i
												class="material-icons md-30 online">lock_outline</i>
												<div class="data">
												
													<h5>Đổi mật khẩu</h5>
													<p>Kiểm soát cài đặt quyền riêng tư của bạn</p>
											
												
												</div> <i class="material-icons">keyboard_arrow_right</i>
											</a>
											<div class="collapse" id="collapseSeven"
												aria-labelledby="headingSeven"
												data-parent="#accordionSettings">
												<div class="content no-layer">
													<div class="set">
														<div class="details">
															<h5>Giữ an toàn cho tôi</h5>
															<p>Tự động quét và xóa tin nhắn trực tiếp bạn nhận
																được từ tất cả những người có chứa nội dung tục tĩu.</p>
														</div>
														<label class="switch"> <input type="checkbox">
															<span class="slider round"></span>
														</label>
													</div>
													<div class="set">
														<div class="details">
															<h5>Bạn bè của tôi rất tử tế</h5>
															<p>Nếu được bật, sẽ quét tin nhắn trực tiếp từ mọi
																người trừ khi họ được liệt kê là bạn của bạn.</p>
														</div>
														<label class="switch"> <input type="checkbox"
															checked> <span class="slider round"></span>
														</label>
													</div>
													<div class="set">
														<div class="details">
															<h5>Mọi người có thể thêm tôi</h5>
															<p>Nếu cho phép bất kỳ ai vào hoặc ra khỏi danh sách
																bạn bè của bạn có thể gửi cho bạn lời mời kết bạn.</p>
														</div>
														<label class="switch"> <input type="checkbox"
															checked> <span class="slider round"></span>
														</label>
													</div>
													<div class="set">
														<div class="details">
															<h5>Bạn của bạn</h5>
															<p>Chỉ bạn bè hoặc bạn chung của bạn mới có thể gửi
																cho bạn lời mời kết bạn.</p>
														</div>
														<label class="switch"> <input type="checkbox"
															checked> <span class="slider round"></span>
														</label>
													</div>
													<div class="set">
														<div class="details">
															<h5>Dữ liệu cần cải thiện</h5>
															<p>Cài đặt này cho phép chúng tôi sử dụng và xử lý
																thông tin cho mục đích phân tích.</p>
														</div>
														<label class="switch"> <input type="checkbox">
															<span class="slider round"></span>
														</label>
													</div>
													<div class="set">
														<div class="details">
															<h5>Dữ liệu cần tùy chỉnh</h5>
															<p>Cài đặt này cho phép chúng tôi sử dụng thông tin
																của bạn để tùy chỉnh Vuốt cho bạn.</p>
														</div>
														<label class="switch"> <input type="checkbox">
															<span class="slider round"></span>
														</label>
													</div>
												</div>
											</div>
										</div>
										<!-- End of Privacy & Safety -->
										<!-- Start of Logout -->
										<div class="category">
											<a href="sign-in.html" class="title collapsed"> <i
												class="material-icons md-30 online">power_settings_new</i>
												<div class="data">
													<h5>Tắt nguồn</h5>
													<p>Đăng xuất khỏi tài khoản của bạn</p>
												</div> <i class="material-icons">keyboard_arrow_right</i>
											</a>
										</div>
										<!-- End of Logout -->
									</div>
								</div>
							</div>
							<!-- End of Settings -->
						</div>
					</div>
				</div>
			</div>
			<!-- End of Sidebar -->
			<!-- Start of Create Chat -->

			<!-- End of Create Chat -->




			<!-- ---------------------------------------------- -->
			<div class="main">

				<div class="tab-content" id="nav-tabContent">
					<!-- Start of Babble -->
					<div border: 1px solid
						#a7a6a6;"
						class="babble tab-pane fade active show"
						role="tabpanel" aria-labelledby="list-chat-list">
						<!-- Start of Chat -->
						<!-- code phần bỏ vô nhắn tin -->
						<span id="receiver"></span>
						<!-- code phần khi click thêm nhóm -->
						<div class="modal-box border " id="add-group">
							<div class="modal-box-head">
								<div class="modal-box-title">Add Group</div>
								<div class="modal-box-close toggle-btn" data-id="add-group"
									onclick="toggleModal(this, false)">
									<i class="fa fa-times"></i>
								</div>
							</div>
							<hr>
							<form action="" onsubmit="return createGroup(event);">
								<div class="modal-box-body">
									<input type="text" class="txt-input txt-group-name"
										placeholder="Group Name...">
								</div>
								<button style="color: blue" type="submit" class="btn">Create
									Group</button>
							</form>
						</div>

						<div class="modal-box border" id="add-user">
							<div class="modal-box-head">
								<div class="modal-box-title">Danh sách</div>
								<div class="modal-box-close toggle-btn" data-id="add-user"
									onclick="toggleModal(this, false)">
									<i class="fa fa-times"></i>
								</div>
							</div>
							<hr>
							<form action="" onsubmit="return addMember(event);">
								<div class="modal-box-body add-member-body">
									<input style="background: yellow;" type="text"
										class="txt-input txt-group-name"
										placeholder="Name of member..."
										onkeyup="searchMemberByKeyword(this)">

									<div class="list-user">
										<ul>
										</ul>
									</div>
								</div>
								<button style="color: blue; font-size: 20px" type="submit"
									class="btn">Thêm thành viên</button>
							</form>
						</div>

						<div class="modal-box border" id="manage-user">
							<div class="modal-box-head">
								<div class="modal-box-title">All Member Of Group</div>
								<div class="modal-box-close toggle-btn" data-id="manage-user"
									onclick="toggleModal(this, false)">
									<i class="fa fa-times"></i>
								</div>
							</div>
							<hr>
							<div class="modal-box-body manage-member-body">
								<div class="list-user">
									<ul>
									</ul>
								</div>
							</div>
						</div>

						<!-- End of Chat -->







						<!--MODAL ADD GROUP-->
						<div class="modal fade" id="AddGroupModal" tabindex="-1"
							role="dialog" aria-hidden="true">
							<div class="modal-dialog modal-lg modal-dialog-centered"
								style="width: 900px !important;" role="document">
								<div class="requests">
									<div class="title">
										<h1>Tạo nhóm</h1>
										<button type="button" class="btn" data-dismiss="modal"
											aria-label="Close">
											<i class="material-icons">close</i>
										</button>
									</div>

									<div class="content">

										<form>
											<!--<span class="material-icons">
									photo_camera
									</span> <div class="row"-->


											<div class="input-group ">

												<div class="col col-lg-2 ">
													<!--ANH Nhom-->
													<button class="btn" data-toggle="modal"
														data-target="#ModalAnh">
														<img class="avatar-xl" src="dist/img/avatars/Photo.png"
															alt="avatar">
													</button>
													<!-- Hiển thị ảnh đã chọn
						<img id="selectedImage" src="#" alt="Ảnh đã chọn" style="display: none;"> -->
												</div>
												<div class="form-group col ">
													<label for="searchInput" class="sr-only">TenNhom</label> <input
														type="text" class="form-control search-input "
														id="TenNhom" placeholder="Nhập tên nhóm...">
												</div>

											</div>

											<div class="form-group ">
												<label for="user">Thêm bạn vào nhóm:</label> <input
													type="text" class="form-control" id="user"
													placeholder="Nhập tên, số điện thoại" required>
											</div>

											<!--Table-->

											<div class="form-group">
												<label for="welcome">Danh sách</label>
												<div class="table-container"
													style="max-height: 100px; overflow-y: auto;">
													<table class="table ">
														<tbody>
															<tr>
																<td class="col-auto mr-auto">Ngọc chăm</td>
																<td class="col-auto">
																	<div class="form-check">
																		<input class="form-check-input" type="checkbox"
																			value="" id="flexCheckDefault"
																			onchange="updateCount()">
																	</div>
																</td>
															</tr>
															<tr>
																<td class="col-auto mr-auto">Kim Yến</td>
																<td class="col-auto">
																	<div class="form-check">
																		<input class="form-check-input" type="checkbox"
																			value="" id="flexCheckDefault"
																			onchange="updateCount()">
																	</div>
																</td>
															</tr>

															<!-- Thêm dữ liệu cho bảng tại đây -->
															<!-- <tr> ... </tr> -->
														</tbody>
													</table>
												</div>
											</div>
											<p style="color: black;">
												Số lượng đã chọn: <span id="count">0</span>
											</p>
											<br>

											<div class="modal-footer">
												<button
													style="border-radius: 7px; width: 120px; height: 40px; font-size: 20px; background-color: #308bec;"
													type="submit" class="btn btn-create-group">Tạo
													nhóm</button>
											</div>
										</form>
									</div>
								</div>
							</div>
						</div>
						<!--END MODAL ADD GROUP-->
						<!-- MODAL CHON ANH-->
						<div class="modal fade" id="ModalAnh" tabindex="-1" role="dialog"
							aria-hidden="true">
							<div class="modal-dialog modal-dialog-centered" role="document">
								<div class="requests">
									<div class="title">
										<h1>Cập nhật ảnh đại diên</h1>
										<button type="button" class="btn" data-dismiss="modal"
											aria-label="Close">
											<i class="material-icons">close</i>
										</button>
									</div>
									<div class="content">

										<div class="container ">
											<!-- Tạo một nút để truy cập và chọn ảnh -->
											<input type="file" id="uploadButton" style="display: none;">
											<button
												style="background-color: rgb(154, 225, 248); color: blue;"
												type="submit" class="btn button w-100"
												onclick="openFileExplorer()">
												<i class="material-icons"> image </i> Tải lên từ máy tính
											</button>


										</div>
										<div class="form-group row mt-3 ">
											<label for="user">Bộ sưu tập</label>
										</div>

									</div>
								</div>
							</div>
						</div>
						<!--END MODAL CHON ANH -->

						<!-- Start of Call -->
						<div class="call" id="call1">
							<div class="content">
								<div class="container">
									<div class="col-md-12">
										<div class="inside">
											<div class="panel">
												<div class="participant">
													<img class="avatar-xxl"
														src="dist/img/avatars/avatar-female-5.jpg" alt="avatar">
													<span>Connecting</span>
												</div>
												<div class="options">
													<button class="btn option">
														<i class="material-icons md-30">mic</i>
													</button>
													<button class="btn option">
														<i class="material-icons md-30">videocam</i>
													</button>
													<button class="btn option call-end">
														<i class="material-icons md-30">call_end</i>
													</button>
													<button class="btn option">
														<i class="material-icons md-30">person_add</i>
													</button>
													<button class="btn option">
														<i class="material-icons md-30">volume_up</i>
													</button>
												</div>
												<button class="btn back" name="1">
													<i class="material-icons md-24">chat</i>
												</button>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- End of Call -->
					</div>
					<!-- End of Babble -->
					<!-- Start of Babble -->
					<div class="babble tab-pane fade" id="list-empty" role="tabpanel"
						aria-labelledby="list-empty-list">
						<!-- Start of Chat -->
						<div class="chat" id="chat2">
							<div class="top">
								<div class="container">
									<div class="col-md-12">
										<div class="inside">
											<a href="#"><img class="avatar-md"
												src="dist/img/avatars/avatar-female-2.jpg"
												data-toggle="tooltip" data-placement="top" title="Lean"
												alt="avatar"></a>
											<div class="status">
												<i class="material-icons offline">fiber_manual_record</i>
											</div>
											<div class="data">
												<h5>
													<a href="#">Lean Avent</a>
												</h5>
												<span>Inactive</span>
											</div>
											<button class="btn connect d-md-block d-none" name="2">
												<i class="material-icons md-30">phone_in_talk</i>
											</button>
											<button class="btn connect d-md-block d-none" name="2">
												<i class="material-icons md-36">videocam</i>
											</button>
											<button class="btn d-md-block d-none">
												<i class="material-icons md-30">info</i>
											</button>
											<div class="dropdown">
												<button class="btn" data-toggle="dropdown"
													aria-haspopup="true" aria-expanded="false">
													<i class="material-icons md-30">more_vert</i>
												</button>
												<div class="dropdown-menu dropdown-menu-right">
													<button class="dropdown-item connect" name="2">
														<i class="material-icons">phone_in_talk</i>Voice Call
													</button>
													<button class="dropdown-item connect" name="2">
														<i class="material-icons">videocam</i>Video Call
													</button>
													<hr>
													<button class="dropdown-item">
														<i class="material-icons">clear</i>Clear History
													</button>
													<button class="dropdown-item">
														<i class="material-icons">block</i>Block Contact
													</button>
													<button class="dropdown-item">
														<i class="material-icons">delete</i>Delete Contact
													</button>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="content empty">
								<div class="container">
									<div class="col-md-12">
										<div class="no-messages">
											<i class="material-icons md-48">forum</i>
											<p>Seems people are shy to start the chat. Break the ice
												send the first message.</p>
										</div>
									</div>
								</div>
							</div>
							<div class="container">
								<div class="col-md-12">
									<div class="bottom">
										<form class="position-relative w-100">
											<textarea class="form-control"
												placeholder="Start typing for reply..." rows="1"></textarea>
											<button class="btn emoticons">
												<i class="material-icons">insert_emoticon</i>
											</button>
											<button type="submit" class="btn send">
												<i class="material-icons">send</i>
											</button>
										</form>
										<label> <input type="file"> <span
											class="btn attach d-sm-block d-none"><i
												class="material-icons">attach_file</i></span>
										</label>
									</div>
								</div>
							</div>
						</div>
						<!-- End of Chat -->
						<!-- Start of Call -->
						<div class="call" id="call2">
							<div class="content">
								<div class="container">
									<div class="col-md-12">
										<div class="inside">
											<div class="panel">
												<div class="participant">
													<img class="avatar-xxl"
														src="dist/img/avatars/avatar-female-2.jpg" alt="avatar">
													<span>Connecting</span>
												</div>
												<div class="options">
													<button class="btn option">
														<i class="material-icons md-30">mic</i>
													</button>
													<button class="btn option">
														<i class="material-icons md-30">videocam</i>
													</button>
													<button class="btn option call-end">
														<i class="material-icons md-30">call_end</i>
													</button>
													<button class="btn option">
														<i class="material-icons md-30">person_add</i>
													</button>
													<button class="btn option">
														<i class="material-icons md-30">volume_up</i>
													</button>
												</div>
												<button class="btn back" name="2">
													<i class="material-icons md-24">chat</i>
												</button>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- End of Call -->
					</div>
					<!-- End of Babble -->
					<!-- Start of Babble -->
					<div class="babble tab-pane fade" id="list-request" role="tabpanel"
						aria-labelledby="list-request-list">
						<!-- Start of Chat -->
						<div class="chat" id="chat3">
							<div class="top">
								<div class="container">
									<div class="col-md-12">
										<div class="inside">
											<a href="#"><img class="avatar-md"
												src="dist/img/avatars/avatar-female-6.jpg"
												data-toggle="tooltip" data-placement="top" title="Louis"
												alt="avatar"></a>
											<div class="status">
												<i class="material-icons offline">fiber_manual_record</i>
											</div>
											<div class="data">
												<h5>
													<a href="#">Louis Martinez</a>
												</h5>
												<span>Inactive</span>
											</div>
											<button class="btn disabled d-md-block d-none" disabled>
												<i class="material-icons md-30">phone_in_talk</i>
											</button>
											<button class="btn disabled d-md-block d-none" disabled>
												<i class="material-icons md-36">videocam</i>
											</button>
											<button class="btn d-md-block disabled d-none" disabled>
												<i class="material-icons md-30">info</i>
											</button>
											<div class="dropdown">
												<button class="btn disabled" data-toggle="dropdown"
													aria-haspopup="true" aria-expanded="false" disabled>
													<i class="material-icons md-30">more_vert</i>
												</button>
												<div class="dropdown-menu dropdown-menu-right">
													<button class="dropdown-item">
														<i class="material-icons">phone_in_talk</i>Voice Call
													</button>
													<button class="dropdown-item">
														<i class="material-icons">videocam</i>Video Call
													</button>
													<hr>
													<button class="dropdown-item">
														<i class="material-icons">clear</i>Clear History
													</button>
													<button class="dropdown-item">
														<i class="material-icons">block</i>Block Contact
													</button>
													<button class="dropdown-item">
														<i class="material-icons">delete</i>Delete Contact
													</button>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="content empty">
								<div class="container">
									<div class="col-md-12">
										<div class="no-messages request">
											<a href="#"><img class="avatar-xl"
												src="dist/img/avatars/avatar-female-6.jpg"
												data-toggle="tooltip" data-placement="top" title="Louis"
												alt="avatar"></a>
											<h5>
												Louis Martinez would like to add you as a contact. <span>Hi
													Keith, I'd like to add you as a contact.</span>
											</h5>
											<div class="options">
												<button class="btn button">
													<i class="material-icons">check</i>
												</button>
												<button class="btn button">
													<i class="material-icons">close</i>
												</button>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="container">
								<div class="col-md-12">
									<div class="bottom">
										<form class="position-relative w-100">
											<textarea class="form-control"
												placeholder="Messaging unavailable" rows="1" disabled></textarea>
											<button class="btn emoticons disabled" disabled>
												<i class="material-icons">insert_emoticon</i>
											</button>
											<button class="btn send disabled" disabled>
												<i class="material-icons">send</i>
											</button>
										</form>
										<label> <input type="file" disabled> <span
											class="btn attach disabled d-sm-block d-none"><i
												class="material-icons">attach_file</i></span>
										</label>
									</div>
								</div>
							</div>
						</div>
						<!-- End of Chat -->
					</div>
					<!-- End of Babble -->
				</div>
			</div>
		</div>
		<!-- Layout -->
	</main>

	<!-- Bootstrap/Swipe core JavaScript
		================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
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
		
	  
	</script>
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
</body>
</html>