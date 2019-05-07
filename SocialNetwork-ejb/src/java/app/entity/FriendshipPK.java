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
public class FriendshipPK implements Serializable {

    @Basic(optional = false)
    @NotNull
    @Column(name = "user1_id")
    private int user1Id;
    @Basic(optional = false)
    @NotNull
    @Column(name = "user2_id")
    private int user2Id;
    @Basic(optional = false)
    @Column(name = "id")
    private int id;

    public FriendshipPK() {
    }

    public FriendshipPK(int user1Id, int user2Id, int id) {
        this.user1Id = user1Id;
        this.user2Id = user2Id;
        this.id = id;
    }

    public int getUser1Id() {
        return user1Id;
    }

    public void setUser1Id(int user1Id) {
        this.user1Id = user1Id;
    }

    public int getUser2Id() {
        return user2Id;
    }

    public void setUser2Id(int user2Id) {
        this.user2Id = user2Id;
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
        hash += (int) user1Id;
        hash += (int) user2Id;
        hash += (int) id;
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof FriendshipPK)) {
            return false;
        }
        FriendshipPK other = (FriendshipPK) object;
        if (this.user1Id != other.user1Id) {
            return false;
        }
        if (this.user2Id != other.user2Id) {
            return false;
        }
        if (this.id != other.id) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "app.entity.FriendshipPK[ user1Id=" + user1Id + ", user2Id=" + user2Id + ", id=" + id + " ]";
    }
    
}
