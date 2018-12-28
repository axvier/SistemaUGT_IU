<%-- 
    Document   : SolicitudControlador
    Created on : 8/12/2018, 01:31:43 PM
    Author     : Xavy PC
--%>
<%@page import="org.apache.commons.io.IOUtils"%>
<%@page import="org.apache.commons.fileupload.FileUploadException"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="utg.login.Login"%>
<%
    Login login = (Login) session.getAttribute("login");
    if (login != null) {
        String opc = request.getParameter("opc");
        if (opc != null) {
            if (opc.equals("mostrar")) {
                String accion = request.getParameter("accion");
                response.sendRedirect("SolicitudVista.jsp?accion=" + accion);
            } else if (opc.equals("jsonUsuarios")) {
                response.sendRedirect("SolicitudModelo.jsp?opc=" + opc);
            } else if (opc.equals("nuevaSolicitudU")) {
                response.sendRedirect("SolicitudModelo.jsp?opc=" + opc);
            } else if (opc.equals("pasajeroAutocomplete")) {
                String term = request.getParameter("term");
                session.setAttribute("term", term);
                response.sendRedirect("SolicitudModelo.jsp?opc=" + opc);
            } else if (opc.equals("saveSolicitud")) {
                if (ServletFileUpload.isMultipartContent(request)) {
                    try {
                        ServletFileUpload SFileUpload = new ServletFileUpload(new DiskFileItemFactory());
                        Iterator iter = SFileUpload.parseRequest(request).iterator();
                        while (iter.hasNext()) {
                            FileItem FItem = (FileItem) iter.next();
                            if (!FItem.isFormField()) {
//                                if (FItem.getFieldName().equals("pdfData")) {
                                byte[] bytes = IOUtils.toByteArray(FItem.getInputStream());
                                session.setAttribute("byteSPDF", bytes);
//                                }
                            }
                            if (FItem.getFieldName().equals("extension")) {
                                session.setAttribute("extension", java.net.URLDecoder.decode(FItem.getString(), "UTF-8"));
                            }
                            if (FItem.getFieldName().equals("jsonMotivo")) {
                                session.setAttribute("jsonMotivo", java.net.URLDecoder.decode(FItem.getString(), "UTF-8"));
                            }
                            if (FItem.getFieldName().equals("jsonViaje")) {
                                session.setAttribute("jsonViaje", java.net.URLDecoder.decode(FItem.getString(), "UTF-8"));
                            }
                            if (FItem.getFieldName().equals("jsonPasajeros")) {
                                session.setAttribute("jsonPasajeros", java.net.URLDecoder.decode(FItem.getString(), "UTF-8"));
                            }
                        }
                        response.sendRedirect("SolicitudModelo.jsp?opc=" + opc);
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