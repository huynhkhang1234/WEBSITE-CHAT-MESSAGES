package com.poly.chatweb.controller;

import java.io.IOException;
import java.io.PrintWriter;

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
	int checkLogin = 0;
//	0 la khong co gi
//	1 thanh cong
//	2 that bai
//	3 thanh cong nhung tk bi khoa
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String url  = request.getContextPath();
		
		request.setAttribute("annotationLG", checkLogin);
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
		
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		
		User user = userService.findUser(username, password);
		String destPage = "/login";
		
		if (user != null) {
			if(user.getIs_active() == true) {
				HttpSession httpSession = request.getSession();
				httpSession.setAttribute("user", user);
				destPage = "/index";
				
				checkLogin = 1;
				httpSession.setAttribute("checkLG", checkLogin);
			}else {
				checkLogin = 3;
			}
		}else {
			checkLogin = 2;
		}
		String url  = request.getContextPath();
        
//        System.out.println("checkLogin: "+checkLogin);
        request.setAttribute("annotationLG", checkLogin);
		response.sendRedirect(url+destPage);
	}

}
