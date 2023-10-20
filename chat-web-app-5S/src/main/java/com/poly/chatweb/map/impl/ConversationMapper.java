package com.poly.chatweb.map.impl;

import java.sql.ResultSet;
import java.sql.SQLException;

import com.poly.chatweb.map.RowMapperInterface;
import com.poly.chatweb.models.Conversation;

public class ConversationMapper implements RowMapperInterface<Conversation> {

	@Override
	public Conversation mapRow(ResultSet rs) {
		Conversation conversation = new Conversation();
		try {
			conversation.setIsActive(rs.getString("isActive"));	
			conversation.setId(rs.getLong("id"));
			conversation.setName(rs.getString("name"));
			conversation.setAvatar(rs.getString("avatar"));
					
		} catch (SQLException e) {
			return null;
		}
		return conversation;
	}

}
