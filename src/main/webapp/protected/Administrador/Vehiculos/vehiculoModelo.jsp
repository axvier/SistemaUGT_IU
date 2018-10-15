<%@page import="sistema.ugt.vehiculos.iu.VehiculosIU"%>
<%@page import="sistema.ugt.servicios.swVehiculo"%>
<%@page import="com.google.gson.Gson"%>
<%
    String opc = request.getParameter("opc");
    //SistemaSW_Service port = new SistemaSW_Service();
    //SistemaSW servicios = port.getSistemaSWPort();
    Gson g = new Gson();

    if (opc.equals("vehiculosConfg")) { //cargar los vehiculos
        //String jsonSolicitud = servicios.vehiculosCargar();
        //VehiculosIU vehiculosIU = g.fromJson(jsonSolicitud, VehiculosIU.class);
        String arrayJSON = swVehiculo.listarVehiculos();
        if (arrayJSON.length() > 0) {
            //String jsonVehiculos = g.toJson(arrayJSON);
            VehiculosIU vehiculosIU = new VehiculosIU();
            vehiculosIU.setListaJson(arrayJSON);
            session.setAttribute("VehiculosIU", vehiculosIU);
            response.sendRedirect("vehiculoControlador.jsp?opc=mostrar&accion=vehiculosConfg");
        }
    } /*else if (opc.equals("saveVehiculo")) {
        String jsonVehiculo = request.getParameter("jsonVehiculo");
        String jsonSolicitud = servicios.vehiculosGuardar(jsonVehiculo);
        VehiculosIU vehiculosIU = g.fromJson(jsonSolicitud, VehiculosIU.class);
        session.setAttribute("VehiculosIU", vehiculosIU);
        response.sendRedirect("vehiculoControlador.jsp?opc=mostrar&accion=vehiculosConfg");
    }*/ else if (opc.equals("eliminarVehiculo")) {
        String placa = request.getParameter("placa");
        String jsonVehiculo = request.getParameter("jsonVehiculo");
        swVehiculo.eliminarVehiculo(placa, jsonVehiculo);
        String arrayJSON = swVehiculo.listarVehiculos();
        if (arrayJSON.length() > 0) {
            VehiculosIU vehiculosIU = new VehiculosIU();
            vehiculosIU.setListaJson(arrayJSON);
            session.setAttribute("VehiculosIU", vehiculosIU);
            response.sendRedirect("vehiculoControlador.jsp?opc=mostrar&accion=vehiculosConfg");
        }
    } else if (opc.equals("saveVehiculo")) {
        String jsonVehiculo = request.getParameter("jsonVehiculo");
        //swVehiculo.modificarVehiculo(jsonVehiculo);
        String arrayJSON = swVehiculo.listarVehiculos();
        if (arrayJSON.length() > 0) {
            VehiculosIU vehiculosIU = new VehiculosIU();
            vehiculosIU.setListaJson(arrayJSON);
            session.setAttribute("VehiculosIU", vehiculosIU);
            response.sendRedirect("vehiculoControlador.jsp?opc=mostrar&accion=vehiculosConfg");
        }

    } else if (opc.equals("modificarVehiculo")) {
        String placa = request.getParameter("placa");
        String jsonVehiculo = request.getParameter("jsonVehiculo");
        swVehiculo.modificarVehiculo(placa, jsonVehiculo);
        String arrayJSON = swVehiculo.listarVehiculos();
        if (arrayJSON.length() > 0) {
            VehiculosIU vehiculosIU = new VehiculosIU();
            vehiculosIU.setListaJson(arrayJSON);
            session.setAttribute("VehiculosIU", vehiculosIU);
            response.sendRedirect("vehiculoControlador.jsp?opc=mostrar&accion=vehiculosConfg");
        }
    }
        //String jsonSolicitud = servicios.vehiculoEliminar(placa);
        //VehiculosIU vehiculosIU = g.fromJson(jsonSolicitud, VehiculosIU.class);
        //session.setAttribute("VehiculosIU", vehiculosIU);
        //response.sendRedirect("vehiculoControlador.jsp?opc=mostrar&accion=vehiculosConfg");

%>
