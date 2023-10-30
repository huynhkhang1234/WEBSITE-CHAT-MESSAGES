package com.chatweb.services.impl;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.http.Part;

import com.chatweb.services.ConversationServiceInterface;
import com.chatweb.services.FileServiceAbstract;
import com.poly.chatweb.dao.ConversationDaoInterface;
import com.poly.chatweb.dao.MessageDaoInterface;
import com.poly.chatweb.dao.UserDaoInterface;
import com.poly.chatweb.daos.impl.ConversationDao;
import com.poly.chatweb.daos.impl.MessageDao;
import com.poly.chatweb.daos.impl.UserDao;
import com.poly.chatweb.dto.ConversationDTO;
import com.poly.chatweb.dto.MessageDTO;
import com.poly.chatweb.dto.UserDTO;
import com.poly.chatweb.models.Conversation;
import com.poly.chatweb.models.Message;
import com.poly.chatweb.models.User;

public class ConversationService implements ConversationServiceInterface {

	private ConversationDaoInterface conversationDaoInterface = ConversationDao.getInstance();

	private UserDaoInterface userDaoInterface = UserDao.getInstace();

	private MessageDaoInterface messageDaoInterface = MessageDao.getInstance();

	private static ConversationService instance = null;

	private ConversationService() {

	}

	public synchronized static ConversationService getInstance() {
		if (instance == null) {
			instance = new ConversationService();
		}
		return instance;
	}

	private User convertToUserEntity(UserDTO userDTO) {
		User user = new User();
		user.setUsername(userDTO.getUsername());
		user.setAdmin(userDTO.isAdmin());
		return user;
	}

	private UserDTO convertToUserDTO(User user) {
		UserDTO userDTO = new UserDTO();
		userDTO.setUsername(user.getUsername());
		userDTO.setAvatar(user.getAvatar());
		userDTO.setAdmin(user.isAdmin());
		return userDTO;
	}

	private ConversationDTO convertToConversationDTO(Conversation conversation) {
		ConversationDTO conversationDTO = new ConversationDTO();
		conversationDTO.setId(conversation.getId());
		conversationDTO.setName(conversation.getName());
		conversationDTO.setAvatar(conversation.getAvatar());
		conversationDTO.setHideGroup(conversation.isHideGroup());

		conversationDTO.setIsActive(conversation.getIsActive());
		return conversationDTO;
	}

	private Conversation convertToConversation(ConversationDTO conversationDTO) {
		Conversation conversation = new Conversation();
		conversation.setId(conversationDTO.getId());
		conversation.setName(conversationDTO.getName());
		conversation.setHideGroup(conversationDTO.isHideGroup());
		if (conversationDTO.getAvatar() != null && !conversationDTO.getAvatar().isEmpty()) {
			conversation.setAvatar(conversationDTO.getAvatar().trim());
		}
		return conversation;
	}

	private MessageDTO convertToMessageDTO(Message messageEntity) {
		String username = messageEntity.getUsername();
		String type = messageEntity.getType();
		String message = messageEntity.getMessage();
		if (!type.equals("text")) {
			message = FileServiceAbstract.toTagHtml(type, username, message);
		}
		String receiver = messageEntity.getReceiver();
		Long groupId = messageEntity.getGroupId();
		MessageDTO messageDTO = new MessageDTO(username, message, type, receiver, groupId);
		messageDTO.setAvatar(messageEntity.getAvatar());
		return messageDTO;
	}

	@Override
	public void saveConversation(ConversationDTO conversationDTO) {
		Conversation conversation = convertToConversation(conversationDTO);
		List<User> users = conversationDTO.getUsers().stream().map(userDTO -> convertToUserEntity(userDTO))
				.collect(Collectors.toList());
		conversationDaoInterface.saveConversation(conversation, users);
		conversationDTO.setId(conversation.getId());

		String dirName = "group-" + conversationDTO.getId();
		File privateDir = new File(FileServiceAbstract.rootLocation.toString() + "/" + dirName);
		privateDir.mkdir();
		String fileName = dirName + ".png";
		File newFile = new File(privateDir.toString() + "/" + fileName);
		try {
			File defaultAvatar = new File(FileServiceAbstract.rootLocation.toString() + "/default/group.png");
			Files.copy(defaultAvatar.toPath(), newFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
			conversation.setAvatar(fileName);
			conversationDaoInterface.saveConversation(conversation, null);
			conversationDTO.setAvatar(fileName);
		} catch (IOException ex) {
		}
	}

	@Override
	public List<ConversationDTO> getAllConversationsByUsername(String username) {
		List<Conversation> conversations = conversationDaoInterface.findAllConversationsByUsername(username);
		List<ConversationDTO> conversationDTOs = conversations.stream()
				.map(conversation -> convertToConversationDTO(conversation)).collect(Collectors.toList());
		return conversationDTOs;
	}

	@Override
	public List<UserDTO> getAllUsersByConversationId(Long id) {
		List<UserDTO> userDTOs = userDaoInterface.findUsersByConversationId(id).stream()
				.map(user -> convertToUserDTO(user)).collect(Collectors.toList());
		return userDTOs;
	}

	@Override
	public List<MessageDTO> getAllMessagesByConversationId(Long id) {
		List<MessageDTO> messageDTOs = messageDaoInterface.findAllMessagesByConvesationId(id).stream()
				.map(message -> convertToMessageDTO(message)).collect(Collectors.toList());
		return messageDTOs;
	}

	@Override
	public void updateConversationById(Long id, String name, Part avatar) {
		try {
			String fileName = "";
			String origin = avatar.getSubmittedFileName();
			if (!origin.isEmpty()) {
				String dirName = "group-" + id;
				File privateDir = new File(FileServiceAbstract.rootLocation.toString() + "/" + dirName);
				String tail = origin.substring(origin.lastIndexOf("."), origin.length());
				fileName = dirName + tail;
				System.err.println("file: " + fileName);
				avatar.write(privateDir.getAbsolutePath() + File.separator + fileName);
			}
			Conversation conversation = new Conversation(id, name, fileName,false);
			
			conversationDaoInterface.saveConversation(conversation, null);
		} catch (IOException ex) {
		}
	}

	@Override
	public ConversationDTO getConversationById(Long id) {
		Conversation conversation = conversationDaoInterface.findConversationById(id);
		return convertToConversationDTO(conversation);
	}

	@Override
	public void deleteConversationById(Long id) {
		conversationDaoInterface.deleteConversationById(id);

	}

	@Override
	public void deleteUserFromConversation(Long conversationId, String username) {
		conversationDaoInterface.deleteUserFromConversation(conversationId, username);
	}

	@Override
	public List<ConversationDTO> getConversationsOfUserByKeyword(String username, String keyword) {
		List<ConversationDTO> conversationDTOs = conversationDaoInterface
				.findConversationsOfUserByKeyword(username, keyword).stream()
				.map(conversation -> convertToConversationDTO(conversation)).collect(Collectors.toList());
		return conversationDTOs;
	}

	@Override
	public void updateGroup(Long id) {
		conversationDaoInterface.updateGroup(id);
		
	}

	@Override
	public String findIsActive(String id) {	
		return conversationDaoInterface.findIsActive(id) ;
	}
	@Override
	public void hideGroup(ConversationDTO conversationDTO) {
		conversationDTO.setHideGroup(!conversationDTO.isHideGroup());
		System.out.println("203" + conversationDTO.isHideGroup());
		Conversation conversation = convertToConversation(conversationDTO);
		System.out.println("204 service - " + conversation.isHideGroup());
		conversationDaoInterface.saveConversation(conversation, null);
	}

	@Override
	public List<Conversation> findAllGroup() {
		List<Conversation> listU = conversationDaoInterface.findAllGroup();
		return listU;
	}

	@Override
	public Conversation findUserByUsername(String username) {
		Conversation user = conversationDaoInterface.findUserByUsername(username);
		return user;
	}

	@Override
	public void changeActive(String username, String status) {
		conversationDaoInterface.changeActive(username, status);
		
	}

	@Override
	public void chatBlock(String sql) {
		 conversationDaoInterface.chatBlock(sql);
		
	}


	
}
