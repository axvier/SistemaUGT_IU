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
public class swSeccionMotivo {
    //<editor-fold defaultstate="collapsed" desc="Listar seccion motivo">
    public static String listarMotivos(){
        String result = "";
        try {
            URL url = new URL(Constantes.PREFIJO + Constantes.IP + "/" + Constantes.SERVICIO + "/ws/tbseccionmotivo");
            HttpURLConnection conexion = (HttpURLConnection) url.openConnection();
            conexion.setRequestMethod("GET");
            conexion.setDoOutput(true);
            conexion.setDoInput(true);
            InputStream contenido = (InputStream) conexion.getInputStream();
            BufferedReader in = new BufferedReader(new InputStreamReader(contenido, "UTF-8"));
            String line;
            while ((line = in.readLine()) != null) {
                result = line;
            }
            conexion.disconnect();
        } catch (Exception e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en consultar el servicio para listar todos los motivos ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return result;
    }
    //</editor-fold>

    //<editor-fold defaultstate="collapsed" desc="Buscar seccion motivo por ID">
    public static String listarMotivoID(String id) {
        String result = "";
        try {
            URL url = new URL(Constantes.PREFIJO + Constantes.IP + "/" + Constantes.SERVICIO + "/ws/tbseccionmotivo/" + id);
            HttpURLConnection conexion = (HttpURLConnection) url.openConnection();
            conexion.setRequestMethod("GET");
            conexion.setDoOutput(true);
            conexion.setDoInput(true);
            InputStream contenido = (InputStream) conexion.getInputStream();
            BufferedReader in = new BufferedReader(new InputStreamReader(contenido, "UTF-8"));
            String line;
            while ((line = in.readLine()) != null) {
                result = line;
            }
            conexion.disconnect();
        } catch (Exception e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en consultar el servicio para buscar motivo por id ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return result;
    }
    //</editor-fold>

    //<editor-fold defaultstate="collapsed" desc="Eliminar motivo por id">
    public static String eliminarMotivo(String id) {
        String resul = "";
        URL url = null;
        try {
            url = new URL(Constantes.PREFIJO + Constantes.IP + "/" + Constantes.SERVICIO + "/ws/tbseccionmotivo/" + id);
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
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en consultar el servicio para eliminar un motivo por id ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        } finally {
            if (httpURLConnection != null) {
                httpURLConnection.disconnect();
            }
        }
        return resul;
    }
    //</editor-fold>

    //<editor-fold defaultstate="collapsed" desc="Modificar motivo">
    public static String modificarMotivo(String id, String json) {
        String jsonResponse = "";
        try {
            URL url = new URL(Constantes.PREFIJO + Constantes.IP + "/" + Constantes.SERVICIO + "/ws/tbseccionmotivo/" + id);
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("PUT");
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
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en consultar el servicio para modificar un motivo ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return jsonResponse;
    }
    //</editor-fold>

    //<editor-fold defaultstate="collapsed" desc="Insertar un motivo nuevo">
    public static String insertMotivo(String json) throws IOException {
        String jsonResponse = "";
        try {
            URL url = new URL(Constantes.PREFIJO + Constantes.IP + "/" + Constantes.SERVICIO + "/ws/tbseccionmotivo");
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
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en consultar el servicio para insertar un motivo ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return jsonResponse;
    }
    //</editor-fold>
}
