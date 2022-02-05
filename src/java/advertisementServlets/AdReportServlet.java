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
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.spi.DirStateFactory.Result;
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
@WebServlet("/AdReportServlet")
public class AdReportServlet extends HttpServlet {
Connection con;
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
     PrintWriter out = response.getWriter();
     HttpSession session = request.getSession();
     String user = (String) session.getAttribute("loggedUser");  
     if(user!=null){
         DbConnection db = new DbConnection();
            con = db.getConnection();
        String ad_id=request.getParameter("r_id");
        String detail=request.getParameter("detail");
      try {   

        Statement ps=con.createStatement();
        String query = "";
        query="SELECT id FROM report WHERE ad_id='"+ad_id+"' AND username='"+user+"'";
        ResultSet rs=ps.executeQuery(query); 
        if(rs.next()){
            session.setAttribute("reported", "er");
            response.sendRedirect("adView.jsp?id="+ad_id);
        }
        else{
        query="INSERT INTO report(ad_id,username,detail) values('"+ad_id+"','"+user+"','"+detail+"')";
        ps.executeUpdate(query);
        response.sendRedirect("adView.jsp?id="+ad_id);
        }
    } catch (Exception ex) {
       out.print(ex);
    }
     }else{
         response.sendRedirect("error.html");
     }
     
}
}
