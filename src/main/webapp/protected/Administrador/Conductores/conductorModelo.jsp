<%@page import="utg.login.Login"%>
<%@page import="ugt.licencias.IU.LicenciasIU"%>
<%@page import="ugt.conductores.iu.ConductorIU"%>
<%@page import="org.json.JSONObject"%>
<%@page import="ugt.servicios.swLicencia"%>
<%@page import="ugt.servicios.swConductor"%>
<%@page import="com.google.gson.Gson"%>
<%
    Login login = (Login) session.getAttribute("login");
    if (login != null) {
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
            JSONObject jsonOb = new JSONObject(jsonConductor);
            String cedula = jsonOb.getString("cedula");
            String existe = swConductor.conductorID(cedula);
            if (existe.length() <= 2) {
                String jsonObject = swConductor.insertConductor(jsonConductor);
                if (jsonObject.length() > 2) {
                    String arrayJSON = swLicencia.insertLicencia(jsonLicencia);
                    if (arrayJSON.length() > 2) {
                        session.setAttribute("statusGuardar", "Se ha guardado Correctamente");
                        session.setAttribute("statusCodigo", "OK");
                    } else {
                        session.setAttribute("statusGuardar", "ERROR NO SE HA PODIDO GUARDAR LA LICENCIA!-> Contacte con el proveedor");
                        session.setAttribute("statusCodigo", "KO");
                    }
                } else {
                    session.setAttribute("statusGuardar", "ERROR NO SE HA PODIDO GUARDAR AL CONDUCTOR!-> Contacte con el proveedor");
                    session.setAttribute("statusCodigo", "KO");
                }
            } else {
                session.setAttribute("statusGuardar", "Ya existe un conductor con esa cédula");
                session.setAttribute("statusCodigo", "KO");
            }
            response.sendRedirect("conductorControlador.jsp?opc=mostrar&accion=guardarStatus");
        } else if (opc.equals("eliminarConductor")) {
            String cedula = request.getParameter("cedula");
            String json = (String) session.getAttribute("json");
            ConductorIU conductr = g.fromJson(json, ConductorIU.class);
            conductr.setEstado("Bloqueado");
            session.setAttribute("json", null);
            String arrayJSON = swConductor.bloquearConductor(g.toJson(conductr), cedula);
            if (arrayJSON.length() > 2) {
                session.setAttribute("statusEliminar", "OK");
            } else {
                session.setAttribute("statusEliminar", "KO");
            }
            response.sendRedirect("conductorControlador.jsp?opc=mostrar&accion=eliminarStatus");
        } else if (opc.equals("modificarConductor")) {
            String cedula = (String) session.getAttribute("cedulaConductor");
            session.setAttribute("cedulaConductor", null);
            String jsonConductor = (String) session.getAttribute("jsonConductor");
            session.setAttribute("jsonConductor", null);
            String jsonMod = swConductor.modificarConductor(jsonConductor, cedula);
            if (jsonMod.length() > 2) {
                session.setAttribute("statusMod", "OK");
            } else {
                session.setAttribute("statusMod", "KO");
            }
            response.sendRedirect("conductorControlador.jsp?opc=mostrar&accion=modificarStatus");
        } else if (opc.equals("jsonConductores")) {
            String jsonMod = swConductor.listarConductoresXEstado("Disponible");
            if (jsonMod.length() > 2) {
                session.setAttribute("jsonArray", jsonMod);
                response.sendRedirect("conductorControlador.jsp?opc=mostrar&accion=jsonConductores");
            } else {
                response.sendRedirect("../../vista.jsp?accion=jsonVacio");

            }
        } else if (opc.equals("jsonConducBloc")) {
            String jsonMod = swConductor.listarConductoresBloqueados();
            if (jsonMod.length() > 2) {
                session.setAttribute("jsonArray", jsonMod);
                response.sendRedirect("conductorControlador.jsp?opc=mostrar&accion=jsonConductores");
            } else {
                response.sendRedirect("../../vista.jsp?accion=jsonVacio");

            }
        } else if (opc.equals("jsonConducOcup")) {
            String jsonMod = swConductor.listarConductoresXEstado("Ocupado");
            if (jsonMod.length() > 2) {
                session.setAttribute("jsonArray", jsonMod);
                response.sendRedirect("conductorControlador.jsp?opc=mostrar&accion=jsonConductores");
            } else {
                response.sendRedirect("../../vista.jsp?accion=jsonVacio");
            }
        } else if (opc.equals("consLicencia")) {
            String licenciaCed = (String) session.getAttribute("licenciaCed");
            session.setAttribute("licenciaCed", null);
            String jsonArray = swLicencia.licenciaID(licenciaCed);
            if (jsonArray.length() > 2) {
                session.setAttribute("jsonArray", jsonArray);
                response.sendRedirect("conductorControlador.jsp?opc=mostrar&accion=jsonConductores");
            } else {
                response.sendRedirect("conductorControlador.jsp?opc=mostrar&accion=jsonVacio");
            }
        } else if (opc.equals("modificarLicencia")) {
            String idlicencia = (String) session.getAttribute("idlicencia");
            session.setAttribute("idlicencia", null);
            String jsonLicencia = (String) session.getAttribute("jsonLicencia");
            session.setAttribute("jsonLicencia", null);
            String jsonMod = swLicencia.modificarLicencia(jsonLicencia, idlicencia);
            if (jsonMod.length() > 2) {
                session.setAttribute("statusMod", "OK");
            } else {
                session.setAttribute("statusMod", "KO");
            }
            response.sendRedirect("conductorControlador.jsp?opc=mostrar&accion=modificarStatus");
        }
    } else {
        response.sendError(501, this.getServletName() + "-> Error no se ha logueado en el sistema contacte con proveedor");
    }

%>