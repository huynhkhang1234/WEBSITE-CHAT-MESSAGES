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
		<link href="<c:url value="/static/dist/css/swipe.min.css" />" type="text/css" rel="stylesheet">
      	<link href="<c:url value="/static/dist/css/changepass.css" />" type="text/css" rel="stylesheet">
		<link href="<c:url value="/static/dist/img/favicon.png" />" type="image/png" rel="icon">	
		
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
		<script type="text/javascript" src="<c:url value="/static/js/ShowAnnotation.js" />" charset="utf-8"></script>
		<!-- Bao gồm thư viện SweetAlert2 -->
	    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@9">
	    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
	    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	</head>
	<body class="start" style="font-family: 'Times New Roman', Times, serif">
	
		<% 
	    Object showAnno = request.getAttribute("showAnno");
	   %>
	
    <script>
	 	var rqValue = '<%= showAnno %>';
	      
	       	if(rqValue==0){
	       		
	       	}else if(rqValue==1){
	       		showAnnotation('Thay đổi thành công', 'Đã khóa tài khoản người dùng!', 1);
	       	}else{
	       		showAnnotation('Thay đổi thành công', 'Đã mở khóa tài khoản người dùng!', 1);
	       	}
    </script>
	
		<main>  
			<div class="layout">
				<!-- Start of Sign In -->
				<div class="main order-md-1">
					<div class="start row">
						<div class="col-sm-9 text-dark">
						<h1>Danh sách người dùng</h1>
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
											          <%--   <a href="<c:url value="${item.getUsername() }"/>">
											               <i class="fas fa-lock"></i>
											            </a> --%>
											            <form action="#" method="post">
											            <button  formaction="<c:url value="/userManager/${item.getUsername() }"/>" class="btn" type="submit">
											            	  <i class="fas fa-lock"></i>
											            </button>
											            </form>
											        </c:when>
											        <c:otherwise>
											            <form action="#" method="post">
											            <button  formaction="<c:url value="/userManager/${item.getUsername() }"/>" class="btn" type="submit">
											            	  <i class="fas fa-unlock-alt"></i>
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
				
			</div> <!-- Layout -->
		</main>
		<!-- Bootstrap core JavaScript
		================================================== -->
		<!-- Placed at the end of the document so the pages load faster -->
		<%--<script type="text/javascript"
		 src="<c:url value="/static/dist/js/jquery-3.3.1.slim.min.js" />" charset="utf-8" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
		<script>window.jQuery || document.write('<script src="<c:url value="/static/dist/js/vendor/jquery-slim.min.js"><\/script>')</script>
		<script	type="text/javascript"
		 src="<c:url value="/static/dist/js/jquery-3.3.1.slim.min.js" />"></script>--%>
		 <script 
		src="<c:url value="/static/dist/js/bootstrap.min.js" />" ></script>  
	</body>

</html>