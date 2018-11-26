<%-- 
    Document   : UsuariosVista
    Created on : 25/11/2018, 08:27:33 PM
    Author     : Xavy PC
--%>
<%@page import="com.google.gson.Gson"%>
<%@page import="utg.login.Login"%>
<%
    Login login = (Login) session.getAttribute("login");
    if (login != null) {
        String accion = request.getParameter("accion");
        Gson G = new Gson();
        if (accion.equals("jsonVacio")) {
            String datos = "{\"rows\":\"\"}";
            out.println(datos);
        } else if (accion.equals("jsonUsuarios")) {
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
        } else if (accion.equals("tableUsuarios")) {
%>
<div class="main-header">
    <h2>UGT</h2>
    <em>Gestión usuarios</em>
</div>
<div class="main-content">
    <!-- MODAL DIALOG -->
    <div class="modal fade" id="modGeneralUsuarios" tabindex="-1" role="dialog" aria-labelledby="modGeneralUsuarios" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">

            </div>
        </div>
    </div>
    <!-- END MODAL DIALOG -->
    <div>
        <ul class="list-inline file-main-menu">
            <li>
                <a data-toggle="modal" onclick="addModalUsuario('modGeneralUsuarios')" style='cursor: pointer'>
                    <span class="fa-stack fa-lg"><i class="fa fa-user-plus fa-stack-2x"></i></span> Nuevo Usuario
                </a>
            </li>
            <li>
                <a id="mnCondOcup" href="#" onclick="fncRecargatTGUsuarios('tbUsuariosG')">
                    <span class="fa-stack fa-lg"></i><i class="fa fa-retweet fa-stack-2x"></i></span>Recargar
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
            <h3><i class="fa fa-table"></i> Gestión </h3><em>Tabla de edición</em>
        </div>
        <div class="widget-content">
            <div id="jqgrid-wrapper">
                <table id="tbUsuariosG" class="table table-striped table-hover">
                    <thead>
                        <tr>
                            <th>Cédula</th>
                            <th>Email</th>
                            <th>Nombres</th>
                            <th>Apellidos</th>
                            <th>Tipo</th>
                            <th>Estado</th>
                            <th></th>
                        </tr>
                    </thead>
                </table>
                <div id="tbUsuariosG_pager"></div>
            </div>
        </div>
    </div> 
</div>
<%
} else if (accion.equals("modalAddGUsuario")) {
%>
<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
    <h4 class="modal-title" id="modalLicenciaTitulo"> UGT | Nuevo usuario </h4>
</div>
<div class="modal-body">
    <form id="formAddGUsuario" class="form-horizontal" role="form" onsubmit="fncAddGUsuario(this.id);return false;">
        <div class="form-group">
            <label  class="col-sm-2 control-label" for="addGCedula">Cédula</label>
            <div class="col-sm-10">
                <input type="text" name="cedula" class="form-control" id="addGCedula" placeholder="123456789-0" onchange="validarCedula(this.id, 'btnAddUsuario')" maxlength="10" required/>
                <div id="salida"></div>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label" for="addGEmail" >Email</label>
            <div class="col-sm-10">
                <input type="email" name="email" class="form-control" id="addGEmail" placeholder="ejemplo@ejempl.com" required/>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label" for="addGNombres" >Nombres</label>
            <div class="col-sm-10">
                <input type="text" name="nombres" class="form-control" id="addGNombres" placeholder="Nombres" required/>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label" for="addGApellidos" >Apellidos</label>
            <div class="col-sm-10">
                <input type="text" name="apellidos" class="form-control" id="addGApellidos" placeholder="Apellidos" required/>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label" for="addGTipo" >Tipo</label>
            <div class="col-sm-10">
                <select name="tipo" class="form-control" id="addGTipo" placeholder="Tipo">
                    <option>Oasis</option>
                    <option>Instituto</option>
                </select>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label" for="addGEstado" >Estado</label>
            <div class="col-sm-10">
                <select name="estado" class="form-control" id="addGEstado" placeholder="Estado">
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
<%
        }
    } else {
        response.sendError(501, this.getServletName() + "-> Error no se ha logueado en el sistema contacte con proveedor");
    }

%>