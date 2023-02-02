package com.myschool.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
 
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.myschool.VO.KakaoVO;
 
@Service("KakaoAPI")
public class KakaoAPI {

    public KakaoVO getAccessToken (String authorize_code) {
        String access_Token = "";
        String refresh_Token = "";
        String reqURL = "https://kauth.kakao.com/oauth/token";
        KakaoVO kakao = new KakaoVO();
        
        try {
            URL url = new URL(reqURL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            
            //    POST 요청을 위해 기본값이 false인 setDoOutput을 true로
            conn.setRequestMethod("POST");
            conn.setDoOutput(true);
            
            //    POST 요청에 필요로 요구하는 파라미터 스트림을 통해 전송
            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
            StringBuilder sb = new StringBuilder();
            sb.append("grant_type=authorization_code");
            sb.append("&client_id=");
            sb.append("&redirect_uri=");
            sb.append("&code=" + authorize_code);
            bw.write(sb.toString());
            bw.flush();
            
            //    결과 코드가 200이라면 성공
            int responseCode = conn.getResponseCode();
            System.out.println("responseCode : " + responseCode);
 
            //    요청을 통해 얻은 JSON타입의 Response 메세지 읽어오기
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String line = "";
            String result = "";
            
            while ((line = br.readLine()) != null) {
                result += line;
            }
            System.out.println("response body : " + result);
            
            //    Gson 라이브러리에 포함된 클래스로 JSON파싱 객체 생성
            JsonParser parser = new JsonParser();
            JsonElement element = parser.parse(result);
            
            access_Token = element.getAsJsonObject().get("access_token").getAsString();
            refresh_Token = element.getAsJsonObject().get("refresh_token").getAsString();
           
            
            kakao.setAccess_token(access_Token);
            kakao.setRefresh_token(refresh_Token);
            
            System.out.println("access_token : " + access_Token);
            System.out.println("refresh_token : " + refresh_Token);
            
            br.close();
            bw.close();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } 
        
        return kakao;
    }
    
    public KakaoVO refreshToken (String refresh) {

        String reqURL = "https://kauth.kakao.com/oauth/token";
        KakaoVO kakao = new KakaoVO();
        
        try {
            URL url = new URL(reqURL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            
            //    POST 요청을 위해 기본값이 false인 setDoOutput을 true로
            conn.setRequestMethod("POST");
            conn.setDoOutput(true);
            
            //    POST 요청에 필요로 요구하는 파라미터 스트림을 통해 전송
            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
            StringBuilder sb = new StringBuilder();
            sb.append("grant_type=refresh_token");
            sb.append("&client_id=");
            sb.append("&refresh_token="+refresh);
    
            bw.write(sb.toString());
            bw.flush();
           
            //    결과 코드가 200이라면 성공
            int responseCode = conn.getResponseCode();
            System.out.println("responseCode : " + responseCode);
 
            //    요청을 통해 얻은 JSON타입의 Response 메세지 읽어오기
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String line = "";
            String result = "";
            
            while ((line = br.readLine()) != null) {
                result += line;
            }
            System.out.println("response body : " + result);
          
            //    Gson 라이브러리에 포함된 클래스로 JSON파싱 객체 생성
            JsonParser parser = new JsonParser();
            JsonElement element = parser.parse(result);
            
            String access_Token = element.getAsJsonObject().get("access_token").getAsString();
           
            
            kakao.setAccess_token(access_Token);
            
            System.out.println("access_token : " + access_Token);
            br.close();
            bw.close();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } 
        return kakao;
 
    }
    
    public HashMap<String, String> getUserInfo (String access_Token) {
        
        //    요청하는 클라이언트마다 가진 정보가 다를 수 있기에 HashMap타입으로 선언
        HashMap<String, String> userInfo = new HashMap<>();
        String reqURL = "https://kapi.kakao.com/v2/user/me";
        try {
            URL url = new URL(reqURL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            
            //    요청에 필요한 Header에 포함될 내용
            conn.setRequestProperty("Authorization", "Bearer " + access_Token);
            
            int responseCode = conn.getResponseCode();
            System.out.println("responseCode : " + responseCode);
            
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            
            String line = "";
            String result = "";
            
            while ((line = br.readLine()) != null) {
                result += line;
            }
            System.out.println("response body : " + result);
            
            JsonParser parser = new JsonParser();
            JsonElement element = parser.parse(result);
            
            JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
            String id =  element.getAsJsonObject().get("id").getAsString();
            
            String nickname = properties.getAsJsonObject().get("nickname").getAsString();
  
            userInfo.put("nickname", nickname);
            userInfo.put("id", id);
            
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        
        return userInfo;
    }
    
    public void kakaoLogout(String access_Token) {
        String reqURL = "https://kapi.kakao.com/v1/user/logout";
        try {
            URL url = new URL(reqURL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Authorization", "Bearer " + access_Token);
            
            int responseCode = conn.getResponseCode();
            System.out.println("responseCode : " + responseCode);
            
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            
            String result = "";
            String line = "";
            
            while ((line = br.readLine()) != null) {
                result += line;
            }
            System.out.println(result);
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }
    
    
   public void getfriend (String access_Token) {
        
        //    요청하는 클라이언트마다 가진 정보가 다를 수 있기에 HashMap타입으로 선언
        String reqURL = "https://kapi.kakao.com/v1/api/talk/friends";
        try {
            URL url = new URL(reqURL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            
            //    요청에 필요한 Header에 포함될 내용
            conn.setRequestProperty("Authorization", "Bearer " + access_Token);
  
            int responseCode = conn.getResponseCode();
            System.out.println("responseCode : " + responseCode);
            
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            
            String line = "";
            String result = "";
            
            while ((line = br.readLine()) != null) {
                result += line;
            }
            System.out.println("response body : " + result);
        
            
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

    }
   
   public void sendmsg (String access_Token,  String name, String date, String uuid, String attend) {
       
       //    요청하는 클라이언트마다 가진 정보가 다를 수 있기에 HashMap타입으로 선언
       String reqURL = "https://kapi.kakao.com/v1/api/talk/friends/message/default/send";
       try {
           URL url = new URL(reqURL);
           HttpURLConnection conn = (HttpURLConnection) url.openConnection();
           conn.setRequestMethod("POST");
           conn.setDoOutput(true);
           //    요청에 필요한 Header에 포함될 내용
           conn.setRequestProperty("Authorization", "Bearer " + access_Token);
           
           
           //    POST 요청에 필요로 요구하는 파라미터 스트림을 통해 전송
           BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
           StringBuilder sb = new StringBuilder();
           
           JsonObject json = new JsonObject();
           
           String textmsg = "[동양미래대학교 컴퓨터공학부] 근로장학생 " + name + "님이 " + date + "에 " + attend + "하셨습니다";
           String receiver = "receiver_uuids=[\"" + uuid + "\"]";
           json.addProperty("object_type", "text");
           json.addProperty("text",textmsg);
           
           JsonObject link = new JsonObject();
           link.addProperty("web_url", "https://www.naver.com");
           link.addProperty("mobile_web_url", "https://www.naver.com");
           
           json.add("link", link.getAsJsonObject());
           sb.append(receiver);
           sb.append("&template_object=" + json);
         
           bw.write(sb.toString());
           System.out.println(sb.toString());
           bw.flush();
 
           int responseCode = conn.getResponseCode();
           System.out.println("responseCode : " + responseCode);
           
           BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
           
           String line = "";
           String result = "";
           
           while ((line = br.readLine()) != null) {
               result += line;
           }
           System.out.println("response body : " + result);
       
           
       } catch (IOException e) {
           // TODO Auto-generated catch block
           e.printStackTrace();
       }

   }
   
   public void sendmsgattended (String access_Token,  String name, String date, String uuid, String attend, String time) {
       
       //    요청하는 클라이언트마다 가진 정보가 다를 수 있기에 HashMap타입으로 선언
       String reqURL = "https://kapi.kakao.com/v1/api/talk/friends/message/default/send";
       try {
           URL url = new URL(reqURL);
           HttpURLConnection conn = (HttpURLConnection) url.openConnection();
           conn.setRequestMethod("POST");
           conn.setDoOutput(true);
           //    요청에 필요한 Header에 포함될 내용
           conn.setRequestProperty("Authorization", "Bearer " + access_Token);
           
           
           //    POST 요청에 필요로 요구하는 파라미터 스트림을 통해 전송
           BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
           StringBuilder sb = new StringBuilder();
           
           JsonObject json = new JsonObject();
           int t = Integer.parseInt(time);
           
           String hour = String.valueOf((int) Math.floor(t / 60));
           String minute = String.valueOf(t % 60); 
           String textmsg = "[동양미래대학교 컴퓨터공학부] 근로장학생 " + name + "님이 " + date + "에 " + attend + "하셨습니다." + " 금일 " + hour + "시간 "
        		   + minute + "분 일하셨습니다.(점심시간이 포함되었을 수 있습니다)";
           String receiver = "receiver_uuids=[\"" + uuid + "\"]";
           json.addProperty("object_type", "text");
           json.addProperty("text",textmsg);
           
           JsonObject link = new JsonObject();
           link.addProperty("web_url", "https://www.naver.com");
           link.addProperty("mobile_web_url", "https://www.naver.com");
           
           json.add("link", link.getAsJsonObject());
           sb.append(receiver);
           sb.append("&template_object=" + json);
         
           bw.write(sb.toString());
           System.out.println(sb.toString());
           bw.flush();
 
           int responseCode = conn.getResponseCode();
           System.out.println("responseCode : " + responseCode);
           
           BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
           
           String line = "";
           String result = "";
           
           while ((line = br.readLine()) != null) {
               result += line;
           }
           System.out.println("response body : " + result);
       
           
       } catch (IOException e) {
           // TODO Auto-generated catch block
           e.printStackTrace();
       }

   }

}
