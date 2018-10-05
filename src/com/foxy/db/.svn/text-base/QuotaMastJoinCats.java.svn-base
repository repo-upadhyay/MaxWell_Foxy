/*
 * QuotaMastJoinCats.java
 *
 * Created on June 30, 2006, 6:52 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package com.foxy.db;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;
import java.util.List;
import java.util.ArrayList;

/**
 *
 * @author hcting
 */
public class QuotaMastJoinCats extends QuotaMast implements Serializable {
    
    private Set<QuotaCats> catsBean = new HashSet();
    private List catBeanList = null;
    
    
    /** Creates a new instance of Farameter */
    public QuotaMastJoinCats() {
    }
    
    public Set<QuotaCats> getCatsBean() {
        return catsBean;
    }
    
    public void setCatsBean(Set<QuotaCats> catsBean) {
        this.catsBean = catsBean;
    }
    
    public List getCatBeanList(){
        //System.err.println("Calling to get cats bean ...");
        try {
            if ( catBeanList == null){
                catBeanList = new ArrayList(catsBean);
                //System.err.println("Number of cat = ["+ catBeanList.size() + "]");
            }
        } catch (Exception e){
            e.printStackTrace();
        }
        return catBeanList;
    }
}
