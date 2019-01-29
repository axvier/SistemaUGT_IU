<%-- 
    Document   : RolesVista
    Created on : 29/11/2018, 11:42:27 PM
    Author     : Xavy PC
--%>

<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="ugt.entidades.Tbroles"%>
<%@page import="ugt.entidades.Tbopciones"%>
<%@page import="utg.roles.iu.RolesIU"%>
<%@page import="ugt.rolesopciones.IU.RolesOpcionesIU"%>
<%@page import="ugt.opciones.iu.OpcionesIU"%>
<%@page import="ugt.entidades.Tbtipoentidad"%>
<%@page import="ugt.tiposentidades.iu.TiposEntidadesIU"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="utg.login.Login"%>
<%
    Login login = (Login) session.getAttribute("login");
    if (login != null) {
        String accion = request.getParameter("accion");
        Gson g = new Gson();
        if (accion.equals("jsonVacio")) {
            String datos = "{\"rows\":\"\"}";
            out.println(datos);
        } else if (accion.equals("jsonRoles")) {
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
        } else if (accion.equals("tableGRoles")) {
%>
<div class="main-header">
    <h2>UGT</h2>
    <em>Gestión usuarios</em>
</div>
<div class="main-content">
    <!-- MODAL DIALOG -->
    <div class="modal fade" id="modGestionRol" tabindex="-1" role="dialog" aria-labelledby="modGestionRol" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">

            </div>
        </div>
    </div>
    <!-- END MODAL DIALOG -->
    <div>
        <ul class="list-inline file-main-menu">
            <li>
                <a data-toggle="modal" onclick="addModalGRol('modGestionRol')" style='cursor: pointer'>
                    <span class="fa-stack fa-lg"><i class="fa fa-plus-circle fa-stack-2x"></i></span> Nuevo Rol
                </a>
            </li>
            <li>
                <a id="mnCondOcup" href="#" onclick="fncRecargarJQG('tbRolesG', '../protected/SuperAdministrador/Roles/', 'RolesControlador.jsp?opc=jsonRoles')">
                    <span class="fa-stack fa-lg"></i><i class="fa fa-retweet fa-stack-2x"></i></span>Recargar
                </a>
            </li>
            <li>
                <a id="mnCondOcup" href="#" onclick="" class="inactive">
                    <span class="fa-stack fa-lg"></i><i class="fa fa-list-alt fa-stack-2x"></i></span>Lista de roles
                </a>
            </li>
            <li>
                <!--<a id="mnCondOcup" href="#" onclick="addModalRolOpcion('modGestionRol', 'tbRolesG')">-->
                <a id="mnCondOcup" href="#" onclick="fncAsignarRolOpcion()">
                    <span class="fa-stack fa-lg"></i><i class="fa fa-puzzle-piece fa-stack-2x"></i></span>Add Rol-Opcion
                </a>
            </li>
        </ul>
    </div>
    <div class="row">
        <div class="col-lg-4 pull-right">
            <label class="col-sm-3 control-label">Busqueda general</label>
            <div class="input-group">
                <input id="search_cells" type="text" class="form-control x-campaigns-filter">
                <span class="input-group-btn">
                    <button class="btn btn-custom-primary" type="button" disabled="disabled"><i class="fa fa-search"></i></button>
                </span>
            </div>
        </div>
    </div><br>
    <div class="widget widget-table">
        <div class="widget-header">
            <h3><i class="fa fa-table"></i> Gestión </h3><em>Tabla de edición para roles</em>
        </div>
        <div class="widget-content">
            <div id="jqgrid-wrapper">
                <table id="tbRolesG" class="table table-striped table-hover">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Rol</th>
                            <th>Descripción</th>
                            <th>Jerarquía</th>
                            <th>Estado</th>
                        </tr>
                    </thead>
                </table>
                <div id="tbRolesG_pager"></div>
            </div>
        </div>
    </div> 
</div>
<%
} else if (accion.equals("selectTipoEntidad")) {
    TiposEntidadesIU tiposentidadesIU = (TiposEntidadesIU) session.getAttribute("tiposentidadesIU");
    session.setAttribute("tiposentidadesIU", null);
%>
<select>
    <%
        if (tiposentidadesIU != null) {
            for (Tbtipoentidad aux : tiposentidadesIU.getLista()) {
                out.println("<option value='" + aux.getIdtipo() + "' data-descripcion='" + aux.getDescripcion() + "'>" + aux.getDescripcion() + "</option>");
            }
        }
    %>
</select>

<%
} else if (accion.equals("modalAddRol")) {
    TiposEntidadesIU tiposentidadesIU = (TiposEntidadesIU) session.getAttribute("tiposentidadesIU");
    session.setAttribute("tiposentidadesIU", null);
%>
<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
    <h4 class="modal-title" id="modalLicenciaTitulo"> UGT | Nuevo Rol </h4>
</div>
<div class="modal-body">
    <form id="formAddGRol" class="form-horizontal" role="form" onsubmit="fncAddGRol(this.id, 'modGestionRol', 'tbRolesG');return false;">
        <div class="form-group">
            <label  class="col-sm-2 control-label" for="addGRCharRol">Siglas del rol</label>
            <div class="col-sm-10">
                <input type="text" name="charrol" class="form-control" id="addCharRol" placeholder="ejemplo de siglas: SecGT" maxlength="5" required/>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label" for="addGRDescripcion" >Descripción</label>
            <div class="col-sm-10">
                <input type="text" name="descripcion" class="form-control" id="addGRDescripcion" placeholder="Descripción breve" required/>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label" for="addGRGerarquia" >Jerarquía</label>
            <div class="col-sm-10">
                <select name="gerarquia" class="form-control" id="addGRGerarquia" title="nivel de jerarquía">
                    <%
                        if (tiposentidadesIU != null) {
                            out.println("<option disabled value='' selected hidden>--Escoja uno --</option>");
                            for (Tbtipoentidad aux : tiposentidadesIU.getLista()) {
                                out.println("<option data-tokens='" + aux.getIdtipo() + "' data-descripcion='" + aux.getDescripcion() + "'>" + aux.getDescripcion() + "</option>");
                            }
                        }
                    %>
                </select>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label" for="addGREstado" >Estado</label>
            <div class="col-sm-10">
                <select name="estado" class="form-control" id="addGREstado" title="Escoja el estado que tendrá">
                    <option>Habilitado</option>
                    <option>Deshabilitado</option>
                </select>
            </div>
        </div>
        <hr>
        <div class="container text-right">
            <button type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-times-circle"></i> Cerrar </button>
            <button type="submit" class="btn btn-success" id="btnAddUsuario"><i class="fa fa-check-circle"></i> Guardar </button>
        </div>
    </form>
</div>
<!--<div class="modal-footer">-->
<!--</div>-->
<%
} else if (accion.equals("GAddGRolOpcion")) {
    RolesIU gRolesIU = (RolesIU) session.getAttribute("gRolesIU");
    session.setAttribute("gRolesIU", null);
    OpcionesIU opcionesIU = (OpcionesIU) session.getAttribute("gOpcionesIU");
    session.setAttribute("gOpcionesIU", null);
%>
<div class="main-header">
    <h2>UGT</h2>
    <em>Agragar Roles - Opciones</em>
</div>
<div class="main-content">
    <!-- MODAL DIALOG -->
    <div class="modal fade" id="modGestionRol" tabindex="-1" role="dialog" aria-labelledby="modGestionRol" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">

            </div>
        </div>
    </div>
    <!-- END MODAL DIALOG -->
    <div>
        <ul class="list-inline file-main-menu">
            <li>
                <a data-toggle="modal" style='cursor: pointer' class="inactive">
                    <span class="fa-stack fa-lg"><i class="fa fa-plus-circle fa-stack-2x"></i></span> Nuevo Rol
                </a>
            </li>
            <li>
                <a id="mnCondOcup" href="#" class="inactive">
                    <span class="fa-stack fa-lg"></i><i class="fa fa-retweet fa-stack-2x"></i></span>Recargar
                </a>
            </li>
            <li>
                <a id="mnCondOcup" href="#" onclick="fncGestionRoles()">
                    <span class="fa-stack fa-lg"></i><i class="fa fa-list-alt fa-stack-2x"></i></span>Lista de roles
                </a>
            </li>
            <li>
                <a id="mnCondOcup" href="#" onclick="fncAsignarRolOpcion()">
                    <span class="fa-stack fa-lg"></i><i class="fa fa-puzzle-piece fa-stack-2x"></i></span>Add Rol-Opcion
                </a>
            </li>
        </ul>
    </div>
    <!-- HORIZONTAL FORM -->
    <div class="widget">
        <div class="widget-header">
            <h3><i class="fa fa-edit"></i> Asignaciones </h3></div>
        <div class="widget-content">
            <form class="form-horizontal" role="form" id="formAddR-O" onsubmit="fncAddGRol_Opcion(this.id);return false;">
                <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label for="addGRol" class="control-label sr-only">Roles</label>
                            <!--<input type="text" class="form-control" id="contact-name" placeholder="Name">-->
                            <select name="tbroles" class="form-control selectpicker" id="addGRol" data-live-search="true" required onchange="changeSelectRol(this.id, 'chksOpcionesRol')">
                                <option disabled value='' selected hidden>--Escoja uno --</option>
                                <%
                                    if (gRolesIU != null) {
                                        g = new GsonBuilder().setDateFormat("yyyy-MM-dd'T'HH:mm:ss").create();
                                        out.println("");
                                        for (Tbroles rol : gRolesIU.getLista()) {
                                            if (!rol.getEstado().equals("Deshabilitado")) {
                                                out.println("<option data-tokens='" + rol.getIdrol() + "' data-json='" + g.toJson(rol) + "'> [" + rol.getCharrol() + "] " + rol.getDescripcion() + " </option>");
                                            }
                                        }
                                    }
                                %>
                            </select>
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <button type="submit" class="btn btn-success" id="btnSR-O">Aplicar</button>
                        &nbsp&nbsp
                        <button type="button" class="btn btn-default" onclick="fncCheckAll('formAddR-O', 'chksOpcionesRol')">Todos</button>
                        <button type="button" class="btn btn-default" onclick="fncCheckAllNot('formAddR-O', 'chksOpcionesRol')">Ninguno</button>
                    </div>
                </div>
                <div class="row" id="chksOpcionesRol">
                    <div class="col-sm-2"></div>
                    <div class="col-sm-10">
                        <%
                            if (opcionesIU != null) {
                                for (Tbopciones opcion : opcionesIU.getLista()) {
                                    if (opcion.getEstado().equals("Habilitado")) {
                                        out.println("  <div class='input-group'>");
                                        out.println("    <label class='control-inline fancy-checkbox custom-bgcolor-green'>");
                                        out.println("      <input type='checkbox' name='gch" + opcion.getIdopcion() + "' value='" + opcion.getIdopcion() + "' data-estado='" + opcion.getEstado() + "' data-descripcion='" + opcion.getDescripcion() + "' data-accion='" + opcion.getAccion() + "'>");
                                        out.println("      <span>" + opcion.getDescripcion() + "</span>");
                                        out.println("    </label>");
                                        out.println("  </div>");
                                    }
                                }
                            }
                        %>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <!-- END HORIZONTAL FORM -->
</div>
<%
} else if (accion.equals("chksOpcionesRol")) {
    OpcionesIU gopcionesRol = (OpcionesIU) session.getAttribute("gopcionesRol");
    session.setAttribute("gopcionesRol", null);
    OpcionesIU opcionesIU = (OpcionesIU) session.getAttribute("gOpcionesIU");
    session.setAttribute("gOpcionesIU", null);
%>
<!--<div class="row" id="chksOpcionesRol">-->
<div class="col-sm-2"></div>
<div class="col-sm-10">
    <%        if (opcionesIU != null) {
            for (Tbopciones opcion : opcionesIU.getLista()) {
                if (opcion.getEstado().equals("Habilitado")) {
                    out.println("  <div class='input-group'>");
                    out.println("    <label class='control-inline fancy-checkbox custom-bgcolor-green'>");
                    if (gopcionesRol != null) {
                        if (gopcionesRol.existeItemID(opcion.getIdopcion()) != null) {
                            out.println("      <input type='checkbox' name='gch" + opcion.getIdopcion() + "' value='" + opcion.getIdopcion() + "' data-estado='" + opcion.getEstado() + "' data-descripcion='" + opcion.getDescripcion() + "' data-accion='" + opcion.getAccion() + "' checked>");
                        } else {
                            out.println("      <input type='checkbox' name='gch" + opcion.getIdopcion() + "' value='" + opcion.getIdopcion() + "' data-estado='" + opcion.getEstado() + "' data-descripcion='" + opcion.getDescripcion() + "' data-accion='" + opcion.getAccion() + "'>");
                        }
                    } else {
                        out.println("      <input type='checkbox' name='gch" + opcion.getIdopcion() + "' value='" + opcion.getIdopcion() + "' data-estado='" + opcion.getEstado() + "' data-descripcion='" + opcion.getDescripcion() + "' data-accion='" + opcion.getAccion() + "'>");
                    }
                    out.println("      <span>" + opcion.getDescripcion() + "</span>");
                    out.println("    </label>");
                    out.println("  </div>");
                }
            }
        }
    %>
</div>
<!--</div>-->
<%
        }
    } else {
        response.sendError(501, this.getServletName() + "-> Error no se ha logueado en el sistema contacte con proveedor");
    }

%>