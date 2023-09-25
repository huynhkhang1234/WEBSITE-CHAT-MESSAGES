package com.poly.chatweb.dao;

import java.util.List;

import com.poly.chatweb.models.Message;

public interface MessageDaoInterface extends GenericDaoInterface<Message> {
	List<Message> findAllMessagesBySenderAndReceiver(String sender, String receiver);

	void saveMessage(Message message);
	
	List<Message> findAllMessagesByConvesationId(Long id);
}
