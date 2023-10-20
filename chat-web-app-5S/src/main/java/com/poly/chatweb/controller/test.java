package com.poly.chatweb.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chatweb.services.UserServiceInterface;
import com.chatweb.services.impl.UserService;
import com.poly.chatweb.daos.impl.FriendDao;
import com.poly.chatweb.models.User;

@WebServlet("/index")
public class test extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	
	private UserServiceInterface userService = UserService.getInstance();
	private FriendDao friendDao = new FriendDao();


	 protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	        // Đoạn mã xử lý ở đây, ví dụ: chuyển hướng trang
		 int checkLogin = (int) request.getSession().getAttribute("checkLG");
		 request.setAttribute("annotationLG", checkLogin);
		 
		 User currentUser = (User) request.getSession().getAttribute("user");		 
			List<User> friends = userService.findFriends(currentUser.getUsername());
			request.setAttribute("friends", friends);
			request.setAttribute("user", currentUser);	
			System.out.println("tesst thu no ben kia nha anh em");			
			//System.out.println("ADMIN?: "+currentUser.isAdmin());
			
			request.setAttribute("currentUser", currentUser);
	      RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/ChatGroup/index2.jsp");
			rd.forward(request, response);
	    }
}