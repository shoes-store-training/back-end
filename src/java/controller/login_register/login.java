package controller.login_register;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.annotation.WebServlet;
import model.db.DatabaseConnection;

@WebServlet(name= "login", urlPatterns = {"/login"})
public class login extends HttpServlet {
    protected void doPost (HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        PrintWriter pw=res.getWriter();
        res.setContentType("text/html");
        
        try {
            Connection conn = null;
            conn = DatabaseConnection.getDbConnection();
            String sql = "SELECT * FROM tbl_user WHERE userId = ? and password = ?";
            PreparedStatement pst = conn.prepareStatement(sql);
            String username = req.getParameter("username");
            String password = req.getParameter("password");
            pst.setString(1, username);
            pst.setString(2, password);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                pw.println("Username and password match ");
            }
            else {
                pw.println("Username and password not match ");
            }
            conn.close();
        }
        catch (ClassNotFoundException | SQLException e) {
            pw.println("Login error");
        }
        pw.close();
    }  
}