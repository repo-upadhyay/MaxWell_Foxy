/*
 * Auditable.java
 *
 * Created on September 15, 2006, 9:37 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package com.foxy.db;


import java.util.Date;

/**
 * A marker interface for auditable persistent domain classes.  Classes that
 * implement this interface will have their user and date information updated
 * on creation or modification in the database using the Hibernate Interceptor
 * called AuditInterceptor.
 * <p>
 * Copyright: Copyright (c) 2006
 * Company: Melloware, Inc.
 * @author Emil A. Lefkof III
 * @version 4.0
 * @see com.melloware.jukes.db.audit.AuditInterceptor
 */
public interface Auditable {
    
    public Date getInsTime();
    
    public String getInsUsrId();
    
    public Date getUpdTime();
    
    public String getUpdUsrId();
    
    public Date getDelTime();
    
    public String getDelUsrId();
    
    
    public void setInsTime(Date insTime);
    
    public void setInsUsrId(String insUsrId);
    
    public void setUpdTime(Date updTime);
    
    public void setUpdUsrId(String updUsrId);
    
    public void setDelTime(Date delTime);
    
    public void setDelUsrId(String delUsrId);
    
}
