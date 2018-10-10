package ugt.opciones.iu;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.List;
import ugt.entidades.Tbopciones;
import ugt.entidades.listas.OpcionesL;

/**
 *
 * @author Xavy PC
 */
public class OpcionesIU extends OpcionesL {

    public void setListaJSON(String arrayJSON) {
        if (arrayJSON.length() > 2) {
            Gson gson = new Gson();
            Type listType = new TypeToken<ArrayList<Tbopciones>>() {
            }.getType();
            List<Tbopciones> lista = gson.fromJson(arrayJSON, listType);
            this.setLista(lista);
        }
    }

    public String htmlMenu() {
        String HTML = "";
        for (Tbopciones opcion : this.getLista()) {
            switch (opcion.getIdopcion()) {
                case 1: //Menu Gestion roles - usuarios - opciones
//                    HTML += getHTMLMenuGestionRolesUsuariosOpciones(opcion.getNombre());
                    break;
            }
        }
        return HTML;
    }
    
//    private String getHTMLMenuGestionRolesUsuariosOpciones(String opcion){
//        
//    }
}
