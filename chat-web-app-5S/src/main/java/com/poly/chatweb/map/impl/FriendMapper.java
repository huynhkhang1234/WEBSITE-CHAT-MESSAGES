package com.poly.chatweb.map.impl;

import java.sql.ResultSet;
import java.sql.SQLException;

import com.poly.chatweb.map.RowMapperInterface;
import com.poly.chatweb.models.Friend;

public class FriendMapper implements RowMapperInterface<Friend> {

	@Override
	public Friend mapRow(ResultSet resultSet) {
		try {
			Friend friend = new Friend();
			friend.setSender(resultSet.getString("sender").trim());
			friend.setReceiver(resultSet.getString("receiver").trim());
			friend.setOwner(resultSet.getString("owner").trim());
			friend.setStatus(resultSet.getBoolean("status"));
			return friend;
		} catch (SQLException e) {
			return null;
		}
	}
}
