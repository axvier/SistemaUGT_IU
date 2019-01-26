<%-- 
    Document   : SolicitudesVAModelo
    Created on : 10/01/2019, 09:23:45 PM
    Author     : Xavy PC
--%>

<%@page import="ugt.registros.iu.RegistrosM"%>
<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="ugt.entidades.Tbsolicitudes"%>
<%@page import="org.json.JSONObject"%>
<%@page import="ugt.servicios.swSolicitudes"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="utg.login.Login"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Login login = (Login) session.getAttribute("login");
    if (login != null) {
        String opc = request.getParameter("opc");
        Gson g = new Gson();
        if (opc.equals("jsonSolicitudesAsignada")) {
            String estado = "aprobadaUGT";
            session.setAttribute("estadoSolicitudes", null);
            String arrayJSON = swSolicitudes.filtrarSolicitudesEstado(estado);
            if (arrayJSON.length() > 2) {
                session.setAttribute("arrayJSON", arrayJSON);
                response.sendRedirect("SolicitudesVAControlador.jsp?opc=mostrar&accion=arrayJSON");
            } else {
                response.sendRedirect("SolicitudesVAControlador.jsp?opc=mostrar&accion=jsonVacio");
            }
        } else if (opc.equals("jsonSolicitudesAprobadas")) {
            String estado = "aprobada";
            session.setAttribute("estadoSolicitudes", null);
            String arrayJSON = swSolicitudes.filtrarSolicitudesEstado(estado);
            if (arrayJSON.length() > 2) {
                session.setAttribute("arrayJSON", arrayJSON);
                response.sendRedirect("SolicitudesVAControlador.jsp?opc=mostrar&accion=arrayJSON");
            } else {
                response.sendRedirect("SolicitudesVAControlador.jsp?opc=mostrar&accion=jsonVacio");
            }
        } else if (opc.equals("modificarSolicitud")) {
            g = new GsonBuilder().setDateFormat("yyyy-MM-dd'T'HH:mm:ss-05:00").create();
            String idSolicitud = (String) session.getAttribute("idSolicitud");
            String jsonsSolicitud = (String) session.getAttribute("jsonSolicitud");
            session.setAttribute("idSolicitud", null);
            session.setAttribute("jsonSolicitud", null);
            String jsonMod = swSolicitudes.modificarSolicitudID(idSolicitud, jsonsSolicitud);
            if (jsonMod.length() > 2) {
                session.setAttribute("statusMod", "Se ha actualizado los datos");
                session.setAttribute("statusCodigo", "OK");
                Tbsolicitudes sol = g.fromJson(jsonMod, Tbsolicitudes.class);
                if (sol.getObservacion() != null && sol.getObservacion().length() > 0) {
                    RegistrosM.Insertar(login, sol, opc);
                }
            } else {
                session.setAttribute("statusMod", "Error al intentar acuatlizar los datos - contacte con el proveedor");
                session.setAttribute("statusCodigo", "KO");
            }
            response.sendRedirect("SolicitudesVAControlador.jsp?opc=mostrar&accion=modificarStatus");
        } else if (opc.equals("aprobarSolicitud")) {
            g = new GsonBuilder().setDateFormat("yyyy-MM-dd'T'HH:mm:ss-05:00").create();
            String idSolicitud = (String) session.getAttribute("idSolicitud");
            String jsonsSolicitud = (String) session.getAttribute("jsonSolicitud");
            session.setAttribute("idSolicitud", null);
            session.setAttribute("jsonSolicitud", null);
            Tbsolicitudes solicitud = g.fromJson(jsonsSolicitud, Tbsolicitudes.class);
            solicitud.setEstado("aprobada");
            String jsonMod = swSolicitudes.modificarSolicitudID(idSolicitud, g.toJson(solicitud));
            if (jsonMod.length() > 2) {
                session.setAttribute("statusMod", "Se ha actualizado los datos");
                session.setAttribute("statusCodigo", "OK");
                RegistrosM.Insertar(login, solicitud, solicitud.getEstado());
            } else {
                session.setAttribute("statusMod", "Error al intentar acuatlizar los datos - contacte con el proveedor");
                session.setAttribute("statusCodigo", "KO");
            }
            response.sendRedirect("SolicitudesVAControlador.jsp?opc=mostrar&accion=modificarStatus");
        } else if (opc.equals("rechazarSolicitud")) {
            g = new GsonBuilder().setDateFormat("yyyy-MM-dd'T'HH:mm:ss-05:00").create();
            String idSolicitud = (String) session.getAttribute("idSolicitud");
            String jsonsSolicitud = (String) session.getAttribute("jsonSolicitud");
            session.setAttribute("idSolicitud", null);
            session.setAttribute("jsonSolicitud", null);
            Tbsolicitudes solicitud = g.fromJson(jsonsSolicitud, Tbsolicitudes.class);
            solicitud.setEstado("rechazada");
            String jsonMod = swSolicitudes.modificarSolicitudID(idSolicitud, g.toJson(solicitud));
            if (jsonMod.length() > 2) {
                RegistrosM.Insertar(login, solicitud, solicitud.getEstado());
                session.setAttribute("statusMod", "Se ha actualizado los datos");
                session.setAttribute("statusCodigo", "OK");
            } else {
                session.setAttribute("statusMod", "Error al intentar acuatlizar los datos - contacte con el proveedor");
                session.setAttribute("statusCodigo", "KO");
            }
            response.sendRedirect("SolicitudesVAControlador.jsp?opc=mostrar&accion=modificarStatus");
        }
    } else {
        response.sendError(501, this.getServletName() + "-> Error no se ha logueado en el sistema contacte con proveedor");
    }
%>
