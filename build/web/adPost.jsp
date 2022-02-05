<%response.setHeader("Cache-Control", "private, no-store, no-cache, must-revalidate");%>
<%@page import="javax.swing.JOptionPane"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="dao.DbConnection"%>
<%@page import="java.sql.Connection"%>
<%
    HttpSession se = request.getSession();
    String user = (String) se.getAttribute("loggedUser");
    String role = (String) se.getAttribute("role");

    if (role!=null && role.equals("USER")) {

        Connection con;
        DbConnection db = new DbConnection();
        con = db.getConnection();
        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery("SELECT * FROM user WHERE username='"+user+"'");
%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Post Your Advertisement</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" />
        <link rel="stylesheet" href="bootstrap icons/bootstrap-icons.css" />
        <link rel="stylesheet" href="css/adpost.css" />
            <link rel="stylesheet" href="css/common.css" />
    </head>

    <body>
        <header id="header">
            <jsp:include page="header.jsp"/>
        </header>

       <form id="adpostForm" action="adPost" method="POST" enctype="multipart/form-data">
            <div id="common">
                <h3>Fill advertisement details</h3>
                <label for="selectLoc">Location</label>
                <select class="custom-select custom-select-sm" id="selectLoc" name="loc"></select>
                <label for="selectCat">Category</label>
                <select id="selectCat" class="custom-select custom-select-sm" name="cat">
                    <option>House</option>
                    <option>Room</option>
                    <option>Shop</option>
                </select>

                <label for="adTitle">Title</label>
                <input type="text" id="adTitle" class="form-control form-control-sm" name="title"/>

                <label for="rentPrice">Rent</label>
                <input type="number" id="rentPrice" class="form-control form-control-sm"name="rent" />

                <label for="area">Area(Square Feet)</label>
                <input type="number" id="area" class="form-control form-control-sm" name="area"/>

                <label for="adDescription">Description</label>
                <textarea id="adDescription" class="form-control form-control-sm" cols="20" rows="10" maxlength="300" name="desc"></textarea>
                <small id="err"></small>

                <div id="btnNext" class="btn btn-primary w-100">Next</div>
            </div>

            <div id="extra" hidden>
                <div id="extraFilters">

                </div>
                <!--<form id="adpostForm" action="adPost" method="POST" enctype="multipart/form-data">-->
                <div class="imageDiv">
                    <h5>Add upto 5 images</h5>
                    <label class="btn btn-warning" for="images">Choose Images</label>
                   <input hidden id="images" class="adImg" name="file" accept=".jpg,.jpeg,.png,.jiff" type="file" multiple/>
                    <div id="imgPreview"></div>
                </div>
                    <!--</form>-->
                <div class="contact">
                    <h5>Contact details</h5>
                    <span>Name</span>
                    <%while (rs.next()) {%>
                    <p id="name"><%= rs.getString("username")%></p>
                    <span>Phone Number</span>
                    <p id="phoneNo"><%= rs.getString("phone_no")%></p>
                    <%}%>
                </div>
                
                <small id="err1"></small>

                <div class="btn-group w-100">
                    <div id="btnPrev" class="btn btn-primary w-50">Previous</div>
                    <input class="btn btn-primary w-50 m-0" id="submit" type="submit" value="Post Ad+" />
                </div>
            </div>
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
        <script src="js/adpost.js"></script>
<script src="js/common.js"></script>

    </body>

</html>