<%@page import="utg.login.Login"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Login login = (Login) session.getAttribute("login");
    if (login != null) {
        String accion = request.getParameter("accion");
        Gson G = new Gson();
        if (accion.equals("vehiculosConfg")) { // cargar los vehiculos para datos de configuracion
            String json = (String) session.getAttribute("jsonArray");
            session.setAttribute("arrayJSON", null);
            out.print(json);
        } else if (accion.equals("respuesta")) {
            String respuesta = (String) session.getAttribute("respuesta");
            String result = "{"
                    + "\"respuesta\":\"" + respuesta + "\""
                    + "}";
            response.setContentType("text/plain");
            response.getWriter().write(result);
        }
    } else {
        response.sendError(501, this.getServletName() + "-> Error no se ha logueado en el sistema contacte con proveedor");
    }

%>