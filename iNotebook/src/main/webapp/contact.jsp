<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us</title>
    <link rel="stylesheet" href="css/constact.css">
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
</head>
<body>
  <header>
      <nav>
        <div class="logo">i<span>NoteBook</span></div>
        <ul>
          <li><a href="Main.jsp" class="active">Home</a></li>
          <li><a href="about.jsp">About</a></li>
          <li><a href="contact.jsp">Contact</a></li>
        </ul>
        <div class="d-flex">
          <button type="button" class="btn btn-success mx-2">
            <a href="Signup.jsp" style="color: white">Login</a>
          </button>
          <button type="button" class="btn btn-outline-success">
            <a href="Login.jsp" style="color: white">SignUp</a>
          </button>
        </div>
      </nav>
    </header>
    
    <div class="contact-container">
<img src="images/image7.png" class="img-fluid" alt="...">
        <div class="contact-card">
            <div class="left-panel">
                <h2>Write us</h2>
                <label for="name">Name</label>
                <input type="text" id="name" placeholder="AdMike" >

                <label for="email">E-mail</label>
                <input type="email" id="email" placeholder="admike@domain.com" >
               
                <div class="checkbox">
                    <input type="checkbox" id="robot-check" style="width:30%; margin-top:16px;">
                    <label for="robot-check" style="width:100%">I am not a robot</label>
                </div>
            </div>

            <div class="right-panel">
                <label for="message">Message</label>
                <textarea id="message" placeholder="Write text here..."></textarea>
                <button type="submit">SEND MESSAGE</button>
            </div>
        </div>


    </div>

</body>
</html>
