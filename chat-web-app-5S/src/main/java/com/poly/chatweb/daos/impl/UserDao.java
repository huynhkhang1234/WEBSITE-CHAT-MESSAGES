package com.poly.chatweb.daos.impl;

import java.util.List;
import java.util.stream.Collectors;

import com.poly.chatweb.dao.UserDaoInterface;
import com.poly.chatweb.map.impl.ConversationMapper;
import com.poly.chatweb.map.impl.UserMapper;
import com.poly.chatweb.models.Conversation;
import com.poly.chatweb.models.User;

public class UserDao extends GenericDao<User> implements UserDaoInterface {

	private static UserDao instance = null;

	private UserDao() {

	}

	public synchronized static UserDao getInstace() {
		if (instance == null) {
			instance = new UserDao();
		}
		return instance;
	}

	@Override
	public User findByUserNameAndPassword(String userName, String password) {
		StringBuilder sql = new StringBuilder("select username, gender, avatar, is_admin, is_active");
		sql.append(" from users where username=? and password=?");
		List<User> users = query(sql.toString(), new UserMapper(), userName, password);
		return users.isEmpty() ? null : users.get(0);
	}

	@Override
	public List<User> findFriends(String userName) {
		StringBuilder sql = new StringBuilder("select  *");
		sql.append(" from users u");
		sql.append(" where u.username LIKE ?");
		String param = "%" + userName + "%";
		List<User> users = query(sql.toString(), new UserMapper(), param);
		return users.stream().filter(u -> !u.getUsername().equals(userName)).collect(Collectors.toList());
	}

	@Override
	public void saveUser(Boolean isRegister, User user) {
		System.out.println("chạy vô đăng kí");
		String username = user.getUsername();
		String password = user.getPassword();
		Boolean gender = user.isGender();
		Boolean isAdmin = user.isAdmin();
		String avatar = user.getAvatar();
		if (avatar==null) {
			StringBuilder sql = new StringBuilder("insert into users values(?,?,?,?,?,?)");
			System.out.println("55");
			save(sql.toString(), username, password, gender,"", false, true);
		} else {
			StringBuilder sql = new StringBuilder("insert into users values(?,?,?,?,?,?)");
			if (isRegister) {
				save(sql.toString(), username, password, gender, avatar, isAdmin, true);
			} else {
				sql = new StringBuilder("update users set password=?, gender=?, avatar=? where username=?");
				save(sql.toString(), password, gender, avatar, username);
			}
		}
	}

	@Override
	public List<User> findFriendsByKeyWord(String userName, String keyWord) {
		StringBuilder sql = new StringBuilder("select u2.username, u2.avatar, u2.gender");
		sql.append(" from users u2 where username != ? and username like ?");
		String param = "%" + keyWord + "%";
		List<User> users = query(sql.toString(), new UserMapper(), userName, param);
		return users;
	}

	@Override
	public List<User> findUsersByConversationId(Long id) {
		StringBuilder sql = new StringBuilder();
		sql.append("select u.username, u.avatar, u.gender, cu.is_admin");
		sql.append(" from users u join conversations_users cu");
		sql.append(" on u.username = cu.username");
		sql.append(" join conversations c");
		sql.append(" on c.id = cu.conversations_id");
		sql.append(" where c.id = ?");
		List<User> users = query(sql.toString(), new UserMapper(), id);
		return users;
	}

	@Override
	public List<User> findFriendsNotInConversation(String userName, String keyword, Long conversationId) {
		StringBuilder sql = new StringBuilder();
		sql.append("select u1.username,u1.avatar,u1.gender");
		sql.append(" from users u1");
		sql.append(" where u1.username like ?");
		sql.append(" and u1.username not in (");
		sql.append(" select u.username");
		sql.append(" from users u join conversations_users cu");
		sql.append(" on u.username = cu.username");
		sql.append(" join conversations c");
		sql.append(" on c.id = cu.conversations_id");
		sql.append(" where c.id = ?)");
		String param = "%" + keyword + "%";
		List<User> users = query(sql.toString(), new UserMapper(), param, conversationId);
		return users;
	}

	@Override
	public User findByUsername(String username) {
		StringBuilder sql = new StringBuilder("select username, gender, avatar");
		sql.append(" from users where username=?");
		List<User> users = query(sql.toString(), new UserMapper(), username);
		return users.isEmpty() ? null : users.get(0);
	}

	@Override
	public void updatePassword(String username, String newPassword) {
		// TODO Auto-generated method stub
		StringBuilder sql = new StringBuilder("UPDATE users SET password = ? WHERE username = ?");
		save(sql.toString(), newPassword, username);

	}

	@Override
	public List<User> findAllUser() {
		StringBuilder sql = new StringBuilder("select * from Users ORDER BY username ASC");
		List<User> users = query(sql.toString(), new UserMapper());
		return users;
	}

	@Override
	public User findUserByUsername(String username) {
		StringBuilder sql = new StringBuilder("select *");
		sql.append(" from users where username=?");
		List<User> users = query(sql.toString(), new UserMapper(), username);
		return users.isEmpty() ? null : users.get(0);
	}

	@Override
	public void changeActive(String username, boolean status) {
		StringBuilder sql = new StringBuilder("update users set is_active = ? where username = ?");
		save(sql.toString(), status, username);
	}

	@Override
	public void userBlock(String sql) {

		StringBuilder sql2 = new StringBuilder(sql);
		save(sql2.toString());
	}

}
