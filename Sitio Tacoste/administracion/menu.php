<!doctype html>
<html lang="en">
<?php
include("../conexion.php");

$product_query_string = ""
?>
<head>
	<meta charset="utf-8" />
	<link rel="apple-touch-icon" sizes="76x76" href="assets/img/taco-icon.png">
	<link rel="icon" type="image/png" sizes="96x96" href="assets/img/taco-icon.png">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

	<title>Menu | Administración Tacoste</title>

	<meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport' />
    <meta name="viewport" content="width=device-width" />


    <!-- Bootstrap core CSS     -->
    <link href="assets/css/bootstrap.min.css" rel="stylesheet" />

    <!-- Animation library for notifications   -->
    <link href="assets/css/animate.min.css" rel="stylesheet"/>

    <!--  Paper Dashboard core CSS    -->
    <link href="assets/css/paper-dashboard.css" rel="stylesheet"/>

    <!--  CSS for Demo Purpose, don't include it in your project     -->
    <link href="assets/css/demo.css" rel="stylesheet" />

    <!--  Fonts and icons     -->
    <link href="http://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" rel="stylesheet">
    <link href='https://fonts.googleapis.com/css?family=Muli:400,300' rel='stylesheet' type='text/css'>
    <link href="assets/css/themify-icons.css" rel="stylesheet">

</head>
<body>

<div class="wrapper">
	<div class="sidebar" data-background-color="white" data-active-color="danger">

    <!--
		Tip 1: you can change the color of the sidebar's background using: data-background-color="white | black"
		Tip 2: you can change the color of the active button using the data-active-color="primary | info | success | warning | danger"
	-->

<div class="sidebar-wrapper">
            <div class="logo">
                <a href="http://www.creative-tim.com" class="simple-text">
                    Tacoste
                </a>
            </div>

            <ul class="nav">   
                <li>
                    <a href="index.php">
                        <i class="ti-receipt"></i>
                        <p>Ordenes</p>
                    </a>
                </li>
                <li>
                    <a href="empleados.php">
                        <i class="ti-user"></i>
                        <p>Empleados</p>
                    </a>
                </li>
                <li>
                    <a href="clientes.php">
                        <i class="ti-user"></i>
                        <p>Clientes</p>
                    </a>
                </li>
                <li>
                    <a href="proveedores.php">
                        <i class="ti-truck"></i>
                        <p>Proveedores</p>
                    </a>
                </li>
                <li class="active">
                    <a href="menu.php">
                        <i class="ti-bookmark-alt"></i>
                        <p>Menu</p>
                    </a>
                </li>
                <li>
                    <a href="precios.php">
                        <i class="ti-money"></i>
                        <p>Precios</p>
                    </a>
                </li>
                <li>
                    <a href="ingredientes.php">
                        <i class="ti-paint-bucket"></i>
                        <p>Ingredientes</p>
                    </a>
                </li>
            </ul>
    	</div>
    </div>



    <div class="main-panel">
		<nav class="navbar navbar-default">
            <div class="container-fluid">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar bar1"></span>
                        <span class="icon-bar bar2"></span>
                        <span class="icon-bar bar3"></span>
                    </button>
                    <a class="navbar-brand" href="#">Opciones del Menú (Todas las Sucursales)</a>
                </div>
                <div class="collapse navbar-collapse">
                    <ul class="nav navbar-nav navbar-right">
                        <li>
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                <i class="ti-panel"></i>
								<p>Stats</p>
                            </a>
                        </li>
                        <li class="dropdown">
                              <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                    <i class="ti-bell"></i>
                                    <p class="notification">5</p>
									<p>Notifications</p>
									<b class="caret"></b>
                              </a>
                              <ul class="dropdown-menu">
                                <li><a href="#">Notification 1</a></li>
                                <li><a href="#">Notification 2</a></li>
                                <li><a href="#">Notification 3</a></li>
                                <li><a href="#">Notification 4</a></li>
                                <li><a href="#">Another notification</a></li>
                              </ul>
                        </li>
						<li>
                            <a href="#">
								<i class="ti-settings"></i>
								<p>Settings</p>
                            </a>
                        </li>
                    </ul>

                </div>
            </div>
        </nav>


        <div class="content">
            <div class="container-fluid">
                <div class="row">

                    <div class="col-md-6">
                        <div class="card">
                            <div class="header">
                                <h4 class="title"> Lista de Alimentos </h4>
                                <p class="category"></p>
                            </div>
                            <div class="content table-responsive table-full-width">
                                <table class="table table-hover">
                                    <thead>
                                        <th>ID</th>
                                    	<th>Nombre</th>
                                    	<th>Precio Actual</th>
                                    	<th>Descripción</th>
                                    </thead>
                                    <tbody class="dynamic-data">
                                        <tr>
                                        	<td>3452</td>
                                        	<td>Taco de Suadero</td>
                                        	<td>$15.00</td>
                                        	<td>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.  </td>
                                        </tr>
                                        <tr>
                                        	<td>3452</td>
                                        	<td>Taco de Suadero</td>
                                        	<td>$15.00</td>
                                        	<td>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.  </td>
                                        </tr>
                                        <tr>
                                        	<td>3452</td>
                                        	<td>Taco de Suadero</td>
                                        	<td>$15.00</td>
                                        	<td>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.  </td>
                                        </tr>
                                        <tr>
                                        	<td>3452</td>
                                        	<td>Taco de Suadero</td>
                                        	<td>$15.00</td>
                                        	<td>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.  </td>
                                        </tr>
                                        <tr>
                                        	<td>3452</td>
                                        	<td>Taco de Suadero</td>
                                        	<td>$15.00</td>
                                        	<td>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.  </td>
                                        </tr>
                                        <tr>
                                        	<td>3452</td>
                                        	<td>Taco de Suadero</td>
                                        	<td>$15.00</td>
                                        	<td>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.  </td>
                                        </tr>
                                        <tr>
                                        	<td>3452</td>
                                        	<td>Taco de Suadero</td>
                                        	<td>$15.00</td>
                                        	<td>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.  </td>
                                        </tr>
                                        <tr>
                                        	<td>3452</td>
                                        	<td>Taco de Suadero</td>
                                        	<td>$15.00</td>
                                        	<td>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.  </td>
                                        </tr>
                                        <tr>
                                        	<td>3452</td>
                                        	<td>Taco de Suadero</td>
                                        	<td>$15.00</td>
                                        	<td>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.  </td>
                                        </tr>
                                        <tr>
                                        	<td>3452</td>
                                        	<td>Taco de Suadero</td>
                                        	<td>$15.00</td>
                                        	<td>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.  </td>
                                        </tr>
                                        
                                    </tbody>
                                </table>

                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="card">
                            <div class="header">
                                <h4 class="title"> Lista de Salsas </h4>
                                <p class="category"></p>
                            </div>
                            <div class="content table-responsive table-full-width">
                                <table class="table table-hover">
                                    <thead>
                                        <th>ID</th>
                                    	<th>Nombre</th>
                                        <th>Precio (ml)</th>
                                        <th>Precio (1/2 lt)</th>
                                    	<th>Precio (lt)</th>
                                        <th>Picor</th>
                                        <th>Recomendaciones</th>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            
                                        </tr>
                                        <tr>
                                            <td>6574</td>
                                            <td>Guacamole</td>
                                            <td>$0.50</td>
                                            <td>$25.50</td>
                                            <td>$40.95</td>
                                            <td>Intermedio</td>
                                            <td>Lorem ipsum dolor sit amet, consectetur adipiscing eli</td>
                                        </tr>
                                        <tr>
                                            <td>6574</td>
                                            <td>Guacamole</td>
                                            <td>$0.50</td>
                                            <td>$25.50</td>
                                            <td>$40.95</td>
                                            <td>Intermedio</td>
                                            <td>Lorem ipsum dolor sit amet, consectetur adipiscing eli</td>
                                        </tr>
                                        <tr>
                                            <td>6574</td>
                                            <td>Guacamole</td>
                                            <td>$0.50</td>
                                            <td>$25.50</td>
                                            <td>$40.95</td>
                                            <td>Intermedio</td>
                                            <td>Lorem ipsum dolor sit amet, consectetur adipiscing eli</td>
                                        </tr>
                                        <tr>
                                            <td>6574</td>
                                            <td>Guacamole</td>
                                            <td>$0.50</td>
                                            <td>$25.50</td>
                                            <td>$40.95</td>
                                            <td>Intermedio</td>
                                            <td>Lorem ipsum dolor sit amet, consectetur adipiscing eli</td>
                                        </tr>
                                        <tr>
                                            <td>6574</td>
                                            <td>Guacamole</td>
                                            <td>$0.50</td>
                                            <td>$25.50</td>
                                            <td>$40.95</td>
                                            <td>Intermedio</td>
                                            <td>Lorem ipsum dolor sit amet, consectetur adipiscing eli</td>
                                        </tr>
                                        <tr>
                                            <td>6574</td>
                                            <td>Guacamole</td>
                                            <td>$0.50</td>
                                            <td>$25.50</td>
                                            <td>$40.95</td>
                                            <td>Intermedio</td>
                                            <td>Lorem ipsum dolor sit amet, consectetur adipiscing eli</td>
                                        </tr>
                                        <tr>
                                            <td>6574</td>
                                            <td>Guacamole</td>
                                            <td>$0.50</td>
                                            <td>$25.50</td>
                                            <td>$40.95</td>
                                            <td>Intermedio</td>
                                            <td>Lorem ipsum dolor sit amet, consectetur adipiscing eli</td>
                                        </tr>
                                        
                                    </tbody>
                                </table>

                            </div>
                        </div>
                    </div>
 
                </div>
            </div>
        </div>



    </div>
</div>


</body>

    <!--   Core JS Files   -->
    <script src="assets/js/jquery-1.10.2.js" type="text/javascript"></script>
	<script src="assets/js/bootstrap.min.js" type="text/javascript"></script>

	<!--  Checkbox, Radio & Switch Plugins -->
	<script src="assets/js/bootstrap-checkbox-radio.js"></script>

	<!--  Charts Plugin -->
	<script src="assets/js/chartist.min.js"></script>

    <!--  Notifications Plugin    -->
    <script src="assets/js/bootstrap-notify.js"></script>

    <!--  Google Maps Plugin    -->
    <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js"></script>

    <!-- Paper Dashboard Core javascript and methods for Demo purpose -->
	<script src="assets/js/paper-dashboard.js"></script>

	<!-- Paper Dashboard DEMO methods, don't include it in your project! -->
	<script src="assets/js/demo.js"></script>

    <!-- Script para autorellenar la tabla de esta página con datos de la base -->
    <!-- La idea es que éste script realiza una petición a una cierta url (dbrequest.php por ejemplo)
         y ésta devuelve los datos solicitados, ya etiquetados (bastan los tds y trs).
         Se insertan directamente en un table body (de la clase 'dynamic-data'). -->
    <script>
        $( window ).load(function() {
            $.post( 'dbrequest.php', { peticion : 'menu' })
                .done( function( data ) {
                    $(".dynamic-data").text(data);   
                });
        });
    </script>
    
</html>
