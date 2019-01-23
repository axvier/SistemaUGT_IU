/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ugt.reportes.iu;

import com.google.gson.Gson;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.json.Json;
import javax.json.JsonObject;
import org.json.JSONArray;
import org.json.JSONObject;
import ugt.reportes.ConductoresRepEstado;

/**
 *
 * @author Xavy PC
 */
public class ConductoresReporteEstadosIU extends ConductoresRepEstado {

    public String generarPIEEstados() {
        String result = "";
        try {
            JSONObject objPie = new JSONObject();
            List<String> labels = new ArrayList<>();
            labels.add("Disponibles");
            labels.add("Fijados");
            labels.add("Indispuestos");
            labels.add("Jubilados");
            objPie.put("labels",new Gson().toJson(labels));

            /**
             * Ingresar obj datasets
             */
            JSONObject objDatasets = new JSONObject();
            objDatasets.put("label", "Estado");
            labels = new ArrayList<>();
            labels.add("#4FE60B");//color disponibles
            labels.add("#0B95E6");//color ocupados
            labels.add("#FBF70D");//color indispuestos
            labels.add("#FB2D0D");//color jubilados
            objDatasets.put("backgroundColor", new Gson().toJson(labels));
            objDatasets.put("borderColor", new Gson().toJson(labels));
            
            List<Integer> data = new ArrayList<>();
            data.add(this.getDisponibles());//total disponibles
            data.add(this.getOcupados());//total ocupados
            data.add(this.getIndispuestos());//total indispuestos
            data.add(this.getJubilados());//total jubilados
            objDatasets.put("data", new Gson().toJson(data));
            objDatasets.put("borderWidth", "1");
            /**Fin ingreso obj datasets*/
            objPie.put("datasets", objDatasets);
            result = objPie.toString();
        } catch (Exception e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemas en generar el grafico de pastel estados conductores ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return result;
    }
}
