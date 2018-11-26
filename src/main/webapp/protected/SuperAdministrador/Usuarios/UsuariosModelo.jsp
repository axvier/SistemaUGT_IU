<%-- 
    Document   : UsuariosModelo
    Created on : 25/11/2018, 08:27:18 PM
    Author     : Xavy PC
--%>
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
        } else if (opc.equals("eliminarUsuario")) {
            String cedulaUG = request.getParameter("cedulaUG");
            String jsonUser = (String) session.getAttribute("jsonUser");
            session.setAttribute("cedulaUG", null);
            session.setAttribute("jsonUser", null);
            Tbusuarios usuario = g.fromJson(jsonUser, Tbusuarios.class);
            usuario.setEstado("Bloqueado");
            session.setAttribute("json", null);
            String objJSON = swUsuario.modificarUsuario(cedulaUG, g.toJson(usuario));
            String result = "";
            if (objJSON.length() > 2) {
                result += " Se ha bloqueado correctamente ";
                session.setAttribute("statusCodigo", "OK");
                String arrayJSON = swLogin.loginUser(usuario.getCedula());
                if (arrayJSON.length() > 2) {
                    UsuariosEntidadesIU usuarioentidadesIU = new UsuariosEntidadesIU();
                    usuarioentidadesIU.setListaJSON(arrayJSON);
                    for(Tbusuariosentidad userentidad : usuarioentidadesIU.getLista()){
//                        String res =
                    }
                } else {
                    result += " pero no tiene ningun rol en el sistema";
                    session.setAttribute("statusCodigo", "KO");
                }
            } else {
                result += " No se ha podido bloquear al usuario ";
                session.setAttribute("statusCodigo", "KO");
            }
            response.sendRedirect("conductorControlador.jsp?opc=mostrar&accion=eliminarStatus");
        }
    } else {
        response.sendError(501, this.getServletName() + "-> Error no se ha logueado en el sistema contacte con proveedor");
    }

%>