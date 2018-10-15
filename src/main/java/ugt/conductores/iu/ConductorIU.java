/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ugt.conductores.iu;

import java.util.Date;
import ugt.entidades.Tbconductores;

/**
 *
 * @author Usuario
 */
public class ConductorIU extends Tbconductores {

    public ConductorIU() {
    }

    public ConductorIU(String cedula, String nombres, String apellidos, Date fechanac) {
        super(cedula, nombres, apellidos, fechanac);
    }

    public String toHTML() {
        String result = "";

        String span = "<span class='input-group-addon deleteid' id=" + this.getCedula() + " onclick='eliminarConductor(this);'><i class='fa fa-minus-circle'></i></span>"
                + "<span class='input-group-addon'  onclick=editarConductor(this);><i class='fa fa-edit'></i></span>";
        result += "<div class='nb2'><div class='card'>";
        result += "<div class='input-group'>"
                + "<input type='text' class='form-control' readonly value='" + this.getNombres() + " " + this.getApellidos() + " " + "'>"
                + span
                + "</div>";
        result += "<div class='contenidoConductor' id='" + this.getCedula() + "' style='display: none;'> "
                + "            <div class='input-group cedula'>"
                + "                 <span class='input-group-addon' style='width: 15%; text-align: left;' id='basic-addon1'>Cédula</span>"
                + "                 <input type='text' readonly onkeypress='return validaLetras(event);'  id='cedula' class='form-control' placeholder='0987654387' value='" + this.getCedula() + "' aria-describedby='basic-addon1'>"
                + "            </div>"
                + "             <div class='input-group nombres'>"
                + "                 <span class='input-group-addon' style='width: 15%; text-align: left;' id='basic-addon1'>Nombres</span>"
                + "                 <input type='text' class='form-control' onkeypress='return validaLetras(event);' id='nombres' placeholder='Nombre' value='" + this.getNombres() + "' aria-describedby='basic-addon1'>"
                + "             </div>"
                + "             <div class='input-group apellidos'>"
                + "                 <span class='input-group-addon' style='width: 15%; text-align: left;' id='basic-addon1'>Apellidos</span>"
                + "                 <input type='text' class='form-control' onkeypress='return validaLetras(event);' id='apellidos' placeholder='Apellido' value='" + this.getApellidos() + "' aria-describedby='basic-addon1'>"
                + "             </div>"
                + "             <div class='input-group fecha'>"
                + "                    <span class='input-group-addon' style='width: 15%; text-align: left;' id='basic-addon1'>Fecha</span>"
                + "                    <input type='date' class='form-control' id='fecha' onkeypress='return validarNumeros(event);' value='" + this.getFechanac() + "' aria-describedby='basic-addon1'>"
                + "             </div>"
                + "             <div class='input-group genero'>"
                + "                    <span class='input-group-addon' style='width: 15%; text-align: left;' id='basic-addon1'>Género</span>"
                + "                    <input type='text' class='form-control' id='genero' value='" + this.getGenero() + "' aria-describedbDiay='basic-addon1'>"
                + "             </div>"
                + "<button title='' class='btn btn-primary float-xs-right' onclick='guardarConductor(this);' id=''  type='button' data-original-title='Agregar Conductor' data-toggle='tooltip' data-placement='top'>"
                + "Modificar"
                + "</button>"
                + "<br><br>"
                + "    </div>"
                + "    </div></div>"
                + "";

        return result;
    }
}
