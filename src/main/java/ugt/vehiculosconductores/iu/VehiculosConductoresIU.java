/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ugt.vehiculosconductores.iu;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.List;
import ugt.entidades.Tbvehiculosconductores;
import ugt.entidades.listas.VehiculosConductoresL;

/**
 *
 * @author Xavy PC
 */
public class VehiculosConductoresIU extends VehiculosConductoresL {

    public void setListaJSON(String arrayJSON) {
        if (arrayJSON.length() > 0) {
            Gson gson = new Gson();
            Type listType = new TypeToken<ArrayList<Tbvehiculosconductores>>() {
            }.getType();
            List<Tbvehiculosconductores> lista = gson.fromJson(arrayJSON, listType);
            this.setLista(lista);
        }
    }
}
