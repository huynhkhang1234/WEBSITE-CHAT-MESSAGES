package com.chatweb.restControllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.chatweb.services.UserServiceInterface;
import com.chatweb.services.impl.ChatService;
import com.chatweb.services.impl.UserService;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.poly.chatweb.models.User;

@MultipartConfig
@WebServlet("/users-rest-controller")
public class UserRestController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private UserServiceInterface userServiceInterface = UserService.getInstance();
	private ChatService chatService = ChatService.getInstance();

	public UserRestController() {
		super();
	}
	int checkLogin = 0;
	
	//sử lí kiểm tra xem có tồn tại user và trang thái on hay ko bằng socket.
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		  response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
		String userName = request.getParameter("username");
		String keyWord = request.getParameter("keyword");
		System.out.println("name:"+userName);
		System.out.println("key"+keyWord);
		String conversationId = request.getParameter("conversationId");
		System.out.println("id"+conversationId);
		List<User> listUsers;
		if (conversationId != null && !conversationId.isEmpty()) {
			Long id = Long.parseLong(conversationId);
			listUsers = userServiceInterface.getFriendsNotInConversation(userName, keyWord, id);
		}
		//tìm kiếm bạn khi key rỗng
		else if (keyWord.isEmpty()) {
			listUsers = userServiceInterface.findFriends(userName);
		}//tìm bạn theo keys 
		else {
			listUsers = userServiceInterface.findFriendsByKeyWord(userName, keyWord);
		}
		for (User user : listUsers) {
			user.setOnline(chatService.isUserOnline(user.getUsername()));
		}
		ObjectMapper objectMapper = new ObjectMapper();
		String json = objectMapper.writeValueAsString(listUsers);

		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");

		PrintWriter printWriter = response.getWriter();
		printWriter.print(json);
		printWriter.flush();
	}protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		  response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		boolean isAdmin = Boolean.valueOf(request.getParameter("isAdmin"));
	    boolean isActive = Boolean.valueOf(request.getParameter("isActive"));
		//kiểm tra username đã tồn tại
		if(userServiceInterface.usernameIsExit(username)==true) {
			checkLogin = 1;
			 request.setAttribute("annotationLG", checkLogin);
			 System.out.println(checkLogin);
				String url  = request.getContextPath();
				RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/ChatGroup/sign-up.jsp");
				rd.forward(request, response);
		}else {
			Boolean gender= Boolean.valueOf(request.getParameter("gender"));
			Part avarta = request.getPart("avarta");
			userServiceInterface.saveUser(true, username, password, gender, avarta, isAdmin, true);

			RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/ChatGroup/sign-in.jsp");
			rd.forward(request, response);
		}
	
	}
}