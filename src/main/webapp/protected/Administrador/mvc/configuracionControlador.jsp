<%
    String opc = request.getParameter("opc");
    if (opc != null) {
        if (opc.equals("vehiculosConfg")) {
            //response.sendRedirect("configuracionVista.jsp?accion=" + opc);
            response.sendRedirect("configuracionModelo.jsp?opc=" + opc);
        } else if (opc.equals("mostrar")) {
            String accion = request.getParameter("accion");
            response.sendRedirect("configuracionVista.jsp?accion=" + accion);
        } else if (opc.equals("conductorConfg")){
        response.sendRedirect("configuracionModelo.jsp?opc=" + opc);
        }
        else {
        }
    }
%>
