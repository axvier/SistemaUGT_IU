<%-- 
    Document   : SolicitudControlador
    Created on : 8/12/2018, 01:31:43 PM
    Author     : Xavy PC
--%>
<%@page import="utg.login.Login"%>
<%
    Login login = (Login) session.getAttribute("login");
    if (login != null) {
        String opc = request.getParameter("opc");
        if (opc != null) {
            if (opc.equals("mostrar")) {
                String accion = request.getParameter("accion");
                response.sendRedirect("SolicitudVista.jsp?accion=" + accion);
            } else if (opc.equals("jsonUsuarios")) {
                response.sendRedirect("SolicitudModelo.jsp?opc=" + opc);
            }
        }
    } else {
        response.sendError(501, this.getServletName() + "-> Error no se ha logueado en el sistema contacte con proveedor");
    }
%>