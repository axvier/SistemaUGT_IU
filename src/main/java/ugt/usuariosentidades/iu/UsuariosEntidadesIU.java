package ugt.usuariosentidades.iu;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.List;
import ugt.entidades.Tbusuariosentidad;
import ugt.entidades.listas.UsuariosEntidadesL;

/**
 *
 * @author Xavy PC
 */
public class UsuariosEntidadesIU extends UsuariosEntidadesL{
    public void setListaJSON(String arrayJSON) {
        if (arrayJSON.length() > 0) {
            Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd'T'HH:mm:ss").create();
            Type listType = new TypeToken<ArrayList<Tbusuariosentidad>>() {
            }.getType();
            List<Tbusuariosentidad> lista = gson.fromJson(arrayJSON, listType);
            this.setLista(lista);
        }
    }
}
