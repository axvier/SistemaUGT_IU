<%@page import="ugt.servicios.swLicencia"%>
<%@page import="ugt.servicios.swConductor"%>
<%@page import="com.google.gson.Gson"%>
<%
    String opc = request.getParameter("opc");
    Gson g = new Gson();
    if (opc.equals("conductoresConfg")) { //cargar los conductores
        String arrayJSON = swConductor.listarConductores();
        if (arrayJSON.length() > 2) {
//            ConductoresIU conductoresIU = new ConductoresIU();
//            conductoresIU.setListaJSON(arrayJSON);
//            session.setAttribute("ConductoresIU", conductoresIU);
            response.sendRedirect("conductorControlador.jsp?opc=mostrar&accion=conductoresConfg");
        }
    } else if (opc.equals("saveConductor")) {
        String jsonConductor = (String) session.getAttribute("jsonConductor");
        String jsonLicencia = (String) session.getAttribute("jsonLicencia");
        session.setAttribute("jsonConductor", null);
        session.setAttribute("jsonLicencia", null);
        String jsonObject = swConductor.insertConductor(jsonConductor);
        if (jsonObject.length() > 2) {
            String arrayJSON = swLicencia.insertLicencia(jsonLicencia);
            if (arrayJSON.length() > 2) {
                session.setAttribute("statusGuardar", "OK");
            } else {
                session.setAttribute("statusGuardar", "KO");
            }
            response.sendRedirect("conductorControlador.jsp?opc=mostrar&accion=guardarStatus");
        } else {
            response.sendError(200, "Ha ocurrido un error al momento de guardar");
        }
    } else if (opc.equals("eliminarConductor")) {
        String cedula = request.getParameter("cedula");
        String json = (String) session.getAttribute("json");
        session.setAttribute("json", null);
        String arrayJSON = swConductor.bloquearConductor(json, cedula);
        if (arrayJSON.length() > 2) {
            session.setAttribute("statusEliminar", "OK");
        } else {
            session.setAttribute("statusEliminar", "KO");
        }
        response.sendRedirect("conductorControlador.jsp?opc=mostrar&accion=eliminarStatus");
    } else if (opc.equals("modificarConductor")) {
        String cedula = (String) session.getAttribute("cedulaConductor");
        String jsonConductor = (String) session.getAttribute("jsonConductor");
        String jsonMod = swConductor.modificarConductor(jsonConductor, cedula);
        if (jsonMod.length() > 2) {
            session.setAttribute("statusMod", "OK");
        } else {
            session.setAttribute("statusMod", "KO");
        }
        response.sendRedirect("conductorControlador.jsp?opc=mostrar&accion=modificarStatus");
    } else if (opc.equals("jsonConductores")) {
        String jsonMod = swConductor.listarConductoresDisponibles();
        if (jsonMod.length() > 2) {
            session.setAttribute("jsonArray", jsonMod);
            response.sendRedirect("conductorControlador.jsp?opc=mostrar&accion=jsonConductores");
        } else {
            response.sendRedirect("protected/vista.jsp?accion=jsonVacio");

        }
    }
%>