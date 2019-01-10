<%-- 
    Document   : SolicitudesModelo
    Created on : 5/01/2019, 05:55:59 PM
    Author     : Xavy PC
--%>

<%@page import="ugt.conductores.iu.ConductoresIU"%>
<%@page import="ugt.servicios.swConductor"%>
<%@page import="ugt.servicios.swVehiculo"%>
<%@page import="ugt.vehiculosconductores.iu.VehiculosConductoresIU"%>
<%@page import="ugt.servicios.swVehiculoConductor"%>
<%@page import="ugt.entidades.Tbvehiculosdependencias"%>
<%@page import="ugt.servicios.swVehiculoDependencia"%>
<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="ugt.entidades.Tbusuariosentidad"%>
<%@page import="ugt.servicios.swSeccionSolicitante"%>
<%@page import="ugt.servicios.swSolicitudes"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="utg.login.Login"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Login login = (Login) session.getAttribute("login");
    if (login != null) {
        String opc = request.getParameter("opc");
        Gson g = new Gson();
        if (opc.equals("jsonSolicitudesEnviados")) {
//            String estado = (String) session.getAttribute("estadoSolicitudes");
            String estado = "enviado";
            session.setAttribute("estadoSolicitudes", null);
            String arrayJSON = swSolicitudes.filtrarSolicitudesEstado(estado);
            if (arrayJSON.length() > 2) {
                session.setAttribute("arrayJSON", arrayJSON);
                response.sendRedirect("SolicitudesControlador.jsp?opc=mostrar&accion=" + opc);
            } else {
                response.sendRedirect("SolicitudesControlador.jsp?opc=mostrar&accion=jsonVacio");
            }
        } else if (opc.equals("modificarSolicitud")) {
            String idSolicitud = (String) session.getAttribute("idSolicitud");
            String jsonsSolicitud = (String) session.getAttribute("jsonSolicitud");
            session.setAttribute("iSolicitudd", null);
            session.setAttribute("jsonSolicitud", null);
            String jsonMod = swSolicitudes.modificarSolicitudID(idSolicitud, jsonsSolicitud);
            if (jsonMod.length() > 2) {
                session.setAttribute("statusMod", "Se ha actualizado los datos");
                session.setAttribute("statusCodigo", "OK");
            } else {
                session.setAttribute("statusMod", "Error al intentar acuatlizar los datos - contacte con el proveedor");
                session.setAttribute("statusCodigo", "KO");
            }
            response.sendRedirect("SolicitudesControlador.jsp?opc=mostrar&accion=modificarStatus");
        } else if (opc.equals("modSolicitanteInfo")) {
            g = new GsonBuilder().setDateFormat("yyyy-MM-dd'T'HH:mm:ss-05:00").create();
            String cedula = (String) session.getAttribute("cedulaSolicitante");
            session.setAttribute("cedulaSolicitante", null);
            String objJSON = swSeccionSolicitante.buscarEntidadUsuarioOpc(cedula, "9");
            if (objJSON.length() > 2) {
                Tbusuariosentidad userSol = g.fromJson(objJSON, Tbusuariosentidad.class);
                session.setAttribute("userSol", userSol);
            }
            response.sendRedirect("SolicitudesControlador.jsp?opc=mostrar&accion=" + opc);
        } else if (opc.equals("AgendaVehiculo")) {
            g = new GsonBuilder().setDateFormat("yyyy-MM-dd'T'HH:mm:ss-05:00").create();
            String placaAgenda = (String) session.getAttribute("placaAgenda");
            session.setAttribute("placaAgenda", null);
            String arrayJSON = swVehiculo.buscarVehiculoAgenda(placaAgenda);
            if (arrayJSON.length() > 2) {
                session.setAttribute("arrayJSON", arrayJSON);
            }
            response.sendRedirect("SolicitudesControlador.jsp?opc=mostrar&accion=arrayJSON");
        } else if (opc.equals("disponibilidadVehiculoConductor")) {
            g = new GsonBuilder().setDateFormat("yyyy-MM-dd'T'HH:mm:ss-05:00").create();
            String cedula = (String) session.getAttribute("cedulaSolicitante");
            session.setAttribute("cedulaSolicitante", null);
            //extraer entidad a la que pertenece el usuario
            String objJSON = swSeccionSolicitante.buscarEntidadUsuarioOpc(cedula, "9");
            if (objJSON.length() > 2) {
                Tbusuariosentidad userSol = g.fromJson(objJSON, Tbusuariosentidad.class);
                Integer entid = userSol.getTbusuariosentidadPK().getIdentidad();
                session.setAttribute("userSol", userSol);
                //extraer la entidad con un vehiculo asignado
                String objJSONDpendencia = swVehiculoDependencia.listarVehiculoDependenciaMatricula(entid.toString(), "dependencia");
                if (objJSONDpendencia.length() > 2) {
                    Tbvehiculosdependencias vehiculodependencia = g.fromJson(objJSONDpendencia, Tbvehiculosdependencias.class);
                    //extraer vehiculo con su conductor asignado
                    String objJSONV_C = swVehiculoConductor.listarVehiculoConductorPlaca(vehiculodependencia.getTbvehiculos().getPlaca());
                    if (objJSONV_C.length() > 2) {
                        VehiculosConductoresIU vehiculoConductor = new VehiculosConductoresIU();
                        vehiculoConductor.setListaJSON(objJSONV_C);
                        if (vehiculoConductor.getLista().size() > 0 && vehiculoConductor.getLista().size() < 2) {
                            session.setAttribute("vehiculoConductor", vehiculoConductor.getLista().get(0));
                        }
                    }
                    session.setAttribute("vehiculodependencia", vehiculodependencia);
                }
            }
            String arrayJSONVehiculos = swVehiculoConductor.VehiculosDependenciasNullorNot();
            if (arrayJSONVehiculos.length() > 2) {
                VehiculosConductoresIU listaV_C = new VehiculosConductoresIU();
                listaV_C.setListaJSON(arrayJSONVehiculos);
                session.setAttribute("listaV_C", listaV_C);
            }
            String arrayJSONConductores = swConductor.listarConductoresDiferenteEstado("Jubilado");
            if (arrayJSONConductores.length() > 2) {
                ConductoresIU listaConductores  = new ConductoresIU();
                listaConductores.setListaJSON(arrayJSONConductores);
                session.setAttribute("listaConductores",listaConductores);
            }
            response.sendRedirect("SolicitudesControlador.jsp?opc=mostrar&accion=" + opc);
        }
    } else {
        response.sendError(501, this.getServletName() + "-> Error no se ha logueado en el sistema contacte con proveedor");
    }
%>
