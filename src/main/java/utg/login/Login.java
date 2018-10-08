package utg.login;

import java.util.ArrayList;
import java.util.List;
import ugt.entidades.Tbroles;
import ugt.entidades.Tbusuariosentidad;

/**
 *
 * @author Xavy PC
 */
public class Login {
    private List<Tbusuariosentidad> RolesEntity= new ArrayList<>();
    private Tbroles rolActivo = new Tbroles();

    public List<Tbusuariosentidad> getRolesEntity() {
        return RolesEntity;
    }

    public void setRolesEntity(List<Tbusuariosentidad> RolesEntity) {
        this.RolesEntity = RolesEntity;
    }

    public Tbroles getRolActivo() {
        return rolActivo;
    }

    public void setRolActivo(Tbroles rolActivo) {
        this.rolActivo = rolActivo;
    }
    
}
