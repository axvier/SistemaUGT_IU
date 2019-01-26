<%-- 
    Document   : SalvoConductosModelo
    Created on : 14/01/2019, 01:30:30 PM
    Author     : Xavy PC
--%>

<%@page import="ugt.registros.iu.RegistrosM"%>
<%@page import="java.util.logging.Level"%>
<%@page import="java.util.logging.Logger"%>
<%@page import="ugt.servicios.swPDF"%>
<%@page import="java.util.Base64"%>
<%@page import="org.json.JSONObject"%>
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
        } else if (opc.equals("jsonFullOrdenes")) {
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
        } else if (opc.equals("modificarOrden")) {
            g = new GsonBuilder().setDateFormat("yyyy-MM-dd'T'HH:mm:ss-05:00").create();
            String idSolicitud = (String) session.getAttribute("idSolicitud");
            String jsonsSolicitud = (String) session.getAttribute("jsonSolicitud");
            String idOrden = (String) session.getAttribute("idOrden");
            String jsonsOrden = (String) session.getAttribute("jsonOrden");
            session.setAttribute("idSolicitud", null);
            session.setAttribute("jsonSolicitud", null);
            session.setAttribute("idOrden", null);
            session.setAttribute("jsonOrdenv", null);
            String jsonMod = swSolicitudes.modificarSolicitudID(idSolicitud, jsonsSolicitud);
            if (jsonMod.length() > 2) {
                RegistrosM.Insertar(login, g.fromJson(jsonMod, Tbsolicitudes.class), "finalizada mod");
                Tbordenesmovilizaciones orden = g.fromJson(jsonsOrden, Tbordenesmovilizaciones.class);
                orden.setSolicitud(g.fromJson(jsonMod, Tbsolicitudes.class));
                if (swOrdenMovilizacion.modificaOrdenMovilizacionID(idOrden, g.toJson(orden)).length() > 2) {
                    RegistrosM.Insertar(login, orden, "modificar");
                    session.setAttribute("statusMod", "Se ha actualizado los datos orden solicitud");
                    session.setAttribute("statusCodigo", "OK");
                } else {
                    session.setAttribute("statusMod", "Error al intentar acuatlizar los datos orden solicitud- contacte con el proveedor");
                    session.setAttribute("statusCodigo", "KO");
                }
            } else {
                session.setAttribute("statusMod", "Error al intentar acuatlizar los datos solicitud orden- contacte con el proveedor");
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
                if (kminicio != null && kminicio.length() > 0) {
                    orden.setKminicio(kminicio);
                }
                orden.setNumeroOrden(solicitud.getNumero() + "-UGT-" + year);
                orden.setSolicitud(solicitud);
                String resAUX = swOrdenMovilizacion.insertOrdenMovilizacion(g.toJson(orden));
                if (resAUX.length() > 2) {
                    RegistrosM.Insertar(login, orden, "Orden Insertada");
                    swSolicitudes.modificarSolicitudID(solicitud.getNumero().toString(), g.toJson(solicitud));
                    RegistrosM.Insertar(login, solicitud, solicitud.getEstado());
                    session.setAttribute("statusMod", "Se ha insertado los datos");
                    session.setAttribute("statusCodigo", "OK");
                }
            } else {
                String solAUX = swSolicitudes.modificarSolicitudID(solicitud.getNumero().toString(), g.toJson(solicitud));
                if (solAUX.length() > 2) {
                    RegistrosM.Insertar(login, solicitud, solicitud.getEstado());
                    session.setAttribute("statusMod", "Se ha actualizado los datos");
                    session.setAttribute("statusCodigo", "OK");
                } else {
                    session.setAttribute("statusMod", "Error al intentar acuatlizar los datos - contacte con el proveedor");
                    session.setAttribute("statusCodigo", "KO");
                }
            }
            response.sendRedirect("SalvoConductosControlador.jsp?opc=mostrar&accion=modificarStatus");
        } else if (opc.equals("subirOrdenPDF")) {
            g = new GsonBuilder().setDateFormat("yyyy-MM-dd'T'HH:mm:ss-05:00").create();
            String numeroOrden = (String) session.getAttribute("numeroOrden");
            session.setAttribute("numeroOrden", null);
            byte[] bytes = (byte[]) session.getAttribute("byteSPDF");
            session.setAttribute("byteSPDF", null);
            String exiteOrden = swOrdenMovilizacion.listarOrdenMovilizacionID(numeroOrden);
            if (exiteOrden.length() > 2) {
                Tbordenesmovilizaciones orden = g.fromJson(exiteOrden, Tbordenesmovilizaciones.class);
                if (orden.getIdpdf() != null) {
                    //actualizar pdf
                    if (bytes != null) {
                        if (bytes.length > 0) {
                            try {
                                String encoded = Base64.getEncoder().encodeToString(bytes);
                                String pdfJSON = new JSONObject()
                                        .put("idpdf", orden.getIdpdf())
                                        .put("archivo", encoded).toString();

                                String jsonPDF = swPDF.modificarPDFID(orden.getIdpdf().toString(), pdfJSON);
                                if (jsonPDF.length() > 2) {
                                    RegistrosM.Insertar(login, orden, "orden pdf actualizado");
                                    session.setAttribute("statusMod", "La orden de movilización se ha actualizado correctamente con el nuevo PDF");
                                    session.setAttribute("statusCodigo", "OK");
                                } else {
                                    session.setAttribute("statusMod", "No ha se ah podido actualizar el pdf de la orden de movilización");
                                    session.setAttribute("statusCodigo", "KO");
                                }
                            } catch (Exception e) {
                                Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en subir el PDF de la orden", e.getClass().getName() + "****" + e.getMessage());
                                System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
                            }
                        } else {
                            session.setAttribute("statusMod", "No ha seleccionado un archivo pdf");
                            session.setAttribute("statusCodigo", "KO");
                        }
                    } else {
                        session.setAttribute("statusMod", "No ha seleccionado un archivo");
                        session.setAttribute("statusCodigo", "KO");
                    }
                } else {
                    //insertar pdf y actualizar orden
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
                                    orden.setIdpdf(obj.getInt("idpdf"));
                                    String rsOrden = swOrdenMovilizacion.modificaOrdenMovilizacionID(orden.getNumeroOrden(), g.toJson(orden));
                                    if (rsOrden.length() > 2) {
                                        session.setAttribute("statusMod", "Se ha subido su archivo pdf...");
                                        session.setAttribute("statusCodigo", "OK");
                                        RegistrosM.Insertar(login, g.fromJson(rsOrden, Tbordenesmovilizaciones.class), "orden pdf insertada");
                                    } else {
                                        session.setAttribute("statusMod", "No se ha podido subir sus archivos");
                                        session.setAttribute("statusCodigo", "KO");
                                    }
                                } else {
                                    session.setAttribute("statusMod", "No ha seleccionado un archivo");
                                    session.setAttribute("statusCodigo", "KO");
                                }
                            } catch (Exception e) {
                                Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en subir el PDF ", e.getClass().getName() + "****" + e.getMessage());
                                System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
                            }
                        } else {
                            session.setAttribute("statusMod", "No ha seleccionado un archivo pdf");
                            session.setAttribute("statusCodigo", "KO");
                        }
                    }
                }
            }
            response.sendRedirect("SalvoConductosControlador.jsp?opc=mostrar&accion=modificarStatus");
        }
    } else {
        response.sendError(501, this.getServletName() + "-> Error no se ha logueado en el sistema contacte con proveedor");
    }
%>
