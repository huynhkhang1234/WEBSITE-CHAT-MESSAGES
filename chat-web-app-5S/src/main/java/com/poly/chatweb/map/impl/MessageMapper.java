package com.poly.chatweb.map.impl;

import java.sql.ResultSet;
import java.sql.SQLException;

import com.poly.chatweb.map.RowMapperInterface;
import com.poly.chatweb.models.Message;

public class MessageMapper implements RowMapperInterface<Message> {

	@Override
	public Message mapRow(ResultSet resultSet) {
		try {
			Message message = new Message();
			message.setUsername(resultSet.getString("sender").trim());
			message.setMessage(resultSet.getString("message"));
			message.setType(resultSet.getString("message_type").trim());
			if (resultSet.getString("receiver") != null) {
				message.setReceiver(resultSet.getString("receiver").trim());
			}
			try {
				message.setAvatar(resultSet.getString("avatar").trim());
			} catch (SQLException ex) {
				return message;
			}
			return message;
		} catch (SQLException e) {
			return null;
		}
	}
}
