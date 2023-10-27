package com.chatweb.services;

import java.util.List;

import javax.servlet.http.Part;

import com.poly.chatweb.dto.ConversationDTO;
import com.poly.chatweb.dto.MessageDTO;
import com.poly.chatweb.dto.UserDTO;

public interface ConversationServiceInterface {
	public void saveConversation(ConversationDTO conversationDTO);

	public List<ConversationDTO> getAllConversationsByUsername(String username);

	public List<UserDTO> getAllUsersByConversationId(Long id);

	public List<MessageDTO> getAllMessagesByConversationId(Long id);

	public void updateConversationById(Long id, String name, Part avatar);

	public ConversationDTO getConversationById(Long id);

	void deleteConversationById(Long id);

	void deleteUserFromConversation(Long conversationId, String username);

	public List<ConversationDTO> getConversationsOfUserByKeyword(String username, String keyword);
	
	void updateGroup(Long id);
	
	String findIsActive(String id);

	 void hideGroup(ConversationDTO conversationDTO1);
}
