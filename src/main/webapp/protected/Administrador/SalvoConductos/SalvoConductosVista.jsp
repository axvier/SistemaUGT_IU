<%-- 
    Document   : SalvoConductosVista
    Created on : 14/01/2019, 01:30:39 PM
    Author     : Xavy PC
--%>

<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="ugt.entidades.Tbsolicitudes"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="utg.login.Login"%>
<%@page import="utils.Constantes"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Login login = (Login) session.getAttribute("login");
    if (login != null) {
        String accion = request.getParameter("accion");
        Gson g = new Gson();
        if (accion.equals("jsonVacio")) {
            String datos = "{\"rows\":\"\"}";
            out.println(datos);
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
        } else if (accion.equals("tableSolSalvoConducto")) {
            /**
             * inicio de la tabla tbSolSalvoConducto
             */
%>
<div class="main-content">
    <!-- MODAL DIALOG -->
    <div class="modal fade" id="modGeneralSalvoConducto" tabindex="-1" role="dialog" aria-labelledby="modGeneralSolicitudes" aria-hidden="true">
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
                <a id="mnRefresh" href="#" onclick="fncRecargarJQGenerarSalvo('tbSolSalvoConducto')">
                    <span class="fa-stack fa-lg"></i><i class="fa fa-refresh fa-stack-2x"></i></span>Recargar
                </a>
            </li>
            <li>
                <a id="mnobservacion" href="#" onclick="" class="inactive">
                    <span class="fa-stack fa-lg"><i class="fa fa-commenting fa-stack-2x"></i></span>Observación
                </a>
            </li>
            <!--            <li>
                            <a id="mnListarSolG" href="#" onclick="" class="inactive">
                                <span class="fa-stack fa-lg"></i><i class="fa fa-navicon fa-stack-2x"></i></span>Lista aprobados
                            </a>
                        </li>-->
        </ul>
    </div>
    <div class="main-content" id="gSolicitudes_body">
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
        <div class="widget widget-table" >
            <div class="widget-header">
                <h3><i class="fa fa-table"></i> Solicitudes listas para generar salvoconducto </h3><em>Lista</em>
            </div>
            <div class="widget-content">
                <div id="jqgrid-wrapper">
                    <table id="tbSolSalvoConducto" class="table table-responsive table-hover">
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
                    <div id="tbSolSalvoConducto_pager"></div>
                </div>
            </div>
        </div> 
    </div> 
</div>
<%
    /**
     * fin de vista de tabla
     */
} else if (accion.equals("tableListaSalvoConductos")) {
    /**
     * inicio de la tabla tbListaSalvoConducto
     */
%>
<div class="main-content">
    <!-- MODAL DIALOG -->
    <div class="modal fade" id="modGeneralSalvoConducto" tabindex="-1" role="dialog" aria-labelledby="modGeneralSolicitudes" aria-hidden="true">
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
                <a id="mnOrdenPDF" href="#" onclick="" class="inactive">
                    <span class="fa-stack fa-lg"><i class="fa fa-file-o fa-stack-2x"></i><i class="fa fa-car fa-stack-1x"></i></span>PDF Orden Mov.
                </a>
            </li>
            <li>
                <a id="mnAsignarV_C" href="#" onclick="" class="inactive">
                    <span class="fa-stack fa-lg"></i><i class="fa fa-bus fa-stack-2x"></i><i class="fa fa-group fa-stack-1x"></i></span>Vehículo-Conductor
                </a>
            </li>
            <li>
                <a id="mnRefresh" href="#" onclick="fncRecargarJQGListaSalvo('tbSolSalvoConducto')">
                    <span class="fa-stack fa-lg"></i><i class="fa fa-refresh fa-stack-2x"></i></span>Recargar
                </a>
            </li>
            <li>
                <a id="mnobservacion" href="#" onclick="" class="inactive">
                    <span class="fa-stack fa-lg"><i class="fa fa-commenting fa-stack-2x"></i></span>Observación
                </a>
            </li>
            <!--            <li>
                            <a id="mnListarSolG" href="#" onclick="" class="inactive">
                                <span class="fa-stack fa-lg"></i><i class="fa fa-navicon fa-stack-2x"></i></span>Lista aprobados
                            </a>
                        </li>-->
        </ul>
    </div>
    <div class="main-content" id="gSolicitudes_body">
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
        <div class="widget widget-table" >
            <div class="widget-header">
                <h3><i class="fa fa-table"></i> Ordenes generadas </h3><em>Lista</em>
            </div>
            <div class="widget-content">
                <div id="jqgrid-wrapper">
                    <table id="tbSolSalvoConducto" class="table table-hover">
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
                    <div id="tbSolSalvoConducto_pager"></div>
                </div>
            </div>
        </div> 
    </div> 
</div>
<%
    /**
     * fin de vista de tabla
     */
} else if (accion.equals("modGenerarSalvoConducto")) {
    /**
     * INICIO del contenido modal para subir KM inicial y generar Orden de
     * Movilización Parametro solicitudGen representa los datos de la solicitud
     * enviadas por JQuery
     */
%>
<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
    <h4 class="modal-title" id="titlemodGeneralSalvoConducto"> Solicitud  | Generar salvo conducto </h4>
</div>
<div class="modal-body">
    <form id="formGenSalvoC" class="form-horizontal" role="form" method="POST">
        <p>Antes de generar el salvo conducto puede ingresar el kilometraje inicial</br></p>
        <div class="form-group">
            <label class="col-sm-3 control-label" for="addGenKMinicio" >KM inicial:</label>
            <div class="col-sm-9">
                <input type="text" value="" name="kminicio" class="form-control" id="addGenKMinicio" title="Kilometraje inicial" placeholder="Kilometraje inicial (opcional)"/>
                <input type="hidden" value="" name="SolicitudGenerar" class="form-control" id="SolicitudGenerar"/>
            </div>
        </div>
        <hr>
        <p><strong class="text-danger">Obligatorio</strong> especificar la autoridad que será la encargada de firmar la orden de movilización</br></p>
        <div class="form-group">
            <label class="col-sm-3 control-label" for="addNombres_Apellidos" >Nombres y Apellidos:</label>
            <div class="col-sm-9">
                <input type="text" minlength=5 value="<%=Constantes.JefeUnidad%>" name="nombresApellidos" class="form-control" id="addNombres_Apellidos" title="Describir los nombres y los apellidos" placeholder="Nombres y Apellidos" required/>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label" for="addCargoEntidad" >Cargo:</label>
            <div class="col-sm-9">
                <input type="text" minlength=5 value="<%=Constantes.CARGOUGT%>" name="cargoentidad" class="form-control" id="addCargoEntidad" title="Describir el cargo que ostenta en una entidad" placeholder="Ejemplo: Jefe de la unidad" required/>
            </div>
        </div>
        <hr>
        <div class="container text-right">
            <button type='submit' class='btn btn-success' id="btsuccesscerrar"><i class='fa fa-upload'></i> Generar</button>
            <button type='button' class='btn btn-default' data-dismiss='modal'><i class='fa fa-times-circle'></i> Cerrar</button>
        </div>
    </form>
    <script>
        $(document).ready(function () {
            $("#addGenKMinicio").keydown(function (e) {
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
</div>
<%
    /**
     * FIN del contenido modal para subir KM inicial y generar Orden de
     * Movilización
     */
} else if (accion.equals("modGenerarSalvoConductoDNuevo")) {
    /**
     * INICIO del contenido modal para subir KM inicial y generar Orden de
     * Movilización Parametro solicitudGen representa los datos de la solicitud
     * enviadas por JQuery
     */
%>
<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
    <h4 class="modal-title" id="titlemodGeneralSalvoConducto"> Solicitud  | Generar salvo conducto </h4>
</div>
<div class="modal-body">
    <form id="formGenSalvoC" class="form-horizontal" role="form" method="POST">
        <p>Antes de generar el salvo conducto puede ingresar el kilometraje inicial</br></p>
        <div class="form-group">
            <label class="col-sm-3 control-label" for="addGenKMinicio" >KM inicial:</label>
            <div class="col-sm-9">
                <input type="text" value="" name="kminicio" class="form-control" id="addGenKMinicio" title="Kilometraje inicial" placeholder="Kilometraje inicial (opcional)"/>
                <input type="hidden" value="" name="SolicitudGenerar" class="form-control" id="SolicitudGenerar"/>
            </div>
        </div>
        <hr>
        <p><strong class="text-danger">Obligatorio</strong> especificar la autoridad que será la encargada de firmar la orden de movilización</br></p>
        <div class="form-group">
            <label class="col-sm-3 control-label" for="addNombres_Apellidos" >Nombres y Apellidos:</label>
            <div class="col-sm-9">
                <input type="text" minlength=5 value="<%=Constantes.JefeUnidad%>" name="nombresApellidos" class="form-control" id="addNombres_Apellidos" title="Describir los nombres y los apellidos" placeholder="Nombres y Apellidos" required/>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label" for="addCargoEntidad" >Cargo:</label>
            <div class="col-sm-9">
                <input type="text" minlength=5 value="<%=Constantes.CARGOUGT%>" name="cargoentidad" class="form-control" id="addCargoEntidad" title="Describir el cargo que ostenta en una entidad" placeholder="Ejemplo: Jefe de la unidad" required/>
            </div>
        </div>
        <hr>
        <div class="container text-right">
            <button type='submit' class='btn btn-success' id="btsuccesscerrar"><i class='fa fa-upload'></i> Generar</button>
            <button type='button' class='btn btn-default' data-dismiss='modal'><i class='fa fa-times-circle'></i> Cerrar</button>
        </div>
    </form>
    <script>
        $(document).ready(function () {
            $("#addGenKMinicio").keydown(function (e) {
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
                saveOrdenSolicitudDNuevo("SolicitudGenerar", "addGenKMinicio");
            });
        });
    </script>
</div>
<%
    /**
     * FIN del contenido modal para subir KM inicial y generar Orden de
     * Movilización
     */
    } else if (accion.equals("modSubirOrden")) {
    /**
     * INICIO CONTENIDO MODAL PARA SUBIR UNA ORDEN PDF
     */
%>
<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
    <h4 class="modal-title" id="titleOrdenSubirPDF"> Orden | Subir PDF </h4>
</div>
<div class="modal-body">
    <form data-parsley-validate novalidate class="form-horizontal" role="form" id="formSubirOrdenPDF">
        <h4>En este espacio puede subir el PDF de la orden de movilización firmada.</h4>
        <input id="filePDF"  type="file" style="display:block;" accept=".pdf" required/>
        <input type="hidden" value="" id="numeroOrden">
    </form>
</div>
<div class='modal-footer'>
    <button type='button' class='btn btn-success' onclick="fncSubirOrdenPDF('formSubirOrdenPDF', 'modGeneralSolicitudes')"><i class='fa fa-cloud-upload'></i> Subir </button>
    <button type='button' class='btn btn-default' data-dismiss='modal'><i class='fa fa-times-circle'></i> Cerrar</button>
</div>
<%
            /**
             * FIN CONTENIDO MODAL PARA SUBIR UNA ORDEN PDF
             */
        }
    } else {
        response.sendError(501, this.getServletName() + "-> Error no se ha logueado en el sistema contacte con proveedor");
    }
%>
