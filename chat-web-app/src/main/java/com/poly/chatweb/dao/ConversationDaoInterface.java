package com.poly.chatweb.dao;

import java.util.List;

import com.poly.chatweb.models.Conversation;
import com.poly.chatweb.models.User;

public interface ConversationDaoInterface {
	void saveConversation(Conversation conversation, List<User> users);

	List<Conversation> findAllConversationsByUsername(String username);

	Conversation findConversationById(Long id);
	
	List<Conversation> findConversationsOfUserByKeyword(String username, String keyword);

	void deleteConversationById(Long id);

	void deleteUserFromConversation(Long conversationId, String username);
}
