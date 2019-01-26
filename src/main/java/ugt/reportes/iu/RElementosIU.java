package ugt.reportes.iu;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.List;
import ugt.entidades.listas.RElementosL;
import ugt.reportes.RElemento;

/**
 *
 * @author Xavy PC
 */
public class RElementosIU extends RElementosL{
     /**
     * Método que define el ingreso de una lista en formtato strign JSON, hacia
     * el atributo lista heredado de la super clase RelementosL
     *
     * @param arrayJSON
     */
    public void setListaJSON(String arrayJSON) {
        if (arrayJSON.length() > 0) {
            Gson gson = new Gson();
            Type listType = new TypeToken<ArrayList<RElemento>>() {
            }.getType();
            List<RElemento> lista = gson.fromJson(arrayJSON, listType);
            this.setLista(lista);
        }
    }
}
