<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="ugt.entidades.Tbvehiculosdependencias"%>
<%@page import="ugt.vehiculosdependencias.iu.VehiculosDependenciasIU"%>
<%@page import="ugt.servicios.swVehiculoDependencia"%>
<%@page import="ugt.entidades.iu.EntidadesIU"%>
<%@page import="ugt.servicios.swEntidad"%>
<%@page import="java.util.logging.Level"%>
<%@page import="java.util.logging.Logger"%>
<%@page import="ugt.servicios.swPDF"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.util.Base64"%>
<%@page import="ugt.entidades.Tbrevisionesmecanicas"%>
<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="ugt.servicios.swRevisionesMecanicas"%>
<%@page import="ugt.vehiculosconductores.iu.VehiculosConductoresIU"%>
<%@page import="ugt.servicios.swVehiculoConductor"%>
<%@page import="ugt.entidades.Tbvehiculos"%>
<%@page import="ugt.entidades.Tbgrupovehiculos"%>
<%@page import="ugt.gruposvehiculos.iu.GruposVehiculosIU"%>
<%@page import="ugt.vehiculos.iu.VehiculoIU"%>
<%@page import="ugt.vehiculos.iu.VehiculosIU"%>
<%@page import="ugt.servicios.swVehiculo"%>
<%@page import="utg.login.Login"%>
<%@page import="com.google.gson.Gson"%>
<%
    Login login = (Login) session.getAttribute("login");
    if (login != null) {
        String opc = request.getParameter("opc");
        Gson g = new Gson();
        if (opc.equals("jsonVehiculos")) { //cargar los vehiculos
            String arrayJSON = swVehiculo.listarVehiculosXEstado("Disponible");
            if (arrayJSON.length() > 2) {
                session.setAttribute("arrayJSON", arrayJSON);
                response.sendRedirect("vehiculoControlador.jsp?opc=mostrar&accion=" + opc);
            } else {
                response.sendRedirect("../../vista.jsp?accion=jsonVacio");

            }
        } else if (opc.equals("jsonVehiculosOcup")) {
            String arrayJSON = swVehiculo.listarVehiculosXEstado("Ocupado");
            if (arrayJSON.length() > 2) {
                session.setAttribute("arrayJSON", arrayJSON);
                response.sendRedirect("vehiculoControlador.jsp?opc=mostrar&accion=jsonVehiculos");
            } else {
                response.sendRedirect("../../vista.jsp?accion=jsonVacio");

            }
        } else if (opc.equals("jsonVehiculosUnlock")) {
            String arrayJSON = swVehiculo.listarVehiculosXEstado("Rematado");
            if (arrayJSON.length() > 2) {
                session.setAttribute("arrayJSON", arrayJSON);
                response.sendRedirect("vehiculoControlador.jsp?opc=mostrar&accion=jsonVehiculos");
            } else {
                response.sendRedirect("../../vista.jsp?accion=jsonVacio");

            }
        } else if (opc.equals("saveVehiculo")) {
            String jsonVehiculo = (String) session.getAttribute("jsonVehiculo");
            String placa = (String) session.getAttribute("placa");
            session.setAttribute("jsonVehiculo", null);
            session.setAttribute("placa", null);
            String existe = swVehiculo.listarVehiculoID(placa);
            if (existe.length() <= 2) {
                String arrayJSON = swVehiculo.insertVehiculo(jsonVehiculo);
                if (arrayJSON.length() > 2) {
                    session.setAttribute("statusGuardar", "Se ha guardado Correctamente");
                    session.setAttribute("statusCodigo", "OK");
                } else {
                    session.setAttribute("statusGuardar", "ERROR NO SE HA PODIDO GUARDAR El Vehiculo!-> Contacte con el proveedor");
                    session.setAttribute("statusCodigo", "KO");
                }
            } else {
                session.setAttribute("statusGuardar", "Ya existe un vehiculo con esa placa");
                session.setAttribute("statusCodigo", "KO");
            }
            response.sendRedirect("vehiculoControlador.jsp?opc=mostrar&accion=guardarStatus");
        } else if (opc.equals("eliminarVehiculo")) {
            String placa = (String) session.getAttribute("placa");
            String json = (String) session.getAttribute("json");
            String nombreGrupo = (String) session.getAttribute("nombreGrupo");
            session.setAttribute("json", null);
            session.setAttribute("placa", null);
            session.setAttribute("nombreGrupo", nombreGrupo);
            String listaGrupo = swVehiculo.listarGrupoVehiculo();
            if (listaGrupo.length() > 2) {
                GruposVehiculosIU grupoVehiculosIU = new GruposVehiculosIU();
                grupoVehiculosIU.setListaJSON(listaGrupo);
                Tbgrupovehiculos search = new Tbgrupovehiculos();
                for (Tbgrupovehiculos grupo : grupoVehiculosIU.getLista()) {
                    if (grupo.getNombre().equals(nombreGrupo)) {
                        search = grupo;
                        break;
                    }
                }
                VehiculoIU vehiculo = g.fromJson(json, VehiculoIU.class);
                vehiculo.setEstado("Rematado");
                vehiculo.setIdgrupo(search);
                String arrayJSON = swVehiculo.bloquearVehiculo(g.toJson(vehiculo), placa);
                if (arrayJSON.length() > 2) {
                    session.setAttribute("statusEliminar", "OK");
                } else {
                    session.setAttribute("statusEliminar", "KO");
                }
            } else {
                session.setAttribute("statusEliminar", "KO");
            }
            response.sendRedirect("vehiculoControlador.jsp?opc=mostrar&accion=eliminarStatus");
        } else if (opc.equals("eliminarRevision")) {
            g = new GsonBuilder().setDateFormat("yyyy-MM-dd'T'HH:mm:ss-05:00").create();
            String idrevision = (String) session.getAttribute("idrevision");
            session.setAttribute("idrevision", null);
            String objRevision = swRevisionesMecanicas.listarRevisionMecanicaID(idrevision);
            String objJSON = swRevisionesMecanicas.eliminarRevisionMecanica(idrevision);
            if (objJSON.equals("200") || objJSON.equals("204") || objJSON.equals("202")) {
                Tbrevisionesmecanicas revDel = g.fromJson(objRevision, Tbrevisionesmecanicas.class);
                if (revDel.getIdpdf() != null) {
                    swPDF.eliminarPDF(revDel.getIdpdf().toString());
                }
                session.setAttribute("statusEliminar", "OK");
            } else {
                session.setAttribute("statusEliminar", "KO");
            }
            response.sendRedirect("vehiculoControlador.jsp?opc=mostrar&accion=eliminarStatus");
        } else if (opc.equals("downloadPDFOrden")) {
            g = new Gson();
            String idPDFRevision = (String) session.getAttribute("idPDFRevision");
            session.setAttribute("idPDFRevision", null);
            String objJSON = swPDF.listarPDFID(idPDFRevision);
            if (objJSON.length() > 2) {
                JSONObject obj = new JSONObject(objJSON);
                String pdf64 = obj.getString("archivo");
                if (pdf64.length() > 2) {
                    byte[] bytes = Base64.getDecoder().decode(pdf64);
                    session.setAttribute("pdf64", Base64.getEncoder().encodeToString(bytes));
                }
            }
            response.sendRedirect("vehiculoControlador.jsp?opc=mostrar&accion=" + opc);
        } else if (opc.equals("modificarVehiculo")) {
            String placa = (String) session.getAttribute("placa");
            String jsonVehiculo = (String) session.getAttribute("jsonVehiculo");
            String idgrupo = (String) session.getAttribute("idgrupo");
            session.setAttribute("placa", null);
            session.setAttribute("jsonVehiculo", null);
            session.setAttribute("idgrupo", null);
            String listaGrupo = swVehiculo.listarGrupoVehiculoID(idgrupo);
            if (listaGrupo.length() > 2) {
                Tbgrupovehiculos grupo = g.fromJson(listaGrupo, Tbgrupovehiculos.class);
                Tbvehiculos vehiculo = g.fromJson(jsonVehiculo, Tbvehiculos.class);
                vehiculo.setIdgrupo(grupo);
                String jsonMod = swVehiculo.modificarVehiculo(placa, g.toJson(vehiculo));
                if (jsonMod.length() > 2) {
                    session.setAttribute("statusMod", "OK");
                } else {
                    session.setAttribute("statusMod", "KO");
                }
            } else {
                session.setAttribute("statusEliminar", "KO");
            }
            response.sendRedirect("vehiculoControlador.jsp?opc=mostrar&accion=modificarStatus");
        } else if (opc.equals("tableVehiculos")) {
            String arrayJSON = swVehiculo.listarGrupoVehiculo();
            if (arrayJSON.length() > 2) {
                GruposVehiculosIU grupoVehiculosIU = new GruposVehiculosIU();
                grupoVehiculosIU.setListaJSON(arrayJSON);
                session.setAttribute("grupoVehiculosIU", grupoVehiculosIU);
                response.sendRedirect("vehiculoControlador.jsp?opc=mostrar&accion=" + opc);
            }
        } else if (opc.equals("contentModalVerCond")) {
            String placa = (String) session.getAttribute("placa");
            String arrayJSON = swVehiculoConductor.listarVehiculoConductorPlaca(placa);
            if (arrayJSON.length() > 2) {
                VehiculosConductoresIU vehiculosConductoresIU = new VehiculosConductoresIU();
                vehiculosConductoresIU.setListaJSON(arrayJSON);
                session.setAttribute("vehiculosConductoresIU", vehiculosConductoresIU);
            }
            response.sendRedirect("vehiculoControlador.jsp?opc=mostrar&accion=contentModalVerCond");
        } else if (opc.equals("jsonRevisionMecanica")) {
            String placa = (String) session.getAttribute("matricula");
            session.setAttribute("matricula", null);
            String arrayJSON = swRevisionesMecanicas.filtrarXSolicitud(placa);
            if (arrayJSON.length() > 2) {
                session.setAttribute("arrayJSON", arrayJSON);
                response.sendRedirect("vehiculoControlador.jsp?opc=mostrar&accion=jsonVehiculos");
            } else {
                response.sendRedirect("../../vista.jsp?accion=jsonVacio");

            }
        } else if (opc.equals("modDependencia")) {
            String arrayEntidades = swEntidad.listarEntidadesSinVehiculo();
            if (arrayEntidades.length() > 2) {
                EntidadesIU entidadesIU = new EntidadesIU();
                entidadesIU.setListaJSON(arrayEntidades);
                session.setAttribute("entidadesRM", entidadesIU);
            }
            response.sendRedirect("vehiculoControlador.jsp?opc=mostrar&accion=" + opc);
        } else if (opc.equals("divModalVerVehiculoEntida")) {
            String placaVD = (String) session.getAttribute("placaVD");
            session.setAttribute("placaVD", null);
            String arrayJSON = swVehiculoDependencia.listarVehiculosDependenciasPlaca(placaVD);
            if (arrayJSON.length() > 2) {
                VehiculosDependenciasIU vehiculoDependencia = new VehiculosDependenciasIU();
                vehiculoDependencia.setListaJson(arrayJSON);
                session.setAttribute("vehiculoDependencia", vehiculoDependencia);
            }
            response.sendRedirect("vehiculoControlador.jsp?opc=mostrar&accion=" + opc);
        } else if (opc.equals("savedependencia")) {
            g = new GsonBuilder().setDateFormat("yyyy-MM-dd'T'HH:mm:ss-05:00").create();
            String jsonvehdep = (String) session.getAttribute("jsonvehdep");
            session.setAttribute("jsonvehdep", null);
            String placaD = (String) session.getAttribute("placaD");
            session.setAttribute("placaD", null);
            Tbvehiculosdependencias vehDep = g.fromJson(jsonvehdep, Tbvehiculosdependencias.class);
            String objJSONVEH = swVehiculoDependencia.listarVehiculosDependenciasPE(placaD, String.valueOf(vehDep.getTbvehiculosdependenciasPK().getIddependencia()));
            if (objJSONVEH.length() <= 2) {
                objJSONVEH = swVehiculo.listarVehiculoID(placaD);
                if (objJSONVEH.length() > 2) {
                    Tbvehiculos vehAux = g.fromJson(objJSONVEH, Tbvehiculos.class);
                    vehDep.setTbvehiculos(vehAux);
                    vehDep.getTbvehiculosdependenciasPK().setMatricula(vehAux.getPlaca());
                    String resp = swVehiculoDependencia.insertVehiculoDependencia(g.toJson(vehDep));
                    if (resp.length() > 2) {
                        session.setAttribute("statusGuardar", "Se ha asignado correctamente la dependencia");
                        session.setAttribute("statusCodigo", "OK");
                    } else {
                        session.setAttribute("statusGuardar", "Error no se ha podido asignar la dependencia");
                        session.setAttribute("statusCodigo", "KO");
                    }
                } else {
                    session.setAttribute("statusGuardar", "Error al momento de elegir de vehiculos");
                    session.setAttribute("statusCodigo", "KO");
                }
            } else {
                session.setAttribute("statusGuardar", "El vehiculo ya esta asignado a " + vehDep.getTbentidad().getCodigoentidad());
                session.setAttribute("statusCodigo", "KO");
            }
            response.sendRedirect("vehiculoControlador.jsp?opc=mostrar&accion=guardarStatus");
        } else if (opc.equals("modificardependencia")) {
            g = new GsonBuilder().setDateFormat("yyyy-MM-dd'T'HH:mm:ss-05:00").create();
            String jsonvehdep = (String) session.getAttribute("jsonvehdep");
            session.setAttribute("jsonvehdep", null);
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss-05:00");
            Tbvehiculosdependencias vehiculoDependencia = g.fromJson(jsonvehdep, Tbvehiculosdependencias.class);
            Calendar today = Calendar.getInstance();
            Date fechafinal = sdf.parse(sdf.format(today.getTime()));
            vehiculoDependencia.setFechafin(fechafinal);
            String objJSON = swVehiculoDependencia.modificarVehiculoDependenciaIDs(String.valueOf(vehiculoDependencia.getTbvehiculosdependenciasPK().getIddependencia()),
                    vehiculoDependencia.getTbvehiculosdependenciasPK().getMatricula(),
                    sdf.format(vehiculoDependencia.getTbvehiculosdependenciasPK().getFechainicio()),
                    g.toJson(vehiculoDependencia));
            if (objJSON.length() > 2) {
                session.setAttribute("statusGuardar", "Se ha finalizado la vinculación con la dependencia");
                session.setAttribute("statusCodigo", "OK");
            } else {
                session.setAttribute("statusGuardar", "Error al momento de finalizar el vínculo con la depenencia");
                session.setAttribute("statusCodigo", "KO");
            }
            response.sendRedirect("vehiculoControlador.jsp?opc=mostrar&accion=guardarStatus");
        } else if (opc.equals("eliminardependencia")) {
            String jsonvehdep = (String) session.getAttribute("jsonvehdep");
            session.setAttribute("jsonvehdep", null);
            String objJSON = swVehiculoDependencia.eliminarVehiculoDependencia(jsonvehdep);
            String result = "";
            if (objJSON.equals("OK")) {
                result += " Se ha eliminado correctamente ";
                session.setAttribute("statusCodigo", "OK");
            } else {
                result += " No se ha podido eliminar a la dependencia ";
                session.setAttribute("statusCodigo", "KO");
            }
            session.setAttribute("statusGuardar", result);
            response.sendRedirect("vehiculoControlador.jsp?opc=mostrar&accion=guardarStatus");
        } else if (opc.equals("addRevisionM")) {
            g = new GsonBuilder().setDateFormat("yyyy-MM-dd'T'HH:mm:ss-05:00").create();
            String placa = (String) session.getAttribute("placaRM");
            session.setAttribute("placaRM", null);
            String jsonRevisionM = (String) session.getAttribute("jsonRevisionM");
            session.setAttribute("jsonRevisionM", null);
            byte[] bytes = (byte[]) session.getAttribute("bytesPDF");
            session.setAttribute("bytesPDF", null);
            String objJSONVehiculo = swVehiculo.listarVehiculoID(placa);
            if (objJSONVehiculo.length() > 2) {
                Tbvehiculos vehiculoAux = g.fromJson(objJSONVehiculo, Tbvehiculos.class);
                Tbrevisionesmecanicas addRevision = g.fromJson(jsonRevisionM, Tbrevisionesmecanicas.class);
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
                                addRevision.setIdpdf(obj.getInt("idpdf"));
                                addRevision.setIdrevision(0);
                                addRevision.setMatricula(vehiculoAux);
                                if (swRevisionesMecanicas.insertRevisionMecanica(g.toJson(addRevision)).length() > 2) {
                                    session.setAttribute("statusGuardar", "Se ha ingresado la revisión mecánica");
                                    session.setAttribute("statusCodigo", "OK");
                                } else {
                                    session.setAttribute("statusGuardar", "No se ha podido ingresado la revisión mecánica");
                                    session.setAttribute("statusCodigo", "KO");
                                }
                            } else {
                                session.setAttribute("statusGuardar", "Error no se ha subido su PDF a la base de datos");
                                session.setAttribute("statusCodigo", "KO");
                            }
                        } catch (Exception e) {
                            session.setAttribute("statusGuardar", "Ha ocurrido un error al momento de subir al servidor modelo");
                            session.setAttribute("statusCodigo", "KO");
                            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en subir el PDF revision mecanica", e.getClass().getName() + "****" + e.getMessage());
                            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
                        }
                    } else {
                        session.setAttribute("statusGuardar", "No ha seleccionado un archivo PDF");
                        session.setAttribute("statusCodigo", "KO");
                    }
                } else {
                    session.setAttribute("statusGuardar", "No ha seleccionado un archivo PDF");
                    session.setAttribute("statusCodigo", "KO");
                }
            }
            response.sendRedirect("vehiculoControlador.jsp?opc=mostrar&accion=guardarStatus");
        }
    } else {
        response.sendError(501, this.getServletName() + "-> Error no se ha logueado en el sistema contacte con proveedor");
    }
%>
