<%@page import="ugt.vehiculosconductores.iu.VehiculosConductoresIU"%>
<%@page import="ugt.servicios.swVehiculoConductor"%>
<%@page import="ugt.entidades.Tbvehiculos"%>
<%@page import="ugt.entidades.Tbgrupovehiculos"%>
<%@page import="ugt.gruposvehiculos.iu.GruposVehiculosIU"%>
<%@page import="ugt.vehiculos.iu.VehiculoIU"%>
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
            String arrayJSON = swVehiculo.listarVehiculosXEstado("Disponible");
            if (arrayJSON.length() > 2) {
                session.setAttribute("arrayJSON", arrayJSON);
                response.sendRedirect("vehiculoControlador.jsp?opc=mostrar&accion=" + opc);
            } else {
                response.sendRedirect("../../vista.jsp?accion=jsonVacio");

            }
        } else if (opc.equals("jsonVehiculosOcup")) {
            String arrayJSON = swVehiculo.listarVehiculosXEstado("Ocupado");
            if (arrayJSON.length() > 2) {
                session.setAttribute("arrayJSON", arrayJSON);
                response.sendRedirect("vehiculoControlador.jsp?opc=mostrar&accion=jsonVehiculos");
            } else {
                response.sendRedirect("../../vista.jsp?accion=jsonVacio");

            }
        } else if (opc.equals("jsonVehiculosUnlock")) {
            String arrayJSON = swVehiculo.listarVehiculosXEstado("Rematado");
            if (arrayJSON.length() > 2) {
                session.setAttribute("arrayJSON", arrayJSON);
                response.sendRedirect("vehiculoControlador.jsp?opc=mostrar&accion=jsonVehiculos");
            } else {
                response.sendRedirect("../../vista.jsp?accion=jsonVacio");

            }
        } else if (opc.equals("saveVehiculo")) {
            String jsonVehiculo = (String) session.getAttribute("jsonVehiculo");
            String placa = (String) session.getAttribute("placa");
            session.setAttribute("jsonVehiculo", null);
            session.setAttribute("placa", null);
            String existe = swVehiculo.listarVehiculoID(placa);
            if (existe.length() <= 2) {
                String arrayJSON = swVehiculo.insertVehiculo(jsonVehiculo);
                if (arrayJSON.length() > 2) {
                    session.setAttribute("statusGuardar", "Se ha guardado Correctamente");
                    session.setAttribute("statusCodigo", "OK");
                } else {
                    session.setAttribute("statusGuardar", "ERROR NO SE HA PODIDO GUARDAR El Vehiculo!-> Contacte con el proveedor");
                    session.setAttribute("statusCodigo", "KO");
                }
            } else {
                session.setAttribute("statusGuardar", "Ya existe un vehiculo con esa c�dula");
                session.setAttribute("statusCodigo", "KO");
            }
            response.sendRedirect("vehiculoControlador.jsp?opc=mostrar&accion=guardarStatus");
        } else if (opc.equals("eliminarVehiculo")) {
            String placa = (String) session.getAttribute("placa");
            String json = (String) session.getAttribute("json");
            String nombreGrupo = (String) session.getAttribute("nombreGrupo");
            session.setAttribute("json", null);
            session.setAttribute("placa", null);
            session.setAttribute("nombreGrupo", nombreGrupo);
            String listaGrupo = swVehiculo.listarGrupoVehiculo();
            if (listaGrupo.length() > 2) {
                GruposVehiculosIU grupoVehiculosIU = new GruposVehiculosIU();
                grupoVehiculosIU.setListaJSON(listaGrupo);
                Tbgrupovehiculos search = new Tbgrupovehiculos();
                for (Tbgrupovehiculos grupo : grupoVehiculosIU.getLista()) {
                    if (grupo.getNombre().equals(nombreGrupo)) {
                        search = grupo;
                        break;
                    }
                }
                VehiculoIU vehiculo = g.fromJson(json, VehiculoIU.class);
                vehiculo.setEstado("Rematado");
                vehiculo.setIdgrupo(search);
                String arrayJSON = swVehiculo.bloquearVehiculo(g.toJson(vehiculo), placa);
                if (arrayJSON.length() > 2) {
                    session.setAttribute("statusEliminar", "OK");
                } else {
                    session.setAttribute("statusEliminar", "KO");
                }
            } else {
                session.setAttribute("statusEliminar", "KO");
            }
            response.sendRedirect("vehiculoControlador.jsp?opc=mostrar&accion=eliminarStatus");
        } else if (opc.equals("modificarVehiculo")) {
            String placa = (String) session.getAttribute("placa");
            String jsonVehiculo = (String) session.getAttribute("jsonVehiculo");
            String idgrupo = (String) session.getAttribute("idgrupo");
            session.setAttribute("placa", null);
            session.setAttribute("jsonVehiculo", null);
            session.setAttribute("idgrupo", null);
            String listaGrupo = swVehiculo.listarGrupoVehiculoID(idgrupo);
            if (listaGrupo.length() > 2) {
                Tbgrupovehiculos grupo = g.fromJson(listaGrupo, Tbgrupovehiculos.class);
                Tbvehiculos vehiculo = g.fromJson(jsonVehiculo, Tbvehiculos.class);
                vehiculo.setIdgrupo(grupo);
                String jsonMod = swVehiculo.modificarVehiculo(placa,g.toJson(vehiculo));
                if (jsonMod.length() > 2) {
                    session.setAttribute("statusMod", "OK");
                } else {
                    session.setAttribute("statusMod", "KO");
                }
            } else {
                session.setAttribute("statusEliminar", "KO");
            }
            response.sendRedirect("vehiculoControlador.jsp?opc=mostrar&accion=modificarStatus");
        } else if (opc.equals("tableVehiculos")) {
            String arrayJSON = swVehiculo.listarGrupoVehiculo();
            if (arrayJSON.length() > 2) {
                GruposVehiculosIU grupoVehiculosIU = new GruposVehiculosIU();
                grupoVehiculosIU.setListaJSON(arrayJSON);
                session.setAttribute("grupoVehiculosIU", grupoVehiculosIU);
                response.sendRedirect("vehiculoControlador.jsp?opc=mostrar&accion=" + opc);
            }
        } else if (opc.equals("contentModalVerCond")) {
            String placa = (String) session.getAttribute("placa");
            String arrayJSON = swVehiculoConductor.listarVehiculoConductorPlaca(placa);
            if (arrayJSON.length() > 2) {
                VehiculosConductoresIU vehiculosConductoresIU = new VehiculosConductoresIU();
                vehiculosConductoresIU.setListaJSON(arrayJSON);
                session.setAttribute("vehiculosConductoresIU", vehiculosConductoresIU);
            }
            response.sendRedirect("vehiculoControlador.jsp?opc=mostrar&accion=contentModalVerCond");
        }
    } else {
        response.sendError(501, this.getServletName() + "-> Error no se ha logueado en el sistema contacte con proveedor");
    }
%>
