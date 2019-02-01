/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ugt.cargos.iu;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.List;
import ugt.entidades.Tbcargos;
import ugt.entidades.listas.CargosL;

/**
 *
 * @author Xavy PC
 */
public class CargosIU extends CargosL{
    public void setListaJSON(String arrayJSON) {
        if (arrayJSON.length() > 0) {
            Gson gson = new Gson();
            Type listType = new TypeToken<ArrayList<Tbcargos>>() {
            }.getType();
            List<Tbcargos> lista = gson.fromJson(arrayJSON, listType);
            this.setLista(lista);
        }
    }
}
