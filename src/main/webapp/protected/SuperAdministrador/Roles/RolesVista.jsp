<%-- 
    Document   : RolesVista
    Created on : 29/11/2018, 11:42:27 PM
    Author     : Xavy PC
--%>

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
                <a id="mnCondOcup" href="#" onclick="fncRecargarJQG('tbRolesG', 'protected/SuperAdministrador/Roles/', 'RolesControlador.jsp?opc=jsonRoles')">
                    <span class="fa-stack fa-lg"></i><i class="fa fa-retweet fa-stack-2x"></i></span>Recargar
                </a>
            </li>
            <li>
                <a id="mnCondOcup" href="#" onclick="addModalEntidadRol('modGeneralUsuarios', 'tbUsuariosG')">
                    <span class="fa-stack fa-lg"></i><i class="fa fa-puzzle-piece fa-stack-2x"></i></span>Add Rol-Opcion
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
    <form id="formAddGRol" class="form-horizontal" role="form" onsubmit="fncAddGRol(this.id);return false;">
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
</div>
<%        }
    } else {
        response.sendError(501, this.getServletName() + "-> Error no se ha logueado en el sistema contacte con proveedor");
    }

%>