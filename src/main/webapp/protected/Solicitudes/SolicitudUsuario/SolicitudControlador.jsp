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
            } else if (opc.equals("saveSolicitud")) {
                if (ServletFileUpload.isMultipartContent(request)) {
                    try {
                        ServletFileUpload SFileUpload = new ServletFileUpload(new DiskFileItemFactory());
                        Iterator iter = SFileUpload.parseRequest(request).iterator();
                        while (iter.hasNext()) {
                            FileItem FItem = (FileItem) iter.next();
                            if (!FItem.isFormField()) {
                                if (FItem.getFieldName().equals("pdfData")) {
                                    byte[] bytes = IOUtils.toByteArray(FItem.getInputStream());
                                    session.setAttribute("byteSPDF", bytes);
                                }
                            }
                        }
                    } catch (FileUploadException e) {
                        out.println(e.toString());
                    }
                }
                String jsonMotivo = request.getParameter("jsonMotivo");
                String jsonViaje = request.getParameter("jsonViaje");
                String jsonPasajeros = request.getParameter("jsonPasajeros");
                session.setAttribute("jsonMotivo", jsonMotivo);
                session.setAttribute("jsonViaje", jsonViaje);
                session.setAttribute("jsonPasajeros", jsonPasajeros);
                response.sendRedirect("SolicitudModelo.jsp?opc=" + opc);
            }
        }
    } else {
        response.sendError(501, this.getServletName() + "-> Error no se ha logueado en el sistema contacte con proveedor");
    }
%>