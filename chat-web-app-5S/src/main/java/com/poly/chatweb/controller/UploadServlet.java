package com.poly.chatweb.controller;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;

import com.chatweb.services.UserServiceInterface;
import com.chatweb.services.impl.UserService;
import com.poly.chatweb.models.User;

@WebServlet("/UploadServlet")
@MultipartConfig
public class UploadServlet extends HttpServlet {
	private UserServiceInterface userService = UserService.getInstance();
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    
        Part filePart = request.getPart("file"); // Lấy tệp được tải lên
        InputStream fileContent = filePart.getInputStream();
        
        try {
            Workbook workbook = WorkbookFactory.create(fileContent);
            org.apache.poi.ss.usermodel.Sheet sheet = workbook.getSheetAt(0); // Đây là ví dụ, bạn cần chỉ định sheet cụ thể

            for (int rowIndex = 1; rowIndex < sheet.getPhysicalNumberOfRows(); rowIndex++) {
                Row row = sheet.getRow(rowIndex);

                // Đọc dữ liệu từ từng dòng của tệp Excel và nhập vào cơ sở dữ liệu
                String username = row.getCell(0).getStringCellValue();
                String password;
                Cell cell = row.getCell(1);
                if (cell.getCellType() == CellType.NUMERIC) {
                    // Nếu ô là số, lấy giá trị số và chuyển thành chuỗi
                    double numericValue = cell.getNumericCellValue();
                    int intValue = (int) numericValue; // Chuyển đổi số thực thành số nguyên
                    password = String.valueOf(intValue); // Lưu giá trị số nguyên dưới dạng chuỗi
                } else if (cell.getCellType() == CellType.STRING) {
                    // Nếu ô là chuỗi, lấy giá trị chuỗi
                    password = cell.getStringCellValue();
                } else {
                    // Xử lý trường hợp khác nếu cần thiết
                    password = ""; // Hoặc bạn có thể xử lý theo cách khác tùy vào yêu cầu của bạn
                }
                
                Boolean gender = row.getCell(2).getBooleanCellValue();
                Boolean isadmin = row.getCell(2).getBooleanCellValue();
                userService.saveUser(true, username, password, gender, null, isadmin, true);
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Xử lý lỗi nếu có
        }
       
        List<User> listUser = userService.getAllUser();		
		request.setAttribute("listU", listUser);
		RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/ChatGroup/userManager.jsp");
		rd.forward(request, response);
    }
}
