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
@Table(name = "friendship")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Friendship.findAll", query = "SELECT f FROM Friendship f")
    , @NamedQuery(name = "Friendship.findByUser1Id", query = "SELECT f FROM Friendship f WHERE f.friendshipPK.user1Id = :user1Id")
    , @NamedQuery(name = "Friendship.findByUser2Id", query = "SELECT f FROM Friendship f WHERE f.friendshipPK.user2Id = :user2Id")
    , @NamedQuery(name = "Friendship.findById", query = "SELECT f FROM Friendship f WHERE f.friendshipPK.id = :id")})
public class Friendship implements Serializable {

    private static final long serialVersionUID = 1L;
    @EmbeddedId
    protected FriendshipPK friendshipPK;
    @JoinColumn(name = "user1_id", referencedColumnName = "id", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private User user;
    @JoinColumn(name = "user2_id", referencedColumnName = "id", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private User user1;

    public Friendship() {
    }

    public Friendship(FriendshipPK friendshipPK) {
        this.friendshipPK = friendshipPK;
    }

    public Friendship(int user1Id, int user2Id, int id) {
        this.friendshipPK = new FriendshipPK(user1Id, user2Id, id);
    }

    public FriendshipPK getFriendshipPK() {
        return friendshipPK;
    }

    public void setFriendshipPK(FriendshipPK friendshipPK) {
        this.friendshipPK = friendshipPK;
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
        hash += (friendshipPK != null ? friendshipPK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Friendship)) {
            return false;
        }
        Friendship other = (Friendship) object;
        if ((this.friendshipPK == null && other.friendshipPK != null) || (this.friendshipPK != null && !this.friendshipPK.equals(other.friendshipPK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "app.entity.Friendship[ friendshipPK=" + friendshipPK + " ]";
    }
    
}
