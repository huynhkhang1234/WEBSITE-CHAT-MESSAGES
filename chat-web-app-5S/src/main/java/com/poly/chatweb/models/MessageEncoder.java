package com.poly.chatweb.models;

import javax.websocket.EncodeException;
import javax.websocket.Encoder;
import javax.websocket.EndpointConfig;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.poly.chatweb.dto.MessageDTO;

public final class MessageEncoder implements Encoder.Text<MessageDTO> {

	private static ObjectMapper objectMapper = new ObjectMapper();

	@Override
	public void destroy() {
	}

	@Override
	public void init(final EndpointConfig arg0) {
	}

	@Override
	public String encode(final MessageDTO message) throws EncodeException {
		try {
			return objectMapper.writeValueAsString(message);
		} catch (JsonProcessingException e) {
			throw new EncodeException(message, "Unable to encode message", e);
		}
	}
}
