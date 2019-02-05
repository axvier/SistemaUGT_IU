<%-- 
    Document   : UsuariosVista
    Created on : 25/11/2018, 08:27:33 PM
    Author     : Xavy PC
--%>
<%@page import="ugt.entidades.Tbcargos"%>
<%@page import="ugt.cargos.iu.CargosIU"%>
<%@page import="ugt.entidades.Tbroles"%>
<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="ugt.entidades.Tbentidad"%>
<%@page import="utg.roles.iu.RolesIU"%>
<%@page import="ugt.entidades.iu.EntidadesIU"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="ugt.entidades.Tbusuariosentidad"%>
<%@page import="ugt.usuariosentidades.iu.UsuariosEntidadesIU"%>
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
            <li>
                <a id="mnCondOcup" href="#" onclick="addModalEntidadRol('modGeneralUsuarios', 'tbUsuariosG')">
                    <span class="fa-stack fa-lg"></i><i class="fa fa-cogs fa-stack-2x"></i></span>Add Entidad-Rol
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
} else if (accion.equals("modalAddGEntidadRol")) {
    String cedulaGU = (String) session.getAttribute("cedulaUG");
    session.setAttribute("cedulaUG", null);
    EntidadesIU entidadesIU = (EntidadesIU) session.getAttribute("entidadesIU");
    RolesIU rolIU = (RolesIU) session.getAttribute("rolesIU");
    session.setAttribute("entidadesIU", null);
    CargosIU cargosIU = (CargosIU) session.getAttribute("cargosIU");
    session.setAttribute("cedulaUG", null);
%>
<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
    <h4 class="modal-title" id="modalLicenciaTitulo"> UGT | Entidad Rol </h4>
</div>
<div class="modal-body">
    <input type="hidden" value="<%=cedulaGU%>" id="cedulaGU">
    <ul class="nav nav-tabs nav-tabs-right">
        <li class="active"><a href="#tabitem1" data-toggle="tab">Agregar Entidad Rol <span class="badge element-bg-color-green"><i class="fa fa-plus"></i></span></a></li>
        <li><a href="#tabitem2" data-toggle="tab" onclick="fncVerEntidadesRolesAsginados('tabitem2')">Ver Entidad-Rol asignadas <span class="badge element-bg-color-blue"><i class="fa fa-eye"></i></span></a></li>
    </ul>
    <div class="tab-content">
        <div class="tab-pane fade in active" id="tabitem1">
            <form id="formAddGU_E_R" class="form-horizontal" role="form" onsubmit="fncAddGU_E_R(this.id);return false;">
                <div class="form-group">
                    <label  class="col-sm-2 control-label" for="addGUEntidad">Entidades</label>
                    <div class="col-sm-10">
                        <select name="tbentidad" class="form-control selectpicker" id="addGUEntidad" data-live-search="true" required>
                            <%
                                if (entidadesIU != null) {
                                    G = new GsonBuilder().setDateFormat("yyyy-MM-dd'T'HH:mm:ss").create();
                                    out.println("<option disabled value='' selected hidden>--Escoja uno --</option>");
                                    for (Tbentidad entidad : entidadesIU.getLista()) {
                                        out.println("<option data-tokens='" + entidad.getCodigoentidad() + "' data-json='" + G.toJson(entidad) + "' data-idtipoentidad='" + entidad.getIdtipo().getIdtipo() + "'> " + entidad.getCodigoentidad() + " - " + entidad.getNombre() + " </option>");
                                    }
                                }
                            %>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label" for="addGURol" >Roles</label>
                    <div class="col-sm-10">
                        <select name="tbroles" class="form-control selectpicker" id="addGURol" data-live-search="true" required>
                            <%
                                if (rolIU != null) {
                                    G = new GsonBuilder().setDateFormat("yyyy-MM-dd'T'HH:mm:ss").create();
                                    out.println("<option disabled value='' selected hidden>--Escoja uno --</option>");
                                    for (Tbroles rol : rolIU.getLista()) {
                                        if (!rol.getEstado().equals("Deshabilitado")) {
                                            out.println("<option data-tokens='" + rol.getIdrol() + "' data-json='" + G.toJson(rol) + "' data-gerarquia='" + rol.getGerarquia().getIdtipo() + "'> [" + rol.getCharrol() + "] - " + rol.getDescripcion() + " </option>");
                                        }
                                    }
                                }
                            %>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label" for="addGUCargo" >Cargo</label>
                    <div class="col-sm-10">
                        <select name="tbroles" class="form-control selectpicker" id="addGUCargo" data-live-search="true" required>
                            <%
                                out.println("<option disabled value='' selected hidden>--Escoja un cargo --</option>");
                                if (cargosIU != null) {
                                    for (Tbcargos cargo : cargosIU.getLista()) {
                                        out.println("<option data-tokens='" + cargo.getCargo() + "' data-json='" + G.toJson(cargo) + "'> " + cargo.getCargo() + " </option>");
                                    }
                                }
                            %>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label" for="addGUfechainicio" >Fecha inicio</label>
                    <div class="col-sm-10">
                        <input id="addGUfechainicio" type="date" class="form-control" value="" required>
                    </div>
                </div>
                <!--                <div class="form-group">
                                    <label class="col-sm-2 control-label" for="addGUfechafin" >Fecha fin</label>
                                    <div class="col-sm-10">
                                        <input id="addGUfechafin" type="date" class="form-control" value="">
                                    </div>
                                </div>-->
                <hr>
                <div class="container text-right">
                    <button type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-times-circle"></i> Cerrar </button>
                    <button type="submit" class="btn btn-success" id="btnAddGU_E_R"><i class="fa fa-check-circle"></i> Guardar </button>
                </div>
            </form>
        </div>
        <div class="tab-pane fade" id="tabitem2">
            <table id="tableEntidadRolVer" class="table table-striped table-hover">
                <thead>        
                    <tr>            
                        <th>Entidad</th>         
                        <th>Rol</th>          
                        <th>Fecha inicio</th>       
                        <th>Fecha Fin</th>       
                    </tr>   
                </thead> 
                <tbody>
                </tbody>
            </table>
        </div>
    </div>
</div>
<!--<div class="modal-footer">-->
<%
} else if (accion.equals("divModalVerEntidadRol")) {
    UsuariosEntidadesIU userentityrol = (UsuariosEntidadesIU) session.getAttribute("userentityrol");
    session.setAttribute("userentityrol", null);
%>
<div id="jqgrid-wrapper">
    <%
        if (userentityrol != null) {
    %>
    <table id="tableEntidadRolVer" class="table table-striped table-condensed">
        <thead>        
            <tr>            
                <th>Entidad</th>         
                <th>Rol</th>          
                <th>Cargo</th>          
                <th>F Inicio</th>       
                <th>F Fin</th>       
                <th>Acciones</th>       
            </tr>   
        </thead> 
        <tbody>
            <%
                SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
                int count = 0;
                G = new GsonBuilder().setDateFormat("yyyy-MM-dd'T'HH:mm:ss-05:00").create();
                for (Tbusuariosentidad aux : userentityrol.getLista()) {
                    out.println("    <input id='row" + count + "' type='hidden' value='' data-json='" + G.toJson(aux) + "'/>");
                    out.println("    <tr>");
                    out.println("        <td>" + aux.getTbentidad().getCodigoentidad() + "</td>");
                    out.println("        <td>" + aux.getTbroles().getDescripcion() + "</td>");
                    out.println("        <td>" + aux.getCargo() + "</td>");
                    out.println("        <td>" + sf.format(aux.getFechainicio()) + "</td>");
                    String ffin = (aux.getFechafin() == null) ? "" : sf.format(aux.getFechafin());
                    out.println("        <td>" + ffin + "</td>");
                    out.println("        <td><button id='delU-E-T'onclick=\"fncEliminarGU_E_R('" + count + "')\" class='btn btn-danger' title='Elimninar entidad Rol'><i class='fa fa-trash'></i></button>");
                    out.println("        <button onclick=\"fncTerminarGU_E_R('" + count++ + "')\" class='btn btn-info' title='Finalizar entidad Rol'><i class='fa fa-exclamation-triangle '></i></button></td>");
                    out.println("    </tr>");
                }
            %>
        </tbody>
    </table>
    <%
        } else {
            out.println("<p>No se le ha asignado a ninguna entidad-rol</p>");
        }
    %>
</div>
<%
        }
    } else {
        response.sendError(501, this.getServletName() + "-> Error no se ha logueado en el sistema contacte con proveedor");
    }

%>