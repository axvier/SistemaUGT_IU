<%-- 
    Document   : MenuControlador
    Created on : 8/10/2018, 11:59:16 AM
    Author     : Xavy PC
--%>

<%@page import="utg.login.Login"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Login login = (Login) session.getAttribute("login");
    if (login != null) {
        String opcion = request.getParameter("opcion");
        if(opcion.equals("ver")){
            String accion = request.getParameter("accion");
            response.sendRedirect("MenuVista.jsp?accion="+accion);
        }else if(opcion.equals("cambiarRol")){
            String rol = request.getParameter("rol");
            response.sendRedirect("MenuModel.jsp?opcion="+opcion+"&rol="+rol);
        }
    } else {
        response.sendError(501, this.getServletName() + "-> Error no se ha logueado en el sistema contacte con proveedor");
    }
%>
