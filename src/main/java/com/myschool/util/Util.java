package com.myschool.util;

import java.security.MessageDigest;
import java.security.SecureRandom;

public class Util {
	public static String getSALT() throws Exception {
		SecureRandom rnd = new SecureRandom();
		byte[] temp = new byte[16];
		rnd.nextBytes(temp);
		
		return Byte_to_String(temp);
	}
	
	public static String Byte_to_String(byte[] temp) {
		StringBuilder sb = new StringBuilder();
		for(byte a : temp) {
			sb.append(String.format("%02x", a));
		}
		return sb.toString();
	}
	
	public static String Hashing(byte[] password, String Salt) throws Exception {
		MessageDigest md = MessageDigest.getInstance("SHA-256"); 
 
		for(int i = 0; i < 10000; i++) {
			String temp = Byte_to_String(password) + Salt; 
			md.update(temp.getBytes()); 
			password = md.digest(); 
		}
		
		return Byte_to_String(password);
	}
	
}
