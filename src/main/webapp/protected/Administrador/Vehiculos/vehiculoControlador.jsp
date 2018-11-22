<%@page import="utg.login.Login"%>
<%
    Login login = (Login) session.getAttribute("login");
    if (login != null) {
        String opc = request.getParameter("opc");
        if (opc != null) {
            if (opc.equals("jsonVehiculos")) {
                response.sendRedirect("vehiculoModelo.jsp?opc=" + opc);
            } else if (opc.equals("mostrar")) {
                String accion = request.getParameter("accion");
                response.sendRedirect("vehiculoVista.jsp?accion=" + accion);
            } else if (opc.equals("saveVehiculo")) {
                String jsonVehiculo = request.getParameter("jsonVehiculo");
                session.setAttribute("jsonVehiculo", jsonVehiculo);
                String placa = request.getParameter("jsonVehiculo");
                session.setAttribute("placa", placa);
                response.sendRedirect("vehiculoModelo.jsp?opc=" + opc);
            } else if (opc.equals("eliminarVehiculo")) {
                String placa = request.getParameter("placa");
                String jsonVehiculo = request.getParameter("jsonVehiculo");
                String nombreGrupo = request.getParameter("nombreGrupo");
                session.setAttribute("json", jsonVehiculo);
                session.setAttribute("placa", placa);
                session.setAttribute("nombreGrupo", nombreGrupo);
                response.sendRedirect("vehiculoModelo.jsp?opc=" + opc);
            } else if (opc.equals("modificarVehiculo")) {
                String placa = request.getParameter("placa");
                String jsonVehiculo = request.getParameter("jsonVehiculo");
                String idgrupo = request.getParameter("idgrupo");
                session.setAttribute("placa", placa);
                session.setAttribute("jsonVehiculo", jsonVehiculo);
                session.setAttribute("idgrupo", idgrupo);
                response.sendRedirect("vehiculoModelo.jsp?opc=" + opc);
            } else if (opc.equals("tableVehiculos")) {
                response.sendRedirect("vehiculoModelo.jsp?opc=" + opc );
            } else if (opc.equals("jsonVehiculosOcup")) {
                response.sendRedirect("vehiculoModelo.jsp?opc=" + opc );
            } else if (opc.equals("jsonVehiculosUnlock")) {
                response.sendRedirect("vehiculoModelo.jsp?opc=" + opc );
            } else if (opc.equals("contentModalVerCond")) {
                String placa = request.getParameter("placa");
                session.setAttribute("placa", placa);
                response.sendRedirect("vehiculoModelo.jsp?opc=" + opc );
            }
        }
    } else {
        response.sendError(501, this.getServletName() + "-> Error no se ha logueado en el sistema contacte con proveedor");
    }

%>
