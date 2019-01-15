<%-- 
    Document   : SalvoConductosModelo
    Created on : 14/01/2019, 01:30:30 PM
    Author     : Xavy PC
--%>

<%@page import="ugt.entidades.Tbsolicitudes"%>
<%@page import="ugt.servicios.swSolicitudes"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="utg.login.Login"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Login login = (Login) session.getAttribute("login");
    if (login != null) {
        String opc = request.getParameter("opc");
        Gson g = new Gson();
        if (opc.equals("jsonSolicitudesEstado")) {
            String estado = (String) session.getAttribute("estadoSolicitudes");
            session.setAttribute("estadoSolicitudes", null);
            String arrayJSON = swSolicitudes.filtrarSolicitudesEstado(estado);
            if (arrayJSON.length() > 2) {
                session.setAttribute("arrayJSON", arrayJSON);
                response.sendRedirect("SalvoConductosControlador.jsp?opc=mostrar&accion=arrayJSON");
            } else {
                response.sendRedirect("SalvoConductosControlador.jsp?opc=mostrar&accion=jsonVacio");
            }
        } else if (opc.equals("ModificarSolicitud")) {
            String idSolicitud = (String) session.getAttribute("idSolicitud");
            String jsonsSolicitud = (String) session.getAttribute("jsonSolicitud");
            session.setAttribute("idSolicitud", null);
            session.setAttribute("jsonSolicitud", null);
            String jsonMod = swSolicitudes.modificarSolicitudID(idSolicitud, jsonsSolicitud);
            if (jsonMod.length() > 2) {
                session.setAttribute("statusMod", "Se ha actualizado los datos");
                session.setAttribute("statusCodigo", "OK");
            } else {
                session.setAttribute("statusMod", "Error al intentar acuatlizar los datos - contacte con el proveedor");
                session.setAttribute("statusCodigo", "KO");
            }
            response.sendRedirect("SalvoConductosControlador.jsp?opc=mostrar&accion=modificarStatus");
        } else if (opc.equals("modGenerarSalvoConducto")) {
            String jsonsSolicitud = (String) session.getAttribute("jsonSolicitud");
            session.setAttribute("jsonSolicitud", null);
            if (jsonsSolicitud.length() > 2) {
                Tbsolicitudes solicitudGen = g.fromJson(jsonsSolicitud, Tbsolicitudes.class);
                session.setAttribute("solicitudGen", solicitudGen);
            }
            response.sendRedirect("SalvoConductosControlador.jsp?opc=mostrar&accion="+opc);
        }
    } else {
        response.sendError(501, this.getServletName() + "-> Error no se ha logueado en el sistema contacte con proveedor");
    }
%>
