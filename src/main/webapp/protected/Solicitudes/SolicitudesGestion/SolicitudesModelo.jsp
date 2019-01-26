<%-- 
    Document   : SolicitudesModelo
    Created on : 5/01/2019, 05:55:59 PM
    Author     : Xavy PC
--%>

<%@page import="ugt.entidades.Tbordenesmovilizaciones"%>
<%@page import="ugt.registros.iu.RegistrosIU"%>
<%@page import="ugt.servicios.swRegistros"%>
<%@page import="ugt.registros.iu.RegistrosM"%>
<%@page import="ugt.licencias.IU.LicenciasIU"%>
<%@page import="ugt.entidades.Tblicencias"%>
<%@page import="ugt.servicios.swLicencia"%>
<%@page import="ugt.entidades.Tbconductores"%>
<%@page import="ugt.revisionesmecanicas.iu.RevisionesMecanicasIU"%>
<%@page import="ugt.entidades.Tbrevisionesmecanicas"%>
<%@page import="ugt.servicios.swRevisionesMecanicas"%>
<%@page import="ugt.entidades.Tbvehiculos"%>
<%@page import="ugt.pdf.iu.CombinarPDF"%>
<%@page import="java.util.Base64"%>
<%@page import="ugt.servicios.swPDF"%>
<%@page import="org.json.JSONObject"%>
<%@page import="ugt.entidades.Tbdisponibilidadvc"%>
<%@page import="ugt.servicios.swDisponibilidadVC"%>
<%@page import="ugt.vehiculos.iu.VehiculosIU"%>
<%@page import="ugt.gruposvehiculos.iu.GruposVehiculosIU"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="ugt.entidades.Tbsolicitudes"%>
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
            String arrayJSON = swSolicitudes.filtrarSolicitudesEnviadaAsignada();
            if (arrayJSON.length() > 2) {
                session.setAttribute("arrayJSON", arrayJSON);
                response.sendRedirect("SolicitudesControlador.jsp?opc=mostrar&accion=" + opc);
            } else {
                response.sendRedirect("SolicitudesControlador.jsp?opc=mostrar&accion=jsonVacio");
            }
        } else if (opc.equals("jsonSolicitudesProcesadas")) {
            String estado = "enviado";
            session.setAttribute("estadoSolicitudes", null);
            String arrayJSON = swSolicitudes.filtrarSolicitudesNoEstado(estado);
            if (arrayJSON.length() > 2) {
                session.setAttribute("arrayJSON", arrayJSON);
                response.sendRedirect("SolicitudesControlador.jsp?opc=mostrar&accion=arrayJSON");
            } else {
                response.sendRedirect("SolicitudesControlador.jsp?opc=mostrar&accion=jsonVacio");
            }
        } else if (opc.equals("modificarSolicitud")) {
            new GsonBuilder().setDateFormat("yyyy-MM-dd'T'HH:mm:ss-05:00").create();
            String idSolicitud = (String) session.getAttribute("idSolicitud");
            String jsonsSolicitud = (String) session.getAttribute("jsonSolicitud");
            session.setAttribute("idSolicitud", null);
            session.setAttribute("jsonSolicitud", null);
            String jsonMod = swSolicitudes.modificarSolicitudID(idSolicitud, jsonsSolicitud);
            if (jsonMod.length() > 2) {
                session.setAttribute("statusMod", "Se ha actualizado los datos");
                session.setAttribute("statusCodigo", "OK");
                Tbsolicitudes sol = g.fromJson(jsonMod, Tbsolicitudes.class);
                RegistrosM.Insertar(login, sol, sol.getEstado() + " " + opc);
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
        } else if (opc.equals("filtrarGrupoAuto")) {
            String idgrupov = (String) session.getAttribute("idgrupov");
            session.setAttribute("idgrupov", null);
            String arrayJSON = "";
            if (idgrupov.equals("0")) {
                arrayJSON = swVehiculoConductor.VehiculosDependenciasNullorNot();
            } else {
                arrayJSON = swVehiculoConductor.filtrarVehiculosConductoresGrupo(idgrupov);
            }
            if (arrayJSON.length() > 2) {
                VehiculosConductoresIU listaV_C = new VehiculosConductoresIU();
                listaV_C.setListaJSON(arrayJSON);
                session.setAttribute("filtroV_C", listaV_C);
            }
            response.sendRedirect("SolicitudesControlador.jsp?opc=mostrar&accion=" + opc);
        } else if (opc.equals("fechaRecividoSol")) {
            g = new GsonBuilder().setDateFormat("yyyy-MM-dd'T'HH:mm:ss-05:00").create();
            String json = (String) session.getAttribute("solicitudRecib");
            session.setAttribute("solicitudRecib", null);
            Tbsolicitudes solActualizar = g.fromJson(json, Tbsolicitudes.class);

            Calendar today = Calendar.getInstance();
            SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd'T'00:00:00-05:00");
            Date date = sf.parse(sf.format(today.getTime()));

            solActualizar.setFecha(date);

            String jsonObject = swSolicitudes.modificarSolicitudID(solActualizar.getNumero().toString(), g.toJson(solActualizar));
            if (jsonObject.length() > 2) {
                session.setAttribute("statusGuardar", "Fecha solicitud actualizado");
                session.setAttribute("statusCodigo", "OK");
                RegistrosM.Insertar(login, solActualizar, "Fecha recibido");
            } else {
                session.setAttribute("statusGuardar", "ERROR NO SE HA PODIDO actualizar la fecha de la solicitud");
                session.setAttribute("statusCodigo", "KO");
            }
            response.sendRedirect("SolicitudesControlador.jsp?opc=mostrar&accion=guardarStatus");
        } else if (opc.equals("vistoBuenoSol")) {
            g = new GsonBuilder().setDateFormat("yyyy-MM-dd'T'HH:mm:ss-05:00").create();
            String json = (String) session.getAttribute("solicitudRecib");
            session.setAttribute("solicitudRecib", null);
            Tbsolicitudes solActualizar = g.fromJson(json, Tbsolicitudes.class);
            solActualizar.setEstado("aprobadaUGT");

//            String ojbExiste = swDisponibilidadVC.getDisponibilidadVCSolicitud(solActualizar.getNumero().toString());
//            if (ojbExiste.length() > 2) {
            String jsonObject = swSolicitudes.modificarSolicitudID(solActualizar.getNumero().toString(), g.toJson(solActualizar));
            if (jsonObject.length() > 2) {
                RegistrosM.Insertar(login, solActualizar, solActualizar.getEstado());
                session.setAttribute("statusGuardar", "Solicitud enviada a Vicerrectorado Administrativo");
                session.setAttribute("statusCodigo", "OK");
            } else {
                session.setAttribute("statusGuardar", "ERROR NO SE HA PODIDO enviar la solicitud");
                session.setAttribute("statusCodigo", "KO");
            }
//            } else {
//                session.setAttribute("statusGuardar", "No se ha asignado un vehiculo ni conductor a la solicitud");
//                session.setAttribute("statusCodigo", "KO");
//            }
            response.sendRedirect("SolicitudesControlador.jsp?opc=mostrar&accion=guardarStatus");
        } else if (opc.equals("modificarSolicitud")) {
            String jsonSolicitud = (String) session.getAttribute("jsonSolicitud");
            String idSolicitud = (String) session.getAttribute("idSolicitud");
            session.setAttribute("jsonSolicitud", null);
            session.setAttribute("idSolicitud", null);
            String jsonObject = swSolicitudes.modificarSolicitudID(idSolicitud, jsonSolicitud);
            if (jsonObject.length() > 2) {
                session.setAttribute("statusGuardar", "Solicitud actualzido");
                session.setAttribute("statusCodigo", "OK");
            } else {
                session.setAttribute("statusGuardar", "ERROR NO SE HA PODIDO actualizar la solicitud");
                session.setAttribute("statusCodigo", "KO");
            }
            response.sendRedirect("SolicitudesControlador.jsp?opc=mostrar&accion=guardarStatus");
        } else if (opc.equals("addDisponivilidadVC")) {
            g = new GsonBuilder().setDateFormat("yyyy-MM-dd'T'HH:mm:ss-05:00").create();
            String jsonDisponVC = (String) session.getAttribute("jsonDisponVC");
            String jsonSolicitud = (String) session.getAttribute("jsonSolicitud");
            session.setAttribute("jsonDisponVC", null);
            session.setAttribute("jsonSolicitud", null);
            Tbsolicitudes solActualizar = g.fromJson(jsonSolicitud, Tbsolicitudes.class);

            String jsonObject = "";
            //preguntamos i ya existe una disponibilidad con un id de solicitud
            String objJSONDisponibilidad = swDisponibilidadVC.getDisponibilidadVCSolicitud(solActualizar.getNumero().toString());
            if (objJSONDisponibilidad.length() > 2) { // Si existe actualizamos
                //convertimos disponibilidad de la base a clase
                Tbdisponibilidadvc disponVC = g.fromJson(objJSONDisponibilidad, Tbdisponibilidadvc.class);
                //convertimos la disponibilidad nuevva a un objetojson
                JSONObject objNuevo = new JSONObject(jsonDisponVC);
                //insertamos el id antguo en la nueva disponiblidad
                objNuevo.append("iddisponibilidad", disponVC.getIddisponibilidad());
                //actualizamos la nueva disponiblidad con id del anterior
                jsonObject = swDisponibilidadVC.modificarDisponibilidadVCID(disponVC.getIddisponibilidad().toString(), objNuevo.toString());
            } else {//si no insertamos la disponibilidad nueva
                jsonObject = swDisponibilidadVC.insertDisponibilidadVC(jsonDisponVC);
            }
            String respuesta = "";
            if (jsonObject.length() > 2) {
                session.setAttribute("statusCodigo", "OK");
                solActualizar.setEstado("asignada");
                jsonObject = swSolicitudes.modificarSolicitudID(solActualizar.getNumero().toString(), g.toJson(solActualizar));
                if (jsonObject.length() > 2) {
                    session.setAttribute("statusCodigo", "OK");
                    RegistrosM.Insertar(login, solActualizar, solActualizar.getEstado() + " VC");
                } else {
                    respuesta += "Error al momento de actualizar estado solicitud " + solActualizar.getNumero();
                    session.setAttribute("statusCodigo", "KO");
                }
            } else {
                respuesta += "Error al momento de asignar el vehículo-conductor";
                session.setAttribute("statusCodigo", "KO");
            }
            if (respuesta.length() > 5) {
                session.setAttribute("statusGuardar", respuesta);
            } else {
                session.setAttribute("statusGuardar", "Solicitud procesada, ahora puede aprobar la solicitud para enviarlo a Vicerrectorado Administrativo");
            }
            response.sendRedirect("SolicitudesControlador.jsp?opc=mostrar&accion=guardarStatus");
        } else if (opc.equals("addOnlyDisponivilidadVC")) {
            g = new GsonBuilder().setDateFormat("yyyy-MM-dd'T'HH:mm:ss-05:00").create();
            String jsonDisponVC = (String) session.getAttribute("jsonDisponVC");
            String jsonSolicitud = (String) session.getAttribute("jsonSolicitud");
            session.setAttribute("jsonDisponVC", null);
            session.setAttribute("jsonSolicitud", null);
            Tbsolicitudes solActualizar = g.fromJson(jsonSolicitud, Tbsolicitudes.class);

            String jsonObject = "";
            //preguntamos i ya existe una disponibilidad con un id de solicitud
            String objJSONDisponibilidad = swDisponibilidadVC.getDisponibilidadVCSolicitud(solActualizar.getNumero().toString());
            if (objJSONDisponibilidad.length() > 2) { // Si existe actualizamos
                //convertimos disponibilidad de la base a clase
                Tbdisponibilidadvc disponVC = g.fromJson(objJSONDisponibilidad, Tbdisponibilidadvc.class);
                //convertimos la disponibilidad nuevva a un objetojson
                JSONObject objNuevo = new JSONObject(jsonDisponVC);
                //insertamos el id antguo en la nueva disponiblidad
                objNuevo.append("iddisponibilidad", disponVC.getIddisponibilidad());
                //actualizamos la nueva disponiblidad con id del anterior
                jsonObject = swDisponibilidadVC.modificarDisponibilidadVCID(disponVC.getIddisponibilidad().toString(), objNuevo.toString());
            } else {//si no insertamos la disponibilidad nueva
                jsonObject = swDisponibilidadVC.insertDisponibilidadVC(jsonDisponVC);
            }
            String respuesta = "";
            if (jsonObject.length() > 2) {
                session.setAttribute("statusCodigo", "OK");
                RegistrosM.Insertar(login, solActualizar, "asignar VC");
            } else {
                respuesta += "Error al momento de asignar el vehículo-conductor";
                session.setAttribute("statusCodigo", "KO");
            }
            if (respuesta.length() > 5) {
                session.setAttribute("statusGuardar", respuesta);
            } else {
                session.setAttribute("statusGuardar", "Solicitud procesada, se ha asignado correctamente el vehículo conductor");
            }
            response.sendRedirect("SolicitudesControlador.jsp?opc=mostrar&accion=guardarStatus");
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
                ConductoresIU listaConductores = new ConductoresIU();
                listaConductores.setListaJSON(arrayJSONConductores);
                session.setAttribute("listaConductores", listaConductores);
            }
            String arrayJSONTipoVehiculo = swVehiculo.listarGrupoVehiculo();
            if (arrayJSONTipoVehiculo.length() > 2) {
                GruposVehiculosIU grupovehiculo = new GruposVehiculosIU();
                grupovehiculo.setListaJSON(arrayJSONTipoVehiculo);
                session.setAttribute("grupovehiculo", grupovehiculo);
            }
            response.sendRedirect("SolicitudesControlador.jsp?opc=mostrar&accion=" + opc);
        } else if (opc.equals("combinarPDFs")) {
            g = new GsonBuilder().setDateFormat("yyyy-MM-dd'T'HH:mm:ss-05:00").create();
            byte[] bytesCombinarPDF = (byte[]) session.getAttribute("bytesCombinarPDF");
            String jsonSolicitud = (String) session.getAttribute("jsonSolicitud");
            Tbsolicitudes solicitu = g.fromJson(jsonSolicitud, Tbsolicitudes.class);
            String pdf = (solicitu.getIdpdf() != null) ? swPDF.listarPDFID(solicitu.getIdpdf().toString()) : "";
            if (pdf.length() > 2) {
                JSONObject obj = new JSONObject(pdf);
                String pdf64 = obj.getString("archivo");
                byte[] bytesBase = Base64.getDecoder().decode(pdf64);
                CombinarPDF combinarPDF = new CombinarPDF();
                byte[] combinado = combinarPDF.combinarPDFs(bytesBase, bytesCombinarPDF).toByteArray();
                if (combinado != null) {
                    String b64Combinado = Base64.getEncoder().encodeToString(combinado);
                    obj = new JSONObject()
                            .put("idpdf", solicitu.getIdpdf().toString())
                            .put("archivo", b64Combinado);
                    if (swPDF.modificarPDFID(solicitu.getIdpdf().toString(), obj.toString()).length() > 2) {
                        RegistrosM.Insertar(login, solicitu, solicitu.getEstado() + " requisitos " + opc);
                        session.setAttribute("statusCodigo", "OK");
                        session.setAttribute("statusGuardar", "Se ha combinado exitosamente, ahora puede descargarlo en el icono de requisitos");
                    } else {
                        session.setAttribute("statusCodigo", "KO");
                        session.setAttribute("statusGuardar", "Se ha producido un error al momento subir el archivo pdfcombinado");
                    }
                } else {
                    session.setAttribute("statusCodigo", "KO");
                    session.setAttribute("statusGuardar", "Se ha producido un error al momento de combinar el archivo pdf");
                }
            } else {
                String b64PDF = (bytesCombinarPDF != null) ? Base64.getEncoder().encodeToString(bytesCombinarPDF) : "";
                if (b64PDF.length() > 0) {
                    JSONObject objJSON = new JSONObject()
                            .put("idpdf", "0")
                            .put("archivo", b64PDF);
                    String pdfInsert = swPDF.insertPDF(objJSON.toString());
                    if (pdfInsert.length() > 2) {
                        objJSON = new JSONObject(pdfInsert);
                        solicitu.setIdpdf(objJSON.getInt("idpdf"));
                        swSolicitudes.modificarSolicitudID(solicitu.getNumero().toString(), g.toJson(solicitu));
                        session.setAttribute("statusCodigo", "OK");
                        session.setAttribute("statusGuardar", "Se ha combinado el PDF, ahora puede descargarlo en el icono de requerimientos");
                    } else {
                        session.setAttribute("statusCodigo", "KO");
                        session.setAttribute("statusGuardar", "Error al intentar insertar un PDF a una solicitud sin requerimientos");
                    }
                } else {
                    session.setAttribute("statusCodigo", "KO");
                    session.setAttribute("statusGuardar", "No ha subido un archivo");
                }
            }
            response.sendRedirect("SolicitudesControlador.jsp?opc=mostrar&accion=guardarStatus");
        } else if (opc.equals("modDatosVehiculoDVC")) {
            g = new GsonBuilder().setDateFormat("yyyy-MM-dd'T'HH:mm:ss-05:00").create();
            String json = (String) session.getAttribute("jsonVehiculo");
            session.setAttribute("jsonVehiculo", null);
            Tbvehiculos vehiculoAux = g.fromJson(json, Tbvehiculos.class);
            if (vehiculoAux != null) {
                session.setAttribute("vehiculoDVC", vehiculoAux);
            }
            String objJSON = swRevisionesMecanicas.filtrarXSolicitud(vehiculoAux.getPlaca());
            if (objJSON.length() > 2) {
                RevisionesMecanicasIU revisiones = new RevisionesMecanicasIU();
                revisiones.setListaJSON(objJSON);
                session.setAttribute("revisionmecanicaDVC", revisiones.itemPos(0));
            }
            response.sendRedirect("SolicitudesControlador.jsp?opc=mostrar&accion=" + opc);
        } else if (opc.equals("modDatosConductorDVC")) {
            g = new GsonBuilder().setDateFormat("yyyy-MM-dd'T'HH:mm:ss-05:00").create();
            String json = (String) session.getAttribute("jsonConductor");
            session.setAttribute("jsonVehiculo", null);
            Tbconductores conductorAux = g.fromJson(json, Tbconductores.class);
            if (conductorAux != null) {
                session.setAttribute("conductorDVC", conductorAux);
            }
            String objJSON = swLicencia.licenciaID(conductorAux.getCedula());
            if (objJSON.length() > 2) {
                LicenciasIU licencias = new LicenciasIU();
                licencias.setListaJSON(objJSON);
                session.setAttribute("licenciaDVC", licencias.itemPos(0));
            }
            response.sendRedirect("SolicitudesControlador.jsp?opc=mostrar&accion=" + opc);
        } else if (opc.equals("modRegDocsSol")) {
            g = new GsonBuilder().setDateFormat("yyyy-MM-dd'T'HH:mm:ss-05:00").create();
            String json = (String) session.getAttribute("jsonSolicitud");
            session.setAttribute("jsonSolicitud", null);
            Tbsolicitudes sol = g.fromJson(json, Tbsolicitudes.class);
            String objJSON = swRegistros.filtarRegistroDocFDesc(sol.getClass().getSimpleName(), sol.getNumero().toString());
            if (objJSON.length() > 2) {
                RegistrosIU registros = new RegistrosIU();
                registros.setListaJSON(objJSON);
                session.setAttribute("registros", registros);
            }
            response.sendRedirect("SolicitudesControlador.jsp?opc=mostrar&accion=" + opc);
        } else if (opc.equals("modRegDocsOrden")) {
            g = new GsonBuilder().setDateFormat("yyyy-MM-dd'T'HH:mm:ss-05:00").create();
            String json = (String) session.getAttribute("jsonOrden");
            session.setAttribute("jsonSolicitud", null);
            Tbordenesmovilizaciones orden = g.fromJson(json, Tbordenesmovilizaciones.class);
            String objJSON = swRegistros.filtarRegistroDocFDesc(orden.getClass().getSimpleName(), orden.getNumeroOrden());
            if (objJSON.length() > 2) {
                RegistrosIU registros = new RegistrosIU();
                registros.setListaJSON(objJSON);
                session.setAttribute("registros", registros);
            }
            response.sendRedirect("SolicitudesControlador.jsp?opc=mostrar&accion=modRegDocsSol" );
        }
    } else {
        response.sendError(501, this.getServletName() + "-> Error no se ha logueado en el sistema contacte con proveedor");
    }
%>
