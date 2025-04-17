<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <link
      href="https://cdn.quilljs.com/1.3.6/quill.snow.css"
      rel="stylesheet"
    />
   			<link
		  href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
		  rel="stylesheet"
		  integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
		  crossorigin="anonymous"
		/>
 
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
    />
       <link rel="stylesheet" href="css/notesDashboard.css" />
       
       <style>
       .p-2:hover {
    box-shadow: 5px 5px 20px rgba(0, 0, 0, 0.5);
    transform: scale(1.02);
}
.dropdown-menu {
  z-index: 1050; /* Bootstrap default */
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



#editor-container {
    position: relative;
}

#updateNoteBtn {
    position: absolute;
    top: 10px;
    left: 10px;
    background-color: orange;
    color: white;
    border: none;
    padding: 5px 10px;
    cursor: pointer;
    z-index: 10;
    border-radius: 5px;
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
			 
			  <!-- Notifications section -->
			  <li>
			    <a class="dropdown-item" href="#">
			      <i class="fas fa-bell"></i> Notifications
			    </a>
			    <ul id="notificationList" class="list-unstyled px-3">
			      <!-- JS will append items here -->
			    </ul>
			  </li>
			 
			 
			  <hr />
			  <li><a class="dropdown-item text-danger" href="LogoutServlet"><i class="fas fa-sign-out-alt"></i> Sign out</a></li>
			</ul>

        </div>
        
        </div>
       <input type="text" id="searchInput" class="form-control" placeholder="Search notes or notebooks...">

<!-- Message when no results are found -->
<p id="noResults" style="display: none; color: red; text-align: center;">No matching results found.</p>


        <div class="d-flex justify-content-between">
          <button class="btn note"><a href="Note.jsp" style="color: black;text-decoration:none;">+ Note</a></button>
         <div class="dropdown">
  <button
    class="btn btn-secondary dropdown-toggle"
    type="button"
    data-bs-toggle="dropdown"
    aria-expanded="false"
    style="margin: 10px"
  >
    ...
  </button>
  <ul class="dropdown-menu">
    <li>
      <a class="dropdown-item" href="#" data-bs-toggle="modal" data-bs-target="#exampleModal3">
        <i class="fas fa-book"></i> NoteBook
      </a>
    </li>
    <hr />
    <li>
      <a class="dropdown-item" href="#" id="fileUploadBtn">
        <i class="fas fa-file"></i> File
      </a>
    </li>
    <hr />
    <li>
      <a class="dropdown-item" href="#" id="imageUploadBtn">
        <i class="fas fa-image"></i> Image
      </a>
    </li>
  
    
  </ul>
</div>
        </div>
        <!--  -->
        

<!-- Task Button to Open Modal -->
<button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#taskModal">+ Task</button>

<!-- Task Modal -->
<div class="modal fade" id="taskModal" tabindex="-1" aria-labelledby="taskModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="taskModalLabel">Things to do</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <!-- Task Form -->
               <form id="taskForm">
			  <div class="mb-3">
			    <label class="form-label">Task Name</label>
			    <input type="text" class="form-control" name="task_name" placeholder="Enter task">
			  </div>
			  <div class="mb-3">
			    <label class="form-label">Description</label>
			    <textarea class="form-control" name="description" placeholder="What is this task about?"></textarea>
			  </div>
			  <div class="mb-3">
			    <label class="form-label">Due Date</label>
			   <input type="date" class="form-control" name="due_date" required>


			  </div>
			</form>
			
			
			<!-- Footer outside form -->
			<div class="modal-footer">
			  <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Cancel</button>
			  <button type="submit" class="btn btn-primary" form="taskForm">Create Task</button>
			</div>
			
			  </div>
        </div>
    </div>
</div>


        <div class="slider">
          <ul>
                       <ul class="list-unstyled">
<li>
    <i class="fas fa-sticky-note"></i> Notes
    <!-- "+ New Note" button should be placed BEFORE the dynamic list -->
    <a class="dropdown-item" href="#" data-bs-toggle="modal" data-bs-target="#exampleModal1" 
        style="color: green; font-weight: bold; display: block; margin-top: 10px;">
        + New Note
    </a>

    <!-- Notes list -->
    <ul id="notesList" style="max-height: 300px; /* Limit height for scrolling */
        overflow-y: auto; /* Enable vertical scrolling */
        border: 2px solid #ddd; /* Light border */
        border-radius: 8px; /* Rounded corners */
        padding: 10px; /* Spacing inside */
        background: #f9f9f9; /* Light background */
        color: green;">
        
        <!-- Notes will be dynamically added here -->
    </ul>
</li>

</ul>
          <li>
  <i class="fas fa-tasks"></i> Tasks
  <ul id="tasksList" style="max-height: 300px; overflow-y: auto; border: 2px solid #ddd; border-radius: 8px; padding: 10px; background: #f9f9f9; color: green;font-weight:600;">
    <!-- Tasks will be dynamically added here -->
  </ul>
</li>

           <li>
    <i class="fas fa-file"></i> Files
    <ul id="filesList" style="max-height: 300px; overflow-y: auto; border: 2px solid #ddd; border-radius: 8px; padding: 10px; background: #f9f9f9; color: blue;">
        <!-- Files will be dynamically added here -->
        
    
    
    
    


    </ul>
</li>

           <div>
           
           </div>
           <p>
           
           </p>
            <li><i class="fas fa-book"></i> Notebook 
            
         
             <b><ul id="notebookList3" style="color:green;"></ul></b>
            </li>
           <li>
				  <i class="fas fa-share"></i> Shared with Me
				  <ul id="sharedWithMeList">
				    <!-- Shared emails + time will be loaded here dynamically -->
				  </ul>
				</li>

            <li><i class="fas fa-trash"></i><a href="Trash.jsp" style="color: black; text-decoration: none">Trash</a></li>
          </ul>
        </div>
        <div class="notebook-card">
          <img src="images/istoc.png" alt="Notebook Icon" />
          <p><strong>Write Your notes Here!</strong></p>
        </div>
      </aside>
      <main class="content">
        <div class="d-flex justify-content-between">
        
<h3 id="NotebookTitle" data-id="null">Notebook</h3>


         
        </div>
       <p id="noteCount">0 notes</p>
          <div id="notesContainer"></div>
        <div class="add-note">
          <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRg1fQdMzYmJ6ux6CDXbLAtsl4S3NARPNYVwg&s" alt="Note Icon" />
          <p><strong>It all begins with notes</strong></p>
          <p>
            Click the <span class="new-note"> <a  class="dropdown-item" href="#" data-bs-toggle="modal" data-bs-target="#exampleModal1"><b>+ New Note </b></a></span> button in
            the sidebar to create a note.
          </p>
        </div>
      </main>

      <main class="content1">
<div class="rich-text-container" id="richTextContainer" style="pointer-events: none; opacity: 0.5;">
    <h2 style="text-align: center">Write Your Notes</h2>

<form id="noteForm" action="SaveNotes" method="POST" enctype="multipart/form-data">
    <!-- Hidden Input for Note ID -->
    <input type="hidden" id="noteId" name="noteId" />

    <!-- Title Input -->
    <input type="text" class="note-title" placeholder="Enter Title..." id="noteTitle1" name="title" required />

    <!-- Quill Editor Toolbar -->
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

   <!-- Quill Editor Container -->
<div id="editor-container">
    <!-- Small Update Button (Initially Hidden) -->
    <button type="button" id="updateNoteBtn" class="btn update" style="display: none;left:650px;top:30px; width:10%;">
        Update
    </button>

    <div id="editor"></div>	
</div>


    <!-- Hidden input to store Quill content -->
    <input type="hidden" name="content" id="hiddenContent">

    <!-- File Upload -->
    <input type="file" name="file" id="fileInput" />

    <!-- Save Button -->
    <button type="submit" class="btn save" style="background-color: green; color: white" id="saveNoteBtn">
        Save
    </button>

   
</form>

</div>

 

        <!-- Modal for Share Btn   -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">Share</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <label for="shareEmail" class="form-label">Email address</label>
        <input type="text" class="form-control" id="shareEmail" placeholder="Enter Email here!">
        <input type="hidden" id="shareNoteId"> <!-- Hidden field to store note ID -->
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-warning w-25" onclick="shareNote()">Share</button>
      </div>
    </div>
  </div>
</div>

        <!--  Model For Note -->

        <!-- Modal -->
<div class="modal fade" id="exampleModal1" tabindex="-1" aria-labelledby="exampleModal1Label" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModal1Label">Create a New Note</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <input type="text" id="notebookName" class="form-control" placeholder="Enter note name..." />
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" id="createNotebook">Create</button>
      </div>
    </div>
  </div>
</div>
        
         <!-- Modal for NoteBook -->
        <div class="modal fade" id="exampleModal3" tabindex="-1" aria-labelledby="exampleModal3Label" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModal3Label">Create a New Notebook</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <input type="text" id="notebookName3" class="form-control" placeholder="Enter notebook name..." />
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" id="createNotebook3">Create</button>
      </div>
    </div>
  </div>
</div>
        
        
      </main>
    </div>

<!-- Include Quill.js -->
<script src="https://cdn.quilljs.com/1.3.6/quill.js"></script>
<script src="https://cdn.jsdelivr.net/npm/quill-image-resize-module@3.0.0/image-resize.min.js"></script>

<script>
  // ✅ Register Image Resize Properly
  Quill.register("modules/imageResize", window.ImageResize.default);

  // ✅ Initialize Quill Editor
  var quill = new Quill("#editor", {
      modules: {
          toolbar: "#toolbar",
          imageResize: {}, // Properly Registered
      },
      placeholder: "Start typing your notes...",
      theme: "snow",
    
  });
  quill.on("text-change", function () {
	    document.getElementById("hiddenContent").value = quill.root.innerHTML;
	});
  
  
  
  //Inserting the Task in the database.
document.getElementById('taskForm').addEventListener('submit', function (e) {
    e.preventDefault();

    const form = document.getElementById('taskForm');
    const formData = new FormData(form);

    // Get due date from form
    const dueDateValue = formData.get("due_date");
    const dueDate = new Date(dueDateValue + "T00:00:00"); // Treat as midnight of selected date

    fetch('CreateTaskServlet', {
        method: 'POST',
        body: formData
    })
    .then(response => response.text())
    .then(message => {
        alert(message);
        form.reset();

        // Hide modal
        const modalEl = document.getElementById('taskModal');
        let modalInstance = bootstrap.Modal.getInstance(modalEl);
        if (!modalInstance) {
            modalInstance = new bootstrap.Modal(modalEl);
        }
        modalInstance.hide();

        const backdrop = document.querySelector('.modal-backdrop');
        if (backdrop) backdrop.remove();
        document.body.classList.remove('modal-open');
        document.body.style = '';

        // ✅ Add to Notifications dropdown
        const notificationList = document.getElementById('notificationList');
        const li = document.createElement('li');
        li.innerHTML = `
            <span style="color:green;">✅</span>
            <span style="color:red;">Your task is created. You have to complete your task by <strong>${dueDate.toDateString()}</strong>.</span>
        `;
        notificationList.appendChild(li);

        // ⏳ Set a reminder timer for that date
        const now = new Date();
        const timeUntilDue = dueDate - now;

        if (timeUntilDue > 0) {
            setTimeout(() => {
                alert("⏰ Reminder: Your task is due today!");
            }, timeUntilDue);
        }
    })
    .catch(error => {
        console.error('Error:', error);
        alert('Something went wrong while saving the task.');
    });
});





  
 //Showing the name of all Task in Task section.
document.addEventListener("DOMContentLoaded", function () {
    const tasksList = document.getElementById('tasksList');
    if (!tasksList) {
        console.error("❌ tasksList element not found");
        return;
    }

    fetch('GetTasksServlet')
      .then(response => response.json())
      .then(data => {
        console.log("✅ Tasks fetched:", data); // Log the data to console
        tasksList.innerHTML = ''; // Clear any existing tasks
        if (data.length === 0) {
          tasksList.innerHTML = '<li>No tasks found</li>'; // Display a message if no tasks
        } else { 
          data.forEach(task => {
            const li = document.createElement('li');
            li.textContent = task.task_name;

            tasksList.appendChild(li);
          });
        }
      })
      .catch(error => {
        console.error('Error loading tasks:', error);
      });
});

  
  
  
  document.getElementById("noteForm").addEventListener("submit", function (event) {
	    event.preventDefault(); // Prevent default form submission

	    let quillEditor = document.querySelector(".ql-editor"); // Get Quill editor content
	    let hiddenInput = document.getElementById("hiddenContent");

	    if (quillEditor && hiddenInput) {
	        hiddenInput.value = quillEditor.innerHTML; // Store formatted content in hidden input
	    }

	    let title = document.getElementById("noteTitle1").value.trim();
	    let content = hiddenInput.value.trim();

	    // Debugging: Log form data
	    console.log("Submitting:", { title, content });

	    if (!title || !content) {
	        alert("Title and content cannot be empty!");
	        return; // Stop form submission
	    }

	    let formData = new FormData(this); // Create FormData object for AJAX submission

	    fetch("SaveNotes", {
	        method: "POST",
	        body: formData
	    })
	    .then(response => response.text())
	    .then(data => {
	        console.log("Server Response:", data);
	        if (data.trim() === "success") {
	            alert("Note saved successfully! 🎉");
	            // Optionally, reset the form after success
	            document.getElementById("noteForm").reset();
	            quillEditor.innerHTML = ""; // Clear Quill editor
	        } else {
	            alert("Error: Could not save note. ❌");
	        }
	    })
	    .catch(error => {
	        console.error("Fetch Error:", error);
	        alert("An error occurred while saving the note.");
	    });
	});

  
  
  
  
  
  
  document.addEventListener("DOMContentLoaded", function () {
	  fetch("/iNotebook/FetchNotes")
	    .then(response => response.json())
	    .then(notes => {
	        console.log("Fetched Notes:", notes); // Debugging
	        let notesList = document.getElementById("notesList");
	        notesList.innerHTML = ""; 

	        if (notes.error) {
	            console.error(notes.error);
	            return;
	        }

	        notes.forEach(note => {
	            console.log("Note Title:", note.title); // Debugging
	            let listItem = document.createElement("li");
	            listItem.innerHTML = `<a href="#" class="note-item" data-id="${note.id}" style="color: black; text-decoration: none;">${note.title}</a>`;
	            notesList.appendChild(listItem);
	        });
	    })
	    .catch(error => console.error("Error fetching notes:", error));

	});
  
    
  
  //When anyone click in the created notebook then its name is appear in h3 section.
  
  document.addEventListener("DOMContentLoaded", function () {
	    // Get the parent list container
	    const notebookList = document.getElementById("notebookList3");

	    // Add a click event listener to the entire list
	    notebookList.addEventListener("click", function (event) {
	        // Check if the clicked element is an <li>
	        if (event.target.tagName === "LI") {
	            // Get the text inside the clicked notebook item
	            let notebookName = event.target.textContent.trim();

	            // Update the h3 title with the notebook name
	            document.getElementById("NotebookTitle").textContent = notebookName;
	        }
	    });
	});

  
  
  
  document.addEventListener("DOMContentLoaded", function () {
	    fetch("/iNotebook/FetchNotes")
	        .then(response => response.json())
	        .then(notes => {
	            console.log("Fetched Notes:", notes);

	            let notesList = document.getElementById("notesList");
	            if (!notesList) {
	                console.error("Error: notesList element not found!");
	                return;
	            }

	            notesList.innerHTML = ""; // Clear previous notes

	            notes.forEach(note => {
	                let listItem = document.createElement("li");
	                listItem.dataset.id = note.id; // Store note ID
	                listItem.style.cursor = "pointer";

	                // Create icon element
	                let icon = document.createElement("i");
	                icon.className = "fas fa-sticky-note";
	                icon.style.marginRight = "8px";

	                // Create span for note title
	                let titleSpan = document.createElement("span");
	                titleSpan.innerText = note.title || "Untitled Note";

	                // Append icon and span to list item
	                listItem.appendChild(icon);
	                listItem.appendChild(titleSpan);

	                // Append list item to notes list
	                notesList.appendChild(listItem);
	            });
	        })
	        .catch(error => console.error("Error fetching notes:", error));
	});
  
  
  
  
  
  
  
  
  
  document.getElementById("notesList").addEventListener("click", async function (event) {
	    console.log("📌 Clicked element:", event.target);

	    let clickedListItem = event.target.closest("li");
	    if (!clickedListItem) {
	        console.error("❌ Error: No <li> element found!");
	        return;
	    }

	    let noteId = clickedListItem.dataset.id ? clickedListItem.dataset.id.trim() : "";
	    if (!noteId || isNaN(noteId)) {
	        console.error("❌ Error: Note ID is missing or invalid.");
	        return;
	    }
	    
	    

	    let url = "http://localhost:8082/iNotebook/FetchNoteDetailsServlet?noteId=" + encodeURIComponent(noteId);

	    console.log("🔗 Fetch URL:", url);

	    try {
	        let response = await fetch(url, {
	            method: "GET",
	            headers: {
	                "Accept": "application/json",
	                "Content-Type": "application/json"
	            }
	        });

	        let rawText = await response.text();
	        console.log("🔍 Raw Server Response:", rawText);

	        let note;
	        try {
	            note = JSON.parse(rawText);
	        } catch (error) {
	            console.error("❌ JSON Parse Error:", error, rawText);
	            return;
	        }

	        console.log("✅ Parsed Note Object:", note);

	        if (!note || typeof note !== "object") {
	            console.error("❌ Error: Invalid note data.");
	            return;
	        }

	        let title = note.title ? note.title : "Untitled Note";
	        let content = note.content ? note.content : "No content available";
	        let imageUrl = note.image ? note.image : "";// New: Handle image
	        let createdAt = note.created_at ? new Date(note.created_at).toLocaleString() : "N/A";
	        console.log("🖼️ Received Image Data:", note.image);

	        // 🛠 Debugging Before Rendering
	        console.log("📝 Title:", title);
	        console.log("📝 Content (HTML):", content);
	        console.log("🖼️ Image URL:", imageUrl);
	        console.log("🕒 Created At:", createdAt);
	        
	        
	        
	     // ✅ 1. Set the Title in the Input Field
	        document.getElementById("noteTitle1").value = title;
	     
	        // ✅ 2. Set the Content inside Quill Editor
	        quill.root.innerHTML = content;  // Directly set the rich-text content
	        
	        
	        if (imageUrl) {
	            let range = quill.getSelection(); // Get current cursor position
	            if (range) {
	                quill.insertEmbed(range.index, "image", imageUrl);
	            } else {
	                quill.insertEmbed(0, "image", imageUrl); // Insert at the beginning if no selection
	            }
	        }
	        
	        

	        let notesContainer = document.getElementById("notesContainer");
	        if (!notesContainer) {
	            console.error("❌ Error: #notesContainer element not found!");
	            return;
	        }

	        
	        // ✅ Create a new card for each clicked note
	        let newNoteCard = document.createElement("div");
	        newNoteCard.classList.add("card", "mt-3", "p-3", "shadow");
	        newNoteCard.dataset.id = noteId; 

	        // ✅ Use innerHTML carefully to preserve the content formatting
	        newNoteCard.innerHTML = `
	        	 <div class="note-card">
	            <div class="card-body position-relative" style="cursor:pointer;" >
	          


	                <h5 class="card-title text-primary"></h5> 
	                <div class="card-text" style="white-space: pre-wrap;"></div> 
	                <p class="text-muted">
	                    <i class="bi bi-clock"></i> Created at: <span class="note-time"></span>
	                </p>
	                <div class="note-image-container mt-2"></div>
	                
	                <!-- ✅ Fix: Move to Trash instead of Permanent Delete -->
	                <form action="MoveToTrashServlet" method="post" onsubmit="return confirmMoveToTrash(event, ${noteId});">
	                    <input type="hidden" name="noteId" value="${noteId}">
	                    <button type="submit" class="btn btn-danger btn-sm delete-note">🗑️ Move to Trash</button>
	                </form>
	            </div>
	            </div>
	        `;

	        // ✅ Set title separately
	        newNoteCard.querySelector(".card-title").textContent = title;

	        // ✅ Set content separately (with HTML support)
	        newNoteCard.querySelector(".card-text").innerHTML = content;

	        // ✅ Set created_at time separately
	        newNoteCard.querySelector(".note-time").textContent = createdAt;

	        if (imageUrl) {
	            let imageContainer = newNoteCard.querySelector(".note-image-container");
	            let imageElement = document.createElement("img");

	            // ✅ Correcting how we set the image source
	            imageElement.src = imageUrl; 
	            imageElement.alt = "Note Image";
	            imageElement.classList.add("img-fluid", "rounded", "mt-2");
	            imageElement.style.maxWidth = "50%";
	            imageElement.style.height = "auto";
	            
	            imageContainer.appendChild(imageElement);
	        }

	        
	        

	        // Append the new card instead of replacing existing content
	        notesContainer.appendChild(newNoteCard);

	        // ✅ Update note count
	        updateNoteCount();

	        // ✅ Hide `.add-note` when a card is added
	        updateNoteVisibility();

	        console.log("✅ Notes Container Updated Successfully!");

	    } catch (error) {
	        console.error("❌ Error fetching note details:", error);
	    }
	    
	    
	    
	});
  
  
  






  
  
  

  function confirmMoveToTrash(event, noteId) {
	    event.preventDefault(); // Prevent form from directly submitting

	    if (confirm("Are you sure you want to move this note to the trash?")) {
	        // Proceed with moving to trash
	        fetch("MoveToTrashServlet", {
	            method: "POST",
	            headers: { "Content-Type": "application/x-www-form-urlencoded" },
	            body: `noteId=${noteId}`
	        })
	        .then(response => response.text())
	        .then(data => {
	            console.log("🗑️ Move to Trash Response:", data);
	            alert("✅ Note moved to Trash!");

	            // ✅ Remove note from the main dashboard after moving to trash
	            document.querySelector(`[data-id="${noteId}"]`).remove();

	            // ✅ Update UI after deleting the note
	            updateNoteCount();
	            updateNoteVisibility();
	        })
	        .catch(error => console.error("❌ Error moving note to trash:", error));
	    }
	}

  
  
	// ✅ Function to update the note count
	function updateNoteCount() {
	    let notesContainer = document.getElementById("notesContainer");
	    let noteCount = document.getElementById("noteCount");

	    let totalNotes = notesContainer.getElementsByClassName("card").length;
	    noteCount.textContent = `${totalNotes} notes`;
	}

	// ✅ Function to show/hide `.add-note`
	function updateNoteVisibility() {
	    let notesContainer = document.getElementById("notesContainer");
	    let addNoteDiv = document.querySelector(".add-note");

	    if (notesContainer.children.length > 0) {
	        addNoteDiv.style.display = "none";  // Hide if notes exist
	    } else {
	        addNoteDiv.style.display = "block"; // Show if no notes
	    }
	}

	
	
	
	//MOve in trash
	document.addEventListener("click", async function (event) {
	    if (event.target.classList.contains("delete-note")) {
	        let noteCard = event.target.closest(".card");
	        let noteId = noteCard.dataset.id; // Ensure each card has a data-id attribute
	        
	        if (!noteId) {
	            console.error("Error: Note ID missing!");
	            return;
	        }

	        let url = "http://localhost:8082/iNotebook/MoveToTrashServlet?noteId=" + encodeURIComponent(noteId);
	        
	        try {
	            let response = await fetch(url, { method: "POST" });
	            if (response.ok) {
	                noteCard.remove(); // Remove note from UI after successful deletion
	                console.log(`Note ${noteId} moved to trash.`);
	            } else {
	                console.error("Failed to move note to trash.");
	            }
	        } catch (error) {
	            console.error("Error:", error);
	        }
	    }
	});
	
	
	
	

	// ✅ Run check when the page loads
	document.addEventListener("DOMContentLoaded", () => {
	    updateNoteCount();
	    updateNoteVisibility();
	});


  
	
	
	
	
	
	//Code for update notes in the database.
	
		
	
	
	// fetch the details according to card
document.addEventListener("DOMContentLoaded", function () {
    let updateBtn = document.getElementById("updateNoteBtn");

    if (!updateBtn) {
        console.error("❌ Error: Update button #updateNoteBtn not found in the DOM!");
        return;
    }

    // ✅ Click event to set note details when clicking on a card
    document.getElementById("notesContainer").addEventListener("click", function (event) {
        let clickedCard = event.target.closest(".card");

        if (!clickedCard) {
            console.error("❌ No card found!");
            return;
        }

        console.log("📌 Clicked Card:", clickedCard);

        // ✅ Extract Note Details from Card
        let noteId = clickedCard.dataset.id; // Get note ID from `data-id`
        let title = clickedCard.querySelector(".card-title").textContent.trim();
        let content = clickedCard.querySelector(".card-text").innerHTML.trim();
        let imageElement = clickedCard.querySelector(".note-image-container img");
        let imageUrl = imageElement ? imageElement.src : "";

        console.log("🆔 Note ID:", noteId);
        console.log("📝 Title:", title);
        console.log("📜 Content:", content);
        console.log("🖼️ Image URL:", imageUrl);

        // ✅ Set values in input fields
        document.getElementById("noteId").value = noteId; // Store note ID
        document.getElementById("noteTitle1").value = title;

        quill.root.innerHTML = ""; // Clear previous content
        quill.clipboard.dangerouslyPasteHTML(0, content); // Insert content safely

        if (imageUrl) {
            setTimeout(() => {
                let range = quill.getSelection();
                if (range) {
                    quill.insertEmbed(range.index, "image", imageUrl);
                } else {
                    quill.insertEmbed(0, "image", imageUrl);
                }
            }, 100);
        }

        console.log("✅ Note ID set in hidden input:", document.getElementById("noteId").value);
        // ✅ Show Update Button
        let updateBtn = document.getElementById("updateNoteBtn");
        updateBtn.style.display = "block";
    });

    // ✅ Click event for "Update" button
    updateBtn.addEventListener("click", async function () {
        console.log("🔄 Update button clicked!");

        let noteId = document.getElementById("noteId").value.trim();
        let title = document.getElementById("noteTitle1").value.trim();
        let content = quill.root.innerHTML.trim();
        let fileInput = document.getElementById("fileInput");
        let file = fileInput.files.length > 0 ? fileInput.files[0] : null;

        console.log("📌 Debugging Values:");
        console.log("🆔 Note ID before update:", noteId);
        console.log("📝 Title:", title);
        console.log("📜 Content:", content);
     //   console.log("Image",file);

        // ✅ Ensure content is not just an empty <p> tag or whitespace
        if (!noteId || !title || content === "" || content === "<p><br></p>") {
            alert("⚠️ Note ID, Title, and Content are required!");
            return;
        }

        let formData = new FormData();
        formData.append("noteId", noteId);
        formData.append("title", title);
        formData.append("content", content);
        if (file) {
            console.log("🖼️ File selected for update:", file.name);
            formData.append("file", file);
        } else {
            console.log("⚠️ No new file selected, keeping the old one.");
        }

        try {
            let response = await fetch("/iNotebook/UpdateNoteServlet", {
                method: "POST",
                body: formData
            });

            let result = await response.text();
            console.log("🔍 Server Response:", result);

            if (result.trim() === "success") {
                alert("✅ Note updated successfully!");
                updateNoteInUI(noteId, title, content);
            } else {
                alert("❌ Failed to update note. Please try again.");
            }
        } catch (error) {
            console.error("❌ Error updating note:", error);
        }
    });
});



//Update UI After Saving


function updateNoteInUI(noteId, title, content) {
let noteCard = document.querySelector(`.card[data-id='${noteId}']`);
if (noteCard) {
    noteCard.querySelector(".card-title").textContent = title;
    noteCard.querySelector(".card-text").innerHTML = content;
    console.log("🔄 UI updated successfully for note:", noteId);
} else {
    console.warn("⚠️ Warning: Note card not found for UI update!");
}
}
	

	
	
	
	
	
	
	
	
	
  
  
  

 
  let currentNoteId = null; // Store the currently selected note

  function loadNote(noteId) {
      let selectedNote = notesData.find(note => note.id === noteId);
      if (!selectedNote) return;

      // Update title
      document.getElementById("noteTitle").value = selectedNote.title;

      // Update description in Quill Editor
      quill.root.innerHTML = selectedNote.description;

      currentNoteId = noteId; // Update the current note ID
  }

 
  // Function to check if the rich text editor is disabled
  function isEditorDisabled() {
      let richTextContainer = document.querySelector(".rich-text-container");
      return richTextContainer && richTextContainer.style.pointerEvents === "none";
  }

  // Function to handle file selection
  function handleFileImport(event, type) {
      if (isEditorDisabled()) {
          alert("Please select a note first before uploading a file.");
          return;
      }

      let file = event.target.files[0]; // Get selected file
      if (!file) return; // If no file selected, do nothing

      let reader = new FileReader();

      if (type === "file" && (file.type === "text/plain" || file.type === "text/markdown")) {
          reader.onload = function (e) {
              let textContent = e.target.result;
              let range = quill.getSelection();
              quill.insertText(range ? range.index : quill.getLength(), textContent);
          };
          reader.readAsText(file);
      } 
      else if (type === "image" && file.type.startsWith("image/")) {
          reader.onload = function (e) {
              let imageUrl = e.target.result;
              let range = quill.getSelection();
              quill.insertEmbed(range ? range.index : quill.getLength(), "image", imageUrl);
              
              // Allow typing after image insertion
              setTimeout(() => quill.setSelection(quill.getLength()), 100);
          };
          reader.readAsDataURL(file);
      } 
      else {
          alert("Invalid file type selected.");
      }
  }

  // Hidden inputs for file & image
  let fileInput = document.createElement("input");
  fileInput.type = "file";
  fileInput.accept = "text/plain,text/markdown";
  fileInput.style.display = "none";
  fileInput.addEventListener("change", (event) => handleFileImport(event, "file"));

  let imageInput = document.createElement("input");
  imageInput.type = "file";
  imageInput.accept = "image/*";
  imageInput.style.display = "none";
  imageInput.addEventListener("change", (event) => handleFileImport(event, "image"));

  // Attach event listeners
  document.getElementById("fileUploadBtn").addEventListener("click", function (event) {
      event.preventDefault();
      fileInput.click();
  });

  document.getElementById("imageUploadBtn").addEventListener("click", function (event) {
      event.preventDefault();
      imageInput.click();
  });

  // Attach click event to each note
  document.querySelectorAll(".note-item").forEach(note => {
      note.addEventListener("click", function () {
          let noteId = this.getAttribute("data-id");
          loadNote(noteId);
      });
  });
  
   
      //Function for update the notes count 
      
      function updateNoteCount() {
    	    let notesContainer = document.getElementById("notesContainer");
    	    let noteCountText = document.getElementById("noteCount"); // The <p> element

    	    let count = notesContainer.children.length; // Count the number of notes
    	    noteCountText.textContent = `${count} notes`; // Update the text
    	}
      
     
      
   // Function to enable the rich text editor when a note or list item is clicked
      function enableRichTextEditor(noteTitle) {
          let richTextContainer = document.querySelector(".rich-text-container");

          // Enable the rich text editor
          richTextContainer.style.pointerEvents = "auto";
          richTextContainer.style.opacity = "1";

          // Set the note title inside the editor input field
          let noteTitleInput = document.querySelector(".note-title");
          noteTitleInput.value = noteTitle; // Set title from the clicked note
      }

      // Add click event listener to #notesContainer (for note cards)
      document.getElementById("notesContainer").addEventListener("click", function (event) {
          let clickedNote = event.target.closest(".note-card");
          if (clickedNote) {
              let noteTitle = clickedNote.querySelector(".card-title").textContent.trim();
              enableRichTextEditor(noteTitle);
          }
      });

      // Add click event listener to #notesList (for li elements)
      document.getElementById("notesList").addEventListener("click", function (event) {
          let clickedListItem = event.target.closest("li"); // Check if an <li> is clicked
          if (clickedListItem) {
              let noteTitle = clickedListItem.querySelector("span").textContent.trim();
              enableRichTextEditor(noteTitle);
          }
      });

      
      document.getElementById("createNotebook").addEventListener("click", function () {
    	    let notebookInput = document.getElementById("notebookName");
    	    let notebookName = notebookInput.value.trim();

    	    if (notebookName === "") {
    	        alert("Please enter a notebook name.");
    	        return;
    	    }

    	    let notesContainer = document.getElementById("notesContainer");
    	    let newNote1 = document.createElement("div");

    	    newNote1.classList.add("note-card");
    	    newNote1.innerHTML = `
    	        <div class="card p-2 m-2" style="border: 1px solid #ddd; border-radius: 10px;
    	        box-shadow: 5px 5px 15px rgba(0, 0, 0, 0.3); transition: all 0.3s ease-in-out;cursor:pointer;">
    	            <div class="card-body">
    	                <h5 class="card-title"></h5> <!-- Title set separately -->
    	                <p class="card-text text-muted">${notebookName}</p>
    	            </div>
    	        </div>
    	    `;

    	    // Set title text separately
    	    //newNote1.querySelector(".card-text").textContent = notebookName;
    	    newNote1.querySelector(".card-title").textContent = notebookName;
    	    
    	    notesContainer.appendChild(newNote1);
    	    updateNoteCount(); // Update note count

    	    // Hide the "add-note" section since a note is now present
    	    document.querySelector(".add-note").style.display = "none";

    	    let notesList = document.getElementById("notesList");
    	    let newNote = document.createElement("li");

    	    // Create an icon
    	    let icon = document.createElement("i");
    	    icon.className = "fas fa-sticky-note";

    	    // Create a span for text and assign notebookName
    	    let textSpan = document.createElement("span");
    	    textSpan.textContent = notebookName;
    	    textSpan.style.display = "inline-block";
    	    textSpan.style.color = "#000";

    	    newNote.appendChild(icon);
    	    newNote.appendChild(textSpan);

    	    // Apply styles for better visibility
    	    newNote.style.cursor = "pointer";
    	    newNote.style.display = "flex";
    	    newNote.style.alignItems = "center";
    	    newNote.style.gap = "8px";
    	    newNote.style.padding = "8px 12px";
    	    newNote.style.margin = "5px 0";
    	    newNote.style.border = "1px solid #28a745"; // Green border
    	    newNote.style.backgroundColor = "#d4edda"; // Light green background
    	    newNote.style.borderRadius = "5px";

    	    notesList.appendChild(newNote);

    	    var modal = bootstrap.Modal.getInstance(document.getElementById("exampleModal1"));
    	    modal.hide();

    	    notebookInput.value = ""; // Clear input field
    	});




      function checkNotesVisibility() {
    	    let notesContainer = document.getElementById("notesContainer");
    	    let addNoteElements = document.querySelectorAll(".add-note > *"); // Select all child elements of .add-note

    	    addNoteElements.forEach((element) => {
    	        // Keep the "+ New Note" link visible, hide the rest
    	        if (element.matches('a[data-bs-toggle="modal"]')) {
    	            element.style.display = "block"; // Keep + New Note visible
    	        } else {
    	            element.style.display = notesContainer.children.length === 0 ? "block" : "none"; // Hide rest
    	        }
    	    });
    	}

      function removeNote(noteElement) {
    	    noteElement.remove();
    	    checkNotesVisibility();
    	    updateNoteCount();
    	}
      
      
      
  
      
      document.addEventListener("DOMContentLoaded", function () {
    	    let selectedNotebook = ""; // Stores the currently selected notebook name

    	    // ✅ Function to Load Notebooks from Database
    	    function loadNotebooks() {
    	        fetch("GetNotebooksServlet")
    	            .then(response => response.text())
    	            .then(data => {
    	                let notebookList3 = document.getElementById("notebookList3");
    	                notebookList3.innerHTML = data; // Update UI with fetched notebooks
    	            })
    	            .catch(error => console.error("Error loading notebooks:", error));
    	    }

    	    // ✅ Call function to load notebooks when page loads
    	    loadNotebooks();

    	    
    	    // ✅ Create New Notebook and Update UI
    	    document.getElementById("createNotebook3").addEventListener("click", function () {
    	        let notebookInput3 = document.getElementById("notebookName3");
    	        let notebookName3 = notebookInput3 ? notebookInput3.value.trim() : "";

    	        if (notebookName3 === "") {
    	            alert("Please enter a notebook name.");
    	            return;
    	        }

    	        // ✅ Send notebook name to servlet
    	        fetch("SaveNotebook", {
    	            method: "POST",
    	            headers: { "Content-Type": "application/x-www-form-urlencoded" },
    	            body: "notebookName=" + encodeURIComponent(notebookName3),
    	        })
    	        .then(response => response.text())
    	        .then(data => {
    	            if (data === "Success") {
    	                // ✅ Reload notebooks from the database
    	                loadNotebooks();
    	                document.addEventListener("DOMContentLoaded", function () {
    	                    let modalElement = document.getElementById("exampleModal3");
    	                    if (modalElement) {
    	                        let modal = bootstrap.Modal.getInstance(modalElement);
    	                        modal.hide();
    	                    } else {
    	                        console.warn("Warning: Modal with ID 'exampleModal3' not found in the DOM.");
    	                    }
    	                });
    	                // ✅ Clear input field
    	                notebookInput3.value = "";
    	            } else if (data === "SessionExpired") {
    	                alert("Session expired. Please log in again.");
    	                window.location.href = "login.jsp"; // Redirect to login page
    	            } else {
    	                alert("Error saving notebook. Try again.");
    	            }
    	        })
    	        .catch(error => console.error("Error:", error));
    	    });

    	    // ✅ Click event for "+New Note" to create a note inside the selected notebook
    	    document.getElementById("createNote").addEventListener("click", function () {
    	        if (!selectedNotebook) {
    	            alert("Please select a notebook first!");
    	            return;
    	        }

    	        let noteInput = document.getElementById("noteName"); // Input field for note name
    	        let noteName = noteInput ? noteInput.value.trim() : "";

    	        if (noteName === "") {
    	            alert("Please enter a note name.");
    	            return;
    	        }

    	        let notesList = document.getElementById("notesList");
    	        if (!notesList) {
    	            console.error("Notes list element not found!");
    	            return;
    	        }

    	        let newNote = document.createElement("li");

    	        // Create a span for text
    	        let noteTextSpan = document.createElement("span");
    	        noteTextSpan.textContent = noteName;
    	        noteTextSpan.style.color = "#000";

    	        // Append elements inside li
    	        newNote.appendChild(noteTextSpan);

    	        // Apply styles for better visibility
    	        newNote.style.cursor = "pointer";
    	        newNote.style.padding = "8px";
    	        newNote.style.margin = "5px 0";
    	        newNote.style.border = "1px solid gray";
    	        newNote.style.borderRadius = "5px";
    	        newNote.style.backgroundColor = "#f0f0f0";

    	        document.addEventListener("click", function (event) {
    	            if (event.target.id === "notebookList3") {
    	                document.getElementById("NotebookTitle").textContent = event.target.textContent.trim();
    	            }
    	        });


    	        // Append the note to the notes list
    	        notesList.appendChild(newNote);

    	        // Clear the input field
    	        if (noteInput) {
    	            noteInput.value = "";
    	        }
    	    });
    	    
    	    

    	});
      
      
      document.getElementById("searchInput").addEventListener("input", function () {
    	    let searchQuery = this.value.toLowerCase().trim();

    	    let notes = document.querySelectorAll(".note-card"); // Selecting all notes
    	    let notebooks = document.querySelectorAll("#notebookList3 li"); // Selecting all notebooks

    	    let hasMatch = false;

    	    // Filter Notes (Cards)
    	    notes.forEach((note) => {
    	        let title = note.querySelector(".card-title").innerText.toLowerCase();
    	        let content = note.querySelector(".card-text").innerText.toLowerCase();
    	        
    	        if (title.includes(searchQuery) || content.includes(searchQuery)) {
    	            note.style.display = "block"; // Show matching notes
    	            hasMatch = true;
    	        } else {
    	            note.style.display = "none"; // Hide non-matching notes
    	        }
    	    });

    	    // Filter Notebooks (List Items)
    	    notebooks.forEach((notebook) => {
    	        let notebookName = notebook.innerText.toLowerCase().trim();

    	        if (notebookName.includes(searchQuery)) {
    	            notebook.style.display = "block"; // Show matching notebooks
    	            hasMatch = true;
    	        } else {
    	            notebook.style.display = "none"; // Hide non-matching notebooks
    	        }
    	    });

    	    // If no match, you can show a message (optional)
    	    let noResults = document.getElementById("noResults");
    	    if (hasMatch) {
    	        noResults.style.display = "none";
    	    } else {
    	        noResults.style.display = "block"; // Show message if nothing matches
    	    }
    	});


      fetch('/getSharedWithMe')
      .then(response => response.text()) // Use .text() instead of .json() to inspect the raw response
      .then(data => {
        console.log('Raw response:', data); // Log the raw response to check its content
        try {
          const jsonData = JSON.parse(data);
          console.log('Parsed data:', jsonData);
          // Handle the response here...
        } catch (error) {
          console.error('Error parsing JSON:', error);
        }
      })
      .catch(error => console.error('Error fetching shared notes:', error));

      
      
      
      //Showing the all the files in file section
      async function fetchFiles() {
    	    try {
    	        let response = await fetch("http://localhost:8082/iNotebook/FetchFiles");
    	        let files = await response.json();

    	        let filesList = document.getElementById("filesList");
    	        filesList.innerHTML = ""; // Clear previous list

    	        if (files.length === 0) {
    	            filesList.innerHTML = "<li>No files found</li>";
    	            return;
    	        }

    	        files.forEach(file => {
    	            let listItem = document.createElement("li");

    	            let fileImage = document.createElement("img");
    	            fileImage.src = "data:image/jpeg;base64," + file.file_path;
    	            fileImage.style.width = "100px"; // Set image size
    	            fileImage.style.height = "100px";
    	            fileImage.style.cursor = "pointer";

    	            // Open full image in a new tab on click
    	            fileImage.onclick = function () {
    	                window.open(fileImage.src, "_blank");
    	            };

    	            listItem.appendChild(fileImage);
    	            filesList.appendChild(listItem);
    	        });

    	    } catch (error) {
    	        console.error("Error fetching files:", error);
    	    }
    	}
    	// Call fetchFiles when the page loads
    	document.addEventListener("DOMContentLoaded", fetchFiles);
    </script>

   <script
  src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
  integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
  crossorigin="anonymous"
></script>
</body>
</html>