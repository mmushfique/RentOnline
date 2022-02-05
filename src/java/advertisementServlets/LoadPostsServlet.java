package advertisementServlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.time.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

@WebServlet("/LoadPostsServlet")
public class LoadPostsServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
//        resp.setContentType("string");
        PrintWriter out = resp.getWriter();

        String location = req.getParameter("location");
        String category = req.getParameter("category");
        int minPrice = Integer.parseInt(req.getParameter("minPrice"));
        int maxPrice = Integer.parseInt(req.getParameter("maxPrice"));
        String sort = req.getParameter("sort");
System.out.println(category);
        //String query = "SELECT ad.title,ad.location,ad.rent,ad.published_date,ad_img.img_path,ad.ad_id FROM advertisement ad LEFT JOIN (SELECT img_path,ad_id FROM ad_img GROUP BY ad_id) ad_img ON ad_img.ad_id=ad.ad_id  WHERE status='1'";
        String query = "SELECT * FROM advertisement ad JOIN(SELECT * FROM ad_img GROUP BY ad_img.ad_id) AS img ON ad.ad_id=img.ad_id";
        if (category.equals("House")) {
            query += " JOIN house_ad h ON ad.ad_id=h.ad_id";
        } else if (category.equals("Room")) {
            query += " JOIN room_ad r ON ad.ad_id=r.ad_id";
        } else if (category.equals("Shop")) {
            query += " JOIN shop_ad s ON ad.ad_id=s.ad_id";
        }

        if (category.equals("House") || category.equals("Room")) {

            String furnished = req.getParameter("furnished");

            if (!furnished.equals("Both")) {
                query += " AND furnished_status='" + furnished + "'";
            }

            if (category.equals("House")) {

                String rooms = req.getParameter("rooms");

                if (!rooms.equals("Any")) {
                    if (rooms.contains("+")) {
                        query += " AND rooms>" + Integer.parseInt(rooms.substring(0, 1));
                    } else {
                        query += " AND rooms=" + Integer.parseInt(rooms);
                    }
                }
            } else if (category.equals("Room")) {
                String beds = req.getParameter("beds");
                if (!beds.equals("Any")) {
                    if (beds.contains("+")) {
                        query += " AND beds>" + Integer.parseInt(beds.substring(0, 1));
                    } else {
                        query += " AND beds=" + Integer.parseInt(beds);
                    }
                }
            }
        }

        if (!location.equals("All")) {
            query = addWhereOrAnd(query);
            query += " location='" + location + "'";
        }

        if (maxPrice != 0 && minPrice != 0) {
            query = addWhereOrAnd(query);
            if (maxPrice == minPrice) {
                query += " rent=" + minPrice;

            } else {
                query += " rent BETWEEN " + minPrice + " AND " + maxPrice;
            }
        } else if (minPrice != 0) {
            query = addWhereOrAnd(query);
            query += " rent> " + minPrice;
        } else if (maxPrice != 0) {
            query = addWhereOrAnd(query);
            query += " rent< " + maxPrice;
        }
        
        query = addWhereOrAnd(query);
        query += "status=1";

        if (sort.equals("Date: Newest on top")) {
            query += " ORDER BY published_date DESC";
        } else if (sort.equals("Date: Oldest on top")) {
            query += " ORDER BY published_date ASC";
        } else if (sort.equals("Price: High to low")) {
            query += " ORDER BY rent DESC";
        } else {
            query += " ORDER BY rent ASC";
        }

        String adlimitStart = req.getParameter("adlimitStart");
        if (adlimitStart
                != null) {
            query += " LIMIT " + Integer.parseInt(adlimitStart) + "," + ((Integer.parseInt(adlimitStart)) + 10);
        } else {
            query += " LIMIT 0,10";
        }

        System.out.println(query);

        String output = "";

        JSONArray allAd = new JSONArray();
        JSONObject singleAd;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/projectdb", "root", "");
            PreparedStatement stmt = con.prepareStatement(query);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                singleAd = new JSONObject();
                singleAd.put("adId", rs.getString("ad_id"));
                singleAd.put("adTitle", rs.getString("title"));
                singleAd.put("adLoc", rs.getString("location"));
                singleAd.put("adRent", rs.getString("rent"));
                singleAd.put("adImg", rs.getString("img_path"));

                String finalGap = "";

                Timestamp pubDateTime = rs.getTimestamp("published_date");

                LocalDate pubDate = Instant.ofEpochMilli(pubDateTime.getTime()).atZone(ZoneId.systemDefault()).toLocalDate();
                LocalTime pubTime = Instant.ofEpochMilli(pubDateTime.getTime()).atZone(ZoneId.systemDefault()).toLocalTime();

                LocalDate nowDate = LocalDate.now();
                LocalTime nowTime = LocalTime.now();

                Duration gapu = Duration.between(pubTime, nowTime);
                Period gap = Period.between(pubDate, nowDate);

                if (gap.getMonths() > 0) {
                      if (gap.getMonths() == 1) {
                        finalGap = String.valueOf(gap.getMonths()) + " Month Ago";
                    } else {
                        finalGap = String.valueOf(gap.getMonths()) + " Months Ago";
                    }
                } else if (gap.getDays() > 0) {
                    if (gap.getDays() == 1) {
                        finalGap = String.valueOf(gap.getDays()) + " Day Ago";
                    } else {
                        finalGap = String.valueOf(gap.getDays()) + " Days Ago";
                    }
                } else if (gapu.toHours() > 0) {
                     if (gapu.toHours() == 1) {
                        finalGap = String.valueOf(gapu.toHours()) + " Hour Ago";
                    } else {
                        finalGap = String.valueOf(gapu.toHours()) + " Hours Ago";
                    }
                } else if (gapu.toMinutes() > 0) {
                    if (gapu.toMinutes() == 1) {
                        finalGap = String.valueOf(gapu.toMinutes()) + " Minute Ago";
                    } else {
                        finalGap = String.valueOf(gapu.toMinutes()) + " Minutes Ago";
                    }
                } else {
                    finalGap = "Just Now";
                }

                singleAd.put("adGap", finalGap);

                allAd.add(singleAd);

            }
        } catch (Exception ex) {
            out.print(ex);

        }
// out.print(query);
        out.print(allAd);
    }

    String addWhereOrAnd(String query) {
        if (query.contains("WHERE")) {
            return query += " AND ";
        } else {
            return query += " WHERE ";
        }
    }
}

//    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        try {
//            Class.forName("com.mysql.jdbc.Driver");
//            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/projectdb", "root", "");
//            PreparedStatement stmt = con.prepareStatement("select * from advertisement");
////            ResultSet rs = stmt.executeQuery();
//            int rs=5;
//            request.setAttribute("result", rs);
//            con.close();
//        } catch (Exception e) {
//        }      
//        request.getRequestDispatcher("/index.jsp").forward(request, response);
// 
//    }
