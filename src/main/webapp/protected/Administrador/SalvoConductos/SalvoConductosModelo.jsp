<%-- 
    Document   : SalvoConductosModelo
    Created on : 14/01/2019, 01:30:30 PM
    Author     : Xavy PC
--%>

<%@page import="ugt.entidades.Tbordenesmovilizaciones"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="ugt.servicios.swOrdenMovilizacion"%>
<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="ugt.entidades.Tbsolicitudes"%>
<%@page import="ugt.servicios.swSolicitudes"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="utg.login.Login"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Login login = (Login) session.getAttribute("login");
    if (login != null) {
        String opc = request.getParameter("opc");
        Gson g = new Gson();
        if (opc.equals("jsonSolicitudesEstado")) {
            String estado = (String) session.getAttribute("estadoSolicitudes");
            session.setAttribute("estadoSolicitudes", null);
            String arrayJSON = swSolicitudes.filtrarSolicitudesEstado(estado);
            if (arrayJSON.length() > 2) {
                session.setAttribute("arrayJSON", arrayJSON);
                response.sendRedirect("SalvoConductosControlador.jsp?opc=mostrar&accion=arrayJSON");
            } else {
                response.sendRedirect("SalvoConductosControlador.jsp?opc=mostrar&accion=jsonVacio");
            }
        }else if (opc.equals("jsonFullOrdenes")) {
            String arrayJSON = swOrdenMovilizacion.listarOrdenesFullSol();
            if (arrayJSON.length() > 2) {
                session.setAttribute("arrayJSON", arrayJSON);
                response.sendRedirect("SalvoConductosControlador.jsp?opc=mostrar&accion=arrayJSON");
            } else {
                response.sendRedirect("SalvoConductosControlador.jsp?opc=mostrar&accion=jsonVacio");
            }
        } else if (opc.equals("ModificarSolicitud")) {
            String idSolicitud = (String) session.getAttribute("idSolicitud");
            String jsonsSolicitud = (String) session.getAttribute("jsonSolicitud");
            session.setAttribute("idSolicitud", null);
            session.setAttribute("jsonSolicitud", null);
            String jsonMod = swSolicitudes.modificarSolicitudID(idSolicitud, jsonsSolicitud);
            if (jsonMod.length() > 2) {
                session.setAttribute("statusMod", "Se ha actualizado los datos");
                session.setAttribute("statusCodigo", "OK");
            } else {
                session.setAttribute("statusMod", "Error al intentar acuatlizar los datos - contacte con el proveedor");
                session.setAttribute("statusCodigo", "KO");
            }
            response.sendRedirect("SalvoConductosControlador.jsp?opc=mostrar&accion=modificarStatus");
        } else if (opc.equals("saveOrdenMov")) {
            g = new GsonBuilder().setDateFormat("yyyy-MM-dd'T'HH:mm:ss-05:00").create();
            String jsonSolicitud = (String) session.getAttribute("jsonSolicitud");
            String kminicio = (String) session.getAttribute("kminicio");
            session.setAttribute("jsonSolicitud", null);
            session.setAttribute("kminicio", null);
            Tbsolicitudes solicitud = g.fromJson(jsonSolicitud, Tbsolicitudes.class);
            solicitud.setEstado("finalizada");
            String exiteOrden = swOrdenMovilizacion.filtarOrdenMovilizacionIDSol(solicitud.getNumero().toString());
            if (exiteOrden.length() <= 2) {
                Calendar today = Calendar.getInstance();
                SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss-05:00");
                Date date = sf.parse(sf.format(today.getTime()));
                int year = Calendar.getInstance().get(Calendar.YEAR);
                Tbordenesmovilizaciones orden = new Tbordenesmovilizaciones();
                orden.setFechagenerar(date);
                if (kminicio != null) {
                    if (kminicio.length() > 0) {
                        orden.setKminicio(kminicio);
                    }
                }
                orden.setNumeroOrden(solicitud.getNumero() + "-UGT-" + year);
                orden.setSolicitud(solicitud);
                String resAUX = swOrdenMovilizacion.insertOrdenMovilizacion(g.toJson(orden));
                if (resAUX.length() > 2) {
                    swSolicitudes.modificarSolicitudID(solicitud.getNumero().toString(), g.toJson(solicitud));
                    session.setAttribute("statusMod", "Se ha insertado los datos");
                    session.setAttribute("statusCodigo", "OK");
                }
            } else {
                String solAUX = swSolicitudes.modificarSolicitudID(solicitud.getNumero().toString(), g.toJson(solicitud));
                if (solAUX.length() > 2) {
                    session.setAttribute("statusMod", "Se ha actualizado los datos");
                    session.setAttribute("statusCodigo", "OK");
                } else {
                    session.setAttribute("statusMod", "Error al intentar acuatlizar los datos - contacte con el proveedor");
                    session.setAttribute("statusCodigo", "KO");
                }
            }
            response.sendRedirect("SalvoConductosControlador.jsp?opc=mostrar&accion=modificarStatus");
        }
    } else {
        response.sendError(501, this.getServletName() + "-> Error no se ha logueado en el sistema contacte con proveedor");
    }
%>
