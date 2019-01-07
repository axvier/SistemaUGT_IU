<%-- 
    Document   : SolicitudesModelo
    Created on : 5/01/2019, 05:55:59 PM
    Author     : Xavy PC
--%>

<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="ugt.entidades.Tbusuariosentidad"%>
<%@page import="ugt.servicios.swSeccionSolicitante"%>
<%@page import="ugt.servicios.swSolicitudes"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="utg.login.Login"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Login login = (Login) session.getAttribute("login");
    if (login != null) {
        String opc = request.getParameter("opc");
        Gson g = new Gson();
        if (opc.equals("jsonSolicitudesEnviados")) {
//            String estado = (String) session.getAttribute("estadoSolicitudes");
            String estado = "enviado";
            session.setAttribute("estadoSolicitudes", null);
            String arrayJSON = swSolicitudes.filtrarSolicitudesEstado(estado);
            if (arrayJSON.length() > 2) {
                session.setAttribute("arrayJSON", arrayJSON);
                response.sendRedirect("SolicitudesControlador.jsp?opc=mostrar&accion=" + opc);
            } else {
                response.sendRedirect("SolicitudesControlador.jsp?opc=mostrar&accion=jsonVacio");
            }
        } else if (opc.equals("modificarSolicitud")) {
            String idSolicitud = (String) session.getAttribute("idSolicitud");
            String jsonsSolicitud = (String) session.getAttribute("jsonSolicitud");
            session.setAttribute("iSolicitudd", null);
            session.setAttribute("jsonSolicitud", null);
            String jsonMod = swSolicitudes.modificarSolicitudID(idSolicitud, jsonsSolicitud);
            if (jsonMod.length() > 2) {
                session.setAttribute("statusMod", "Se ha actualizado los datos");
                session.setAttribute("statusCodigo", "OK");
            } else {
                session.setAttribute("statusMod", "Error al intentar acuatlizar los datos - contacte con el proveedor");
                session.setAttribute("statusCodigo", "KO");
            }
            response.sendRedirect("SolicitudesControlador.jsp?opc=mostrar&accion=modificarStatus");
        } else if (opc.equals("modSolicitanteInfo")) {
            g = new GsonBuilder().setDateFormat("yyyy-MM-dd'T'HH:mm:ss-05:00").create();
            String cedula = (String) session.getAttribute("cedulaSolicitante");
            session.setAttribute("cedulaSolicitante", null);
            String objJSON = swSeccionSolicitante.buscarEntidadUsuarioOpc(cedula, "9");
            if (objJSON.length() > 2) {
                Tbusuariosentidad userSol = g.fromJson(objJSON, Tbusuariosentidad.class);
                session.setAttribute("userSol", userSol);
            }
            response.sendRedirect("SolicitudesControlador.jsp?opc=mostrar&accion=" + opc);
        } else if (opc.equals("disponibilidadVehiculoConductor")) {
            g = new GsonBuilder().setDateFormat("yyyy-MM-dd'T'HH:mm:ss-05:00").create();
            String cedula = (String) session.getAttribute("cedulaSolicitante");
            session.setAttribute("cedulaSolicitante", null);
            String objJSON = swSeccionSolicitante.buscarEntidadUsuarioOpc(cedula, "9");
            if (objJSON.length() > 2) {
                Tbusuariosentidad userSol = g.fromJson(objJSON, Tbusuariosentidad.class);
                session.setAttribute("userSol", userSol);
            }
            response.sendRedirect("SolicitudesControlador.jsp?opc=mostrar&accion=" + opc);
        }
    } else {
        response.sendError(501, this.getServletName() + "-> Error no se ha logueado en el sistema contacte con proveedor");
    }
%>
