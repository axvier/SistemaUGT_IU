package ugt.vehiculos.iu;

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.List;
import ugt.entidades.Tbvehiculos;

import ugt.entidades.listas.VehiculosL;

/**
 *
 * @author Evelyn
 */
public class VehiculosIU extends VehiculosL {

    public void setListaJson(String arrayJSON){
    if (arrayJSON.length() > 0) {
            Gson gson = new Gson();
            Type listType = new TypeToken<ArrayList<Tbvehiculos>>() {
            }.getType();
            List<Tbvehiculos> lista=gson.fromJson(arrayJSON, listType);
            this.setVehiculo(lista); 
    }
    }
    
    public String Vehiculos(String opc) {
        String result = "";
        if (opc.equals("vehiculosConfg")) {

            result += "<form>"
                    + "<div class='form-group row'>"
                    + "<label id='seccionEtiqueta' value='otro' for='example-text-input' class='form-control-label'></label>"
                    + "<div id='seccionContenido' class='col-xs-12'>" //seccion boton y la lista
                    + "<div class='float-xs-right pr-0'>"//boton vehiculos
                    + "<button type='button' class='btn btn-primary' id='basica' data-toggle='collapse' href='#collapseBibliografiaB' aria-expanded='false' aria-controls='collapseBibliografiaB'>"
                    + "<i class='fa fa-plus-circle'></i>"
                    + "Veh&iacute;culos"
                    + "</button>"
                    + "</div>"//div del boton
                    + "<div id='BibliografiaBasica' class='bibliografia3'>"
                    + "<br><br><div class='collapse nb' id='collapseBibliografiaB'><div class='card card-block form-group'>"
                    + "                <div class='input-group delete' style='background-color: rgb(0,65,127); color: #ffffff;'>"
                    + "                  <label>Nuevo Vehiculo</label>"
                    + "                <span class='deleteid' aria-hidden='true' id='0'></span>"
                    + "                </div>";
            result += "<div class='contenidoVehiculo' id='0'>"
                    + "             <div class='input-group vehiculo'>"
                    + "                 <span class='input-group-addon' style='width: 15%; text-align: left;' id='basic-addon1'>Vehiculo</span>"
                    + "                 <input type='text' class='form-control' onkeypress='return validaLetras(event);' id='vehiculo' placeholder='Nombres del Vehiculo' aria-describedby='basic-addon1'>"
                    + "             </div>"
                    + ""
                    + "                 <input type='hidden' class='tipoBibliografia' value='sitio'>"
                    + "            <div class='input-group placa'>"
                    + "                 <span class='input-group-addon' style='width: 15%; text-align: left;' id='basic-addon1'>Placa vehiculo</span>"
                    + "                 <input type='text' onkeypress='return validaLetras(event);'  id='placa' class='form-control' placeholder='AAA-123' aria-describedby='basic-addon1'>"
                    + "            </div>"
                    + "             <div class='input-group anio'>"
                    + "                    <span class='input-group-addon' style='width: 15%; text-align: left;' id='basic-addon1'>A&ntilde;o</span>"
                    + "                    <input type='text' class='form-control' id='anio' onkeypress='return validarNumeros(event);' placeholder='2018' aria-describedby='basic-addon1'>"
                    + "             </div>"
                    + "             <div class='input-group disco'>"
                    + "                    <span class='input-group-addon' style='width: 15%; text-align: left;' id='basic-addon1'>Disco/Facultad</span>"
                    + "                    <input type='text' class='form-control' id='disco' placeholder='Disco que se maneja en el departamente' aria-describedbDiay='basic-addon1'>"
                    + "             </div>"
                    + "<button title='' class='btn btn-primary float-xs-right' onclick='guardarVehiculo(this);' id=''  type='button' data-original-title='Agregar Vehiculo' data-toggle='tooltip' data-placement='top'>"
                    + "Agregar"
                    + "</button>"
                    + "</div></div></div>";

            for (Tbvehiculos vehiculos : this.getVehiculo()){ //trae la lista de vehiculos
            result +=getContenidoVehiculos(vehiculos);
            }
            result += "</div>"
                    + "</div>"
                    + "</form>";
        }
        return result;
    }

    public String getContenidoVehiculos(Tbvehiculos vehiculos) {
        String result = "";

        String span = "<span class='input-group-addon deleteid' id=" + vehiculos.getPlaca() + " onclick='eliminarVehiculo(this);'><i class='fa fa-minus-circle'></i></span>"
                + "<span class='input-group-addon'  onclick=editarVehiculo(this);><i class='fa fa-edit'></i></span>"
                + "<span class='input-group-addon'  onclick=listaConductores(this);><i class='fa fa-user'></i></span>";
        result += "<div class='nb2'><div class='card'>";
        result += "<div class='input-group'>"
                + "<input type='text' class='form-control' readonly value='" + vehiculos.getDescripcion() + "(" + vehiculos.getAnio() + ")" + "'>"
                + span
                + "</div>";
        String disabled = "";
        result += "<div class='contenidoVehiculo' id='" + vehiculos.getPlaca() + "' style='display: none;'> "
                + "            <div class='input-group placa'>"
                + "                 <span class='input-group-addon' style='width: 15%; text-align: left;' id='basic-addon1'>Placa vehiculo</span>"
                + "                 <input type='text' readonly onkeypress='return validaLetras(event);'  id='placa' class='form-control' placeholder='AAA-123' value='" + vehiculos.getPlaca() + "' aria-describedby='basic-addon1'>"
                + "            </div>"
                + "             <div class='input-group vehiculo'>"
                + "                 <span class='input-group-addon' style='width: 15%; text-align: left;' id='basic-addon1'>Vehiculo</span>"
                + "                 <input type='text' class='form-control' onkeypress='return validaLetras(event);' id='vehiculo' placeholder='Descripcion del Vehiculo' value='" + vehiculos.getDescripcion() + "' aria-describedby='basic-addon1'>"
                + "             </div>"
                + "             <div class='input-group anio'>"
                + "                    <span class='input-group-addon' style='width: 15%; text-align: left;' id='basic-addon1'>A&ntilde;o</span>"
                + "                    <input type='text' class='form-control' id='anio' onkeypress='return validarNumeros(event);' placeholder='2018' value='" + vehiculos.getAnio() + "' aria-describedby='basic-addon1'>"
                + "             </div>"
                + "             <div class='input-group disco'>"
                + "                    <span class='input-group-addon' style='width: 15%; text-align: left;' id='basic-addon1'>Disco/Facultad</span>"
                + "                    <input type='text' class='form-control' id='disco' placeholder='Disco que se maneja en el departamente'value='" + vehiculos.getDisco() + "' aria-describedbDiay='basic-addon1'>"
                + "             </div>"
                + "<button title='' class='btn btn-primary float-xs-right' onclick='modificarVehiculo(this);' id=''  type='button' data-original-title='Agregar Vehiculo' data-toggle='tooltip' data-placement='top'>"
                + "Modificar"
                + "</button>"
                + "<br><br>"
                + "    </div>"
                + "    </div></div>"
                + "";

        return result;
    }
}
