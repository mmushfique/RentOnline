/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package adminControls;

import dao.DbConnection;
import java.io.IOException;
import java.io.PrintWriter;
import static java.lang.Boolean.parseBoolean;
import java.sql.Connection;
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
@WebServlet("/manageAdsServlet")
public class manageAdsServlet extends HttpServlet {

     Connection con;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession se = request.getSession();
        String user = (String) se.getAttribute("loggedUser");
if(user!=null){
        try {
            DbConnection db = new DbConnection();
            con = db.getConnection();
            Statement st = con.createStatement();
            String query = "";

            ResultSet rs = st.executeQuery("SELECT * from admin WHERE username='" + user + "'");
            if (rs.next()) {

                if (request.getParameter("id")!=null) {
                    String ad_id = request.getParameter("id");
                    query = "DELETE FROM advertisement WHERE ad_id='" + ad_id + "'";
                    st.executeUpdate(query);
                } 
            }
            
        } catch (Exception e) {
            PrintWriter out = response.getWriter();
            out.print(e);
        }
         }else{
         response.sendRedirect("error.html");
     }

    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession se = request.getSession();
        String user = (String) se.getAttribute("loggedUser");
if(user!=null){
        try {
            DbConnection db = new DbConnection();
            con = db.getConnection();
            Statement st = con.createStatement();
            String query = "";

            ResultSet rs = st.executeQuery("SELECT * from admin WHERE username='" + user + "'");
            if (rs.next()) {
                String ad_id = request.getParameter("ad_id");
                String status = request.getParameter("status");
                if(status!=null){
                query = "UPDATE advertisement SET status='"+1+"' WHERE ad_id='" + ad_id + "'";
                }else{
                    query = "UPDATE advertisement SET status='"+0+"' WHERE ad_id='" + ad_id + "'";
                }
                st.executeUpdate(query);
            }        
        } catch (Exception e) {
            PrintWriter out = response.getWriter();
            out.print(e);
        }
        response.sendRedirect("manageAds.jsp");
        
        }else{
         response.sendRedirect("error.html");
     }
}
}
