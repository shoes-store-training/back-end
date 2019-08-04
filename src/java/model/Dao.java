/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.sql.Connection;

/**
 *
 * @author Dell Inspiron14
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
        } catch (Exception e) {
            e.printStackTrace();
        }
        return check;
    }
}
