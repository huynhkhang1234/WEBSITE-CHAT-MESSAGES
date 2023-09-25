package com.chatweb.services;

import java.nio.ByteBuffer;
import java.util.HashSet;
import java.util.Queue;
import java.util.Set;
import java.util.concurrent.CopyOnWriteArraySet;

import com.chatweb.websockets.ChatWebsocket;
import com.poly.chatweb.dto.FileDTO;
import com.poly.chatweb.dto.MessageDTO;

public abstract class ChatServiceAbstract {

	protected static final Set<ChatWebsocket> chatWebsockets = new CopyOnWriteArraySet<>();
	
	public abstract boolean register(ChatWebsocket chatWebsocket);

	public abstract boolean close(ChatWebsocket chatWebsocket);

	public abstract void sendMessageToAllUsers(MessageDTO message);

	public abstract void sendMessageToOneUser(MessageDTO message, Queue<FileDTO> fileDTOs);

	public abstract void handleFileUpload(ByteBuffer byteBuffer, boolean last, Queue<FileDTO> fileDTOs);

	public abstract boolean isUserOnline(String username);
	
	protected Set<String> getUsernames() {
		Set<String> usernames = new HashSet<String>();
		chatWebsockets.forEach(chatWebsocket -> {
			usernames.add(chatWebsocket.getUsername());
		});
		return usernames;
	}
}
