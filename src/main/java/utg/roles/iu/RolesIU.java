package utg.roles.iu;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.List;
import ugt.entidades.Tbroles;
import ugt.entidades.listas.RolesL;

/**
 *
 * @author Xavy PC
 */
public class RolesIU extends RolesL {

    public void setListaJSON(String arrayJSON) {
        if (arrayJSON.length() > 2) {
            Gson gson = new Gson();
            Type listType = new TypeToken<ArrayList<Tbroles>>() {
            }.getType();
            List<Tbroles> lista = gson.fromJson(arrayJSON, listType);
            this.setLista(lista);
        }
    }
}
