package ugt.servicios;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.logging.Level;
import java.util.logging.Logger;
import utils.Constantes;

/**
 *
 * @author Xavy PC
 */
public class swLicencia {
    //<editor-fold defaultstate="collapsed" desc="Listar licencias">
    public static String listarLicencias() {
        String json = "";
        try {
            URL url = new URL(Constantes.PREFIJO + Constantes.IP + "/" + Constantes.SERVICIO + "/ws/tblicencias");
            HttpURLConnection conexion = (HttpURLConnection) url.openConnection();
            conexion.setRequestMethod("GET");
            conexion.setDoOutput(true); //enviar un json al ad  
            conexion.setDoInput(true);  //traer el jason del ad
            InputStream contenido = (InputStream) conexion.getInputStream();
            BufferedReader in = new BufferedReader(new InputStreamReader(contenido, "UTF-8"));
            String line;
            while ((line = in.readLine()) != null) {
                json = line;
            }
            conexion.disconnect();
        } catch (Exception e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en consultar el servicio paara listar las licencias  ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return json;
    }
    //</editor-fold>

    //<editor-fold defaultstate="collapsed" desc="Licencia segun CEDULA JSON">
    public static String licenciaID(String cedula) {
        String json = "";
        try {
            URL url = new URL(Constantes.PREFIJO + Constantes.IP + "/" + Constantes.SERVICIO + "/ws/buscarlicenciacedula/" + cedula);
            HttpURLConnection conexion = (HttpURLConnection) url.openConnection();
            conexion.setRequestMethod("GET");
            conexion.setDoOutput(true);
            conexion.setDoInput(true);
            InputStream contenido = (InputStream) conexion.getInputStream();
            BufferedReader in = new BufferedReader(new InputStreamReader(contenido, "UTF-8"));
            String line;
            while ((line = in.readLine()) != null) {
                json = line;
            }
            conexion.disconnect();
        } catch (Exception e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en consultar el servicio para consulatr licencia por cedula ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return json;
    }
    //</editor-fold>

    //<editor-fold defaultstate="collapsed" desc="Insertar licencia y retornar sus datos">
    public static String insertLicencia(String json) throws IOException {
        String jsonResponse = "";
        try {
            URL url = new URL(Constantes.PREFIJO + Constantes.IP + "/" + Constantes.SERVICIO + "/ws/tblicencias");
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("POST");
            connection.setDoOutput(true);
            connection.setDoInput(true);
            connection.setRequestProperty("Content-Type", "application/json; charset=utf-8");
            connection.setRequestProperty("Accept", "application/json; charset=utf-8");
            try (OutputStreamWriter writer = new OutputStreamWriter(connection.getOutputStream(), "UTF-8")) {
                writer.write(json);
                writer.flush();
            }
            InputStream content = (InputStream) connection.getInputStream();
            BufferedReader in = new BufferedReader(new InputStreamReader(content));
            jsonResponse = in.readLine();
            connection.disconnect();
        } catch (NumberFormatException | IOException e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en consultar el servicio para insertar una licencia ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return jsonResponse;
    }
    //</editor-fold>
    
    //<editor-fold defaultstate="collapsed" desc="Elinminar licencia">
    public static String eliminarLicencia(String cedula) { 
        String resul = "";
        URL url = null; 
        try {
            url = new URL(Constantes.PREFIJO + Constantes.IP + "/" + Constantes.SERVICIO + "/ws/tblicencias/" + cedula);
        } catch (MalformedURLException exception) {
            exception.printStackTrace();
        }
        HttpURLConnection httpURLConnection = null;
        try {
            httpURLConnection = (HttpURLConnection) url.openConnection();
            httpURLConnection.setRequestProperty("Content-Type", "application/json; charset=utf-8");
            httpURLConnection.setRequestMethod("DELETE");
//            System.out.println(httpURLConnection.getResponseCode());
            resul = String.valueOf(httpURLConnection.getResponseCode());
        } catch (IOException e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en consultar el servicio para eliminar una licencia ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        } finally {
            if (httpURLConnection != null) {
                httpURLConnection.disconnect();
            }
        }
        return resul;
    }
    //</editor-fold>

    //<editor-fold defaultstate="collapsed" desc="Modificar uuna licencia y retornar sus nuevos datos">
    public static String modificarLicencia(String json, String idlicencia) {
        String jsonResponse = "";
        try {
            URL url = new URL(Constantes.PREFIJO + Constantes.IP + "/" + Constantes.SERVICIO + "/ws/tblicencias/" + idlicencia);
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("PUT");
            connection.setDoOutput(true);
            connection.setDoInput(true);
            connection.setRequestProperty("Content-Type", "application/json; charset=utf-8");
            connection.setRequestProperty("Accept", "application/json; charset=utf-8");
            try (OutputStreamWriter writer = new OutputStreamWriter(connection.getOutputStream(), "ISO-8859-1")) {
                writer.write(json);
                writer.flush();
            }
            InputStream content = (InputStream) connection.getInputStream();
            BufferedReader in = new BufferedReader(new InputStreamReader(content));
            jsonResponse = in.readLine();
            connection.disconnect();
        } catch (NumberFormatException | IOException e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en consultar el servicio para modificar una licencia ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return jsonResponse;
    }
    //</editor-fold>
}
