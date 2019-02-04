<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.commons.fileupload.FileUploadException"%>
<%@page import="utg.login.Login"%>
<%
    Login login = (Login) session.getAttribute("login");
    if (login != null) {
        String opc = request.getParameter("opc");
        if (opc != null) {
            if (opc.equals("jsonVehiculos")) {
                response.sendRedirect("vehiculoModelo.jsp?opc=" + opc);
            } else if (opc.equals("mostrar")) {
                String accion = request.getParameter("accion");
                response.sendRedirect("vehiculoVista.jsp?accion=" + accion);
            } else if (opc.equals("saveVehiculo")) {
                String jsonVehiculo = request.getParameter("jsonVehiculo");
                session.setAttribute("jsonVehiculo", jsonVehiculo);
                String placa = request.getParameter("placa");
                session.setAttribute("placa", placa);
                response.sendRedirect("vehiculoModelo.jsp?opc=" + opc);
            } else if (opc.equals("eliminarVehiculo")) {
                String placa = request.getParameter("placa");
                String jsonVehiculo = request.getParameter("jsonVehiculo");
                String nombreGrupo = request.getParameter("nombreGrupo");
                session.setAttribute("json", jsonVehiculo);
                session.setAttribute("placa", placa);
                session.setAttribute("nombreGrupo", nombreGrupo);
                response.sendRedirect("vehiculoModelo.jsp?opc=" + opc);
            } else if (opc.equals("eliminarRevision")) {
                String idrevision = request.getParameter("idrevision");
                session.setAttribute("idrevision", idrevision);
                response.sendRedirect("vehiculoModelo.jsp?opc=" + opc);
            } else if (opc.equals("downloadPDFOrden")) {
                String idPDFRevision = request.getParameter("idPDFRevision");
                session.setAttribute("idPDFRevision", idPDFRevision);
                response.sendRedirect("vehiculoModelo.jsp?opc=" + opc);
            } else if (opc.equals("modificarVehiculo")) {
                String placa = request.getParameter("placa");
                String jsonVehiculo = request.getParameter("jsonVehiculo");
                String idgrupo = request.getParameter("idgrupo");
                session.setAttribute("placa", placa);
                session.setAttribute("jsonVehiculo", jsonVehiculo);
                session.setAttribute("idgrupo", idgrupo);
                response.sendRedirect("vehiculoModelo.jsp?opc=" + opc);
            } else if (opc.equals("tableVehiculos")) {
                response.sendRedirect("vehiculoModelo.jsp?opc=" + opc );
            } else if (opc.equals("jsonVehiculosOcup")) {
                response.sendRedirect("vehiculoModelo.jsp?opc=" + opc );
            } else if (opc.equals("jsonVehiculosUnlock")) {
                response.sendRedirect("vehiculoModelo.jsp?opc=" + opc );
            } else if (opc.equals("contentModalVerCond")) {
                String placa = request.getParameter("placa");
                session.setAttribute("placa", placa);
                response.sendRedirect("vehiculoModelo.jsp?opc=" + opc );
            } else if (opc.equals("modRevisionM")) {
                String placa = request.getParameter("placaRM");
                session.setAttribute("placaRM", placa);
                response.sendRedirect("vehiculoVista.jsp?accion=" + opc );
            } else if (opc.equals("modDependencia")) {
                String placa = request.getParameter("placaRM");
                session.setAttribute("placaRM", placa);
                response.sendRedirect("vehiculoModelo.jsp?opc=" + opc );
            } else if (opc.equals("divModalVerVehiculoEntida")) {
                String placa = request.getParameter("placaVD");
                session.setAttribute("placaVD", placa);
                response.sendRedirect("vehiculoModelo.jsp?opc=" + opc );
            } else if (opc.equals("savedependencia")) {
                String jsonvehdep = request.getParameter("jsonvehdep");
                session.setAttribute("jsonvehdep", jsonvehdep);
                String placaD = request.getParameter("placaD");
                session.setAttribute("placaD", placaD);
                response.sendRedirect("vehiculoModelo.jsp?opc=" + opc);
            } else if (opc.equals("modificardependencia")) {
                String jsonvehdep = request.getParameter("jsonvehdep");
                session.setAttribute("jsonvehdep", jsonvehdep);
                response.sendRedirect("vehiculoModelo.jsp?opc=" + opc);
            } else if (opc.equals("eliminardependencia")) {
                String jsonvehdep = request.getParameter("jsonvehdep");
                session.setAttribute("jsonvehdep", jsonvehdep);
                response.sendRedirect("vehiculoModelo.jsp?opc=" + opc);
            } else if (opc.equals("jsonRevisionMecanica")) {
                String placa = request.getParameter("matricula");
                session.setAttribute("matricula", placa);
                response.sendRedirect("vehiculoModelo.jsp?opc=" + opc );
            } else if (opc.equals("addRevisionM")) {
                if (ServletFileUpload.isMultipartContent(request)) {
                    try {
                        ServletFileUpload SFileUpload = new ServletFileUpload(new DiskFileItemFactory());
                        Iterator iter = SFileUpload.parseRequest(request).iterator();
                        while (iter.hasNext()) {
                            FileItem FItem = (FileItem) iter.next();
                            if (!FItem.isFormField()) {
                                if (FItem.getFieldName().equals("dato")) {
                                    byte[] bytes = org.apache.commons.io.IOUtils.toByteArray(FItem.getInputStream());
                                    session.setAttribute("bytesPDF", bytes);
                                }
                            }
                            if (FItem.getFieldName().equals("jsonRevisionM")) {
                                session.setAttribute("jsonRevisionM", java.net.URLDecoder.decode(FItem.getString(), "UTF-8"));
                            }
                            if (FItem.getFieldName().equals("placaRM")) {
                                session.setAttribute("placaRM", FItem.getString());
                            }
                        }
                        response.sendRedirect("vehiculoModelo.jsp?opc=" + opc);
                    } catch (FileUploadException e) {
                        out.println(e.toString());
                        response.sendError(501, this.getServletName() + "-> Error al querer subir el archivo al servidor");
                    }
                }
            }
        }
    } else {
        response.sendError(501, this.getServletName() + "-> Error no se ha logueado en el sistema contacte con proveedor");
    }

%>
