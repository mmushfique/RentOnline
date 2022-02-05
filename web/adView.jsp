<%response.setHeader("Cache-Control", "private, no-store, no-cache, must-revalidate");%>
<%@page import="java.time.temporal.ChronoUnit"%>
<%@page import="java.time.LocalTime"%>
<%@page import="dao.DbConnection"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Advertisment Info</title>
        <link rel="stylesheet" href="css/adView.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css">
        <!--<link rel="stylesheet" href="bootstrap icons/bootstrap-icons.css">-->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.6.1/font/bootstrap-icons.css">
    </head>

    <body >
        <header id="header">
            <jsp:include page="header.jsp" />  
        </header>


        <header id="header">
        </header>
        <div class="row container-fluid mx-auto align-items-center">
            <div id="adImgSlide" class="carousel slide bg-dark border rounded-lg col-12 col-md-8 my-2" data-ride="carousel"
                 data-interval="false">
                <div class="carousel-inner">
                    <%
                        Connection con;
                        DbConnection db = new DbConnection();
                        con = db.getConnection();
                        int count = 0;
                        String id = request.getParameter("id");
                        String query = "SELECT img_path FROM ad_img WHERE ad_id=?";

                        try {
                            PreparedStatement pst = con.prepareStatement(query);
                            pst.setString(1, id);
                            ResultSet rs = pst.executeQuery();
                            while (rs.next()) {
                                count++;

                    %>
                    <img class="carousel-item" src='<%= rs.getString("img_path")%>'>

                    <%
                            }
                        } catch (Exception e) {
                            out.println(e.getMessage());
                        }
                    %>
                </div>
                <%
                    if (count > 1) {


                %>
                <a class="carousel-control-prev" href="#adImgSlide" data-slide="prev">
                    <span class="carousel-control-prev-icon"></span>
                </a>
                <a class="carousel-control-next" href="#adImgSlide" data-slide="next">
                    <span class="carousel-control-next-icon"></span>
                </a>
                <%                }
                %>
                <ul class="carousel-indicators">
                    <%
                        while (count > 0) {
                            int i = 0;

                    %>
                    <li data-target="#adImgSlide" data-slide-to='<%= i%>' class="active"></li>

                    <%
                            i++;
                            count--;
                        }
                    %>
                </ul>
            </div>
            <script type="text/javascript">
                document.getElementsByClassName('carousel-item')[0].classList.add('active');
                document.getElementsByClassName('carousel-indicators')[0].getElementsByTagName('li')[0].classList.add('active');

            </script>

            <div class="box col-12 col-md-4">
                <div class="adFullDet border bg-light p-3 my-2" >
                    <%
                        String type = "";
                        if (id.charAt(0) == 'H') {
                            type = "house_ad";
                        } else if (id.charAt(0) == 'R') {
                            type = "room_ad";
                        } else {
                            type = "shop_ad";
                        }

                        String loc = "";
                        query = "SELECT published_date,title,location,description,property_area,rent,us.f_name,us.l_name,us.phone_no,t.* FROM advertisement ad JOIN user us ON ad.username=us.username JOIN " + type + " t ON ad.ad_id=t.ad_id WHERE ad.ad_id=?";
                        try {
                            PreparedStatement pst = con.prepareStatement(query);
                            pst.setString(1, id);
                            ResultSet rs = pst.executeQuery();
                            if (rs.next()) {
                                loc = rs.getString("location");
                    %>
                    <div class="text-capitalize h3 font-weight-bold">Posted By: </br><%= rs.getString("f_name") + " " + rs.getString("l_name")%></div>
                    <div class="title text-capitalize font-weight-bold h4"><%= rs.getString("title")%></div>
                    <div class="postedOn h5 ">Published on : <%= rs.getDate("published_date")%> <%= rs.getTime("published_date")%></div>
                    <div class="location border-bottom h4"><%= rs.getString("location")%></div>
                    <div class="price font-weight-bold h4">Rent: <%= rs.getString("rent")%></div>
                    <%
                        if (type == "house_ad") {
                    %>
                    <div class="type h5">Furnished Status:<%=  rs.getString("furnished_status")%></div>
                    <div class="type h5">Number of Rooms:<%=  rs.getString("rooms")%></div>
                    <%
                    } else if (type == "room_ad") {
                    %>
                    <div class="type h5">Furnished Status:<%=  rs.getString("furnished_status")%></div>
                    <div class="type h5">Number of Beds:<%=  rs.getString("beds")%></div>
                    <%
                    } else {
                    %>
                    <div class="type h5">Dimension:<%=  rs.getString("dimension")%></div>
                    <%
                        }
                    %>
                    <div class="contactPhone h5">Phone No:<%= rs.getString("phone_no")%></div>
                    <div class="h4 font-weight-bold">Description
                        <div class="h5 discription border p-2 rounded"><%= rs.getString("description")%>
                        </div>
                    </div>
                    <%
                            }
                        } catch (Exception e) {
                            out.println(e.getMessage());

                        }
                    %>
                    <br><br>
                </div><div><a class="text-white" href="adReport.jsp?id=<%=id%>">Report this ad</a></div>
            </div>

            <!--<div class="chat" role="button"><span class="bi bi-chat-square-text m-1"></span>Chat</div>-->
<h2>Similar ads</h2>
            <div class="box border p-3 my-2 mx-auto bg-light row container-fluid mt-3">
                
                <%
                    query = "SELECT advertisement.ad_id,published_date,title,location,rent,img.* FROM advertisement JOIN " + type + " ON advertisement.ad_id=" + type + ".ad_id JOIN (SELECT * FROM ad_img GROUP BY ad_id) AS img ON advertisement.ad_id=img.ad_id WHERE advertisement.ad_id!=? AND location=? LIMIT 4;";
                    try {
                        PreparedStatement pst = con.prepareStatement(query);
                        pst.setString(1, id);
                        pst.setString(2, loc);
                        ResultSet rs = pst.executeQuery();
                        while (rs.next()) {
                %>
                
                <a class="card text-dark text-decoration-none border col-12 col-md-6 col-lg-3" href="adView.jsp?id=<%=rs.getString("ad_id")%>">
                    <img class="card-img-top adImg" src="<%= rs.getString("img_path")%>">
                    <div class="card-body adDetails">
                        <h5 class="card-title"><%= rs.getString("title")%></h5>
                        <div class="card-text locInfo"><%= rs.getString("location")%></div>
                        <div class="card-text price"><%= rs.getString("rent")%></div>
                    </div>
                </a>
                <%           }
                    } catch (Exception e) {
                        System.err.println(e.getMessage());
                    }
                %>
            </div>
        </div>
        <%if (session.getAttribute("reported") != null) {
                LocalTime time = LocalTime.now().truncatedTo(ChronoUnit.MINUTES);
                String stTime = time.toString();
        %>
        <script>
            alert("you already reported");
                    document.getElementsClassName('box')[0].innerHTML = `
                    < div class = 'rounded border bg-warning d-flex flex-column p-2 position-fixed errBox w-25' style = "min-width:200px" >
                    < span onclick = 'hide(event);' class = 'btn btn-dark bi bi-x ms-auto border rounded-circle' > < /span>
                    < div class = 'text-center' > You have reported once < /div>
                    < small class = 'text-black-50 text-end' ><%=stTime%> < /small>
                    < /div>`;
        </script>

        <%session.removeAttribute("reported");
            }
        %>
        <div class="box"></div>
        <footer id="footer">
        </footer>





        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.min.js"></script>
        <!--<script src="Js/adMain.js"></script>-->

    </body>

</html>