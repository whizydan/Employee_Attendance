<%@page import="java.util.List"%>
<%@page import="com.kerberos.kopitiam.Products"%>
<%@page import="com.kerberos.kopitiam.SessionManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.kerberos.kopitiam.DatabaseManager"%>
<%
    String email = (String) new SessionManager().getSessionAttribute(request,"email");
    DatabaseManager db = new DatabaseManager();
    List<Products> productsExpired = db.getExpiredProducts();
    List<Products> fewProducts = db.getFewProducts();
    ResultSet result = db.executeQuery("select * from users where email = '"+email+"'");
    String photo = "product9.jpg";
    while(result.next()){
        photo = result.getString("photo");
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
<meta name="description">
<meta name="keywords" content="admin, estimates, bootstrap, business, corporate, creative, management, minimal, modern,  html5, responsive">
<meta name="author" content="kerberos">
<meta name="robots" content="noindex, nofollow">
<title>Verify</title>

<link rel="shortcut icon" type="image/x-icon" href="assets/img/favicon.png">

<link rel="stylesheet" href="assets/css/bootstrap.min.css">

<link rel="stylesheet" href="assets/css/animate.css">

<link rel="stylesheet" href="assets/css/dataTables.bootstrap4.min.css">

<link rel="stylesheet" href="assets/plugins/fontawesome/css/fontawesome.min.css">
<link rel="stylesheet" href="assets/plugins/fontawesome/css/all.min.css">

<link rel="stylesheet" href="assets/css/style.css">
<script>
var imageCapture;
onGetUserMediaButtonClick();

function onGetUserMediaButtonClick() {
  navigator.mediaDevices.getUserMedia({video: true})
  .then(mediaStream => {
    document.querySelector('video').srcObject = mediaStream;

    const track = mediaStream.getVideoTracks()[0];
    imageCapture = new ImageCapture(track);
  })
  .catch(error => ChromeSamples.log(error));
}

function onGrabFrameButtonClick() {
  imageCapture.grabFrame()
  .then(imageBitmap => {
    const canvas = document.querySelector('#grabFrameCanvas');
    drawCanvas(canvas, imageBitmap);
  })
  .catch(error => ChromeSamples.log(error));
}

function onTakePhotoButtonClick() {
  imageCapture.takePhoto()
  .then(blob => createImageBitmap(blob))
  .then(imageBitmap => {
    const canvas = document.querySelector('#takePhotoCanvas');
    drawCanvas(canvas, imageBitmap);
  })
  .catch(error => ChromeSamples.log(error));
  
  const canvas = document.getElementById("takePhotoCanvas");
  const context = canvas.getContext("2d");
  const imageDataUrl = canvas.toDataURL("image/jpeg");
  //postImageToServer(imageDataUrl);
  var image = document.getElementById("image");
  image.value = imageDataUrl;
}

/* Utils */

function getCookie(cookieName) {
    const name = cookieName + "=";
    const decodedCookie = decodeURIComponent(document.cookie);
    const cookieArray = decodedCookie.split(";");

    for (let i = 0; i < cookieArray.length; i++) {
        let cookie = cookieArray[i];
        while (cookie.charAt(0) === " ") {
            cookie = cookie.substring(1);
        }
        if (cookie.indexOf(name) === 0) {
            return cookie.substring(name.length, cookie.length);
        }
    }
    return "";
}

function postImageToServer(imageDataUrl) {
    const url = "VerifyServlet"; // Replace with your server's URL

    // Create a FormData object and append the image data
    const formData = new FormData();
    formData.append("image", dataURItoBlob(imageDataUrl), "image.jpg"); // Change "image.jpg" to the desired filename
    formData.append("email",getCookie("email"));
    // Send the FormData to the server using a POST request
    fetch(url, {
        method: "POST",
        body: formData
    })
    .then(response => {
        if (response.ok) {
            // Handle a successful response from the server
            console.log("Image successfully posted to the server.");
        } else {
            // Handle errors
            console.error("Failed to post the image to the server.");
        }
    })
    .catch(error => {
        console.error("Error: " + error);
    });
}


function dataURItoBlob(dataURI) {
    const byteString = atob(dataURI.split(",")[1]);
    const ab = new ArrayBuffer(byteString.length);
    const ia = new Uint8Array(ab);
    for (let i = 0; i < byteString.length; i++) {
        ia[i] = byteString.charCodeAt(i);
    }
    return new Blob([ab], { type: "image/jpeg" }); // Change the type as needed
}


function drawCanvas(canvas, img) {
  canvas.width = getComputedStyle(canvas).width.split('px')[0];
  canvas.height = getComputedStyle(canvas).height.split('px')[0];
  let ratio  = Math.min(canvas.width / img.width, canvas.height / img.height);
  let x = (canvas.width - img.width * ratio) / 2;
  let y = (canvas.height - img.height * ratio) / 2;
  canvas.getContext('2d').clearRect(0, 0, canvas.width, canvas.height);
  canvas.getContext('2d').drawImage(img, 0, 0, img.width, img.height,
      x, y, img.width * ratio, img.height * ratio);
}

document.querySelector('video').addEventListener('play', function() {
  document.querySelector('#grabFrameButton').disabled = false;
  document.querySelector('#takePhotoButton').disabled = false;
});
</script>
</head>
<body>
<div id="global-loader">
<div class="whirly-loader"> </div>
</div>

<div class="main-wrapper">

<div class="header">

<div class="header-left active">
<a href="index.jsp" class="logo">
<img src="assets/img/logo.png" alt="">
</a>
<a href="index.jsp" class="logo-small">
<img src="assets/img/logo-small.png" alt="">
</a>
<a id="toggle_btn" href="javascript:void(0);">
</a>
</div>

<a id="mobile_btn" class="mobile_btn" href="#sidebar">
<span class="bar-icon">
<span></span>
<span></span>
<span></span>
</span>
</a>

<ul class="nav user-menu">



<li class="nav-item dropdown has-arrow flag-nav">
<a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="javascript:void(0);" role="button">
<img src="assets/img/flags/us1.png" alt="" height="20">
</a>
<div class="dropdown-menu dropdown-menu-right">
<a href="javascript:void(0);" class="dropdown-item">
<img src="assets/img/flags/us.png" alt="" height="16"> English
</a>
</div>
</li>


<li class="nav-item dropdown">
<a href="javascript:void(0);" class="dropdown-toggle nav-link" data-bs-toggle="dropdown">
<img src="assets/img/icons/notification-bing.svg" alt="img"> <span class="badge rounded-pill"><%=productsExpired.size()+fewProducts.size()%></span>
</a>
<div class="dropdown-menu notifications">
<div class="topnav-dropdown-header">
<span class="notification-title">Notifications</span>
</div>
<div class="noti-content">
<ul class="notification-list">

<% 
        
        if (productsExpired != null && !productsExpired.isEmpty()) {
            for (Products item : productsExpired) {
        %>
        <li class="notification-message">
        
        <div class="media d-flex">
        <span class="avatar flex-shrink-0">
            <img alt="" src="assets/img/product/<%=item.getPhoto()%>">
        </span>
        <div class="media-body flex-grow-1">
        <p class="noti-details"><span class="noti-title">Product</span> <%=item.getName()%><span class="noti-title"> has expired, please delete it!</span></p>
        <p class="noti-time"><span class="notification-time">Just now</span></p>
        </div>
        </div>
        </a>
        </li>
        <%
            }
        }
        %>
        <%
        if (fewProducts != null && !fewProducts.isEmpty()) {
            for (Products item : fewProducts) {
        %>
        <li class="notification-message">
        <a href="activities.jsp?id=<%= item.getId() %>">
        <div class="media d-flex">
        <span class="avatar flex-shrink-0">
            <img alt="" src="assets/img/product/<%=item.getPhoto()%>">
        </span>
        <div class="media-body flex-grow-1">
        <p class="noti-details"><span class="noti-title">Product</span> <%=item.getName()%><span class="noti-title"> is almost being completed</span></p>
        <p class="noti-time"><span class="notification-time">Just now</span></p>
        </div>
        </div>
        </a>
        </li>
        <%
            }
        }
        %>

</ul>
</div>
</div>
</li>

<li class="nav-item dropdown has-arrow main-drop">
<a href="javascript:void(0);" class="dropdown-toggle nav-link userset" data-bs-toggle="dropdown">
<span class="user-img"><img src="assets/img/profiles/avator1.jpg" alt="">
<span class="status online"></span></span>
</a>
<div class="dropdown-menu menu-drop-user">
<div class="profilename">
<div class="profileset">
<span class="user-img"><img src="assets/img/profiles/avator1.jpg" alt="">
<span class="status online"></span></span>
<div class="profilesets">
<h6><%=new SessionManager().getSessionAttribute(request,"email")%></h6>
<h5>Admin</h5>
</div>
</div>
<hr class="m-0">
<a class="dropdown-item" href="profile.jsp"> <i class="me-2" data-feather="user"></i> My Profile</a>
<hr class="m-0">
<a class="dropdown-item logout pb-0" href="logout.jsp"><img src="assets/img/icons/log-out.svg" class="me-2" alt="img">Logout</a>
</div>
</div>
</li>
</ul>


<div class="dropdown mobile-user-menu">
<a href="javascript:void(0);" class="nav-link dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false"><i class="fa fa-ellipsis-v"></i></a>
<div class="dropdown-menu dropdown-menu-right">
</div>
</div>

</div>

<div class="page-wrapper pagehead">
<div class="content">
<div class="page-header">
<div class="row">
<div class="col-sm-12">
<h3 class="page-title">Verify</h3>
<ul class="breadcrumb">
<li class="breadcrumb-item"><a href="index.html">SignIn</a></li>
<li class="breadcrumb-item active">Verify Attendance</li>
</ul>
</div>
</div>
</div>
<div class="row">
<div class="col-sm-12">
  <form action="VerifyServlet" method="post" enctype="multipart/form-data">
  <div class="card" id='results'>
  <div class="card-header text-center">
    <video autoplay></video>
  </div>
  <div class="card-footer">
      <div class="container">
        <div class="row flex text-center">
            <div class="col-sm-6">
                <!-- First Column Content -->
                <p>This is the original image</p><br>
                <image src="assets/img/product/<%=photo%>"/>
            </div>
            <div class="col-sm-6">
                <!-- Second Column Content -->
                <p>This is the current image</p><br>
                <canvas id='takePhotoCanvas'></canvas>
            </div>
        </div>
    </div>
  </div>
  <input hidden name="email" type="text" value="<%=email%>"/>
  <input hidden id="image" type="text" name="image"/>
  <div class="card-body text-center">
      <button type="submit" class="btn btn-primary" id='takePhotoButton'>Click to capture verification image when ready</button>  
  </div>
</div>
</form>
</div>
</div>
</div>
</div>
</div>
</div>

<script>
  document.querySelector('#takePhotoButton').addEventListener('mouseover', onTakePhotoButtonClick);
  document.querySelector('#takePhotoButton').addEventListener('click', onTakePhotoButtonClick);
</script>
<script src="assets/js/jquery-3.6.0.min.js"></script>

<script src="assets/js/feather.min.js"></script>

<script src="assets/js/jquery.slimscroll.min.js"></script>

<script src="assets/js/bootstrap.bundle.min.js"></script>

<script src="assets/js/script.js"></script>
</body>
</html>