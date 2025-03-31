<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <link rel="stylesheet" type="text/css" href="css/Dashboard.css">
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

    <section class="section">
        <div class="text-content">
            <h1><span>weL</span>Come,</h1>
            <p>Our notebook on cloud - safe and secure</p>
            <p>"An online web platform designed for you to effortlessly create, edit, upload, and organize your notes securely in the cloud. Whether you're a student, professional, or someone who loves jotting down ideas, iNotebook helps you stay organized without any hassle. With a user-friendly interface and powerful features, you can access your notes anytime, anywhere. Your data remains private and encrypted, ensuring complete security. Get started today and experience the ease of digital note-taking. For more details, check out our About Page and see how iNotebook can enhance your productivity!". <a href="#">About Page</a>.
            </p>
            <button class="button"><a href="notesDashboard.jsp"  style="color:white;    text-decoration: none;">Create New Note</a></button>
        </div>
        <div class="image-content">
            <img src="images/nitesh2.png" alt="iNotebook illustration">
        </div>
    </section>
</body>
</html>