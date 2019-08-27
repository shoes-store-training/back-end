/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model.bean;

/**
 *
 * @author Dell Inspiron14
 */
public class AccountTest {
    public static Account getAccount(){
        Account acc = new Account();
        acc.setUserName("admin");
        acc.setPassword("123");
        acc.setFullName("the admin");
        acc.setEmail("admin@admin");
        acc.setAddress("abc");
        acc.setPhoneNumber("132465798");
        acc.setGender(true);
        return acc;
    }
}
