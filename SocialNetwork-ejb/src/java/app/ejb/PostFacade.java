/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package app.ejb;

import app.entity.Post;
import java.util.Date;
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
public class PostFacade extends AbstractFacade<Post> {

    @PersistenceContext(unitName = "SocialNetwork-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public PostFacade() {
        super(Post.class);
    }

    public List<Post> findFriendsPostsByUserId(int id) {
        Query query;
        query = em.createQuery("select distinct p from Post p join Friendship f where (f.user.id = p.author.id and f.user1.id = :id) "
                + "or (f.user1.id = p.author.id and f.user.id = :id) or (p.author.id = :id) order by p.date desc");
        query.setParameter("id", id);
        if (query.getResultList().isEmpty()) {
            return null;
        } else {
            return query.getResultList();
        }
    }

    public List<Post> findMyPosts(int id) {
        Query query;
        query = em.createQuery("select p from Post p where p.author.id = :id order by p.date desc");
        query.setParameter("id", id);
        if (query.getResultList().isEmpty()) {
            return null;
        } else {
            return query.getResultList();
        }
    }

    public Integer getNextId() {
        Query query;
        query = em.createQuery("select max(p.id) from Post p");
        Integer number = (Integer) query.getSingleResult();
        if (number == null) {
            number = 0;
        }
        return number + 1;
    }

    public void insertPost(Post post) {
        post.setId(this.getNextId());
        post.setDate(new Date());
        this.create(post);
    }

}
