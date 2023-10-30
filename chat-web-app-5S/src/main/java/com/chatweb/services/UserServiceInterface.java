package com.chatweb.services;

import java.util.List;

import javax.servlet.http.Part;

import com.poly.chatweb.models.User;

public interface UserServiceInterface {

	public void saveUser(Boolean isRegister, String username, String password, boolean gender, Part avatar);

	public User findUser(String username, String password);
	
	public List<User> findFriends(String username);
	
	public List<User> findFriendsByKeyWord(String username, String keyword);

	public List<User> getFriendsNotInConversation(String userName, String keyword, Long conversationId);

	public List<User> getAllUser();
	
	public User findUserByUsername(String username);
	
	public void changeActive(String username, boolean status);
	
	public void userBlock(String sql);
}
