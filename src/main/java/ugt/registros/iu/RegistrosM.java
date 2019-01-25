/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ugt.registros.iu;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonSyntaxException;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import ugt.entidades.Tbordenesmovilizaciones;
import ugt.entidades.Tbregistros;
import ugt.entidades.Tbsolicitudes;
import ugt.entidades.Tbusuariosentidad;
import ugt.servicios.swRegistros;
import ugt.servicios.swSeccionSolicitante;
import utg.login.Login;

/**
 * Clase para insertar los registros de modificaciones de los documentos
 * solicitudes y ordenes
 *
 * @author Xavy PC
 */
public class RegistrosM {

    /**
     * Método estatico para insertar el registro de cambio de la solicitud
     *
     * @param login define la persona quien realizo el cambio con su rol
     * @param entity define la clase solicitud a la que se ha echo los cambios
     * @return result define el valor del rtegistro en formato json string
     */
    //<editor-fold defaultstate="collapsed" desc="Insertar registro tbsolicitudes">
    public static String Insertar(Login login, Tbsolicitudes entity) {
        String result = "";
        try {
            Gson g = new GsonBuilder().setDateFormat("yyyy-MM-dd'T'HH:mm:ss-05:00").create();
            Tbregistros registro = new Tbregistros();
            registro.setFecha(today());
            registro.setAccion(entity.getEstado());
            registro.setIdregistro(0);
            registro.setIdtabla(entity.getNumero().toString());
            insertResponbale(login, registro);
            registro.setTabla(entity.getClass().getSimpleName());
            result = swRegistros.insertRegistro(g.toJson(registro));
        } catch (ParseException | IOException e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemmas en insertar registro modelo ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return result;
    }

    //</editor-fold>
    /**
     * Método estatico para insertar el registro de cambio de la orden
     * movilizacion
     *
     * @param login define la persona quien realizo el cambio con su rol
     * @param entity define la clase orden de movilizacion a la que se ha echo
     * los cambios
     * @return result define el valor del rtegistro en formato json string
     */
    //<editor-fold defaultstate="collapsed" desc="Insertar registro tbordenes">
    public static String Insertar(Login login, Tbordenesmovilizaciones entity) {
        String result = "";
        try {
            Gson g = new GsonBuilder().setDateFormat("yyyy-MM-dd'T'HH:mm:ss-05:00").create();
            Tbregistros registro = new Tbregistros();
            registro.setFecha(today());
            registro.setAccion(entity.getSolicitud().getEstado()+"+"+entity.getNumeroOrden());
            registro.setIdregistro(0);
            registro.setIdtabla(entity.getNumeroOrden());
            insertResponbale(login, registro);
            registro.setTabla(entity.getClass().getSimpleName());
            result = swRegistros.insertRegistro(g.toJson(registro));
        } catch (ParseException | IOException e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemmas en insertar registro modelo ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
        return result;
    }
    //</editor-fold>

    /**
     * Método statico privado para extraer la fecha actual en formato date
     *
     * @return date extrae date actual
     */
    private static Date today() throws ParseException {
        Calendar today = Calendar.getInstance();
        SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss-05:00");
        Date date = sf.parse(sf.format(today.getTime()));
        return date;
    }

    /**
     * Método static para insertar el responblae del cambio en calidad de un rol
     * y entidad determinado
     *
     * @param login define persona que realizo el cambio
     * @param registro define el registro donde se realizara el cambio
     */
    private static void insertResponbale(Login login, Tbregistros registro) {
        Gson g = new GsonBuilder().setDateFormat("yyyy-MM-dd'T'HH:mm:ss-05:00").create();
        try {
            if (login.getRolActivo() != null && login.getRolActivo().getIdrol() != null) {
                String idrol = login.getRolActivo().getIdrol().toString();
                String cedula = login.getRolesEntity().get(0).getTbusuarios().getCedula();
                String nombres = login.getRolesEntity().get(0).getTbusuarios().getApellidos() + " "
                        + login.getRolesEntity().get(0).getTbusuarios().getNombres();
                String objJSONSolicitante = swSeccionSolicitante.buscarEntidadSolicitante(cedula, idrol);
                if (objJSONSolicitante.length() > 2) {
                    Tbusuariosentidad entidadRol = g.fromJson(objJSONSolicitante, Tbusuariosentidad.class);
                    registro.setResponsable(cedula + "-"
                            + nombres + "-"
                            + entidadRol.getTbroles().getDescripcion() + " "
                            + entidadRol.getTbentidad().getNombre());
                }
            }
        } catch (JsonSyntaxException e) {
            Logger.getAnonymousLogger().log(Level.SEVERE, "problemmas en insertar responbale en registro ", e.getClass().getName() + "****" + e.getMessage());
            System.err.println("ERROR: " + e.getClass().getName() + "***" + e.getMessage());
        }
    }
}
