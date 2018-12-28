package ugt.viajepasajero.iu;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.List;
import ugt.entidades.Tbviajepasajero;
import ugt.entidades.listas.ViajesPasajerosL;

/**
 *
 * @author Xavy PC
 */
public class ViajesPasajerosIU extends ViajesPasajerosL {

    public void setListaJSON(String arrayJSON) {
        if (arrayJSON.length() > 0) {
            Gson gson = new Gson();
            Type listType = new TypeToken<ArrayList<Tbviajepasajero>>() {
            }.getType();
            List<Tbviajepasajero> lista = gson.fromJson(arrayJSON, listType);
            this.setLista(lista);
        }
    }

    public Tbviajepasajero existeItemID(String cedula, Integer idviaje) {
        Tbviajepasajero result = null;
        for (Tbviajepasajero search : this.getLista()) {
            if (search.getTbviajepasajeroPK().getCedulap().equals(cedula) && search.getTbviajepasajeroPK().getIdviaje() == idviaje) {
                result = search;
                break;
            }
        }
        return result;
    }
}
