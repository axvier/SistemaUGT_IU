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
public class swUsuarioEntidad {
    
    //<editor-fold defaultstate="collapsed" desc="Listar usuarios-entidades-rol">
    public static String listarUsuariosEntidades() {
        String result = "";
        try {
            URL url = new URL(Constantes.PREFIJO + Constantes.IP + "/" + Constantes.SERVICIO + "/ws/tbusuariosentidad");
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
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en consultar el servicio para listar usuarios-entidades-rol ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return result;
    }
    //</editor-fold>

    //<editor-fold defaultstate="collapsed" desc="Buscar usuario-entidades-rol por ID compuesto">
    public static String listarUsuarioEntidadID(String idCompuesto) {
        String result = "";
        try {
            URL url = new URL(Constantes.PREFIJO + Constantes.IP + "/" + Constantes.SERVICIO + "/ws/tbusuariosentidad/" + idCompuesto);
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
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en consultar el servicio para buscar un usuario-entidad-rol ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return result;
    }
    //</editor-fold>

    //<editor-fold defaultstate="collapsed" desc="Elinminar usuario-entidad-rol por id">
    public static String eliminarUsuarioEntidad(String idcompuesto) {
        String resul = "";
        URL url = null;
        try {
            url = new URL(Constantes.PREFIJO + Constantes.IP + "/" + Constantes.SERVICIO + "/ws/tbusuariosentidad/" + idcompuesto);
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
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en consultar el servicio para eliminar un usuario-entidad-rol ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        } finally {
            if (httpURLConnection != null) {
                httpURLConnection.disconnect();
            }
        }
        return resul;
    }
    //</editor-fold>

    //<editor-fold defaultstate="collapsed" desc="Modificar usuario-entidad-rol">
    public static String modificarUsuarioEntidad(String idcompuesto, String jsonUserEntity) {
        String jsonResponse = "";
        try {
            URL url = new URL(Constantes.PREFIJO + Constantes.IP + "/" + Constantes.SERVICIO + "/ws/tbusuariosentidad/" + idcompuesto);
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("PUT");
            connection.setDoOutput(true);
            connection.setDoInput(true);
            connection.setRequestProperty("Content-Type", "application/json; charset=utf-8");
            connection.setRequestProperty("Accept", "application/json; charset=utf-8");
            try (OutputStreamWriter writer = new OutputStreamWriter(connection.getOutputStream(), "UTF-8")) {
                writer.write(jsonUserEntity);
                writer.flush();
            }
            InputStream content = (InputStream) connection.getInputStream();
            BufferedReader in = new BufferedReader(new InputStreamReader(content));
            jsonResponse = in.readLine();
            connection.disconnect();
        } catch (NumberFormatException | IOException e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en consultar el servicio para modificar un usuario-entidad-rol ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return jsonResponse;
    }
    //</editor-fold>

    //<editor-fold defaultstate="collapsed" desc="Insertar usuario-entidad">
    public static String insertUsuarioEntidad(String json) throws IOException {
        String jsonResponse = "";
        try {
            URL url = new URL(Constantes.PREFIJO + Constantes.IP + "/" + Constantes.SERVICIO + "/ws/tbusuariosentidad");
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
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en consultar el servicio para insertar un usuario-entidad-rol ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return jsonResponse;
    }
    //</editor-fold>
    
    //<editor-fold defaultstate="collapsed" desc="Terminar todos los usuarios entidad fecha fin">
    public static String terminarUsuarioEntidadCedula(String cedula) {
        String result = "";
        try {
            URL url = new URL(Constantes.PREFIJO + Constantes.IP + "/" + Constantes.SERVICIO + "/ws/terminarallusuarioentidad/" + cedula);
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
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en consultar el servicio para terminar la asignacion usuario entidad fecha fin ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return result;
    }
    //</editor-fold>
    
    //<editor-fold defaultstate="collapsed" desc="Listar usuario-entidades-rol por cedula">
    public static String totalUsuarioEntidadCedula(String cedula) {
        String result = "";
        try {
            URL url = new URL(Constantes.PREFIJO + Constantes.IP + "/" + Constantes.SERVICIO + "/ws/totalusuarioentidadrol/" + cedula);
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
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en consultar el servicio para lista total de usuario-entidad-rol ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return result;
    }
    //</editor-fold>
    
}
