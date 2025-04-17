<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %>
    <%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Notebook App</title>
    <link href="https://cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
    <link rel="stylesheet" href="css/Note.css" />
    <style>
    .quill-disabled {
    pointer-events: none;
    opacity: 0.5;
    </style>
</head>

<body>
    <div class="container">
        <aside class="sidebar">
            <div class="container">
                <div class="profile-container dropdown">
                    <div class="avatar" id="profileDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                        S
                    </div>
                    
                    <br />
                    <br />
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="profileDropdown">
                        <li class="dropdown-header">ACCOUNT</li>
                        <li class="px-3">
                            
                        </li>
                        <hr />

                        
                        <li>
                            <a class="dropdown-item" href="#"><i class="fas fa-bell"></i> Notifications</a>
                        </li>
                        <hr />
                       
                        <hr />
                        <li>
                            <a class="dropdown-item text-danger" href="#"><i class="fas fa-sign-out-alt"></i> Sign
                                out</a>
                        </li>
                    </ul>
                </div>
            </div>
            <input type="text" class="search" placeholder="Search" />
            <div class="d-flex justify-content-between">
                <button class="btn note">+ Note</button>
                <div class="dropdown">
                    <button class="btn btn-secondary" type="button" data-bs-toggle="dropdown" style="margin: 10px">
                        ...
                    </button>
                    <ul class="dropdown-menu">
                        <li>
                            <a class="dropdown-item" href="#" data-bs-toggle="modal" data-bs-target="#exampleModal1">
                                <i class="fas fa-book"></i> NoteBook
                            </a>
                        </li>
                        <hr />
                        <li>
                            <a class="dropdown-item" href="#"><i class="fas fa-file"></i> File</a>
                        </li>
                        <hr />
                        <li>
                            <a class="dropdown-item" href="#"><i class="fas fa-image"></i> Image</a>
                        </li>
                        <hr />
                        <li>
                            <a class="dropdown-item" href="https://excalidraw.com/"><i class="fas fa-paint-brush"></i> Sketch</a>
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
                        <i class="fas fa-home"></i><a href="home.html" style="color: black; text-decoration: none">
                            Home</a>
                    </li>
                    
                    <li><i class="fas fa-sticky-note"></i> Notes</li>
                    <li><i class="fas fa-tasks"></i> Tasks</li>
                    <li><i class="fas fa-file"></i> Files</li>
                    <li><i class="fas fa-book"></i> Notebook</li>
                    <li><i class="fas fa-share"></i> Shared with Me</li>
                    <li><i class="fas fa-trash"></i> Trash</li>

                    <!--
            <li><i class="fas fa-th-large"></i> Templates</li>
            <li><i class="fas fa-tags"></i> Tags</li>
            <li><i class="fas fa-star"></i> Shortcuts</li>
            <li><i class="fas fa-users"></i> Spaces</li>
            -->
                </ul>
            </div>
            <div class="notebook-card">
                <img src="images/istoc.jpg" alt="Notebook Icon" />
                <p><strong>Write Your notes Here!</strong></p>
            </div>
        </aside>
        <main class="content">
            <div class="d-flex justify-content-between">
        <h3>Notes</h3>
       
    </div>
  
  
 <!-- Always outside the loop -->
<p style="margin-right: 200px; font-weight: 600">notes</p>
<div class="add-note">
    <div class="slider1">
        <%-- LOOP STARTS HERE --%>
        <%
            Integer userId = (Integer) session.getAttribute("userId");
            if (userId == null) {
                response.sendRedirect("Signup.jsp");
                return; 
            }

            String url = "jdbc:mysql://localhost:3306/notebook";
            String dbUser = "root";
            String dbPassword = "";

            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(url, dbUser, dbPassword);
            PreparedStatement pstmt = conn.prepareStatement(
                "SELECT id, title, file_path, content, created_at FROM notes WHERE  user_id = ?"
            );
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                int noteId = rs.getInt("id");
                String title = rs.getString("title");
                String content = rs.getString("content");
                Timestamp createdAt = rs.getTimestamp("created_at");
        %>

        <!-- ✅ Single Note Card -->
       <!-- ✅ Single Note Card -->
<div class="card my-3">
    <div class="card-header">
    
        <div style="display: flex; justify-content: space-between">
			       <button
  type="button"
  class="btn btn-light btn-sm"
  style="color: blue; width:35%;"
  data-bs-toggle="modal"
  data-bs-target="#exampleModal"
  data-note-id="<%= noteId %>"
  data-title="<%= title %>"
  data-content="<%= content %>"
  data-created="<%= createdAt.toString() %>"
>
  Share
</button>


            <p style="margin-left: 10px; margin-top: 10px">
                <b><%= title %></b>
            </p>
            
        </div>
    </div>
   <div class="card-body">
    <% if (rs.getBlob("file_path") != null) { %>
        <img src="GetImage?id=<%= noteId %>" alt="Note Image" class="img-fluid mb-2" style="max-height: 200px; object-fit: cover;" />
    <% } %>
    <p class="card-text">
        <%= content.length() > 200 ? content.substring(0, 200) + "..." : content %>
    </p>
</div>

    <div class="card-footer">
        <small class="text-body-secondary"><%= createdAt.toString() %></small>
    </div>
</div>


        <% } %> <%-- END OF WHILE LOOP --%>
        <%
            rs.close();
            pstmt.close();
            conn.close();
        %>
    </div>
</div>

  
  
  
        </main>
        

        <main class="content1">
            <div class="rich-text-container">
                <h2 style="text-align: center">Write Your Notes</h2>
                
                <form >
                <input type="text" class="note-title" placeholder="Enter Title..." required/>
                <div id="toolbar">
                    <span class="ql-formats">
                        <select class="ql-font"></select>
                        <select class="ql-size"></select>
                    </span>
                    <span class="ql-formats">
                        <button class="ql-bold"></button>
                        <button class="ql-italic"></button>
                        <button class="ql-underline"></button>
                        <button class="ql-strike"></button>
                    </span>
                    <span class="ql-formats">
                        <select class="ql-color"></select>
                        <select class="ql-background"></select>
                    </span>
                    <span class="ql-formats">
                        <button class="ql-list" value="ordered"></button>
                        <button class="ql-list" value="bullet"></button>
                        <button class="ql-indent" value="-1"></button>
                        <button class="ql-indent" value="+1"></button>
                    </span>
                    
                    <span class="ql-formats">
                        <select class="ql-align"></select>
                    </span>
                    <span class="ql-formats">
                        <button class="ql-clean"></button>
                    </span>
                </div>
                <div id="editor"></div>
               
                <button type="submit" class="btn save" style="background-color: green; color: white">
                    Save
                </button>
                </form>
            </div>

            <!-- Modal for Share Btn   -->
            <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel"
                aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5" id="exampleModalLabel">Share</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <label for="exampleInputEmail1" class="form-label">Email address</label>
                           <input type="text" class="form-control" id="emailInput" placeholder="Enter Email here!" />
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-warning w-25" onclick="sendNoteDetails()">
							  Send
							</button>
                        </div>
                    </div>
                </div>
            </div>
            
            <!--  Model For Notebook -->

            <div class="modal fade" id="exampleModal1" tabindex="-1" aria-labelledby="exampleModalLabel"
                aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5" id="exampleModalLabel">
                                Create Notebook
                            </h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <label for="text" class="form-label">Name</label>
                            <input type="text" class="form-control" id="Notebook Name" placeholder="Note........." />
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                                Close
                            </button>
                            <button type="button" class="btn btn-warning">Create</button>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>

    <script src="https://cdn.quilljs.com/1.3.6/quill.js"></script>
    <script>
    // Initialize Quill
    var quill = new Quill("#editor", {
      modules: {
        toolbar: "#toolbar",
      },
      placeholder: "Start typing your notes...",
      theme: "snow",
    });

    // Disable editor functionality
    quill.enable(false);

    // Add visual + interaction block
    document.querySelector('.ql-container').classList.add('quill-disabled');
    document.querySelector('#toolbar').classList.add('quill-disabled');
    document.querySelector('.note-title').classList.add('quill-disabled');
    document.querySelector('.rich-text-container').classList.add('quill-disabled');
    
        let selectedNote = {};

        const exampleModal = document.getElementById('exampleModal');
        exampleModal.addEventListener('show.bs.modal', function (event) {
          const button = event.relatedTarget;

          selectedNote = {
            id: button.getAttribute('data-note-id'),
            title: button.getAttribute('data-title'),
            content: button.getAttribute('data-content'),
            created: button.getAttribute('data-created'),
          };

          // Optionally clear email field
          document.getElementById('emailInput').value = '';
        });

        // Handle Send button click
        function sendNoteDetails() {
          const email = document.getElementById('emailInput').value;

          if (!email) {
            alert('Please enter an email!');
            return;
          }

          fetch('SendNoteEmailServlet', {
            method: 'POST',
            headers: {
              'Content-Type': 'application/json'
            },
            body: JSON.stringify({
              email: email,
              note: selectedNote
            })
          })
          
          .then(res => res.text())
          .then(response => {
            alert(response);
            const modal = bootstrap.Modal.getInstance(exampleModal);
            modal.hide();
          })
          .catch(err => {
            console.error('Error:', err);
            alert('Failed to send email.');
          });
        }

    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
</body>

</html>