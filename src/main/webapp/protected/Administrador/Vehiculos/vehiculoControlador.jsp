<%@page import="utg.login.Login"%>
<%
    Login login = (Login) session.getAttribute("login");
    if (login != null) {
        String opc = request.getParameter("opc");
        if (opc != null) {
            if (opc.equals("vehiculosConfg")) {
                //response.sendRedirect("configuracionVista.jsp?accion=" + opc);
                response.sendRedirect("vehiculoModelo.jsp?opc=" + opc);
            } else if (opc.equals("mostrar")) {
                String accion = request.getParameter("accion");
                response.sendRedirect("vehiculoVista.jsp?accion=" + accion);
            } else if (opc.equals("saveVehiculo")) {
                String jsonVehiculo = request.getParameter("jsonVehiculo");
                response.sendRedirect("vehiculoModelo.jsp?opc=" + opc + "&jsonVehiculo=" + jsonVehiculo);
            } else if (opc.equals("eliminarVehiculo")) {
                String placa = request.getParameter("placa");
                String jsonVehiculo = request.getParameter("jsonVehiculo");
                response.sendRedirect("vehiculoModelo.jsp?opc=" + opc + "&placa=" + placa + "&jsonVehiculo=" + jsonVehiculo);
            } else if (opc.equals("modificarVehiculo")) {
                String placa = request.getParameter("placa");
                String jsonVehiculo = request.getParameter("jsonVehiculo");
                response.sendRedirect("vehiculoModelo.jsp?opc=" + opc + "&jsonVehiculo=" + jsonVehiculo + "&placa=" + placa);
            } else {
            }
        }
    } else {
        response.sendError(501, this.getServletName() + "-> Error no se ha logueado en el sistema contacte con proveedor");
    }

%>
