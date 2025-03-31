<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
   <link rel="stylesheet" type="text/css" href="css/Login.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
</head>
<body>




 <div class="container d-flex">
        <div class="left-panel w-50">
            <div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
                <div class="carousel-indicators">
                    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
                    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
                    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
                </div>
                <div class="carousel-inner ">
                    <div class="carousel-item active">
                        <img src="images/image5.webp" class="d-block w-100 h-50 rounded " alt="Slide 1">
                    </div>
                    <div class="carousel-item">
                        <img src="images/image6.webp" class="d-block w-100 h-50 rounded" alt="Slide 2">
                    </div>
                    <div class="carousel-item">
                        <img src="images/nitesh1.png" class="d-block w-100 h-50 rounded" alt="Slide 3">
                    </div>
                </div>
               
            </div>
        </div>
       <div class="right-panel w-50 d-flex align-items-center justify-content-center text-white" style="background: transparent; box-shadow: 0px 0px 20px rgba(0, 0, 0, 0.2)">
            <div class="form-container w-75 ">
                <h2>Create an account</h2>
                <p>Already have an account? <a href="Signup.jsp" class="text-warning">Log in</a></p>
               <form action="RegisterServlet" method="post">
    <div class="mb-3">
        <input type="text" class="form-control" name="first_name" placeholder="First name" required>
    </div>
    <div class="mb-3">
        <input type="text" class="form-control" name="last_name" placeholder="Last name" required>
    </div>
    <div class="mb-3">
        <input type="email" class="form-control" name="email" placeholder="Email" required>
    </div>
    <div class="mb-3">
        <input type="password" class="form-control" name="password" placeholder="Enter your password" required>
    </div>
    <div class="form-check mb-3">
        <input type="checkbox" class="form-check-input" id="terms" required>
        <label class="form-check-label" for="terms">I agree to the <a href="#" class="text-warning">Terms & Conditions</a></label>
    </div>
    <button type="submit" class="btn btn-warning w-100">Create account</button>
</form>
                <div class="text-center mt-3">Or register with</div>
                  <div class="d-flex justify-content-between mt-3">
                                     <button class="btn btn-light w-48"><img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQiufjMBMPwlCuWDLiEEd_e9Z6jHGRi8kP7oA&s" width="20" > Google</button>
                    <button class="btn btn-light w-48"><img src="https://upload.wikimedia.org/wikipedia/commons/0/05/Facebook_Logo_%282019%29.png" width="20" alt="Facebook"> Facebook</button>
                </div>
                </div>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>