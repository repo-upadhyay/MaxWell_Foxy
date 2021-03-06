/*
 * HibernateUtil.java
 *
 * Created on June 15, 2006, 7:03 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package com.foxy.db;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

/**
 *
 * @author eric
 */
public class HibernateUtilInternal {
    
    /** Creates a new instance of HibernateUtil */
    public HibernateUtilInternal() {
    }
    
    private static Log log = LogFactory.getLog(HibernateUtilInternal.class);
    
    private static final SessionFactory sessionFactory;
    
    static {
        try {
            // Create the SessionFactory
            sessionFactory = new Configuration().configure().buildSessionFactory();
        } catch (Throwable ex) {
            log.error("Initial SessionFactory creation failed.", ex);
            ex.printStackTrace();
            throw new ExceptionInInitializerError(ex);
        }
    }
    
    public static final ThreadLocal session = new ThreadLocal();
    
    
    public static Session currentSession() throws HibernateException {
        Session s = (Session) session.get();
        // Open a new Session, if this Thread has none yet
        if (s == null) {
            s = sessionFactory.openSession(new AuditInterceptor());
            session.set(s);
        }
        return s;
    }    
    
    public static void closeSession() throws HibernateException {
        Session s = (Session) session.get();
        session.set(null);
        if (s != null)
            s.close();
    }
    
}
