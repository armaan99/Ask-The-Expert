package dao;

import dbcon.DatabaseConnection;
import dto.Questioner_dto;
import java.sql.Connection;
import java.sql.*;
import java.util.ArrayList;
import java.util.UUID;

public class Questioner_dao {
    
    private static Connection con;
    private static PreparedStatement pst;
    private static ResultSet rs;
    
    public static boolean checkQuestionerExistance(String mailId){
    
        boolean b = false;
        
        try{
            
            con = DatabaseConnection.getConnection();
            
            pst = con.prepareStatement("select questioner_email_id from questioner where questioner_email_id = ?");
            pst.setString(1, mailId);
            
            rs = pst.executeQuery();
            
            if(rs.isBeforeFirst()){
                b = true;
            }
        
        }catch(SQLException e){
            e.printStackTrace();
        }
        
        return b;
    }
    
    public static String sendVerificationMail(String mailId){
    
        String otp = UUID.randomUUID().toString().substring(0, 5);
        
        boolean mailSent = Mail_dao.sendMail(mailId, "Mail Verification OTP", "Please enter below mentioned OTP to confirm your E-mail ID\n"+otp);
        
        if(mailSent)
            return otp;
        else
            return null;
    }
    
    public static boolean addQuestioner(Questioner_dto obj){

        boolean b = false;
        
        try{
            con = DatabaseConnection.getConnection();
            
            pst = con.prepareStatement("insert into questioner values(?,?,?,?,?,?)");
            pst.setString(1, obj.getFirstName());
            pst.setString(2, obj.getLastName());
            pst.setString(3, obj.getEmailID());
            pst.setString(4, obj.getPassword());
            pst.setInt(5, 0);
            pst.setBoolean(6, false);
            
            int x = pst.executeUpdate();
            
            if(x>0)
                b = true;
            
            con.close();
            
        }catch(SQLException e){
            e.printStackTrace();
        }
        
        return b;
    }
    
    public static boolean isBlocked(String mailId){
    
        boolean b = false;
        
        try{
        
            con = DatabaseConnection.getConnection();
            
            pst = con.prepareStatement("select block from questioner where questioner_email_id = ?");
            pst.setString(1, mailId);
            
            rs = pst.executeQuery();
            
            if(rs.isBeforeFirst()){
                rs.next();
                b = rs.getBoolean("block");
                
            }
            
        }catch(SQLException e){
            e.printStackTrace();
        }
        
        return b;
    }
    
    public static Questioner_dto checkQuestioner(String emailID, String password){
    
        Questioner_dto obj = null;
        
        try{
            con = DatabaseConnection.getConnection();
            
            pst = con.prepareStatement("select * from questioner where questioner_email_id = ? and password = ?");
            pst.setString(1, emailID);
            pst.setString(2, password);
            
            rs = pst.executeQuery();
            
            if(rs.isBeforeFirst()){
                rs.next();
                obj = new Questioner_dto();
                obj.setFirstName(rs.getString("first_name"));
                obj.setLastName(rs.getString("last_name"));
                obj.setEmailID(rs.getString("questioner_email_id"));
                obj.setPassword(rs.getString("password"));
                obj.setReportCount(rs.getInt("report_count"));
                obj.setBlock(rs.getBoolean("block"));
            }
            
            con.close();
            
        }catch(SQLException e){
            e.printStackTrace();
        }
        
        return obj;
    }
    
    public static boolean forgotPassword(String mailId){
        
        boolean b = false;
        
        try{
            
            con = DatabaseConnection.getConnection();
            
            String generatedPassword = UUID.randomUUID().toString().substring(0, 5);
            
            pst = con.prepareStatement("update questioner set password = ? where questioner_email_id = ?");
            pst.setString(1, generatedPassword);
            pst.setString(2, mailId);
            
            int x = pst.executeUpdate();
            
            if(x>0){
                boolean mailSent = Mail_dao.sendMail(mailId, "Temporary generated password", "Try logging in with this new password\n"+generatedPassword);
            
                if(mailSent && x>0)
                    b = true;
            }
            
            con.close();
        
        }catch(SQLException e){
            e.printStackTrace();
        }
        
        return b;
    }
    
    public static ArrayList<Questioner_dto> getAllQuestioner(){
    
        ArrayList<Questioner_dto> questionerList = new ArrayList<>();
        
        try{
        
            con = DatabaseConnection.getConnection();
            
            pst = con.prepareStatement("select * from questioner");
            
            rs = pst.executeQuery();
            
            if(rs.isBeforeFirst()){
                while(rs.next()){
                    Questioner_dto obj = new Questioner_dto();
                    obj.setFirstName(rs.getString("first_name"));
                    obj.setLastName(rs.getString("last_name"));
                    obj.setEmailID(rs.getString("questioner_email_id"));
                    obj.setPassword(rs.getString("password"));
                    obj.setReportCount(rs.getInt("report_count"));
                    obj.setBlock(rs.getBoolean("block"));
                    
                    questionerList.add(obj);
                }
            }
            
            con.close();
            
        }catch(SQLException e){
            e.printStackTrace();
        }
        
        return questionerList;
    }
    
    public static boolean blockQuestioner(String mailId){
        
        boolean b = false;
        
        try{
        
            con = DatabaseConnection.getConnection();
            
            pst = con.prepareStatement("update questioner set block = 1 where questioner_email_id = ?");
            pst.setString(1, mailId);
            
            int x = pst.executeUpdate();
            
            if(x>0)
                b = true;
            
        }catch(SQLException e){
            e.printStackTrace();
        }   
        return b;
    }
    
    public static boolean unblockQuestioner(String mailId){
        
        boolean b = false;
        
        try{
        
            con = DatabaseConnection.getConnection();
            
            pst = con.prepareStatement("update questioner set block = 0 where questioner_email_id = ?");
            pst.setString(1, mailId);
            
            int x = pst.executeUpdate();
            
            if(x>0)
                b = true;
            
        }catch(SQLException e){
            e.printStackTrace();
        }   
        return b;
    }
    
    public static boolean changePassword(String emailID, String oldPassword, String newPassword){
        
        boolean b = false;
        
        try{
            
            con = DatabaseConnection.getConnection();
            
            pst = con.prepareStatement("update questioner set password = ? where questioner_email_id = ? and password = ?");
            pst.setString(1, newPassword);
            pst.setString(2, emailID);
            pst.setString(3, oldPassword);
            
            int x = pst.executeUpdate();
            
            if(x>0)
                b = true;
            
            con.close();
            
        }catch(SQLException e){
            e.printStackTrace();
        }
        
        return b;
    }
    
    public static boolean deleteAccount(String emailID, String password){
        
        boolean b = false;
        
        try{
        
            con = DatabaseConnection.getConnection();
            
            pst = con.prepareStatement("delete from questioner where questioner_email_id = ? and password = ?");
            pst.setString(1, emailID);
            pst.setString(2, password);
            
            int x = pst.executeUpdate();
            
            if(x > 0){
                int y = 0;
                int quesCount = 0;
                int ansCount = 0;
                
                pst = con.prepareStatement("select * from questions where questioner_email_id = ?");
                pst.setString(1, emailID);
                rs = pst.executeQuery();
                if(rs.isBeforeFirst()){
                    pst = con.prepareStatement("delete from questions where questioner_email_id = ?");
                    pst.setString(1, emailID);

                    y = pst.executeUpdate();

                    while(rs.next()){
                        
                        int qId = rs.getInt("question_id");
                        boolean b2 = Answers_dao.deleteAnswerFromQuesId(qId);
                        
                        quesCount++ ;
                    }
                }
            
                if(y == quesCount)
                    b = true;
            }
            
            con.close();
            
        }catch(SQLException e){
            e.printStackTrace();
        }
        
        return b;
    }
}
