/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package app.ejb;

import app.entity.Party;
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
public class PartyFacade extends AbstractFacade<Party> {

    @PersistenceContext(unitName = "SocialNetwork-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public PartyFacade() {
        super(Party.class);
    }

    public List<Party> findByIdOwner(int idowner) {
        Query q;
        q = this.em.createQuery("select p from Party p where p.owner.id =:idowner");
        q.setParameter("idowner", idowner);
        return q.getResultList();

    }

    public List<Party> findByIdOwnerAndIdMember(int idUser) {
        Query q;
        q = this.em.createQuery("select distinct p from Party p join Membership m where (m.party.id = p.id and ((m.user.id =:id) or (p.owner.id =:id))) or (p.owner.id =:id) order by p.name");
        q.setParameter("id", idUser);
        return q.getResultList();
    }

    public Integer getNextId() {
        Query query;
        query = em.createQuery("select max(p.id) from Party p");
        Integer number = (Integer) query.getSingleResult();
        if (number == null) {
            number = 0;
        }
        return number + 1;
    }

    public void insertGroup(Party group) {
        group.setId(getNextId());
        this.create(group);
    }

}
