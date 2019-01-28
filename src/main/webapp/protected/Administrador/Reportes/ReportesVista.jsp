<%-- 
    Document   : ReportesVista
    Created on : 22/01/2019, 11:41:52 AM
    Author     : Xavy PC
--%>

<%@page import="ugt.reportes.iu.RElementosIU"%>
<%@page import="ugt.reportes.RDataset"%>
<%@page import="ugt.reportes.RElemento"%>
<%@page import="ugt.reportes.ConductoresRepGenero"%>
<%@page import="ugt.reportes.iu.ConductoresReporteEstadosIU"%>
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
        } else if (accion.equals("conductoresChartEstado")) {
            String repCondEstado = (String) session.getAttribute("repCondEstado");
            session.setAttribute("repCondEstado", null);
            response.setContentType("application/json");
            response.getWriter().write(repCondEstado);
        } else if (accion.equals("respuestaJSON")) {
            String respuestaJSON = (String) session.getAttribute("respuestaJSON");
            session.setAttribute("respuestaJSON", null);
            response.setContentType("application/json");
            response.getWriter().write(respuestaJSON);
        } else if (accion.equals("vehiculosChartEstadosesion")) {
            String respuestaJSON = (String) session.getAttribute("respuestaJSON");
            session.setAttribute("respuestaJSON", null);
            response.setContentType("application/json");
            response.getWriter().write(respuestaJSON);
        } else if (accion.equals("conductoresReporte")) {
            ConductoresReporteEstadosIU repCondEstado = (ConductoresReporteEstadosIU) session.getAttribute("repCondEstado");
            session.setAttribute("repCondEstado", null);
            int disponibles = (repCondEstado != null) ? repCondEstado.getDisponibles() : 0;
            int ocupados = (repCondEstado != null) ? repCondEstado.getOcupados() : 0;
            int indispuestos = (repCondEstado != null) ? repCondEstado.getIndispuestos() : 0;
            int jubilados = (repCondEstado != null) ? repCondEstado.getJubilados() : 0;
%>
<div class="main-content">
    <!-- MODAL DIALOG -->
    <div class="modal fade" id="modGeneralReportes" tabindex="-1" role="dialog" aria-labelledby="modGeneralSolicitudes" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">

            </div>
        </div>
    </div>
    <!-- END MODAL DIALOG -->
    <!--    <div>
            <ul class="list-inline file-main-menu">
                <li>
                    <a id="mnReqPDF" href="NominaConductores">
                        <span class="fa-stack fa-lg"></i><i class="fa fa-file-pdf fa-stack-2x"></i></span>Nómina Conductores
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
        </div>-->
    <div class="row" id="estadostotales">
        <div class="col-sm-2">
            <div class="contextual-summary-info contextual-background green-bg">
                <i class="fa fa-check-circle"></i>
                <p class="pull-right"><span>Disponibles</span> <%=disponibles%></p>
            </div>
        </div>
        <div class="col-md-2">
            <div class="contextual-summary-info contextual-background bg-primary">
                <i class="fa fa-car"></i>
                <p class="pull-right"><span>Fijados</span><%=ocupados%></p>
            </div>
        </div>
        <div class="col-md-2">
            <div class="contextual-summary-info contextual-background yellow-bg">
                <i class="fa fa-warning"></i>
                <p class="pull-right"><span>Indispuestos</span><%=indispuestos%></p>
            </div>
        </div>
        <div class="col-md-2">
            <div class="contextual-summary-info contextual-background red-bg">
                <i class="fa fa-close"></i>
                <p class="pull-right"><span>Jubilados</span><%=jubilados%></p>
            </div>
        </div>
        <div class="col-md-2">
            <div class="contextual-summary-info contextual-background btn-custom-secondary">
                <i class="fa fa-users"></i>
                <p class="pull-right"><span>Totales</span><%=disponibles + ocupados + indispuestos + jubilados%></p>
            </div>
        </div>
    </div>
    <div style="margin-top: 15px;"></div>
    <div class="main-content" id="gSolicitudes_body">
        <div id="mnOpcionesReportes">
            <div class="col-sm-4 col-md-3 sidebar">
                <div class="list-group">
                    <!--                    <span href="#" class="list-group-item main-nav">
                                            Submenu
                                        </span>-->
                    <a href="NominaConductorPDF" class="list-group-item" title="Generar lista de conductores a exepción de los jubilados">
                        <i class="fa fa-check"></i> Nómina Conductores pdf
                    </a>
                    <a href="#" class="list-group-item" onclick="fncReporteConductores()">
                        <i class="fa fa-level-up"></i> total por estado
                    </a>
                    <a href="#" class="list-group-item" onclick="fncReporteConductoresGenero()">
                        <i class="fa fa-level-down"></i> total por genero
                    </a>
                </div>        
            </div>
        </div>
        <div class="col-md-6">
            <div class="widget">
                <div class="widget-header">
                    <h3><i class="fa fa-bar-chart-o"></i> Gráfico de conductores</h3> <em> - estados</em>
                </div>
                <div class="widget-content">
                    <!--<div class="demo-flot-chart" id="placeholder"></div>-->
                    <canvas id="myChart" width="60" height="35"></canvas>
                </div>
            </div>                         
        </div>
    </div>
</div> 
<%
} else if (accion.equals("conductoresReporteGenero")) {
    ConductoresRepGenero repCondEstado = (ConductoresRepGenero) session.getAttribute("repGenero");
    session.setAttribute("repGenero", null);
    int femenino = (repCondEstado != null) ? repCondEstado.getFemenino() : 0;
    int masculino = (repCondEstado != null) ? repCondEstado.getMasculino() : 0;
    int otros = (repCondEstado != null) ? repCondEstado.getOtros() : 0;
%>
<div class="main-content">
    <!-- MODAL DIALOG -->
    <div class="modal fade" id="modGeneralReportes" tabindex="-1" role="dialog" aria-labelledby="modGeneralSolicitudes" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">

            </div>
        </div>
    </div>
    <!-- END MODAL DIALOG -->
    <div class="row" id="estadostotales">
        <div class="col-sm-2">
            <div class="contextual-summary-info contextual-background" style="background-color: #FB5DD7;">
                <i class="fa fa-venus"></i>
                <p class="pull-right"><span>Femenino</span> <%=femenino%></p>
            </div>
        </div>
        <div class="col-md-2">
            <div class="contextual-summary-info contextual-background bg-primary" >
                <i class="fa fa-mars"></i>
                <p class="pull-right"><span>Masculino</span><%=masculino%></p>
            </div>
        </div>
        <div class="col-md-2">
            <div class="contextual-summary-info contextual-background btn-custom-secondary">
                <i class="fa fa-transgender"></i>
                <p class="pull-right"><span>Otros</span><%=otros%></p>
            </div>
        </div>
        <div class="col-md-2">
            <div class="contextual-summary-info contextual-background green-bg">
                <i class="fa fa-users"></i>
                <p class="pull-right"><span>Totales</span><%=masculino + femenino + otros%></p>
            </div>
        </div>
    </div>
    <div style="margin-top: 15px;"></div>
    <div class="main-content" id="gSolicitudes_body">
        <div id="mnOpcionesReportes">
            <div class="col-sm-4 col-md-3 sidebar">
                <div class="list-group">
                    <!--                    <span href="#" class="list-group-item main-nav">
                                            Submenu
                                        </span>-->
                    <a href="NominaConductorPDF" class="list-group-item" title="Generar lista de conductores a exepción de los jubilados">
                        <i class="fa fa-check"></i> Nómina Conductores pdf
                    </a>
                    <a href="#" class="list-group-item" onclick="fncReporteConductores()">
                        <i class="fa fa-level-up"></i> total por estado
                    </a>
                    <a href="#" class="list-group-item" onclick="fncReporteConductoresGenero()">
                        <i class="fa fa-level-down"></i> total por genero
                    </a>
                </div>        
            </div>
        </div>
        <div class="col-md-6">
            <div class="widget">
                <div class="widget-header">
                    <h3><i class="fa fa-bar-chart-o"></i> Gráfico de conductores</h3> <em> - Genero</em>
                </div>
                <div class="widget-content">
                    <!--<div class="demo-flot-chart" id="placeholder"></div>-->
                    <canvas id="myChart" width="60" height="35"></canvas>
                </div>
            </div>                         
        </div>
    </div>
</div> 
<%
} else if (accion.equals("vehiculosReporte")) {
    RElementosIU elemento = (RElementosIU) session.getAttribute("elementosRep");
    session.setAttribute("elementosRep", null);
%>
<div class="main-content">
    <!-- MODAL DIALOG -->
    <div class="modal fade" id="modGeneralReportes" tabindex="-1" role="dialog" aria-labelledby="modGeneralSolicitudes" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">

            </div>
        </div>
    </div>
    <!-- END MODAL DIALOG -->
    <div class="row" id="estadostotales">
        <%
            long total = 0;
            if (elemento != null && elemento.getLista() != null && elemento.itemPos(0) != null) {
                for (RDataset dato : elemento.itemPos(0).getData()) {
                    total += dato.getData();
                    String icon = "";
                    if (dato.getLabel().equals("Disponibles")) {
                        icon = "fa-check-circle";
                    }
                    if (dato.getLabel().equals("Ocupados")) {
                        icon = "fa-user";
                    }
                    if (dato.getLabel().equals("Rematados")) {
                        icon = "fa-close";
                    }
        %>
        <div class="col-sm-2">
            <div class="contextual-summary-info contextual-background " style="background-color: <%=dato.getBackground()%>;">
                <i class="fa <%=icon%>"></i>
                <p class="pull-right"><span><%=dato.getLabel()%></span> <%=dato.getData()%></p>
            </div>
        </div>
        <%
                }
            }
            if (total > 0) {
        %>
        <div class="col-md-2">
            <div class="contextual-summary-info contextual-background btn-custom-secondary">
                <i class="fa fa-users"></i>
                <p class="pull-right"><span>Totales</span><%=total%></p>
            </div>
        </div>
        <%
            }
        %>
    </div>
    <div style="margin-top: 15px;"></div>
    <div class="main-content" id="gSolicitudes_body">
        <div id="mnOpcionesReportes">
            <div class="col-sm-4 col-md-3 sidebar">
                <div class="list-group">
                    <!--                    <span href="#" class="list-group-item main-nav">
                                            Submenu
                                        </span>-->
                    <a href="NominaVehiculosPDF" class="list-group-item" title="Generar lista de vehiculos a exepción de los rematados">
                        <i class="fa fa-check"></i> Nómina vehículos
                    </a>
                    <!--                    <a href="#" class="list-group-item" onclick="fncReporteConductores()">
                                            <i class="fa fa-level-up"></i> total por estado
                                        </a>
                                        <a href="#" class="list-group-item" onclick="fncReporteConductoresGenero()">
                                            <i class="fa fa-level-down"></i> total por genero
                                        </a>-->
                </div>        
            </div>
        </div>
        <div class="col-md-6">
            <div class="widget">
                <div class="widget-header">
                    <h3><i class="fa fa-bar-chart-o"></i> Gráfico de Vehículos</h3> <em> - estados</em>
                </div>
                <div class="widget-content">
                    <!--<div class="demo-flot-chart" id="placeholder"></div>-->
                    <canvas id="myChart" width="60" height="35"></canvas>
                </div>
            </div>                         
        </div>
    </div>
</div> 
<%
} else if (accion.equals("solicitudesReporte")) {
    RElementosIU elemento = (RElementosIU) session.getAttribute("elementosRep");
    session.setAttribute("elementosRep", null);
%>
<div class="main-content">
    <!-- MODAL DIALOG -->
    <div class="modal fade" id="modGeneralReportes" tabindex="-1" role="dialog" aria-labelledby="modGeneralSolicitudes" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">

            </div>
        </div>
    </div>
    <!-- END MODAL DIALOG -->
    <div class="col-sm-12" id="estadostotales">
        <div class="row">
            <%
                long total = 0;
                int cont = 0;
                if (elemento != null && elemento.getLista() != null && elemento.itemPos(0) != null) {
                    for (RDataset dato : elemento.itemPos(0).getData()) {
//                        if(cont++ == 4){
//                            out.println("</div><div style='margin-top: 5px;'></div><div class='row'>");
//                            cont=0;
//                        }
                        total += dato.getData();
                        String icon = "";
                        if (dato.getLabel().equals("Finalizados")) {
                            icon = "fa-check-circle";
                        }
                        if (dato.getLabel().equals("Rechazados")) {
                            icon = "fa-thumbs-o-down";
                        }
                        if (dato.getLabel().equals("Asignados")) {
                            icon = "fa-car";
                        }
                        if (dato.getLabel().equals("Creados")) {
                            icon = "fa-envelope-o";
                        }
                        if (dato.getLabel().equals("Eliminados")) {
                            icon = "fa-close";
                        }
                        if (dato.getLabel().equals("Aprobado UGT")) {
                            icon = "fa-star";
                        }
                        if (dato.getLabel().equals("Aprobado VR")) {
                            icon = "fa-thumbs-o-up";
                        }
            %>
            <div class="col-sm-2">
                <div class="contextual-summary-info contextual-background " style="background-color: <%=dato.getBackground()%>;">
                    <i class="fa <%=icon%>"></i>
                    <p class="pull-right"><span><%=dato.getLabel()%></span> <%=dato.getData()%></p>
                </div>
            </div>
            <%
                    }
                }
                if (total > 0) {
            %>
            <div class="col-md-2">
                <div class="contextual-summary-info contextual-background btn-custom-secondary">
                    <i class="fa fa-users"></i>
                    <p class="pull-right"><span>Totales</span><%=total%></p>
                </div>
            </div>
            <%
                }
            %>
        </div>
    </div>
    <div class="col-sm-12" style="margin-top: 15px;"></div>
    <div class="main-content" id="gSolicitudes_body">
        <!--        <div id="mnOpcionesReportes">
                    <div class="col-sm-4 col-md-3 sidebar">
                        <div class="list-group">
                                                <span href="#" class="list-group-item main-nav">
                                                    Submenu
                                                </span>
                            <a href="NominaVehiculosPDF" class="list-group-item" title="Generar lista de vehiculos a exepción de los rematados">
                                <i class="fa fa-check"></i> Solicitudes PDF
                            </a>
                                                <a href="#" class="list-group-item" onclick="fncReporteConductores()">
                                                    <i class="fa fa-level-up"></i> total por estado
                                                </a>
                                                <a href="#" class="list-group-item" onclick="fncReporteConductoresGenero()">
                                                    <i class="fa fa-level-down"></i> total por genero
                                                </a>
                        </div>        
                    </div>
                </div>-->
        <div class="col-md-6">
            <div class="widget">
                <div class="widget-header">
                    <h3><i class="fa fa-bar-chart-o"></i> Gráfico de Solicitudes</h3> <em> - estados</em>
                </div>
                <div class="widget-content">
                    <!--<div class="demo-flot-chart" id="placeholder"></div>-->
                    <canvas id="myChart" width="60" height="35"></canvas>
                </div>
            </div>                         
        </div>
    </div>
</div> 
<%
} else if (accion.equals("ordenesReporte")) {
    RElementosIU elemento = (RElementosIU) session.getAttribute("elementosRep");
    session.setAttribute("elementosRep", null);
%>
<div class="main-content">
    <!-- MODAL DIALOG -->
    <div class="modal fade" id="modGeneralReportes" tabindex="-1" role="dialog" aria-labelledby="modGeneralSolicitudes" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">

            </div>
        </div>
    </div>
    <!-- END MODAL DIALOG -->
    <div class="col-sm-12" id="estadostotales">
        <div class="row">
            <%
                long total = 0;
                if (elemento != null && elemento.getLista() != null && elemento.itemPos(0) != null) {
                    for (RDataset dato : elemento.itemPos(0).getData()) {
                        String icon = "";
                        if (dato.getLabel().equals("Aprobado VR")) {
                            icon = "fa-thumbs-o-up";
                            total += dato.getData();
            %>
            <div class="col-sm-2">
                <div class="contextual-summary-info contextual-background " style="background-color: <%=dato.getBackground()%>;">
                    <i class="fa <%=icon%>"></i>
                    <p class="pull-right"><span>Sin Generar</span> <%=dato.getData()%></p>
                </div>
            </div>
            <%
                }
                if (dato.getLabel().equals("Finalizados")) {
                    icon = "fa-magic";
                    total += dato.getData();
            %>
            <div class="col-sm-2">
                <div class="contextual-summary-info contextual-background " style="background-color: <%=dato.getBackground()%>;">
                    <i class="fa <%=icon%>"></i>
                    <p class="pull-right"><span>Generados</span> <%=dato.getData()%></p>
                </div>
            </div>
            <%
                        }
                    }
                }
                if (total > 0) {
            %>
            <div class="col-md-2">
                <div class="contextual-summary-info contextual-background btn-custom-secondary">
                    <i class="fa fa-copy"></i>
                    <p class="pull-right"><span>Totales</span><%=total%></p>
                </div>
            </div>
            <%
                }
            %>
        </div>
    </div>
    <div class="col-sm-12" style="margin-top: 15px;"></div>
    <div class="main-content" id="gSolicitudes_body">
        <div id="mnOpcionesReportes">
            <div class="col-md-3 sidebar">
                <div class="list-group">
                    <!--                    <span href="#" class="list-group-item main-nav">
                                            Submenu
                                        </span>-->
                    <a href="#" class="list-group-item" title="Generar informe de viajes institucionales por fecha" onclick="fcModalInformeViajes('modGeneralReportes')">
                        <i class="fa fa-check"></i>Informe viajes institucionales PDF
                    </a>
                    <a href="#" class="list-group-item" title="Generar informe de viajes institucionales por fecha" onclick="fcModalInformeViajesConductores('modGeneralReportes')">
                        <i class="fa fa-check"></i>Informe resumen conductores kilometros PDF
                    </a>
                </div>      
            </div>
        </div>
        <div class="col-md-6">
            <div class="widget">
                <div class="widget-header">
                    <h3><i class="fa fa-bar-chart-o"></i> Gráfico de Ordenes</h3> <em> - estados</em>
                </div>
                <div class="widget-content">
                    <!--<div class="demo-flot-chart" id="placeholder"></div>-->
                    <canvas id="myChart" width="60" height="35"></canvas>
                </div>
            </div>                         
        </div>
    </div>
</div> 
<%
} else if (accion.equals("modalInformeViajes")) {
%>
<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
    <h4 class="modal-title" id="titleModalSolicitanteInfo"> Reportes ordenes | Informe viajes por fechas </h4>
</div>
<div class="modal-body">
    <form id="formRangoFechas" class="form-horizontal" role="form" method="POST">
        <h4>Ingrese el rango de la fecha para generar su informe</h4>
        <div class="form-group">
            <label  class='col-sm-2 control-label' ><h4>Inicio</h4></label>
            <div class="col-sm-10">
                <input id="starFecha" name="starFecha" type="date" class="form-control" title="Fecha inicio" required/>
                <p id="error-starDate"></p>
            </div>
        </div>
        <div class="form-group">
            <label  class='col-sm-2 control-label' ><h4>Fin</h4></label>
            <div class="col-sm-10">
                <input id="endFecha" name="endFecha" type="date" class="form-control" title="Fecha Fin" required/>
                <p id="error-endDate"></p>
            </div>
        </div>
        <div class='modal-footer'>
            <button type='submit' class='btn btn-success' id="btsuccesscerrar"><i class='fa fa-upload'></i> Generar</button>
            <button type='button' class='btn btn-default' data-dismiss='modal'><i class='fa fa-times-circle'></i> Cerrar</button>
        </div>
    </form>
</div>
<script>
    $(document).ready(function () {
        var today = new Date();
        var dd = today.getDate();
        var mm = today.getMonth() + 1; //January is 0!
        var yyyy = today.getFullYear();
        if (dd < 10) {
            dd = '0' + dd;
        }
        if (mm < 10) {
            mm = '0' + mm;
        }
        today = yyyy + '-' + mm + '-' + dd;
//        document.getElementById("starFecha").setAttribute("value", today);

        $("#starFecha").change(function (e) {
            var f1 = $("#starFecha").val();
            var f2 = $("#endFecha").val();
            if (typeof f2 !== 'undefined' && new Date(f2).getTime() < new Date(f1).getTime()) {
                alert("La fecha inicio debe ser menor o igual que la final");
                $("#starFecha").val("");
            }
        });
        $("#endFecha").change(function (e) {
            var f1 = $("#starFecha").val();
            var f2 = $("#endFecha").val();
            if (typeof f1 !== 'undefined' && new Date(f2).getTime() < new Date(f1).getTime()) {
                alert("La fecha final debe ser mayor o igual que la de inicio");
                $("#endFecha").val("");
            }
        });

        $("#formRangoFechas").submit(function () {
            $('#modGeneralReportes').modal('hide'); //or  $('#IDModal').modal('hide');
        });
    });
</script>
<%
} else if (accion.equals("modalInformeConductores")) {
%>
<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
    <h4 class="modal-title" id="titleModalSolicitanteInfo"> Reportes ordenes | Resumen viajes conductores por fechas </h4>
</div>
<div class="modal-body">
    <form id="formRangoFechas" class="form-horizontal" role="form" method="POST">
        <h4>Ingrese el rango de la fecha para generar su informe</h4>
        <div class="form-group">
            <label  class='col-sm-2 control-label' ><h4>Inicio</h4></label>
            <div class="col-sm-10">
                <input id="starFecha" name="starFecha" type="date" class="form-control" title="Fecha inicio" required/>
                <p id="error-starDate"></p>
            </div>
        </div>
        <div class="form-group">
            <label  class='col-sm-2 control-label' ><h4>Fin</h4></label>
            <div class="col-sm-10">
                <input id="endFecha" name="endFecha" type="date" class="form-control" title="Fecha Fin" required/>
                <p id="error-endDate"></p>
            </div>
        </div>
        <div class='modal-footer'>
            <button type='submit' class='btn btn-success' id="btsuccesscerrar"><i class='fa fa-upload'></i> Generar</button>
            <button type='button' class='btn btn-default' data-dismiss='modal'><i class='fa fa-times-circle'></i> Cerrar</button>
        </div>
    </form>
</div>
<script>
    $(document).ready(function () {
        var today = new Date();
        var dd = today.getDate();
        var mm = today.getMonth() + 1; //January is 0!
        var yyyy = today.getFullYear();
        if (dd < 10) {
            dd = '0' + dd;
        }
        if (mm < 10) {
            mm = '0' + mm;
        }
        today = yyyy + '-' + mm + '-' + dd;
//        document.getElementById("starFecha").setAttribute("value", today);

        $("#starFecha").change(function (e) {
            var f1 = $("#starFecha").val();
            var f2 = $("#endFecha").val();
            if (typeof f2 !== 'undefined' && new Date(f2).getTime() < new Date(f1).getTime()) {
                alert("La fecha inicio debe ser menor o igual que la final");
                $("#starFecha").val("");
            }
        });
        $("#endFecha").change(function (e) {
            var f1 = $("#starFecha").val();
            var f2 = $("#endFecha").val();
            if (typeof f1 !== 'undefined' && new Date(f2).getTime() < new Date(f1).getTime()) {
                alert("La fecha final debe ser mayor o igual que la de inicio");
                $("#endFecha").val("");
            }
        });

        $("#formRangoFechas").submit(function () {
            $('#modGeneralReportes').modal('hide'); //or  $('#IDModal').modal('hide');
        });
    });
</script>
<%
        }
    } else {
        response.sendError(501, this.getServletName() + "-> Error no se ha logueado en el sistema contacte con proveedor");
    }
%>
