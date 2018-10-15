<%@page import="ugt.servicios.swConductor"%>
<%@page import="com.google.gson.Gson"%>
<%
    String opc = request.getParameter("opc");
    Gson g = new Gson();
    if (opc.equals("conductoresConfg")) { //cargar los conductores
        String arrayJSON = swConductor.listarConductores();
        if (arrayJSON.length() > 0) {
//            ConductoresIU conductoresIU = new ConductoresIU();
//            conductoresIU.setListaJSON(arrayJSON);
//            session.setAttribute("ConductoresIU", conductoresIU);
            response.sendRedirect("conductorControlador.jsp?opc=mostrar&accion=conductoresConfg");
        }
    } else if (opc.equals("saveConductor")) {
        String jsonConductor = request.getParameter("jsonConductor");
        String jsonObject = swConductor.insertConductor(jsonConductor);
        if (jsonObject.length() > 0) {
            String arrayJSON = swConductor.listarConductores();
            if (arrayJSON.length() > 0) {
//                ConductoresIU conductoresIU = new ConductoresIU();
//                conductoresIU.setListaJSON(arrayJSON);
//                session.setAttribute("ConductoresIU", conductoresIU);
                response.sendRedirect("conductorControlador.jsp?opc=mostrar&accion=conductoresConfg");
            }
        } else {
            response.sendError(200, "Ha ocurrido un error al momento de guardar");
        }
    } else if (opc.equals("eliminarConductor")) {
        String cedula = request.getParameter("cedula");
        String respuesta = swConductor.eliminarConductor(cedula);
        if (respuesta.equals("200") || respuesta.equals("204") || respuesta.equals("202")) {
            String arrayJSON = swConductor.listarConductores();
            if (arrayJSON.length() > 0) {
//                ConductoresIU conductoresIU = new ConductoresIU();
//                conductoresIU.setListaJSON(arrayJSON);
//                session.setAttribute("ConductoresIU", conductoresIU);
                response.sendRedirect("conductorControlador.jsp?opc=mostrar&accion=conductoresConfg");
            }
        } else {
            response.sendError(200, "Ha ocurrido un error al momento de elimar");
        }
    } else if (opc.equals("modificarConductor")) {
        String cedula = (String) session.getAttribute("cedulaConductor");
        String jsonConductor = request.getParameter("jsonConductor");
        String jsonMod = swConductor.modificarConductor(jsonConductor, cedula);
        if (jsonMod.length() > 0) {
            String arrayJSON = swConductor.listarConductores();
            if (arrayJSON.length() > 0) {
//                ConductoresIU conductoresIU = new ConductoresIU();
//                conductoresIU.setListaJSON(arrayJSON);
//                session.setAttribute("ConductoresIU", conductoresIU);
                response.sendRedirect("conductorControlador.jsp?opc=mostrar&accion=conductoresConfg");
            }
        } else {
            response.sendError(200, "Ha ocurrido un error al momento de elimar");

        }
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