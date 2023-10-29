package com.poly.chatweb.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chatweb.services.ConversationServiceInterface;
import com.chatweb.services.UserServiceInterface;
import com.chatweb.services.impl.ConversationService;
import com.chatweb.services.impl.UserService;
import com.poly.chatweb.daos.impl.FriendDao;
import com.poly.chatweb.models.Conversation;
import com.poly.chatweb.models.User;

@WebServlet("/chatUnBlock")
public class chatUnBlock extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private ConversationServiceInterface converService = ConversationService.getInstance();


	 protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 String sql = "update conversations set isActive = 1 ";		 
		  converService.chatBlock(sql);
		  System.out.println("get");			
			List<Conversation> listGroup = converService.findAllGroup();
			System.out.println(listGroup);
			request.setAttribute("listU", listGroup);			
			RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/ChatGroup/chatGroupManager.jsp");
			rd.forward(request, response);			
	    }
}