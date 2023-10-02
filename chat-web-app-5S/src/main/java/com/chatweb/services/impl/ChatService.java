package com.chatweb.services.impl;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.ByteBuffer;
import java.util.List;
import java.util.Queue;
import java.util.Set;
import java.util.stream.Collectors;

import javax.websocket.EncodeException;

import com.chatweb.services.ChatServiceAbstract;
import com.chatweb.services.FileServiceAbstract;
import com.chatweb.websockets.ChatWebsocket;
import com.poly.chatweb.dao.UserDaoInterface;
import com.poly.chatweb.daos.impl.UserDao;
import com.poly.chatweb.dto.FileDTO;
import com.poly.chatweb.dto.MessageDTO;
import com.poly.chatweb.models.User;



public class ChatService extends ChatServiceAbstract {

	private static ChatService chatService = null;

	private UserDaoInterface userDaoInterface = UserDao.getInstace();

	private ChatService() {
	}

	public synchronized static ChatService getInstance() {
		if (chatService == null) {
			chatService = new ChatService();
		}
		return chatService;
	}

	@Override
	public boolean register(ChatWebsocket chatWebsocket) {
		return chatWebsockets.add(chatWebsocket);
	}

	@Override
	public boolean close(ChatWebsocket chatWebsocket) {
		return chatWebsockets.remove(chatWebsocket);
	}

	@Override
	public boolean isUserOnline(String username) {
		for (ChatWebsocket chatWebsocket : chatWebsockets) {
			if (chatWebsocket.getUsername().equals(username)) {
				return true;
			}
		}
		return false;
	}

	@Override
	public void sendMessageToAllUsers(MessageDTO message) {
		message.setOnlineList(getUsernames());
		chatWebsockets.stream().forEach(chatWebsocket -> {
			try {
				chatWebsocket.getSession().getBasicRemote().sendObject(message);
			} catch (IOException | EncodeException e) {
				e.printStackTrace();
			}
		});
	}
	//gửi hình là chạy vô. 
	@Override
	public void sendMessageToOneUser(MessageDTO message, Queue<FileDTO> fileDTOs) {
		if (!message.getType().equals("text")) {
			String fileName = message.getMessage();
			fileName = fileName.replaceAll("\\s+", "");
			//lấy đường dẫn tọa file mới chứa ảnh.
			String destFile = FileServiceAbstract.rootLocationURLImage.toString() + "/" + message.getUsername() + "/"
					+ fileName;			
			String destFile2 = FileServiceAbstract.rootLocationURLImage.toString() + "/" + message.getUsername();					
			File uploadedFile = new File(destFile);
			File uploadedFile2 = new File(destFile2);			System.out.println("tạo file:" + uploadedFile);
			if (!uploadedFile2.exists()) {
			    System.out.println("Tạo thư mục");
			    uploadedFile2.mkdirs(); // Tạo cả thư mục cha "D:\data" nếu nó chưa tồn tại
			}
			
			String sender = message.getUsername();
			String receiver = message.getReceiver();
			Long groupId = message.getGroupId();
			String url = FileServiceAbstract.rootLocationShowImage+"/data/"+sender+"/" +fileName;						
			try {
				FileOutputStream fileOutputStream = new FileOutputStream(uploadedFile, false);
				FileDTO newFileDTO = new FileDTO(fileName, message.getType(), fileOutputStream, sender, receiver,
						groupId, url);
				System.out.println("fileOutStream:" + fileOutputStream);
				////
				long initialSize = fileOutputStream.getChannel().size();	
				System.out.println("Kích thước ban đầu của fileOutputStream: " + initialSize + " byte");		
				fileDTOs.add(newFileDTO);
			} catch (FileNotFoundException ex) {
				ex.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else {
			//gửi tin nhắn dạng chữ.
			if (message.getReceiver() != null) {
				chatWebsockets.stream()
						.filter(chatWebsocket -> chatWebsocket.getUsername().equals(message.getReceiver()))
						.forEach(chatWebsocket -> {
							try {
								chatWebsocket.getSession().getBasicRemote().sendObject(message);
							} catch (IOException | EncodeException e) {
								e.printStackTrace();
							}
						});
			} else {
				List<User> usersGroup = userDaoInterface.findUsersByConversationId(message.getGroupId());

				User sender = usersGroup.stream().filter(u -> u.getUsername().equals(message.getUsername()))
						.collect(Collectors.toList()).get(0);
				message.setAvatar(sender.getAvatar());

				Set<String> usernamesGroup = usersGroup.stream().map(User::getUsername).collect(Collectors.toSet());

				chatWebsockets.stream()
						.filter(chatWebsocket -> usernamesGroup.contains(chatWebsocket.getUsername())
								&& !chatWebsocket.getUsername().equals(message.getUsername()))
						.forEach(chatWebsocket -> {
							try {
								chatWebsocket.getSession().getBasicRemote().sendObject(message);
							} catch (IOException | EncodeException e) {
								e.printStackTrace();
							}
						});
			}
		}
	}
	//đợi hàng chờ khi gửi file lên và cập nhật file.
	@Override
	public void handleFileUpload(ByteBuffer byteBuffer, boolean last, Queue<FileDTO> fileDTOs) {
		try {
			if (!last) {
				while (byteBuffer.hasRemaining()) {
					fileDTOs.peek().getFileOutputStream().write(byteBuffer.get());
				}
			}
			else {
				if(byteBuffer.array().length > 0){
					while (byteBuffer.hasRemaining()) {
						fileDTOs.peek().getFileOutputStream().write(byteBuffer.get());
					}
				}
				fileDTOs.peek().getFileOutputStream().flush();
				fileDTOs.peek().getFileOutputStream().close();
				System.out
						.println("Done: " + fileDTOs.peek().getFilename() + " of user: " + fileDTOs.peek().getSender());
				String message = "<img src=\"" + fileDTOs.peek().getUrl() + "\" alt=\"\">";
				String typeFile = fileDTOs.peek().getTypeFile();
				if (typeFile.startsWith("audio")) {
					message = "<audio controls>\r\n" + "  <source src=\"" + fileDTOs.peek().getUrl() + "\" type=\""
							+ typeFile + "\">\r\n" + "</audio>";
				} else if (typeFile.startsWith("video")) {
					message = "<video width=\"400\" controls>\r\n" + "  <source src=\"" + fileDTOs.peek().getUrl()
							+ "\" type=\"" + typeFile + "\">\r\n" + "</video>";
				} else if (typeFile.startsWith("image")) {
					System.out.println("tệp đó là hình ảnh:" + fileDTOs.peek().getUrl());
					message = "<img src=\"" + fileDTOs.peek().getUrl() + "\" alt=\"\">";
				} else {
					message = "<a href=" + fileDTOs.peek().getUrl() + ">" + fileDTOs.peek().getFilename() + "</a>";
				}
				String type = "text";
				String username = fileDTOs.peek().getSender();
				String receiver = fileDTOs.peek().getReceiver();
				Long groupId = fileDTOs.peek().getGroupId();
				MessageDTO messageResponse = new MessageDTO(username, message, type, receiver, groupId);
				fileDTOs.remove();
				sendMessageToOneUser(messageResponse, fileDTOs);
			}

		} catch (IOException ex) {
			System.out.println(ex.getMessage());
			ex.printStackTrace();
		}
	}
}
