/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model.dao;

import java.sql.Connection;
import model.db.DatabaseConnection;

/**
 *
 * @author longpd
 */
public class Dao {
    private Connection conn;
    public boolean checkConnect(){
        boolean check = false;
        try {
            conn = DatabaseConnection.getDbConnection();
            if(conn != null){
                check = true;
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return check;
    }
}
