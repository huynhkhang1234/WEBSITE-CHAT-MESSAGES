package com.poly.chatweb.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chatweb.services.UserServiceInterface;
import com.chatweb.services.impl.UserService;
import com.poly.chatweb.models.User;

@WebServlet("/loadUser")
@MultipartConfig
public class loadUserIcon extends HttpServlet {
	private UserServiceInterface userService = UserService.getInstance();
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {           
        List<User> listUser = userService.getAllUser();		
		request.setAttribute("allUser", listUser);		
    }
}
