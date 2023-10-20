package com.poly.chatweb.dao;

import java.util.List;

import com.poly.chatweb.models.User;

public interface UserDaoInterface extends GenericDaoInterface<User> {
	User findByUserNameAndPassword(String userName, String password);

	void saveUser(Boolean isRegister, User user);

	List<User> findFriends(String userName);

	List<User> findFriendsByKeyWord(String userName, String keyword);

	List<User> findUsersByConversationId(Long id);

	List<User> findFriendsNotInConversation(String userName, String keyword, Long conversationId);

	User findByUsername(String username);
	
	void updatePassword(String username, String newPassword);
}
