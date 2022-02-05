/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package advertisementServlets;

import dao.DbConnection;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
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
@WebServlet("/AdDeleteServlet")
public class AdDeleteServlet extends HttpServlet {
    Connection con;
@Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
         HttpSession se = request.getSession();
         String user= (String)se.getAttribute("loggedUser");
         if(user!=null){
        try {
           DbConnection db = new DbConnection();
            con = db.getConnection();
            Statement st = con.createStatement();
            String query = "";
            
            String id = (String) request.getParameter("id");

            query = "SELECT * from advertisement WHERE ad_id='" + id + "' AND username='" + user + "'";
            ResultSet rs = st.executeQuery(query);
            if (rs.next()) {
                query = "DELETE FROM advertisement WHERE ad_id='" + id + "'";
                st.executeUpdate(query);
            }
            response.sendRedirect("adEdit.jsp");
        } catch (Exception e) {
            PrintWriter out = response.getWriter();
            out.println(e);
        }
       }else{
         response.sendRedirect("error.html");
     } 
    }
}
