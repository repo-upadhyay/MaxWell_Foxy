/*
 * FoxyOerderNoReservePage.java
 *
 * Created on June 20, 2006, 6:18 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */
package com.foxy.page;

import com.foxy.db.HibernateUtil;
import com.foxy.db.OrderNoReserved;
import com.foxy.util.OrderNumber;
import java.io.Serializable;
import java.util.Calendar;
import java.util.Locale;
import javax.faces.application.FacesMessage;
import javax.faces.context.ExternalContext;
import javax.faces.context.FacesContext;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author Darren Ting
 */
public class FoxyOrderNoReservePage extends Page implements Serializable {

    private static String MENU_CODE = "FOXY";
    private OrderNoReserved ordNoReservedBean = null;
    private String orderIdYear = null;
    private String mainFactoryCode = null;
    private Integer orderNoCount = null;
    private Integer daysToExpired = 90;

    ////this.setOrderId(ordNo.getOrderNumber(Integer.parseInt(this.getMainFactoryCode()), this.orderIdYear));
    /**
     * Creates a new instance of FoxyOrderNoReservePage
     */
    public FoxyOrderNoReservePage() {
        super(MENU_CODE);
        this.isAuthorize(MENU_CODE);
    }

    public OrderNoReserved getOrdNoReservedBean() {
        return ordNoReservedBean;
    }

    public void setOrdNoReservedBean(OrderNoReserved ordNoReservedBean) {
        this.ordNoReservedBean = ordNoReservedBean;
    }

    public String getOrderIdYear() {
        return orderIdYear;
    }

    public void setOrderIdYear(String orderIdYear) {
        this.orderIdYear = orderIdYear;
    }

    public String getMainFactoryCode() {
        return mainFactoryCode;
    }

    public void setMainFactoryCode(String mainFactoryCode) {
        this.mainFactoryCode = mainFactoryCode;
    }

    public Integer getOrderNoCount() {
        return orderNoCount;
    }

    public void setOrderNoCount(Integer orderNoCount) {
        this.orderNoCount = orderNoCount;
    }

    public Integer getDaysToExpired() {
        return daysToExpired;
    }

    public void setDaysToExpired(Integer daysToExpired) {
        this.daysToExpired = daysToExpired;
    }

    /**
     * Save data into database (Both add and edit used same back bean, only
     * differ is one created will all null value and the other call
     * getDbOrdNoReservedBean to initialise with db
     */
    public String saveAdd() {
        //System.out.println("Save DbOrdNoReservedBean");
        String userid = null;
        ExternalContext ectxtmp;
        String result = "fail";

        try {
            ectxtmp = FacesContext.getCurrentInstance().getExternalContext();
            if (ectxtmp != null) {
                userid = ectxtmp.getRemoteUser();
            }
            
            if (userid != null) {//If failed to get user id, failed

                OrderNumber ordNo = new OrderNumber();

                Session session = (Session) HibernateUtil.currentSession();
                Transaction tx = session.beginTransaction();

                int i;
                for (i = 0; i < this.orderNoCount; i++) {
                    OrderNoReserved ordnumreserv = new OrderNoReserved();
                    //Do no consider reused from expired reserved refNum in-order to guatantee sequancial num
                    ordnumreserv.setReservedNo(ordNo.getOrderNumber(Integer.parseInt(this.mainFactoryCode), this.orderIdYear, false));
                    ordnumreserv.setForUserId(userid);
                    ordnumreserv.setMainFactory(Integer.parseInt(this.mainFactoryCode));
                    ordnumreserv.setYear(Integer.parseInt(this.orderIdYear));
                    ordnumreserv.setReservedOn(Calendar.getInstance(Locale.US).getTime());
                    ordnumreserv.setExpiredAfterDays(this.daysToExpired);
                    ordnumreserv.setStatus("A");
                    session.saveOrUpdate(ordnumreserv);
                }

                tx.commit();
                session.clear();
                result = "success";
            }
        } catch (Exception e) {
            e.printStackTrace();
            FacesMessage fmsg = new FacesMessage(FacesMessage.SEVERITY_ERROR, e.getCause().toString(), e.getMessage());
            ctx.addMessage(null, fmsg);
            return null;
        } finally {
            HibernateUtil.closeSession();
        }
        return (result);
    }
}
