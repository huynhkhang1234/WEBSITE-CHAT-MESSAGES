package com.poly.chatweb.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chatweb.services.FileServiceAbstract;
import com.chatweb.services.UserServiceInterface;
import com.chatweb.services.impl.UserService;

/**
 * Servlet implementation class ChangePassworkController
 */
@WebServlet("/users/changepass")
public class ChangePassworkController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private UserServiceInterface userService = UserService.getInstance();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ChangePassworkController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String url  = request.getContextPath();
		if (FileServiceAbstract.rootURL.isEmpty() || FileServiceAbstract.rootURL.contains("localhost")) {
			
			FileServiceAbstract.rootURL = url.replaceAll("changepass", "files/");
			System.out.println(FileServiceAbstract.rootURL);
		}
		
			request.setAttribute("message", "");
			
			RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/ChatGroup/change_pass.jsp");
			rd.forward(request, response);
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String username = request.getParameter("username");
		String passnew = request.getParameter("passnew");
		String passnew2 = request.getParameter("passnew2");
		String destPage = "/users/changepass";
		if(passnew.equalsIgnoreCase(passnew2)) {
			System.out.println("Success!!! " + username);
			userService.updatePassword(username, passnew);
			destPage = "/login";
		}else {
			request.getSession().setAttribute("message2", "Đổi mật khẩu thất bại!!!");
			System.out.println("Failler!!! " + username);
			
		}
		String url  = request.getContextPath();
		response.sendRedirect(url+destPage);
	}

}
