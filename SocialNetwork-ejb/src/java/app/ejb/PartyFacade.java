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
 * @author Raúl
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
    
     public void insertGroup(String name, int user_id) {
        Query query = getEntityManager().createNativeQuery("INSERT INTO Party (name,owner) VALUES ('" 
                + name +  "', " + user_id + ")");
        query.executeUpdate();
    }
    public List<Party> findByIdOwner(int idowner){
        Query q;
        q=this.em.createQuery("select p from Party p where p.owner.id =:idowner");
        q.setParameter("idowner",idowner  );
        return q.getResultList();
        
    }
     
}
