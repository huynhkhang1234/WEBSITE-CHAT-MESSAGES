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

@WebServlet("/bill")
public class BillController extends HttpServlet {
	private static final long serialVersionUID = 1L;	
	private UserServiceInterface userService = UserService.getInstance();
	 protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	        // Đoạn mã xử lý ở đây, ví dụ: chuyển hướng trang
		 List<User> listUser = userService.getAllUser();			
			request.setAttribute("listUserBill", listUser);
	      RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/ChatGroup/bill.jsp");
			rd.forward(request, response);
	    }
}