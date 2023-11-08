package com.poly.chatweb.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.chatweb.services.UserServiceInterface;
import com.chatweb.services.impl.UserService;
import com.poly.chatweb.models.User;

@WebServlet("/users/*")
@MultipartConfig
public class UserController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private UserServiceInterface userService = UserService.getInstance();

	public UserController() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		  response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
		   String url = request.getContextPath();
		    String status = request.getPathInfo();		    
			RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/ChatGroup/sign-up.jsp");
		    if (status.equals("/register") || status.equals("/update")) {
		        String title = "Update User";
		        String description = "Update your information";
		        String btnSubmit = "Update";
		        String btnGoBack = "/chat";

		        if (status.equals("/register")) {
		            title = "Register User";
		            description = "Enter your information";
		            btnSubmit = "Register";
		            btnGoBack = "/login";
		        }
		    
		        request.setAttribute("title", title);
		        request.setAttribute("description", description);
		        request.setAttribute("status", status);
		        request.setAttribute("btnSubmit", btnSubmit);
		        request.setAttribute("btnGoBack", btnGoBack);

		        if (status.equals("/register")) {
		            rd = request.getRequestDispatcher("/WEB-INF/views/ChatGroup/sign-up.jsp");
		            rd.forward(request, response);
		        } else if (status.equals("/update")) {
		            rd = request.getRequestDispatcher("/WEB-INF/views/ChatGroup/user-form.jsp");
		            rd.forward(request, response);
		        }
		    } else if (status.equals("/logout")) {
		        request.getSession().invalidate();
		        response.sendRedirect(url + "/login");
		    } else if (status.equals("/forpass")) {
		        request.getSession().invalidate();
		        rd = request.getRequestDispatcher("/WEB-INF/views/ChatGroup/forgotPassword.jsp");
		        rd.forward(request, response);
		    } else if (status.equals("/changepass")) {
		        request.getSession().invalidate();
		        rd = request.getRequestDispatcher("/WEB-INF/views/ChatGroup/change_pass.jsp");
		        rd.forward(request, response);
		    } else {
		        response.sendRedirect(url + "/login");
		     
		    }

		  
		}
		
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    String url = request.getContextPath();
	    String username = request.getParameter("username");
	    String password = request.getParameter("password");
	    String gender = request.getParameter("gender");
	    boolean isMale = false;

	    if (gender != null && gender.equals("true")) {
	        isMale = true;
	    }

	    Part avatar = request.getPart("avatar");
	    boolean isAdmin = true;
	    boolean isActive = true;

	    String path = request.getPathInfo();

	    if (path.endsWith("register")) {
	        userService.saveUser(true, username, password, Boolean.valueOf(gender), avatar, isAdmin, isActive);
	        response.sendRedirect(url + "/login");
	    } else if (path.endsWith("update")) {
	    	User us =	userService.findUserByUsername(username);
	    	System.out.println(username);
	    	System.out.println(us.getPassword());
	        userService.saveUser(false, username, "123", Boolean.valueOf(gender), avatar, isAdmin, isActive);
	        // Đặt một thuộc tính trong request để thông báo rằng cập nhật thành công
	        request.setAttribute("updateSuccess", true);

	        // Chuyển hướng đến trang hiện tại (không cần đổi trang)
	        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/ChatGroup/user-form.jsp");
	        rd.forward(request, response);
	    } else {
	        response.sendRedirect(url + "/chat");
	    }
	}}