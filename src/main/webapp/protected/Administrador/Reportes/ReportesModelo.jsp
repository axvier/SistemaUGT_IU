<%-- 
    Document   : ReportesModelo
    Created on : 22/01/2019, 11:41:43 AM
    Author     : Xavy PC
--%>

<%@page import="ugt.reportes.iu.RElementosIU"%>
<%@page import="ugt.reportes.ConductoresRepGenero"%>
<%@page import="ugt.reportes.iu.ConductoresReporteEstadosIU"%>
<%@page import="ugt.servicios.swReportes"%>
<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="utg.login.Login"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    Login login = (Login) session.getAttribute("login");
    if (login != null) {
        String opc = request.getParameter("opc");
        Gson g = new Gson();
        if (opc.equals("conductoresReporte")) {
            String objJSON = swReportes.reporteEstadoConductor();
            if (objJSON.length() > 2) {
                ConductoresReporteEstadosIU repCondEstado = g.fromJson(objJSON, ConductoresReporteEstadosIU.class);
                session.setAttribute("repCondEstado", repCondEstado);
            }
            response.sendRedirect("ReportesControlador.jsp?opc=mostrar&accion=" + opc);
        } else if (opc.equals("conductoresChartEstado")) {
            String objJSON = swReportes.reporteEstadoConductor();
            if (objJSON.length() > 2) {
//                ConductoresReporteEstadosIU repCondEstado = g.fromJson(objJSON, ConductoresReporteEstadosIU.class);
                session.setAttribute("repCondEstado", objJSON);
            }
            response.sendRedirect("ReportesControlador.jsp?opc=mostrar&accion=" + opc);
        } else if (opc.equals("conductoresReporteGenero")) {
            String objJSON = swReportes.reporteGeneroConductor();
            if (objJSON.length() > 2) {
                ConductoresRepGenero repGenero = g.fromJson(objJSON, ConductoresRepGenero.class);
                session.setAttribute("repGenero", repGenero);
            }
            response.sendRedirect("ReportesControlador.jsp?opc=mostrar&accion=" + opc);
        } else if (opc.equals("conductoresChartGenero")) {
            String objJSON = swReportes.reporteGeneroConductor();
            if (objJSON.length() > 2) {
                session.setAttribute("respuestaJSON", objJSON);
            }
            response.sendRedirect("ReportesControlador.jsp?opc=mostrar&accion=respuestaJSON");
        } else if (opc.equals("vehiculosReporte")) {
            String arrayJSON = swReportes.reporteVehiculosTipo("estados");
            if (arrayJSON.length() > 2) {
                RElementosIU elementos = new RElementosIU();
                elementos.setListaJSON(arrayJSON);
                session.setAttribute("respuestaJSON", arrayJSON);
                session.setAttribute("elementosRep", elementos);
            }
            response.sendRedirect("ReportesControlador.jsp?opc=mostrar&accion=" + opc);
        }
    } else {
        response.sendError(501, this.getServletName() + "-> Error no se ha logueado en el sistema contacte con proveedor");
    }
%>
