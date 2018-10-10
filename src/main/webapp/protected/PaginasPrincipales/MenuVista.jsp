<%-- 
    Document   : MenuVista
    Created on : 10/10/2018, 11:48:29 AM
    Author     : Xavy PC
--%>

<%@page import="ugt.entidades.Tbopciones"%>
<%@page import="ugt.opciones.iu.OpcionesIU"%>
<%@page import="utg.login.Login"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Login login = (Login) session.getAttribute("login");
    if (login != null) {
        if (login.getRolActivo().getCharrol().equals("Admin")) {
%>
<link href="../../assets/css/skins/fulldark.css" rel="stylesheet" type="text/css"/>
<%} else if (login.getRolActivo().getCharrol().equals("Sadmi")) {
%>
<link href="../../assets/css/skins/slategray.css" rel="stylesheet" type="text/css"/>
<%} else {
%>
<link href="../../assets/css/skins/darkblue.css" rel="stylesheet" type="text/css"/>
<%}%>
<script src="assets/js/jquery/jquery-2.1.0.min.js"></script>
<script src="assets/js/king-common.js"></script>

<div class="sidebar-minified js-toggle-minified">
    <i class="fa fa-exchange"></i>

</div>
<div class="sidebar-scroll">
    <nav class="main-nav">
        <ul class="main-menu">
            <%
                String accion = request.getParameter("accion");
                if (accion.equals("mostrarMenu")) {
                    OpcionesIU opcionesIU = (OpcionesIU) session.getAttribute("opcionesIU");
//                        String menu = opcionesIU.htmlMenu();
//                        String data = "{\"contenido\":\"" + menu + "\"}";
//                        response.setCharacterEncoding("UTF-8");
//                        response.getWriter().write(data);
                    for (Tbopciones opc : opcionesIU.getLista()) {
                        if (opc.getIdopcion().equals(1)) {//Menu Gestión roles - usuarios - opciones
            %>
            <li style='cursor: pointer'>
                <a onclick="fncGestionUsuarios();">
                    <i class="fa fa-users"></i><span class="text">Usuarios</span>
                </a>
            </li>
            <li style='cursor: pointer'>
                <a onclick="fncGestionRoles();">
                    <i class="fa fa-registered fa-fw"></i><span class="text">Roles</span>
                </a>
            </li>
            <li style='cursor: pointer'>
                <a onclick="fncGestionOpciones();">
                    <i class="fa fa-puzzle-piece fa-fw"></i><span class="text">Opciones</span>
                </a>
            </li>
            <%
                }
                if (opc.getIdopcion().equals(2)) {//Menu Gestión Entidades
            %>
            <li id="<%out.println(opc.getIdopcion());%>"><a href="#" class="js-sub-menu-toggle"><i class="fa fa-tasks"></i><span class="text">Gestión entidad</span>
                    <i id="ico1" class="toggle-icon fa fa-angle-left"></i></a>
                <ul id="submenu1" class="sub-menu ">
                    <li style='cursor: pointer'>
                        <a onclick="fncGestionEntidades()">
                            <i class="fa fa-university"></i><span class="text">Entidades</span>
                        </a>
                    </li>
                    <li style='cursor: pointer'>
                        <a onclick="fncGestionTipoEntidad()">
                            <i class="fa fa-list"></i><span class="text">Tipo entidad</span>
                        </a>
                    </li>
                </ul>
            </li>
            <%
                }
                if (opc.getIdopcion().equals(3)) {//Menu Gestión Conductores
            %>
            <li id="<%out.println(opc.getIdopcion());%>"><a href="#" class="js-sub-menu-toggle"><i class="fa fa-drivers-license fa-fw"></i><span class="text">Gestión conductores</span>
                    <i id="ico1" class="toggle-icon fa fa-angle-left"></i></a>
                <ul id="submenu1" class="sub-menu ">
                    <li style='cursor: pointer'>
                        <a onclick="fncGestionChoferes()">
                            <i class="fa fa-user-circle"></i><span class="text">Conductores disponibles</span>
                        </a>
                    </li>
                    <li style='cursor: pointer'>
                        <a onclick="fncGestionChoferesBlock()">
                            <i class="fa fa-user-times"></i><span class="text">Conductores bloqueados</span>
                        </a>
                    </li>
                </ul>
            </li>
            <%
                }
                if (opc.getIdopcion().equals(4)) {//Menu Gestión Vehiculos
            %>
            <li id="<%out.println(opc.getIdopcion());%>"><a href="#" class="js-sub-menu-toggle"><i class="fa fa-truck fa-fw"></i><span class="text">Gestión vehiculos</span>
                    <i id="ico1" class="toggle-icon fa fa-angle-left"></i></a>
                <ul id="submenu1" class="sub-menu ">
                    <li style='cursor: pointer'>
                        <a onclick="fncGestionAuto()">
                            <i class="fa fa-car"></i><span class="text">Vehiculos disponibles</span>
                        </a>
                    </li>
                    <li style='cursor: pointer'>
                        <a onclick="fncGestionAutoBlock()">
                            <i class="fa fa-lock"></i><span class="text">Vehiculos bloqueados</span>
                        </a>
                    </li>
                </ul>
            </li>
            <%
                }
                if (opc.getIdopcion().equals(5)) {//Menu Gestión Solicitudes
            %>
            <li id="<%out.println(opc.getIdopcion());%>"><a href="#" class="js-sub-menu-toggle"><i class="fa fa-briefcase fa-fw"></i><span class="text">Gestión solicitudes</span>
                    <i id="ico1" class="toggle-icon fa fa-angle-left"></i></a>
                <ul id="submenu1" class="sub-menu ">
                    <li style='cursor: pointer'>
                        <a onclick="fncGestionSolicitudesAdmin()">
                            <i class="fa fa-list-ul"></i><span class="text">Solicitudes nuevas</span>
                        </a>
                    </li>
                    <li style='cursor: pointer'>
                        <a onclick="fncGestionSProcesadasAdmin()">
                            <i class="fa fa-sticky-note"></i><span class="text">Solicitudes en proceso</span>
                        </a>
                    </li>
                </ul>
            </li>
            <%
                }
                if (opc.getIdopcion().equals(6)) {//Menu Gestión Ordenes de Movilizacion
            %>
            <li id="<%out.println(opc.getIdopcion());%>"><a href="#" class="js-sub-menu-toggle"><i class="fa fa-briefcase fa-fw"></i><span class="text">Gestión salvoconductos</span>
                    <i id="ico1" class="toggle-icon fa fa-angle-left"></i></a>
                <ul id="submenu1" class="sub-menu ">
                    <li style='cursor: pointer'>
                        <a onclick="fncGenerarOrden()">
                            <i class="fa fa-tachometerl"></i><span class="text">Generar Orden</span>
                        </a>
                    </li>
                    <li style='cursor: pointer'>
                        <a onclick="fncGeListaOrden()">
                            <i class="fa fa-server"></i><span class="text">Lista de Ordenes</span>
                        </a>
                    </li>
                </ul>
            </li>
            <%
                            }
                if (opc.getIdopcion().equals(6)) {//Menu Para Reportes
            %>
            <li id="<%out.println(opc.getIdopcion());%>"><a href="#" class="js-sub-menu-toggle"><i class="fa fa-clone fa-fw"></i><span class="text">Reportes</span>
                    <i id="ico1" class="toggle-icon fa fa-angle-left"></i></a>
                <ul id="submenu1" class="sub-menu ">
                    <li style='cursor: pointer'>
                        <a onclick="fncReporteConductores()">
                            <i class="fa fa-tachometerl"></i><span class="text">Conductores</span>
                        </a>
                    </li>
                    <li style='cursor: pointer'>
                        <a onclick="fncReporteConductores()">
                            <i class="fa fa-tachometerl"></i><span class="text">Vehiculos</span>
                        </a>
                    </li>
                    <li style='cursor: pointer'>
                        <a onclick="fncReporteConductores()">
                            <i class="fa fa-tachometerl"></i><span class="text">Vehiculos</span>
                        </a>
                    </li>
                </ul>
            </li>
            <%
                            }
                        }
                    }

                } else {
                    response.sendError(501, this.getServletName() + "-> Error no se ha logueado en el sistema contacte con proveedor");
                }
            %>
        </ul>
    </nav>
</div>