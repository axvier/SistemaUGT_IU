<%@page import="ugt.vehiculos.iu.VehiculosIU"%>
<%@page import="ugt.servicios.swVehiculo"%>
<%@page import="utg.login.Login"%>
<%@page import="com.google.gson.Gson"%>
<%
    Login login = (Login) session.getAttribute("login");
    if (login != null) {
        String opc = request.getParameter("opc");
        Gson g = new Gson();
        if (opc.equals("jsonVehiculos")) { //cargar los vehiculos
            String arrayJSON = swVehiculo.listarVehiculos();
            if (arrayJSON.length() > 2) {
                session.setAttribute("arrayJSON", arrayJSON);
                response.sendRedirect("vehiculoControlador.jsp?opc=mostrar&accion="+opc);
            }
        }else if (opc.equals("eliminarVehiculo")) {
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
    } else {
        response.sendError(501, this.getServletName() + "-> Error no se ha logueado en el sistema contacte con proveedor");
    }
%>
