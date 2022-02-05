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
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.simple.JSONObject;
/**
 *
 * @author user
 */
@WebServlet("/AdEditServlet")
public class AdEditServlet extends HttpServlet {
    Connection con;
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        String adId = request.getParameter("ad_id");
        String type = "";
        
        switch (adId.charAt(0)) {
            case 'H':
                type = "house_ad";
                break;
            case 'R':
                type = "room_ad";
                break;
            default:
                type = "shop_ad";
                break;
        }
        try {
            DbConnection db = new DbConnection();
            con = db.getConnection();
            String query = "SELECT * FROM advertisement JOIN " + type + " ON advertisement.ad_id=" + type + ".ad_id WHERE advertisement.ad_id=?";
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, adId);
            ResultSet rs = pst.executeQuery();

            JSONObject ob = new JSONObject();
            rs.next();
            ob.put("title", rs.getString("title"));
            ob.put("location", rs.getString("location"));
            ob.put("description", rs.getString("description"));
            ob.put("property_area", rs.getString("property_area"));
            ob.put("rent", rs.getString("rent"));
            if (type.equals("house_ad")) {
                ob.put("rooms", rs.getString("rooms"));
                ob.put("furnished_status", rs.getString("furnished_status"));
            } else if (type.equals("room_ad")) {
                ob.put("beds", rs.getString("beds"));
                ob.put("furnished_status", rs.getString("furnished_status"));
            } else {
                ob.put("dimension", rs.getString("dimension"));
            }
            PrintWriter out = response.getWriter();
            out.print(ob);
            
        } catch (SQLException ex) {
            PrintWriter out = response.getWriter();
            out.println(ex.getMessage());
        }
    }
}
