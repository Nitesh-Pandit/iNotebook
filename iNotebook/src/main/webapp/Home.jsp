<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<!DOCTYPE html>
<html lang="en">


<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Notebook App</title>
    
    <!--
    <link rel="stylesheet" href="styles.css">
    -->
    <link href="https://cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

     <link rel="stylesheet" type="text/css" href="css/Home.css">
</head>

<body>





    <div class="container">
        <aside class="sidebar">
            <div class="container">
              <div class="profile-container dropdown" style="cursor: pointer;">
                <div
                  class="avatar"
                  id="profileDropdown"
                  data-bs-toggle="dropdown"
                  aria-expanded="false"
                >
                  S
                </div>
                 <strong>sonikumar12345abc@gmail.com</strong><br />
                 <br>
                 <br>
                <ul
                  class="dropdown-menu dropdown-menu-end"
                  aria-labelledby="profileDropdown"
                >
                  <li class="dropdown-header">ACCOUNT</li>
                  <li class="px-3">
                    <strong>sonikumar12345abc</strong><br />
                    <small>sonikumar12345abc@gmail.com</small>
                  </li>
                  <hr />
                  <li>
                    <a class="dropdown-item" href="#" 
                      ><i class="fas fa-user"></i> Account info...</a
                    >
                  </li>
                  <li>
                    <a class="dropdown-item" href="#"
                      ><i class="fas fa-cog"></i> Settings</a
                    >
                  </li>
                  <li>
                    <a class="dropdown-item" href="#"
                      ><i class="fas fa-bell"></i> Notifications</a
                    >
                  </li>
                  <hr />
                  <li>
                    <a class="dropdown-item" href="#"
                      ><i class="fas fa-question-circle"></i> Need help?</a
                    >
                  </li>
                  <hr />
                  <li>
                    <a class="dropdown-item text-danger" href="#"
                      ><i class="fas fa-sign-out-alt"></i> Sign out</a
                    >
                  </li>
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
                  data-bs-target="#exampleModal1"
                >
                  <i class="fas fa-book"></i> NoteBook
                </a>
                  </li>
                  <hr />
                  <li>
                    <a class="dropdown-item" href="#"
                      ><i class="fas fa-file"></i> File</a
                    >
                  </li>
                  <hr />
                  <li>
                    <a class="dropdown-item" href="#"
                      ><i class="fas fa-image"></i> Image</a
                    >
                  </li>
                  <hr />
                  <li>
                    <a class="dropdown-item" href="#"
                      ><i class="fas fa-paint-brush"></i> Sketch</a
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
                  ><a href="home.html" style="color: black; text-decoration: none">
                    Home</a
                  >
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
              <img src="images/istoc.png" alt="Notebook Icon" />
              <p><strong>Write Your notes Here!</strong></p>
            </div>
          </aside>




        <main class="content">
            <p>Get Ready to takes notes</p>
            <h3>Sonikumari345atebac's Home</h3>
            <div class="add-note">
                <img src="images/nonotes.png" alt="Note Icon">
                <p><strong>No Any notes Found here!</strong></p>

            </div>



<!-- Modal for Notebook -->
        <div
          class="modal fade"
          id="exampleModal1"
          tabindex="-1"
          aria-labelledby="exampleModalLabel"
          aria-hidden="true"
        >
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">
                <h1 class="modal-title fs-5" id="exampleModalLabel">
                  Create Notebook
                </h1>
                <button
                  type="button"
                  class="btn-close"
                  data-bs-dismiss="modal"
                  aria-label="Close"
                ></button>
              </div>
              <div class="modal-body">
                <label for="text" class="form-label" style="margin-right:760px;">Name</label>
                <input
                  type="text"
                  class="form-control"
                  id="Notebook Name"
                  placeholder="Note........."
                />
              </div>
              <div class="modal-footer">
                <button
                  type="button"
                  class="btn btn-secondary"
                  data-bs-dismiss="modal"
                >
                  Close
                </button>
                <button type="button" class="btn btn-warning">Create</button>
              </div>
            </div>
          </div>
        </div>


            <!--  Model  -->

            <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel"
                aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5" id="exampleModalLabel">Create Notebook</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <input type="text" placeholder="Enter Notebook Name">
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            <button type="button" class="btn btn-warning">Save</button>
                        </div>
                    </div>
                </div>
            </div>


            <div class="d-flex">
                <div class="card border-success mb-3 mx-2" style="max-width: 18rem;">
                    <div class="card-header">My First Notes</div>
                    <div class="card-body text-success">
                        <h5 class="card-title">Success card title</h5>
                        <p class="card-text">Some quick example text to build on the card title and make up the bulk of
                            the card's content.</p>
                    </div>
                </div>
                <br>

                <div class="card border-success mb-3 mx-2" style="max-width: 18rem;">
                    <div class="card-header">Header</div>
                    <div class="card-body text-secondary">
                        <h5 class="card-title">No tittle</h5>
                        <p class="card-text"><span class="new-note"><b>+ Click Here!</b></span> to create notes.After
                            Creation you can Update Delete and Edit Notes any time When you want..</p>
                    </div>
                </div>
                <br>
            </div>
        </main>

        <script>
            document.getElementById("openSketch").addEventListener("click", function () {
                window.open("https://excalidraw.com/", "_blank");
            });
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>

</body>

</html>