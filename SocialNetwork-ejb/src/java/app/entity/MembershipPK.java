/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package app.entity;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.validation.constraints.NotNull;

/**
 *
 * @author Administrator
 */
@Embeddable
public class MembershipPK implements Serializable {

    @Basic(optional = false)
    @NotNull
    @Column(name = "id_user")
    private int idUser;
    @Basic(optional = false)
    @NotNull
    @Column(name = "id_party")
    private int idParty;
    @Basic(optional = false)
    @Column(name = "id")
    private int id;

    public MembershipPK() {
    }

    public MembershipPK(int idUser, int idParty, int id) {
        this.idUser = idUser;
        this.idParty = idParty;
        this.id = id;
    }

    public int getIdUser() {
        return idUser;
    }

    public void setIdUser(int idUser) {
        this.idUser = idUser;
    }

    public int getIdParty() {
        return idParty;
    }

    public void setIdParty(int idParty) {
        this.idParty = idParty;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (int) idUser;
        hash += (int) idParty;
        hash += (int) id;
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof MembershipPK)) {
            return false;
        }
        MembershipPK other = (MembershipPK) object;
        if (this.idUser != other.idUser) {
            return false;
        }
        if (this.idParty != other.idParty) {
            return false;
        }
        if (this.id != other.id) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "app.entity.MembershipPK[ idUser=" + idUser + ", idParty=" + idParty + ", id=" + id + " ]";
    }
    
}
