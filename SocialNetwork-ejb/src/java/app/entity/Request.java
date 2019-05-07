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
@Table(name = "request")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Request.findAll", query = "SELECT r FROM Request r")
    , @NamedQuery(name = "Request.findByUser1Id", query = "SELECT r FROM Request r WHERE r.requestPK.user1Id = :user1Id")
    , @NamedQuery(name = "Request.findByUser2Id", query = "SELECT r FROM Request r WHERE r.requestPK.user2Id = :user2Id")
    , @NamedQuery(name = "Request.findById", query = "SELECT r FROM Request r WHERE r.requestPK.id = :id")})
public class Request implements Serializable {

    private static final long serialVersionUID = 1L;
    @EmbeddedId
    protected RequestPK requestPK;
    @JoinColumn(name = "user1_id", referencedColumnName = "id", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private User user;
    @JoinColumn(name = "user2_id", referencedColumnName = "id", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private User user1;

    public Request() {
    }

    public Request(RequestPK requestPK) {
        this.requestPK = requestPK;
    }

    public Request(int user1Id, int user2Id, int id) {
        this.requestPK = new RequestPK(user1Id, user2Id, id);
    }

    public RequestPK getRequestPK() {
        return requestPK;
    }

    public void setRequestPK(RequestPK requestPK) {
        this.requestPK = requestPK;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public User getUser1() {
        return user1;
    }

    public void setUser1(User user1) {
        this.user1 = user1;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (requestPK != null ? requestPK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Request)) {
            return false;
        }
        Request other = (Request) object;
        if ((this.requestPK == null && other.requestPK != null) || (this.requestPK != null && !this.requestPK.equals(other.requestPK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "app.entity.Request[ requestPK=" + requestPK + " ]";
    }
    
}
