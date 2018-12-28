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
public class swViajePasajero {
    //<editor-fold defaultstate="collapsed" desc="Listar viaje pasajero">
    public static String listarViajesPasajeros(){
        String result = "";
        try {
            URL url = new URL(Constantes.PREFIJO + Constantes.IP + "/" + Constantes.SERVICIO + "/ws/tbviajepasajero");
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
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en consultar el servicio para listar todos los viajes con pasajeros ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return result;
    }
    //</editor-fold>

    //<editor-fold defaultstate="collapsed" desc="Buscar viaje pasajero por ID compuesto">
    public static String listarViajePasajeroID(String idCompuesto) {
        String result = "";
        try {
            URL url = new URL(Constantes.PREFIJO + Constantes.IP + "/" + Constantes.SERVICIO + "/ws/tbviajepasajero/" + idCompuesto);
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
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en consultar el servicio para buscar un viaje con pasajero por id compuesto ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return result;
    }
    //</editor-fold>

    //<editor-fold defaultstate="collapsed" desc="Eliminar viaje pasjero por id compuesto">
    public static String eliminarViajePasajero(String idcompuesto) {
        String resul = "";
        URL url = null;
        try {
            url = new URL(Constantes.PREFIJO + Constantes.IP + "/" + Constantes.SERVICIO + "/ws/tbviajepasajero/" + idcompuesto);
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
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en consultar el servicio para eliminar un viaje con pasajero por id compuesto ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        } finally {
            if (httpURLConnection != null) {
                httpURLConnection.disconnect();
            }
        }
        return resul;
    }
    //</editor-fold>

    //<editor-fold defaultstate="collapsed" desc="Modificar viaje pasajero por id compuesto y json">
    public static String modificarViajePasajero(String idcompuesto, String json) {
        String jsonResponse = "";
        try {
            URL url = new URL(Constantes.PREFIJO + Constantes.IP + "/" + Constantes.SERVICIO + "/ws/tbviajepasajero/" + idcompuesto);
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
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en consultar el servicio para modificar un viaje con pasajero ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return jsonResponse;
    }
    //</editor-fold>

    //<editor-fold defaultstate="collapsed" desc="Insertar un viaje pasajero nuevo">
    public static String insertViajePasajero(String json) throws IOException {
        String jsonResponse = "";
        try {
            URL url = new URL(Constantes.PREFIJO + Constantes.IP + "/" + Constantes.SERVICIO + "/ws/tbviajepasajero");
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
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en consultar el servicio para insertar un viaje pasajero nuevo ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return jsonResponse;
    }
    //</editor-fold>
}
