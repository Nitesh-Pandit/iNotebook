<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
       <%@ page import="jakarta.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Home Page</title>
        <link rel="stylesheet" type="text/css" href="css/Main.css">
    <link
    
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
    />
  </head>
  <body style="  margin-left: 5px;
    margin-right: 5px;">
    
<% 
    String message = request.getParameter("message");
    String alertType = request.getParameter("alertType");
    if (message != null) { 
%>
     <div class="alert alert-<%= alertType %> alert-dismissible fade show text-center floating-alert" role="alert" style="position: fixed; top: 220px; width: 50%; z-index: 9999; left:400px;">
        <strong><%= alertType.equals("success") ? "Success" : "Error" %>:</strong> <%= message %>
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
<% } %>


   <header>
    <nav class="navbar navbar-expand-lg px-3" style="background: #2c3e50;padding: 30px;">
        <a class="navbar-brand fw-bold text-light" href="#">i<span style="color: #1abc9c;">NoteBook</span></a>

        <!-- Navbar Toggle Button (For Small Screens) -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" 
            aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <!-- Navbar Links -->
       <div class="collapse navbar-collapse justify-content-center" id="navbarNav">
    <ul class="navbar-nav">
        <li class="nav-item">
            <a class="nav-link text-light disabled" href="#" tabindex="-1" aria-disabled="true">Home</a>
        </li>
        <li class="nav-item">
            <a class="nav-link text-light disabled" href="#" tabindex="-1" aria-disabled="true">About</a>
        </li>
        <li class="nav-item">
            <a class="nav-link text-light disabled" href="#" tabindex="-1" aria-disabled="true">Contact</a>
        </li>
    </ul>
</div>


        <!-- Buttons (Aligned to the Right) -->
        <div class="d-flex">
            <a href="signup.html" class="btn btn-success mx-2 disabled">Login</a>
            <a href="login.html" class="btn btn-outline-success disabled">SignUp</a>
        </div>
    </nav>
</header>

  
  
  
  

<section class="image-slider">
  <div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
    <!-- Indicators -->
    <div class="carousel-indicators">
      <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active"
        aria-current="true" aria-label="Slide 1"></button>
      <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1"
        aria-label="Slide 2"></button>
      <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2"
        aria-label="Slide 3"></button>
    </div>

    <!-- Carousel Images -->
    <div class="carousel-inner">
      <div class="carousel-item active">
        <img src="images/details-slide-2.jpg" class="d-block w-100 carousel-img" alt="Slide 1" />
      </div>
      <div class="carousel-item">
        <img src="images/3.jpg" class="d-block w-100 carousel-img" alt="Slide 2" />
      </div>
      <div class="carousel-item">
        <img src="images/niteshhh.webp" class="d-block w-100 carousel-img" alt="Slide 3" />
      </div>
    </div>

    <!-- Prev & Next Buttons -->
    <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
      <span class="carousel-control-prev-icon" aria-hidden="true"></span>
      <span class="visually-hidden">Previous</span>
    </button>
    <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
      <span class="carousel-control-next-icon" aria-hidden="true"></span>
      <span class="visually-hidden">Next</span>
    </button>

    <!-- Overlay Text -->
    <div class="overlay">
      <p>From quick memos to detailed meeting notes, iNoteBook has you covered. Enjoy features like rich text editing,
        tagging, cloud syncing, and offline access – all in a beautifully designed interface.</p>
      <a href="Dashboard.jsp" class="btn btn-primary">Start Now</a>
    </div>
  </div>
</section>




    <div class="container marketing">
      <!-- Three columns of text below the carousel -->
      <div class="row my-5 text-center">  <!-- Center text for all screen sizes -->
          <div class="col-lg-4 col-md-6 mb-4">
              <img src="images/edit.jpg" class="d-block w-50 mx-auto rounded-circle" alt="Edit Notes">
              <h2 class="fw-normal mt-3">Insert Notes</h2>
              <p>Some representative placeholder content for inserting notes.</p>
              <p><a class="btn btn-success" href="#">Insert Notes »</a></p>
          </div><!-- /.col-lg-4 -->
          
          <div class="col-lg-4 col-md-6 mb-4">
              <img src="images/update1.jpg" class="d-block w-50 mx-auto rounded-circle" alt="Update Notes">
              <h2 class="fw-normal mt-3">Update Notes</h2>
              <p>Modify your existing notes with ease.</p>
              <p><a class="btn btn-warning" href="#">Update Notes »</a></p>
          </div><!-- /.col-lg-4 -->
          
          <div class="col-lg-4 col-md-12">
              <img src="images/delete.jpg" class="d-block w-50 mx-auto rounded-circle" alt="Delete Notes">
              <h2 class="fw-normal mt-3">Delete Notes</h2>
              <p>Remove notes you no longer need.</p>
              <p><a class="btn btn-danger" href="#">Delete Notes »</a></p>
          </div><!-- /.col-lg-4 -->
      </div><!-- /.row -->
  </div>
  


    <!-- START THE FEATURETTES -->

    <hr class="featurette-divider">
    <div class="row featurette">
      <div class="col-md-7">
        <h2 class="featurette-heading fw-normal lh-1">First featurette heading. <span class="text-body-secondary">It’ll blow your mind.</span></h2>
        <p class="lead">Some great placeholder content for the first featurette here. Imagine some exciting prose here.</p>
      </div>
      <div class="col-md-5">
     <img src="images/student.webp" class="d-block w-100" alt="Second slide">
      </div>
    </div>

    <hr class="featurette-divider"> 

    <div class="row featurette">
      <div class="col-md-7 order-md-2">
        <h2 class="featurette-heading fw-normal lh-1">Oh yeah, it’s that good. <span class="text-body-secondary">See for yourself.</span></h2>
        <p class="lead">Another featurette? Of course. More placeholder content here to give you an idea of how this layout would work with some actual real-world content in place.</p>
      </div>
      <div class="col-md-5 order-md-1">
             <img src="images/about-1.jpg" class="d-block w-100" alt="Second slide">

      </div>
    </div>

    <hr class="featurette-divider">

    <div class="row featurette">
      <div class="col-md-7">
        <h2 class="featurette-heading fw-normal lh-1">And lastly, this one. <span class="text-body-secondary">Checkmate.</span></h2>
        <p class="lead">And yes, this is the last block of representative placeholder content. Again, not really intended to be actually read, simply here to give you a better view of what this would look like with some actual content. Your content.</p>
      </div>
      <div class="col-md-5">
                     <img src="images/carousel-2.jpg" class="d-block w-100" alt="Second slide">

      </div>
    </div>

    <hr class="featurette-divider">

    <!-- /END THE FEATURETTES -->

  </div>


  <footer class="footer">
    <div class="footer-container">
        <!-- Logo & Social Icons -->
        <div class="footer-column">
            <h2>iNotebook</h2>
            <p>An E-commerce website.</p>
                    </div>

        <!-- Company Links -->
        <div class="footer-column">
            <h3>Company</h3>
            <p><a href="#">Home</a></p>
            <p><a href="#">About</a></p>
            <p><a href="#">Contact Us</a></p>
        </div>

        <!-- Template Links -->
        <div class="footer-column">
            <h3>Features</h3>
            <p><a href="#">Insert</a></p>
            <p><a href="#">Update</a></p>
            <p><a href="#">Delete</a></p>
            <p><a href="#">Share</a></p>
        </div>
        <!-- Contact Info -->
        <div class="footer-column">
            <h3>Contact</h3>
            <p>+91555555555555</p>
            <p>Inotebook@gmail.com</p>
            <p>30 N Tramba St Ste R<br>Rajkot, WY 36000</p>
        </div>
    </div>

    <!-- Bottom Section -->
    <div class="footer-bottom">
        <p>Need Help Customizing Your Site?</p>
        <p>Get personalized page adjustments from our expert team to make your site stand out.</p>
  
        <p>© All rights reserved. Flowfye.</p>
    </div>
</footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  </body>
</html>
