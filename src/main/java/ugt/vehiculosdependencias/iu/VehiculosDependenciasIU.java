/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ugt.vehiculosdependencias.iu;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.List;
import ugt.entidades.Tbvehiculosdependencias;
import ugt.entidades.listas.VehiculosDependenciasL;

/**
 *
 * @author Xavy PC
 */
public class VehiculosDependenciasIU extends VehiculosDependenciasL{

    public void setListaJson(String arrayJSON) {
        if (arrayJSON.length() > 0) {
            Gson gson = new Gson();
            Type listType = new TypeToken<ArrayList<Tbvehiculosdependencias>>() {
            }.getType();
            List<Tbvehiculosdependencias> lista = gson.fromJson(arrayJSON, listType);
            this.setLista(lista);
        }
    }
}
