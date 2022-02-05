<%@page import="dao.DbConnection"%>
<%@page import="javax.swing.JOptionPane"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession se = request.getSession();
    String user = (String) se.getAttribute("loggedUser");
    String role = (String) se.getAttribute("role");
    if (role != null && role.equals("USER")) {

%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" />
        <link rel="stylesheet" href="css/adEdit.css" />
            <link rel="stylesheet" href="css/common.css" />
        <title>AdEdit</title>
    </head>

    <body>
        <header id="header">
            <jsp:include page="header.jsp" />  
        </header>

        <div class="box">
            <h3>Your Advertisments</h3>
            <div class="typeBlock">
                <label for="adType">Choose Ad Type</label>
                <select class="custom-select custom-select-sm" name="" id="adType">
                    <option>All</option>
                    <option>House</option>
                    <option>Room</option>
                    <option>Shop</option>
                </select>
            </div>

            <div class="allAdBox">

                <%                   
                    
                    DbConnection db = new DbConnection();
                    Connection con = db.getConnection();
                    String query = "SELECT * FROM advertisement JOIN (SELECT * FROM ad_img GROUP BY ad_id) AS img ON advertisement.ad_id=img.ad_id WHERE username=?";
                    try {
                        PreparedStatement pst = con.prepareStatement(query);
                        pst.setString(1, user);
                        ResultSet rs = pst.executeQuery();
                        while (rs.next()) {

                            String ad_id = rs.getString("ad_id");

                            String type = "";
                            if (ad_id.charAt(0) == 'H') {
                                type = "house";
                            } else if (ad_id.charAt(0) == 'R') {
                                type = "room";
                            } else {
                                type = "shop";
                            }
                %>
                <div class="card m-2" id="<%= rs.getString("ad_id")%>">
                    <span hidden id="<%= type%>"></span>
                    <span class="editBtn">Edit Ad</span>
                    <img class="card-img-top adImg" src="<%=rs.getString("img_path")%>" />
                    <div class="card-body adDetails">
                        <h5 class="card-title"><%= rs.getString("title")%></h5>
                        <div class="card-text locInfo"><%= rs.getString("location")%></div>
                        <div class="card-text price"><%= rs.getString("rent")%></div>
                        <a class="btn btn-sm btn-warning w-100" href="AdDeleteServlet?id=<%= rs.getString("ad_id")%>">Remove Ad</a>
                    </div>
                </div>

                <%
                        }
                        rs.close();
                    } catch (Exception e) {
                        out.println(e);
                    }
                %>
            </div>
        </div>

        <form hidden class="adEditForm" action="AdUpdateServlet" method="POST" >
            <h3>Edit Advertisement Details</h3>
            <input hidden name="id">
            <label for="selectLoc">Location</label>
            <select class="custom-select custom-select-sm" id="selectLoc" name="loc"></select>

            <label for="adTitle">Title</label>
            <input type="text" id="adTitle" class="form-control form-control-sm" name="title" />

            <label for="rentPrice">Rent</label>
            <input type="number" id="rentPrice" class="form-control form-control-sm" name="rent"/>

            <label for="area">Area(Square Feet)</label>
            <input type="number" id="area" class="form-control form-control-sm" name="area"/>

            <label for="adDescription">Description</label>
            <textarea name="desc" id="adDescription" class="form-control form-control-sm" cols="20" rows="10" maxlength="300"></textarea>
            <div id="extraFilters"></div>
            
<!--            <div class="imageDiv">
                    <h5>Add upto 5 images</h5>
                    <label class="btn btn-warning" for="images">Choose Images</label>
                   <input hidden id="images" class="adImg" name="file" accept=".jpg,.jpeg,.png,.jiff" type="file" multiple/>
                    <div id="imgPreview"></div>
                </div>-->

            <input class="btn btn-primary btn-sm w-100" id="submit" type="submit" value="Apply Changes" />
            <span class="btn btn-primary btn-sm w-100" id="btnClose">Close</span>
        </form>

        <footer id="footer">
            <jsp:include page="footer.html" />  
        </footer>
            <%} else {
                    String redirectURL = "/RentOnline/errorDis.html";
                    response.sendRedirect(redirectURL);
                }%>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.min.js"></script>
        <script src="js/adEdit.js"></script>
        <script src="js/common.js"></script>
    </body>


</html>
