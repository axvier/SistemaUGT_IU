<%-- 
    Document   : ReportesVista
    Created on : 22/01/2019, 11:41:52 AM
    Author     : Xavy PC
--%>

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
    <div class="modal fade" id="modGeneralSolicitudes" tabindex="-1" role="dialog" aria-labelledby="modGeneralSolicitudes" aria-hidden="true">
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
                <i class="fa fa-close"></i>
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
                    <a href="#" class="list-group-item">
                        <i class="fa fa-check"></i> Nómina Conductores pdf
                    </a>
                    <a href="#" class="list-group-item">
                        <i class="fa fa-level-up"></i> Con viajes ascendente pdf
                    </a>
                    <a href="#" class="list-group-item">
                        <i class="fa fa-level-down"></i> Con viaje descendente pdf
                    </a>
                </div>        
            </div>
        </div>
        <div class="col-md-8">
            <div class="widget">
                <div class="widget-header">
                    <h3><i class="fa fa-bar-chart-o"></i> Gráfico de conductores</h3> <em> - estados</em>
                </div>
                <div class="widget-content">
                    <!--<div class="demo-flot-chart" id="placeholder"></div>-->
                    <canvas id="myChart" width="80" height="40"></canvas>
                </div>
            </div>                         
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
