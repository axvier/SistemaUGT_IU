<%-- 
    Document   : SolicitudesControlador
    Created on : 5/01/2019, 05:56:20 PM
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
                response.sendRedirect("SolicitudesVista.jsp?accion=" + accion);
            } else if (opc.equals("jsonSolicitudesEnviados")) {
                response.sendRedirect("SolicitudesModelo.jsp?opc=" + opc);
            } else if (opc.equals("modSolicitanteInfo")) {
                String cedula = request.getParameter("cedulaSolicitante");
                String idSolicitud = request.getParameter("idSolicitud");
                session.setAttribute("cedulaSolicitante", cedula);
                session.setAttribute("idSolicitud", idSolicitud);
                response.sendRedirect("SolicitudesModelo.jsp?opc=" + opc);
            }
        }
    } else {
        response.sendError(501, this.getServletName() + "-> Error no se ha logueado en el sistema contacte con proveedor");
    }
%>
