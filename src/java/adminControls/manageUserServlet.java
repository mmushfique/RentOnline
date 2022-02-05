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
@WebServlet("/manageUserServlet")
public class manageUserServlet extends HttpServlet {

    Connection con;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession se = request.getSession();
        String user = (String) se.getAttribute("loggedUser");
        PrintWriter out = response.getWriter();
if(user!=null){
        try {
            DbConnection db = new DbConnection();
            con = db.getConnection();
            Statement st = con.createStatement();
            String query = "";

            ResultSet rs = st.executeQuery("SELECT * from admin WHERE username='" + user + "'");
            if (rs.next()) {

                if (!(request.getParameter("username").equals(""))) {
                    String username = request.getParameter("username");
                    query = "DELETE FROM user WHERE username='" + username + "'";
                    st.executeUpdate(query);
                }
            }
            response.sendRedirect("manageUsers.jsp");
        } catch (Exception e) {
            out.print(e);
        }
            }else{
         response.sendRedirect("error.html");
     }


    }
    
}
