package com.poly.chatweb.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.chatweb.services.FileServiceAbstract;
import com.chatweb.services.UserServiceInterface;
import com.chatweb.services.impl.UserService;
import com.poly.chatweb.models.User;

@WebServlet({"/login"})
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private UserServiceInterface userService = UserService.getInstance();

	public LoginController() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		  response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
		String url  = request.getContextPath();
		if (FileServiceAbstract.rootURL.isEmpty() || FileServiceAbstract.rootURL.contains("localhost")) {
			
			FileServiceAbstract.rootURL = url.replaceAll("login", "files/");
			System.out.println(FileServiceAbstract.rootURL);
		}
		User user = (User) request.getSession().getAttribute("user");
		if (user != null) {
			response.sendRedirect(url+"/index");
		} else {
			RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/ChatGroup/sign-in.jsp");
			rd.forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		  response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		User user = userService.findUser(username, password);
		String destPage = "/login";
		if (user != null) {
			HttpSession httpSession = request.getSession();
			httpSession.setAttribute("user", user);
			System.out.println("set session thành công");
			destPage = "/index";
			
		}
	
		String url  = request.getContextPath();				
		response.sendRedirect(url+destPage);
	}

}