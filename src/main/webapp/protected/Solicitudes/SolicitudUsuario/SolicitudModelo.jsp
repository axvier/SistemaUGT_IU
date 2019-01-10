<%-- 
    Document   : SolicitudModelo
    Created on : 8/12/2018, 01:31:07 PM
    Author     : Xavy PC
--%>
<%@page import="ugt.entidades.Tbdisponibilidadvc"%>
<%@page import="ugt.servicios.swDisponibilidadVC"%>
<%@page import="java.util.Arrays"%>
<%@page import="ugt.solicitudes.SolicitudesfullLista"%>
<%@page import="ugt.solicitudes.SolicitudPDF"%>
<%@page import="ugt.servicios.swSeccionViaje"%>
<%@page import="ugt.servicios.swViajePasajero"%>
<%@page import="ugt.entidades.TbviajepasajeroPK"%>
<%@page import="ugt.servicios.swSeccionMotivo"%>
<%@page import="ugt.servicios.swSeccionSolicitante"%>
<%@page import="ugt.servicios.swPasajero"%>
<%@page import="ugt.entidades.Tbviajepasajero"%>
<%@page import="ugt.entidades.listas.ViajesPasajerosL"%>
<%@page import="ugt.entidades.listas.PasajerosL"%>
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
//            String objJSON = swVehiculoDependencia.listarVehiculoDependenciaMatricula(pk, "dependencia");
//            if (objJSON.length() > 2) {
//                Tbvehiculosdependencias vehiculodependencia = g.fromJson(objJSON, Tbvehiculosdependencias.class);
//                String ojb2JSON = swVehiculoConductor.listarVehiculoConductorPlaca(vehiculodependencia.getTbvehiculos().getPlaca());
//                if (ojb2JSON.length() > 2) {
//                    VehiculosConductoresIU vehiculoConductor = new VehiculosConductoresIU();
//                    vehiculoConductor.setListaJSON(ojb2JSON);
//                    session.setAttribute("vehiculoConductor", vehiculoConductor);
//                }
//                session.setAttribute("vehiculodependencia", vehiculodependencia);
//            }
            response.sendRedirect("SolicitudControlador.jsp?opc=mostrar&accion=" + opc);
        } else if (opc.equals("pasajeroAutocomplete")) {
            String termino = (String) session.getAttribute("term");
            session.setAttribute("term", null);
            String jsonPasajeros = swPasajero.listarPasajerosTerm(termino);
            JSONArray arrayJSON = new JSONArray(jsonPasajeros);
            JSONArray result = new JSONArray();
            for (int i = 0; i < arrayJSON.length(); i++) {
                JSONObject childJSONObject = arrayJSON.getJSONObject(i);
                JSONObject objJSON = new JSONObject()
                        .put("value", childJSONObject.getString("apellidos") + " " + childJSONObject.getString("nombres"))
                        .put("label", childJSONObject.getString("cedula"))
                        .put("json", childJSONObject.toString());
                result.put(objJSON);
            }
            if (arrayJSON.length() > 0) {
                session.setAttribute("listTerm", result.toString());
            } else {
                String objJSON = new JSONObject()
                        .put("value", "")
                        .put("label", "Cargando...").toString();
                session.setAttribute("listTerm", objJSON);
            }
            response.sendRedirect("SolicitudControlador.jsp?opc=mostrar&accion=" + opc);
        } else if (opc.equals("saveSolicitud")) {
            g = new GsonBuilder().setDateFormat("yyyy-MM-dd'T'HH:mm:ss-05:00").create();
            String status = "";
            byte[] bytes = (byte[]) session.getAttribute("byteSPDF");
            String jsonMotivo = (String) session.getAttribute("jsonMotivo");
            String jsonViaje = (String) session.getAttribute("jsonViaje");
            String jsonPasajeros = (String) session.getAttribute("jsonPasajeros");
            String extension = (String) session.getAttribute("extension");
            session.setAttribute("extension", null);
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
                solicitud = g.fromJson(objJSON, Tbsolicitudes.class); // set nuevos datos de la solicitud insertada
                Solicitudesfull solfull = new Solicitudesfull();
                //insertar pdf y actualizar idpdf a solcitud
                if (bytes != null) {
                    if (bytes.length > 0) {
                        try {
                            String encoded = Base64.getEncoder().encodeToString(bytes);
                            String pdfJSON = new JSONObject()
                                    .put("idpdf", 0)
                                    .put("archivo", encoded).toString();
                            String jsonPDF = swPDF.insertPDF(pdfJSON);
                            if (jsonPDF.length() > 2) {
                                JSONObject obj = new JSONObject(jsonPDF);
                                solicitud.setIdpdf(obj.getInt("idpdf"));
                                if (swSolicitudes.modificarSolicitudID(solicitud.getNumero().toString(), g.toJson(solicitud)).length() <= 2) {
                                    status += " ERROR EN ASIGNAR EL PDF, ";
                                }
                            }
                        } catch (Exception e) {
                            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en subir el PDF ", e.getClass().getName() + "****" + e.getMessage());
                            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
                        }
                    }
                }
                //set datos de solictud en la clase con los componentes
                solfull.setSolicitud(solicitud);
                //ingreso de solicitante
                if (login.getRolesEntity().size() > 0) {
                    Tbseccionsolicitantes usrAux = new Tbseccionsolicitantes();
                    usrAux.setCedulau(login.getRolesEntity().get(0).getTbusuarios());
                    usrAux.setExtension(extension);
                    usrAux.setIdsolicitante(0);
                    usrAux.setSolicitud(solicitud);
                    String objJSONSolicitante = swSeccionSolicitante.insertSolicitante(g.toJson(usrAux));
                    if (objJSONSolicitante.length() > 2) { // si se ingreso correctamente
                        solfull.setSolicitante(g.fromJson(objJSONSolicitante, Tbseccionsolicitantes.class)); // insertar solicitante en solicitud full
                    } else { // si no enviar mensaje 
                        status += " ERROR EN GUARDAR DATOS DE SOLICITANTE, ";
                    }
                }
                //ingreso de motivo
                if (jsonMotivo != null) {
                    Tbseccionmotivo motivoAux = g.fromJson(jsonMotivo, Tbseccionmotivo.class);// extraer motivo y insertar id solicitud
                    motivoAux.setSolicitud(solicitud);
                    String objJSONMotivo = swSeccionMotivo.insertMotivo(g.toJson(motivoAux));
                    if (objJSONMotivo.length() > 2) { // si se ingreso correctamente
                        solfull.setMotivo(g.fromJson(objJSONMotivo, Tbseccionmotivo.class)); // insertar motivo en solicitud full
                    } else { // si no enviar mensaje 
                        status += " ERROR AL GUARDAR MOTIVO, ";
                    }
                }
                //ingreso de viaje
                if (jsonViaje != null) {
                    Tbseccionviajes viajeAux = g.fromJson(jsonViaje, Tbseccionviajes.class);// extraer viaje y insertar id solicitud
                    viajeAux.setSolicitud(solicitud);
                    String objJSONViaje = swSeccionViaje.insertViaje(g.toJson(viajeAux));
                    if (objJSONViaje.length() > 2) { // si se ingreso correctamente
                        solfull.setViaje(g.fromJson(objJSONViaje, Tbseccionviajes.class)); // insertar viaje en solicitud full
                    } else { // si no enviar mensaje 
                        status += " ERROR AL GUARDAR EL VIAJE, ";
                    }
                }
                //ingreso pasajeros
                if (jsonPasajeros != null) {
                    ViajesPasajerosL pasajeros = g.fromJson(jsonPasajeros, ViajesPasajerosL.class);
                    ViajesPasajerosL pasajerosAux = new ViajesPasajerosL();
                    for (Tbviajepasajero viajePasajeroAux : pasajeros.getLista()) {
                        String existe = swPasajero.listarPasajeroID(viajePasajeroAux.getTbpasajeros().getCedula());
                        if (existe.length() <= 2) { // si no existe entonces se lo inserta
                            if (swPasajero.insertPasajero(g.toJson(viajePasajeroAux.getTbpasajeros())).length() <= 2) {
                                status += "Error al ingresar pasajero " + viajePasajeroAux.getTbpasajeros().getCedula();
                            }
                        } else {
                            swPasajero.modificarPasajero(viajePasajeroAux.getTbpasajeros().getCedula(), g.toJson(viajePasajeroAux.getTbpasajeros()));
//                                status += "Error al ingresar pasajero " + viajePasajeroAux.getTbpasajeros().getCedula();
                        }
                        //pregutnamos si ya existe la seccion viaje de la solicitud con su id
                        if (solfull.getViaje() != null) {
                            if (solfull.getViaje().getIdviaje() != 0) {
                                //insertamos la seccion viaje
                                viajePasajeroAux.setTbseccionviajes(solfull.getViaje());
                                //insertamos los pks
                                viajePasajeroAux.setTbviajepasajeroPK(new TbviajepasajeroPK(solfull.getViaje().getIdviaje(), viajePasajeroAux.getTbpasajeros().getCedula()));
                                // insertamos la relacion pasajero y viaje
                                String objJSONViajePasajero = swViajePasajero.insertViajePasajero(g.toJson(viajePasajeroAux));
                                if (objJSONViajePasajero.length() > 2) { // si se ingreso correctamente
                                    pasajerosAux.add(g.fromJson(objJSONViajePasajero, Tbviajepasajero.class));
                                } else { // si no enviar mensaje 
                                    status += " ERROR PASAJERO " + viajePasajeroAux.getTbpasajeros().getCedula() + ", ";
                                }
                            }
                        }
                    }
                    if (pasajerosAux.getLista().size() > 0) {
                        solfull.setPasajeros(pasajerosAux.getLista());
                    }
                }
                if (status.length() > 2) {
                    session.setAttribute("statusGuardar", status);
                    session.setAttribute("statusCodigo", "KO");
                } else {
                    session.setAttribute("statusGuardar", "Solicitud Guardada");
                    session.setAttribute("statusCodigo", "OK");
                }
                String auxNA = login.getRolesEntity().get(0).getTbusuarios().getNombres() + " " + login.getRolesEntity().get(0).getTbusuarios().getApellidos();
                session.setAttribute("statusnombresapellidos", auxNA);
                if (login.getRolActivo() != null) {
                    if (login.getRolActivo().getIdrol() != null) {
                        String idrol = login.getRolActivo().getIdrol().toString();
                        String cedula = login.getRolesEntity().get(0).getTbusuarios().getCedula();
                        String objJSONSolicitante = swSeccionSolicitante.buscarEntidadSolicitante(cedula, idrol);
                        if (objJSONSolicitante.length() > 2) {
                            Tbusuariosentidad entidadRol = g.fromJson(objJSONSolicitante, Tbusuariosentidad.class);
                            String auxRE = entidadRol.getTbroles().getDescripcion() + " de " + entidadRol.getTbentidad().getNombre();
                            session.setAttribute("statusrolentidad", auxRE);
                        }
                    }
                }
                session.setAttribute("solicitudFull", solfull.getSolicitud().getNumero().toString());
                response.sendRedirect("SolicitudControlador.jsp?opc=mostrar&accion=guardarStatusSol");
            }
        } else if (opc.equals("modConfirmSolPDF")) {
            String auxNA = login.getRolesEntity().get(0).getTbusuarios().getNombres() + " " + login.getRolesEntity().get(0).getTbusuarios().getApellidos();
            session.setAttribute("statusnombresapellidos", auxNA);
            if (login.getRolActivo() != null) {
                if (login.getRolActivo().getIdrol() != null) {
                    String idrol = login.getRolActivo().getIdrol().toString();
                    String cedula = login.getRolesEntity().get(0).getTbusuarios().getCedula();
                    String objJSONSolicitante = swSeccionSolicitante.buscarEntidadSolicitante(cedula, idrol);
                    if (objJSONSolicitante.length() > 2) {
                        Tbusuariosentidad entidadRol = g.fromJson(objJSONSolicitante, Tbusuariosentidad.class);
                        String auxRE = entidadRol.getTbroles().getDescripcion() + " de " + entidadRol.getTbentidad().getNombre();
                        session.setAttribute("statusrolentidad", auxRE);
                    }
                }
            }
            response.sendRedirect("SolicitudControlador.jsp?opc=mostrar&accion=" + opc);

        } else if (opc.equals("generarPDFSolID")) {
            String idSolicitud = (String) session.getAttribute("idSolicitud");
            String objJSON = swSolicitudes.getSolicitudFullID(idSolicitud);
            if (objJSON.length() > 2) {
                SolicitudPDF pdf = g.fromJson(objJSON, SolicitudPDF.class);
                session.setAttribute("solicitudfullPDF", pdf);
            }
            response.sendRedirect("SolicitudControlador.jsp?opc=mostrar&accion=" + opc);
        } else if (opc.equals("misSolicitudes")) {
            g = new GsonBuilder().setDateFormat("yyyy-MM-dd'T'HH:mm:ss-05:00").create();
            String objJSON = swSolicitudes.getSolicitudesFullCedula(login.getRolesEntity().get(0).getTbusuarios().getCedula());
            if (objJSON.length() > 2) {
                SolicitudesfullLista pdf = g.fromJson(objJSON, SolicitudesfullLista.class);
                if (pdf.getLista().size() > 0) {
                    session.setAttribute("arrayJSON", g.toJson(pdf.getLista()));
                    response.sendRedirect("SolicitudControlador.jsp?opc=mostrar&accion=jsonSolicitudes");
                } else {
                    response.sendRedirect("SolicitudControlador.jsp?opc=mostrar&accion=jsonVacio");
                }
            }
        } else if (opc.equals("downloadReqSol")) {
            g = new Gson();
            String idSolicitud = (String) session.getAttribute("idSolicitud");
            session.setAttribute("idSolicitud", null);
            String objJSON = swPDF.listarPDFID(idSolicitud);
            if (objJSON.length() > 2) {
                JSONObject obj = new JSONObject(objJSON);
                String pdf64 = obj.getString("archivo");
                if (pdf64.length() > 0) {
                    byte[] bytes = Base64.getDecoder().decode(pdf64);
                    session.setAttribute("pdf64", Base64.getEncoder().encodeToString(bytes));
                }
                response.sendRedirect("SolicitudControlador.jsp?opc=mostrar&accion=" + opc);
            }
        } else if (opc.equals("modDisponibilidadV_C")) {
            g = new GsonBuilder().setDateFormat("yyyy-MM-dd'T'HH:mm:ss-05:00").create();
            String idSolicitud = (String) session.getAttribute("idSolicitud");
            String objJSON = swDisponibilidadVC.getDisponibilidadVCSolicitud(idSolicitud);
            if (objJSON.length() > 2) {
                Tbdisponibilidadvc disponibilidadVC = g.fromJson(objJSON, Tbdisponibilidadvc.class);
                session.setAttribute("disponibilidadVC", disponibilidadVC);
            }
            response.sendRedirect("SolicitudControlador.jsp?opc=mostrar&accion=" + opc);
        } else if (opc.equals("eliminarSolicitud")) {
            g = new GsonBuilder().setDateFormat("yyyy-MM-dd'T'HH:mm:ss-05:00").create();
            String idSolicitud = (String) session.getAttribute("idSolicitud");
            session.setAttribute("idSolicitud", null);
            String objJSON = swSolicitudes.listarSolicitudID(idSolicitud);
            if (objJSON.length() > 2) {
                String respuesta = "";
                Tbsolicitudes sol = g.fromJson(objJSON, Tbsolicitudes.class);
                String idPDF = (sol.getIdpdf() != null) ? sol.getIdpdf().toString() : "";
                if (idPDF.length() > 0) {
                    String deletePDF = swPDF.eliminarPDF(idPDF);
                    if (deletePDF.equals("200") || deletePDF.equals("204") || deletePDF.equals("202")) {
                        respuesta += "";
                    }else{
                        respuesta += "Pdf requistitos no eliminado, ";
                    }
                }
                String deleteSolicitud = swSolicitudes.eliminarSolicitud(idSolicitud);
                if (deleteSolicitud.equals("200") || deleteSolicitud.equals("204") || deleteSolicitud.equals("202")) {
                    respuesta += "";
                }else
                    respuesta += "No se ha podido eliminar la solicitud";
                if (respuesta.length() > 0) {
                    session.setAttribute("statusCodigo", "KO");
                } else {
                    respuesta ="Se ha eliminado el registro";
                    session.setAttribute("statusCodigo", "OK");
                }
                session.setAttribute("statusDelete", respuesta);
            }
            response.sendRedirect("SolicitudControlador.jsp?opc=mostrar&accion=eliminarStatus");
        }
    } else {
        response.sendError(501, this.getServletName() + "-> Error no se ha logueado en el sistema contacte con proveedor");
    }
%>