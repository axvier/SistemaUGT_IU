<%-- 
    Document   : RolesControlador
    Created on : 29/11/2018, 11:42:37 PM
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
                response.sendRedirect("RolesVista.jsp?accion=" + accion);
            } else if (opc.equals("jsonRoles")) {
                response.sendRedirect("RolesModelo.jsp?opc=" + opc);
            } else if (opc.equals("selectTipoEntidad")) {
                response.sendRedirect("RolesModelo.jsp?opc=" + opc);
            } else if (opc.equals("modalAddRol")) {
                response.sendRedirect("RolesModelo.jsp?opc=" + opc);
            }
        }
    } else {
        response.sendError(501, this.getServletName() + "-> Error no se ha logueado en el sistema contacte con proveedor");
    }

%>