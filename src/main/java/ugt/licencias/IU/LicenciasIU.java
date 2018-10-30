package ugt.licencias.IU;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.List;
import ugt.entidades.Tblicencias;
import ugt.entidades.listas.LicenciasL;

/**
 *
 * @author Xavy PC
 */
public class LicenciasIU extends LicenciasL{
     public void setListaJSON(String arrayJSON) {
        if (arrayJSON.length() > 0) {
            Gson gson = new Gson();
            Type listType = new TypeToken<ArrayList<Tblicencias>>() {
            }.getType();
            List<Tblicencias> lista = gson.fromJson(arrayJSON, listType);
            this.setLista(lista);
        }
    }
}
