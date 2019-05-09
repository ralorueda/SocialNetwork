/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package app.ejb;

import app.entity.Friendship;
import app.entity.User;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

/**
 *
 * @author Administrator
 */
@Stateless
public class FriendshipFacade extends AbstractFacade<Friendship> {

    @PersistenceContext(unitName = "SocialNetwork-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public FriendshipFacade() {
        super(Friendship.class);
    }
    
    public List<User> findFriendsListById(int userID) {
        Query query;
        query = this.getEntityManager().createQuery("select u from User u join Friendship f where (f.user.id =:id and f.user1.id = u.id) or (f.user1.id =:id and f.user.id = u.id)");
        query.setParameter("id", userID);
        return query.getResultList();
    }

    public Friendship findFriendshipById(int userId, int friendId) {
        Query query;
        query = this.getEntityManager().createQuery("select f from Friendship f where (f.user.id =:friendId and f.user1.id =:userId) or (f.user1.id =:friendId and f.user.id =:userId)");
        query.setParameter("friendId", friendId);
        query.setParameter("userId", userId);
        return (Friendship) query.getSingleResult();
    }

}
