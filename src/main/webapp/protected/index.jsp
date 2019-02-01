<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="ugt.opciones.iu.OpcionesIU"%>
<%@page import="ugt.servicios.swLogin"%>
<%@page import="ugt.entidades.Tbusuariosentidad"%>
<%@page import="utg.login.Login"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Map"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.jasig.cas.client.authentication.AttributePrincipal"%>
<%@page contentType='text/html' pageEncoding='UTF-8'%>
<html lang="es" class="no-js">
    <head>
        <title>DTIC | UGT</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

        <!--        <link href="../assets/css/skins/orange.css" rel="stylesheet" type="text/css"/>-->

        <!-- CSS -->
        <link href="../assets/css/bootstrap.min.css" rel="stylesheet" type="text/css">
        <link href="../assets/css/font-awesome.min.css" rel="stylesheet" type="text/css">
        <link href="../assets/css/main.css" rel="stylesheet" type="text/css">
        <link href="../assets/css/my-custom-styles.css" rel="stylesheet" type="text/css">
        <!--[if lte IE 9]>
                <link href="../assets/css/main-ie.css" rel="stylesheet" type="text/css"/>
                <link href="../assets/css/main-ie-part2.css" rel="stylesheet" type="text/css"/>
        <![endif]-->

        <!-- Fav and touch icons -->
        <link rel="apple-touch-icon-precomposed" sizes="144x144" href="../assets/ico/kingadmin-favicon144x144.png">
        <link rel="apple-touch-icon-precomposed" sizes="114x114" href="../assets/ico/kingadmin-favicon114x114.png">
        <link rel="apple-touch-icon-precomposed" sizes="72x72" href="../assets/ico/kingadmin-favicon72x72.png">
        <link rel="apple-touch-icon-precomposed" sizes="57x57" href="../assets/ico/kingadmin-favicon57x57.png">
        <link rel="shortcut icon" href="../assets/ico/favicon.ico">



        <link href="../js/css/dtic.css" rel="stylesheet" type="text/css"/>

    </head>

    <%
        String tipoLogueo = "";
        Boolean estado = false;
        session.setAttribute("tipousuario2", "");
        session.setAttribute("TipoUser", "");
        session.setAttribute("ingreso", "false");
        String codigocas = "";
        String cedulacas = "";
        String nombre = "";
        Login login = (Login) session.getAttribute("login");
        try {

            if (request.getUserPrincipal() != null) {
                AttributePrincipal principal = (AttributePrincipal) request.getUserPrincipal();
                final Map attributes = principal.getAttributes();
                String[] cadena = attributes.toString().split("=");

                for (String i : cadena) {
                    if (i.contains("cedula")) {
                        session.setAttribute("existe", "true");
                        estado = true;
                    }
                }
                if (attributes != null) {
                    Iterator attributeNames = attributes.keySet().iterator();
                    if (attributeNames.hasNext()) {
                        for (; attributeNames.hasNext();) {
                            String attributeName = (String) attributeNames.next();
                            final Object attributeValue = attributes.get(attributeName);
                            if (attributeValue instanceof List) {
                                final List values = (List) attributeValue;
                            } else {
                                if (attributeName == "perid") {
                                    session.setAttribute("ingreso", "true");
                                    codigocas = attributeValue.toString();
                                    session.setAttribute("tipousuario2", "");
                                }
                                if (attributeName == "cedula") {
                                    cedulacas = attributeValue.toString();
                                }
                                if (attributeName == "clientName") {
                                    session.setAttribute("tipousuario2", attributeValue.toString());
                                }

                                if (attributeName == "given_name") {
                                    nombre = attributeValue.toString();
                                }
                            }
                        }
                    } else {
                        out.println("<pre>The attribute map is empty. Review your CAS filter configurations.</pre>");
                    }
                } else {
                    out.println("<pre>The user principal is empty from the request object. Review the wrapper filter configuration.</pre>");
                }
            }
            if (estado == true) {
                if (!codigocas.equals("")) {
                    //tipo de sesion
                    if (session.getAttribute("tipousuario2").toString().isEmpty()) {
                        tipoLogueo = "Oasis";
                    } else {
                        tipoLogueo = "Institucional";
                    }

                    //aqui desarrollo
                    if (login == null) {
                        login = new Login();
                        Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd'T'HH:mm:ss").create();
                        String json = swLogin.loginUser(cedulacas);
//                        String json = "";
                        if (json.length() > 2) {
                            JSONArray arrayJSON = new JSONArray(json);
                            for (int i = 0; i < arrayJSON.length(); i++) {
                                JSONObject childJSONObject = arrayJSON.getJSONObject(i);
                                Tbusuariosentidad roles = gson.fromJson(childJSONObject.toString(), Tbusuariosentidad.class);
                                login.getRolesEntity().add(roles);
                            }
                            if (login.getRolesEntity().size() > 0) {
                                login.setRolActivo(login.getRolesEntity().get(0).getTbroles());
                                String jsonArrayOpc = swLogin.opcionesRol(login.getRolActivo().getIdrol().toString());
                                OpcionesIU opciones = new OpcionesIU();
                                opciones.setListaJSON(jsonArrayOpc);
                                session.setAttribute("opcionesIU", opciones);
                            }

                            session.setAttribute("login", login);
                        } else {
                            response.sendRedirect("PaginasPrincipales/NoAutorizadoLogin.jsp");
                        }
                    }
                }
            }

        } catch (Exception e) {
        } finally {

        }
    %>
    <link href="../assets/css/skins/darkblue.css" rel="stylesheet" type="text/css"/>
    <body class="sidebar-fixed topnav-fixed dashboard">
        <div id="Logeo" name="Logeo" ><div style="display:none;"><% out.println(tipoLogueo);%></div></div>

        <!-- WRAPPER -->
        <div id="wrapper" class="wrapper">
            <!-- TOP BAR -->
            <div class="top-bar navbar-fixed-top">
                <div class="container">
                    <div class="clearfix">
                        <!-- logo -->
                        <div class="pull-left left logo">
                            <a href="index.jsp"><img src="../assets/img/logoDEAC.png"  /></a>
                        </div>
                        <!-- end logo -->
                        <div class="pull-right right">
                            <!-- top-bar-right -->
                            <div class="top-bar-right">
                                <!--                                <div class="notifications">
                                                                    <ul>
                                                                         notification: general 
                                                                        <li class="notification-item general">
                                                                            <div class="btn-group">
                                                                                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                                                                    <i class="fa fa-bell"></i><span class="count">8</span>
                                                                                    <span class="circle"></span>
                                                                                </a>
                                                                                <ul class="dropdown-menu" role="menu">
                                                                                    <li class="notification-header">
                                                                                        <em>You have 8 notifications</em>
                                                                                    </li>
                                                                                    <li>
                                                                                        <a href="#">
                                                                                            <i class="fa fa-comment green-font"></i>
                                                                                            <span class="text">New comment on the blog post</span>
                                                                                            <span class="timestamp">1 minute ago</span>
                                                                                        </a>
                                                                                    </li>
                                                                                    <li>
                                                                                        <a href="#">
                                                                                            <i class="fa fa-user green-font"></i>
                                                                                            <span class="text">New registered user</span>
                                                                                            <span class="timestamp">12 minutes ago</span>
                                                                                        </a>
                                                                                    </li>
                                                                                    <li>
                                                                                        <a href="#">
                                                                                            <i class="fa fa-comment green-font"></i>
                                                                                            <span class="text">New comment on the blog post</span>
                                                                                            <span class="timestamp">18 minutes ago</span>
                                                                                        </a>
                                                                                    </li>
                                                                                    <li>
                                                                                        <a href="#">
                                                                                            <i class="fa fa-shopping-cart red-font"></i>
                                                                                            <span class="text">4 new sales order</span>
                                                                                            <span class="timestamp">4 hours ago</span>
                                                                                        </a>
                                                                                    </li>
                                                                                    <li>
                                                                                        <a href="#">
                                                                                            <i class="fa fa-edit yellow-font"></i>
                                                                                            <span class="text">3 product reviews awaiting moderation</span>
                                                                                            <span class="timestamp">1 day ago</span>
                                                                                        </a>
                                                                                    </li>
                                                                                    <li>
                                                                                        <a href="#">
                                                                                            <i class="fa fa-comment green-font"></i>
                                                                                            <span class="text">New comment on the blog post</span>
                                                                                            <span class="timestamp">3 days ago</span>
                                                                                        </a>
                                                                                    </li>
                                                                                    <li>
                                                                                        <a href="#">
                                                                                            <i class="fa fa-comment green-font"></i>
                                                                                            <span class="text">New comment on the blog post</span>
                                                                                            <span class="timestamp">Oct 15</span>
                                                                                        </a>
                                                                                    </li>
                                                                                    <li>
                                                                                        <a href="#">
                                                                                            <i class="fa fa-warning red-font"></i>
                                                                                            <span class="text red-font">Low disk space!</span>
                                                                                            <span class="timestamp">Oct 11</span>
                                                                                        </a>
                                                                                    </li>
                                                                                    <li class="notification-footer">
                                                                                        <a href="#">View All Notifications</a>
                                                                                    </li>
                                                                                </ul>
                                                                            </div>
                                                                        </li>
                                                                         end notification: general 
                                                                    </ul>
                                                                </div>-->
                                <!-- logged user and the menu -->
                                <div class="logged-user">
                                    <div id="btnUser" class="btn-group">
                                        <a  class="btn btn-link dropdown-toggle" data-toggle="dropdown" >
                                            <img src="../assets/img/user-avatar.png" alt="User Avatar" />
                                            <span class='name'><%out.print(nombre); %></span><span class='caret'></span>
                                        </a>
                                        <ul class="dropdown-menu" role="menu" >
                                            <%
                                                if (login != null) {
                                                    for (Tbusuariosentidad rol : login.getRolesEntity()) {
                                                        if (rol.getTbroles().getEstado() != "Deshabilitado") {
                                                            out.println("<li>");
                                                            out.println("    <a onclick=\"fncambiarRol('" + rol.getTbroles().getCharrol() + "');\" style='cursor: pointer'>");
                                                            out.println("       <i class=\"fa fa-user\"></i>");
                                                            out.println("       <span class=\"text\">" + rol.getCargo() + " " + rol.getTbroles().getCharrol() + "</span>");
                                                            out.println("    </a>");
                                                            out.println("</li>");
                                                        }
                                                    }
                                                }
                                            %>
                                            <li>
                                                <a onclick="Matar();" style='cursor: pointer' >
                                                    <i class="fa fa-power-off"></i>
                                                    <span class="text">SALIR</span>
                                                </a>
                                            </li>
                                        </ul>
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
                    <i class="fa fa-exchange" onclick="abrecierra()"></i>
                </div>
                <div class="sidebar-scroll">
                    <center><i class="fa fa-spinner fa-pulse fa-3x fa-fw"></i>
                        <span class="sr-only">Cargando...</span></center>
                </div>

            </div>
            <!-- END LEFT SIDEBAR -->
            <!-- MAIN CONTENT WRAPPER -->
            <div id="main-content-wrapper" class="content-wrapper">
                <div id="alertgeneral">
                    <!--                    <span>If you <strong>can't see the logo</strong> on the top left, please reset the style on right style switcher (for upgraded theme only).</span>
                                        <button type="button" class="close">x</button>-->
                </div>
                <div class="row">
                    <div class="col-lg-12 ">
                        <ul id='divSeguimiento' class="breadcrumb">
                            <li><i class="fa fa-home"></i><a href="../index.jsp">Home</a></li>
                            <li><a href="index.jsp">Inicio</a></li>
                        </ul>
                    </div>
                </div>
                <!-- main -->
                <div id='contenidoDinamico' class="content">
                    <div class="main-header">
                        <h2>UGT</h2>
                        <em>ESPOCH</em>
                    </div>

                    <div id='contenidoInferior' class="main-content">
                        <p class="lead">Bienvenido.</p>


                        <!--                        <div id="menuLateral" class="col-xs-3">
                                                    <div id="menuTipo">
                                                        <span id='lnkReportes'  class='dda-link'onclick="graficarPanelInicio(1)">
                                                            <i class='fa fa-pie-chart'></i>
                                                        </span>
                                                        <span id='lnkDocumentos' class='dda-link' onclick="graficarPanelInicio(2)">
                                                            <i class='fa fa-file-text'></i>
                                                        </span>
                                                        <span id='lnkConfigurar' class='dda-link'  onclick="graficarPanelInicio(3)">
                                                            <i class='fa fa-cog'></i>
                                                        </span>
                                                    </div>
                                                    <div id="menuLateralScrollbar">
                        
                                                         Menú Lateral
                                                        <div id="contenidoMenuLateral">
                                                            Contenido Menu Sistema 
                                                        </div>
                                                    </div>
                                                </div> -->


                        </br>
                        <!--<div class="bottom-30px"></div>-->
                    </div>

                </div>
                <!-- /main -->
                <!-- FOOTER -->
                <footer class="footer">
                    <div> <a href="http://dtic.espoch.edu.ec/" target="_blank" style="color:#FFF;"> <img width="45" height="15" src="../assets/img/dtic.png" > Escuela Superior Politécnica de Chimborazo 2018</a></div>
                </footer>
                <!-- END FOOTER -->
            </div>

            <!-- END CONTENT WRAPPER -->
        </div>
        <!-- END WRAPPER -->
        <!-- Javascript -->
        <script src="../assets/js/jquery/jquery-2.1.0.min.js"></script>
        <script src="../assets/js/bootstrap/bootstrap.js"></script>
        <script src="../assets/js/plugins/modernizr/modernizr.js"></script>
        <script src="../assets/js/plugins/bootstrap-tour/bootstrap-tour.custom.js"></script>
        <script src="../assets/js/plugins/jquery-slimscroll/jquery.slimscroll.min.js"></script>
        <script src="../assets/js/king-common.js"></script>
        <script src="../assets/js/plugins/wizard/wizard.min.js"></script>
        <script src="../assets/js/plugins/parsley-validation/parsley.min.js"></script>
        <script src="../assets/js/plugins/stat/jquery.easypiechart.min.js"></script>
        <script src="../assets/js/plugins/raphael/raphael-2.1.0.min.js"></script>
        <script src="../assets/js/plugins/stat/flot/jquery.flot.min.js"></script>
        <script src="../assets/js/plugins/stat/flot/jquery.flot.resize.min.js"></script>
        <script src="../assets/js/plugins/stat/flot/jquery.flot.time.min.js"></script>
        <script src="../assets/js/plugins/stat/flot/jquery.flot.pie.min.js"></script>
        <script src="../assets/js/plugins/stat/flot/jquery.flot.tooltip.min.js"></script>
        <script src="../assets/js/plugins/jquery-sparkline/jquery.sparkline.min.js"></script>
        <script src="../assets/js/plugins/datatable/jquery.dataTables.min.js"></script>
        <script src="../assets/js/plugins/datatable/dataTables.bootstrap.js"></script>
        <script src="../assets/js/plugins/jquery-mapael/jquery.mapael.js"></script>
        <script src="../assets/js/plugins/raphael/maps/usa_states.js"></script>
        <script src="../assets/js/plugins/dropzone/dropzone.min.js" type="text/javascript"></script>
        <script src="../js/numeric/jquery.numeric.min.js" type="text/javascript"></script>
        <script src="../assets/js/king-chart-stat.js"></script>
        <script src="../assets/js/king-table.js"></script>
        <script src="../assets/js/king-components.js"></script>
        <!--        <link href="../js/dropzone/dropzone.css" rel="stylesheet" type="text/css"/>
                <script src="../js/dropzone/dropzone.js" type="text/javascript"></script>-->
        <!--inicio graficos charts-->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.3/Chart.min.js"></script>
        <!--        <script src="../js/flop_chart0.8.3/jquery.flot.min.js" type="text/javascript"></script>
                <script src="../js/flop_chart0.8.3/jquery.flot.resize.min.js" type="text/javascript"></script>
                <script src="../js/flop_chart0.8.3/jquery.flot.time.min.js" type="text/javascript"></script>
                <script src="../js/flop_chart0.8.3/jquery.flot.pie.min.js" type="text/javascript"></script>-->
        <!--fin graficos chart-->
        <script src="../assets/js/jquery-ui/jquery-ui-1.10.4.custom.js" type="text/javascript"></script>
        <link href="../js/css/selectbox.css" rel="stylesheet" type="text/css"/>
        <!--<link rel="stylesheet" href="//code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">-->


        <script src="../js/validacion.js" type="text/javascript"></script>
        <script src="../js/dtic.js" type="text/javascript"></script>

        <script src="../assets/js/plugins/jqgrid/jquery.jqGrid.min.js"></script>
        <!--<script src="../assets/js/plugins/jqgrid/i18n/grid.locale-en.js"></script>-->
        <script src="../assets/js/plugins/jqgrid/i18n/grid.locale-es.js"></script>
        <script src="../assets/js/plugins/jqgrid/jquery.jqGrid.fluid.js"></script>
        <script src="../assets/js/plugins/bootstrap-datepicker/bootstrap-datepicker.js"></script>

        <!--para que funcione alertyfy-->
        <script src="../alertify/alertify.js" type="text/javascript"></script>
        <link href="../alertify/css/alertify.css" crossorigin="anonymous" rel="stylesheet" />
        <link href="../alertify/css/themes/semantic.css" rel="stylesheet" >

        <!--para que funcione el calendar-->
        <link href='../js/fullcalendar3.9.0/fullcalendar.min.css' rel='stylesheet' />
        <link href='../js/fullcalendar3.9.0/fullcalendar.print.min.css' rel='stylesheet' media='print' />
        <script src='../js/fullcalendar3.9.0/lib/moment.min.js'></script>
        <!--<script src='../js/fullcalendar3.9.0/lib/jquery.min.js'></script>-->
        <script src='../js/fullcalendar3.9.0/fullcalendar.min.js'></script>
        <script src="../js/fullcalendar3.9.0/locale-all.js" type="text/javascript"></script>

        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.10.1/sweetalert2.all.min.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.10.1/sweetalert2.css">
        <script src="../assets/js/plugins/select2/select2.min.js" type="text/javascript"></script>
        <!--<script src="../js/jquery.validate.min.js" type="text/javascript"></script>-->
        <!--para que funcione la aplicacion-->
        <!--<link rel="stylesheet" href="https://cdn.jsdelivr.net/simplemde/latest/simplemde.min.css"> edicoon text en un text area-->
        <!--<script src="https://cdn.jsdelivr.net/simplemde/latest/simplemde.min.js"></script>-->
        <script src="../js/ugt.js" type="text/javascript"></script>
        <script src="../protected/Administrador/Conductores/Conductores.js" type="text/javascript"></script>
        <script src="../protected/Administrador/Vehiculos/Vehiculos.js" type="text/javascript"></script>
        <script src="../protected/SuperAdministrador/Usuarios/Usuarios.js" type="text/javascript"></script>
        <script src="../protected/SuperAdministrador/Roles/Roles.js" type="text/javascript"></script>
        <script src="../protected/Solicitudes/SolicitudUsuario/Solicitud.js" type="text/javascript"></script>
        <script src="../protected/Solicitudes/SolicitudesGestion/Solicitudes.js" type="text/javascript"></script>
        <script src="../protected/Solicitudes/SolicitudesGestionVA/SolicitudesVA.js" type="text/javascript"></script>
        <script src="../protected/Administrador/SalvoConductos/SalvoConductos.js" type="text/javascript"></script>
        <script src="../protected/Administrador/Reportes/Reportes.js" type="text/javascript"></script>
    </body>
</html>