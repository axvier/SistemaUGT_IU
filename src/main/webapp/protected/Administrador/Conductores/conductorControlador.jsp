<%
    String opc = request.getParameter("opc");
    if (opc != null) {
        if (opc.equals("conductoresConfg")) {
            response.sendRedirect("conductorModelo.jsp?opc=" + opc);
        } else if (opc.equals("mostrar")) {
            String accion = request.getParameter("accion");
            response.sendRedirect("conductorVista.jsp?accion=" + accion);
        } else if (opc.equals("saveConductor")) {
            String jsonConductor = request.getParameter("jsonConductor");
            session.setAttribute("jsonConductor", jsonConductor);
            String jsonLicencia = request.getParameter("jsonLicencia");
            session.setAttribute("jsonLicencia", jsonLicencia);
            response.sendRedirect("conductorModelo.jsp?opc=" + opc);
        } else if (opc.equals("eliminarConductor")) {
            String cedula = request.getParameter("cedula");
            String json = request.getParameter("jsonConductor");
            session.setAttribute("json", json);
            response.sendRedirect("conductorModelo.jsp?opc=" + opc + "&cedula=" + cedula);
        } else if (opc.equals("modificarConductor")) {
            String cedula = request.getParameter("cedula");
            session.setAttribute("cedulaConductor", cedula);
            String jsonConductor = request.getParameter("jsonConductor");
            session.setAttribute("jsonConductor", jsonConductor);
            response.sendRedirect("conductorModelo.jsp?opc=" + opc);
        } else if (opc.equals("tableConductores")) {
            response.sendRedirect("conductorVista.jsp?accion="+opc);
        } else if (opc.equals("jsonConductores")) {
            response.sendRedirect("conductorModelo.jsp?opc="+opc);
        } else if (opc.equals("jsonConducBloc")) {
            response.sendRedirect("conductorModelo.jsp?opc="+opc);
        } else if (opc.equals("jsonConducOcup")) {
            response.sendRedirect("conductorModelo.jsp?opc="+opc);
        } else if (opc.equals("consLicencia")) {
            String cedula = request.getParameter("cedula");
            session.setAttribute("licenciaCed", cedula);
            response.sendRedirect("conductorModelo.jsp?opc="+opc);
        } else if (opc.equals("modificarLicencia")) {
            String idlicencia = request.getParameter("idlicencia");
            session.setAttribute("idlicencia", idlicencia);
            String jsonLicencia = request.getParameter("jsonLicencia");
            session.setAttribute("jsonLicencia", jsonLicencia);
            response.sendRedirect("conductorModelo.jsp?opc=" + opc);
        } else if (opc.equals("modalAsignarVehiculo")) {
            String cedula = request.getParameter("cedulaCondVehiculo");
            session.setAttribute("cedulaCondVehiculo", cedula);
            response.sendRedirect("conductorModelo.jsp?opc=" + opc);
        }
    }
%>
