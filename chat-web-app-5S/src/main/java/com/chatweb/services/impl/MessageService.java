package com.chatweb.services.impl;

import java.util.ArrayList;
import java.util.List;

import com.chatweb.services.FileServiceAbstract;
import com.chatweb.services.MessageServiceInterface;
import com.poly.chatweb.dao.MessageDaoInterface;
import com.poly.chatweb.daos.impl.MessageDao;
import com.poly.chatweb.dto.MessageDTO;
import com.poly.chatweb.models.Message;

public class MessageService implements MessageServiceInterface {
	private static MessageService instance = null;

	private MessageDaoInterface messageDaoInterface = MessageDao.getInstance();

	public synchronized static MessageService getInstance() {
		if (instance == null) {
			instance = new MessageService();
		}
		return instance;
	}

	private Message convertToEntity(MessageDTO messageDTO) {
		String username = messageDTO.getUsername();
		String message = messageDTO.getMessage();
		String type = messageDTO.getType();
		String receiver = messageDTO.getReceiver();
		Long groupId = messageDTO.getGroupId();
		Message messageEntity = new Message(username, message, type, receiver, groupId);
		return messageEntity;
	}

	private MessageDTO convertToDTO(Message messageEntity) {
		String username = messageEntity.getUsername();
		String type = messageEntity.getType();
		String message = messageEntity.getMessage();
		if (!type.equals("text")) {
			message = FileServiceAbstract.toTagHtml(type, username, message);
		}
		String receiver = messageEntity.getReceiver();
		Long groupId = messageEntity.getGroupId();
		MessageDTO messageDTO = new MessageDTO(username, message, type, receiver, groupId);
		return messageDTO;
	}

	@Override
	public List<MessageDTO> getAllMessagesBySenderAndReceiver(String sender, String receiver) {
		List<Message> listMessages = messageDaoInterface.findAllMessagesBySenderAndReceiver(sender, receiver);
		System.out.println("message nhắn tin" + listMessages);
		List<MessageDTO> listMessageDTOs = new ArrayList<MessageDTO>();
		listMessages.stream().forEach(msg -> {
			MessageDTO messageDTO = convertToDTO(msg);
			listMessageDTOs.add(messageDTO);
		});
		return listMessageDTOs;
	}

	@Override
	public void saveMessage(MessageDTO messageDTO) {
		Message messageEntity = convertToEntity(messageDTO);
		messageDaoInterface.saveMessage(messageEntity);
	}

}
