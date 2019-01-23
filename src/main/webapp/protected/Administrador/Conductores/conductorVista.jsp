<%@page import="java.text.SimpleDateFormat"%>
<%@page import="ugt.entidades.Tbvehiculos"%>
<%@page import="ugt.entidades.Tbvehiculosconductores"%>
<%@page import="ugt.vehiculos.iu.VehiculosIU"%>
<%@page import="ugt.vehiculosconductores.iu.VehiculosConductoresIU"%>
<%@page import="utg.login.Login"%>
<%@page import="ugt.licencias.IU.LicenciasIU"%>
<%@page import="ugt.conductores.iu.ConductoresIU"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Login login = (Login) session.getAttribute("login");
    if (login != null) {
        String accion = request.getParameter("accion");
        Gson G = new Gson();
        if (accion.equals("conductoresConfg")) { //cargar conductores desde los datos de la solicitud
            ConductoresIU conductoresIU = (ConductoresIU) session.getAttribute("ConductoresIU");
            session.setAttribute("ConductoresIU", null);
            String resultado = conductoresIU.toHTML();
            response.setContentType("text/plain");
            response.getWriter().write(resultado);
        } else if (accion.equals("respuesta")) {
            String respuesta = (String) session.getAttribute("respuesta");
            session.setAttribute("respuesta", null);
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
        } else if (accion.equals("tableConductores")) {
%>
<div class="main-header">
    <h2>UGT</h2>
    <em>Conductores</em>
</div>
<div class="main-content">
    <!-- MODAL DIALOG -->
    <div class="modal fade" id="miModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="myModalLabel">UGT | Conductor Nuevo</h4>
                </div>
                <div class="modal-body">
                    <form id="formAddCond" class="form-horizontal" role="form" onsubmit="fncaddNuevoConductor(); return false;">
                        <div class="form-group">
                            <label  class="col-sm-2 control-label" for="addCedula">Cédula</label>
                            <div class="col-sm-10">
                                <input type="text" name="cedula" class="form-control" id="addCedulaConductor" placeholder="123456789-0" onchange="validarCedula(this.id, 'btnAddCond')" maxlength="10" required/>
                                <div id="salida"></div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label" for="addNombres" >Nombres</label>
                            <div class="col-sm-10">
                                <input type="text" name="nombres" class="form-control" id="addNombres" placeholder="Nombres" required/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label" for="addApellidos" >Apellidos</label>
                            <div class="col-sm-10">
                                <input type="text" name="apellidos" class="form-control" id="addApellidos" placeholder="Apellidos" required/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label" for="addGenero" >Género</label>
                            <div class="col-sm-10">
                                <select name="genero" class="form-control" id="addGenero" placeholder="Género">
                                    <option>Masculino</option>
                                    <option>Femenino</option>
                                    <option>Otros</option>
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
                        <div class="form-group">
                            <label class="col-sm-2 control-label" for="addFechanac" >Fecha Nacimiento</label>
                            <div class="col-sm-10">
                                <input type="date" name="fechanac" class="form-control" id="addFechanac" placeholder="2018-01-01" required/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label" for="addTelefono" >Teléfono</label>
                            <div class="col-sm-10">
                                <input type="text" name="telefono" class="form-control" id="addTelefono" placeholder="0000000000" maxlength="15" required/>
                            </div>
                        </div>
                        <hr>
                        <p>Licencia</p>
                        <div class="form-group">
                            <label class="col-sm-2 control-label" for="addTipo" >Tipo Licencia</label>
                            <div class="col-sm-10">
                                <select name="tipo" class="form-control selectpicker" id="addTipo" data-live-search="true">
                                    <option data-tokens="A">A</option>
                                    <option data-tokens="B">B</option>
                                    <option data-tokens="F">F</option>
                                    <option data-tokens="A1">A1</option>
                                    <option data-tokens="C">C</option>
                                    <option data-tokens="C1">C1</option>
                                    <option data-tokens="D">D</option>
                                    <option data-tokens="D1">D1</option>
                                    <option data-tokens="E">E</option>
                                    <option data-tokens="E1">E1</option>
                                    <option data-tokens="G">G</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label" for="addFechaexpedicion" >Fecha expedición</label>
                            <div class="col-sm-10">
                                <input type="date" name="fechaexpedicion" class="form-control" id="addFechaexpedicion" placeholder="2018-01-01" required/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label" for="addFechaexpiracion" >Fecha expiración</label>
                            <div class="col-sm-10">
                                <input type="date" name="fechaexpiracion" class="form-control" id="addFechaexpiracion" placeholder="2018-01-01" required/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label" for="addPuntos" >Puntos</label>
                            <div class="col-sm-10">
                                <input type="number" name="puntos" class="form-control" id="addPuntos" placeholder="30" required/>
                            </div>
                        </div>
                        <div class="form-group">
                            <button type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-times-circle"></i> Cerrar</button>
                            <button type="submit" class="btn btn-success" id="btnAddCond"><i class="fa fa-check-circle"></i> Guardar</button>
                        </div>
                    </form>
                </div>
                <div class="modal-footer"></div>
            </div>
        </div>
    </div>
    <!-- END MODAL DIALOG -->
    <!-- MODAL DIALOG -->
    <div class="modal fade" id="modalLicencia" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="modalLicenciaTitulo">UGT | Licencia información</h4>
                </div>
                <div class="modal-body">
                    <div class="widget-content">
                        <div id="jqgrid-wrapper">
                            <table id="jqgridCLicencia" class="table table-striped table-hover">
                                <tr>
                                    <td></td>
                                </tr>
                            </table>
                            <div id="jqgpager_licencia"></div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-times-circle"></i> Cerrar</button>
                </div>
            </div>
        </div>
    </div>
    <!-- END MODAL DIALOG -->
    <!-- MODAL DIALOG -->
    <div class="modal fade" id="modGeneralCond" tabindex="-1" role="dialog" aria-labelledby="modGeneralCond" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">

            </div>
        </div>
    </div>
    <!-- END MODAL DIALOG -->
    <div>
        <ul class="list-inline file-main-menu">
            <li>
                <a data-toggle="modal" data-target="#miModal" style='cursor: pointer'>
                    <span class="fa-stack fa-lg"><i class="fa fa-user-plus fa-stack-2x"></i></span> Nuevo Conductor
                </a>
            </li>
            <li>
                <a  id="mnCondDisp" href="#" onclick="cambiarJQGConductor('jsonConductores')">
                    <span class="fa-stack fa-lg"><i class="fa fa-check fa-stack-1x"></i><i class="fa fa-file-o fa-stack-2x"></i></span>Conductores
                </a>
            </li>
<!--            <li>
                <a id="mnCondOcup" href="#" onclick="cambiarJQGConductor('jsonConducOcup')">
                    <span class="fa-stack fa-lg"><i class="fa fa-exchange fa-stack-1x"></i><i class="fa fa-file-o fa-stack-2x"></i></span>Conductores con vehiculos
                </a>
            </li>-->
            <li>
                <a id="mnCondOcup" href="#" onclick="verLicenciaConductor()">
                    <span class="fa-stack fa-lg"><i class="fa fa-search fa-stack-1x"></i><i class="fa fa-credit-card fa-stack-2x"></i></span>Ver licencia
                </a>
            </li>
            <li>
                <a id="mnCondOcup" href="#" onclick="asignarVehiculosModal()">
                    <span class="fa-stack fa-lg"><i class="fa fa-taxi fa-stack-1x"></i><i class="fa fa-circle-thin fa-stack-2x"></i></span>Asignar vehiculos
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
                <table id="jqgridChofer" class="table table-striped table-hover">
                    <tr>
                        <td></td>
                    </tr>
                </table>
                <div id="jqgrid_pager"></div>
            </div>
        </div>
    </div> 
</div>
<script>
    $(document).ready(function () {
            $("#addTelefono").keydown(function (e) {
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
            $("#formGenSalvoC").submit(function () {
                $('#modGeneralSalvoConducto').modal('hide'); //or  $('#IDModal').modal('hide');
                saveOrdenSolicitud("SolicitudGenerar", "addGenKMinicio");
            });
        });
</script>
<%
} else if (accion.equals("jsonConductores")) {
    String json = (String) session.getAttribute("jsonArray");
    session.setAttribute("jsonArray", null);
    out.print(json);
} else if (accion.equals("jsonVacio")) {
    String datos = "{\"rows\":\"\"}";
    out.println(datos);
} else if (accion.equals("tableCondUnlock")) {
%>
<div class="main-header">
    <h2>UGT</h2>
    <em>Conductores Jubilados</em>
</div>
<div class="main-content">
    <!--    <div>
            <ul class="list-inline file-main-menu">
                <li>
                    <a data-toggle="modal" data-target="#miModal" style='cursor: pointer'>
                        <span class="fa-stack fa-lg"><i class="fa fa-user-plus fa-stack-2x"></i></span> Nuevo Conductor
                    </a>
                </li>
                <li>
                    <a  id="mnCondDisp" href="#" onclick="cambiarJQGConductor('jsonConductores')">
                        <span class="fa-stack fa-lg"><i class="fa fa-check fa-stack-1x"></i><i class="fa fa-file-o fa-stack-2x"></i></span>Conductores disponibles
                    </a>
                </li>
                <li>
                    <a id="mnCondOcup" href="#" onclick="cambiarJQGConductor('jsonConducOcup')">
                        <span class="fa-stack fa-lg"><i class="fa fa-exchange fa-stack-1x"></i><i class="fa fa-file-o fa-stack-2x"></i></span>Conductores ocupados
                    </a>
                </li>
                <li>
                    <a id="mnCondOcup" href="#" onclick="verLicenciaConductor()">
                        <span class="fa-stack fa-lg"><i class="fa fa-search fa-stack-1x"></i><i class="fa fa-credit-card fa-stack-2x"></i></span>Ver licencia
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
                <table id="jqgridChoferBloq" class="table table-striped table-hover">
                    <tr>
                        <td></td>
                    </tr>
                </table>
                <div id="jqgpager_bloq"></div>
            </div>
        </div>
    </div> 
</div>
<%
} else if (accion.equals("modalAsignarVehiculo")) {
    int vahiculosXpersona = 3;
    VehiculosConductoresIU vehConductoresIU = (VehiculosConductoresIU) session.getAttribute("vehConductoresIU");
    session.setAttribute("vehConductoresIU", null);
    VehiculosIU vehiculosIU = (VehiculosIU) session.getAttribute("vehiculosIU");
    session.setAttribute("vehiculosIU", null);
    String duenio = (vehConductoresIU != null) ? (vehConductoresIU.getLista().size() > 0) ? vehConductoresIU.getLista().get(0).getTbconductores().getNombres() : "" : "";
%>
<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
    <h4 class="modal-title" id="modalLicenciaTitulo">UGT | Asignación vehicular : <%=duenio%></h4>
</div>
<div class="modal-body">
    <form id="formAddVehiculosCond" class="form-horizontal" role="form" onsubmit="fncAddVehiculosConductor();return false;">
        <div class="widget-content">
            <div class="row">
                <div class="col-md-12">
                    <input type="hidden" value="<%=vahiculosXpersona%>" id="totalVehiculosXpersona">
                    <div id="salida"></div>
                    <%
                        for (int i = 0; i < vahiculosXpersona; i++) {
                    %>
                    <div class="input-group">
                        <span class="input-group-addon" style="background:  #ECF790;">Vehiculo <%=i%></span>
                        <select name="vehiculo" class="form-control selectpicker" data-live-search="true" id="vehiculoAsigAdd<%=i%>" required>
                            <%
                                String valor = "";
                                String date1 = "";
                                String date2 = "";
                                int cont = 0;
                                Tbvehiculosconductores search = (vehConductoresIU != null) ? (vehConductoresIU.getLista().size() > i) ? vehConductoresIU.itemPos(i) : null : null;
                                if (vehiculosIU != null) {
                                    for (Tbvehiculos vehiculo : vehiculosIU.getVehiculo()) {
                                        if (cont++ == 0) { // si estan en la primer vehiculo total
                                            if (search == null) { //vehiculo 1 con conductor es nulo sin vehiculo ni conductor
                                                valor = "<option disabled value='' selected hidden>--Escoja uno --</option>\n";
                                                valor += (vehiculo.getEstado().equals("Disponible"))
                                                        ? "<option class='disponibles' value='" + vehiculo.getPlaca() + "' data-jsonvehiculo='" + G.toJson(vehiculo) + "'>" + vehiculo.getDisco() + " | " + vehiculo.getMarca() + " " + vehiculo.getModelo() + " con placa " + vehiculo.getPlaca() + "</option>\n"
                                                        : "<option class='jubilados' disabled value='" + vehiculo.getPlaca() + "' data-jsonvehiculo='" + G.toJson(vehiculo) + "'>" + vehiculo.getDisco() + " | " + vehiculo.getMarca() + " " + vehiculo.getModelo() + " con placa " + vehiculo.getPlaca() + "</option>\n";
                                            } else {
                                                if (vehiculo.getPlaca().equals(search.getTbvehiculos().getPlaca())) { //primer vehiculo total es igual a vehiculo 1 con conductor
                                                    valor += "<option class='jubilados' value='" + search.getTbvehiculos().getPlaca() + "' data-jsonvehiculo='" + G.toJson(search.getTbvehiculos()) + "' selected='selected'>" + search.getTbvehiculos().getDisco() + " | " + search.getTbvehiculos().getMarca() + " " + search.getTbvehiculos().getModelo() + " con placa " + search.getTbvehiculos().getPlaca() + "</option>\n";
                                                    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
                                                    date1 = (search.getTbvehiculosconductoresPK().getFechainicio() != null) ? formatter.format(search.getTbvehiculosconductoresPK().getFechainicio()) : "";
                                                    date2 = (search.getFechafin() != null) ? formatter.format(search.getFechafin()) : "";
                                                } else {
                                                    valor = "<option disabled value='' selected hidden>--Escoja uno --</option>\n";
                                                    valor += (vehiculo.getEstado().equals("Disponible"))
                                                            ? "<option class='disponibles' value='" + vehiculo.getPlaca() + "' data-jsonvehiculo='" + G.toJson(vehiculo) + "'>" + vehiculo.getDisco() + " | " + vehiculo.getMarca() + " " + vehiculo.getModelo() + " con placa " + vehiculo.getPlaca() + "</option>\n"
                                                            : "<option class='jubilados' disabled value='" + vehiculo.getPlaca() + "' data-jsonvehiculo='" + G.toJson(vehiculo) + "'>" + vehiculo.getDisco() + " | " + vehiculo.getMarca() + " " + vehiculo.getModelo() + " con placa " + vehiculo.getPlaca() + "</option>\n";
                                                }
                                            }
                                        } else {
                                            if (search == null) {
                                                valor += (vehiculo.getEstado().equals("Disponible"))
                                                        ? "<option class='disponibles' value='" + vehiculo.getPlaca() + "' data-jsonvehiculo='" + G.toJson(vehiculo) + "'>" + vehiculo.getDisco() + " | " + vehiculo.getMarca() + " " + vehiculo.getModelo() + " con placa " + vehiculo.getPlaca() + "</option>\n"
                                                        : "<option class='jubilados' disabled value='" + vehiculo.getPlaca() + "' data-jsonvehiculo='" + G.toJson(vehiculo) + "'>" + vehiculo.getDisco() + " | " + vehiculo.getMarca() + " " + vehiculo.getModelo() + " con placa " + vehiculo.getPlaca() + "</option>\n";
                                            } else {
                                                if (vehiculo.getPlaca().equals(search.getTbvehiculos().getPlaca())) {
                                                    valor += "<option class='jubilados' value='" + search.getTbvehiculos().getPlaca() + "' data-jsonvehiculo='" + G.toJson(search.getTbvehiculos()) + "' selected='selected'>" + search.getTbvehiculos().getDisco() + " | " + search.getTbvehiculos().getMarca() + " " + search.getTbvehiculos().getModelo() + " con placa " + search.getTbvehiculos().getPlaca() + "</option>\n";
                                                    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
                                                    date1 = (search.getTbvehiculosconductoresPK().getFechainicio() != null) ? formatter.format(search.getTbvehiculosconductoresPK().getFechainicio()) : "";
                                                    date2 = (search.getFechafin() != null) ? formatter.format(search.getFechafin()) : "";
                                                } else {
                                                    valor += (vehiculo.getEstado().equals("Disponible"))
                                                            ? "<option class='disponibles' value='" + vehiculo.getPlaca() + "' data-jsonvehiculo='" + G.toJson(vehiculo) + "'>" + vehiculo.getDisco() + " | " + vehiculo.getMarca() + " " + vehiculo.getModelo() + " con placa " + vehiculo.getPlaca() + "</option>\n"
                                                            : "<option class='jubilados' disabled value='" + vehiculo.getPlaca() + "' data-jsonvehiculo='" + G.toJson(vehiculo) + "'>" + vehiculo.getDisco() + " | " + vehiculo.getMarca() + " " + vehiculo.getModelo() + " con placa " + vehiculo.getPlaca() + "</option>\n";
                                                }
                                            }
                                        }
                                    }
                                } else {
                                    valor = "<option disabled value='' selected hidden>--Todavía no se han ingresado vehiculos en el Sistema--</option>\n";
                                }
                                out.println(valor);
                            %>
                        </select>
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon" style="background:  #ECF790;">
                            <label class="fancy-checkbox">
                                <span>Inicio</span>
                            </label>
                        </span>
                        <input id="fechainicio<%=i%>" type="date" class="form-control" value="<%=date1%>" required>
                        <span class="input-group-addon" style="background:  #ECF790;">
                            <label class="fancy-checkbox">
                                <span>Fin</span>
                            </label>
                        </span>
                        <input id="fechafin<%=i%>" type="date" class="form-control" value="<%=date2%>" >
                    </div>
                    <br/>
                    <%
                        }
                    %>
                </div>
            </div>
        </div>
        </br>
        <div class="container text-right">
            <button type="submit" class="btn btn-success" >Add</button>
        </div>
    </form>
</div>
<div class="modal-footer">
    <button type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-times-circle"></i> Cerrar</button>
</div>
<%
        }
    } else {
        response.sendError(501, this.getServletName() + "-> Error no se ha logueado en el sistema contacte con proveedor");
    }

%>

