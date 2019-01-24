<%-- 
    Document   : SolicitudesVista
    Created on : 5/01/2019, 05:56:08 PM
    Author     : Xavy PC
--%>

<%@page import="java.time.ZoneId"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.Period"%>
<%@page import="ugt.entidades.Tblicencias"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="ugt.entidades.Tbrevisionesmecanicas"%>
<%@page import="ugt.vehiculos.iu.VehiculosIU"%>
<%@page import="ugt.entidades.Tbgrupovehiculos"%>
<%@page import="ugt.gruposvehiculos.iu.GruposVehiculosIU"%>
<%@page import="ugt.entidades.Tbconductores"%>
<%@page import="ugt.conductores.iu.ConductoresIU"%>
<%@page import="ugt.entidades.Tbvehiculos"%>
<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="ugt.vehiculosconductores.iu.VehiculosConductoresIU"%>
<%@page import="ugt.entidades.Tbvehiculosdependencias"%>
<%@page import="ugt.entidades.Tbvehiculosconductores"%>
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
        } else if (accion.equals("arrayJSON")) {
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
        } else if (accion.equals("combinarPDFs")) {
            String result = (String) session.getAttribute("pdf64");
            result = (result != null) ? result : "";
            session.setAttribute("pdf64", null);
            if (result != null) {
                response.setContentType("text/plain");
                response.getWriter().write(result);
            } else {
                response.sendError(300, "Error al retornnar pdf requisitos en base 64");
            }
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
                    <span class="fa-stack fa-lg"></i><i class="fa fa-file-pdf-o fa-stack-2x"></i></span>PDF requisitos
                </a>
            </li>
            <li>
                <a id="mnAsignarV_C" href="#" onclick="" class="inactive">
                    <span class="fa-stack fa-lg"></i><i class="fa fa-bus fa-stack-2x"></i><i class="fa fa-group fa-stack-1x"></i></span>Vehículo-Conductor
                </a>
            </li>
            <li>
                <a id="mnListarSolG" href="#" onclick="" class="inactive">
                    <span class="fa-stack fa-lg"></i><i class="fa fa-navicon fa-stack-2x"></i></span>Lista
                </a>
            </li>
        </ul>
    </div>
    <div class="main-content" id="gSolicitudes_body">
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
        <div class="widget widget-table" >
            <div class="widget-header">
                <h3><i class="fa fa-table"></i> Sección </h3><em>Lista nuevas solicitudes</em>
            </div>
            <div class="widget-content">
                <div id="jqgrid-wrapper">
                    <table id="tbSolicitudesNuevas" class="table table-hover">
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
</div>
<%
} else if (accion.equals("tableSolicitudesProcesadas")) {
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
                    <span class="fa-stack fa-lg"><i class="fa fa-users fa-stack-2x"></i></span>Pasajeros
                </a>
            </li>
            <li>
                <a id="mnReqPDF" href="#" onclick="" class="inactive">
                    <span class="fa-stack fa-lg"><i class="fa fa-file-pdf-o fa-stack-2x"></i></span>PDF requisitos
                </a>
            </li>
            <li>
                <a id="mnAsignarV_C" href="#" onclick="" class="inactive">
                    <span class="fa-stack fa-lg"><i class="fa fa-bus fa-stack-2x"></i><i class="fa fa-group fa-stack-1x"></i></span>Vehículo-Conductor
                </a>
            </li>
            <li>
                <a id="mnobservacion" href="#" onclick="" class="inactive">
                    <span class="fa-stack fa-lg"><i class="fa fa-commenting fa-stack-2x"></i></span>Observación
                </a>
            </li>
        </ul>
    </div>
    <div class="main-content" id="gSolicitudes_body">
        <div class="row">
            <div class="col-lg-6">
                <div class="form-group">
                    <label  class="col-sm-2 control-label" id="titleTipoDisponibilidad">Filtro solicitud</label>
                    <div class="col-sm-10">
                        <select name="filtroSolicitud" class="form-control" id="filtroSolicitudEstado" data-live-search="true">
                            <!--<optgroup label="Tipo Vehículo">-->
                            <!--<option value="asignada">Asignadas</option>-->
                            <option value="aprobada">Aprobadas (Visto bueno VA)</option>
                            <option value="aprobadaUGT">Aprobadas (Visto bueno UGT)</option>
                            <option value="finalizada">Finalizadas</option>
                            <option value="rechazada">Rechazadas</option>
                            <option value="procesadas" selected="selected">Todas (UGT - VA)</option>
                            <!--</optgroup>-->
                        </select>
                    </div>    
                </div>    
            </div>
            <div class="col-lg-6 pull-right">
                <div class="input-group">
                    <input id="search_cells" type="text" class="form-control x-campaigns-filter">
                    <span class="input-group-btn">
                        <button class="btn btn-custom-primary" type="button" disabled="disabled"><i class="fa fa-search"></i></button>
                    </span>
                </div>
            </div>
        </div><br>
        <div class="widget widget-table" >
            <div class="widget-header">
                <h3><i class="fa fa-table"></i> Sección Solicitudes Procesadas</h3><em>Lista solicitudes</em>
            </div>
            <div class="widget-content">
                <div id="jqgrid-wrapper">
                    <table id="tbSolicitudesNuevas" class="table table-hover">
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
</div>
<%
} else if (accion.equals("modSolicitanteInfo")) {
    Tbusuariosentidad userSol = (Tbusuariosentidad) session.getAttribute("userSol");
    String idSolicitud = (String) session.getAttribute("idSolicitud");
    session.setAttribute("userSol", null);
    session.setAttribute("idSolicitud", null);
    G = new GsonBuilder().setDateFormat("yyyy-MM-dd'T'HH:mm:ss-05:00").create();
%>
<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
    <h4 class="modal-title" id="titleModalSolicitanteInfo"> Solicitud <%=idSolicitud%> | Datos usuario de la solicitud </h4>
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
    G = new GsonBuilder().setDateFormat("yyyy-MM-dd'T'HH:mm:ss-05:00").create();
    Tbusuariosentidad userSol = (Tbusuariosentidad) session.getAttribute("userSol");
    Tbvehiculosconductores vehiculoConductor = (Tbvehiculosconductores) session.getAttribute("vehiculoConductor");
    Tbvehiculosdependencias vehiculodependencia = (Tbvehiculosdependencias) session.getAttribute("vehiculodependencia");
    VehiculosConductoresIU listaV_C = (VehiculosConductoresIU) session.getAttribute("listaV_C");
    ConductoresIU listaConductores = (ConductoresIU) session.getAttribute("listaConductores");
    GruposVehiculosIU grupovehiculo = (GruposVehiculosIU) session.getAttribute("grupovehiculo");

    session.setAttribute("userSol", null);
    session.setAttribute("vehiculoConductor", null);
    session.setAttribute("vehiculodependencia", null);
    session.setAttribute("listaV_C", null);
    session.setAttribute("listaConductores", null);
    session.setAttribute("grupovehiculo", null);

%>

<!--<div class="row">
    <div class="col-lg-4 pull-right">
        <div class="input-group">
            <input type="text" id="search_solicitud_pasajeros" name="search" class="form-control searchbox" />
            <input type=hidden id="json_solicitud_pasajeros" name="search"/>
            <span class="input-group-btn">
                <button id="search_solicitud_pasajeros_button" class="btn btn-custom-secondary" type="button" disabled="disabled" onclick="fncCatchSelectS('form3')"><i class="fa fa-plus"></i></button>
            </span>
        </div>
    </div>
</div><br>-->
<div class="widget" >
    <div class="widget-header">
        <h3><i class="fa fa-table"></i> Sección </h3><em>Lista nuevas solicitudes</em>
    </div>
    <div class="widget-content">
        <!-- external events -->
        <div id="external-events">
            <div class="row">
                <div class="col-md-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h3 class="panel-title">Opciones vehículo-conductor </h3></div>
                        <div class="panel-body">
                            <div class="col-md-6 form-horizontal">
                                <div class="form-group">
                                    <label  class="col-sm-2 control-label" id="titleTipoDisponibilidad">Lista vehículos</label>
                                    <div class="col-sm-10">
                                        <select name="vehiculo" class="form-control selectpicker" id="addDVehiculoC" data-live-search="true" onchange="fncSelectConductorDVC()" required>
                                            <%                                        //lista de vehiculos
                                                String valor = "";
                                                if (listaV_C != null) {
                                                    valor += "<option disabled value='' selected hidden>--Escoja uno --</option>\n";
                                                    for (Tbvehiculosconductores itemList : listaV_C.getLista()) {
                                                        //extraemos solo el vehiculo
                                                        Tbvehiculos itemVehiculo = itemList.getTbvehiculos();
                                                        //si el vehiculo conductor es diferente a vacio
                                                        if (vehiculoConductor != null) {
                                                            // pregutnar si el vehiculo conductor es igual al item list para seleccionarlo
                                                            if (vehiculoConductor.getTbvehiculosconductoresPK().getMatricula().equals(itemVehiculo.getPlaca())) {
                                                                valor += "<option class='disponibles' value='" + itemVehiculo.getPlaca() + "' data-jsonvehiculo='" + G.toJson(vehiculoConductor)
                                                                        + "' selected='selected'>"
                                                                        + itemVehiculo.getDisco() + " | " + itemVehiculo.getMarca() + " " + itemVehiculo.getModelo() + " con placa " + itemVehiculo.getPlaca()
                                                                        + "</option>\n";
                                                            } //si no lo imprimimos sin seleccionado
                                                            else {
                                                                valor += "<option class='disponibles' value='" + itemVehiculo.getPlaca() + "' data-jsonvehiculo='" + G.toJson(itemList) + "'>"
                                                                        + itemVehiculo.getDisco() + " | " + itemVehiculo.getMarca() + " " + itemVehiculo.getModelo() + " con placa " + itemVehiculo.getPlaca()
                                                                        + "</option>\n";
                                                            }
                                                            // si no preguntar si el vehiculo dependencia es diferente a null
                                                        } else if (vehiculodependencia != null) {
                                                            //preguntamos si el vehichulo dependencia es igual al item list para seleccinarlo
                                                            if (vehiculodependencia.getTbvehiculos().getPlaca().equals(itemVehiculo.getPlaca())) {
                                                                valor += "<option class='disponibles' value='" + itemVehiculo.getPlaca() + "' data-jsonvehiculo='" + G.toJson(itemList)
                                                                        + "' selected='selected'>"
                                                                        + itemVehiculo.getDisco() + " | " + itemVehiculo.getMarca() + " " + itemVehiculo.getModelo() + " con placa " + itemVehiculo.getPlaca()
                                                                        + "</option>\n";
                                                            }//imprimimos sin seleccionar vehiculo depednencia
                                                            else {
                                                                valor += "<option class='disponibles' value='" + itemVehiculo.getPlaca() + "' data-jsonvehiculo='" + G.toJson(itemList) + "'>"
                                                                        + itemVehiculo.getDisco() + " | " + itemVehiculo.getMarca() + " " + itemVehiculo.getModelo() + " con placa " + itemVehiculo.getPlaca()
                                                                        + "</option>\n";
                                                            }
                                                        } else {
                                                            valor += "<option class='disponibles' value='" + itemVehiculo.getPlaca() + "' data-jsonvehiculo='" + G.toJson(itemList) + "'>"
                                                                    + itemVehiculo.getDisco() + " | " + itemVehiculo.getMarca() + " " + itemVehiculo.getModelo() + " con placa " + itemVehiculo.getPlaca()
                                                                    + "</option>\n";
                                                        }
                                                    }
                                                }
                                                out.println(valor);
                                            %>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label  class="col-sm-2 control-label" id="titleTipoDisponibilidad">Filtros vehículos</label>
                                    <div class="col-sm-10">
                                        <select name="fitlroVehiculo" class="form-control" id="filtroAuto" data-live-search="true" onchange="fncFiltrarAutos(this.id, 'addDVehiculoC')" required>
                                            <optgroup label="Tipo Vehículo">
                                                <option value="0" selected="selected"> Todos </option>
                                                <%
                                                    if (grupovehiculo != null) {
                                                        for (Tbgrupovehiculos grupo : grupovehiculo.getLista()) {
                                                            out.println("<option value='" + grupo.getIdgrupo() + "' data-tipo='g'>" + grupo.getNombre() + " </option>");
                                                        }
                                                    }
                                                %>
                                            </optgroup>
                                        </select>
                                    </div>    
                                </div>    
                                <div class="form-group">
                                    <button type="button" id="btn-aprobarDVC" class="btn btn-success" onclick="fncAprobarVehiculoConductor()"><i class="fa fa-check fa-2x"></i> Asignar </button>
                                    <button type="button" id="btn-quick-event" class="btn btn-custom-primary" onclick="fncVerAgendaPlaca()"><i class="fa fa-eye fa-2x"></i> Agenda </button>
                                    <button type="button" id="btn-modal-dts-vehiculo" class="btn btn-info" onclick="fncModVerDatosVehiculo('addDVehiculoC', 'modGeneralSolicitudes')"><i class="fa fa-car fa-2x"></i> Datos vehículo </button>
                                    <input type="hidden" value="" id="inputHSolititud">
                                </div>
                                <!--</div>-->
                                <!--</div>-->
                            </div>
                            <div class="col-md-6 form-horizontal">
                                <!--                    <div class="panel panel-default">
                                                        <div class="panel-heading">
                                                            <h3 class="panel-title">Conductor</h3></div>
                                                        <div class="panel-body">-->
                                <div class="form-group">
                                    <label  class="col-sm-2 control-label" id="titleTipoDisponibilidad">Lista conductores</label>
                                    <div class="col-sm-10">
                                        <select name="conductor" class="form-control selectpicker" id="addDVConductor" data-live-search="true" required>
                                            <%//lista de conductores
                                                valor = "";
                                                if (listaConductores != null) {
                                                    valor += "<option disabled value='' selected hidden>--Escoja uno --</option>\n";
                                                    for (Tbconductores itemConductor : listaConductores.getListaconductores()) {
                                                        if (vehiculoConductor != null) {
                                                            // pregutnar si el vehiculo conductor es igual al item conductor list para seleccionarlo
                                                            if (vehiculoConductor.getTbvehiculosconductoresPK().getCedula().equals(itemConductor.getCedula())) {
                                                                valor += "<option class='disponibles' value='" + itemConductor.getCedula() + "' data-jsonconductor='" + G.toJson(itemConductor)
                                                                        + "' selected='selected'>"
                                                                        + itemConductor.getNombres() + " " + itemConductor.getApellidos()
                                                                        + "</option>\n";
                                                            } //si no lo imprimimos sin seleccionado
                                                            else {
                                                                valor += "<option class='disponibles' value='" + itemConductor.getCedula() + "' data-jsonconductor='" + G.toJson(itemConductor) + "'>"
                                                                        + itemConductor.getNombres() + " " + itemConductor.getApellidos()
                                                                        + "</option>\n";
                                                            }
                                                            // si no, lsitamos normalmente la opcion
                                                        } else {
                                                            valor += "<option class='disponibles' value='" + itemConductor.getCedula() + "' data-jsonconductor='" + G.toJson(itemConductor) + "'>"
                                                                    + itemConductor.getNombres() + " " + itemConductor.getApellidos()
                                                                    + "</option>\n";
                                                        }
                                                    }
                                                }
                                                out.println(valor);
                                            %>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <button type="button" id="btn-modal-dts-conductor" class="btn btn-info" onclick="fncModVerDatosConductor('addDVConductor', 'modGeneralSolicitudes')"><i class="fa fa-user fa-2x"></i> Datos conductor </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- end external events -->
        <div id='loading'>Seleccione un vehiculo para comenzar con la agenda...</div>
        <div class="calendar" id="calendarVehiculo"></div>
    </div>
</div>
<%        } else if (accion.equals("filtrarGrupoAuto")) {
    VehiculosConductoresIU filtroV_C = (VehiculosConductoresIU) session.getAttribute("filtroV_C");
    session.setAttribute("filtroV_C", null);
    String valor = "";
    if (filtroV_C != null) {
        valor += "<option disabled value='' selected hidden>--Escoja uno --</option>\n";
        for (Tbvehiculosconductores itemList : filtroV_C.getLista()) {
            //extraemos solo el vehiculo
            Tbvehiculos itemVehiculo = itemList.getTbvehiculos();
            //imprimimos el valor del vehiculo con o sin conductor
            valor += "<option value='" + itemVehiculo.getPlaca() + "' data-jsonvehiculo='" + G.toJson(itemList) + "'>"
                    + itemVehiculo.getDisco() + " | " + itemVehiculo.getMarca() + " " + itemVehiculo.getModelo() + " con placa " + itemVehiculo.getPlaca()
                    + "</option>\n";
        }
    } else {
        valor += "<option disabled value='' selected hidden>--No existen vehiculos --</option>\n";
    }
    out.println(valor);
} else if (accion.equals("modCombinarSolicitud")) {
    /**
     * inicio contenido modal para combinar solicitud pdf con las demas
     */
%>
<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
    <h4 class="modal-title" id="modalLicenciaTitulo"> Solicitud | Sección combinar pdf </h4>
</div>
<div class="modal-body">
    <form data-parsley-validate novalidate class="form-horizontal" role="form" id="formCombinarPDF">
        <h4>En este espacio puede subir la solicitud final con los vistos buenos de las respectivas autoridades de la institución.</h4>
        <input id="filePDF"  type="file" style="display:block;" accept=".pdf" required/>
        <input type="hidden" value="" id="jsonSolFormPDF">
    </form>
</div>
<div class='modal-footer'>
    <button type='button' class='btn btn-success' onclick="fncCombinarPDF('formCombinarPDF', 'modGeneralSolicitudes')"><i class='fa fa-upload'></i> Subir</button>
    <button type='button' class='btn btn-default' data-dismiss='modal'><i class='fa fa-times-circle'></i> Cerrar</button>
</div>
<%/**
     * fin cotenido modal para combinar solicitud pdf con las demas
     */
} else if (accion.equals("modDatosVehiculoDVC")) {
    /**
     * inicio contenido modal para ver datos de vehiculo DVC
     */
    Tbvehiculos vehiculoAux = (Tbvehiculos) session.getAttribute("vehiculoDVC");
    Tbrevisionesmecanicas revisionAux = (Tbrevisionesmecanicas) session.getAttribute("revisionmecanicaDVC");
    session.setAttribute("vehiculoDVC", null);
    session.setAttribute("revisionmecanicaDVC", null);
    String observacion = (vehiculoAux.getObservacion() != null) ? vehiculoAux.getObservacion() : "";
%>
<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
    <h4 class="modal-title" id="modalLicenciaTitulo"> Vehículo <%=vehiculoAux.getPlaca()%> | Datos del vehículo </h4>
</div>
<div class="modal-body">
    <form data-parsley-validate novalidate class="form-horizontal" role="form" id="formCombinarPDF">
        <div class='form-group'>
            <label  class='col-sm-2 control-label' >Matrícula</label>
            <div class='col-sm-10'>
                <input type='text' class='form-control' value="<%=vehiculoAux.getAnio()%>" readonly/>
            </div>
        </div>
        <div class='form-group'>
            <label  class='col-sm-2 control-label' >Color</label>
            <div class='col-sm-10'>
                <input type='text' class='form-control' value="<%=vehiculoAux.getColor()%>" readonly/>
            </div>
        </div>
        <div class='form-group'>
            <label  class='col-sm-2 control-label' >Tipo</label>
            <div class='col-sm-10'>
                <input type='text' class='form-control' value="<%=vehiculoAux.getIdgrupo().getNombre()%>" readonly/>
            </div>
        </div>
        <div class='form-group'>
            <label  class='col-sm-2 control-label' >observación</label>
            <div class='col-sm-10'>
                <textarea cols="50" readonly><%=observacion%></textarea>
            </div>
        </div>
        <hr>
        <%
            if (revisionAux != null) {
                SimpleDateFormat smf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");
                String date = smf.format(revisionAux.getFecha());
        %>
        <h3>Última revisión mecánica</h3>
        <div class='form-group'>
            <label  class='col-sm-2 control-label' >ID revisión</label>
            <div class='col-sm-10'>
                <input type='text' class='form-control' value="<%=revisionAux.getIdrevision()%>" readonly/>
            </div>
        </div>
        <div class='form-group'>
            <label  class='col-sm-2 control-label' >Detalle</label>
            <div class='col-sm-10'>
                <input type='text' class='form-control' value="<%=revisionAux.getDetalle()%>" readonly/>
            </div>
        </div>
        <div class='form-group'>
            <label  class='col-sm-2 control-label' >Fecha</label>
            <div class='col-sm-10'>
                <input type='datetime-local' class='form-control' value="<%=date%>" readonly/>
            </div>
        </div>
        <%
            } else {
                out.println("<h3 class='text-danger'>No hay una revision mecánica disponible</h3>");
            }
        %>
    </form>
</div>
<div class='modal-footer'>
    <button type='button' class='btn btn-default' data-dismiss='modal'><i class='fa fa-times-circle'></i> Cerrar</button>
</div>
<%/**
     * fin cotenido modal para ver datos del vehiculo DVC
     */
} else if (accion.equals("modDatosConductorDVC")) {
    /**
     * inicio contenido modal para ver datos de conductor DVC
     */
    Tbconductores conductorAux = (Tbconductores) session.getAttribute("conductorDVC");
    Tblicencias licenciaAux = (Tblicencias) session.getAttribute("licenciaDVC");
    session.setAttribute("conductorDVC", null);
    session.setAttribute("licenciaDVC", null);
    SimpleDateFormat smf = new SimpleDateFormat("dd 'de' MMMM 'del' yyyy");
    LocalDate ahora = LocalDate.now();
    LocalDate fechaNac = conductorAux.getFechanac().toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
    Period periodo = Period.between(fechaNac, ahora);
    String edad = periodo.getYears() + " años con " + periodo.getMonths() + " m.";
    String observacion = (conductorAux.getObservacion() != null) ? conductorAux.getObservacion() : "";
%>
<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
    <h4 class="modal-title" id="modalLicenciaTitulo"> Conductor <%=conductorAux.getCedula()%> | Datos del Conductor </h4>
</div>
<div class="modal-body">
    <form data-parsley-validate novalidate class="form-horizontal" role="form" id="formCombinarPDF">
        <div class='form-group'>
            <label  class='col-sm-2 control-label' >Cédula</label>
            <div class='col-sm-10'>
                <input type='text' class='form-control' value="<%=conductorAux.getCedula()%>" readonly/>
            </div>
        </div>
        <div class='form-group'>
            <label  class='col-sm-2 control-label' >Año nacimiento</label>
            <div class='col-sm-10'>
                <input type='text' class='form-control' value="<%=smf.format(conductorAux.getFechanac())%>" readonly/>
            </div>
        </div>
        <div class='form-group'>
            <label  class='col-sm-2 control-label' >Edad</label>
            <div class='col-sm-10'>
                <input type='text' class='form-control' value="<%=edad%>" readonly/>
            </div>
        </div>
        <div class='form-group'>
            <label  class='col-sm-2 control-label' >observación</label>
            <div class='col-sm-10'>
                <textarea cols="50" readonly><%=observacion%></textarea>
            </div>
        </div>
        <hr>
        <%
            if (licenciaAux != null) {
                smf = new SimpleDateFormat("yyyy-MM-dd");
                String expedicion = smf.format(licenciaAux.getFechaexpedicion());
                String expiracion = smf.format(licenciaAux.getFechaexpiracion());
                String puntos = String.valueOf(licenciaAux.getPuntos());
                puntos = (puntos == "null") ? "0" : puntos;
        %>
        <h3>Licencia</h3>
        <div class='form-group'>
            <label  class='col-sm-2 control-label' >ID</label>
            <div class='col-sm-10'>
                <input type='text' class='form-control' value="<%=licenciaAux.getIdlicencia()%>" readonly/>
            </div>
        </div>
        <div class='form-group'>
            <label  class='col-sm-2 control-label' >Tipo</label>
            <div class='col-sm-10'>
                <input type='text' class='form-control' value="<%=licenciaAux.getTipo()%>" readonly/>
            </div>
        </div>
        <div class='form-group'>
            <label  class='col-sm-2 control-label' >Puntos</label>
            <div class='col-sm-10'>
                <input type='text' class='form-control' value="<%=puntos%>" readonly/>
            </div>
        </div>
        <div class='form-group'>
            <label  class='col-sm-2 control-label' >Fecha expedición</label>
            <div class='col-sm-10'>
                <input type='date' class='form-control' value="<%=expedicion%>" readonly/>
            </div>
        </div>
        <div class='form-group'>
            <label  class='col-sm-2 control-label' >Fecha expiración</label>
            <div class='col-sm-10'>
                <input type='date' class='form-control' value="<%=expiracion%>" readonly/>
            </div>
        </div>
        <%
            } else {
                out.println("<h3 class='text-danger'>No hay una licencia asignada al conductor</h3>");
            }
        %>
    </form>
</div>
<div class='modal-footer'>
    <button type='button' class='btn btn-default' data-dismiss='modal'><i class='fa fa-times-circle'></i> Cerrar</button>
</div>
<%/**
             * fin contenido modal para ver datos de conductor DVC
             */
        }
    } else {
        response.sendError(501, this.getServletName() + "-> Error no se ha logueado en el sistema contacte con proveedor");
    }
%>
