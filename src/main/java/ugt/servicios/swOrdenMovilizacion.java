/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
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
public class swOrdenMovilizacion {

    //<editor-fold defaultstate="collapsed" desc="Listar ordenez de movilizacion">
    public static String listarOrdenesMovilizaciones() {
        String result = "";
        try {
            URL url = new URL(Constantes.PREFIJO + Constantes.IP + "/" + Constantes.SERVICIO + "/ws/tbordenesmovilizaciones");
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
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en consultar el servicio para listar todas las ordenes de movilizacion ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return result;
    }
    //</editor-fold>
    
    //<editor-fold defaultstate="collapsed" desc="Listar ordenez de movilizacion">
    public static String listarOrdenesFullSol() {
        String result = "";
        try {
            URL url = new URL(Constantes.PREFIJO + Constantes.IP + "/" + Constantes.SERVICIO + "/ws/blistaordenfullsol");
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
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en consultar el servicio para listar todas las ordenes de movilizacion con datos solicitud", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return result;
    }
    //</editor-fold>

    //<editor-fold defaultstate="collapsed" desc="Buscar orden de movilizacion por id"> 
    public static String listarOrdenMovilizacionID(String id) {
        String result = "";
        try {
            URL url = new URL(Constantes.PREFIJO + Constantes.IP + "/" + Constantes.SERVICIO + "/ws/tbordenesmovilizaciones/" + id);
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
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en consultar el servicio para buscar una orde de movilizacion con id ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return result;
    }
    //</editor-fold>

    //<editor-fold defaultstate="collapsed" desc="Elinminar orden de movilisacion con un id">
    public static String eliminarOrdenMovilizacion(String id) {
        String resul = "";
        URL url = null;
        try {
            url = new URL(Constantes.PREFIJO + Constantes.IP + "/" + Constantes.SERVICIO + "/ws/tbordenesmovilizaciones/" + id);
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
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en consultar el servicio para eliminar una orden de movilizacion con id ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        } finally {
            if (httpURLConnection != null) {
                httpURLConnection.disconnect();
            }
        }
        return resul;
    }
    //</editor-fold>

    //<editor-fold defaultstate="collapsed" desc="Modificar orden de movilizacion con id">
    public static String modificaOrdenMovilizacionID(String id, String json) {
        String jsonResponse = "";
        try {
            URL url = new URL(Constantes.PREFIJO + Constantes.IP + "/" + Constantes.SERVICIO + "/ws/tbordenesmovilizaciones/" + id);
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
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en consultar el servicio para modificar una orden de movilizacion con id", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return jsonResponse;
    }
    //</editor-fold>

    //<editor-fold defaultstate="collapsed" desc="Insertar orden de movilizacion y retornar datos">
    public static String insertOrdenMovilizacion(String json) throws IOException {
        String jsonResponse = "";
        try {
            URL url = new URL(Constantes.PREFIJO + Constantes.IP + "/" + Constantes.SERVICIO + "/ws/tbordenesmovilizaciones");
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
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en consultar el servicio insertar una orden de movilizacion ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return jsonResponse;
    }
    //</editor-fold>
    
    //<editor-fold defaultstate="collapsed" desc="filtar orden movilizacion por idSolicitud"> 
    public static String filtarOrdenMovilizacionIDSol(String id) {
        String result = "";
        try {
            URL url = new URL(Constantes.PREFIJO + Constantes.IP + "/" + Constantes.SERVICIO + "/ws/bordenesmovilizacionsol/" + id);
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
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en consultar el servicio para buscar una orden de movilizacion con id solicitud", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return result;
    }
    //</editor-fold>
}
