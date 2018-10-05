/*
 * AuditInterceptor.java
 *
 * Created on September 15, 2006, 9:06 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package com.foxy.db;

import java.io.Serializable;
import java.util.Date;
import java.util.Iterator;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.CallbackException;
import org.hibernate.EntityMode;
import org.hibernate.Interceptor;
import org.hibernate.Transaction;
import org.hibernate.type.Type;
import javax.faces.context.FacesContext;
import javax.faces.context.ExternalContext;


/**
 * Audit inteceptor so any Hibernate insert or update will update the
 * CREATED_USER and MODIFIED_USER as well as CREATED_DATE on inserts.
 * <p>
 * Copyright: Copyright (c) 2006
 * Company: Melloware, Inc.
 * @author Emil A. Lefkof III
 * @version 4.0
 * @see com.melloware.jukes.db.audit.Auditable
 */
public class AuditInterceptor implements Interceptor,Serializable {
    
    private static final Log LOG = LogFactory.getLog(AuditInterceptor.class);
    
    /**
     * Default constructor
     */
    public AuditInterceptor() {
        super();
        LOG.info("AuditInterceptor is created.");
    }
    
    public String getCurrenUserId(){
        String userid = null;
        ExternalContext ectx = FacesContext.getCurrentInstance().getExternalContext();
        if ( ectx != null){
            userid = ectx.getRemoteUser();
        }
        if ( userid == null){
            userid = "null";
        }
        return  userid;
    }
    
    /* (non-Javadoc)
     * @see org.hibernate.Interceptor#getEntity(java.lang.String, java.io.Serializable)
     */
    public Object getEntity(String arg0, Serializable arg1)
    throws CallbackException {
        return null;
    }
    
    /* (non-Javadoc)
     * @see org.hibernate.Interceptor#getEntityName(java.lang.Object)
     */
    public String getEntityName(Object arg0)
    throws CallbackException {
        return null;
    }
    
    /* (non-Javadoc)
     * @see org.hibernate.Interceptor#isTransient(java.lang.Object)
     */
    public Boolean isTransient(Object arg0) {
        return null;
    }
    
    /* (non-Javadoc)
     * @see org.hibernate.Interceptor#afterTransactionBegin(org.hibernate.Transaction)
     */
    public void afterTransactionBegin(Transaction arg0) {
        // do nothing
        
    }
    
    /* (non-Javadoc)
     * @see org.hibernate.Interceptor#afterTransactionCompletion(org.hibernate.Transaction)
     */
    public void afterTransactionCompletion(Transaction arg0) {
        // do nothing
        
    }
    
    /* (non-Javadoc)
     * @see org.hibernate.Interceptor#beforeTransactionCompletion(org.hibernate.Transaction)
     */
    public void beforeTransactionCompletion(Transaction arg0) {
        // do nothing
        
    }
    
    /* (non-Javadoc)
     * @see org.hibernate.Interceptor#findDirty(java.lang.Object, java.io.Serializable, java.lang.Object[],
     * java.lang.Object[], java.lang.String[], org.hibernate.type.Type[])
     */
    public int[] findDirty(Object arg0, Serializable arg1, Object[] arg2, Object[] arg3, String[] arg4, Type[] arg5) {
        return null;
    }
    
    /* (non-Javadoc)
     * @see org.hibernate.Interceptor#instantiate(java.lang.String, org.hibernate.EntityMode, java.io.Serializable)
     */
    public Object instantiate(String arg0, EntityMode arg1, Serializable arg2)
    throws CallbackException {
        return null;
    }
    
    /* (non-Javadoc)
     * @see org.hibernate.Interceptor#onCollectionRecreate(java.lang.Object, java.io.Serializable)
     */
    public void onCollectionRecreate(Object arg0, Serializable arg1)
    throws CallbackException {
        // do nothing
        
    }
    
    /* (non-Javadoc)
     * @see org.hibernate.Interceptor#onCollectionRemove(java.lang.Object, java.io.Serializable)
     */
    public void onCollectionRemove(Object arg0, Serializable arg1)
    throws CallbackException {
        // do nothing
    }
    
    /* (non-Javadoc)
     * @see org.hibernate.Interceptor#onCollectionUpdate(java.lang.Object, java.io.Serializable)
     */
    public void onCollectionUpdate(Object arg0, Serializable arg1)
    throws CallbackException {
        // do nothing
        
    }
    
    /* (non-Javadoc)
     * @see org.hibernate.Interceptor#onDelete(java.lang.Object, java.io.Serializable, java.lang.Object[],
     * java.lang.String[], org.hibernate.type.Type[])
     */
    public void onDelete(Object arg0, Serializable arg1, Object[] arg2, String[] arg3, Type[] arg4)
    throws CallbackException {
        // do nothing
        
    }
    
    //Called during update records
    public boolean onFlushDirty(Object entity,
            Serializable id,
            Object[] currentState,
            Object[] previousState,
            String[] propertyNames,
            Type[] types)
            throws CallbackException {
        
        boolean result = false;
        
        if (entity instanceof Auditable) {
            int delUsrIdIdx = -1;
            int delTimeIdx = -1;
            int statusIdx = -1;
            
            for (int i = 0; i < propertyNames.length; i++) {
                
                if ("updUsrId".equals(propertyNames[i])) {//Update user id who update this bean
                    currentState[i] = this.getCurrenUserId();
                    result = true;
                    
                } else if ("updTime".equals(propertyNames[i])) {//Update time stamp
                    currentState[i] = new Date();
                    result = true;
                    
                } else if ("status".equals(propertyNames[i])) {
                    statusIdx = i; //Keep the array index for later used
                    result = true;
                    
                } else if ("delUsrId".equals(propertyNames[i])) {
                    delUsrIdIdx = i;//Keep the array index for later used
                    result = true;
                    
                } else if ("delTime".equals(propertyNames[i])) {
                    delTimeIdx = i;//Keep the array index for later used
                    result = true;
                }
            }//end for loop
            
            if ( statusIdx >= 0){ //Only this column found/exist then do, else dont do anythings (-1)
                if ( "D".equals(currentState[statusIdx])) {
                    if ( delTimeIdx >= 0){ //Only this column found/exist then do, else dont do anythings (-1)
                        currentState[delTimeIdx] = new Date();
                    }
                    
                    if ( delUsrIdIdx >= 0 ){//Only this column found/exist then do, else dont do anythings (-1)
                        currentState[delUsrIdIdx] = this.getCurrenUserId();
                    }
                }else {
                    if ( delTimeIdx >= 0){//Only this column found/exist then do, else dont do anythings (-1)
                        currentState[delTimeIdx] = null;
                    }
                    
                    if ( delUsrIdIdx >= 0 ){//Only this column found/exist then do, else dont do anythings (-1)
                        currentState[delUsrIdIdx] = null;
                    }
                }
            }
        }
        return result;
    }
    
    /* (non-Javadoc)
     * @see org.hibernate.Interceptor#onLoad(java.lang.Object, java.io.Serializable, java.lang.Object[],
     * java.lang.String[], org.hibernate.type.Type[])
     */
    public boolean onLoad(Object arg0, Serializable arg1, Object[] arg2, String[] arg3, Type[] arg4)
    throws CallbackException {
        return false;
    }
    
    /* (non-Javadoc)
     * @see org.hibernate.Interceptor#onPrepareStatement(java.lang.String)
     */
    public String onPrepareStatement(String arg0) {
        return arg0;
    }
    
    public boolean onSave(Object entity, Serializable id, Object[] state, String[] propertyNames, Type[] types)
    throws CallbackException {
        
        boolean result = false;
        
        if (entity instanceof Auditable) {
            for (int i = 0; i < propertyNames.length; i++) {
                if ("insUsrId".equals(propertyNames[i])) {
                    //System.err.println("Audit Interceptor assign insUsrId = " + this.getCurrenUserId());
                    state[i] = this.getCurrenUserId();
                    result = true;
                }
                if (("insTime".equals(propertyNames[i])) && (state[i] == null)) {
                    state[i] = new Date();
                    result = true;
                }
            }
        }else{
            Class cl = entity.getClass();
            //System.err.println("Not auditable entity detected by interceptor!! [" + cl.getName()  + "]");
        }
        return result;
    }
    
    /* (non-Javadoc)
     * @see org.hibernate.Interceptor#postFlush(java.util.Iterator)
     */
    public void postFlush(Iterator arg0)
    throws CallbackException {
        // do nothing
        
    }
    
    /* (non-Javadoc)
     * @see org.hibernate.Interceptor#preFlush(java.util.Iterator)
     */
    public void preFlush(Iterator arg0)
    throws CallbackException {
        // do nothing
        
    }
    
}
