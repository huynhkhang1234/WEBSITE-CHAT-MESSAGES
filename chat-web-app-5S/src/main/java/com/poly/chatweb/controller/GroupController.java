package com.poly.chatweb.controller;

import java.io.IOException;
import java.net.URLDecoder;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chatweb.services.ConversationServiceInterface;
import com.chatweb.services.impl.ConversationService;
import com.poly.chatweb.models.Conversation;

/**
 * Servlet implementation class UserManagerController
 */
@WebServlet("/userManager/group/*")
public class GroupController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ConversationServiceInterface converService = ConversationService.getInstance();
	
//	0: khong co gi
//	1: khoa tai khoan
//	2: mo khoa tai khoan
	int showAnno = 0;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String url  = request.getContextPath();
		
		List<Conversation> listGroup = converService.findAllGroup();
		
		request.setAttribute("listU", listGroup);
		request.setAttribute("showAnno", showAnno);
		RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/ChatGroup/chatGroupManager.jsp");
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
		
		  String decodedSearchParam = URLDecoder.decode(extractedUsername, "UTF-8");
		Conversation user = converService.findUserByUsername(decodedSearchParam);		
		if(user!= null) {
			if(user.getIsActive().trim().equals("0")) {
				converService.changeActive(user.getName(), "1");
				showAnno=1;
				System.out.println("Thay doi tu true -> false -----"+showAnno);
			}else {
				converService.changeActive(user.getName(), "0");
				showAnno=2;
				System.out.println("Thay doi tu false -> true -----"+showAnno);
			}
		}else {
			System.out.println("Khong tim thay user");
		}		
		doGet(request, response);
	
	}
}