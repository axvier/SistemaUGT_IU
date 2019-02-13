<%@page import="ugt.vehiculosdependencias.iu.VehiculosDependenciasIU"%>
<%@page import="ugt.entidades.Tbvehiculosdependencias"%>
<%@page import="ugt.entidades.Tbentidad"%>
<%@page import="ugt.entidades.iu.EntidadesIU"%>
<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="ugt.entidades.Tbrevisionesmecanicas"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="ugt.revisionesmecanicas.iu.RevisionesMecanicasIU"%>
<%@page import="ugt.entidades.Tbvehiculosconductores"%>
<%@page import="ugt.vehiculosconductores.iu.VehiculosConductoresIU"%>
<%@page import="ugt.entidades.Tbgrupovehiculos"%>
<%@page import="ugt.gruposvehiculos.iu.GruposVehiculosIU"%>
<%@page import="utg.login.Login"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Login login = (Login) session.getAttribute("login");
    if (login != null) {
        String accion = request.getParameter("accion");
        Gson G = new Gson();
        if (accion.equals("jsonVehiculos")) {
            String json = (String) session.getAttribute("arrayJSON");
            session.setAttribute("arrayJSON", null);
            out.print(json);
        } else if (accion.equals("respuesta")) {
            String respuesta = (String) session.getAttribute("respuesta");
            String result = "{"
                    + "\"respuesta\":\"" + respuesta + "\""
                    + "}";
            response.setContentType("text/plain");
            response.getWriter().write(result);
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
        } else if (accion.equals("eliminarStatus")) {
            String respuesta = (String) session.getAttribute("statusEliminar");
            session.setAttribute("statusEliminar", null);
            String result = "{"
                    + "\"respuesta\":\"" + respuesta + "\""
                    + "}";
            response.setContentType("text/plain");
            response.getWriter().write(result);
        } else if (accion.equals("modificarStatus")) {
            String respuesta = (String) session.getAttribute("statusMod");
            session.setAttribute("statusMod", null);
            String result = "{"
                    + "\"respuesta\":\"" + respuesta + "\""
                    + "}";
            response.setContentType("text/plain");
            response.getWriter().write(result);
        } else if (accion.equals("downloadPDFOrden")) {
            String result = (String) session.getAttribute("pdf64");
            session.setAttribute("pdf64", null);
            if (result != null) {
                response.setContentType("text/plain");
                response.getWriter().write("{\"respuesta\":\"" + result + "\"}");
            } else {
                response.setContentType("text/plain");
                response.getWriter().write("{\"respuesta\":\"vacio\"}");
            }
        } else if (accion.equals("tableVehiculos")) {
%>
<div class="main-header">
    <h2>UGT</h2>
    <em>Vehiculos</em>
</div>
<div class="main-content">
    <!-- MODAL DIALOG -->
    <div class="modal fade" id="modGeneralVehiculo" tabindex="-1" role="dialog" aria-labelledby="modGeneralVehiculo" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">

            </div>
        </div>
    </div>
    <!-- END MODAL DIALOG -->
    <!-- MODAL DIALOG -->
    <div class="modal fade" id="miModalVehiculo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="myModalLabel">UGT | Vehículo Nuevo</h4>
                </div>
                <div class="modal-body">
                    <form id="formAddVehiculo" class="form-horizontal" role="form" onsubmit="fncaddNuevoVehiculo();return false;">
                        <div class="form-group">
                            <label  class="col-sm-2 control-label" for="addPlaca">Placa</label>
                            <div class="col-sm-10">
                                <input type="text" name="placa" class="form-control" id="addPlaca" placeholder="ABC1234" onchange="validarMatricula(this.id)" maxlength="7" required/>
                                <div id="salida"></div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label" for="addDisco" >Disco</label>
                            <div class="col-sm-10">
                                <input type="text" name="disco" class="form-control" id="addDisco" placeholder="0" required/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label" for="addMarca" >Marca</label>
                            <div class="col-sm-10">
                                <input type="text" name="marca" class="form-control" id="addMarca" placeholder="Mazda" required/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label" for="addModelo" >Modelo</label>
                            <div class="col-sm-10">
                                <input type="text" name="modelo" class="form-control" id="addModelo" placeholder="Nuevo" required/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label" for="addMotor" >Motor</label>
                            <div class="col-sm-10">
                                <input type="text" name="modelo" class="form-control" id="addMotor" placeholder="Numero motor" required/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label" for="addAnio" >Año matricula</label>
                            <div class="col-sm-10">
                                <input type="number" name="anio" class="form-control" id="addAnio" placeholder="2000" max="2500" min="1990" required/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label" for="addColor" >Color</label>
                            <div class="col-sm-10">
                                <input type="text" name="color" class="form-control" id="addColor" placeholder="Blanco" required/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label" for="addDescrip" >Descripción</label>
                            <div class="col-sm-10">
                                <input type="text" name="descripcion" class="form-control" id="addDescrip" placeholder="Descripción breve" required/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label" for="addGrupo" >Grupo</label>
                            <div class="col-sm-10">
                                <select name="idgrupo" class="form-control selectpicker" id="addGrupo" data-live-search="true">
                                    <%
                                        GruposVehiculosIU grupoVehiculosIU = (GruposVehiculosIU) session.getAttribute("grupoVehiculosIU");
                                        if (grupoVehiculosIU != null) {
                                            for (Tbgrupovehiculos grupoV : grupoVehiculosIU.getLista()) {
                                                out.println("<option data-tokens='" + grupoV.getIdgrupo() + "' data-idgrupo='" + grupoV.getIdgrupo() + "' data-detalle='" + grupoV.getDetalle() + "'>" + grupoV.getNombre() + "</option>");
                                            }
                                        }
                                    %>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label" for="addEstado" >Estado</label>
                            <div class="col-sm-10">
                                <select name="estado" class="form-control" id="addEstado" placeholder="Estado">
                                    <option>Disponible</option>
                                </select>
                            </div>
                        </div>
                        <hr>
                        <div class="form-group">
                            <button type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-times-circle"></i> Cerrar</button>
                            <button type="submit" class="btn btn-success"><i class="fa fa-check-circle"></i>Guardar</button>
                        </div>
                    </form>
                </div>
                <!--<div class="modal-footer"></div>-->
            </div>
        </div>
    </div>
    <!-- END MODAL DIALOG -->
    <div>
        <ul class="list-inline file-main-menu">
            <li>
                <a data-toggle="modal" data-target="#miModalVehiculo" style='cursor: pointer'>
                    <span class="fa-stack fa-lg"><i class="fa fa-plus-circle fa-stack-2x"></i></span>Add vehículo
                </a>
            </li>
            <li>
                <a  id="mnCondDisp" href="#" onclick="cambiarJQGVehiculo('jsonVehiculos')">
                    <span class="fa-stack fa-lg"></i><i class="fa fa-truck fa-stack-2x"></i></span>Disponibles
                </a>
            </li>
            <li>
                <a id="mnCondOcup" href="#" onclick="cambiarJQGVehiculo('jsonVehiculosOcup')">
                    <span class="fa-stack fa-lg"></i><i class="fa fa-bus fa-stack-2x"></i><i class="fa fa-group fa-stack-1x"></i></span>Con Conductores
                </a>
            </li>
            <li>
                <a id="mnCondOcup" href="#" onclick="verVehiculoConductor('modGeneralVehiculo')">
                    <span class="fa-stack fa-lg"></i><i class="fa fa-file-o fa-stack-2x"></i><i class="fa fa-user fa-stack-1x"></i></span>Conductor asignado
                </a>
            </li>
            <li>
                <a id="mnCondOcup" href="#" onclick="addModalRevisionMecanica('modGeneralVehiculo', 'jqgridVehiculo')">
                    <span class="fa-stack fa-lg"></i><i class="fa fa-gavel fa-stack-2x"></i></span>Revision Mecánica
                </a>
            </li>
            <li>
                <a id="mnCondOcup" href="#" onclick="addModalDependencia('modGeneralVehiculo', 'jqgridVehiculo')">
                    <span class="fa-stack fa-lg"></i><i class="fa fa-university fa-stack-2x"></i></span>Dependencias
                </a>
            </li>
        </ul>
    </div>
    <div class="row">
        <div class="col-lg-4 pull-right">
            <label class="col-sm-3 control-label">Busqueda general</label>
            <div class="input-group">
                <input id="search_cells" type="search" class="form-control">
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
                <table id="jqgridVehiculo" class="table table-hover">
                    <tr>
                        <td></td>
                    </tr>
                </table>
                <div id="jqgVehiculo_pager"></div>
            </div>
        </div>
    </div> 
</div>
<script>
    $(document).ready(function () {
        $("#addDisco").keydown(function (e) {
            // Allow: backspace, delete, tab, escape and enter
            if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 110]) !== -1 ||
                    // Allow: Ctrl+A
                            (e.keyCode === 65 && e.ctrlKey === true) ||
                            // Allow: home, end, left, right
                                    (e.keyCode >= 35 && e.keyCode <= 39)) {
                        // let it happen, don't do anything
                        return;
                    }
                    // Ensure that it is a number and stop the keypress
                    if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
                        e.preventDefault();
                    }
                });
        $("#addMotor").keydown(function (e) {
            // Allow: backspace, delete, tab, escape and enter
            if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 110]) !== -1 ||
                    // Allow: Ctrl+A
                            (e.keyCode === 65 && e.ctrlKey === true) ||
                            // Allow: home, end, left, right
                                    (e.keyCode >= 35 && e.keyCode <= 39)) {
                        // let it happen, don't do anything
                        return;
                    }
                    // Ensure that it is a number and stop the keypress
                    if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
                        e.preventDefault();
                    }
                });
        $("#addAnio").keydown(function (e) {
            // Allow: backspace, delete, tab, escape and enter
            if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 110]) !== -1 ||
                    // Allow: Ctrl+A
                            (e.keyCode === 65 && e.ctrlKey === true) ||
                            // Allow: home, end, left, right
                                    (e.keyCode >= 35 && e.keyCode <= 39)) {
                        // let it happen, don't do anything
                        return;
                    }
                    // Ensure that it is a number and stop the keypress
                    if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
                        e.preventDefault();
                    }
                });
    });
</script>
<%
} else if (accion.equals("tableVehiculosUnlock")) {
%>
<div class="main-header">
    <h2>UGT</h2>
    <em>Vehiculos dados de baja</em>
</div>
<div class="main-content">
    <!-- MODAL DIALOG -->
    <!--    <div class="modal fade" id="miModalVehiculo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title" id="myModalLabel">UGT | Vehículo Nuevo</h4>
                    </div>
                    <div class="modal-body">
                        <form id="formAddVehiculo" class="form-horizontal" role="form" onsubmit="fncaddNuevoVehiculo(); return false;">
                            <div class="form-group">
                                <label  class="col-sm-2 control-label" for="addPlaca">Placa</label>
                                <div class="col-sm-10">
                                    <input type="text" name="placa" class="form-control" id="addPlaca" placeholder="ABC-1234" maxlength="8" required/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="addDisco" >Disco</label>
                                <div class="col-sm-10">
                                    <input type="text" name="disco" class="form-control" id="addDisco" placeholder="0" required/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="addMarca" >Marca</label>
                                <div class="col-sm-10">
                                    <input type="text" name="marca" class="form-control" id="addMarca" placeholder="Mazda" required/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="addModelo" >Modelo</label>
                                <div class="col-sm-10">
                                    <input type="text" name="modelo" class="form-control" id="addModelo" placeholder="Nuevo" required/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="addAnio" >Año</label>
                                <div class="col-sm-10">
                                    <input type="number" name="anio" class="form-control" id="addAnio" placeholder="2000" max="2500" min="1990" required/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="addColor" >Color</label>
                                <div class="col-sm-10">
                                    <input type="text" name="color" class="form-control" id="addColor" placeholder="Blanco" required/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="addDescrip" >Descripción</label>
                                <div class="col-sm-10">
                                    <textarea name="descripcion" class="form-control" id="addDescrip" placeholder="Descripción breve" required/></textarea>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="addGrupo" >Grupo</label>
                                <div class="col-sm-10">
                                    <select name="idgrupo" class="form-control selectpicker" id="addGrupo" data-live-search="true">
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="addEstado" >Estado</label>
                                <div class="col-sm-10">
                                    <select name="estado" class="form-control" id="addEstado" placeholder="Estado">
                                        <option>Disponible</option>
                                    </select>
                                </div>
                            </div>
                            <hr>
                            <div class="form-group">
                                <button type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-times-circle"></i> Cerrar</button>
                                <button type="submit" class="btn btn-success"><i class="fa fa-check-circle"></i>Guardar</button>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer"></div>
                </div>
            </div>
        </div>-->
    <!-- END MODAL DIALOG -->
    <!--    <div>
            <ul class="list-inline file-main-menu">
                <li>
                    <a data-toggle="modal" data-target="#miModalVehiculo" style='cursor: pointer'>
                        <span class="fa-stack fa-lg"><i class="fa fa-plus-circle fa-stack-2x"></i></span> Nuevo vehículo
                    </a>
                </li>
                <li>
                    <a  id="mnCondDisp" href="#" onclick="cambiarJQGVehiculo('jsonVehiculos')">
                        <span class="fa-stack fa-lg"></i><i class="fa fa-truck fa-stack-2x"></i></span>Vehículos disponibles
                    </a>
                </li>
                <li>
                    <a id="mnCondOcup" href="#" onclick="cambiarJQGVehiculo('jsonVehiculosOcup')">
                        <span class="fa-stack fa-lg"></i><i class="fa fa-bus fa-stack-2x"></i><i class="fa fa-group fa-stack-1x"></i></span>Vehículos ocupados
                    </a>
                </li>
            </ul>
        </div>-->
    <!--    <div class="row">
            <div class="col-lg-6 pull-right">
                <div class="input-group">
                    <input id="search_cells" type="search" class="form-control">
                    <span class="input-group-btn">
                        <button class="btn btn-custom-primary" type="button" disabled="disabled"><i class="fa fa-search"></i></button>
                    </span>
                </div>
            </div>
        </div><br>-->
    <div class="widget widget-table">
        <div class="widget-header">
            <h3><i class="fa fa-table"></i> Gestión </h3><em>Tabla de edición</em>
        </div>
        <div class="widget-content">
            <div id="jqgrid-wrapper">
                <table id="jqgridVehiculoUnlock" class="table table-hover">
                    <tr>
                        <td></td>
                    </tr>
                </table>
                <div id="jqgVehiculoUnlock_pager"></div>
            </div>
        </div>
    </div> 
</div>
<%
} else if (accion.equals("contentModalVerCond")) {
    VehiculosConductoresIU vehiculosConductoresIU = (VehiculosConductoresIU) session.getAttribute("vehiculosConductoresIU");
    session.setAttribute("vehiculosConductoresIU", null);
%>
<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
    <h4 class="modal-title" id="modalLicenciaTitulo">UGT | Ver conductor</h4>
</div>
<div class="modal-body">
    <div class="widget-content">
        <div id="jqgrid-wrapper">
            <%
                if (vehiculosConductoresIU != null) {
            %>
            <table id="jqgVerConductor" class="table table-striped table-hover">
                <thead>        
                    <tr>            
                        <th>Cedula</th>         
                        <th>Nombre</th>          
                        <th>Apellidos</th>       
                    </tr>   
                </thead> 
                <tbody>
                    <%
                        for (Tbvehiculosconductores vehcond : vehiculosConductoresIU.getLista()) {
                            out.println("    <tr>");
                            out.println("        <td>" + vehcond.getTbconductores().getCedula() + "</td>");
                            out.println("        <td>" + vehcond.getTbconductores().getNombres() + "</td>");
                            out.println("        <td>" + vehcond.getTbconductores().getApellidos() + "</td>");
                            out.println("    </tr>");
                        }
                    %>
                </tbody>
            </table>
            <%
                } else {
                    out.println("<p>No se le ha asignado un conductor</p>");
                }
            %>
        </div>
    </div>
</div>
<div class="modal-footer">
    <button type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-times-circle"></i> Cerrar</button>
</div>
<%
} else if (accion.equals("jsonVacio")) {
    String datos = "{\"rows\":\"\"}";
    out.println(datos);
} else if (accion.equals("modRevisionM")) {
    String matricula = (String) session.getAttribute("placaRM");
    session.setAttribute("placaRM", null);
%>
<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
    <h4 class="modal-title" id="modalLicenciaTitulo">Vehículo <%=matricula%>| Revisiones mecánicas</h4>
</div>
<div class="modal-body">
    <input type="hidden" value="<%=matricula%>" id="placaRM">
    <ul class="nav nav-tabs nav-tabs-right">
        <li class="active"><a href="#tabitem1" data-toggle="tab"><i class="fa fa-plus fa-2x"></i>  Add revisión mecánica</a></li>
        <li><a href="#tabitem2" data-toggle="tab" onclick="fncVerListaRevisiones('tabitem2', 'tjqgRevision')"><i class="fa fa-eye fa-2x text-center"></i>  Lista revisiones</a></li>
    </ul>
    <div class="tab-content">
        <div class="tab-pane fade in active" id="tabitem1">
            <form id="formAddGU_E_R" class="form-horizontal" role="form" onsubmit="fncAddRevisionMForm(this.id, 'modGeneralVehiculo');return false;">
                <div class="form-group">
                    <label  class="col-sm-2 control-label" for="addRMDetalle">Detalle: </label>
                    <div class="col-sm-10">
                        <input id="addRMDetalle" type="text" class="form-control" value="" required>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label" for="addRMFecha" >Fecha: </label>
                    <div class="col-sm-10">
                        <input id="addRMFecha" type="datetime-local" class="form-control" value="" required>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label" for="filePDF" >PDF revisión: </label>
                    <div class="col-sm-10">
                        <input id="filePDF"  type="file" style="display:block;" accept=".pdf" required/>
                    </div>
                </div>
                <hr>
                <div class="text-right">
                    <button type="submit" class="btn btn-success" id="btnAddGU_E_R"><i class="fa fa-check-circle"></i> Guardar </button>
                </div>
            </form>
        </div>
        <div class="tab-pane fade" id="tabitem2">
            <div id="jqgrid-wrapper">
                <table id="tjqgRevision" class="table table-hover">
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
                <div id="tjqgRevision_pager"></div>
            </div>
        </div>
    </div>
</div>
<div class="modal-footer">
    <button type="button" class="btn btn-default" data-dismiss="modal" id="modGeneralVehiculo_Cerrar" onclick="cerrarModRevisionM('modGeneralVehiculo')"><i class="fa fa-times-circle"></i> Cerrar</button>
</div>
<%
} else if (accion.equals("modDependencia")) {
    String matricula = (String) session.getAttribute("placaRM");
    session.setAttribute("placaRM", null);
    EntidadesIU entidadesIU = (EntidadesIU) session.getAttribute("entidadesRM");
    session.setAttribute("entidadesRM", null);
%>
<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
    <h4 class="modal-title" id="modalLicenciaTitulo">Vehículo <%=matricula%>| Dependencia </h4>
</div>
<div class="modal-body">
    <input type="hidden" value="<%=matricula%>" id="placaRM">
    <ul class="nav nav-tabs nav-tabs-right">
        <li class="active"><a href="#tabitem1" data-toggle="tab"><i class="fa fa-plus fa-2x"></i>  Agregar dependencia</a></li>
        <li><a href="#tabitem2" data-toggle="tab" onclick="fncVerVehiculoDependencias('tabitem2', '<%=matricula%>')"><i class="fa fa-eye fa-2x text-center"></i>  Historial dependencias</a></li>
    </ul>
    <div class="tab-content">
        <div class="tab-pane fade in active" id="tabitem1">
            <form id="formAddGU_E_R" class="form-horizontal" role="form" onsubmit="fncAddVhiculoDependencia(this.id, 'modGeneralVehiculo', '<%=matricula%>');return false;">
                <div class="form-group">
                    <label class="col-sm-2 control-label" for="addGUEntidad" >Entidad</label>
                    <div class="col-sm-10">
                        <select name="tbentidad" class="select2" id="addGUEntidad" data-live-search="true" required>
                            <%
                                if (entidadesIU != null) {
                                    G = new GsonBuilder().setDateFormat("yyyy-MM-dd'T'HH:mm:ss").create();
                                    out.println("<option disabled value='' selected hidden>--Escoja una entidad --</option>");
                                    for (Tbentidad entidad : entidadesIU.getLista()) {
//                                        if (entidad.getIdpadre() != null) {
                                        String opcion = "<option data-tokens='" + entidad.getCodigoentidad()
                                                + "' data-json='" + G.toJson(entidad) + "'> "
                                                + entidad.getCodigoentidad() + " - " + entidad.getNombre();
                                        if (entidad.getIdpadre() != null && entidad.getIdpadre().getCodigoentidad() != null) {
                                            opcion += " pertenece a: " + entidad.getIdpadre().getCodigoentidad();
                                        }
                                        opcion += " </option>";
                                        out.println(opcion);
//                                        }
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
                <hr>
                <div class="text-right">
                    <button type="submit" class="btn btn-success" id="btnAddGU_E_R"><i class="fa fa-check-circle"></i> Agregar </button>
                </div>
            </form>
        </div>
        <div class="tab-pane fade" id="tabitem2">
            <div id="jqgrid-wrapper">
                <table id="tableDependenciaVver" class="table table-hover">
                    <thead>        
                        <tr>            
                            <th>Entidad</th>         
                            <th>Vehiculo</th>         
                            <th>Fecha inicio</th>       
                            <th>Fecha Fin</th>       
                            <th>Acciones</th>       
                        </tr>   
                    </thead> 
                    <tbody>
                    </tbody>
                </table>
                <div id="tableDependenciaVver-pager"></div>
            </div>
        </div>
    </div>
</div>
<div class="modal-footer">
    <button type="button" class="btn btn-default" data-dismiss="modal" id="modGeneralVehiculo_Cerrar"><i class="fa fa-times-circle"></i> Cerrar</button>
</div>
<script>
    $(document).ready(function () {
        $('#addGUEntidad').select2();
    });
</script>
<%
} else if (accion.equals("divModalVerVehiculoEntida")) {
    VehiculosDependenciasIU vehiculodepenencia = (VehiculosDependenciasIU) session.getAttribute("vehiculoDependencia");
    session.setAttribute("vehiculoDependencia", null);
%>
<div id="jqgrid-wrapper">
    <%
        if (vehiculodepenencia != null) {
    %>
    <table id="tableEntidadRolVer" class="table table-striped table-condensed">
        <thead>        
            <tr>            
                <th>Entidad</th>         
                <th>Vehiculo</th>          
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
                for (Tbvehiculosdependencias aux : vehiculodepenencia.getLista()) {
                    out.println("    <input id='row" + count + "' type='hidden' value='' data-json='" + G.toJson(aux) + "'/>");
                    out.println("    <tr>");
                    out.println("        <td>" + aux.getTbentidad().getCodigoentidad() + "</td>");
                    out.println("        <td>" + aux.getTbvehiculos().getDisco() + " " + aux.getTbvehiculos().getPlaca() + "</td>");
                    out.println("        <td>" + sf.format(aux.getTbvehiculosdependenciasPK().getFechainicio()) + "</td>");
                    String ffin = (aux.getFechafin() == null) ? "" : sf.format(aux.getFechafin());
                    out.println("        <td>" + ffin + "</td>");
                    out.println("        <td><button id='delV-E-T'onclick=\"fncEliminarGU_V_E('" + count + "')\" class='btn btn-danger' title='Elimninar vehiculo dependencia'><i class='fa fa-trash'></i></button>");
                    if (ffin.length() == 0) {
                        out.println("        <button onclick=\"fncTerminarGU_V_E('" + count++ + "')\" class='btn btn-info' title='Finalizar vehiculo dependencia'><i class='fa fa-exclamation-triangle '></i></button></td>");
                    }
                    out.println("    </tr>");
                }
            %>
        </tbody>
    </table>
    <%
        } else {
            out.println("<p>No se le ha asignado a ninguna dependencia</p>");
        }
    %>
</div>
<%
        } else {
        }
    } else {
        response.sendError(501, this.getServletName() + "-> Error no se ha logueado en el sistema contacte con proveedor");
    }

%>