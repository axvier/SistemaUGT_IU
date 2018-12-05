<%-- 
    Document   : RolesModelo
    Created on : 29/11/2018, 11:42:18 PM
    Author     : Xavy PC
--%>
<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="ugt.servicios.swRolesOpciones"%>
<%@page import="ugt.entidades.Tbopciones"%>
<%@page import="ugt.entidades.Tbrolesopciones"%>
<%@page import="ugt.entidades.Tbroles"%>
<%@page import="utg.roles.iu.RolesIU"%>
<%@page import="ugt.rolesopciones.IU.RolesOpcionesIU"%>
<%@page import="ugt.opciones.iu.OpcionesIU"%>
<%@page import="ugt.servicios.swOpcion"%>
<%@page import="ugt.servicios.swLogin"%>
<%@page import="ugt.tiposentidades.iu.TiposEntidadesIU"%>
<%@page import="ugt.servicios.swTipoEntidad"%>
<%@page import="ugt.servicios.swRol"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="utg.login.Login"%>
<%
    Login login = (Login) session.getAttribute("login");
    if (login != null) {
        String opc = request.getParameter("opc");
        Gson g = new Gson();
        if (opc.equals("jsonRoles")) {
            String arrayJSON = swRol.listarRoles();
            if (arrayJSON.length() > 2) {
                session.setAttribute("arrayJSON", arrayJSON);
                response.sendRedirect("RolesControlador.jsp?opc=mostrar&accion=" + opc);
            } else {
                response.sendRedirect("RolesControlador.jsp?opc=mostrar&accion=jsonVacio");
            }
        } else if (opc.equals("selectTipoEntidad")) {
            String arrayJSON = swTipoEntidad.listarTipoEntidad();
            if (arrayJSON.length() > 2) {
                TiposEntidadesIU tiposentidadesIU = new TiposEntidadesIU();
                tiposentidadesIU.setListaJSON(arrayJSON);
                session.setAttribute("tiposentidadesIU", tiposentidadesIU);
            }
            response.sendRedirect("RolesControlador.jsp?opc=mostrar&accion=" + opc);
        } else if (opc.equals("modalAddRol")) {
            String arrayJSON = swTipoEntidad.listarTipoEntidad();
            if (arrayJSON.length() > 2) {
                TiposEntidadesIU tiposentidadesIU = new TiposEntidadesIU();
                tiposentidadesIU.setListaJSON(arrayJSON);
                session.setAttribute("tiposentidadesIU", tiposentidadesIU);
            }
            response.sendRedirect("RolesControlador.jsp?opc=mostrar&accion=" + opc);
        } else if (opc.equals("GAddGRolOpcion")) {
//            String idRol = (String) session.getAttribute("idRol");
//            session.setAttribute("idRol", null);
            String arrayJSON = swRol.listarRoles();
            if (arrayJSON.length() > 2) {
                RolesIU rolesIU = new RolesIU();
                rolesIU.setListaJSON(arrayJSON);
                session.setAttribute("gRolesIU", rolesIU);
            }
            String objJSON = swOpcion.listarOpciones();
            if (arrayJSON.length() > 2) {
                OpcionesIU gOpcionesIU = new OpcionesIU();
                gOpcionesIU.setListaJSON(objJSON);
                session.setAttribute("gOpcionesIU", gOpcionesIU);
            }
            response.sendRedirect("RolesControlador.jsp?opc=mostrar&accion=" + opc);
        } else if (opc.equals("chksOpcionesRol")) {
            String idRol = (String) session.getAttribute("idRol");
            session.setAttribute("idRol", null);
            String arrayJSON = swLogin.opcionesRol(idRol);
            if (arrayJSON.length() > 2) {
                OpcionesIU opcionesRol = new OpcionesIU();
                opcionesRol.setListaJSON(arrayJSON);
                session.setAttribute("gopcionesRol", opcionesRol);
            }
            String objJSON = swOpcion.listarOpciones();
            if (arrayJSON.length() > 2) {
                OpcionesIU gOpcionesIU = new OpcionesIU();
                gOpcionesIU.setListaJSON(objJSON);
                session.setAttribute("gOpcionesIU", gOpcionesIU);
            }
            response.sendRedirect("RolesControlador.jsp?opc=mostrar&accion=" + opc);
        } else if (opc.equals("saveRol")) {
            String jsonRol = (String) session.getAttribute("jsonRol");
            session.setAttribute("jsonRol", null);
            String jsonObject = swRol.insertRol(jsonRol);
            if (jsonObject.length() > 2) {
                session.setAttribute("statusGuardar", "Rol guardado correctamente");
                session.setAttribute("statusCodigo", "OK");
            } else {
                session.setAttribute("statusGuardar", "ERROR NO SE HA PODIDO GUARDAR El ROL!-> Contacte con el proveedor");
                session.setAttribute("statusCodigo", "KO");
            }
            response.sendRedirect("RolesControlador.jsp?opc=mostrar&accion=guardarStatus");
        } else if (opc.equals("modificarRol")) {
            String idrol = (String) session.getAttribute("idrol");
            String jsonRol = (String) session.getAttribute("jsonRol");
            session.setAttribute("idrol", null);
            session.setAttribute("jsonRol", null);
            String jsonMod = swRol.modificarRol(idrol, jsonRol);
            if (jsonMod.length() > 2) {
                session.setAttribute("statusMod", "Se ha actualizado los datos");
                session.setAttribute("statusCodigo", "OK");
            } else {
                session.setAttribute("statusMod", "Error al intentar acuatlizar los datos - contacte con el proveedor");
                session.setAttribute("statusCodigo", "KO");
            }
            response.sendRedirect("RolesControlador.jsp?opc=mostrar&accion=modificarStatus");
        } else if (opc.equals("eliminarRol")) {
            String idrol = (String) session.getAttribute("idrol");
            session.setAttribute("idrol", null);
            String objJSON = swRol.eliminaRol(idrol);
            String result = "";
            if (objJSON.equals("200") || objJSON.equals("204") || objJSON.equals("202")) {
                result += " Se ha eliminado correctamente ";
                session.setAttribute("statusCodigo", "OK");
                //verificar si en el test de errores es necesario de crear un servicio web para cerrar todas las asignaciones en la base d datos
            } else {
                result += " No se ha podido eliminar al usuario ";
                session.setAttribute("statusCodigo", "KO");
            }
            session.setAttribute("statusDelete", result);
            response.sendRedirect("RolesControlador.jsp?opc=mostrar&accion=eliminarStatus");
        } else if (opc.equals("saveRolOpciones")) {
            String jsonRol = (String) session.getAttribute("jsonRol");
            String jsonOpciones = (String) session.getAttribute("jsonOpciones");
            session.setAttribute("jsonRol", null);
            session.setAttribute("jsonOpciones", null);
            Tbroles rol = g.fromJson(jsonRol, Tbroles.class);
            OpcionesIU opciones = g.fromJson(jsonOpciones, OpcionesIU.class);
            String result = "";
            String auxJSON = swRolesOpciones.eliminarOpcionesIDRol(rol.getIdrol().toString());
            if (auxJSON.equals("OK")) {
                for (Tbopciones search : opciones.getLista()) {
                    Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd'T'HH:mm:ss-05:00").create();
                    Tbrolesopciones insert = new Tbrolesopciones();
                    insert.setId(0);
                    insert.setIdopcion(search);
                    insert.setIdrol(rol);
                    String auxMOD = swRolesOpciones.insertRolOpcion(gson.toJson(insert));
                    if (auxMOD.length() > 2) {
                        result += "rol " + insert.getIdopcion().getDescripcion() + " con su información anexado";
                        session.setAttribute("statusCodigo", "OK");
                    } else {
                        result += "rol " + insert.getIdopcion().getDescripcion() + " no se ha podido anexar";
                        session.setAttribute("statusCodigo", "KO");
                    }
                }
            } else {
                result += "No se ha podido Eliminar-Actualizar las opciones con rol";
                session.setAttribute("statusCodigo", "KO");
            }
            session.setAttribute("statusDelete", result);
            response.sendRedirect("RolesControlador.jsp?opc=mostrar&accion=eliminarStatus");
        }
    } else {
        response.sendError(501, this.getServletName() + "-> Error no se ha logueado en el sistema contacte con proveedor");
    }

%>