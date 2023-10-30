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

import com.chatweb.services.ConversationServiceInterface;
import com.chatweb.services.impl.ConversationService;
import com.poly.chatweb.dto.ConversationDTO;

@WebServlet("/conversation")
@MultipartConfig
public class ConversationController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private ConversationServiceInterface conversationServiceInterface = ConversationService.getInstance();

	public ConversationController() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		  response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
		String url = request.getContextPath();
		String conversationId = request.getParameter("conversationId");
		String destPage = "/WEB-INF/views/group-form.jsp";
		if (conversationId != null && !conversationId.isEmpty()) {
			Long id = Long.parseLong(conversationId);
			ConversationDTO conversationDTO = conversationServiceInterface.getConversationById(id);
			request.setAttribute("conversationDTO", conversationDTO);
			RequestDispatcher rd = request.getRequestDispatcher(destPage);
			rd.forward(request, response);
		} else {
			destPage = "/chat";
			response.sendRedirect(url+destPage);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		  response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
		System.out.println("conversations 2 người");
		String conversationId = request.getParameter("groupId");
		String groupName = request.getParameter("groupName").trim();
		Part avatar = request.getPart("avatar");
		Long id = Long.parseLong(conversationId);
		conversationServiceInterface.updateConversationById(id, groupName, avatar);
		String url = request.getContextPath();
		response.sendRedirect(url+"/chat");
	}
}
