/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model.bo;

import java.sql.SQLException;
import model.bean.Account;
import model.dao.AccessAccountDAO;

/**
 *
 * @author Dell Inspiron14
 */
public class AccessAccountBO {

    private AccessAccountDAO aad = new AccessAccountDAO();

    public Account getAccount(String username, String pass) throws SQLException, ClassNotFoundException {
        Account account = aad.getAccount(username, pass);
        if (account.getFullName() == null || account.getFullName().length() == 0) {
            account.setFullName("No fullname");
        }
        if (account.getPhoneNumber() == null || account.getPhoneNumber().length() == 0) {
            account.setPhoneNumber("No phone");
        }
        if (account.getAddress() == null || account.getAddress().length() == 0) {
            account.setAddress("No address");
        }
        if (account.getEmail() == null || account.getEmail().length() == 0) {
            account.setEmail("No email");
        }
        if (account.getGender() == null || account.getGender().length() == 0) {
            account.setGender("No gender");
        }
        return account;
    }

    public boolean saveAccount(Account acc) throws ClassNotFoundException{
        return aad.saveAccount(acc);
    }
    
    public boolean changePassWord(Account acc) throws ClassNotFoundException{
        return aad.changePassWord(acc);
    }
}
