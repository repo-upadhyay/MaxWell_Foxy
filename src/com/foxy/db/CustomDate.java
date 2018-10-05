package com.foxy.db;

import java.text.SimpleDateFormat;
import java.util.Date;

public class CustomDate extends Date {

	private final String pattern = "YYYY-MM-DD HH:MM:SS";
	private final SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);

	@Override
	public String toString() {
		return simpleDateFormat.format(this);
	}

}
