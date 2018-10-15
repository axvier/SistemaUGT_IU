<%@page import="sistema.ugt.vehiculos.iu.VehiculosIU"%>
<%@page import="sistema.ugt.solicitud.ContenidoSolicitudIU"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String accion = request.getParameter("accion");
    Gson G = new Gson();
    if (accion.equals("vehiculosConfg")) { // cargar los vehiculos para datos de configuracion
        VehiculosIU vehiculosIU = (VehiculosIU) session.getAttribute("VehiculosIU");
        String resultado = vehiculosIU.Vehiculos(accion);
        response.setContentType("text/plain");
        response.getWriter().write(resultado);
    } else if (accion.equals("respuesta")) {
        String respuesta = (String) session.getAttribute("respuesta");
        String result = "{"
                + "\"respuesta\":\"" + respuesta + "\""
                + "}";
        response.setContentType("text/plain");
        response.getWriter().write(result);
    }
    /*else if (accion.equals("conductorConfg")) { //cargar conductores desde los datos de la solicitud
        ConductoresIU conductoresIU = (ConductoresIU) session.getAttribute("ConductoresIU");
        String resultado = conductoresIU.Conductores(accion);
        response.setContentType("text/plain");
        response.getWriter().write(resultado);
    }*/
%>