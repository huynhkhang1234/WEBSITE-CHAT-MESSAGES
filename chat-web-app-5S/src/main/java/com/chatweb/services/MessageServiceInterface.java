package com.chatweb.services;

import java.util.List;

import com.poly.chatweb.dto.MessageDTO;

public interface MessageServiceInterface {
	public List<MessageDTO> getAllMessagesBySenderAndReceiver(String sender, String receiver);

	public void saveMessage(MessageDTO messageDTO);
}
