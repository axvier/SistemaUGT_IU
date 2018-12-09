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
            <h3><i class="fa fa-magic"></i> Wizard</h3></div>
        <div class="widget-content">
            <div class="wizard-wrapper">
                <div id="demo-wizard" class="wizard">
                    <ul class="steps">
                        <li data-target="#step1" class="active"><span class="badge badge-info">1</span>Account Type<span class="chevron"></span></li>
                        <li data-target="#step2"><span class="badge">2</span>User Account<span class="chevron"></span></li>
                        <li data-target="#step3"><span class="badge">3</span>Options<span class="chevron"></span></li>
                        <li data-target="#step4" class="last"><span class="badge">4</span>Create Account</li>
                    </ul>
                </div>
                <div class="step-content">
                    <div class="step-pane active" id="step1">
                        <form id="form1" data-parsley-validate novalidate>
                            <p>Choose your account type:</p>
                            <label class="fancy-radio">
                                <input type="radio" name="account-type" value="personal" required data-parsley-errors-container="#error-step1">
                                <span><i></i>Personal</span>
                            </label>
                            <label class="fancy-radio">
                                <input type="radio" name="account-type" value="business">
                                <span><i></i>Business</span>
                            </label>
                            <label class="fancy-radio">
                                <input type="radio" name="account-type" value="enterprise">
                                <span><i></i>Enterprise</span>
                            </label>
                            <p id="error-step1"></p>
                        </form>
                    </div>
                    <div class="step-pane" id="step2">
                        <form id="form2" data-parsley-validate novalidate>
                            <p>Please provide email, username and password
                                <br/>
                                <em><small>Field marked * is required</small></em>
                            </p>
                            <div class="row">
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label for="email">Email *</label>
                                        <input type="email" id="email" class="form-control" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="password">Password *</label>
                                        <input type="password" id="password" name="password" class="form-control" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="password2">Repeat Password *</label>
                                        <input type="password" id="password2" name="password2" class="form-control" required data-parsley-equalto="#password" data-parsley-equalto-message="Password doesn't match.">
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="step-pane" id="step3">
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
                    <div class="step-pane" id="step4">
                        <p class="lead"><i class="fa fa-check-circle text-success"></i> All is well! Click "Create My Account" to complete.</p>
                    </div>
                </div>
                <div class="actions">
                    <button type="button" class="btn btn-default" id="prevWizard"><i class="fa fa-arrow-left"></i> Prev</button>
                    <button type="button" class="btn btn-primary" id="nextWizard">Next <i class="fa fa-arrow-right"></i></button>
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

        if (data.step === 3 && data.direction === 'next') {
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
</script>
<%
        }
    } else {
        response.sendError(501, this.getServletName() + "-> Error no se ha logueado en el sistema contacte con proveedor");
    }
%>