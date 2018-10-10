<%-- 
    Document   : MenuModelo
    Created on : 8/10/2018, 12:02:43 PM
    Author     : Xavy PC
--%>

<%@page import="ugt.opciones.iu.OpcionesIU"%>
<%@page import="servicios.swLogin"%>
<%@page import="ugt.entidades.Tbusuariosentidad"%>
<%@page import="utg.login.Login"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Login login = (Login) session.getAttribute("login");
    if (login != null) {
        String opcion = request.getParameter("opcion");
        if (opcion.equals("cambiarRol")) {
            String rol = request.getParameter("rol");
            Tbusuariosentidad search = login.getRolesEntity().stream().filter(userentiy -> userentiy.getTbroles().getCharrol().equals(rol)).findAny().orElse(null);
            if (search != null) {
                login.setRolActivo(search.getTbroles());
                String jsonArrayOpc = swLogin.opcionesRol(login.getRolActivo().getIdrol().toString());
                OpcionesIU opciones = new OpcionesIU();
                opciones.setListaJSON(jsonArrayOpc);
                session.setAttribute("opcionesIU", opciones);
                session.setAttribute("login", login);
                response.sendRedirect("MenuControlador.jsp?opcion=ver&accion=imprimirMenu");
            }
        } else if (opcion.equals("")) {

        }
    } else {
        response.sendError(501, this.getServletName() + "-> Error no se ha logueado en el sistema contacte con proveedor");
    }
%>
