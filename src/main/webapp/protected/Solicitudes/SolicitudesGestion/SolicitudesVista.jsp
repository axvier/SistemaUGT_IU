<%-- 
    Document   : SolicitudesVista
    Created on : 5/01/2019, 05:56:08 PM
    Author     : Xavy PC
--%>

<%@page import="ugt.entidades.Tbroles"%>
<%@page import="ugt.entidades.Tbentidad"%>
<%@page import="ugt.entidades.Tbusuarios"%>
<%@page import="ugt.entidades.Tbusuariosentidad"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="utg.login.Login"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Login login = (Login) session.getAttribute("login");
    if (login != null) {
        String accion = request.getParameter("accion");
        Gson G = new Gson();
        if (accion.equals("jsonVacio")) {
            String datos = "{\"rows\":\"\"}";
            out.println(datos);
        } else if (accion.equals("jsonSolicitudesEnviados")) {
            String json = (String) session.getAttribute("arrayJSON");
            session.setAttribute("arrayJSON", null);
            out.print(json);
        } else if (accion.equals("guardarStatus")) {
            String respuesta = (String) session.getAttribute("statusGuardar");
            String codigo = (String) session.getAttribute("statusCodigo");
            session.setAttribute("statusGuardar", null);
            session.setAttribute("statusCodigo", null);
            String result = "{"
                    + "\"respuesta\":\"" + respuesta + "\","
                    + "\"codigo\":\"" + codigo + "\""
                    + "}";
            response.setContentType("text/plain");
            response.getWriter().write(result);
        } else if (accion.equals("modificarStatus")) {
            String respuesta = (String) session.getAttribute("statusMod");
            String codigo = (String) session.getAttribute("statusCodigo");
            session.setAttribute("statusMod", null);
            session.setAttribute("statusCodigo", null);
            String result = "{"
                    + "\"respuesta\":\"" + respuesta + "\","
                    + "\"codigo\":\"" + codigo + "\""
                    + "}";
            response.setContentType("text/plain");
            response.getWriter().write(result);
        } else if (accion.equals("eliminarStatus")) {
            String respuesta = (String) session.getAttribute("statusDelete");
            String codigo = (String) session.getAttribute("statusCodigo");
            session.setAttribute("statusDelete", null);
            session.setAttribute("statusCodigo", null);
            String result = "{"
                    + "\"respuesta\":\"" + respuesta + "\","
                    + "\"codigo\":\"" + codigo + "\""
                    + "}";
            response.setContentType("text/plain");
            response.getWriter().write(result);
        } else if (accion.equals("tableSolicitudesNuevas")) {
%>
<!--<div class="main-header">
    <h2>UGT</h2>
    <em>Solicitudes nuevas recividas</em>
</div>-->
<div class="main-content">
    <!-- MODAL DIALOG -->
    <div class="modal fade" id="modGeneralSolicitudes" tabindex="-1" role="dialog" aria-labelledby="modGeneralSolicitudes" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">

            </div>
        </div>
    </div>
    <!-- END MODAL DIALOG -->
    <div>
        <ul class="list-inline file-main-menu">
            <li>
                <a id="mnUsuarioSol" href="#" onclick="" class="inactive">
                    <span class="fa-stack fa-lg"><i class="fa fa-user fa-stack-2x"></i></span> Solictante
                </a>
            </li>
            <li>
                <a id="mnViajeSol" href="#" onclick="" class="inactive">
                    <span class="fa-stack fa-lg"><i class="fa fa-plane fa-stack-2x"></i></span> Detalles Viaje
                </a>
            </li>
            <li>
                <a id="mnPasjerosSol" href="#" onclick="" class="inactive">
                    <span class="fa-stack fa-lg"></i><i class="fa fa-users fa-stack-2x"></i></span>Pasajeros
                </a>
            </li>
            <li>
                <a id="mnReqPDF" href="#" onclick="" class="inactive">
                    <span class="fa-stack fa-lg"></i><i class="fa fa-eye fa-stack-2x"></i></span>PDF requisitos
                </a>
            </li>
            <li>
                <a id="mnListarSolG" href="#" onclick="" class="inactive">
                    <span class="fa-stack fa-lg"></i><i class="fa fa-navicon fa-stack-2x"></i></span>Lista
                </a>
            </li>
        </ul>
    </div>
    <div class="row">
        <div class="col-lg-6 pull-right">
            <div class="input-group">
                <input id="search_cells" type="text" class="form-control x-campaigns-filter">
                <span class="input-group-btn">
                    <button class="btn btn-custom-primary" type="button" disabled="disabled"><i class="fa fa-search"></i></button>
                </span>
            </div>
        </div>
    </div><br>
    <div class="widget widget-table" id="gSolicitudes_body">
        <div class="widget-header">
            <h3><i class="fa fa-table"></i> Sección </h3><em>Lista nuevas solicitudes</em>
        </div>
        <div class="widget-content">
            <div id="jqgrid-wrapper">
                <table id="tbSolicitudesNuevas" class="table table-striped table-hover">
                    <thead>
                        <tr>
                            <th>id</th>
                            <th>estado</th>
                            <th>fecha</th>
                            <th>Motivo</th>
                            <th></th>
                        </tr>
                    </thead>
                </table>
                <div id="tbSolicitudesNuevas_pager"></div>
            </div>
        </div>
    </div> 
</div>
<%
} else if (accion.equals("modSolicitanteInfo")) {
    Tbusuariosentidad userSol = (Tbusuariosentidad) session.getAttribute("userSol");
    String idSolicitud = (String) session.getAttribute("idSolicitud");
    session.setAttribute("userSol", null);
    session.setAttribute("idSolicitud", null);
%>
<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
    <h4 class="modal-title" id="modalLicenciaTitulo"> Solicitud <%=idSolicitud%> | Datos usuario de la solicitud </h4>
</div>
<div class="modal-body">
    <form class="form-horizontal" role="form">
        <%
            if (userSol != null) {
                Tbusuarios user = (userSol.getTbusuarios() != null) ? userSol.getTbusuarios() : null;
                if (user != null) {

        %>
        <h4>Datos personales</h4>
        <table class='table table-striped table-hover'>
            <thead>
                <tr>
                    <th>Cedula</th>   
                    <th>Nombres</th>          
                    <th>Apellidos</th>       
                    <th>Email</th>       
                </tr>   
            </thead>
            <tbody>
                <tr>
                    <td><%=user.getCedula()%></td>
                    <td><%=user.getNombres()%></td>
                    <td><%=user.getApellidos()%></td>
                    <td><%=user.getEmail()%></td>
                </tr>
            </tbody>
        </table>
        <%
            } else
                out.println("<h4>NO HAY INFORMACION DEL USUARIO DUEÑO DE LA SOLICITUD</h4>");
            Tbentidad entidad = (userSol.getTbentidad() != null) ? userSol.getTbentidad() : null;
            Tbroles roles = (userSol.getTbroles() != null) ? userSol.getTbroles() : null;
            if (entidad != null && roles != null) {
        %>
        <h4>Información del cargo en la institución</h4>
        <label  class="control-label">Cargo: </label>
        <div class="form-group">
            <div class="col-sm-10">
                <input type="text" class="form-control" value="<%=roles.getDescripcion()%>" title="<%=roles.getDescripcion()%>" readonly/>
            </div>
        </div>
        <label  class="control-label">Entidad: </label>
        <div class="form-group">
            <div class="col-sm-10">
                <input type="text" class="form-control" value="<%=entidad.getNombre()%>" title="<%=entidad.getNombre()%>" readonly/>
            </div>
        </div>
        <%
                } else
                    out.println("<h4>NO HAY INFORMACION DEL CARGO EN LA INSTITUCIÓN</h4>");
            } else {
                out.println("<h4>NO HAY INFORMACIÓN DEL USUARIO DUEÑO DE LA SOLICITUD</h4>");
            }
        %>
    </form>
</div>
<div class='modal-footer'>
    <button type='button' class='btn btn-default' data-dismiss='modal'><i class='fa fa-times-circle'></i> Close</button>
</div>
<%
} else if (accion.equals("disponibilidadVehiculoConductor")) {
    Tbusuariosentidad userSol = (Tbusuariosentidad) session.getAttribute("userSol");
    String idSolicitud = (String) session.getAttribute("idSolicitud");
    session.setAttribute("userSol", null);
    session.setAttribute("idSolicitud", null);
%>
<div class="widget-header">
    <h3><i class="fa fa-table"></i> Sección </h3><em>Lista nuevas solicitudes</em>
</div>
<div class="widget-content">
    <div id="jqgrid-wrapper">
        <table id="tbSolicitudesNuevas" class="table table-striped table-hover">
            <thead>
                <tr>
                    <th>id</th>
                    <th>estado</th>
                    <th>fecha</th>
                    <th>Motivo</th>
                    <th></th>
                </tr>
            </thead>
        </table>
        <div id="tbSolicitudesNuevas_pager"></div>
    </div>
</div>
<%
        }
    } else {
        response.sendError(501, this.getServletName() + "-> Error no se ha logueado en el sistema contacte con proveedor");
    }
%>
