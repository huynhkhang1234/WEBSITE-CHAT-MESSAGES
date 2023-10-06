package com.chatweb.services.impl;

import java.io.File;
import java.io.IOException;
import java.net.URL;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;

import javax.servlet.http.Part;

import com.chatweb.services.FileServiceAbstract;
import com.chatweb.services.UserServiceInterface;
import com.poly.chatweb.dao.UserDaoInterface;
import com.poly.chatweb.daos.impl.UserDao;
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
	public void saveUser(Boolean isRegister, String username, String password, boolean gender, Part avatar) {
		System.out.println("Kiểm tra ảnh có tồn tại trong thư mục hay ko");
		System.out.println("avatar bên đây" +avatar);		 
		try {
			Path projectDirectory = Paths.get(System.getProperty("user.dir"));
			// Lấy thư mục cha của projectDirectory
			Path adminDirectory = projectDirectory.getParent();
			// In ra thư mục adminDirectory

			String basePath = adminDirectory.toString();

			String relativePath = "/eclipse-workspace_Java6/WEBSITE-CHAT-MESSAGES/chat-web-app-5S/src/main/webapp/static/images/"
					+ username;
			File privateDir = new File(basePath + relativePath);
			if (!privateDir.exists()) {
				privateDir.mkdirs();
			}
			System.out.println(privateDir.getPath());
			//đường dẫn ảnh tạo ra khi đăng kí với tên
			System.out.println("toi muon kiem tra hinh anh:" + FileServiceAbstract.rootLocation.toString() + "/" + username);
			File privateDir = new File(FileServiceAbstract.rootLocation.toString() + "/" + username);
			privateDir.mkdir();
			//tên thư mục gốc.
			String origin = avatar.getSubmittedFileName();
			String fileName = "";
			if (!origin.isEmpty()) {
				String tail = origin.substring(origin.lastIndexOf("."), origin.length());
				fileName = username + tail;
				avatar.write(privateDir.getAbsolutePath() + File.separator + fileName);

			} else {
				System.out.println("origin"+origin);
				System.out.println("FileService:"+FileServiceAbstract.rootLocation.toString());
				File defaultAvatar = new File(FileServiceAbstract.rootLocation.toString() + "/default/user-male.jpg");
				if (gender == false) {
					defaultAvatar = new File(FileServiceAbstract.rootLocation.toString() + "/default/user-female.jpg");
				}
				fileName = username + ".jpg";
				//đường dẫn ảnh tạo ra khi đăng kí với tên
				File newFile = new File(privateDir.toString() + "/" + fileName);
				System.out.println("Tạo thư mục:" +newFile);
				Files.copy(defaultAvatar.toPath(), newFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
				System.out.println("file name:" +fileName);
			}
			//tạo user mới.
			User userEntity = new User(username, password, gender, fileName);
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

}
