<!DOCTYPE html>
<html lang="en">

<head>

  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>Ahmedabad University</title>

  <!-- Custom fonts for this theme -->
   <link href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" rel="stylesheet">
  <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic" rel="stylesheet" type="text/css">
  <!-- Theme CSS -->
  <link href="css/freelancer.min.css" rel="stylesheet">
<style type="text/css">
.bg-secondary {
  background-color: #60a3bc !important;
}
.bg-primary {
    background-color: #60a3bc !important;
}

b{
color:#000000;
font-size:20px;
}
.form-control{
color:#000;
}
.btn-file {
  position: relative;
  overflow: hidden;
}
.btn-file input[type=file] {
  position: absolute;
  top: 0;
  right: 0;
  min-width: 100%;
  min-height: 100%;
  font-size: 100px;
  text-align: right;
  filter: alpha(opacity=0);
  opacity: 0;
  background: red;
  cursor: inherit;
  display: block;
}
input[readonly] {
  background-color: white !important;
  cursor: text !important;
}
.s{
margin-top:30px;
}
.masthead {
    padding-top: calc(6rem + 74px);
    padding-bottom: 0rem;
}


</style>

<script type="text/javascript" src="js/jquery-3.2.1.min.js"></script>
<script>
function logOut(){
	$.post('Controller',
			{
				btn: 'LogOut',
			},
			function(data,status){
				if(data == 'done'){
					window.location.href = 'Login.jsp' ;
				}
	});
}
$(document).ready(function(){
	
	$('input[type="file"]').change(function(){
        var file = document.getElementById("fi").files[0];
		if (file) {
    		var reader = new FileReader();
    		reader.readAsText(file, "UTF-8");
    		reader.onload = function (evt) {
    			document.getElementById("data").value = '';
        		document.getElementById("data").value = evt.target.result;
    		}
    		
        }
     });
	$('#btn').click(function(){
		var grp = $('#group').val();
		document.getElementById('loaingImage').style.display='inline';
		$('#btn').attr("disabled", true);
		$('#group').attr("disabled", true);
		$('#data').attr("disabled", true);
		$('#fi').attr("disabled", true);
		var group;
		if(grp == 'A')
			group = 'A';
		else if(grp == 'B')
			group = 'B';
		$.post('Controller',
				{
					btn: 'Insert',
					data: $('#data').val(),
					group: group,
				},
				function(data,status){
					alert(data);
					document.getElementById('loaingImage').style.display='none';
					$('#btn').removeAttr("disabled");
					$('#group').removeAttr("disabled");
					$('#data').removeAttr("disabled");
					$('#fi').removeAttr("disabled");
		});
	});
});
</script>

</head>

<body id="page-top">
<%
	String userId = (String) request.getAttribute("user");
	System.out.println(userId);
	if(userId == null){
		response.getWriter().println("<script> window.location.href = \"Login.jsp\" </script>");
	}
%>
  <!-- Navigation -->
  <nav class="navbar navbar-expand-lg bg-secondary text-uppercase fixed-top" id="mainNav">
    <div class="container">
    <img class="img-fluid pr-3 aa-logo-img" src="Images/AU.png" height="70px" width="70px" alt="logo">
      <a class="navbar-brand js-scroll-trigger" href="#page-top">AHMEDABAD UNIVERSITY</a>
      <button class="navbar-toggler navbar-toggler-right text-uppercase font-weight-bold bg-primary text-white rounded" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
        Menu
        <i class="fas fa-bars"></i>
      </button>
      <div class="collapse navbar-collapse" id="navbarResponsive">
        <ul class="navbar-nav ml-auto">
          <li class="nav-item mx-0 mx-lg-1">
            <a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" href="#portfolio">Add Student</a>
          </li>
          <li class="nav-item mx-0 mx-lg-1">
            <a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" href="#about">Update Student</a>
          </li>
          <li class="nav-item mx-0 mx-lg-1">
            <a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" onclick="logOut()" href="#">Sign Out</a>
          </li>
        </ul>
      </div>
    </div>
  </nav>

  <!-- Masthead -->
  <header class="masthead bg-primary text-white text-center">
  </header>

  <!-- Portfolio Section -->
  <section class="page-section portfolio" id="portfolio">
    <div class="container">

      <!-- Portfolio Section Heading -->
      <h2 class="page-section-heading text-center text-uppercase text-secondary mb-0">Add Student</h2>

      <!-- Icon Divider -->
      <div class="divider-custom">
        <div class="divider-custom-line"></div>
        <div class="divider-custom-icon">
          <i class="fa fa-star" aria-hidden="true"></i>
        </div>
        <div class="divider-custom-line"></div>
      </div>
      <div class="mx-auto" style="width: 50%;margin-top:2%;">
         <div class="col-md-12 text-center">
        <form><!-- action="Controller" method="post"> -->
		  <div class="form-group">
		    <b>Select Group</b>
		    <select class="form-control" id="group">
		      <option disabled>Select Group</option>
		      <option>A</option>
		      <option>B</option>
		    </select>
		  </div>
		 	<b>Enter each email id in the new line into below the text area. </b>
			<textarea class="form-control" rows="7" id="data" required="required" name="data" 
			placeholder="Enter text in following format (Only one email ID in one line):
example.x@ahduni.edu.in
example.y@ahduni.edu.in"></textarea>
			<br><b>OR</b><br/>	
            <div class="input-group">
                <span class="input-group-btn">
                    <span class="btn btn-success btn-file">
                        Select File <input type="file" id="fi" accept=".csv,.txt">
                    </span>
                </span>
                <input type="text" class="form-control" placeholder="Please enter .csv or .txt file only in specified format"  readonly>
            </div>
            <div class="s">
         	 <button type="button" id="btn" name="btn" value="Insert" class="btn btn-dark"><span class="fa fa-plus"></span> Insert</button>
         	 <img id="loaingImage" style="display: none;" height="30" width="30" src="Images/loading.gif">
         	 </div>
		</form>
	</div>
	</div>

    </div>
  </section>

  <!-- About Section -->
  <!-- <section class="page-section bg-primary text-white mb-0" id="about">
    <div class="container">

      About Section Heading
      <h2 class="page-section-heading text-center text-uppercase text-white">About</h2>

      Icon Divider
      <div class="divider-custom divider-light">
        <div class="divider-custom-line"></div>
        <div class="divider-custom-icon">
          <i class="fa fa-pencil" aria-hidden="true"></i>
        </div>
        <div class="divider-custom-line"></div>
      </div>

      About Section Content
      

    </div>
  </section>
 -->
 
  <!-- Footer -->
  <!-- <footer class="footer text-center">
    <div class="container">
      <div class="row">

        Footer Location
        <div class="col-lg-4 mb-5 mb-lg-0">
          <h4 class="text-uppercase mb-4">Location</h4>
          <p class="lead mb-0">Ahmedabad University, GICT Building, Central Campus,
            <br> Navrangpura, Ahmedabad, Gujarat 380009</p>
        </div>

        Footer Social Icons
        <div class="col-lg-4 mb-5 mb-lg-0">
          <h4 class="text-uppercase mb-4">Around the Web</h4>
          <a class="btn btn-outline-light btn-social mx-1" href="#">
           <i class="fa fa-facebook-square" aria-hidden="true"></i>
          </a>
          <a class="btn btn-outline-light btn-social mx-1" href="#">
            <i class="fa fa-twitter-square" aria-hidden="true"></i>
          </a>
         
        </div>

        Footer About Text
        <div class="col-lg-4">
          <h4 class="text-uppercase mb-4">About Ahmedabad University</h4>
          <p class="lead mb-0">xyz
            <a href="http://startbootstrap.com">Start</a>.</p>
        </div>

      </div>
    </div>
  </footer> -->

  <!-- Copyright Section -->
  <section class="copyright py-4 text-center text-white">
    <div class="container">
      <small>Made by <i>Yash Vaghela</i> and <i>Tapaswi Satyapanthi</i></small>
    </div>
  </section>

  <!-- Scroll to Top Button (Only visible on small and extra-small screen sizes) -->
  <div class="scroll-to-top d-lg-none position-fixed ">
    <a class="js-scroll-trigger d-block text-center text-white rounded" href="#page-top">
      <i class="fa fa-chevron-up"></i>
    </a>
  </div>
  <!-- Bootstrap core JavaScript -->
  <script src="vendor/jquery/jquery.min.js"></script>
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Plugin JavaScript -->
  <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

  <!-- Contact Form JavaScript -->
  <script src="js/jqBootstrapValidation.js"></script>
  <script src="js/contact_me.js"></script>

  <!-- Custom scripts for this template -->
  <script src="js/freelancer.min.js"></script>

<script type="text/javascript">
$(document).on('change', '.btn-file :file', function() {
	  var input = $(this),
	      numFiles = input.get(0).files ? input.get(0).files.length : 1,
	      label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
	  input.trigger('fileselect', [numFiles, label]);
	});

	$(document).ready( function() {
	    $('.btn-file :file').on('fileselect', function(event, numFiles, label) {
	        
	        var input = $(this).parents('.input-group').find(':text'),
	            log = numFiles > 1 ? numFiles + ' files selected' : label;
	        
	        if( input.length ) {
	            input.val(log);
	        } else {
	            if( log ) alert(log);
	        }
	        
	    });
	});
</script>
</body>

</html>
