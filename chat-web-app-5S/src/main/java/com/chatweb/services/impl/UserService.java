package com.chatweb.services.impl;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.Part;

import com.chatweb.services.FileServiceAbstract;
import com.chatweb.services.UserServiceInterface;
import com.poly.chatweb.dao.UserDaoInterface;
import com.poly.chatweb.daos.impl.UserDao;
import com.poly.chatweb.models.Conversation;
import com.poly.chatweb.models.User;

public class UserService implements UserServiceInterface {
	private static UserService instance = null;

	private UserDaoInterface userDaoInterface = UserDao.getInstace();

	public synchronized static UserService getInstance() {
		if (instance == null) {
			instance = new UserService();
		}
		return instance;
	}

	private UserService() {
		 // Thay "ten_thu_muc_moi" bằng tên thư mục bạn muốn tạo
		String newDirectoryName = "data";
		//đường dẫn tạo file mới: khang chằng hạng.
		String newDirectoryPath = FileServiceAbstract.rootLocation + File.separator + newDirectoryName;
		//lưu đường dẫn cuối cùng. để hiện thị.
		FileServiceAbstract.rootLocationURLImage = newDirectoryPath;
		File newDirectory = new File(newDirectoryPath);
		System.out.println("Root path: " + newDirectoryPath);
		if (!newDirectory.exists()) {
		    System.out.println("Tạo thư mục");
		    newDirectory.mkdirs(); // Tạo cả thư mục cha "D:\data" nếu nó chưa tồn tại
		}
	}

	@Override
	public void saveUser(Boolean isRegister, String username, String password, boolean gender, Part avatar, boolean isAdmin, boolean isActive) {
	    try {
	    	if(avatar==null) {
	    		User userEntity = new User(username, password, gender, null, isAdmin, isActive);
		        userDaoInterface.saveUser(isRegister, userEntity);
		        return;
	    	}
	        String origin = avatar.getSubmittedFileName();
	        String fileName;
	        if (origin != null && !origin.isEmpty()) {
	            // Tạo tên tệp mới bằng cách nối username với tên gốc (bao gồm phần mở rộng)
	            fileName = username + "-" + origin;
	            // Lấy thư mục lưu trữ
	            File privateDir = new File(FileServiceAbstract.rootLocation.toString() + "/" + username);
	            privateDir.mkdir();
	            // Lưu ảnh vào thư mục với tên mới
	            avatar.write(privateDir.getAbsolutePath() + File.separator + fileName);
	        } else {
	            // Xử lý nếu không có tên tệp gốc
	            System.out.println("Tên tệp gốc rỗng hoặc null.");
	            return; // Thêm xử lý khác nếu cần thiết
	        }
	        // Tạo user mới
	        User userEntity = new User(username, password, gender, fileName, isAdmin, isActive);
	        userDaoInterface.saveUser(isRegister, userEntity);
	    } catch (IOException ex) {
	        System.out.println(ex.getMessage());
	        ex.printStackTrace();
	    }
	}


	@Override
	public User findUser(String username, String password) {
		User user = userDaoInterface.findByUserNameAndPassword(username, password);
		return user;
	}

	@Override
	public List<User> findFriends(String username) {
		List<User> friends = userDaoInterface.findFriends(username);
		return friends;
	}

	public List<User> findFriendsByKeyWord(String username, String keyword) {
		List<User> friends = userDaoInterface.findFriendsByKeyWord(username, keyword);
		return friends;
	}

	@Override
	public List<User> getFriendsNotInConversation(String userName, String keyword, Long conversationId) {
		List<User> friends = userDaoInterface.findFriendsNotInConversation(userName, keyword, conversationId);
		return friends;
	}

	@Override
	public boolean usernameIsExit(String username) {
		User user = userDaoInterface.findByUsername(username);
		if (user == null) {
			return false;
		}
		return true;
	}

	@Override
	public void updatePassword(String username, String newPassword) {
		// TODO Auto-generated method stub
		userDaoInterface.updatePassword(username, newPassword);
		
	}
	
	@Override
	public List<User> getAllUser() {
		List<User> listU = userDaoInterface.findAllUser();
		return listU;
	}

	@Override
	public User findUserByUsername(String username) {
		User user = userDaoInterface.findUserByUsername(username);
		return user;
	}

	@Override
	public void changeActive(String username, boolean status) {
		userDaoInterface.changeActive(username, status);
		
	}

	@Override
	public void userBlock(String sql) {
		userDaoInterface.userBlock(sql);

	}
}
