/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model.dao;

/**
 *
 * @author longpd
 *  
 */
public class Test {
    public static void main(String[] args){
        Dao d = new Dao();
        if(d.checkConnect()){
            System.out.println("Connected");
        }
    }
}
