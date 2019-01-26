<%-- 
    Document   : ReportesControlador
    Created on : 22/01/2019, 11:42:15 AM
    Author     : Xavy PC
--%>

<%@page import="utg.login.Login"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    Login login = (Login) session.getAttribute("login");
    if (login != null) {
        String opc = request.getParameter("opc");
        if (opc != null) {
            if (opc.equals("mostrar")) {
                String accion = request.getParameter("accion");
                response.sendRedirect("ReportesVista.jsp?accion=" + accion);
            } else if (opc.equals("conductoresReporte")) {
                response.sendRedirect("ReportesModelo.jsp?opc=" + opc);
            } else if (opc.equals("conductoresChartEstado")) {
                response.sendRedirect("ReportesModelo.jsp?opc=" + opc);
            } else if (opc.equals("conductoresReporteGenero")) {
                response.sendRedirect("ReportesModelo.jsp?opc=" + opc);
            } else if (opc.equals("conductoresChartGenero")) {
                response.sendRedirect("ReportesModelo.jsp?opc=" + opc);
            } else if (opc.equals("vehiculosReporte")) {
                response.sendRedirect("ReportesModelo.jsp?opc=" + opc);
            }
        }
    } else {
        response.sendError(501, this.getServletName() + "-> Error no se ha logueado en el sistema contacte con proveedor");
    }
%>
