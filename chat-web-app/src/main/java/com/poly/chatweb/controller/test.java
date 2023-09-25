package com.poly.chatweb.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/cute")
public class test extends HttpServlet {
	 protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	        // Đoạn mã xử lý ở đây, ví dụ: chuyển hướng trang
	      System.out.println("cu te no ko bat");
	      RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/group-form.jsp");
			rd.forward(request, response);
	    }
}
