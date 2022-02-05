<%response.setHeader("Cache-Control", "private, no-store, no-cache, must-revalidate");
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

        <div class="container">
            <div class="inner">
                <div class="row">
                   
                    <div class="col-md-9">
<br><br><br><br>
                        <form class="form-inline" action="AdReportServlet" method="post">
                            <h3>Please mention in detail,why are you reporting selected the advertisement </h3>
                            <br><br>
                            <input type="text" name="r_id"  value="<%=request.getParameter("id")%>" readonly hidden/>
      
                             <div class="btn-group w-100">
                                 <textarea type="text" id="detail" class="form-control form-control-sm" name="detail" style="width:100%;height:100px;resize:none " placeholder="Type your message"></textarea>
                             </div>
                            <br><br><br><br><br><br>
                             <div class="btn-group w-100">
                                 <input class="btn btn-primary w-50 m-0" id="submit" type="submit" value="Report"  />
                </div>
                        </form>
                        <br>

                    </div>
                </div>
            </div>
        </div>

       
        <script src="js/common.js"></script>
        <br><br><br><br><br>
        <footer id="footer">
            <jsp:include page="footer.html" />  
        </footer>
         <%} else {
                String redirectURL = "login.jsp";
                response.sendRedirect(redirectURL);
            }%>
    </body>
</html>
