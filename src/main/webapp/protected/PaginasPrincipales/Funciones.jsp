<%-- 
    Document   : Requisitos
    Created on : 28/01/2019, 10:43:13 PM
    Author     : Xavy PC
--%>

<%@page import="ugt.entidades.Tbusuariosentidad"%>
<%@page import="utg.login.Login"%>
<!DOCTYPE html>
<!--[if IE 9 ]><html class="ie ie9" lang="en" class="no-js"> <![endif]-->
<!--[if !(IE)]><!-->
<html lang="en" class="no-js">
    <!--<![endif]-->

    <head>
        <title>DTIC | UGT</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <!-- CSS -->
        <link href="../../assets/css/bootstrap.min.css" rel="stylesheet" type="text/css">
        <link href="../../assets/css/font-awesome.min.css" rel="stylesheet" type="text/css">
        <link href="../../assets/css/main.css" rel="stylesheet" type="text/css">
        <link href="../../assets/css/my-custom-styles.css" rel="stylesheet" type="text/css">
        <!--[if lte IE 9]>
                <link href="../../assets/css/main-ie.css" rel="stylesheet" type="text/css"/>
                <link href="../../assets/css/main-ie-part2.css" rel="stylesheet" type="text/css"/>
        <![endif]-->
        <!-- CSS for demo style switcher. you can remove this -->
        <!-- Fav and touch icons -->
        <link rel="apple-touch-icon-precomposed" sizes="144x144" href="../../assets/ico/kingadmin-favicon144x144.png">
        <link rel="apple-touch-icon-precomposed" sizes="114x114" href="../../assets/ico/kingadmin-favicon114x114.png">
        <link rel="apple-touch-icon-precomposed" sizes="72x72" href="../../assets/ico/kingadmin-favicon72x72.png">
        <link rel="apple-touch-icon-precomposed" sizes="57x57" href="../../assets/ico/kingadmin-favicon57x57.png">
        <link rel="shortcut icon" href="../../assets/ico/favicon.ico">
    </head>

    <body class="sidebar-fixed topnav-fixed ">
        <link href="../../assets/css/skins/darkblue.css" rel="stylesheet" type="text/css"/>
        <!-- WRAPPER -->
        <div id="wrapper" class="wrapper">
            <!-- TOP BAR -->
            <div class="top-bar navbar-fixed-top">
                <div class="container">
                    <div class="clearfix">
                        <!-- logo -->
                        <div class="pull-left left logo">
                            <a href="index.jsp"><img src="../../assets/img/logoDEAC.png"  /></a>
                        </div>
                        <!-- end logo -->
                        <div class="pull-right right">
                            <!-- top-bar-right -->
                            <div class="top-bar-right">
                                <!-- logged user and the menu -->
                                <div class="logged-user">
                                    <div class="btn-group">
                                        <%
                                            Login login = (Login) session.getAttribute("login");
                                            if (login != null) {
                                        %>
                                        <a class="btn btn-link" href="../index.jsp" >
                                            <i class="fa fa-wrench fa-2x"></i>
                                            <span class="text" style="font-size: 20px;">Pagina gestión</span>
                                        </a>
                                        <%
                                        } else {
                                        %>
                                        <a class="btn text-success" href="../index.jsp" >
                                            <i class="fa fa-sign-in fa-2x"></i>
                                            <span class="text" style="font-size: 20px;">Ingresar</span>
                                        </a>
                                        <%
                                            }
                                        %>
                                    </div>
                                </div>
                                <!-- end logged user and the menu -->
                            </div>
                            <!-- end top-bar-right -->
                        </div>
                    </div>
                </div>
                <!-- /container -->
            </div>
            <!-- END TOP BAR -->
            <!-- LEFT SIDEBAR -->
            <div id="left-sidebar" class="left-sidebar">
                <div class="sidebar-minified js-toggle-minified">
                    <i class="fa fa-exchange"></i>
                </div>
                <nav class="main-nav">
                    <ul class="main-menu">
                        <li style='cursor: pointer'>
                            <a href="Funciones.jsp">
                                <i class="fa fa-book"></i><span class="text">Funciones unidad</span>
                            </a>
                        </li>
                        <li style='cursor: pointer'>
                            <a href="Requisitospdfs.jsp">
                                <i class="fa fa-file-pdf-o"></i><span class="text">PDF normas</span>
                            </a>
                        </li>
                    </ul>
                </nav>
            </div>
            <!-- END LEFT SIDEBAR -->
            <!-- MAIN CONTENT WRAPPER -->
            <div id="main-content-wrapper" class="content-wrapper ">
                <!-- top general alert -->
                <div class="alert alert-danger top-general-alert">
                </div>
                <!-- end top general alert -->
                <div class="row">
                    <div class="col-lg-4 ">
                        <ul class="breadcrumb">
                            <li><i class="fa fa-home"></i><a href="../../index.jsp">Home</a></li>
                        </ul>
                    </div>
                </div>
                <!-- main -->
                <div class="content">
                    <div class="main-content">
                        <div class="text-center">
                            <div class="row list-group king-gallery">
                                <img src="../../assets/img/ugtLogo.png" width="100" alt="Fixed Slidebar" class="list-group-image"/>
                            </div>
                            <div class="bottom-30px"></div>
                            <p class="lead">UNIDAD DE GESTIÓN DE TRASNPORTE.</p>
                            <p><h4><i class="fa fa-university"></i> Escuela Superior Politécnica del Chimborazo.</h4></p>
                        </div>
                        <div class="text-justify">
                            <p><h5>Según oficio 1183 VA. ESPOCH.2018, la dirección administrativa dispone a la unidad de gestión de transporte, todas las medidas que sean necesarias con el fin de controlar que los vehículos institucionales sean utilizados únicamente cuando las solicitudes de movilizaciones cuenten necesariamente con la autorización por escrito tanto por el señor rector como máxima autoridad institucional, cuanto por la suscrita como autoridad delegada para autorizar dichas peticiones.</h5></p>
                            <p><h5>Adicionalmente, a que se realicen las acciones de control pertinentes, encaminadas a verificar que previamente a la salida de los vehículos institucionales, se verifiquen que los mismos sean utilizados con fines oficiales y únicamente por las personas debidamente autorizadas para el efecto, de manera que, en ele evento de que la persona no autorizadas utilicen dichos bienes instituciones, desliñado las responsabilidades subsecuentes, ocasionadas por dichas acciones u omisiones.</h5></p>
                        </div>
                    </div>
                </div>
                <!-- /main -->
                <!-- FOOTER -->
                <footer class="footer">
                    <div> <a href="http://dtic.espoch.edu.ec/" target="_blank"> <img width="45" height="15" src="../../assets/img/dtic.png" > Escuela Superior Politécnica de Chimborazo 2018</a></div>
                </footer>
                <!-- END FOOTER -->
            </div>
            <!-- END CONTENT WRAPPER -->
        </div>
        <!-- END WRAPPER -->
        <!-- Javascript -->
        <script src="../../assets/js/jquery/jquery-2.1.0.min.js"></script>
        <script src="../../assets/js/bootstrap/bootstrap.js"></script>
        <script src="../../assets/js/plugins/modernizr/modernizr.js"></script>
        <script src="../../assets/js/plugins/bootstrap-tour/bootstrap-tour.custom.js"></script>
        <script src="../../assets/js/plugins/jquery-slimscroll/jquery.slimscroll.min.js"></script>
        <script src="../../assets/js/king-common.js"></script>
    </body>

</html>

