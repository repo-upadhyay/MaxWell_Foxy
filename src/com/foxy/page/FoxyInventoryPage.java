/*
 * FoxyInventoryPage.java
 *
 * Created on June 20, 2006, 6:18 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package com.foxy.page;

import javax.faces.application.FacesMessage;
import com.foxy.db.Inventory;
import com.foxy.db.Supplier;
import com.foxy.data.FoxyInventoryList;
import com.foxy.db.HibernateUtil;
import com.foxy.util.FoxyPagedDataModel;
import com.foxy.util.ListData;
import java.io.Serializable;
import java.util.List;
import java.util.ArrayList;
import javax.faces.model.DataModel;
import javax.faces.model.SelectItem;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.Criteria;
import org.hibernate.criterion.Expression;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.Query;


/**
 *
 * @author hcting
 */
public class FoxyInventoryPage extends Page implements Serializable{
    private static String MENU_CODE = new String("FOXY");
    
    private DataModel ListModel;
    private List  supplierList = null;
    private Inventory inventoryBean = null;
    private Double tmpForexRate = null;
    private Double inputForexRate = null;
    private Double sgdForexRate = null;
    private String forexRateStr = null;
    
    /** Creates a new instance of FoxyInventoryPage */
    public FoxyInventoryPage() {
        super(new String("InventoryForm"));
        
        try {
            this.isAuthorize(MENU_CODE);
            //System.out.println(ctx.getApplication().getViewHandler().toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
        
    }
    
    
    public Double getTmpForexRate() {
        return tmpForexRate;
    }
    
    public void setTmpForexRate(Double tmpForexRate) {
        this.tmpForexRate = tmpForexRate;
    }
    
    public Inventory getInventoryBean() {
        if ( inventoryBean == null ){
            //System.err.println("Create new bean .....");
            inventoryBean = new Inventory();
        }
        
        return inventoryBean;
    }
    
    public void setInventoryBean(Inventory inventoryBean) {
        this.inventoryBean = inventoryBean;
    }
    
    
    public String getForexRateStr() {
        if ( forexRateStr == null){
            this.onCurCodeChange();
        }
        return forexRateStr;
    }
    
    public void setForexRateStr(String forexRateStr) {
        this.forexRateStr = forexRateStr;
    }
    
    
    public Inventory getDbEditInventoryBean() {
        
        if ( this.inventoryBean == null) {
            try {
                //System.err.println("Get Edit beans now .....for InventoryBean");
                Session session = (Session) HibernateUtil.currentSession();
                Transaction tx= session.beginTransaction();
                Criteria crit = session.createCriteria(Inventory.class);
                //System.err.println("Id = " + foxySessionData.getPageParameterLong());
                crit.add(Expression.eq("id", foxySessionData.getPageParameterLong()));
                List result = crit.list();
                //System.err.println("Result size = " + result.size());
                if ( result.size() > 0 ) {
                    this.inventoryBean = (Inventory)result.get(0);
                    this.tmpForexRate = this.inventoryBean.getForexrate();
                } else {
                    System.err.println("Inv No Inventory with invRefId = " + foxySessionData.getPageParameterLong());
                }
                tx.commit();
            } catch (HibernateException e) {
                //do something here with the exception
                e.printStackTrace();
                FacesMessage fmsg  = new FacesMessage(FacesMessage.SEVERITY_ERROR, e.getCause().toString(), e.getMessage());
                ctx.addMessage(null, fmsg);
            }catch (Exception e){
                e.printStackTrace();
                FacesMessage fmsg  = new FacesMessage(FacesMessage.SEVERITY_ERROR, e.getCause().toString(), e.getMessage());
                ctx.addMessage(null, fmsg);
            }finally {
                HibernateUtil.closeSession();
            }
        }
        return inventoryBean;
    }
    
    public void setDbEditInventoryBean(Inventory inventoryBean) {
        this.inventoryBean = inventoryBean;
    }
    
    
    public String saveAdd() {
        //System.out.println("Save Add");
        try {
            Session session = (Session) HibernateUtil.currentSession();
            Transaction tx= session.beginTransaction();
            inventoryBean.setUnitCost(inventoryBean.getBaseValue() / inventoryBean.getQuantity());
            inventoryBean.setForexrate(inventoryBean.getBaseValue()/inventoryBean.getValue());
            session.save(inventoryBean);
            this.foxySessionData.setPageParameterLong(inventoryBean.getId());
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
            FacesMessage fmsg  = new FacesMessage(FacesMessage.SEVERITY_ERROR, e.getCause().toString(), e.getMessage());
            ctx.addMessage(null, fmsg);
            e.printStackTrace();
            return null;
        }finally {
            HibernateUtil.closeSession();
        }
        
        return ("success");
    }
    
    public String editInventory(){
        return ("editinventory");
    }
    
    
    public String editInventoryDetail(){  //Refresh this bean and retrieve bean in getEditBean method
        this.foxySessionData.setPageParameterLong2(null);
        this.foxySessionData.setSessObject1(null);
        return ("editinventorydetail");
    }
    
    
    public String saveEdit() {
        //System.out.println("Save Edit");
        try {
            Session session = (Session) HibernateUtil.currentSession();
            Transaction tx= session.beginTransaction();
            inventoryBean.setUnitCost(inventoryBean.getBaseValue() / inventoryBean.getQuantity());
            inventoryBean.setForexrate(inventoryBean.getBaseValue()/inventoryBean.getValue());
            session.update(inventoryBean);
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
            FacesMessage fmsg  = new FacesMessage(FacesMessage.SEVERITY_ERROR, e.getCause().toString(), e.getMessage());
            ctx.addMessage(null, fmsg);
            return null;
        }finally {
            HibernateUtil.closeSession();
        }
        return ("success");
    }
    
    
    public String search() {
        this.foxySessionData.setAction(LST);
        foxyTable.setFirst(0);
        return (null);
    }
    
    public DataModel getInventoryList() {
        //Added in to get total row count
        Number numofRec = null;
        int firstrow = this.foxyTable.getFirst();
        int pagesize = this.foxyTable.getRows();
        ListData ld = (ListData)getBean("listData");
        
        
        if (this.searchKey != null) {
            String likestr = "%" +  this.searchKey.replace('*', '%') + "%";
            try {
                List result = null;
                Session session = (Session) HibernateUtil.currentSession();
                Transaction tx= session.beginTransaction();
                
                Criteria criteria = session.createCriteria(Inventory.class);
                //Get Total row count
                criteria.setProjection(Projections.rowCount());
                criteria.add(Expression.like("invoice", likestr));
                numofRec = ((Number) criteria.uniqueResult());
                tx.commit();
            } catch (HibernateException e) {
                e.printStackTrace();
                FacesMessage fmsg  = new FacesMessage(FacesMessage.SEVERITY_ERROR, e.getCause().toString(), e.getMessage());
                ctx.addMessage(null, fmsg);
            }catch (Exception e){
                e.printStackTrace();
                FacesMessage fmsg  = new FacesMessage(FacesMessage.SEVERITY_ERROR, e.getCause().toString(), e.getMessage());
                ctx.addMessage(null, fmsg);
            }finally {
                HibernateUtil.closeSession();
            }
            
            numofRec = numofRec == null ? 0 : numofRec.intValue();
            
            
            try {
                List result = null;
                if (this.searchKey != null) {
                    Session session = (Session) HibernateUtil.currentSession();
                    Transaction tx= session.beginTransaction();
                    Criteria criteria = session.createCriteria(Inventory.class);
                    criteria.add(Expression.like("invoice", likestr));
                    criteria.addOrder(Order.asc("invoiceDate"));
                    criteria.setFirstResult(firstrow);
                    criteria.setMaxResults(pagesize);
                    
                    result = criteria.list();
                    tx.commit();
                    for (int i = 0; i < result.size(); i ++ ){
                        Inventory inv = (Inventory) result.get(i);
                        FoxyInventoryList invl = new FoxyInventoryList();
                        invl.setId(inv.getId());
                        //invl.setRefIdInv(inv.getId());
                        invl.setInvoiceNumber(inv.getInvoice());
                        invl.setInvoiceDate(inv.getInvoiceDate());
                        invl.setSupplier(inv.getSupplier());
                        invl.setType(inv.getInvType());
                        invl.setInvtoryCode(inv.getInvCode());
                        invl.setQuantity(inv.getQuantity());
                        invl.setUnit(inv.getUnit());
                        invl.setInsDate(inv.getInsTime());
                        this.tableList.add(invl);
                    }
                    
                    if ( ListModel != null ){
                        ListModel = null;
                    }
                    
                    ListModel = (DataModel)new FoxyPagedDataModel(this.tableList, numofRec.intValue(), pagesize);
                }
            } catch (HibernateException e) {
                e.printStackTrace();
                FacesMessage fmsg  = new FacesMessage(FacesMessage.SEVERITY_ERROR, e.getCause().toString(), e.getMessage());
                ctx.addMessage(null, fmsg);
            }catch (Exception e){
                e.printStackTrace();
                FacesMessage fmsg  = new FacesMessage(FacesMessage.SEVERITY_ERROR, e.getCause().toString(), e.getMessage());
                ctx.addMessage(null, fmsg);
            }finally {
                HibernateUtil.closeSession();
            }
        }
        return ListModel;
    }
    
    
    public void setSupplierList(List supplierList) {
        this.supplierList = supplierList;
    }
    
    
    public  List getSupplierList() {
        //System.out.println( "Search supplier for [" + this.getInventoryType() + "]");
        if ( this.supplierList == null){
            this.supplierList = new ArrayList();
            
            if ( this.inventoryBean.getInvType() != null ) { //Items type, use it to get all relavent supplier list
                List resultList = null;
                try {
                    Session session = (Session) HibernateUtil.currentSession();
                    Transaction tx= session.beginTransaction();
                    Criteria crit = session.createCriteria(Supplier.class);
                    crit.add(Expression.eq("itemCode", this.inventoryBean.getInvType()));
                    crit.addOrder(Order.asc("supCode"));
                    resultList = crit.list();
                    //System.out.println( "Search supplier for [" + this.getInventoryType() + "] found count [" + resultList.size() + "]");
                    tx.commit();
                } catch (HibernateException e) {
                    //do something here with the exception
                    e.printStackTrace();
                    FacesMessage fmsg  = new FacesMessage(FacesMessage.SEVERITY_ERROR, e.getCause().toString(), e.getMessage());
                    ctx.addMessage(null, fmsg);
                }catch (Exception e){
                    e.printStackTrace();
                    FacesMessage fmsg  = new FacesMessage(FacesMessage.SEVERITY_ERROR, e.getCause().toString(), e.getMessage());
                    ctx.addMessage(null, fmsg);
                }finally {
                    HibernateUtil.closeSession();
                }
                
                if ( resultList.size() > 0){
                    this.supplierList.add(new SelectItem(new String(""), new String("Pls select one"))); //Always add a null items, event no records
                }else {
                    this.supplierList.add(new SelectItem(new String(""), new String("Empty"))); //Always add a null items, event no records
                }
                
                for (int i = 0; i < resultList.size(); i ++) {
                    Supplier sup = (Supplier)resultList.get(i);
                    this.supplierList.add(new SelectItem(sup.getSupCode(), sup.getSupCode() + " - " + sup.getSupName()));
                }
            }else {
                this.supplierList.add(new SelectItem(new String(""), new String("Empty"))); //Always add a null items, event no records
            }
        }
        return this.supplierList;
    }
    
    
    //action for ajax call
    public String onCurCodeChange() {
        //force to reset the supplier list
        this.tmpForexRate = super.getForexRate(this.inventoryBean.getCurrency(), this.inventoryBean.getInvoiceDate());
        //System.err.println("ForexRate - [" + this.tmpForexRate + "]");
        this.inputForexRate = super.getRawForexRate(this.inventoryBean.getCurrency(), this.inventoryBean.getInvoiceDate());
        this.sgdForexRate = super.getRawForexRate("SGD", this.inventoryBean.getInvoiceDate());
        
        this.forexRateStr = "Currency [ USD_TO_" + this.inventoryBean.getCurrency() +  " = " + this.inputForexRate + "] ";
        this.forexRateStr += "[USD_TO_SGD = " + this.sgdForexRate + "]";
        
        try {
            super.resetForexRate();
            this.inventoryBean.setBaseValue(null);
            
            if ( tmpForexRate != null && this.inventoryBean.getValue() != null){
                this.inventoryBean.setBaseValue(super.roundDouble(this.inventoryBean.getValue() * tmpForexRate, 2));
                //System.err.println("Base value is NOT null!! = [" + this.inventoryBean.getBaseValue() + "]");
            }
        } catch ( Exception e){
            e.printStackTrace();
            
        } finally {
        }
        
        return null; //Need to return null to disable page flow to take effect
    }
    
    
    //action for ajax call
    public String onItemTypeChange() {
        //force to reset the supplier list
        this.setSupplierList(null);
        return null; //Need to return null to disable page flow to take effect
    }
    
    
    public String searchs() {
        //this.foxySessionData.setAction(SCH);
        this.foxySessionData.setSearchKey(null);
        this.foxySessionData.setSearchType(null);
        this.foxySessionData.setOrderId(null);
        return ("go_schInventory");
    }
    
    public String shortCut() {
        //this.foxySessionData.setAction(ENQ);
        //this.foxySessionData.setPageParameter(String.valueOf(this.getOrderId()));
        return ("go_schInventory");
    }
    
    public String delete(){
        try {
            Session session = (Session) HibernateUtil.currentSession();
            Transaction tx= session.beginTransaction();
            String  qstr  = new String("DELETE Inventory t ");
            qstr = qstr.concat("WHERE t.id = :pinvRefId ");
            Query q = session.createQuery(qstr);
            q.setLong("pinvRefId", foxySessionData.getPageParameterLong());
            q.executeUpdate();
            
            qstr  = new String("DELETE InvMovement t ");
            qstr = qstr.concat("WHERE t.invRefId = :pinvRefId ");
            q = session.createQuery(qstr);
            q.setLong("pinvRefId", foxySessionData.getPageParameterLong());
            q.executeUpdate();
            
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
            FacesMessage fmsg  = new FacesMessage(FacesMessage.SEVERITY_ERROR, e.getCause().toString(), e.getMessage());
            ctx.addMessage(null, fmsg);
            return (null);
        } finally {
            HibernateUtil.closeSession();
        }
        
        return null;
    }
    
}
