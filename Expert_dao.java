package dao;

import dbcon.DatabaseConnection;
import dto.Expert_dto;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.UUID;

public class Expert_dao {
    
    private static Connection con;
    private static PreparedStatement pst;
    private static ResultSet rs;
    
    public static boolean checkExpertExistance(String mailId){
    
        boolean b = false;
        
        try{
            
            con = DatabaseConnection.getConnection();
            
            pst = con.prepareStatement("select expert_email_id from expert where expert_email_id = ?");
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
    
    public static boolean addExpert(Expert_dto obj){
        
        boolean b = false;
        
        try{
            
            con = DatabaseConnection.getConnection();
            
            pst = con.prepareStatement("insert into expert values(?,?,?,?,?,?,?)");
            pst.setString(1, obj.getFirstName());
            pst.setString(2, obj.getLastName());
            pst.setString(3, obj.getEmailID());
            pst.setString(4, obj.getPassword());
            pst.setString(5, obj.getCategory());
            pst.setInt(6, 0);
            pst.setBoolean(7, false);
            
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
            
            pst = con.prepareStatement("select block from expert where expert_email_id = ?");
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
    
    public static Expert_dto checkExpert(String emailID, String password){
    
        Expert_dto obj = null;
        
        try{
            con = DatabaseConnection.getConnection();
            
            pst = con.prepareStatement("select * from expert where expert_email_id = ? and password = ?");
            pst.setString(1, emailID);
            pst.setString(2, password);
            
            rs = pst.executeQuery();
            
            if(rs.isBeforeFirst()){
                rs.next();
                obj = new Expert_dto();
                obj.setFirstName(rs.getString("first_name"));
                obj.setLastName(rs.getString("last_name"));
                obj.setEmailID(rs.getString("expert_email_id"));
                obj.setPassword(rs.getString("password"));
                obj.setCategory(rs.getString("category"));
                obj.setReportCount(rs.getInt("report_count"));
                obj.setBlock(rs.getBoolean("block"));
            }
            
            con.close();
            
        }catch(SQLException e){
            e.printStackTrace();
        }
        
        return obj;
    }
    
    public static boolean incrementReport(String expertMailID){
        
        boolean b = false;
        int report = -1;
        
        try{
            
            con = DatabaseConnection.getConnection();
            
            pst = con.prepareStatement("select report_count from expert where expert_email_id = ?");
            pst.setString(1, expertMailID);
            
            rs = pst.executeQuery();
            
            if(rs.isBeforeFirst()){
                rs.next();
                report = rs.getInt("report_count");
            }
            
            if(report != -1){
                pst = con.prepareStatement("update expert set report_count = ? where expert_email_id = ?");
                pst.setInt(1, report+1);
                pst.setString(2, expertMailID);

                int x = pst.executeUpdate();

                if(x>0)
                    b = true;
            }
            
            con.close();
        
        }catch(SQLException e){
            e.printStackTrace();
        }
        
        return b;
    }
    
    public static boolean forgotPassword(String mailId){
        
        boolean b = false;
        
        try{
            
            con = DatabaseConnection.getConnection();
            
            String generatedPassword = UUID.randomUUID().toString().substring(0, 5);
            
            pst = con.prepareStatement("update expert set password = ? where expert_email_id = ?");
            pst.setString(1, generatedPassword);
            pst.setString(2, mailId);
            
            int x = pst.executeUpdate();
            
            if(x>0){
                boolean mailSent = Mail_dao.sendMail(mailId, "Temporary generated password", "Try logging in with this new password\n"+generatedPassword);
            
                if(mailSent)
                    b = true;
            }
            con.close();
        
        }catch(SQLException e){
            e.printStackTrace();
        }
        
        return b;
    }
    
    public static boolean changePassword(String emailID, String oldPassword, String newPassword){
        
        boolean b = false;
        
        try{
            
            con = DatabaseConnection.getConnection();
            
            pst = con.prepareStatement("update expert set password = ? where expert_email_id = ? and password = ?");
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
            
            pst = con.prepareStatement("delete from expert where expert_email_id = ? and password = ?");
            pst.setString(1, emailID);
            pst.setString(2, password);
            
            int x = pst.executeUpdate();
            
            if(x > 0){
                int y = 0;
                int count = 0;

                pst = con.prepareStatement("select * from answers where expert_email_id = ?");
                pst.setString(1, emailID);
                rs = pst.executeQuery();
                if(rs.isBeforeFirst()){
                    pst = con.prepareStatement("delete from answers where expert_email_id = ?");
                    pst.setString(1, emailID);

                    y = pst.executeUpdate();

                    while(rs.next()){
                        count++ ;
                    }
                }
            
                if(y == count)
                    b = true;
            }
            
            con.close();
            
        }catch(SQLException e){
            e.printStackTrace();
        }
        
        return b;
    }
    
    public static ArrayList<Expert_dto> getAllExpert(){
        
        ArrayList<Expert_dto> expertList = new ArrayList<>();
        
        try{
        
            con = DatabaseConnection.getConnection();
            
            pst = con.prepareStatement("select * from expert");
            
            rs = pst.executeQuery();
            
            if(rs.isBeforeFirst()){
                while(rs.next()){
                    Expert_dto obj = new Expert_dto();
                    obj.setFirstName(rs.getString("first_name"));
                    obj.setLastName(rs.getString("last_name"));
                    obj.setEmailID(rs.getString("expert_email_id"));
                    obj.setPassword(rs.getString("password"));
                    obj.setCategory(rs.getString("category"));
                    obj.setReportCount(rs.getInt("report_count"));
                    obj.setBlock(rs.getBoolean("block"));
                    
                    expertList.add(obj);
                }
            }
            
            con.close();
            
        }catch(SQLException e){
            e.printStackTrace();
        }
        
        return expertList;
    }
    
    public static boolean blockExpert(String mailId){
        
        boolean b = false;
        
        try{
        
            con = DatabaseConnection.getConnection();
            
            pst = con.prepareStatement("update expert set block = 1 where expert_email_id = ?");
            pst.setString(1, mailId);
            
            int x = pst.executeUpdate();
            
            if(x>0)
                b = true;
            
        }catch(SQLException e){
            e.printStackTrace();
        }   
        return b;
    }
    
    public static boolean unblockExpert(String mailId){
        
        boolean b = false;
        
        try{
        
            con = DatabaseConnection.getConnection();
            
            pst = con.prepareStatement("update expert set block = 0 where expert_email_id = ?");
            pst.setString(1, mailId);
            
            int x = pst.executeUpdate();
            
            if(x>0)
                b = true;
            
        }catch(SQLException e){
            e.printStackTrace();
        }   
        return b;
    }
}