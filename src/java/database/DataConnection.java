/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


/**
 *
 * @longpd HP
 */
public class DataConnection {
   public static void main(String[] args) {
        try {
            String dbURL = "jdbc:sqlserver://localhost:1433;databaseName=snkrkorea;user=sa;password=sa";
            Connection conn = DriverManager.getConnection(dbURL);
            if (conn != null) {
                System.out.println("Connected");
            }
        } catch (SQLException ex) {
            System.err.println("Cannot connect database, " + ex);
        }
   }
}
