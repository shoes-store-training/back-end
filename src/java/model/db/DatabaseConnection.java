/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model.db;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author longpd
 *
 */
public class DatabaseConnection implements Serializable{
    public static Connection getDbConnection() throws ClassNotFoundException{
        Connection conn = null;
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            conn = DriverManager.getConnection("jdbc:sqlserver://localhost:1433;databaseName=snkrkorea", "shoe", "shoe");
        } catch (SQLException ex) {
            System.err.println("Cannot connect database, " + ex);
        }
        return conn;
    }
}
