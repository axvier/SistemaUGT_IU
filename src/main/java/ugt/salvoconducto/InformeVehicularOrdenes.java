/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ugt.salvoconducto;

import com.google.gson.Gson;
import com.google.gson.JsonSyntaxException;
import com.google.gson.reflect.TypeToken;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import ugt.servicios.swReportes;
import ugt.solicitudes.Solicitudesfull;

/**
 *
 * @author Xavy PC
 */
@WebServlet(name = "InformeVehicularOrdenes", urlPatterns = {"/InformeVehicularOrdenes"})
public class InformeVehicularOrdenes extends HttpServlet {

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
            out.println("<title>Servlet InformeVehicularOrdenes</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet InformeVehicularOrdenes at " + request.getContextPath() + "</h1>");
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
            String fecha1 = request.getParameter("starFecha");
            String fecha2 = request.getParameter("endFecha");
            response.setHeader("Content-disposition", "attachment; filename=INFORME-" + fecha1 + "-" + fecha2 + ".pdf");

            ReporteOrdenesPDF orden = new ReporteOrdenesPDF();
            String solicitudes = swReportes.reporteOrdenesTipo("numero", "ASC", fecha1, fecha2);
            if (solicitudes.length() > 2) {
                Gson gson = new Gson();
                Type listType = new TypeToken<ArrayList<Solicitudesfull>>() {
                }.getType();
                List<Solicitudesfull> lista = gson.fromJson(solicitudes, listType);
                orden.setListaSolicitudes(lista);
            }
            orden.setStartFecha(fecha1);
            orden.setEndFecha(fecha2);
            ByteArrayOutputStream baos = orden.generarReporteOrdenPDF();
            OutputStream os = response.getOutputStream();
            baos.writeTo(os);
            os.flush();
        } catch (JsonSyntaxException | IOException e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en ejecutar el servlet generar solictud segun rango ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
            response.sendError(515, "ERROR: " + e.getClass().getName() + "***" + e.getMessage());
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
