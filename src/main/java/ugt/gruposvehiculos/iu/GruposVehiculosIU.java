package ugt.gruposvehiculos.iu;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.List;
import ugt.entidades.Tbgrupovehiculos;
import ugt.entidades.listas.GrupoVehiculosL;

/**
 *
 * @author Xavy PC
 */
public class GruposVehiculosIU extends GrupoVehiculosL {

    public void setListaJSON(String arrayJSON) {
        if (arrayJSON.length() > 0) {
            Gson gson = new Gson();
            Type listType = new TypeToken<ArrayList<Tbgrupovehiculos>>() {
            }.getType();
            List<Tbgrupovehiculos> lista = gson.fromJson(arrayJSON, listType);
            this.setLista(lista);
        }
    }
}
