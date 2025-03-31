<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
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
   
</head>

<body>




    <div class="container">
        <aside class="sidebar">
            <div class="container">
                <div class="profile-container dropdown">
                    <div class="avatar" id="profileDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                        S
                    </div>
                    <strong>sonikumar12345abc@gmail.com</strong><br />
                    <br />
                    <br />
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="profileDropdown">
                        <li class="dropdown-header">ACCOUNT</li>
                        <li class="px-3">
                            <strong>sonikumar12345abc</strong><br />
                            <small>sonikumar12345abc@gmail.com</small>
                        </li>
                        <hr />
                        <li>
                            <a class="dropdown-item" href="#"><i class="fas fa-user"></i> Account info...</a>
                        </li>
                        <li>
                            <a class="dropdown-item" href="#"><i class="fas fa-cog"></i> Settings</a>
                        </li>
                        <li>
                            <a class="dropdown-item" href="#"><i class="fas fa-bell"></i> Notifications</a>
                        </li>
                        <hr />
                        <li>
                            <a class="dropdown-item" href="#"><i class="fas fa-question-circle"></i> Need help?</a>
                        </li>
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
                    <li><i class="fas fa-calendar"></i> Calendar</li>
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
        <button type="button" class="btn btn-light btn-sm" style="width: 25%; color: blue" data-bs-toggle="modal" data-bs-target="#exampleModal">
            Share
        </button>
    </div>
    <p style="margin-right: 200px; font-weight: 600"> notes</p>
            <div class="add-note">
                <div class="slider1">
 
 				
 
 
                    <div class="card my-3">
                        <div class="card-header">
                            <div style="display: flex; justify-content: space-between">
                                <p style="margin-left: 90px; margin-top: 10px">
                                  <b>Untittle</b>
                                </p>
                               
                                <input type="hidden" name="note_id" value="All the notes appear here" />
                                <button type="submit" class="btn btn-outline-danger" style="width: 75px; height: 40px">
                                    Delete
                                </button>
                           
                            </div>
                        </div>
                        <div class="card-body">
                            <p class="card-text">
                               All the card is created using css and html but some of there are not crated
                            </p>
                        </div>
                        <div class="card-footer">
                            <small class="text-body-secondary">7th march</small>
                        </div>
                    </div>
                     
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
                            <input type="text" class="form-control" id="Email Name" placeholder="Enter Email here!" />
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-warning w-25">
                                Send Invite
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
        var quill = new Quill("#editor", {
            modules: {
                toolbar: "#toolbar",
            },
            placeholder: "Start typing your notes...",
            theme: "snow",
        });
       

    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
</body>

</html>