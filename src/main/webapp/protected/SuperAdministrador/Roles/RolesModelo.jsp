<%-- 
    Document   : RolesModelo
    Created on : 29/11/2018, 11:42:18 PM
    Author     : Xavy PC
--%>
<%@page import="ugt.tiposentidades.iu.TiposEntidadesIU"%>
<%@page import="ugt.servicios.swTipoEntidad"%>
<%@page import="ugt.servicios.swRol"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="utg.login.Login"%>
<%
    Login login = (Login) session.getAttribute("login");
    if (login != null) {
        String opc = request.getParameter("opc");
        Gson g = new Gson();
        if (opc.equals("jsonRoles")) {
            String arrayJSON = swRol.listarRoles();
            if (arrayJSON.length() > 2) {
                session.setAttribute("arrayJSON", arrayJSON);
                response.sendRedirect("RolesControlador.jsp?opc=mostrar&accion=" + opc);
            } else {
                response.sendRedirect("RolesControlador.jsp?opc=mostrar&accion=jsonVacio");
            }
        }else if(opc.equals("selectTipoEntidad")){
            String arrayJSON = swTipoEntidad.listarTipoEntidad();
            if (arrayJSON.length() > 2) {
                TiposEntidadesIU tiposentidadesIU = new TiposEntidadesIU();
                tiposentidadesIU.setListaJSON(arrayJSON);
                session.setAttribute("tiposentidadesIU", tiposentidadesIU);
            }
            response.sendRedirect("RolesControlador.jsp?opc=mostrar&accion=" + opc);
        }else if(opc.equals("modalAddRol")){
            String arrayJSON = swTipoEntidad.listarTipoEntidad();
            if (arrayJSON.length() > 2) {
                TiposEntidadesIU tiposentidadesIU = new TiposEntidadesIU();
                tiposentidadesIU.setListaJSON(arrayJSON);
                session.setAttribute("tiposentidadesIU", tiposentidadesIU);
            }
            response.sendRedirect("RolesControlador.jsp?opc=mostrar&accion=" + opc);
        }
    } else {
        response.sendError(501, this.getServletName() + "-> Error no se ha logueado en el sistema contacte con proveedor");
    }

%>