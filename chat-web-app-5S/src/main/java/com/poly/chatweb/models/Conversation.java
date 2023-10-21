package com.poly.chatweb.models;

public class Conversation {
	private Long id;
	private String name;
	private String avatar;
	private String isActive;
	public Conversation() {
	}
	public Conversation(Long id, String name, String avatar) {
		super();
		this.id = id;
		this.name = name;
		this.avatar = avatar;
		
	}

//	public Conversation(Long id, String name, String avatar, String isActive) {
//		super();
//		this.id = id;
//		this.name = name;
//		this.avatar = avatar;
//		this.isActive = isActive;
//	}


	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAvatar() {
		return avatar;
	}

	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}


	public String getIsActive() {
		return isActive;
	}


	public void setIsActive(String isActive) {
		this.isActive = isActive;
	}
	
}