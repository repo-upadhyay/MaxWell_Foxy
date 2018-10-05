/*
 * ProdScheduleJoinLots.java
 *
 * Created on June 30, 2006, 6:52 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package com.foxy.db;

import java.io.Serializable;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;
import java.util.List;
import java.util.ArrayList;
import java.util.Iterator;
import java.text.SimpleDateFormat;

/**
 *
 * @author hcting
 */
public class ProdScheduleJoinLots extends ProdSchedule implements Serializable {
    
    private Set<ProdScheduleLots> lotsBean = new HashSet();
    private List lotBeanList = null;
    
    
    /** Creates a new instance of Farameter */
    public ProdScheduleJoinLots() {
    }
    
    public Set<ProdScheduleLots> getLotsBean() {
        return lotsBean;
    }
    
    public void setLotsBean(Set<ProdScheduleLots> lotsBean) {
        this.lotsBean = lotsBean;
    }
    
    public List getLotBeanList(){
        //System.err.println("Calling to get lots bean ...");
        try {
            if ( lotBeanList == null  && lotsBean != null){
                lotBeanList = new ArrayList(lotsBean);
                //System.err.println("Number of lots = ["+ lotBeanList.size() + "]");
            }
        } catch (Exception e){
            e.printStackTrace();
        }
        return lotBeanList;
    }
    
    public String getLotsString(){
        String str = null;
        ProdScheduleLots tmplot = null;
        
        Iterator it = lotsBean.iterator();
        while ( it.hasNext() ){
            tmplot = (ProdScheduleLots)it.next();
            if ( str == null){
                str = tmplot.getLot();
            }else{
                str = str + "/" + tmplot.getLot();
            }
        }
        return str;
    }
    
    public String getVesselDateRange(){
        SimpleDateFormat sdf1 = new SimpleDateFormat("MM/dd");
        Date vStart = null;
        Date vEnd = null;
        Date tmpDate = null;
        String str = null;
        ProdScheduleLots tmplot = null;
        
        Iterator it = lotsBean.iterator();
        while ( it.hasNext() ){
            tmplot = (ProdScheduleLots)it.next();
            tmpDate = tmplot.getVesselDate();
            
            if (vStart == null ){//First object and initialise
                vStart = tmpDate;
                vEnd = vStart;
            } else {
                if ( vStart.after(tmpDate)){
                    vStart = tmpDate;
                    continue;
                }
                if ( vEnd.before(tmpDate)){
                    vEnd = tmpDate;
                    continue;
                }
            }
        }//end while
        str = sdf1.format(vStart) + " - " + sdf1.format(vEnd);
        return str;
    }
    
    
    public String getSewDateRange(){
        SimpleDateFormat sdf1 = new SimpleDateFormat("MM/dd");
        String str = null;
        str = sdf1.format(this.getSewStart()) + " - " + sdf1.format(this.getSewEnd());
        return str;
    }
}
