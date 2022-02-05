<%@page import="java.io.PrintWriter"%>


<!-- <%@page contentType="text/html" pageEncoding="UTF-8" %> -->
<!DOCTYPE html>
<html lang="en">

  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Login</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" />
    <link rel="stylesheet" href="bootstrap icons/bootstrap-icons.css" />
    <link rel="stylesheet" href="css/login.css" />
                <link rel="stylesheet" href="css/common.css" />

  </head>

  <body>
    
     <header id="header">
           <jsp:include page="header.jsp" />  
        </header>
   

    <form class="login" id="loginForm" action="LoginServlet" method="POST">
      <span id="switchSignup" class="bi bi-person-plus"></span>
      <span class="bi bi-person-check"></span>
      <h4>Sign In</h4>
      <div class="block">
        <input class="form-control" type="text" id="emailcheck" name="username" placeholder="username" />
        <input class="form-control" type="password" id="passwordcheck" name="password"
               placeholder="Password" />
        <small> </small>
      </div>
      <%
  
if (request.getParameter("er") != null) {
%>
      <div class="block">
          <label style="color:red">Username or password incorrect</label>
      </div>
 <%}%>
      <div class="btn-group w-100 ">
        <button class="btn btn-primary btn-sm" type="submit" id="loginBtn">Login</button>
        <a class="btn btn-danger btn-sm" id="forgotpassBtn"  href="#">Forgot Password?</a>
      </div>

    </form>
    <form class="signUp" id="signupForm" method="POST" hidden>
      <span id="switchLogin" class="bi bi-person-check"></span>
      <span class="bi bi-person-plus"></span>
      <h4>Sign up</h4>
      <div class="block">
          <div>
          <input class="form-control" type="text" id="username" name="username" placeholder="username" required />
          <small id="userError">error</small>

        </div>
        <div>
          <input class="form-control" type="text" id="firstName" name="fName" placeholder="First Name" />
          <small>error</small>
        </div>
        <div>
          <input class="form-control" type="text" id="lastName" name="lName" placeholder="Last Name" />
          <small>error</small>
        </div>
        <div>
          <input class="form-control" type="email" id="email" name="email" placeholder="Email" />
          <small id="emailError">error</small>
        </div>
        <div>
          <input class="form-control" type="password" id="password" name="password" placeholder="Password" />
          <small>error</small>
        </div>
        <div>
          <input class="form-control" type="password" id="repassword" placeholder="Re-Enter Password" />
          <small>error</small>
        </div>
        <div>
          <input class="form-control" type="number" id="phoneNo" name="phoneNo" placeholder="Phone no"
                 min="0" />
          <small id="phoneError">error</small>
        </div>
      </div>
      <button class="btn btn-primary btn-sm" type="submit" id="signupBtn">Signup</button>
    </form>


   <footer id="footer">
            <jsp:include page="footer.html" />  
        </footer>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.min.js"></script>
    <script src="js/login.js"></script>
    <script src="js/common.js"></script>
  </body>

</html>