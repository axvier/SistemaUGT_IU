<%-- 
    Document   : SolicitudModelo
    Created on : 8/12/2018, 01:31:07 PM
    Author     : Xavy PC
--%>
<%@page import="ugt.servicios.swPDF"%>
<%@page import="java.util.logging.Level"%>
<%@page import="java.util.logging.Logger"%>
<%@page import="java.util.Base64"%>
<%@page import="ugt.entidades.Tbseccionsolicitantes"%>
<%@page import="ugt.entidades.Tbpasajeros"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="ugt.entidades.Tbseccionviajes"%>
<%@page import="ugt.entidades.Tbseccionmotivo"%>
<%@page import="ugt.solicitudes.Solicitudesfull"%>
<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="ugt.servicios.swSolicitudes"%>
<%@page import="ugt.entidades.Tbpdf"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="ugt.entidades.Tbsolicitudes"%>
<%@page import="ugt.vehiculosconductores.iu.VehiculosConductoresIU"%>
<%@page import="ugt.servicios.swVehiculoConductor"%>
<%@page import="ugt.entidades.Tbvehiculosdependencias"%>
<%@page import="ugt.entidades.Tbusuariosentidad"%>
<%@page import="ugt.servicios.swVehiculoDependencia"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="utg.login.Login"%>
<%
    Login login = (Login) session.getAttribute("login");
    if (login != null) {
        String opc = request.getParameter("opc");
        Gson g = new Gson();
        if (opc.equals("nuevaSolicitudU")) {
            int idrol = login.getRolActivo().getIdrol();
            String pk = "";
            for (Tbusuariosentidad aux : login.getRolesEntity()) {
                if (aux.getTbusuariosentidadPK().getIdrol() == idrol) {
                    pk = aux.getTbentidad().getIdentidad().toString();
                }
            }
            String objJSON = swVehiculoDependencia.listarVehiculoDependenciaMatricula(pk, "dependencia");
            if (objJSON.length() > 2) {
                Tbvehiculosdependencias vehiculodependencia = g.fromJson(objJSON, Tbvehiculosdependencias.class);
                String ojb2JSON = swVehiculoConductor.listarVehiculoConductorPlaca(vehiculodependencia.getTbvehiculos().getPlaca());
                if (ojb2JSON.length() > 2) {
                    VehiculosConductoresIU vehiculoConductor = new VehiculosConductoresIU();
                    vehiculoConductor.setListaJSON(ojb2JSON);
                    session.setAttribute("vehiculoConductor", vehiculoConductor);
                }
                session.setAttribute("vehiculodependencia", vehiculodependencia);
            }
            response.sendRedirect("SolicitudControlador.jsp?opc=mostrar&accion=" + opc);
        } else if (opc.equals("saveSolicitud")) {
            byte[] bytes = (byte[]) session.getAttribute("byteSPDF");
            String jsonMotivo = (String) session.getAttribute("jsonMotivo");
            String jsonViaje = (String) session.getAttribute("jsonViaje");
            String jsonPasajeros = (String) session.getAttribute("jsonPasajeros");
            session.setAttribute("byteSPDF", null);
            session.setAttribute("jsonMotivo", null);
            session.setAttribute("jsonViaje", null);
            session.setAttribute("jsonPasajeros", null);
            Calendar today = Calendar.getInstance();
            SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd'T'00:00:00-05:00");
            Date date = sf.parse(sf.format(today.getTime()));
            Tbsolicitudes solicitud = new Tbsolicitudes();
            solicitud.setEstado("enviado");
            solicitud.setFecha(date);
            solicitud.setNumero(0);
            String objJSON = swSolicitudes.insertSolicitud(g.toJson(solicitud));
            if (objJSON.length() > 2) {
                g = new GsonBuilder().setDateFormat("yyyy-MM-dd'T'HH:mm:ss").create();
                Solicitudesfull solfull = new Solicitudesfull();
                //ingreso de solicitud
                solfull.setSolicitud(g.fromJson(objJSON, Tbsolicitudes.class));
                //ingreso de solicitante
                if (login.getRolesEntity().size() > 0) {
                    solfull.getSolicitante().setCedulau(login.getRolesEntity().get(0).getTbusuarios());
                    solfull.getSolicitante().setExtension("Riobamba");
                    solfull.getSolicitante().setIdsolicitante(0);
                    solfull.getSolicitante().setSolicitud(solicitud);
                }
                //ingreso de motivo
                if (jsonMotivo != null) {
                    solfull.setMotivo(g.fromJson(jsonMotivo, Tbseccionmotivo.class));
                }
                //ingreso de viaje
                if (jsonViaje != null) {
                    solfull.setViaje(g.fromJson(jsonMotivo, Tbseccionviajes.class));
                }
                //ingreso pasajeros
                if (jsonPasajeros != null) {
                    JSONArray arrayJSON = new JSONArray(jsonPasajeros);
                    for (int i = 0; i < arrayJSON.length(); i++) {
                        JSONObject childJSONObject = arrayJSON.getJSONObject(i);
                        Tbpasajeros pasajero = g.fromJson(childJSONObject.toString(), Tbpasajeros.class);
                        solfull.getPasajeros().add(pasajero);
                    }
                }
                //ingreso por servicio solcitud fullcon los demas 
                if (bytes.length > 0) {
                    try {
                        String encoded = Base64.getEncoder().encodeToString(bytes);
                        String pdfJSON = new JSONObject()
                                .put("idpdf", 0)
                                .put("archivo", encoded).toString();
                        String jsonPDF = swPDF.insertPDF(pdfJSON);
                        if (jsonPDF.length() > 2) {
                            JSONObject obj = new JSONObject(jsonPDF);
                            solfull.setIdpdf(obj.getInt("idpdf"));
                        }
                    } catch (Exception e) {
                        Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en subir el PDF ", e.getClass().getName() + "****" + e.getMessage());
                        System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
                    }

                }
            }
        }
    } else {
        response.sendError(501, this.getServletName() + "-> Error no se ha logueado en el sistema contacte con proveedor");
    }
%>