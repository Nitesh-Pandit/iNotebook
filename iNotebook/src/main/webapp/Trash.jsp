<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %>
<%@ page import="java.sql.*, jakarta.servlet.http.*, jakarta.servlet.*" %>
<%
    // ✅ Get the logged-in user's ID from session
    Integer userId = (Integer) session.getAttribute("userId");
    
    if (userId == null) {
        response.sendRedirect("Signup.jsp"); // Redirect if user is not logged in
        return;
    }

    // ✅ Database Connection
    String url = "jdbc:mysql://localhost:3306/notebook";
    String dbUser = "root";
    String dbPassword = "";

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, dbUser, dbPassword);

        // ✅ Fetch only the logged-in user's trashed notes
        String sql = "SELECT id, title, file_path,content, created_at FROM notes WHERE is_deleted = 1 AND user_id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, userId);
        rs = pstmt.executeQuery();
%>

    
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Bootstrap demo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="css/notesDashboard.css" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    
      <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
    />
    
    
       <style>
       
       .p-2:hover {
    
    box-shadow: 5px 5px 20px rgba(0, 0, 0, 0.5);
    transform: scale(1.02);
}

#notesContainer {
    max-height: 600px;  /* Adjust based on preference */
    overflow-y: auto;   /* Enables vertical scrolling */
    padding: 10px;
}

#notesContainer::-webkit-scrollbar {
    width: 8px;
}

#notesContainer::-webkit-scrollbar-thumb {
    background-color: #888;
    border-radius: 4px;
}

#notesContainer::-webkit-scrollbar-thumb:hover {
    background-color: #555;
}
       </style>
       
       
       <script>
        // Hide alert after 3 seconds
        setTimeout(() => {
            let alertBox = document.getElementById("alertBox");
            if (alertBox) {
                alertBox.style.transition = "opacity 0.5s";
                alertBox.style.opacity = "0";
                setTimeout(() => {
                    alertBox.style.display = "none";
                }, 500);
            }
        }, 3000);
    </script>
  </head>
  <body>
   
   
   <% 
    HttpSession sessionObj = request.getSession(false);
    String message = (sessionObj != null) ? (String) sessionObj.getAttribute("message") : null;
    String alertType = (sessionObj != null) ? (String) sessionObj.getAttribute("alertType") : null;
    String userName = (sessionObj != null) ? (String) sessionObj.getAttribute("userName") : null;
    String userEmail = (sessionObj != null) ? (String) sessionObj.getAttribute("userEmail") : null;

    if (userName == null || userEmail == null) {
        response.sendRedirect("Signup.jsp");
        return;
    }

    if (message != null && alertType != null) { 
%>
    <!-- Bootstrap Alert -->
    <div class="alert alert-<%= alertType %> alert-dismissible fade show text-center floating-alert" role="alert" style="position: fixed; top: 20px; width: 100%; z-index: 9999;">
        <strong><%= alertType.equals("success") ? "Success" : "Error" %>:</strong> <%= message %>
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>

<%
    // Remove message after displaying to prevent duplicate alerts
    sessionObj.removeAttribute("message");
    sessionObj.removeAttribute("alertType");
    }
%>



 <div class="container">
      <aside class="sidebar">
        <div class="container">
           <div class="profile-container dropdown">
            <div class="avatar" id="profileDropdown" data-bs-toggle="dropdown">
                <%= userName.charAt(0) %> 
            </div>
            <strong><%= userEmail %></strong><br /><br>
            <ul class="dropdown-menu dropdown-menu-end">
                <li class="dropdown-header">ACCOUNT</li>
                <li class="px-3">
                    <strong><%= userName %></strong><br />
                    <small><%= userEmail %></small>
                </li>
                <hr />
                <li><a class="dropdown-item" href="#"><i class="fas fa-user"></i> Account info...</a></li>
                <li><a class="dropdown-item" href="#"><i class="fas fa-cog"></i> Settings</a></li>
                <li><a class="dropdown-item" href="#"><i class="fas fa-bell"></i> Notifications</a></li>
                <hr />
                <li><a class="dropdown-item" href="#"><i class="fas fa-question-circle"></i> Need help?</a></li>
                <hr />
                <li><a class="dropdown-item text-danger" href="LogoutServlet"><i class="fas fa-sign-out-alt"></i> Sign out</a></li>
            </ul>
        </div>
        
        </div>
        <input type="text" class="search" placeholder="Search" />
        <div class="d-flex justify-content-between">
          <button class="btn note"><a href="Note.jsp" style="color: black;text-decoration:none;">+ Note</a></button>
          <div class="dropdown">
            <button
              class="btn btn-secondary"
              type="button"
              data-bs-toggle="dropdown"
              style="margin: 10px"
            >
              ...
            </button>
            <ul class="dropdown-menu">
              <li>
                <a
                  class="dropdown-item"
                  href="#"
                  data-bs-toggle="modal"
                  data-bs-target="#exampleModal3"
                >
                  <i class="fas fa-book"></i> NoteBook
                </a>
               
                
              </li>
              <hr />
              <li>
                <a class="dropdown-item" href="#" id="fileUploadBtn"
                  ><i class="fas fa-file" ></i> File</a
                >
              </li>
              <hr />
              <li>
                <a class="dropdown-item" href="#" id="imageUploadBtn"
                  ><i class="fas fa-image" ></i> Image</a
                >
              </li>
              <hr />
              <li>
                <a class="dropdown-item" href="#" id="sketchBtn"
                  ><i class="fas fa-paint-brush" ></i> Sketch</a
                >
              </li>
            </ul>
          </div>
        </div>
        
        
        
                    <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#taskModal">+ Task</button>



<!-- Modal -->
    <div class="modal fade" id="taskModal" tabindex="-1" aria-labelledby="taskModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="taskModalLabel">Things to do</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="mb-3">
                            <label class="form-label">Task Name</label>
                            <input type="text" class="form-control" placeholder="Enter task">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Description</label>
                            <textarea class="form-control" placeholder="What is this task about?"></textarea>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Due Date</label>
                            <div class="d-flex">
                                <button type="button" class="btn btn-outline-secondary">Today</button>
                                <button type="button" class="btn btn-outline-secondary">Tomorrow</button>
                                <button type="button" class="btn btn-outline-secondary">Custom</button>
                                <button type="button" class="btn btn-outline-secondary">Repeat</button>
                            </div>
                        </div>
                                               
                       
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-primary">Create Task</button>
                </div>
            </div>
        </div>
    </div>

        <div class="slider">
          <ul>
            <li>
              <i class="fas fa-home"></i
              ><a href="Home.jsp" style="color: black; text-decoration: none">
                Home</a
              >
            </li>
           <ul class="list-unstyled">
<li>
    <i class="fas fa-sticky-note"></i> 
  
 <a href="notesDashboard.jsp" style="color: black; text-decoration: none">Notes</a>
</li>

</ul>
            <li><i class="fas fa-tasks"></i> Tasks</li>
            <li><i class="fas fa-file"></i> Files</li>
           <div>
           
           </div>
           <p>
           
           </p>
            <li><i class="fas fa-book"></i> Notebook 
            
         
             <b><ul id="notebookList3" style="color:green;"></ul></b>
            </li>
            <li><i class="fas fa-share"></i> Shared with Me</li>
            <li><i class="fas fa-trash"></i> Trash</li>
          </ul>
        </div>
        <div class="notebook-card">
          <img src="images/istoc.png" alt="Notebook Icon" />
          <p><strong>Write Your notes Here!</strong></p>
        </div>
      </aside>
   
   
   
   
  
   <main class="content" style="max-width:100%">
            <p>Get Ready to takes notes</p>
            <h3>Sonikumari345atebac's <p class="text-danger">Deleted notes</p></h3>
            <div class="add-note" style="margin-top:0px;">
                <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSgy6cH4pk8uBtQ-_MBHx5MtDO8ms62KxR0UQ&s" alt="Note Icon">
              

<div class="container mt-4">
    <div class="row"style="width:100%;">
        <%
            boolean hasNotes = false;
            while (rs.next()) {
                hasNotes = true;
                int noteId = rs.getInt("id"); // Get note ID
        %>
        <div class="col-md-4" id="note-<%= noteId %>" >
    <div class="card mt-3 p-3 shadow" style="height: 100%; min-height: 300px;">
        <img src="GetImage?id=<%= noteId %>" class="card-img-top" alt="Note Image">
        <div class="card-body">
            <h5 class="card-title"><%= rs.getString("title") %></h5>
            <p class="card-text" style="min-height: 80px; overflow: hidden;">
                <%= rs.getString("content") %>
            </p>
            <p class="text-muted">
                <i class="bi bi-clock"></i> Created at: <%= rs.getTimestamp("created_at") %>
            </p>
            <form style="display:inline;">
                <button type="button" class="btn btn-danger btn-sm delete-btn" data-id="<%= noteId %>">🗑️ Delete Permanently</button>
            </form>
        </div>
    </div>
</div>

        <%
            }
            if (!hasNotes) {
        %>
        <p style="position:relative;left:50px;"><strong>No Any Deleted Notes Here!</strong></p>
        <%
            }
        %>
    </div>
</div>


        </main>
        
      
        
<script>
        function confirmDelete() {
            return confirm("Are you sure you want to permanently delete this note?");
        }
       
        document.addEventListener("DOMContentLoaded", function () {
            document.querySelectorAll(".delete-btn").forEach(button => {
                button.addEventListener("click", function () {
                    let noteId = this.getAttribute("data-id");

                    if (confirm("⚠ Are you sure you want to permanently delete this note?")) {
                        fetch("PermanentDeleteServlet", {
                            method: "POST",
                            headers: { "Content-Type": "application/x-www-form-urlencoded" },
                            body: "noteId=" + noteId
                        })
                        .then(response => response.text())  // Get plain text response
                        .then(data => {
                            let params = new URLSearchParams(data); // Parse key=value format
                            if (params.get("status") === "success") {
                                alert("✅ Note permanently deleted!");
                                document.getElementById("note-" + noteId).remove(); // Remove card from UI
                            } else {
                                alert("❌ Error: " + params.get("message"));
                            }
                        })
                        .catch(error => alert("❌ Network error: " + error));
                    }
                });
            });
        });

    </script>

        
     



   
   
   
   
   
   
   
   
   
   
   
   
   
   
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
  </body>
</html>




<%
    } catch (Exception e) {
        e.printStackTrace();	
    } finally {
        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>