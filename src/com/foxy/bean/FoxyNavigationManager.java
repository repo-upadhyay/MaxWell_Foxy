/*
 * FoxyNaviationManager.java
 *
 * Created on June 16, 2006, 11:09 AM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package com.foxy.bean;

import javax.faces.application.NavigationHandler;
import javax.faces.context.FacesContext;

/**
 *
 * @author eric
 */
public class FoxyNavigationManager extends NavigationHandler {
    public static final String RETURN_BACK = "!returnBack";
    public static final String LOGIN_GLOBAL = "globalLogin";
    
    NavigationHandler _base;
    String actionNameCurrent;
    String actionMethodCurrent;
    
    /** Creates a new instance of FoxyNaviationManager */
    public FoxyNavigationManager(NavigationHandler base) {
        super();
        _base = base;
    }
    
    public void handleNavigation(FacesContext fc, String actionMethod, String actionName) {
        actionNameCurrent = actionName;
        actionMethodCurrent = actionMethod;
        
        /*System.out.println(this.actionNameCurrent);
        System.out.println(this.actionMethodCurrent);*/
        
        _base.handleNavigation(fc, actionMethodCurrent, actionNameCurrent);
    }
    
}
