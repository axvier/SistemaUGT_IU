<%-- 
    Document   : vista
    Created on : 14/10/2018, 06:48:04 PM
    Author     : Xavy PC
--%>

<%@page import="utg.login.Login"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    Login login = (Login) session.getAttribute("login");
    if (login != null) {
        String accion = request.getParameter("accion");
        if(accion.equals("jsonVacio")){
            String datos = "{\"rows\":\"\"}";
            out.println(datos);
        }
    } else {
        response.sendError(501, this.getServletName() + "-> Error no se ha logueado en el sistema contacte con proveedor");
    }
%>
