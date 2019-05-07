/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package app.ejb;

import app.entity.User;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

/**
 *
 * @author Raúl
 */
@Stateless
public class UserFacade extends AbstractFacade<User> {

    @PersistenceContext(unitName = "SocialNetwork-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public UserFacade() {
        super(User.class);
    }

    public User findByUsername(String username) {
        Query query = getEntityManager().createNativeQuery("SELECT * FROM User WHERE username = '" + username + "'", User.class);
        if (query.getResultList().isEmpty()) {
            return null;
        } else {
            return (User) query.getResultList().get(0);
        }
    }

    public void insertUser(String name, String surnames, String username, String password, String email, String birthdate, int rol_id) {
        Query query = getEntityManager().createNativeQuery("INSERT INTO User (name, surnames, username, password, email, birthdate, rol_id) VALUES ('" 
                + name + "', '" + surnames + "', '" + username + "', '" + password + "', '" + email + "', '" + birthdate + "', " + rol_id + ")");
        query.executeUpdate();
    }
    
        public void insertUser(User u, String birthdate) {
        
              Query q =  getEntityManager().createNativeQuery("INSERT INTO User (name, surnames, username, password, email, birthdate, rol_id) VALUES (?,?,?,?,?,?,?)")
      .setParameter(1, u.getName())
      .setParameter(2, u.getSurnames())
      .setParameter(3, u.getUsername())
      .setParameter(4, u.getPassword())
      .setParameter(5, u.getEmail())
      .setParameter(6, birthdate)
      .setParameter(7, 2);
      
          q.executeUpdate();
    }

    public void updateUser(String name, String surnames, String username, String password, String email, String birthdate, String currentUsername) {
        Query query = getEntityManager().createNativeQuery("UPDATE User SET name='" + name + "', surnames ='" + surnames + "', username = '" + username + "', password = '"
                + password + "', email = '" + email + "', birthdate = '" + birthdate + "' WHERE username = '" + currentUsername + "'");
        query.executeUpdate();
    }
    
}
