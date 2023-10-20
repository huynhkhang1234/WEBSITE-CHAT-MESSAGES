package com.chatweb.restControllers;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.poly.chatweb.daos.impl.FriendDao;
import com.poly.chatweb.models.Friend;

@WebServlet("/friend-rest-controller")
public class FriendRestController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public FriendRestController() {
		super();
	}

	
	//tìm bạn với nội dung message , ko có trả về any.
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		  response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
		String sender = request.getParameter("sender");
		String receiver = request.getParameter("receiver");

		Friend friend = new FriendDao().findFriend(sender, receiver);
		if(friend == null) {
			friend = new Friend("any", "any", "any", false);
		}
		ObjectMapper objectMapper = new ObjectMapper();
		String json = objectMapper.writeValueAsString(friend);

		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");

		PrintWriter printWriter = response.getWriter();
		printWriter.print(json);
		printWriter.flush();

	}
}
