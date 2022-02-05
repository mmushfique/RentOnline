/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package userServlets;

import dao.DbConnection;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author user
 */
@WebServlet("/SignupServlet")
public class SignupServlet extends HttpServlet {

    Connection con;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String fName = request.getParameter("fname");
        String lName = request.getParameter("lname");
        String email = request.getParameter("email");
        String phoneNo = request.getParameter("phoneNo");
        String password = request.getParameter("password");

        DbConnection db = new DbConnection();
        con = db.getConnection();

        try {
            String query = "SELECT username FROM user WHERE username='" + username + "'";
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery(query);
            if (rs.next()) {
                PrintWriter out = response.getWriter();
                out.print("username");
            } else {
                query = "SELECT email FROM user WHERE email='" + email + "'";
                st = con.createStatement();
                rs = st.executeQuery(query);
                if (rs.next()) {
                    PrintWriter out = response.getWriter();
                    out.print("email");
                } else {
                        query = "SELECT phone_no FROM user WHERE phone_no='" + phoneNo + "'";
                st = con.createStatement();
                rs = st.executeQuery(query);
                if (rs.next()) {
                    PrintWriter out = response.getWriter();
                    out.print("phone");
                } else {
                    //Insert register data to database
                    query = "INSERT INTO user VALUES(?,?,?,?,?,?)";

                    PreparedStatement pt = this.con.prepareStatement(query);
                    pt.setString(1, username);
                    pt.setString(2, fName);
                    pt.setString(3, lName);
                    pt.setString(4, email);
                    pt.setString(5, phoneNo);
                    pt.setString(6, password);
                    pt.executeUpdate();
                    HttpSession session = request.getSession();
                    session.setAttribute("loggedUser",username);
                    session.setAttribute("role","USER");
                }
            }
            }
        } catch (Exception e) {
            PrintWriter out = response.getWriter();
            out.println(e);
        }
    }
}
