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
        } else if (accion.equals("tableVehiculos")) {
%>
<div class="main-header">
    <h2>UGT</h2>
    <em>Vehiculos</em>
</div>
<div class="main-content">
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
                    <span class="fa-stack fa-lg"></i><i class="fa fa-bus fa-stack-2x"></i><i class="fa fa-group fa-stack-1x"></i></span>Vehículos con Conductores
                </a>
            </li>
            <li>
                <a id="mnCondOcup" href="#" onclick="verVehiculoConductor()">
                    <span class="fa-stack fa-lg"></i><i class="fa fa-file-o fa-stack-2x"></i><i class="fa fa-user fa-stack-1x"></i></span>Ver conductor asignado
                </a>
            </li>
        </ul>
    </div>
    <div class="row">
        <div class="col-lg-6 pull-right">
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
                <table id="jqgridVehiculo" class="table table-striped table-hover">
                    <tr>
                        <td></td>
                    </tr>
                </table>
                <div id="jqgVehiculo_pager"></div>
            </div>
        </div>
    </div> 
</div>
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
                <table id="jqgridVehiculoUnlock" class="table table-striped table-hover">
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
        }
    } else {
        response.sendError(501, this.getServletName() + "-> Error no se ha logueado en el sistema contacte con proveedor");
    }

%>