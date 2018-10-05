/*
 * FoxyOerderNoUpdatePage.java
 *
 * Created on June 20, 2006, 6:18 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */
package com.foxy.page;

import com.foxy.db.HibernateUtil;
import com.foxy.db.OrderNoReserved;
import com.foxy.util.FoxyPagedDataModel;
import java.io.Serializable;
import java.util.List;
import javax.faces.application.FacesMessage;
import javax.faces.model.DataModel;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Expression;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;

/**
 *
 * @author Darren Ting
 */
public class FoxyOrderNoAllUserListPage extends Page implements Serializable {

    private static String MENU_CODE = "FOXY";
    //private OrderNoReserved ordNoReservedBean = null;

    /**
     * Creates a new instance of FoxyOrderNoUpdatePage
     */
    public FoxyOrderNoAllUserListPage() {
        super(MENU_CODE);
        this.isAuthorize(MENU_CODE);
    }

    /**
     * Prepare data for OrdNoReserved listing
     */
    public DataModel getOrdNoReservedList() {
        Number numofRec = null;
        int firstrow = foxyTable.getFirst();
        int pagesize = foxyTable.getRows();

        if (this.foxyListModel == null) {
            try {
                Session session = (Session) HibernateUtil.currentSession();
                Transaction tx = session.beginTransaction();
                Criteria criteria = session.createCriteria(OrderNoReserved.class);

                //Get Total row count
                criteria.setProjection(Projections.rowCount());
                criteria.addOrder(Order.asc("reservedNo"));
                numofRec = ((Number) criteria.uniqueResult());
                tx.commit();

                //System.err.println("Total Number of records: [" + numofRec.intValue() + "]");
                numofRec = numofRec == null ? 0 : numofRec.intValue();


                //Retrieve subset of record base on foxyTable current view page
                tx = session.beginTransaction();
                criteria = session.createCriteria(OrderNoReserved.class);
                criteria.addOrder(Order.asc("reservedNo"));
                criteria.setFirstResult(firstrow);
                criteria.setMaxResults(pagesize);
                List result = criteria.list();
                tx.commit();
                if (this.foxyListModel != null) {
                    this.foxyListModel = null;
                }
                this.foxyListModel = (DataModel) new FoxyPagedDataModel(result, numofRec.intValue(), pagesize);
                session.clear();
            } catch (HibernateException e) {
                //do something here with the exception
                e.printStackTrace();
                FacesMessage fmsg = new FacesMessage(FacesMessage.SEVERITY_ERROR, e.getCause().toString(), e.getMessage());
                ctx.addMessage(null, fmsg);
            } catch (Exception e) {
                e.printStackTrace();
                FacesMessage fmsg = new FacesMessage(FacesMessage.SEVERITY_ERROR, e.getCause().toString(), e.getMessage());
                ctx.addMessage(null, fmsg);
            } finally {
                HibernateUtil.closeSession();
            }
        }
        return this.foxyListModel;
    }
}
