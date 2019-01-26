<%-- 
    Document   : SalvoConductosControlador
    Created on : 14/01/2019, 01:30:49 PM
    Author     : Xavy PC
--%>

<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="org.apache.commons.io.IOUtils"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.commons.fileupload.FileUploadException"%>
<%@page import="utg.login.Login"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Login login = (Login) session.getAttribute("login");
    if (login != null) {
        String opc = request.getParameter("opc");
        if (opc != null) {
            if (opc.equals("mostrar")) {
                String accion = request.getParameter("accion");
                response.sendRedirect("SalvoConductosVista.jsp?accion=" + accion);
            } else if (opc.equals("jsonSolicitudesEstado")) {
                String estado = request.getParameter("estadoSolicitudes");
                session.setAttribute("estadoSolicitudes", estado);
                response.sendRedirect("SalvoConductosModelo.jsp?opc=" + opc);
            } else if (opc.equals("jsonFullOrdenes")) {
                response.sendRedirect("SalvoConductosModelo.jsp?opc=" + opc);
            } else if (opc.equals("modificarSolicitud")) {
                String jsonSolicitud = request.getParameter("jsonSolicitud");
                session.setAttribute("jsonSolicitud", jsonSolicitud);
                String idSolicitud = request.getParameter("idSolicitud");
                session.setAttribute("idSolicitud", idSolicitud);
                response.sendRedirect("SalvoConductosModelo.jsp?opc=" + opc);
            } else if (opc.equals("modificarOrden")) {
                String jsonSolicitud = request.getParameter("jsonSolicitud");
                session.setAttribute("jsonSolicitud", jsonSolicitud);
                String idSolicitud = request.getParameter("idSolicitud");
                session.setAttribute("idSolicitud", idSolicitud);
                String jsonOrden = request.getParameter("jsonOrden");
                session.setAttribute("jsonOrden", jsonOrden);
                String idOrden = request.getParameter("idOrden");
                session.setAttribute("idOrden", idOrden);
                response.sendRedirect("SalvoConductosModelo.jsp?opc=" + opc);
            } else if (opc.equals("saveOrdenMov")) {
                String jsonSolicitud = request.getParameter("jsonSolicitud");
                session.setAttribute("jsonSolicitud", jsonSolicitud);
                String kminicio = request.getParameter("kminicio");
                session.setAttribute("kminicio", kminicio);
                response.sendRedirect("SalvoConductosModelo.jsp?opc=" + opc);
            } else if (opc.equals("subirOrdenPDF")) {
                if (ServletFileUpload.isMultipartContent(request)) {
                    try {
                        ServletFileUpload SFileUpload = new ServletFileUpload(new DiskFileItemFactory());
                        Iterator iter = SFileUpload.parseRequest(request).iterator();
                        while (iter.hasNext()) {
                            FileItem FItem = (FileItem) iter.next();
                            if (!FItem.isFormField()) {
                                byte[] bytes = IOUtils.toByteArray(FItem.getInputStream());
                                session.setAttribute("byteSPDF", bytes);
                            }
                            if (FItem.getFieldName().equals("numeroOrden")) {
                                session.setAttribute("numeroOrden", FItem.getString());
                            }
                        }
                        response.sendRedirect("SalvoConductosModelo.jsp?opc=" + opc);
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
