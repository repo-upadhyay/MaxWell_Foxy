/*
 * Menu.java
 *
 * Created on June 21, 2006, 3:59 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package com.foxy.db;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 *
 * @author eric
 */
public class MenuTreeList implements Serializable {
    private String menuCode;
    private String menuParent;
    private String menuName;
    private String action;
    private Set subMenus = new HashSet();
    private List subMenuList = null;
    
    /** Creates a new instance of Menu */
    public MenuTreeList() {
    }
    
    
    public boolean isSubMenuEmpty(){
        if ( subMenus.isEmpty() ) {
            return true;
        } else {
            return false;
        }
    }
    
    
    public List getSubMenuList(){
        if ( subMenuList == null ){
            subMenuList = new ArrayList(subMenus);
        }
        return subMenuList;
    }
    
    
    public Set getSubMenus(){
        return this.subMenus;
    }
    
    public void setSubMenus(Set submenus) {
        this.subMenus =  submenus;
    }
    
    //PROPERTY: menuCode
    public String getMenuCode(){
        return this.menuCode;
    }
    public void setMenuCode(String newValue) {
        this.menuCode = newValue;
    }
    //PROPERTY: menuParent
    public String getMenuParent(){
        return this.menuParent;
    }
    public void setMenuParent(String newValue) {
        this.menuParent = newValue;
    }
    //PROPERTY: menuName
    public String getMenuName(){
        return this.menuName;
    }
    public void setMenuName(String newValue) {
        this.menuName = newValue;
    }
    //PROPERTY: action
    public String getAction(){
        return this.action;
    }
    public void setAction(String newValue) {
        this.action = newValue;
    }
}
