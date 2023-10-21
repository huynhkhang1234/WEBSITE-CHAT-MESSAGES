package com.chatweb.services;

import java.io.File;

import javax.servlet.http.HttpServletResponse;

public abstract class FileServiceAbstract {
	
	//đường dẫn tổng từ trang ở đỉa lên trang web	      
	public static String rootLocation = "D:\\CongoTY5S_Group\\code\\WEBSITE-CHAT-MESSAGES\\chat-web-app-5S\\src\\main\\webapp\\static";
	//đường dẫn từ hình ảnh mới tạo lên vd: khang-> khang.jpg.
	public static String rootLocationURLImage = "";	
	
	public static String rootLocationShowImage = "http://localhost:8080/chat-web-app/static";
	
	public static String rootURL = "";	

	public static String toTagHtml(String type, String username, String message) {
		//giữ liệu hiện thị đường dẫn trên image khi chat.
		String tag = "";
		String url = "/chat-web-app/static/data/"+ username + "/" + message;		
		if (type.startsWith("audio")) {
			tag = "<audio controls>\r\n" + "  <source src=\"" + url + "\" type=\"" + type + "\">\r\n" + "</audio>";
		} else if (type.startsWith("video")) {
			tag = "<video width=\"400\" controls>\r\n" + "  <source src=\"" + url + "\" type=\"" + type + "\">\r\n"
					+ "</video>";
		} else if (type.startsWith("image")) {
			//System.out.println("Hình ảnh :" +url);
			tag = "<img src=\"" + url + "\" alt=\"\">";
			//tag = "<img src=\"" +"/chat-web-app/static/images/anh2.png" + "\" alt=\"\">";
			//tag = "<img src=\"" +"/chat-web-app/static/images/anh2.jpg" + "\" alt=\"\">";
		}
		else {
			tag = "<a href="+url+">"+message+"</a>";
		}
		return tag;
	}

	protected static final int DEFAULT_BUFFER_SIZE = 10240;

	public abstract void handleStreamFileToClient(File file, String contentType, HttpServletResponse response);
}
