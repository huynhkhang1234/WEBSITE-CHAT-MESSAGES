package com.chatweb.restControllers;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chatweb.services.ConversationServiceInterface;
import com.chatweb.services.impl.ConversationService;

@WebServlet("/update-conversations-rest-controller")
public class UpdateGroupRest extends HttpServlet {
	private ConversationServiceInterface conversationServiceInterface = ConversationService.getInstance();
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("test");
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");		
		String conversationId = request.getParameter("conversationId");		
		Long id = Long.parseLong(conversationId);		
		conversationServiceInterface.updateGroup(id);

	}
}
