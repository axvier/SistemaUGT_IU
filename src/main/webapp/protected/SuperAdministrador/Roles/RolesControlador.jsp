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
            } else if (opc.equals("GAddGRolOpcion")) {
                response.sendRedirect("RolesModelo.jsp?opc=" + opc);
            } else if (opc.equals("chksOpcionesRol")) {
                String idRol = request.getParameter("idRol");
                session.setAttribute("idRol", idRol);
                response.sendRedirect("RolesModelo.jsp?opc=" + opc);
            } else if (opc.equals("saveRol")) {
                String jsonUser = request.getParameter("jsonRol");
                session.setAttribute("jsonRol", jsonUser);
                response.sendRedirect("RolesModelo.jsp?opc=" + opc);
            } else if (opc.equals("modificarRol")) {
                String jsonRol = request.getParameter("jsonRol");
                session.setAttribute("jsonRol", jsonRol);
                String idrol = request.getParameter("idrol");
                session.setAttribute("idrol", idrol);
                response.sendRedirect("RolesModelo.jsp?opc=" + opc);
            } else if (opc.equals("eliminarRol")) {
                String idrol = request.getParameter("idrol");
                session.setAttribute("idrol", idrol);
                response.sendRedirect("RolesModelo.jsp?opc=" + opc);
            } else if (opc.equals("saveRolOpciones")) {
                String jsonRol = request.getParameter("jsonRol");
                session.setAttribute("jsonRol", jsonRol);
                String jsonOpciones = request.getParameter("jsonOpciones");
                session.setAttribute("jsonOpciones", jsonOpciones);
                response.sendRedirect("RolesModelo.jsp?opc=" + opc);
            }
        }
    } else {
        response.sendError(501, this.getServletName() + "-> Error no se ha logueado en el sistema contacte con proveedor");
    }

%>