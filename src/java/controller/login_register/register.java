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

@WebServlet(name= "register", urlPatterns = {"/register"})
public class register extends HttpServlet {
    protected void doPost (HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        PrintWriter pw=res.getWriter();
        res.setContentType("text/html");
        
        try {
            Connection conn = null;
            conn = DatabaseConnection.getDbConnection();
            String sql = "INSERT INTO tbl_user (userId, password, email, fullname, gender, role) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement pst = conn.prepareStatement(sql);
            String username = req.getParameter("username");
            String password = req.getParameter("password");
            String email = req.getParameter("email");
            String fullname = req.getParameter("first_name") + " " + req.getParameter("last_name");
            String gender = req.getParameter("gender");
            pst.setString(1, username);
            pst.setString(2, password);
            pst.setString(3, email);
            pst.setString(4, fullname);
            pst.setString(5, gender);
            pst.setString(6, "3");
            if (pst.executeUpdate() > 0) {
                pw.println("Register successfully!");
            }
            else {
                pw.println("Register failed");
            }
            conn.close();
        }
        catch (ClassNotFoundException | SQLException e) {
            pw.println("Login error");
        }
    
        pw.close();
    }  
}