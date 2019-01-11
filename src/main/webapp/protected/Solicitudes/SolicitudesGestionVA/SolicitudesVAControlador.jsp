<%-- 
    Document   : SolicitudesVAControlador
    Created on : 10/01/2019, 09:24:02 PM
    Author     : Xavy PC
--%>

<%@page import="utg.login.Login"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Login login = (Login) session.getAttribute("login");
    if (login != null) {
        String opc = request.getParameter("opc");
        if (opc != null) {
            if (opc.equals("mostrar")) {
                String accion = request.getParameter("accion");
                response.sendRedirect("SolicitudesVAVista.jsp?accion=" + accion);
            } else if (opc.equals("jsonSolicitudesAsignada")) {
                response.sendRedirect("SolicitudesVAModelo.jsp?opc=" + opc);
            }
        }
    } else {
        response.sendError(501, this.getServletName() + "-> Error no se ha logueado en el sistema contacte con proveedor");
    }
%>
