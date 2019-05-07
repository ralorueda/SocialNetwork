/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package app.entity;

import java.io.Serializable;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Administrator
 */
@Entity
@Table(name = "membership")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Membership.findAll", query = "SELECT m FROM Membership m")
    , @NamedQuery(name = "Membership.findByIdUser", query = "SELECT m FROM Membership m WHERE m.membershipPK.idUser = :idUser")
    , @NamedQuery(name = "Membership.findByIdParty", query = "SELECT m FROM Membership m WHERE m.membershipPK.idParty = :idParty")
    , @NamedQuery(name = "Membership.findById", query = "SELECT m FROM Membership m WHERE m.membershipPK.id = :id")})
public class Membership implements Serializable {

    private static final long serialVersionUID = 1L;
    @EmbeddedId
    protected MembershipPK membershipPK;
    @JoinColumn(name = "id_party", referencedColumnName = "id", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private Party party;
    @JoinColumn(name = "id_user", referencedColumnName = "id", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private User user;

    public Membership() {
    }

    public Membership(MembershipPK membershipPK) {
        this.membershipPK = membershipPK;
    }

    public Membership(int idUser, int idParty, int id) {
        this.membershipPK = new MembershipPK(idUser, idParty, id);
    }

    public MembershipPK getMembershipPK() {
        return membershipPK;
    }

    public void setMembershipPK(MembershipPK membershipPK) {
        this.membershipPK = membershipPK;
    }

    public Party getParty() {
        return party;
    }

    public void setParty(Party party) {
        this.party = party;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (membershipPK != null ? membershipPK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Membership)) {
            return false;
        }
        Membership other = (Membership) object;
        if ((this.membershipPK == null && other.membershipPK != null) || (this.membershipPK != null && !this.membershipPK.equals(other.membershipPK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "app.entity.Membership[ membershipPK=" + membershipPK + " ]";
    }
    
}
