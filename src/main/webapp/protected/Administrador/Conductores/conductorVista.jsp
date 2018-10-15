<%@page import="ugt.conductores.iu.ConductoresIU"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String accion = request.getParameter("accion");
    Gson G = new Gson();
    if (accion.equals("conductoresConfg")) { //cargar conductores desde los datos de la solicitud
        ConductoresIU conductoresIU = (ConductoresIU) session.getAttribute("ConductoresIU");
        String resultado = conductoresIU.toHTML();
        response.setContentType("text/plain");
        response.getWriter().write(resultado);
    } else if (accion.equals("respuesta")) {
        String respuesta = (String) session.getAttribute("respuesta");
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
    <div class="widget widget-table">
        <div class="widget-header">
            <h3><i class="fa fa-table"></i> Gestión </h3><em>Tabla para editar la  información de los conductores disponilbes</em>
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
<%
    } else if(accion.equals("jsonConductores")) {
        String json = (String) session.getAttribute("jsonArray");
        session.setAttribute("jsonArray", null);
        out.print(json);
    }
%>

