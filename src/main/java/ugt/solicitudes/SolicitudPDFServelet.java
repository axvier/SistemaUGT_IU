/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ugt.solicitudes;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonSyntaxException;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import ugt.entidades.Tbusuariosentidad;
import ugt.servicios.swSeccionSolicitante;
import ugt.servicios.swSolicitudes;

/**
 *
 * @author Xavy PC
 */
@WebServlet(
        name = "SolicitudPDF",
        urlPatterns = {"/SolicitudPDFServelet"}
)
public class SolicitudPDFServelet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet SolicitudPDFServelet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SolicitudPDFServelet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/force-download");
        try {
            String nombres_apellidos = request.getParameter("nombres_apellidos");
            byte[] bytes = nombres_apellidos.getBytes(StandardCharsets.ISO_8859_1);
            nombres_apellidos = new String(bytes, StandardCharsets.UTF_8);
            String rol_entidad = request.getParameter("rol_entidad");
            bytes = rol_entidad.getBytes(StandardCharsets.ISO_8859_1);
            rol_entidad = new String(bytes, StandardCharsets.UTF_8);;
            String idSolicitud = request.getParameter("idSolicitud");
            String cedula = request.getParameter("cedula");
            String idrol = request.getParameter("idrol");
            String entidadrol = swSeccionSolicitante.buscarEntidadSolicitante(cedula, idrol);
            String jsonSolicitud = swSolicitudes.getSolicitudFullID(idSolicitud);

//            response.setHeader("Expires", "0");
//            response.setHeader("Cache-Control","must-revalidate, post-check=0, pre-check=0");
//            response.setHeader("Pragma", "public");
            response.setHeader("Content-disposition", "attachment; filename="+idSolicitud+".pdf");

            Gson g = new GsonBuilder().setDateFormat("yyyy-MM-dd'T'HH:mm:ss-05:00").create();
            SolicitudPDF solPDF = g.fromJson(jsonSolicitud, SolicitudPDF.class);
            solPDF.setEntidadrol(g.fromJson(entidadrol, Tbusuariosentidad.class));
            solPDF.setSolicitanteTitulos(nombres_apellidos);
            solPDF.setSolicitantRolEntidad(rol_entidad);
            ByteArrayOutputStream baos = solPDF.generarPDF();
            OutputStream os = response.getOutputStream();
            baos.writeTo(os);
            os.flush();
        } catch (JsonSyntaxException | IOException e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en ejecutar el servlet generador PDF Solicitud ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
