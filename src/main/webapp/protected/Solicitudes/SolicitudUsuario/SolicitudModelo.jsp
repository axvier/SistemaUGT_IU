<%-- 
    Document   : SolicitudModelo
    Created on : 8/12/2018, 01:31:07 PM
    Author     : Xavy PC
--%>
<%@page import="com.google.gson.Gson"%>
<%@page import="utg.login.Login"%>
<%
    Login login = (Login) session.getAttribute("login");
    if (login != null) {
        String opc = request.getParameter("opc");
        Gson g = new Gson();
        if (opc.equals("nuevaSolicitudU")) {
            
        } else if (opc.equals("selectTipoEntidad")) {
     
        } 
    } else {
        response.sendError(501, this.getServletName() + "-> Error no se ha logueado en el sistema contacte con proveedor");
    }
%>