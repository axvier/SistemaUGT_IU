package ugt.rolesopciones.IU;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.List;
import ugt.entidades.Tbrolesopciones;
import ugt.entidades.listas.RolesOpcionesL;

/**
 *
 * @author Xavy PC
 */
public class RolesOpcionesIU extends RolesOpcionesL {

    public void setListaJSON(String arrayJSON) {
        if (arrayJSON.length() > 0) {
            Gson gson = new Gson();
            Type listType = new TypeToken<ArrayList<Tbrolesopciones>>() {
            }.getType();
            List<Tbrolesopciones> lista = gson.fromJson(arrayJSON, listType);
            this.setLista(lista);
        }
    }
}
