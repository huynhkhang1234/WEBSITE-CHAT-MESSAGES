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
 * Servlet implementation class userBlockController
 */
@WebServlet("/userBlock")
public class userBlockController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserServiceInterface userService = UserService.getInstance();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public userBlockController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		User utemp = (User) request.getSession().getAttribute("user");
		String sql1 = "update users set is_active = 0 where username != '"+utemp.getUsername()+"'";
		userService.userBlock(sql1);
		
		List<User> listUser = userService.getAllUser();
		
		request.setAttribute("listU", listUser);
		RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/ChatGroup/userManager.jsp");
		rd.forward(request, response);
	}

	

}