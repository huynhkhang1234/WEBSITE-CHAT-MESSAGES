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
import com.poly.chatweb.models.User;

/**
 * Servlet implementation class UserManagerController
 */
@WebServlet("/userManager/*")
public class UserManagerController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserServiceInterface userService = UserService.getInstance();
	
//	0: khong co gi
//	1: khoa tai khoan
//	2: mo khoa tai khoan
//	3: khong the khoa chinh minh
	int showAnno = 0;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String url  = request.getContextPath();
		
		List<User> listUser = userService.getAllUser();
		
		request.setAttribute("listU", listUser);
		request.setAttribute("showAnno", showAnno);
		RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/ChatGroup/userManager.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uri = request.getRequestURI();
		String[] uriParts = uri.split("/");	
		String username = uriParts[uriParts.length - 1];
		
		String extractedUsername;
		if (username.contains(";")) {
		    int semicolonIndex = username.indexOf(";");
		     extractedUsername = username.substring(0, semicolonIndex);
		}else {
			extractedUsername = username;
		}
		
		User user = userService.findUserByUsername(extractedUsername);
		User utemp = (User) request.getSession().getAttribute("user");
		System.out.println("1: "+user.getUsername());
		System.out.println("1: "+utemp.getUsername());
		if((user!= null) && !(user.getUsername().equals(utemp.getUsername()))) {
			if(user.getIs_active()) {
				userService.changeActive(user.getUsername(), false);
				showAnno=1;
				System.out.println("Thay doi tu true -> false -----"+showAnno);
			}else {
				userService.changeActive(user.getUsername(), true);
				showAnno=2;
				System.out.println("Thay doi tu false -> true -----"+showAnno);
			}
		}else {
			System.out.println("Khong hop le");
			showAnno=3;
		}
		
		System.out.println(username);
		doGet(request, response);
	}

}