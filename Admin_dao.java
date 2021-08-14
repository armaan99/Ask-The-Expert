package dao;

import dbcon.DatabaseConnection;
import dto.Admin_dto;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.UUID;

public class Admin_dao {
    
    private static Connection con;
    private static PreparedStatement pst;
    private static ResultSet rs;
    
    public static Admin_dto checkAdmin(String mailId, String password){
        
        Admin_dto obj = null;
        
        try{
            
            con = DatabaseConnection.getConnection();
            
            pst = con.prepareStatement("select * from admin where admin_email_id = ? and password = ?");
            pst.setString(1, mailId);
            pst.setString(2, password);
            
            rs = pst.executeQuery();
            
            if(rs.isBeforeFirst()){
                rs.next();
                obj = new Admin_dto();
                obj.setFirstName(rs.getString("first_name"));
                obj.setLastName(rs.getString("last_name"));
                obj.setEmailID(rs.getString("admin_email_id"));
                obj.setPassword(rs.getString("password"));
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
            
            pst = con.prepareStatement("update admin set password = ? where admin_email_id = ?");
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
    
    public static boolean changePassword(String mailId, String oldPassword, String newPassword){
        
        boolean b = false;
        
        try{
            
            con = DatabaseConnection.getConnection();
            
            pst= con.prepareStatement("update admin set password = ? where admin_email_id = ? and password = ?");
            pst.setString(1, newPassword);
            pst.setString(2, mailId);
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
}
