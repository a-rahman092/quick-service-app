<?php
$HostName = "localhost";
$DatabaseName = "yvxrlaix_quickservice";
$HostUser = "yvxrlaix_quickservice";
$HostPass = "S5up3oV6";

$con = mysqli_connect($HostName, $HostUser, $HostPass, $DatabaseName);


?>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="shortcut icon" type="image/x-icon" href="assets/images/checked.png" />

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">

    <title>Admin Dashboard</title>
  </head>
  <body>
    <nav class="navbar navbar-expand-lg navbar-dark" style="background-color: #155bd5;">
  <div class="container-fluid px-md-5">
    <a class="navbar-brand d-flex align-items-center" href="/"><img class="me-2" src="assets/images/checked.png" width="40"/><strong>QuickService</strong></a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav ms-auto">
        <li class="nav-item me-3">
          <a class="nav-link text-white" aria-current="page" href="/">Home</a>
        </li>
        <li class="nav-item me-3">
          <a class="nav-link text-white" href="servitor-register.html">Register Servitor</a>
        </li>
      </ul>
    </div>
  </div>
</nav>
    <div class="container my-5">
      <h3 class="text-center mb-5">Admin Dashboard</h3>
  	<table class="table table-bordered table-responsive">
  		<thead>
    		<tr>
     			<th>Name</th>
      			<th>Mobile</th>
      			<th>Service Providing</th>
      			<th>Cost</th>
      			<th>Photo</th>
              <th>Action</th>
    		</tr>
  		</thead>
  		<tbody>
     		<?php
          
    			$sql = "SELECT * FROM service_person where verified='NO'";
				$result = mysqli_query($con, $sql);

				if (mysqli_num_rows($result) > 0) {
  					while($row = mysqli_fetch_assoc($result)) {
    				echo "<tr>
    						<td>".$row['name']."</td>
      						<td>".$row['mobile']."</td>
      						<td>".$row['service_providing']."</td>
      						<td>".$row['cost']."</td>
      						<td><img src=".$row['photo']." alt='image' width='70' height='70'/></td>
                            <td><form action='admin-approve.php' method='post'><input type='text' value=".$row['mobile']." hidden='hidden' name='mobile'/><input type='submit' class='btn btn-success me-3' value='Approve' name='submit'/></form></td>
      					<tr>";
  					}
				} 
          else{
            echo "0 results";}
				mysqli_close($con);
    
   			?>
  		</tbody>
	</table>
  	</div>

    <!-- Optional JavaScript; choose one of the two! -->

    <!-- Option 1: Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>

    <!-- Option 2: Separate Popper and Bootstrap JS -->
    <!--
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
    -->
  </body>
</html>