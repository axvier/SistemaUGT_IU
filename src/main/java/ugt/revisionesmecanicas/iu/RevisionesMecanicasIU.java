package ugt.revisionesmecanicas.iu;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.List;
import ugt.entidades.Tbrevisionesmecanicas;
import ugt.entidades.listas.RevisionesMecanicasL;

/**
 * Clase hija hereda de RevisionesmecnicasL para su tratamiento en IU
 *
 * @author Xavy PC
 */
public class RevisionesMecanicasIU extends RevisionesMecanicasL {

    /**
     * Método que define el ingreso de una lista en formtato strign JSON, hacia
     * el atributo lista heredado de la super clase RevisionesMecanicasL
     *
     * @param arrayJSON
     */
    public void setListaJSON(String arrayJSON) {
        if (arrayJSON.length() > 0) {
            Gson gson = new Gson();
            Type listType = new TypeToken<ArrayList<Tbrevisionesmecanicas>>() {
            }.getType();
            List<Tbrevisionesmecanicas> lista = gson.fromJson(arrayJSON, listType);
            this.setLista(lista);
        }
    }
}
