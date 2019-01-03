<%-- 
    Document   : SolicitudVista
    Created on : 8/12/2018, 01:31:18 PM
    Author     : Xavy PC
--%>
<%@page import="ugt.entidades.Tbdisponibilidadvc"%>
<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="java.io.ByteArrayOutputStream"%>
<%@page import="java.io.OutputStream"%>
<%@page import="ugt.solicitudes.SolicitudPDF"%>
<%@page import="ugt.vehiculosconductores.iu.VehiculosConductoresIU"%>
<%@page import="ugt.entidades.Tbvehiculosdependencias"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="utg.login.Login"%>
<%
    Login login = (Login) session.getAttribute("login");
    if (login != null) {
        String accion = request.getParameter("accion");
        Gson g = new GsonBuilder().setDateFormat("yyyy-MM-dd'T'HH:mm:ss").create();
        if (accion.equals("jsonVacio")) {
            String datos = "{\"rows\":\"\"}";
            out.println(datos);
        } else if (accion.equals("jsonSolicitudes")) {
            String json = (String) session.getAttribute("arrayJSON");
            session.setAttribute("arrayJSON", null);
            out.print(json);
        } else if (accion.equals("pasajeroAutocomplete")) {
            String json = (String) session.getAttribute("listTerm");
            session.setAttribute("listTerm", null);
            response.setContentType("text/plain");
            response.getWriter().write(json);
        } else if (accion.equals("downloadReqSol")) {
            String result = (String) session.getAttribute("pdf64");
            session.setAttribute("pdf64", null);
            if (result != null) {
                response.setContentType("text/plain");
                response.getWriter().write(result);
            } else {
                response.sendError(300, "Error al retornnar pdf requisitos en base 64");
            }
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
        } else if (accion.equals("guardarStatusSol")) {
            String respuesta = (String) session.getAttribute("statusGuardar");
            String codigo = (String) session.getAttribute("statusCodigo");
            String nombres_apellidos = (String) session.getAttribute("statusnombresapellidos");
            String rol_entidad = (String) session.getAttribute("statusrolentidad");
            String idSolicitud = (String) session.getAttribute("solicitudFull");
            session.setAttribute("statusGuardar", null);
            session.setAttribute("statusCodigo", null);
            session.setAttribute("statusnombresapellidos", null);
            session.setAttribute("statusrolentidad", null);
            session.setAttribute("solicitudFull", null);
            String result = "{"
                    + "\"respuesta\":\"" + respuesta + "\","
                    + "\"nombres_apellidos\":\"" + nombres_apellidos + "\","
                    + "\"rol_entidad\":\"" + rol_entidad + "\","
                    + "\"idSolicitud\":\"" + idSolicitud + "\","
                    + "\"codigo\":\"" + codigo + "\""
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
        } else if (accion.equals("generarPDFSolID")) {
            String nombre_apellido = (String) session.getAttribute("nombre_apellido");
            String rol_entidad = (String) session.getAttribute("rol_entidad");
//            String idSolicitud = (String) session.getAttribute("idSolicitud");
            SolicitudPDF respuesta = (SolicitudPDF) session.getAttribute("solicitudfullPDF");

            session.setAttribute("solicitudfullPDF", null);
            session.setAttribute("nombre_apellido", null);
            session.setAttribute("rol_entidad", null);
            session.setAttribute("idSolicitud", null);

            respuesta.setSolicitanteTitulos((nombre_apellido == null) ? "" : nombre_apellido);
            respuesta.setSolicitantRolEntidad((rol_entidad == null) ? "" : rol_entidad);

            ByteArrayOutputStream baos = respuesta.generarPDF();

            // configuraciones para responder en el encabezado
            response.setHeader("Expires", "0");
            response.setHeader("Cache-Control", "must-revalidate, post-check=0, pre-check=0");
            response.setHeader("Pragma", "public");
            //connfiguracion del tipo de contenido
            response.setContentType("application/pdf");
            // tamaño del contenido
            response.setContentLength(baos.size());
            // Escrbiir ByteArrayOutputStream del PDF en el ServletOutputStream de jsp
            OutputStream os = response.getOutputStream();
            baos.writeTo(os);
            os.flush();
            os.close();
        } else if (accion.equals("nuevaSolicitudU")) {
            String cedula = "";
            String nombres = "";
            String apellidos = "";
            if (login.getRolesEntity().size() > 0) {
                cedula = login.getRolesEntity().get(0).getTbusuarios().getCedula();
                apellidos = login.getRolesEntity().get(0).getTbusuarios().getApellidos();
                nombres = login.getRolesEntity().get(0).getTbusuarios().getNombres();
            }
%>
<div class="main-header">
    <h2>UGT</h2>
    <em>Nueva Solcitud</em>
</div>
<div class="main-content">
    <!-- MODAL DIALOG -->
    <div class="modal fade" id="modGestionSol" tabindex="-1" role="dialog" aria-labelledby="modGestionRol" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">

            </div>
        </div>
    </div>
    <!-- END MODAL DIALOG -->
    <!-- INICIO MENU SUPERIOR-->
    <!--    <div>
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
                    <a id="mnCondOcup" href="#" onclick="" class="inactive">
                        <span class="fa-stack fa-lg"></i><i class="fa fa-list-alt fa-stack-2x"></i></span>Lista de roles
                    </a>
                </li>
                <li>
                    <a id="mnCondOcup" href="#" onclick="addModalRolOpcion('modGestionRol', 'tbRolesG')">
                    <a id="mnCondOcup" href="#" onclick="fncAsignarRolOpcion()">
                        <span class="fa-stack fa-lg"></i><i class="fa fa-puzzle-piece fa-stack-2x"></i></span>Add Rol-Opcion
                    </a>
                </li>
            </ul>
        </div>-->
    <!--FIN MENU SUPERIOR-->
    <!-- WIDGET WIZARD -->
    <div class="widget">
        <div class="widget-header">
            <h3><i class="fa fa-pencil"></i> Nuevo </h3></div>
        <div class="widget-content">
            <div class="wizard-wrapper">
                <div id="demo-wizard" class="wizard">
                    <ul class="steps">
                        <li data-target="#step1" class="active"><span class="badge badge-info">1</span>Sección motivo<span class="chevron"></span></li>
                        <li data-target="#step2"><span class="badge">2</span>Sección viaje<span class="chevron"></span></li>
                        <li data-target="#step3"><span class="badge">3</span>Sección pasajeros<span class="chevron"></span></li>
                        <li data-target="#step4"><span class="badge">4</span>Vehículo-conductor<span class="chevron"></span></li>
                        <li data-target="#step5"><span class="badge">5</span>Requerimientos<span class="chevron"></span></li>
                        <li data-target="#step6" class="last"><span class="badge">6</span>Enviar</li>
                    </ul>
                </div>
                <div class="step-content">
                    <!--INICIO SECCION MOTIVO-->
                    <div class="step-pane active" id="step1">
                        <form id="form1" data-parsley-validate novalidate>
                            <p><b>Datos solicitante: </b></p>
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="addNombres" class="col-md-3 control-label">Nombres</label>
                                        <div class="input-group">
                                            <input type="text" class="form-control" id="addNombres" value="<%=nombres%>" readonly>
                                            <span class="input-group-addon"><i class="fa fa-user"></i></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="addApellidos" class="col-md-3 control-label">Apellidos</label>
                                        <div class="input-group">
                                            <input type="text" class="form-control" id="addApellidos" value="<%=apellidos%>" readonly>
                                            <span class="input-group-addon"><i class="fa fa-user"></i></span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="addCedula" class="col-md-3 control-label">Cedula</label>
                                        <div class="input-group">
                                            <input type="text" class="form-control" id="addCedula" value="<%=cedula%>" readonly>
                                            <span class="input-group-addon"><i class="fa fa-book"></i></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="addExtension" class="col-md-3 control-label">Extension</label>
                                        <div class="input-group">
                                            <input type="text" class="form-control" id="addExtension" placeholder="Macas/Riobamba" required data-parsley-errors-container="#error-step112_1">
                                            <!--<input type="text" class="form-control" id="addExtension" placeholder="Macas/Riobamba">-->
                                            <span class="input-group-addon"><i class="fa fa-home"></i></span>
                                        </div>
                                        <p id="error-step112_1"></p>
                                    </div>
                                </div>
                            </div>
                            <p><b>Detalle el motivo del viaje :</b></p>
                            <div class="widget-content no-padding">
                                <textarea id="addTxtMotivo" name="motivo" lang="es" data-iconlibrary="fa" rows="12" required data-parsley-errors-container="#error-step1" style="min-width: 98%"></textarea>
                                <!--<textarea id="addTxtMotivo" name="motivo" lang="es" data-iconlibrary="fa" rows="15" style="min-width: 98%"></textarea>-->
                            </div>
                            <p id="error-step1"></p>
                        </form>
                    </div>
                    <!--FIN DE SECCION MOTIVO-->
                    <!--INICIO DE SECCION VIAJE-->
                    <div class="step-pane" id="step2">
                        <form id="form2" data-parsley-validate novalidate class="form-horizontal" role="form">
                            <p>Ingrese los datos del viaje: </p>
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="addOrigen" class="col-md-3 control-label">Origen</label>
                                        <div class="input-group">
                                            <input type="text" class="form-control" id="addOrigen" placeholder="Origen" required data-parsley-errors-container="#error-step2_1">
                                            <!--<input type="text" class="form-control" id="addOrigen" placeholder="Origen">-->
                                            <span class="input-group-addon"><i class="fa fa-home"></i></span>
                                        </div>
                                        <p id="error-step2_1"></p>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="addDestino" class="col-md-3 control-label">Destino</label>
                                        <div class="input-group">
                                            <input type="text" class="form-control" id="addDestino" placeholder="Destino" required data-parsley-errors-container="#error-step2_2">
                                            <!--<input type="text" class="form-control" id="addDestino" placeholder="Destino">-->
                                            <span class="input-group-addon"><i class="fa fa-plane"></i></span>
                                        </div>
                                        <p id="error-step2_2"></p>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="addFechaSalida" class="col-md-3 control-label">Fecha salida</label>
                                        <div class="input-group">
                                            <input type="datetime-local" class="form-control" id="addFechaSalida" placeholder="Fecha salida" required data-parsley-errors-container="#error-step2_3">
                                            <!--<input type="datetime-local" class="form-control" id="addFechaSalida" placeholder="Fecha salida">-->
                                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                        </div>
                                        <p id="error-step2_3"></p>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="addFechaRetorno" class="col-md-3 control-label">Fecha retorno</label>
                                        <div class="input-group">
                                            <input type="datetime-local" class="form-control" id="addFechaRetorno" title="Fecha retorno" required data-parsley-errors-container="#error-step2_4">
                                            <!--<input type="datetime-local" class="form-control" id="addFechaRetorno" title="Fecha retorno">-->
                                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                        </div>
                                        <p id="error-step2_4"></p>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="addTelefono" class="col-md-3 control-label">Teléfono</label>
                                        <div class="input-group">
                                            <input type="text" class="form-control" id="addTelefono" placeholder="0912345678" maxlength="15" required data-parsley-errors-container="#error-step2_5">
                                            <!--<input type="text" class="form-control" id="addTelefono" placeholder="0912345678">-->
                                            <span class="input-group-addon"><i class="fa fa-phone"></i></span>
                                        </div>
                                        <p id="error-step2_5"></p>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                    <!--FIN DE SECCION DE VIAJE-->
                    <!--INICIO SECCION PASAJEROS-->
                    <div class="step-pane" id="step3">
                        <div class="row">
                            <div class="col-sm-6">
                                <ul class="list-inline file-main-menu">
                                    <li>
                                        <a data-toggle="modal" style='cursor: pointer' onclick="fncAddPasajeroManual('form3')">
                                            <span class="fa-stack fa-lg"><i class="fa fa-plus-circle fa-stack-2x"></i></span> Nuevo Pasajero
                                        </a>
                                    </li>
                                </ul>
                            </div>
                            <div class="col-lg-4 pull-right">
                                <div class="input-group">
                                    <input type="text" id="search_solicitud_pasajeros" name="search" class="form-control searchbox" />
                                    <input type=hidden id="json_solicitud_pasajeros" name="search"/>
                                    <span class="input-group-btn">
                                        <button id="search_solicitud_pasajeros_button" class="btn btn-custom-secondary" type="button" disabled="disabled" onclick="fncCatchSelectS('form3')"><i class="fa fa-plus"></i></button>
                                    </span>
                                </div>
                            </div>
                        </div>
                        <form id="form3" data-parsley-validate novalidate class="form-horizontal" role="form">
                            <div class="panel-group" id="dynamic_div_solicitud"></div>
                        </form>
                    </div>
                    <!--FIN DE SECCION PASAJEROS-->
                    <!--INICIO SECCION DISPONIBILIDAD VEHICULO-CONDUCTOR-->
                    <div class="step-pane" id="step4">
                        <form id="form4" data-parsley-validate novalidate>
                            <%
                                Tbvehiculosdependencias vehiculodependencia = (Tbvehiculosdependencias) session.getAttribute("vehiculodependencia");
                                session.setAttribute("vehiculodependencia", null);
                                VehiculosConductoresIU vehiculoConductor = (VehiculosConductoresIU) session.getAttribute("vehiculoConductor");
                                session.setAttribute("vehiculoConductor", null);
                            %>
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="addOrigen" class="col-md-3 control-label">Vehículo:</label>
                                        <div class="input-group">
                                            <%
                                                if (vehiculodependencia != null) {
                                                    if (vehiculodependencia.getTbvehiculos() != null) {
                                                        out.println("<input type='text' class='form-control' id='addOrigen' placeholder='vehiculo' value='El vehiculo " + vehiculodependencia.getTbvehiculos().getDisco() + " placa " + vehiculodependencia.getTbvehiculos().getPlaca() + " esta asignado por defecto");
                                                    } else {
                                                        out.println("<input type='text' class='form-control' id='addOrigen' placeholder='vehiculo' value='El vehiculo será asignado en la unidad (UGT)' readonly>");
                                                    }
                                                } else {
                                                    out.println("<input type='text' class='form-control' id='addOrigen' placeholder='vehiculo' value='El vehiculo será asignado en la unidad (UGT)' readonly>");
                                                }
                                            %>
                                            <span class="input-group-addon"><i class="fa fa-home"></i></span>
                                        </div>
                                        <p id="error-step2_1"></p>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="addDestino" class="col-md-3 control-label">Conductor:</label>
                                        <div class="input-group">
                                            <%
                                                if (vehiculoConductor != null) {
                                                    if (vehiculoConductor.getLista().get(0).getTbconductores() != null) {
                                                        out.println("<input type='text' class='form-control' id='addDestino' placeholder='Condcutor' value='El conductor " + vehiculoConductor.getLista().get(0).getTbconductores().getApellidos() + " " + vehiculoConductor.getLista().get(0).getTbconductores().getNombres() + " esta asignado por defecto' readonly>");
                                                    } else {
                                                        out.println("<input type='text' class='form-control' id='addDestino' placeholder='Condcutor' value='El conductor será asignado en la unidad (UGT)' readonly>");
                                                    }
                                                } else {
                                                    out.println("<input type='text' class='form-control' id='addDestino' placeholder='Condcutor' value='El conductor será asignado en la unidad (UGT)' readonly>");
                                                }
                                            %>
                                            <span class="input-group-addon"><i class="fa fa-plane"></i></span>
                                        </div>
                                        <p id="error-step2_2"></p>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                    <!--FIN DE SECCION DISPONIBILIDAD VEHICULO-CONDUCTOR-->
                    <!--INICIO SECCION SUBIR PDF-->
                    <div class="step-pane" id="step5">
                        <div class="row widget-content">
                            <div class="col-sm-4">
                                <p style="font-size: 20px;">Espacio para subir un archivoPDF que debe contener los siguientes requerimientos escaneados: 
                                <ul>
                                    <li>
                                        Carta de compromiso deslindando a la espoch de resposabilidad
                                    </li>
                                    <li>
                                        Planificación previa autorizada
                                    </li>
                                    <li>
                                        Delegaciones respectivas con visto bueno
                                    </li>
                                    <li>
                                        Invitación (de ser el caso)
                                    </li>
                                    <li>
                                        Resoluciónes consejo politécnico (de ser el caso)
                                    </li>
                                    <li>
                                        Giras estudiantiles con el respectivo visto bueno
                                    </li>
                                    <li>
                                        Pronóstico del tiempo INAMHI
                                    </li>
                                    <li>
                                        Copias certificadas fiel copia del original
                                    </li>
                                </ul></p>
                            </div>
                            <div class="col-sm-8">
                                <!-- FILE UPLOAD -->
                                <form id="form5"  data-parsley-validate novalidate>
                                    <div style='float:left; width:100%; height:150px; text-align:center; border-style: solid; border-width: 1px; padding: 0px;' class="dropzone" id="drop_pdfs"></div>
                                </form>
                                <!-- END FILE UPLOAD -->
                            </div>
                        </div>
                    </div>
                    <!--FIN SECCION SUBIR PDF-->
                    <div class="step-pane" id="step6">
                        <p class="lead"><i class="fa fa-check-circle text-success"></i> Todo listo! De click en el botón "Enviar solicitud" para completar el envio. <p>Si desea
                            revise los pasos anteriores para verificar los datos. Al terminar se mostrara el oficio final que Ud puede imprimir</p></p>
                    </div>
                </div>
                <div class="actions">
                    <button type="button" class="btn btn-default" id="prevWizard"><i class="fa fa-arrow-left"></i> Anterior</button>
                    <button type="button" class="btn btn-primary" id="nextWizard">Siguiente <i class="fa fa-arrow-right"></i></button>
                </div>
            </div>
        </div>
    </div>
    <!-- END WIDGET WIZARD -->

</div>
<script>
    var dropFile;
    $('#demo-wizard').on('change', function (e, data) {
        // validation
        if ($('#form' + data.step).length > 0) {
            var parsleyForm = $('#form' + data.step).parsley();
            parsleyForm.validate();

            if (!parsleyForm.isValid())
                return false;
        }

        // last step button
        var $btnNext = $(this).parents('.wizard-wrapper').find('#nextWizard');
        if (data.step === 5 && data.direction === 'next') {
            $btnNext.text(' Enviar solicitud')
                    .prepend('<i class="fa fa-check-circle"></i>')
                    .removeClass('btn-primary').addClass('btn-success');
        } else {
            $btnNext.text('Siguiente ').
                    append('<i class="fa fa-arrow-right"></i>')
                    .removeClass('btn-success').addClass('btn-primary');
        }
        if (data.step === 3 && data.direction === 'next') {
            if (!$.trim($('#dynamic_div_solicitud').html()).length) {
                swalNormal("0 Pasajeros", "Debe ingresar al menos un pasajero", "error");
                $(this).wizard('previous');
            } else {
                var encontrado = false;
                var errortexto = fnObjSeccionPasajeros();
                for (var i in errortexto) {
                    if (errortexto.hasOwnProperty(i)) {
                        errortexto[i].forEach(function (valor, indice, array) {
                            if (valor.tipo === null) {
                                encontrado = true;
                            }
                        });
                    }
                }
                if (encontrado) {
                    swalNormal("Error tipo pasajeros", "Debe especificar el tipo en cada uno de los pasajeros", "error");
                    $(this).wizard('previous');
                }
            }
        }
        if (data.step === 5 && data.direction === 'next') {
            if (typeof dropFile[0].dropzone.files[0] === "undefined") {
                swalNormal("PDF no encontrado", "Debe subir un pdf con los requerimientos especificados", "error");
                $(this).wizard('previous');
            }
        }

    }).on('finished', function () {
        fncGuardarSolicitud();
    });

    $('#nextWizard').click(function () {
        $('#demo-wizard').wizard('next');
    });

    $('#prevWizard').click(function () {
        $('#demo-wizard').wizard('previous');
    });

    $(document).ready(function () {
        Dropzone.autoDiscover = false;
        dropFile = $("#drop_pdfs").dropzone({
            url: "protected/Solicitudes/SolicitudUsuario/SolicitudControlador.jsp?opc=saveSolicitud",
            paramName: "file",
            uploadMultiple: true,
            maxFiles: 1,
            maxFilesize: 5242880,
            acceptedFiles: "application/pdf",
            autoProcessQueue: false,
            addRemoveLinks: true,
            success: function (file, response) {
                var datos = JSON.parse(response);
                console.log("Mensaje servidor :" + response);
                fncConfirmarGenerarSolcitud(datos);
            },
            error: function (file, response) {
                response = JSON.parse(response);
                var tipo = (response.codigo === "KO") ? "warning" : "info";
                swalNormal(" Solicitud ", "[" + response.codigo + "] " + response.respuesta, tipo);
                console.log("error uploaded D: :" + response);
            }
        });

        $(function () {
            $("#search_solicitud_pasajeros").autocomplete({
                source: function (request, response) {
                    $.ajax({
                        url: "protected/Solicitudes/SolicitudUsuario/SolicitudControlador.jsp?opc=pasajeroAutocomplete",
                        type: "GET",
                        data: {
                            term: request.term
                        },
                        dataType: "json",
                        success: function (data) {
                            response(data);
                        }
                    });
                },
//                source: projects,
                minLength: 1,
                select: function (event, ui) {
//                    fncCatchSelectS(ui);
                    $("#json_solicitud_pasajeros").val(ui.item.json);
                    $("#search_solicitud_pasajeros_button").prop('disabled', false);
                }
            });
        });
    });
</script>
<%
} else if (accion.equals("modConfirmSolPDF")) {
    String nom_apell = (String) session.getAttribute("statusnombresapellidos");
    String rol_entidad = (String) session.getAttribute("statusrolentidad");
    String idSolicitud = (String) session.getAttribute("idSolicitud");
    String cedula = login.getRolesEntity().get(0).getTbusuarios().getCedula();
    String idrol = login.getRolActivo().getIdrol().toString();
    session.setAttribute("statusnombresapellidos", null);
    session.setAttribute("statusrolentidad", null);
    session.setAttribute("idSolicitud", null);
%>
<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
    <h4 class="modal-title" id="modalLicenciaTitulo"> Solicitud <%=idSolicitud%> | Generar pdf </h4>
</div>
<div class="modal-body">
    <form id="formAddInfoSol" class="form-horizontal" role="form" method="POST">
        <p>Para completar el informe puede editar la forma en que ud se dirige en el documento asi como a la entidad a la que pertence</p>
        <label  class="control-label" for="addGRCharRol">Acrónimo y Nombre (Dr. Nombre1 Nombre2 Apellido1 Apellido2 Ph.D.)</label>
        <div class="form-group">
            <div class="col-sm-10">
                <input type="text" value="<%=nom_apell%>" name="nombres_apellidos" class="form-control" id="addNombres_Apellidos" title="Dr. Nombre1 Nombre2 Apellido1 Apellido2 Ph.D." placeholder="Dr. Nombre1 Nombre2 Apellido1 Apellido2 Ph.D." required/>
            </div>
        </div>
        <label class="control-label" for="addGRDescripcion" >En calidad de:</label>
        <div class="form-group">
            <div class="col-sm-10">
                <input type="text" value="<%=rol_entidad%>" name="rol_entidad" class="form-control" id="addRol_entidad" title="Decano de la Facultad de Ciencias" placeholder="Decano de la Facultad de Ciencias" required/>
                <input type="hidden" value="<%=idSolicitud%>" name="idSolicitud" class="form-control" id="addidSolicitud"/>
                <input type="hidden" value="<%=cedula%>" name="cedula" class="form-control" id="addcedula"/>
                <input type="hidden" value="<%=idrol%>" name="idrol" class="form-control" id="addidrol"/>
            </div>
        </div>
        <hr>
        <div class="container text-right">
            <button type="button" class="btn btn-default" data-dismiss="modal" onclick="fncNuevaSolicitud()"><i class="fa fa-times-circle"></i> Cerrar </button>
            <button type="submit" class="btn btn-success"><i class="fa fa-check-circle"></i> Generar </button>
        </div>
    </form>
</div>
<%
} else if (accion.equals("tableMisSolicitudes")) {
%>
<div class="main-header">
    <h2>UGT</h2>
    <em>Mis solicitudes</em>
</div>
<div class="main-content">
    <!-- MODAL DIALOG -->
    <div class="modal fade" id="modGeneralMisSolicitudes" tabindex="-1" role="dialog" aria-labelledby="modGeneralMisSolicitudes" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">

            </div>
        </div>
    </div>
    <!-- END MODAL DIALOG -->
    <div>
        <ul class="list-inline file-main-menu mn_missol">
            <li>
                <a data-toggle="modal" onclick="verViajeSolicitudModal('modGeneralMisSolicitudes', 'tbMisSolicitudes')" style='cursor: pointer'>
                    <span class="fa-stack fa-lg"><i class="fa fa-plane fa-stack-2x"></i></span> Detalles Viaje
                </a>
            </li>
            <li>
                <a id="mnCondOcup" href="#" onclick="verPasajerosSolModal('modGeneralMisSolicitudes', 'tbMisSolicitudes')">
                    <span class="fa-stack fa-lg"></i><i class="fa fa-users fa-stack-2x"></i></span>Pasajeros
                </a>
            </li>
            <li>
                <a id="mnSolReqPDF" href="#" onclick="verSolRequisitosPDF('0', 'tbMisSolicitudes')">
                    <span class="fa-stack fa-lg"></i><i class="fa fa-eye fa-stack-2x"></i></span>PDF requisitos
                </a>
            </li>
            <li>
                <a id="mnSolGenerar" href="#" onclick="ingInfoDescSolicitudModal('modGeneralMisSolicitudes', 'tbMisSolicitudes')">
                    <span class="fa-stack fa-lg"></i><i class="fa fa-download fa-stack-2x"></i></span>Generar oficio
                </a>
            </li>
            <li>
                <a id="mnCondOcup" href="#" onclick="verSolDisponV_C('modGeneralMisSolicitudes', 'tbMisSolicitudes')">
                    <span class="fa-stack fa-lg"></i><i class="fa fa-search fa-stack-2x"></i></span>Vehiculo-Conductor
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
            <h3><i class="fa fa-table"></i> Lista </h3><em>Solicitudes</em>
        </div>
        <div class="widget-content">
            <div id="jqgrid-wrapper">
                <table id="tbMisSolicitudes" class="table table-striped table-hover">
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
                <div id="tbMisSolicitudes_pager"></div>
            </div>
        </div>
    </div> 
</div>
<%
} else if (accion.equals("modDisponibilidadV_C")) {
    String idSolicitud = (String) session.getAttribute("idSolicitud");
    Tbdisponibilidadvc disponibilidadVC = (Tbdisponibilidadvc) session.getAttribute("disponibilidadVC");
    session.setAttribute("idSolicitud", null);
    session.setAttribute("disponibilidadVC", null);
%>
<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
    <h4 class="modal-title" id="modalLicenciaTitulo"><b> Solicitud <%=idSolicitud%> | Vehículo y conductor asignado </b></h4>
</div>
<div class="modal-body">
    <%  if (disponibilidadVC == null) {
            out.println("<h4>La Unidad de Gestión de Trasnporte, aún no ha asignado, a un conductor ni a un vehículo</h4>");
        } else {
    %>
    <h4>Datos del conductor</h4>
    <table class="table table-striped table-hover">
        <thead>        
            <tr>            
                <th>Cedula</th>         
                <th>Nombre</th>          
                <th>Apellidos</th>       
            </tr>   
        </thead> 
        <tbody>
            <%
                if (disponibilidadVC.getCedulaCond() != null) {
                    out.println((disponibilidadVC.getCedulaCond().getCedula() != null) ? "<td>" + disponibilidadVC.getCedulaCond().getCedula() + "</td>" : "");
                    out.println((disponibilidadVC.getCedulaCond().getNombres() != null) ? "<td>" + disponibilidadVC.getCedulaCond().getNombres() + "</td>" : "");
                    out.println((disponibilidadVC.getCedulaCond().getApellidos() != null) ? "<td>" + disponibilidadVC.getCedulaCond().getApellidos() + "</td>" : "");
                }
            %>
        </tbody>
    </table>
    <%
        if (disponibilidadVC.getCedulaCond() == null) {
            out.println("<h4>La Unidad de Gestión de Trasnporte, aún no ha asignado, a un conductor</h4>");
        }
    %>
    <hr>
    <h4>Datos del vehículo</h4>
    <table class="table table-striped table-hover">
        <thead>        
            <tr>            
                <th>Placa</th>         
                <th>Disco</th>         
                <th>Marca</th>          
                <th>Modelo</th>       
                <th>Color</th>       
                <th>Año</th>       
            </tr>   
        </thead> 
        <tbody>
            <%
                if (disponibilidadVC.getMatricula() != null) {
                    out.println((disponibilidadVC.getMatricula().getPlaca() != null) ? "<td>" + disponibilidadVC.getMatricula().getPlaca() + "</td>" : "");
                    out.println((disponibilidadVC.getMatricula().getDisco() > 0) ? "<td>" + disponibilidadVC.getMatricula().getDisco()+ "</td>" : "");
                    out.println((disponibilidadVC.getMatricula().getMarca()!= null) ? "<td>" + disponibilidadVC.getMatricula().getMarca()+ "</td>" : "");
                    out.println((disponibilidadVC.getMatricula().getModelo()!= null) ? "<td>" + disponibilidadVC.getMatricula().getModelo()+ "</td>" : "");
                    out.println((disponibilidadVC.getMatricula().getColor()!= null) ? "<td>" + disponibilidadVC.getMatricula().getColor()+ "</td>" : "");
                    out.println((disponibilidadVC.getMatricula().getAnio()!= null) ? "<td>" + disponibilidadVC.getMatricula().getAnio()+ "</td>" : "");
                }
            %>
        </tbody>
    </table>
    <%
            if (disponibilidadVC.getMatricula() == null) {
                out.println("<h4>La Unidad de Gestión de Trasnporte, aún no ha asignado un vehículo</h4>");
            }
        }
    %>
</div>
<div class="modal-footer">
    <button type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-times-circle"></i> Close</button>
</div>
<%        }
    } else {
        response.sendError(501, this.getServletName() + "-> Error no se ha logueado en el sistema contacte con proveedor");
    }
%>