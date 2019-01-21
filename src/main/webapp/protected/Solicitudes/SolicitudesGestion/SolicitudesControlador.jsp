<%-- 
    Document   : SolicitudesControlador
    Created on : 5/01/2019, 05:56:20 PM
    Author     : Xavy PC
--%>

<%@page import="org.apache.commons.fileupload.FileUploadException"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="org.apache.commons.io.IOUtils"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="utg.login.Login"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Login login = (Login) session.getAttribute("login");
    if (login != null) {
        String opc = request.getParameter("opc");
        if (opc != null) {
            if (opc.equals("mostrar")) {
                String accion = request.getParameter("accion");
                response.sendRedirect("SolicitudesVista.jsp?accion=" + accion);
            } else if (opc.equals("jsonSolicitudesEnviados")) {
                response.sendRedirect("SolicitudesModelo.jsp?opc=" + opc);
            } else if (opc.equals("jsonSolicitudesProcesadas")) {
                response.sendRedirect("SolicitudesModelo.jsp?opc=" + opc);
            } else if (opc.equals("modSolicitanteInfo")) {
                String cedula = request.getParameter("cedulaSolicitante");
                String idSolicitud = request.getParameter("idSolicitud");
                session.setAttribute("cedulaSolicitante", cedula);
                session.setAttribute("idSolicitud", idSolicitud);
                response.sendRedirect("SolicitudesModelo.jsp?opc=" + opc);
            } else if (opc.equals("disponibilidadVehiculoConductor")) {
                String cedula = request.getParameter("cedulaSolicitante");
                session.setAttribute("cedulaSolicitante", cedula);
                response.sendRedirect("SolicitudesModelo.jsp?opc=" + opc);
            } else if (opc.equals("AgendaVehiculo")) {
                String placaAgenda = request.getParameter("placaAgenda");
                session.setAttribute("placaAgenda", placaAgenda);
                response.sendRedirect("SolicitudesModelo.jsp?opc=" + opc);
            } else if (opc.equals("fechaRecividoSol")) {
                String json = request.getParameter("solicitudRecib");
                session.setAttribute("solicitudRecib", json);
                response.sendRedirect("SolicitudesModelo.jsp?opc=" + opc);
            } else if (opc.equals("vistoBuenoSol")) {
                String json = request.getParameter("solicitudRecib");
                session.setAttribute("solicitudRecib", json);
                response.sendRedirect("SolicitudesModelo.jsp?opc=" + opc);
            } else if (opc.equals("filtrarGrupoAuto")) {
                String idgrupov = request.getParameter("idgrupov");
                session.setAttribute("idgrupov", idgrupov);
                response.sendRedirect("SolicitudesModelo.jsp?opc=" + opc);
            } else if (opc.equals("addDisponivilidadVC")) {
                String jsonDisponVC = request.getParameter("jsonDisponVC");
                session.setAttribute("jsonDisponVC", jsonDisponVC);
                String jsonSolicitud = request.getParameter("jsonSolicitud");
                session.setAttribute("jsonSolicitud", jsonSolicitud);
                response.sendRedirect("SolicitudesModelo.jsp?opc=" + opc);
            } else if (opc.equals("modificarSolicitud")) {
                String jsonSolicitud = request.getParameter("jsonSolicitud");
                session.setAttribute("jsonSolicitud", jsonSolicitud);
                String idSolicitud = request.getParameter("idSolicitud");
                session.setAttribute("idSolicitud", idSolicitud);
                response.sendRedirect("SolicitudesModelo.jsp?opc=" + opc);
            } else if (opc.equals("modDatosVehiculoDVC")) {
                String jsonVehiculo = request.getParameter("jsonVehiculo");
                session.setAttribute("jsonVehiculo", jsonVehiculo);
                response.sendRedirect("SolicitudesModelo.jsp?opc=" + opc);
            } else if (opc.equals("modDatosConductorDVC")) {
                String jsonConductor = request.getParameter("jsonConductor");
                session.setAttribute("jsonConductor", jsonConductor);
                response.sendRedirect("SolicitudesModelo.jsp?opc=" + opc);
            } else if (opc.equals("combinarPDFs")) {
                if (ServletFileUpload.isMultipartContent(request)) {
                    try {
                        ServletFileUpload SFileUpload = new ServletFileUpload(new DiskFileItemFactory());
                        Iterator iter = SFileUpload.parseRequest(request).iterator();
                        while (iter.hasNext()) {
                            FileItem FItem = (FileItem) iter.next();
                            if (!FItem.isFormField()) {
                                if (FItem.getFieldName().equals("dato")) {
                                    byte[] bytes = IOUtils.toByteArray(FItem.getInputStream());
                                    session.setAttribute("bytesCombinarPDF", bytes);
                                }
                            }
                            if (FItem.getFieldName().equals("jsonSolicitud")) {
                                session.setAttribute("jsonSolicitud", java.net.URLDecoder.decode(FItem.getString(), "UTF-8"));
                            }
                        }
                        response.sendRedirect("SolicitudesModelo.jsp?opc=" + opc);
                    } catch (FileUploadException e) {
                        out.println(e.toString());
                        response.sendError(501, this.getServletName() + "-> Error al querer subir el archivo al sistema");
                    }
                }
            }
        }
    } else {
        response.sendError(501, this.getServletName() + "-> Error no se ha logueado en el sistema contacte con proveedor");
    }
%>
