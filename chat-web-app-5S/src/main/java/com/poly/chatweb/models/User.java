package com.poly.chatweb.models;

public class User {
	private String username;
	private String password;
	private boolean gender;
	private String avatar;
	private boolean isOnline;
	private boolean isAdmin;
	private boolean is_active;
	public User() {

	}

	public User(String username, String password, boolean gender, String avatar) {
		this.username = username;
		this.password = password;
		this.gender = gender;
		this.avatar = avatar;
	}
	

	public User(String username, String password, boolean gender, String avatar, boolean isAdmin, boolean is_active) {
		super();
		this.username = username;
		this.password = password;
		this.gender = gender;
		this.avatar = avatar;
		this.isAdmin = isAdmin;
		this.is_active = is_active;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public boolean isGender() {
		return gender;
	}

	public void setGender(boolean gender) {
		this.gender = gender;
	}

	public String getAvatar() {
		return avatar;
	}

	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public boolean isAdmin() {
		return isAdmin;
	}

	public void setAdmin(boolean isAdmin) {
		this.isAdmin = isAdmin;
	}

	public boolean isOnline() {
		return isOnline;
	}

	public void setOnline(boolean isOnline) {
		this.isOnline = isOnline;
	}

	public boolean getIs_active() {
		return is_active;
	}

	public void setIs_active(boolean is_active) {
		this.is_active = is_active;
	}
	
	

}
