package com.poly.chatweb.dto;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;

public class ConversationDTO {
	@JsonProperty("id")
	private Long id;

	@JsonProperty("name")
	private String name;

	@JsonProperty("avatar")
	private String avatar;
	
	@JsonProperty("isActive")
	private String isActive;
	
	@JsonProperty("hideGroup")
	private boolean hideGroup;
	
	@JsonProperty("users")
	private List<UserDTO> users;

	public ConversationDTO() {
	}

	@JsonCreator
	public ConversationDTO(@JsonProperty("id") Long id, @JsonProperty("name") String name,
			@JsonProperty("avatar") String avatar,@JsonProperty("isActive") String isActive,  @JsonProperty("hideGroup") boolean hideGroup,@JsonProperty("users") List<UserDTO> users) {
		this.id = id;
		this.name = name;
		this.avatar = avatar;
		this.hideGroup = hideGroup;
		this.users = users;		
		this.isActive = isActive;
	}

	public boolean isHideGroup() {
		return hideGroup;
	}

	public void setHideGroup(boolean hideGroup) {
		this.hideGroup = hideGroup;
	}

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

	public List<UserDTO> getUsers() {
		return users;
	}

	public void setUsers(List<UserDTO> users) {
		this.users = users;
	}

	public String getIsActive() {
		return isActive;
	}

	public void setIsActive(String isActive) {
		this.isActive = isActive;
	}
	

}
