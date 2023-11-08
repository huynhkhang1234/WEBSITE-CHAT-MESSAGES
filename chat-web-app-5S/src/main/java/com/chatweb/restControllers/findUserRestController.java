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
@WebServlet("/find-user")
public class findUserRestController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private UserServiceInterface userServiceInterface = UserService.getInstance();
	private ChatService chatService = ChatService.getInstance();

	public findUserRestController() {
		super();
	}
	int checkLogin = 0;
	
	//sử lí kiểm tra xem có tồn tại user và trang thái on hay ko bằng socket.
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		  response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
		
		String keyWord = request.getParameter("keyword");
		
		System.out.println("key"+keyWord);
		List<User> listUsers = null;
		
//		//tìm kiếm bạn khi key rỗng
		 if (keyWord.isEmpty()) {
			System.out.println("tim kiếm ko phải bạn bè.");
			listUsers = userServiceInterface.getAllUser();
		}//tìm bạn theo keys 
		else {
			//System.out.println("tim kiếm ban thứ 3");
			listUsers = userServiceInterface.findFriends(keyWord.trim());
		}
		 System.out.println(listUsers);
		if(listUsers != null) {
			for (User user : listUsers) {
				user.setOnline(chatService.isUserOnline(user.getUsername()));
			}	
		}
		
		System.out.println(listUsers);
		ObjectMapper objectMapper = new ObjectMapper();
		String json = objectMapper.writeValueAsString(listUsers);

		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");

		PrintWriter printWriter = response.getWriter();
		printWriter.print(json);
		printWriter.flush();
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
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