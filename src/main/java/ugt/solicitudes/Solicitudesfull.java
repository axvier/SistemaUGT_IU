package ugt.solicitudes;

import java.util.List;
import ugt.entidades.Tbdisponibilidadvc;
import ugt.entidades.Tbseccionmotivo;
import ugt.entidades.Tbseccionsolicitantes;
import ugt.entidades.Tbseccionviajes;
import ugt.entidades.Tbsolicitudes;
import ugt.entidades.Tbviajepasajero;

/**
 *
 * @author Xavy PC
 */
public class Solicitudesfull{

    private Tbsolicitudes solicitud;
    private Tbseccionmotivo motivo;
    private Tbseccionviajes viaje;
    private Tbseccionsolicitantes solicitante;
    private List<Tbviajepasajero> pasajeros;
    private Tbdisponibilidadvc disponibilidadvc;

    public Tbsolicitudes getSolicitud() {
        return solicitud;
    }

    public List<Tbviajepasajero> getPasajeros() {
        return pasajeros;
    }

    public void setPasajeros(List<Tbviajepasajero> pasajeros) {
        this.pasajeros = pasajeros;
    }

    public Tbdisponibilidadvc getDisponibilidadvc() {
        return disponibilidadvc;
    }

    public void setDisponibilidadvc(Tbdisponibilidadvc disponibilidadvc) {
        this.disponibilidadvc = disponibilidadvc;
    }

    public Tbseccionmotivo getMotivo() {
        return motivo;
    }

    public void setMotivo(Tbseccionmotivo motivo) {
        this.motivo = motivo;
    }

    public Tbseccionviajes getViaje() {
        return viaje;
    }

    public void setViaje(Tbseccionviajes viaje) {
        this.viaje = viaje;
    }

    public Tbseccionsolicitantes getSolicitante() {
        return solicitante;
    }

    public void setSolicitante(Tbseccionsolicitantes solicitante) {
        this.solicitante = solicitante;
    }

    public void setSolicitud(Tbsolicitudes sol) {
        this.solicitud = sol;
    }

}
