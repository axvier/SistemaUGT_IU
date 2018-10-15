package ugt.conductores.iu;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.List;
import ugt.entidades.Tbconductores;
import ugt.entidades.listas.ConductoresL;

/**
 *
 * @author Xavier Aranda
 */
public class ConductoresIU extends ConductoresL{

    public void setListaJSON(String arrayJSON) {
        if (arrayJSON.length() > 0) {
            Gson gson = new Gson();
            Type listType = new TypeToken<ArrayList<Tbconductores>>() {
            }.getType();
            List<Tbconductores> lista = gson.fromJson(arrayJSON, listType);
            this.setListaconductores(lista);
        }
    }
    
    public String toHTML(){
        String result = "";
        result += "<form>"
                + "<div class='form-group row'>"
                + "<label id='seccionEtiqueta' value='otro' for='example-text-input' class='form-control-label'></label>"
                + "<div id='seccionContenido' class='col-xs-12'>" //seccion boton y la lista
                + "<div class='float-xs-right pr-0'>"//boton vehiculos
                + "<button type='button' class='btn btn-primary' id='basica' data-toggle='collapse' href='#collapseBibliografiaB' aria-expanded='false' aria-controls='collapseBibliografiaB'>"
                + "<i class='fa fa-plus-circle'></i>"
                + "Conductor"
                + "</button>"
                + "</div>"//div del boton
                + "<div id='BibliografiaBasica' class='bibliografia3'>"
                + "<br><br><div class='collapse nb' id='collapseBibliografiaB'><div class='card card-block form-group'>"
                + "                <div class='input-group delete' style='background-color: rgb(0,65,127); color: #ffffff;'>"
                + "                  <label>Nuevo Conductor</label>"
                + "                <span class='deleteid' aria-hidden='true' id='0'></span>"
                + "                </div>";
        result += "<div class='contenidoConductor' id='0'>" //
                + ""
                + "            <div class='input-group cedula'>"
                + "                 <span class='input-group-addon' style='width: 15%; text-align: left;' id='basic-addon1'>Cedula</span>"
                + "                 <input type='text' onkeypress='return validaLetras(event);'  id='cedula' class='form-control' placeholder='0908765432' aria-describedby='basic-addon1'>"
                + "            </div>"
                + "             <div class='input-group nombres'>"
                + "                 <span class='input-group-addon' style='width: 15%; text-align: left;' id='basic-addon1'>Nombres</span>"
                + "                 <input type='text' class='form-control' onkeypress='return validaLetras(event);' id='nombres' placeholder='Nombres del conductor' aria-describedby='basic-addon1'>"
                + "             </div>"
                + "             <div class='input-group apellidos'>"
                + "                 <span class='input-group-addon' style='width: 15%; text-align: left;' id='basic-addon1'>Apellidos</span>"
                + "                 <input type='text' class='form-control' onkeypress='return validaLetras(event);' id='apellidos' placeholder='Apellidos del conductor' aria-describedby='basic-addon1'>"
                + "             </div>"
                + "             <div class='input-group fecha'>"
                + "                    <span class='input-group-addon' style='width: 15%; text-align: left;' id='basic-addon1'>Fecha</span>"
                + "                    <input type='date' class='form-control' id='fecha' onkeypress='return validarNumeros(event);' value='' placeholder='1992-12-04' aria-describedby='basic-addon1'>"
                + "             </div>"
                + "             <div class='input-group genero'>"
                + "                    <span class='input-group-addon' style='width: 15%; text-align: left;' id='basic-addon1'>Genero</span>"
                + "                    <select class='form-control' id='genero'>"
                + "                         <option value='' selected disabled hidden>Elija una opcion</option>"
                + "                         <option value='Masculino'> Masculino</option>"
                + "                         <option value='Femenino'> Femenino</option>"
                + "                         <option value='Otros'> Otros</option>"
                + "                     </select>"
                + "             </div>"
                + "<button title='' class='btn btn-primary float-xs-right' onclick='guardarConductor(this);' id=''  type='button' data-original-title='Agregar Vehiculo' data-toggle='tooltip' data-placement='top'>"
                + "Agregar"
                + "</button>"
                + "</div></div></div>";

        for (Tbconductores conductor : this.getListaconductores()) {
            ConductorIU auxconductor = new ConductorIU(conductor.getCedula(), conductor.getNombres(), conductor.getApellidos(), conductor.getFechanac());
            auxconductor.setGenero(conductor.getGenero());
            result += auxconductor.toHTML();
        }
        
        result += "</div>"
                + "</div>"
                + "</form>";
        return result;
    }

}