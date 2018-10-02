/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servicios;


import java.io.BufferedReader;
import java.io.*;
import java.net.*;
import java.util.ArrayList;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class WSCentralizada {

    //<editor-fold defaultstate="collapsed" desc="Consumo Datos Clientes">
    public static String BuscarPersona(String strCedula) throws JSONException {
        String strJson = "";
        try {
            //SERVICIO
            URL url = new URL("http://servicioscentral.espoch.edu.ec/Central/ServiciosPersona.svc/ObtenerPorDocumento/" + strCedula);
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("GET");
            connection.setDoOutput(true);
            connection.setDoInput(true);
             InputStream content = (InputStream) connection.getInputStream();
            BufferedReader in = new BufferedReader(new InputStreamReader(content,"UTF-8"));
            String line;
           
            while ((line = in.readLine()) != null) {
                strJson = line;
            }
            connection.disconnect();
        } catch (NumberFormatException | IOException ex) {
            System.out.println("Fallort");
        }
        return strJson;
    }

//</editor-fold>
    //<editor-fold defaultstate="collapsed" desc="Documentos Personales">
    public static String DocumentoPersonal(String strCedula) throws JSONException {
        String strJson = "";
        try {
            //SERVICIO
            URL url = new URL("http://servicioscentral.espoch.edu.ec/Central/ServiciosDocumentoPersonal.svc/ObtenerPorDocumento/" + strCedula);
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("GET");
            connection.setDoOutput(true);
            connection.setDoInput(true);
            InputStream content = (InputStream) connection.getInputStream();
            BufferedReader in = new BufferedReader(new InputStreamReader(content,"UTF-8"));
            String line;
           
            while ((line = in.readLine()) != null) {
                strJson = line;
            }
            connection.disconnect();
        } catch (NumberFormatException | IOException ex) {
            System.out.println("Fallort");
        }
        return strJson;
    }

//</editor-fold>
    //<editor-fold defaultstate="collapsed" desc="Direcciones Personales">
    public static String DireccionPersona(long IdPersona) throws JSONException {
        String strJson = "";
        try {
            //SERVICIO
            URL url = new URL("http://servicioscentral.espoch.edu.ec/Central/ServiciosDireccion.svc/ObtenerSegunPersona/" + IdPersona);
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("GET");
            connection.setDoOutput(true);
            connection.setDoInput(true);
             InputStream content = (InputStream) connection.getInputStream();
            BufferedReader in = new BufferedReader(new InputStreamReader(content,"UTF-8"));
            String line;
           
            while ((line = in.readLine()) != null) {
                strJson = line;
            }
            connection.disconnect();
        } catch (NumberFormatException | IOException ex) {
            System.out.println("Fallort");
        }
        return strJson;
    }

//</editor-fold>
   
}
