/*
 * FoxySalesInvoicePage.java
 *
 * Created on June 20, 2006, 6:18 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package com.foxy.page;

import javax.faces.application.FacesMessage;
import com.foxy.db.SalesInvoice;
import com.foxy.db.HibernateUtil;
import com.foxy.util.FoxyPagedDataModel;
import com.foxy.util.ListData;
import java.io.Serializable;
import java.util.List;
import javax.faces.model.DataModel;
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
public class FoxySalesInvoicePage extends Page implements Serializable{
    private static String MENU_CODE = new String("FOXY");
    
    private DataModel ListModel;
    private SalesInvoice salesInvoiceBean = null;
    private String currentMode = "VIEW";
    private Double tmpForexRate = null;
    private Double inputForexRate = null;
    private Double sgdForexRate = null;
    private List  brandList = null;
    private List  divisionList = null;
    private String forexRateStr = null;
    
    
    
    /** Creates a new instance of Page */
    public FoxySalesInvoicePage() {
        super(new String("SalesInvoiceForm"));
        //System.out.println("Calling constructor now!!!!!!!!!!!!!!");
        try {
            //this.getInvMovementBean();
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
    
    public Double getInputForexRate() {
        return inputForexRate;
    }
    
    public void setInputForexRate(Double inputForexRate) {
        this.inputForexRate = inputForexRate;
    }
    
    public Double getSgdForexRate() {
        return sgdForexRate;
    }
    
    public void setSgdForexRate(Double sgdForexRate) {
        this.sgdForexRate = sgdForexRate;
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
    
    
    
    public SalesInvoice getSalesInvoiceBean() {
        if ( salesInvoiceBean == null ){
            //System.err.println("Create new bean .....");
            salesInvoiceBean = new SalesInvoice();
        }
        return salesInvoiceBean;
    }
    
    public void setSalesInvoiceBean(SalesInvoice salesInvoiceBean) {
        this.salesInvoiceBean = salesInvoiceBean;
    }
    
    public SalesInvoice getEditSalesInvoiceBean() {
        
        if ( this.salesInvoiceBean == null) {
            try {
                Session session = (Session) HibernateUtil.currentSession();
                Transaction tx= session.beginTransaction();
                Criteria crit = session.createCriteria(SalesInvoice.class);
                crit.add(Expression.eq("saleinvid", foxySessionData.getPageParameterLong()));
                List result = crit.list();
                //System.err.println("Result size = " + result.size());
                if ( result.size() > 0 ) {
                    this.salesInvoiceBean = (SalesInvoice)result.get(0);
                    this.tmpForexRate = this.salesInvoiceBean.getForexrate();
                } else {
                    System.err.println("No sales invoice  with saleinvid = " + foxySessionData.getPageParameterLong());
                }
                tx.commit();
            } catch (HibernateException e) {
                //do something here with the exception
                e.printStackTrace();
                FacesMessage fmsg  = new FacesMessage(FacesMessage.SEVERITY_ERROR, e.getCause().toString(), e.getMessage());
                ctx.addMessage(null, fmsg);
            } catch (Exception e){
                e.printStackTrace();
                FacesMessage fmsg  = new FacesMessage(FacesMessage.SEVERITY_ERROR, e.getCause().toString(), e.getMessage());
                ctx.addMessage(null, fmsg);
            }finally {
                HibernateUtil.closeSession();
            }
        }
        return salesInvoiceBean;
    }
    
    
    public void setEditSalesInvoiceBean(SalesInvoice salesInvoiceBean) {
        this.salesInvoiceBean = salesInvoiceBean;
    }
    
    
    public DataModel getSalesInvoiceList() {
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
                
                Criteria criteria = session.createCriteria(SalesInvoice.class);
                //Get Total row count
                criteria.setProjection(Projections.rowCount());
                criteria.add(Expression.like("invno", likestr));
                criteria.addOrder(Order.asc("invno"));
                numofRec = ((Number) criteria.uniqueResult());
                tx.commit();
            } catch (HibernateException e) {
                e.printStackTrace();
                FacesMessage fmsg  = new FacesMessage(FacesMessage.SEVERITY_ERROR, e.getCause().toString(), e.getMessage());
                ctx.addMessage(null, fmsg);
            } catch (Exception e){
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
                    Criteria criteria = session.createCriteria(SalesInvoice.class);
                    criteria.add(Expression.like("invno", likestr));
                    criteria.addOrder(Order.asc("invno"));
                    criteria.setFirstResult(firstrow);
                    criteria.setMaxResults(pagesize);
                    
                    result = criteria.list();
                    tx.commit();
                    for (int i = 0; i < result.size(); i ++ ){
                        SalesInvoice salesinv = (SalesInvoice) result.get(i);
                        this.tableList.add(salesinv);
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
            } catch (Exception e){
                e.printStackTrace();
                FacesMessage fmsg  = new FacesMessage(FacesMessage.SEVERITY_ERROR, e.getCause().toString(), e.getMessage());
                ctx.addMessage(null, fmsg);
            }finally {
                HibernateUtil.closeSession();
            }
        }
        return ListModel;
    }
    
    
    public String search() {
        this.foxySessionData.setAction(LST);
        foxyTable.setFirst(0);
        return (null);
    }
    
    
    //action for ajax call
    public String onCurCodeChange() {
        //force to reset the supplier list
        this.tmpForexRate = super.getForexRate(this.salesInvoiceBean.getCurrency(), this.salesInvoiceBean.getInvdate());
        //System.err.println("ForexRate - [" + this.tmpForexRate + "]");
        this.inputForexRate = super.getRawForexRate(this.salesInvoiceBean.getCurrency(), this.salesInvoiceBean.getInvdate());
        this.sgdForexRate = super.getRawForexRate("SGD", this.salesInvoiceBean.getInvdate());
        
        this.forexRateStr = "Currency [ USD_TO_" + this.salesInvoiceBean.getCurrency() +  " = " + this.inputForexRate + "] ";
        this.forexRateStr += "[USD_TO_SGD = " + this.sgdForexRate + "]";
        
        try {
            super.resetForexRate();
            
            this.salesInvoiceBean.setFobbaseval(null);
            this.salesInvoiceBean.setCmtbaseval(null);
            this.salesInvoiceBean.setRevenuebaseval(null);
            
            if ( tmpForexRate != null ){
                if ( this.salesInvoiceBean.getFobval() != null ){
                    this.salesInvoiceBean.setFobbaseval(super.roundDouble(this.salesInvoiceBean.getFobval() * tmpForexRate,2));
                }
                
                if ( this.salesInvoiceBean.getCmtval() != null ){
                    this.salesInvoiceBean.setCmtbaseval(super.roundDouble(this.salesInvoiceBean.getCmtval() * tmpForexRate,2));
                }
                
                if ( this.salesInvoiceBean.getRevenue() != null){
                    this.salesInvoiceBean.setRevenuebaseval(super.roundDouble(this.salesInvoiceBean.getRevenue() * tmpForexRate,2));
                }
            }
        } catch ( Exception e){
            e.printStackTrace();
            
        } finally {
        }
        
        return null; //Need to return null to disable page flow to take effect
    }
    
    
    public String editSalesInvoice(){
        return ("editsalesinvoice");
    }
    
    
    public String editSalesInvoiceDetail(){  //Refresh this bean and retrieve bean in getEditBean method
        this.foxySessionData.setPageParameterLong2(null);
        this.foxySessionData.setSessObject1(null);
        return ("editsalesinvoicedetail");
    }
    
    //action for ajax call
    public String onCustCodeChange() {
        //force to reset the brand and division list
        this.brandList = null;
        this.divisionList = null;
        return null; //Need to return null to disable page flow to take effect
    }
    
    //action for ajax call
    public String onCustBrandChange() {
        //Force to reset the division list (reload)
        this.divisionList =  null;
        return null; //Need to return null to disable page flow to take effect
    }
    
    
    
    public String saveAdd() {
        //System.out.println("Save Add ssRefId11   = [" + this.invMovementBean.getSsRefId() +"]" );
        //System.out.println("Save Add ssRefId2222 = [" + this.getSumRefId() +"]" );
        //System.out.println("Save Add ssRefI333 = [" + this.invMovementBean.getQuantity() +"]" );
        try {
            //this.invMovementBean.setSsRefId(Integer.parseInt(this.getSumRefId()));
            Session session = (Session) HibernateUtil.currentSession();
            Transaction tx= session.beginTransaction();
            this.salesInvoiceBean.setForexrate(this.tmpForexRate);
            //System.out.println("Forex Rate  = [" + this.tmpForexRate +"]" );
            session.save(this.salesInvoiceBean);
            this.foxySessionData.setPageParameterLong(salesInvoiceBean.getSaleinvid());
            tx.commit();
            HibernateUtil.closeSession();
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
    
    
    public String saveUpd() {
        //System.err.println("!!!!!!!!!!!!!!!!!!!Save Upd");
        //System.err.println("Current Mode = " + this.currentMode);
        try {
            //System.err.println("!!!!!!!!!!! -Current SumRefId = " + this.sumRefId);
            //this.invMovementBean.setSsRefId(Integer.parseInt(this.sumRefId));
            Session session = (Session) HibernateUtil.currentSession();
            //System.err.println("Save upde11 = [" +  this.invMovementBean.getInvRefId() + "]");
            //System.err.println("Save upde22 = [" +  this.invMovementBean.getId() + "]");
            //System.err.println("Save upde33 = [" +  this.invMovementBean.getSsRefId() + "]");
            //System.err.println("Session invRefId = " + foxySessionData.getPageParameterLong2());
            Transaction tx= session.beginTransaction();
            this.salesInvoiceBean.setForexrate(this.tmpForexRate);
            //System.err.println("Update with ForexRate = [" + this.tmpForexRate + "]");
            session.update(this.salesInvoiceBean);
            
            tx.commit();
            HibernateUtil.closeSession();
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
    
    
    public String delete(){
        try {
            Session session = (Session) HibernateUtil.currentSession();
            Transaction tx= session.beginTransaction();
            String  qstr  = new String("DELETE SalesInvoice t ");
            qstr = qstr.concat("WHERE t.saleinvid  = :psaleinvid ");
            Query q = session.createQuery(qstr);
            q.setLong("psaleinvid", foxySessionData.getPageParameterLong());
            q.executeUpdate();
            
            qstr  = new String("DELETE SalesInvoiceDetail t ");
            qstr = qstr.concat("WHERE t.saleinvid  = :psaleinvid ");
            q = session.createQuery(qstr);
            q.setLong("psaleinvid", foxySessionData.getPageParameterLong());
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
