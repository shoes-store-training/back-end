/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.bean.Account;
import model.bo.AccessAccountBO;
import model.db.DatabaseConnection;

/**
 *
 * @author longpd
 */
public class AccessAccountDAO {
    
    private String driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
    private String url = "jdbc:sqlserver://localhost:1433;databaseName=snkrkorea";
    private Statement stm = null;
    private Connection conn;
    private Account acc;

    public Account getAccount(String username, String pass) throws SQLException, ClassNotFoundException {
        try{
            conn =  DatabaseConnection.getDbConnection();
            try (PreparedStatement pstm = conn.prepareStatement("SELECT * FROM tbl_user WHERE userId = ? and password = ?")) {
                ResultSet rs;
                pstm.setString(1, username);
                pstm.setString(2, pass);
                rs = pstm.executeQuery();
                if (rs.next()) {
                    acc = new Account();
                    acc.setUserName(rs.getString(1));
                    acc.setFullName(rs.getString("fullname"));
                    acc.setEmail(rs.getString("email"));
                    acc.setAddress(rs.getString("address"));
                    acc.setPhoneNumber(rs.getString("phone"));
                    acc.setGender(rs.getString("gender"));
                    acc.setPassword(rs.getString(2));
                }
                rs.close();
            }
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return acc;
    }
    public boolean saveAccount(Account acc) throws ClassNotFoundException{
        try {
            conn =  DatabaseConnection.getDbConnection();
            PreparedStatement pstm = conn.prepareStatement("UPDATE tbl_user SET email = ?, fullname = ?, address = ?, gender = ?, phone = ? WHERE userId = ? and password = ?");
            pstm.setString(1, acc.getEmail());
            pstm.setString(2, acc.getFullName());
            pstm.setString(3, acc.getAddress());
            pstm.setString(4, acc.getGender());
            pstm.setString(5, acc.getPhoneNumber());
            pstm.setString(6, acc.getUserName());
            pstm.setString(7, acc.getPassword());
            pstm.executeUpdate();
            return true;
        }catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    public boolean changePassWord(Account acc) throws ClassNotFoundException{
        try{
            conn = DatabaseConnection.getDbConnection();
            PreparedStatement pstm = conn.prepareStatement("UPDATE tbl_user SET password = ? WHERE userId = ?");
            pstm.setString(1, acc.getPassword());
            pstm.setString(2, acc.getUserName());
            pstm.executeUpdate();
            return true;
        }
        catch(SQLException e){
            e.printStackTrace();
        }
        return false;
    }
}
