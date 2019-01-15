/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ugt.salvoconducto;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonSyntaxException;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import ugt.entidades.Tbsolicitudes;
import ugt.servicios.swOrdenMovilizacion;
import ugt.servicios.swSolicitudes;

/**
 *
 * @author Xavy PC
 */
@WebServlet(name = "GenerarSalvoConducto", urlPatterns = {"/GenerarSalvoConducto"})
public class GenerarSalvoConducto extends HttpServlet {

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
            out.println("<title>Servlet GenerarSalvoConducto</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet GenerarSalvoConducto at " + request.getContextPath() + "</h1>");
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
        Gson g = new GsonBuilder().setDateFormat("yyyy-MM-dd'T'HH:mm:ss-05:00").create();
        response.setContentType("application/force-download");
        try {

            String jsonSolicitud = request.getParameter("jsonSolicitud");
            String kminicio = request.getParameter("kminicio");
            Tbsolicitudes solicitud = g.fromJson(jsonSolicitud, Tbsolicitudes.class);
            Calendar today = Calendar.getInstance();
            SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd'T'00:00:00-05:00");
            Date date = sf.parse(sf.format(today.getTime()));
            response.setHeader("Content-disposition", "attachment; filename=" + solicitud.getNumero() + "_UGT_" + date.getYear() + ".pdf");

            String jsonSolFull = swSolicitudes.getSolicitudFullID(solicitud.getNumero().toString());
            OrdenMovilizacionPDF ordenPDF = g.fromJson(jsonSolFull, OrdenMovilizacionPDF.class);
            ByteArrayOutputStream baos = ordenPDF.generarPDF();

            String exiteOrden = swOrdenMovilizacion.filtarOrdenMovilizacionIDSol(solicitud.getNumero().toString());
            if (exiteOrden.length() <= 2) {
                boolean insert = insertarOrdenMovilizacion(solicitud, kminicio);
                boolean actualizar = (insert) ? actualizarSolicitud(solicitud) : false;
            }else{
                actualizarSolicitud(solicitud);
            }
            
            OutputStream os = response.getOutputStream();
            baos.writeTo(os);
            os.flush();
        } catch (JsonSyntaxException | IOException e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en ejecutar el servlet generador de salvo conducto ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
            response.sendError(515, "ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        } catch (ParseException ex) {
            Logger.getLogger(GenerarSalvoConducto.class.getName()).log(Level.SEVERE, null, ex);
            response.sendError(515, "ERROR: " + ex.getClass().getName() + "***" + ex.getMessage());
        }
    }

    /**
     * Método para actualizar estado a finalizado de la solicitud
     *
     * @param solicitud establece la instancia de la clase tbsolicitud en la que
     * contiene los datos necesarios para actualizar
     * @return tipo booleano con el resultado de la actualización
     */
    private boolean actualizarSolicitud(Tbsolicitudes solicitud) {
        boolean result = false;
        Gson g = new GsonBuilder().setDateFormat("yyyy-MM-dd'T'HH:mm:ss-05:00").create();
        solicitud.setEstado("finalizado");
        String res = swSolicitudes.modificarSolicitudID(solicitud.getNumero().toString(), g.toJson(solicitud));
        result = (res.length() > 2);
        return result;
    }

    private boolean insertarOrdenMovilizacion(Tbsolicitudes solicitud, String kmInicio) {
        boolean result = false;
        try {
            Calendar today = Calendar.getInstance();
            SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd'T'00:00:00-05:00");
            Date date = sf.parse(sf.format(today.getTime()));
        } catch (ParseException e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en insertar la orden de movilización ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
            result = false;
        }
        return result;
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
