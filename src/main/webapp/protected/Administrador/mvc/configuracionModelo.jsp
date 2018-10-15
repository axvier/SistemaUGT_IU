<%@page import="sistema.ugt.configuracion.ConductoresIU"%>
<%@page import="sistema.ugt.configuracion.VehiculosIU"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="sistema.utg.webservice.SistemaSW"%>
<%@page import="sistema.utg.webservice.SistemaSW_Service"%>
<%
    String opc = request.getParameter("opc");
    SistemaSW_Service port = new SistemaSW_Service();
    SistemaSW servicios = port.getSistemaSWPort();
    Gson g = new Gson();
    if (opc.equals("vehiculosConfg")) { //cargar los vehiculos
        String jsonSolicitud = servicios.vehiculosCargar();
        VehiculosIU vehiculosIU = g.fromJson(jsonSolicitud, VehiculosIU.class);
        session.setAttribute("VehiculosIU", vehiculosIU);
        response.sendRedirect("configuracionControlador.jsp?opc=mostrar&accion=vehiculosConfg");
    } else if (opc.equals("conductorConfg")) { //cargar los conductores
        String jsonSolicitud = servicios.conductoresCargar();
        ConductoresIU conductoresIU = g.fromJson(jsonSolicitud, ConductoresIU.class);
        session.setAttribute("ConductoresIU", conductoresIU);
        response.sendRedirect("configuracionControlador.jsp?opc=mostrar&accion=conductorConfg");
    }
%>
