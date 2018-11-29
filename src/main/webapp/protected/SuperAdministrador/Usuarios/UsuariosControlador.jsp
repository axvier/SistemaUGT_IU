<%-- 
    Document   : UsuariosControlador
    Created on : 25/11/2018, 08:27:09 PM
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
                response.sendRedirect("UsuariosVista.jsp?accion=" + accion);
            } else if (opc.equals("jsonUsuarios")) {
                response.sendRedirect("UsuariosModelo.jsp?opc=" + opc);
            } else if (opc.equals("saveUser")) {
                String jsonUser = request.getParameter("jsonUser");
                session.setAttribute("jsonUser", jsonUser);
                response.sendRedirect("UsuariosModelo.jsp?opc=" + opc);
            } else if (opc.equals("modificarUser")) {
                String jsonUser = request.getParameter("jsonUser");
                session.setAttribute("jsonUser", jsonUser);
                String cedulaUG = request.getParameter("cedula");
                session.setAttribute("cedulaUG", cedulaUG);
                response.sendRedirect("UsuariosModelo.jsp?opc=" + opc);
            } else if (opc.equals("eliminarUser")) {
                String cedulaUG = request.getParameter("cedula");
                session.setAttribute("cedulaUG", cedulaUG);
                response.sendRedirect("UsuariosModelo.jsp?opc=" + opc);
            } else if (opc.equals("modalAddGEntidadRol")) {
                String cedulaUG = request.getParameter("cedulaUG");
                session.setAttribute("cedulaUG", cedulaUG);
                response.sendRedirect("UsuariosModelo.jsp?opc=" + opc);
            } else if (opc.equals("divModalVerEntidadRol")) {
                String cedulaUG = request.getParameter("cedulaUG");
                session.setAttribute("cedulaUG", cedulaUG);
                response.sendRedirect("UsuariosModelo.jsp?opc=" + opc);
            } else if (opc.equals("saveUsuarioEntidad")) {
                String jsonUsuarioEntidad = request.getParameter("jsonUsuarioEntidad");
                session.setAttribute("jsonUsuarioEntidad", jsonUsuarioEntidad);
                response.sendRedirect("UsuariosModelo.jsp?opc=" + opc);
            } else if (opc.equals("elimUsuarioEntidad")) {
                String jsonUsuarioEntidad = request.getParameter("jsonUsuarioEntidad");
                session.setAttribute("jsonUsuarioEntidad", jsonUsuarioEntidad);
                response.sendRedirect("UsuariosModelo.jsp?opc=" + opc);
            } else if (opc.equals("modUsuarioEntidad")) {
                String jsonUsuarioEntidad = request.getParameter("jsonUsuarioEntidad");
                session.setAttribute("jsonUsuarioEntidad", jsonUsuarioEntidad);
                response.sendRedirect("UsuariosModelo.jsp?opc=" + opc);
            }
        }
    } else {
        response.sendError(501, this.getServletName() + "-> Error no se ha logueado en el sistema contacte con proveedor");
    }

%>