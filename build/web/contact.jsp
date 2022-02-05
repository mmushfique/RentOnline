<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact us </title>
    <link rel="stylesheet" href="css/contact.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.1/css/all.min.css">
  </head>
  <body>

    <header id="header">
            <jsp:include page="header.jsp"/>
        </header>

    <!--contact section start-->
    <div class="contact-section">
      <div class="contact-info">
        <div><i class="fas fa-map-marker-alt"></i>No119,Galle road,Colombo 10, Sri Lanka</div>
        <div><i class="fas fa-envelope"></i>rentportal@gmail.com</div>
        <div><i class="fas fa-phone"></i>0112010326</div>
        <div><i class="fas fa-clock"></i>24HOURS/365DAYS</div>
      </div>
      <div class="contact-form">
        <h2>Contact Us</h2>
        <form class="contact" action="" method="post">
          <input type="text" name="name" class="text-box" placeholder="Your Name" required>
          <input type="email" name="email" class="text-box" placeholder="Your Email" required>
          <textarea name="message" rows="5" placeholder="Your Message" required></textarea>
          <input type="submit" name="submit" class="send-btn" value="Send">
        </form>
      </div>
    </div>

    <!--contact section end-->
<footer id="footer">
            <jsp:include page="footer.html" />  
        </footer>
  </body>
</html>