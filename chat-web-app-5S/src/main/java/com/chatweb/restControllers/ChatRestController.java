package com.chatweb.restControllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chatweb.services.MessageServiceInterface;
import com.chatweb.services.impl.MessageService;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.poly.chatweb.dto.MessageDTO;

@WebServlet("/chat-rest-controller")
public class ChatRestController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private MessageServiceInterface messageServiceInterface = MessageService.getInstance();

	public ChatRestController() {
		super();
	}
	//lấy thông tin từ tin nhắn và load lại giao diện.
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String sender = request.getParameter("sender");
		String receiver = request.getParameter("receiver");
		System.out.println("sender:" + sender);
		System.out.println("receiver:" + receiver);
		List<MessageDTO> messages = messageServiceInterface.getAllMessagesBySenderAndReceiver(sender, receiver);
		System.out.println("tin nhắn đã nhắn:" + messages);
		ObjectMapper objectMapper = new ObjectMapper();
		String json = objectMapper.writeValueAsString(messages);
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");

		PrintWriter printWriter = response.getWriter();
		printWriter.print(json);
		printWriter.flush();
	}
	
}
