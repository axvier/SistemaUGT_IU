<%-- 
    Document   : UsuariosModelo
    Created on : 25/11/2018, 08:27:18 PM
    Author     : Xavy PC
--%>
<%@page import="ugt.cargos.iu.CargosIU"%>
<%@page import="ugt.servicios.swCargo"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="ugt.servicios.swRol"%>
<%@page import="utg.roles.iu.RolesIU"%>
<%@page import="ugt.entidades.iu.EntidadesIU"%>
<%@page import="ugt.servicios.swEntidad"%>
<%@page import="ugt.servicios.swUsuarioEntidad"%>
<%@page import="ugt.entidades.Tbusuariosentidad"%>
<%@page import="ugt.usuariosentidades.iu.UsuariosEntidadesIU"%>
<%@page import="ugt.servicios.swLogin"%>
<%@page import="ugt.entidades.Tbusuarios"%>
<%@page import="org.json.JSONObject"%>
<%@page import="ugt.servicios.swUsuario"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="utg.login.Login"%>
<%
    Login login = (Login) session.getAttribute("login");
    if (login != null) {
        String opc = request.getParameter("opc");
        Gson g = new Gson();
        if (opc.equals("jsonUsuarios")) {
            String arrayJSON = swUsuario.listarUsuarios();
            if (arrayJSON.length() > 2) {
                session.setAttribute("arrayJSON", arrayJSON);
                response.sendRedirect("UsuariosControlador.jsp?opc=mostrar&accion=" + opc);
            } else {
                response.sendRedirect("UsuariosControlador.jsp?opc=mostrar&accion=jsonVacio");
            }
        } else if (opc.equals("saveUser")) {
            String jsonUser = (String) session.getAttribute("jsonUser");
            session.setAttribute("jsonUser", null);
            JSONObject jsonOb = new JSONObject(jsonUser);
            String cedula = jsonOb.getString("cedula");
            String existe = swUsuario.listarUsuarioID(cedula);
            if (existe.length() <= 2) {
                String jsonObject = swUsuario.insertUsuario(jsonUser);
                if (jsonObject.length() > 2) {
                    session.setAttribute("statusGuardar", "Usuario guardado correctamente");
                    session.setAttribute("statusCodigo", "OK");
                } else {
                    session.setAttribute("statusGuardar", "ERROR NO SE HA PODIDO GUARDAR El USUARIO!-> Contacte con el proveedor");
                    session.setAttribute("statusCodigo", "KO");
                }
            } else {
                session.setAttribute("statusGuardar", "Ya existe un usuario con esa cédula");
                session.setAttribute("statusCodigo", "KO");
            }
            response.sendRedirect("UsuariosControlador.jsp?opc=mostrar&accion=guardarStatus");
        } else if (opc.equals("modificarUser")) {
            String cedulaUG = (String) session.getAttribute("cedulaUG");
            String jsonUser = (String) session.getAttribute("jsonUser");
            session.setAttribute("cedulaUG", null);
            session.setAttribute("jsonUser", null);
            String jsonMod = swUsuario.modificarUsuario(cedulaUG, jsonUser);
            if (jsonMod.length() > 2) {
                session.setAttribute("statusMod", "Se ha actualizado los datos");
                session.setAttribute("statusCodigo", "OK");
            } else {
                session.setAttribute("statusMod", "Error al intentar acuatlizar los datos - contacte con el proveedor");
                session.setAttribute("statusCodigo", "KO");
            }
            response.sendRedirect("UsuariosControlador.jsp?opc=mostrar&accion=modificarStatus");
        } else if (opc.equals("eliminarUser")) {
            String cedulaUG = (String) session.getAttribute("cedulaUG");
            session.setAttribute("cedulaUG", null);
            String objJSON = swUsuario.eliminarUsuario(cedulaUG);
            String result = "";
            if (objJSON.equals("200") || objJSON.equals("204") || objJSON.equals("202")) {
                result += " Se ha eliminado correctamente ";
                session.setAttribute("statusCodigo", "OK");
                String arrayJSON = swUsuarioEntidad.terminarUsuarioEntidadCedula(cedulaUG); // servicipo para cerrar todas las asginaciones de fechas en usuario entidad
                if (arrayJSON.length() > 2) {
                    result += " junto con los roles asignados en el sistema";
                    session.setAttribute("statusCodigo", "OK");
                } else {
                    result += " pero no se ha actualizado ningun rol en el sistema";
                    session.setAttribute("statusCodigo", "KO");
                }
            } else {
                result += " No se ha podido eliminar al usuario ";
                session.setAttribute("statusCodigo", "KO");
            }
            session.setAttribute("statusDelete", result);
            response.sendRedirect("UsuariosControlador.jsp?opc=mostrar&accion=eliminarStatus");
        } else if (opc.equals("modalAddGEntidadRol")) {
            String arrayEntidades = swEntidad.listarEntidades();
            if (arrayEntidades.length() > 2) {
                EntidadesIU entidadesIU = new EntidadesIU();
                entidadesIU.setListaJSON(arrayEntidades);
                session.setAttribute("entidadesIU", entidadesIU);
            }
            String arrayRoles = swRol.listarRoles();
            if (arrayRoles.length() > 2) {
                RolesIU rolesIU = new RolesIU();
                rolesIU.setListaJSON(arrayRoles);
                session.setAttribute("rolesIU", rolesIU);
            }
            String arrayCargos = swCargo.listarCargos();
            if(arrayCargos.length()>2){
                CargosIU cargos = new CargosIU();
                cargos.setListaJSON(arrayCargos);
                session.setAttribute("cargosIU", cargos);
            }
            response.sendRedirect("UsuariosControlador.jsp?opc=mostrar&accion=" + opc);
        } else if (opc.equals("divModalVerEntidadRol")) {
            String cedulaUG = (String) session.getAttribute("cedulaUG");
            session.setAttribute("cedulaUG", null);
            String arrayJSON = swUsuarioEntidad.totalUsuarioEntidadCedula(cedulaUG);
            if (arrayJSON.length() > 2) {
                UsuariosEntidadesIU userentityrol = new UsuariosEntidadesIU();
                userentityrol.setListaJSON(arrayJSON);
                session.setAttribute("userentityrol", userentityrol);
            }
            response.sendRedirect("UsuariosControlador.jsp?opc=mostrar&accion=" + opc);
        } else if (opc.equals("saveUsuarioEntidad")) {
            String jsonUsuarioEntidad = (String) session.getAttribute("jsonUsuarioEntidad");
            session.setAttribute("jsonUsuarioEntidad", null);
            Tbusuariosentidad aux = g.fromJson(jsonUsuarioEntidad, Tbusuariosentidad.class);
            String idCompuesto = "id;cedulau=" + aux.getTbusuariosentidadPK().getCedulau() + ";identidad=" + aux.getTbusuariosentidadPK().getIdentidad() + ";idrol=" + aux.getTbusuariosentidadPK().getIdrol();
            String existe = swUsuarioEntidad.listarUsuarioEntidadID(idCompuesto);
            if (existe.length() <= 2) {
                String jsonObject = swUsuarioEntidad.insertUsuarioEntidad(jsonUsuarioEntidad);
                if (jsonObject.length() > 2) {
                    session.setAttribute("statusGuardar", "Entidad y rol asignados correctamente");
                    session.setAttribute("statusCodigo", "OK");
                } else {
                    session.setAttribute("statusGuardar", "ERROR NO SE HA PODIDO Asignar!-> Contacte con el proveedor");
                    session.setAttribute("statusCodigo", "KO");
                }
            } else {
                session.setAttribute("statusGuardar", "El usuario ya esta asignado a " + aux.getTbentidad().getCodigoentidad() + " con el rol " + aux.getTbroles().getDescripcion());
                session.setAttribute("statusCodigo", "KO");
            }
            response.sendRedirect("UsuariosControlador.jsp?opc=mostrar&accion=guardarStatus");
        } else if (opc.equals("elimUsuarioEntidad")) {
            String jsonUsuarioEntidad = (String) session.getAttribute("jsonUsuarioEntidad");
            session.setAttribute("jsonUsuarioEntidad", null);
            Tbusuariosentidad aux = g.fromJson(jsonUsuarioEntidad, Tbusuariosentidad.class);
            String idCompuesto = "id;cedulau=" + aux.getTbusuariosentidadPK().getCedulau() + ";identidad=" + aux.getTbusuariosentidadPK().getIdentidad() + ";idrol=" + aux.getTbusuariosentidadPK().getIdrol();
            String objJSON = swUsuarioEntidad.eliminarUsuarioEntidad(idCompuesto);
            String result = "";
            if (objJSON.equals("200") || objJSON.equals("204") || objJSON.equals("202")) {
                result += " Se ha eliminado correctamente ";
                session.setAttribute("statusCodigo", "OK");
            } else {
                result += " No se ha podido eliminar al usuario ";
                session.setAttribute("statusCodigo", "KO");
            }
            session.setAttribute("statusDelete", result);
            response.sendRedirect("UsuariosControlador.jsp?opc=mostrar&accion=eliminarStatus");
        } else if (opc.equals("modUsuarioEntidad")) {
            Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd'T'HH:mm:ss-05:00").create();
            String jsonUsuarioEntidad = (String) session.getAttribute("jsonUsuarioEntidad");
            session.setAttribute("jsonUsuarioEntidad", null);
            Tbusuariosentidad aux = g.fromJson(jsonUsuarioEntidad, Tbusuariosentidad.class);
            String idCompuesto = "id;cedulau=" + aux.getTbusuariosentidadPK().getCedulau() + ";identidad=" + aux.getTbusuariosentidadPK().getIdentidad() + ";idrol=" + aux.getTbusuariosentidadPK().getIdrol();
            Calendar today = Calendar.getInstance();
            SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd'T'00:00:00-05:00");
            Date date = sf.parse(sf.format(today.getTime()));
            aux.setFechafin(date);
            String jsonone = gson.toJson(aux);
            String objJSON = swUsuarioEntidad.modificarUsuarioEntidad(idCompuesto,jsonone);
            String result = "";
            if (objJSON.length() > 2) {
                result = " Se ha finalizado correctamente la relación ";
                session.setAttribute("statusCodigo", "OK");
            } else {
                result = " No se ha podido finalizar la relación ";
                session.setAttribute("statusCodigo", "KO");
            }
            session.setAttribute("statusMod", result);
            response.sendRedirect("UsuariosControlador.jsp?opc=mostrar&accion=modificarStatus");
        }
    } else {
        response.sendError(501, this.getServletName() + "-> Error no se ha logueado en el sistema contacte con proveedor");
    }

%>