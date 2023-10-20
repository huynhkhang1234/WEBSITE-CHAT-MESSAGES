package com.chatweb.restControllers;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chatweb.services.ConversationServiceInterface;
import com.chatweb.services.impl.ConversationService;
import com.fasterxml.jackson.databind.ObjectMapper;


@WebServlet("/api/getGroupIsactive")
public class GetGroupIsActive extends HttpServlet {
	
	private ConversationServiceInterface conversationServiceInterface = ConversationService.getInstance();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String id = request.getParameter("conversationId");				
		conversationServiceInterface.findIsActive(id);		
		String json = conversationServiceInterface.findIsActive(id);		;
		ObjectMapper objectMapper = new ObjectMapper();
		json = objectMapper.writeValueAsString(json);
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		PrintWriter printWriter = response.getWriter();
		printWriter.print(json);
		printWriter.flush();
	}
}
