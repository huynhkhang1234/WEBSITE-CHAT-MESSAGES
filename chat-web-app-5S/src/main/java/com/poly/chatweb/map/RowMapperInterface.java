package com.poly.chatweb.map;

import java.sql.ResultSet;

public interface RowMapperInterface<T> {
	T mapRow(ResultSet rs);
}
