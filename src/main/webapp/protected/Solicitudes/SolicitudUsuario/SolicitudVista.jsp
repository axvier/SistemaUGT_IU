<%-- 
    Document   : SolicitudVista
    Created on : 8/12/2018, 01:31:18 PM
    Author     : Xavy PC
--%>
<%@page import="ugt.vehiculosconductores.iu.VehiculosConductoresIU"%>
<%@page import="ugt.entidades.Tbvehiculosdependencias"%>
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
        } else if (accion.equals("jsonSolicitudes")) {
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
                            <div id="dynamic_div_solicitud"></div>
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
                                        Invitación (de ser el caso)
                                    </li>
                                    <li>
                                        Resoluciónes consejo politécnico (de ser el caso)
                                    </li>
                                    <li>
                                        Copias certificadas
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
                console.log("Successfully uploaded :D :" + response);
                var datos = JSON.parse(response);
                var tipo = (data.codigo === "KO")? "warning":"info";
                swalNormal(" Solicitud ", "[" + datos.codigo + "] " + datos.respuesta, tipo);
                fncConfirmarGenerarSolcitud();
            },
            error: function (file, response) {
                var datos = JSON.parse(response);
                var tipo = (data.codigo === "KO")? "warning":"info";
                swalNormal(" Solicitud ", "[" + datos.codigo + "] " + datos.respuesta, tipo);
                console.log("error uploaded D: :" + response);
//            },
//            init: function () {
//
//                var myDropzone = this;
//
//                // Update selector to match your button
//                $(".btn-success").click(function (e) {
//                    alert("enviando");
//                    e.preventDefault();
//                    myDropzone.processQueue();
//                });
//
//                this.on('sending', function (file, xhr, formData) {
//                    // Append all form inputs to the formData Dropzone will POST
//                    var motivo = JSON.stringify(fncObjSeccionMotivo());
//                    var viaje = JSON.stringify(fncObjSeccionViaje());
//                    var listaPasajeros = JSON.stringify(fnObjSeccionPasajeros());
//                    var extension = $("#form1 #addExtension").val();
//                    formData.append("jsonMotivo", motivo);
//                    formData.append("jsonViaje", viaje);
//                    formData.append("jsonPasajeros", listaPasajeros);
//                    formData.append("jsonPasajeros", listaPasajeros);
//                    formData.append("extension", extension);
//                });
            }
        });

        $(function () {
            var projects = [
                {
                    value: "Giovanni Xavier Aranda Cóndor",
                    label: "1804789830",
                    json: "{\"apellidos\": \"Aranda Cóndor\",\"cedula\": \"1804789830\",\"descripcion\": \"Secretario\",\"entidad\": \"UGT\",\"nombres\": \"Giovanni Xavier\"}"
                },
                {
                    value: "nuevo1 nuevo2",
                    label: "0987341734",
                    json: "{\"apellidos\": \"nuevo2\",\"cedula\": \"0987341734\",\"descripcion\": \"uenco\",\"entidad\": \"UGT\",\"nombres\": \"nuevo1\"}"
                },
                {
                    value: "otro otro2",
                    label: "0123456789",
                    json: "{\"apellidos\": \"otro2\",\"cedula\": \"0123456789\",\"descripcion\": \"presidente\",\"entidad\": \"UGT\",\"nombres\": \"otro1\"}"
                }
            ];
            $("#search_solicitud_pasajeros").autocomplete({
//                source: function (request, response) {
//                    $.ajax({
//                        url: "SearchController",
//                        type: "GET",
//                        data: {
//                            term: request.term
//                        },
//                        dataType: "json",
//                        success: function (data) {
//                            response(data);
//                        }
//                    });
//                }
                source: projects,
//                minLength: 2,
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
        }
    } else {
        response.sendError(501, this.getServletName() + "-> Error no se ha logueado en el sistema contacte con proveedor");
    }
%>