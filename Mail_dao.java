package dao;

import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class Mail_dao {
    
    public static boolean sendMail(String reciever, String subject, String content){
    
        boolean b = false;
        
        String senderMailId = "#@gmail.com";
        String senderPassword = "#";
        
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.socketFactory.port", "465");
        props.put("mail.smtp.socketFactory.class","javax.net.ssl.SSLSocketFactory");
        props.put("mail.smtp.auth", "true");  
        props.put("mail.smtp.port", "465");
        
        Session session = Session.getDefaultInstance(props,
         new javax.mail.Authenticator() {
          @Override
          protected PasswordAuthentication getPasswordAuthentication() {
           return new PasswordAuthentication(senderMailId,senderPassword);
           }
        });
        
        
        try{
            
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(senderMailId));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(reciever));
            message.setSubject(subject);
            message.setContent(content, "text/html; charset=utf-8");

            Transport.send(message);
            b = true;
        
        }catch(MessagingException e){
            e.printStackTrace();
        }
        
        return b;
    }
}