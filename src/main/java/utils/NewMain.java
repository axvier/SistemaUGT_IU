/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utils;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;
import org.json.JSONException;
import org.json.JSONObject;
import ugt.conductores.iu.GenConductorPDF;
import ugt.entidades.Tbordenesmovilizaciones;
import ugt.entidades.Tbpasajeros;
import ugt.entidades.Tbpdf;
import ugt.entidades.Tbusuariosentidad;
import ugt.pdf.iu.classpdf;
import ugt.reportes.ConductorRepNomina;
import ugt.reportes.iu.ConductoresReporteEstadosIU;
import ugt.salvoconducto.OrdenMovilizacionPDF;
import ugt.servicios.swOrdenMovilizacion;
import ugt.servicios.swPDF;
import ugt.servicios.swReportes;
import ugt.servicios.swSeccionSolicitante;
import ugt.servicios.swSolicitudes;
import ugt.solicitudes.SolicitudPDF;
import ugt.solicitudes.Solicitudesfull;

/**
 *
 * @author Xavy PC
 */
public class NewMain {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) throws JSONException, FileNotFoundException, IOException {
        Gson g = new GsonBuilder().setDateFormat("yyyy-MM-dd'T'HH:mm:ss-05:00").create();
//        String jsonPDF = swPDF.listarPDFID("2");
//        JSONObject obj = new JSONObject(jsonPDF);
//        byte[] bytes = Base64.getDecoder().decode(obj.getString("archivo"));
////        byte[] bytes = Base64.getDecoder().decode(obj.getString("archivo"));
////        Tbpdf pdf = new Tbpdf();
////        pdf.setIdpdf(obj.getInt("idpdf"));
////        pdf.setArchivo(bytes);
////        File file = new File("D:\\Tesis\\457.pdf");
////        byte[] bytes = new byte[(int) file.length()];
////        FileInputStream fis = new FileInputStream(file);
////        fis.read(bytes); //read file into bytes[]
////        fis.close();
////        
////        String pdfJSON = new JSONObject()
////                .put("idpdf", 0)
////                .put("archivo", Base64.getEncoder().encodeToString(bytes)).toString();
////        String jsonPDF = swPDF.insertPDF(pdfJSON);
//        classpdf pdf = g.fromJson(jsonPDF, classpdf.class);
//        OutputStream out = new FileOutputStream("out.pdf");
//        out.write(bytes);
//        out.close();
//        Runtime.getRuntime().exec("rundll32 url.dll,FileProtocolHandler out.pdf");
//        g = new GsonBuilder().setDateFormat("yyyy-MM-dd'T'HH:mm:ss").create();
//        String solTitulos = "Dr. Giovanni Xavier Aranda Cóndor";
//        String solRolEntidad = "Director de la Escuela Ingeniería en Sistemas";
//        String entidadrol = swSeccionSolicitante.buscarEntidadSolicitante("1804789830", "1");
//        String jsonSolicitud = swSolicitudes.getSolicitudFullID("39");
//        Solicitudesfull full = g.fromJson(jsonSolicitud, Solicitudesfull.class);
//        SolicitudPDF solPDF = g.fromJson(jsonSolicitud, SolicitudPDF.class);
//        solPDF.setEntidadrol(g.fromJson(entidadrol, Tbusuariosentidad.class));
//        solPDF.setEntidadrol(g.fromJson(entidadrol, Tbusuariosentidad.class));
//        solPDF.setEntidadrol(g.fromJson(entidadrol, Tbusuariosentidad.class));
//        solPDF.setSolicitanteTitulos(solTitulos);
//        solPDF.setSolicitantRolEntidad(solRolEntidad);
//        String jsonSolFull = swSolicitudes.getSolicitudFullID("98");
//        OrdenMovilizacionPDF ordenPDF = g.fromJson(jsonSolFull, OrdenMovilizacionPDF.class);
//        String jsonOrden = swOrdenMovilizacion.filtarOrdenMovilizacionIDSol(ordenPDF.getSolicitud().getNumero().toString());
//        if(jsonOrden.length()>2){
//            Tbordenesmovilizaciones ord = g.fromJson(jsonOrden, Tbordenesmovilizaciones.class);
//            ordenPDF.setOrden(ord);
//        }
//        String ruta = ordenPDF.generarPDF();
//        System.out.println(ruta);
        String ruta = "";
//        String objJSON = swReportes.reporteEstadoConductor();
//        if (objJSON.length() > 2) {
//            ConductoresReporteEstadosIU repCondEstado = g.fromJson(objJSON, ConductoresReporteEstadosIU.class);
//            result = repCondEstado.generarPIEEstados();
//        }
        GenConductorPDF conductorPDF = new GenConductorPDF();
        String nomina = swReportes.reporteNominaConductor();
        if (nomina.length() > 2) {
            Gson gson = new Gson();
            Type listType = new TypeToken<ArrayList<ConductorRepNomina>>() {
            }.getType();
            List<ConductorRepNomina> lista = gson.fromJson(nomina, listType);
            conductorPDF.setListaConductor(lista);
        }
//        ruta = conductorPDF.generarPDF();
        System.out.println("solicitudes full() => " + ruta);
        Runtime.getRuntime().exec("rundll32 url.dll,FileProtocolHandler D:/pdfs/" + ruta);
    }

}
