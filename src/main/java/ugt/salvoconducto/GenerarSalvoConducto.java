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
import ugt.entidades.Tbordenesmovilizaciones;
import ugt.entidades.Tbsolicitudes;
import ugt.registros.iu.RegistrosM;
import ugt.servicios.swOrdenMovilizacion;
import ugt.servicios.swSolicitudes;
import utg.login.Login;

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
        Gson g = new GsonBuilder().setDateFormat("yyyy-MM-dd'T'HH:mm:ss-05:00").create();
        response.setContentType("application/force-download");
        try {

            String jsonSolicitud = java.net.URLDecoder.decode(request.getParameter("SolicitudGenerar"), "utf-8");
            Tbsolicitudes solicitud = g.fromJson(jsonSolicitud, Tbsolicitudes.class);
            int year = Calendar.getInstance().get(Calendar.YEAR);
            response.setHeader("Content-disposition", "attachment; filename=" + solicitud.getNumero() + "_UGT_" + year + ".pdf");

            String jsonSolFull = swSolicitudes.getSolicitudFullID(solicitud.getNumero().toString());
            OrdenMovilizacionPDF ordenPDF = g.fromJson(jsonSolFull, OrdenMovilizacionPDF.class);
            String jsonOrden = swOrdenMovilizacion.filtarOrdenMovilizacionIDSol(ordenPDF.getSolicitud().getNumero().toString());
            if (jsonOrden.length() > 2) {
                Tbordenesmovilizaciones ord = g.fromJson(jsonOrden, Tbordenesmovilizaciones.class);
                Calendar today = Calendar.getInstance();
                SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss-05:00");
                try {
                    Date date = sf.parse(sf.format(today.getTime()));
                    ord.setFechagenerar(date);
                    swOrdenMovilizacion.modificaOrdenMovilizacionID(ord.getNumeroOrden(), g.toJson(ord));
                } catch (ParseException ex) {
                    Logger.getLogger(GenerarSalvoConducto.class.getName()).log(Level.SEVERE, null, ex);
                }
                ordenPDF.setOrden(ord);
            }
            ByteArrayOutputStream baos = ordenPDF.generarPDF();
            OutputStream os = response.getOutputStream();
            baos.writeTo(os);
            os.flush();
        } catch (JsonSyntaxException | IOException e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en ejecutar el servlet generador de salvo conducto ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
            response.sendError(515, "ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
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

            String jsonSolicitud = java.net.URLDecoder.decode(request.getParameter("SolicitudGenerar"), "utf-8");
            String nombresApellidos = request.getParameter("nombresApellidos");
            String cargoentidad = request.getParameter("cargoentidad");
            Tbsolicitudes solicitud = g.fromJson(jsonSolicitud, Tbsolicitudes.class);
            int year = Calendar.getInstance().get(Calendar.YEAR);
            response.setHeader("Content-disposition", "attachment; filename=" + solicitud.getNumero() + "_UGT_" + year + ".pdf");

            String jsonSolFull = swSolicitudes.getSolicitudFullID(solicitud.getNumero().toString());
            OrdenMovilizacionPDF ordenPDF = g.fromJson(jsonSolFull, OrdenMovilizacionPDF.class);
            if (nombresApellidos != null && cargoentidad != null) {
                ordenPDF.setNombresApellidos(nombresApellidos);
                ordenPDF.setCargoEntidad(cargoentidad);
            }
            String jsonOrden = swOrdenMovilizacion.filtarOrdenMovilizacionIDSol(ordenPDF.getSolicitud().getNumero().toString());
            if (jsonOrden.length() > 2) {
                Tbordenesmovilizaciones ord = g.fromJson(jsonOrden, Tbordenesmovilizaciones.class);
                Calendar today = Calendar.getInstance();
                SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss-05:00");
                try {
                    Date date = sf.parse(sf.format(today.getTime()));
                    ord.setFechagenerar(date);
                    swOrdenMovilizacion.modificaOrdenMovilizacionID(ord.getNumeroOrden(), g.toJson(ord));
                    Login login = (Login) request.getSession(false).getAttribute("login");
                    RegistrosM.Insertar(login, ord, "orden generada");
                } catch (ParseException ex) {
                    Logger.getLogger(GenerarSalvoConducto.class.getName()).log(Level.SEVERE, null, ex);
                }
                ordenPDF.setOrden(ord);
            }
            ByteArrayOutputStream baos = ordenPDF.generarPDF();
            OutputStream os = response.getOutputStream();
            baos.writeTo(os);
            os.flush();
        } catch (JsonSyntaxException | IOException e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en ejecutar el servlet generador de salvo conducto ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
            response.sendError(515, "ERROR: " + e.getClass().getName() + "***" + e.getMessage());
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
        solicitud.setEstado("finalizada");
        String res = swSolicitudes.modificarSolicitudID(solicitud.getNumero().toString(), g.toJson(solicitud));
        result = (res.length() > 2);
        return result;
    }

    private boolean insertarOrdenMovilizacion(Tbsolicitudes solicitud, String kmInicio, int year) {
        boolean result = false;
        try {
            Gson g = new GsonBuilder().setDateFormat("yyyy-MM-dd'T'HH:mm:ss-05:00").create();
            Calendar today = Calendar.getInstance();
            SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd'T'00:00:00-05:00");
            Date date = sf.parse(sf.format(today.getTime()));
            Tbordenesmovilizaciones orden = new Tbordenesmovilizaciones();
            orden.setFechagenerar(date);
            orden.setKminicio(kmInicio);
            orden.setNumeroOrden(solicitud.getNumero() + "-UGT-" + year);
            orden.setSolicitud(solicitud);
            String resAUX = swOrdenMovilizacion.insertOrdenMovilizacion(g.toJson(orden));
            result = (resAUX.length() > 2);
        } catch (ParseException | IOException e) {
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
