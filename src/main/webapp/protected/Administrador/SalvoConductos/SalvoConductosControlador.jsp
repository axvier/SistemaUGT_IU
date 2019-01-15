<%-- 
    Document   : SalvoConductosControlador
    Created on : 14/01/2019, 01:30:49 PM
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
                response.sendRedirect("SalvoConductosVista.jsp?accion=" + accion);
            } else if (opc.equals("jsonSolicitudesEstado")) {
                String estado = request.getParameter("estadoSolicitudes");
                session.setAttribute("estadoSolicitudes", estado);
                response.sendRedirect("SalvoConductosModelo.jsp?opc=" + opc);
            } else if (opc.equals("modificarSolicitud")) {
                String jsonSolicitud = request.getParameter("jsonSolicitud");
                session.setAttribute("jsonSolicitud", jsonSolicitud);
                String idSolicitud = request.getParameter("idSolicitud");
                session.setAttribute("idSolicitud", idSolicitud);
                response.sendRedirect("SalvoConductosModelo.jsp?opc=" + opc);
            } else if (opc.equals("modGenerarSalvoConducto")) {
                String jsonSolicitud = java.net.URLDecoder.decode(request.getParameter("jsonSolicitud"), "UTF-8");
                session.setAttribute("jsonSolicitud", jsonSolicitud);
                response.sendRedirect("SalvoConductosModelo.jsp?opc=" + opc);
            }
        }
    } else {
        response.sendError(501, this.getServletName() + "-> Error no se ha logueado en el sistema contacte con proveedor");
    }
%>
