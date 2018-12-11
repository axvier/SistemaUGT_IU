<%-- 
    Document   : SolicitudVista
    Created on : 8/12/2018, 01:31:18 PM
    Author     : Xavy PC
--%>
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
        } else if (accion.equals("nuevaSolicitudU")) {
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
                        <li data-target="#step4"><span class="badge">4</span>Disponibilidad vehículo-conductor<span class="chevron"></span></li>
                        <li data-target="#step5" class="last"><span class="badge">5</span>Crear oficio</li>
                    </ul>
                </div>
                <div class="step-content">
                    <div class="step-pane active" id="step1">
                        <form id="form1" data-parsley-validate novalidate>
                            <p>Detalle el motivo del viaje :</p>
                            <div class="widget-content no-padding">
                                <!--<textarea id="addTxtMotivo" name="motivo" lang="es" data-iconlibrary="fa" rows="15" required data-parsley-errors-container="#error-step1" style="min-width: 98%"></textarea>-->
                                <textarea id="addTxtMotivo" name="motivo" lang="es" data-iconlibrary="fa" rows="15" style="min-width: 98%"></textarea>
                            </div>
                            <p id="error-step1"></p>
                        </form>
                    </div>
                    <div class="step-pane" id="step2">
                        <form id="form2" data-parsley-validate novalidate class="form-horizontal" role="form">
                            <p>Ingrese los datos del viaje: </p>
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="addOrigen" class="col-md-3 control-label">Origen</label>
                                        <div class="input-group">
                                            <!--<input type="text" class="form-control" id="addOrigen" placeholder="Origen" required data-parsley-errors-container="#error-step2_1">-->
                                            <input type="text" class="form-control" id="addOrigen" placeholder="Origen">
                                            <span class="input-group-addon"><i class="fa fa-home"></i></span>
                                        </div>
                                        <p id="error-step2_1"></p>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="addDestino" class="col-md-3 control-label">Destino</label>
                                        <div class="input-group">
                                            <!--<input type="text" class="form-control" id="addDestino" placeholder="Destino" required data-parsley-errors-container="#error-step2_2">-->
                                            <input type="text" class="form-control" id="addDestino" placeholder="Destino">
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
                                            <!--<input type="datetime-local" class="form-control" id="addFechaSalida" placeholder="Fecha salida" required data-parsley-errors-container="#error-step2_3">-->
                                            <input type="datetime-local" class="form-control" id="addFechaSalida" placeholder="Fecha salida">
                                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                        </div>
                                        <p id="error-step2_3"></p>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="addFechaRetorno" class="col-md-3 control-label">Fecha retorno</label>
                                        <div class="input-group">
                                            <!--<input type="datetime-local" class="form-control" id="addFechaRetorno" title="Fecha retorno" required data-parsley-errors-container="#error-step2_4">-->
                                            <input type="datetime-local" class="form-control" id="addFechaRetorno" title="Fecha retorno">
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
                                            <!--<input type="text" class="form-control" id="addTelefono" placeholder="0912345678" required data-parsley-errors-container="#error-step2_5">-->
                                            <input type="text" class="form-control" id="addTelefono" placeholder="0912345678">
                                            <span class="input-group-addon"><i class="fa fa-phone"></i></span>
                                        </div>
                                        <p id="error-step2_5"></p>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="step-pane" id="step3">
                        <div class="row">
                            <div class="col-sm-6">
                                <ul class="list-inline file-main-menu">
                                    <li>
                                        <a data-toggle="modal" style='cursor: pointer' onclick="fncAddPasajeroManual('Pform3')">
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
                                        <button id="search_solicitud_pasajeros_button" class="btn btn-custom-secondary" type="button" disabled="disabled" onclick="fncCatchSelectS('Pform3')"><i class="fa fa-plus"></i></button>
                                    </span>
                                </div>
                            </div>
                        </div>
                        <form id="Pform3" data-parsley-validate novalidate class="form-horizontal" role="form">
                            <div id="dynamic_div_solicitud">
                            </div>
                        </form>
                    </div>
                    <div class="step-pane" id="step4">
                        <form id="form3" data-parsley-validate novalidate>
                            <label class="fancy-checkbox">
                                <input type="checkbox" name="newsletter">
                                <span>Subscribe to monthly newsletter</span>
                            </label>
                            <label class="fancy-checkbox">
                                <input type="checkbox" name="terms">
                                <span>I accept the <a href="#">Terms &amp; Agreements</a></span>
                            </label>
                        </form>
                    </div>
                    <div class="step-pane" id="step5">
                        <p class="lead"><i class="fa fa-check-circle text-success"></i> Del clik en siguiente para generare el oficio.</p>
                    </div>
                </div>
                <div class="actions">
                    <button type="button" class="btn btn-default" id="prevWizard"><i class="fa fa-arrow-left"></i> Anterior</button>
                    <button type="button" class="btn btn-primary" id="nextWizard">Siguiente<i class="fa fa-arrow-right"></i></button>
                </div>
            </div>
        </div>
    </div>
    <!-- END WIDGET WIZARD -->

</div>
<script>
    $('#demo-wizard').on('change', function (e, data) {
        // validation
        if ($('#form' + data.step).length > 0) {
            var parsleyForm = $('#form' + data.step).parsley();
            parsleyForm.validate();

            if (!parsleyForm.isValid())
                return false;
        }

        // last step button
        $btnNext = $(this).parents('.wizard-wrapper').find('.btn-next');

        if (data.step === 5 && data.direction === 'next') {
            $btnNext.text(' Create My Account')
                    .prepend('<i class="fa fa-check-circle"></i>')
                    .removeClass('btn-primary').addClass('btn-success');
        } else {
            $btnNext.text('Next ').
                    append('<i class="fa fa-arrow-right"></i>')
                    .removeClass('btn-success').addClass('btn-primary');
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
        $(function () {
            var projects = [
                {
                    value: "Giovanni Xavier Aranda Cóndor",
                    label: "1804789830",
                    json: "{\"apellidos\": \"Aranda\",\"cedula\": \"1804789830\",\"descripcion\": \"Secretario\",\"entidad\": \"UGT\",\"nombres\": \"Xavier\"}"
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