/*
 * FoxyFactoryPage.java
 *
 * Created on June 20, 2006, 6:18 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */
package com.foxy.page;

import com.foxy.db.FactoryMast;
import com.foxy.db.HibernateUtil;
import com.foxy.util.FoxyPagedDataModel;
import com.foxy.util.ListData;
import java.io.Serializable;
import java.util.List;
import javax.faces.application.FacesMessage;
import javax.faces.model.DataModel;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Expression;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;

/**
 *
 * @author eric
 */
public class FoxyFactoryPage extends Page implements Serializable {

    private static String MENU_CODE = new String("FOXY");
    private FactoryMast factoryBean = null;
    ListData ld = (ListData) this.getBean("listData");

    public class FactoryMastEx extends FactoryMast {
        public String getCountryName() {
            return ld.getCountryDesc(getFactoryCode(), 1);
        }
    }

    /**
     * Creates a new instance of FoxyParameterPage
     */
    public FoxyFactoryPage() {
        super(MENU_CODE);
        this.isAuthorize(MENU_CODE);
    }

    //FactoryMast getter
    public FactoryMast getFactoryBean() {
        if (factoryBean == null) {
            factoryBean = new FactoryMast();
        }
        return factoryBean;
    }

    public void setFactoryBean(FactoryMast FactoryBean) {
        this.factoryBean = FactoryBean;
    }

    /**
     * Retrive data from database based on recordid
     */
    public FactoryMast getDbFactoryBean() {
        //Should only retrieve if object not yet retrieved !! else will be to heavy and unneccessary query !
        if (this.factoryBean == null) {
            try {
                Session session = (Session) HibernateUtil.currentSession();
                Transaction tx = session.beginTransaction();
                Criteria crit = session.createCriteria(FactoryMast.class);
                System.err.println("id = " + foxySessionData.getPageParameterLong());
                crit.add(Expression.eq("id", foxySessionData.getPageParameterLong()));
                List result = crit.list();
                if (result.size() == 1) {
                    this.factoryBean = (FactoryMast) result.get(0);
                } else {
                    System.err.println("No Factory record with id = " + foxySessionData.getPageParameterLong());
                }
                tx.commit();
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
        return this.factoryBean;
    }

    //Setter required to allow update from client to be sync
    public void setDbFactoryBean(FactoryMast FactoryBean) {
        this.factoryBean = FactoryBean;
    }

    /**
     * Prepare data for parameter listing
     */
    public DataModel getFactoryList() {
        Number numofRec = null;
        int firstrow = foxyTable.getFirst();
        int pagesize = foxyTable.getRows();

        try {
            if (this.getSearchKey() != null) {
                String likestr = null;
                if (this.searchKey.length() > 0) {
                    likestr = "%" + this.searchKey.replace('*', '%') + "%";
                }
                Session session = (Session) HibernateUtil.currentSession();
                Transaction tx = session.beginTransaction();
                Criteria criteria = session.createCriteria(FactoryMast.class);

                //Get Total row count
                criteria.setProjection(Projections.rowCount());
                if (likestr != null) {
                    criteria.add(Expression.like("factoryName", likestr));
                }
                if (!"ALLSELECTED".equals(this.getSearchType())) {
                    criteria.add(Expression.eq("countryCode", this.getSearchType()));
                }
                criteria.addOrder(Order.asc("seqNo"));
                numofRec = ((Number) criteria.uniqueResult());
                tx.commit();

                //System.err.println("Total Number of records: [" + numofRec.intValue()
                  //      + "] likestr = " + likestr + "] search type = [" + this.getSearchType() + " ]");


                numofRec = numofRec == null ? 0 : numofRec.intValue();


                //Retrieve subset of record base on foxyTable current view page
                tx = session.beginTransaction();
                criteria = session.createCriteria(FactoryMast.class);
                if (likestr != null) {
                    criteria.add(Expression.like("factoryName", likestr));
                }
                if (!"ALLSELECTED".equals(this.getSearchType())) {
                    criteria.add(Expression.eq("countryCode", this.getSearchType()));
                }
                criteria.addOrder(Order.asc("seqNo"));
                criteria.setFirstResult(firstrow);
                criteria.setMaxResults(pagesize);
                List result = criteria.list();
                //result.
                tx.commit();
                if (this.foxyListModel != null) {
                    this.foxyListModel = null;
                }

                this.foxyListModel = (DataModel) new FoxyPagedDataModel(result, numofRec.intValue(), pagesize);
                session.clear();
            } else {
                System.err.println("Search key is null !!!");
            }
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
        return this.foxyListModel;
    }

    /**
     * Save data into database (Both add and edit used same back bean, only
     * differ is one created will all null value and the other call
     * getDbFactoryBean to initialise with db
     */
    public String saveAdd() {
        try {
            Session session = (Session) HibernateUtil.currentSession();
            Transaction tx = session.beginTransaction();
            factoryBean.setStatus("A");
            session.saveOrUpdate(factoryBean);
            tx.commit();
            session.clear();
        } catch (Exception e) {
            e.printStackTrace();
            FacesMessage fmsg = new FacesMessage(FacesMessage.SEVERITY_ERROR, e.getCause().toString(), e.getMessage());
            ctx.addMessage(null, fmsg);
            return null;
        } finally {
            HibernateUtil.closeSession();
            ListData ld = (ListData) this.getBean("listData");
            ld.resetFactoryList(); //force to set Factory list = null to ensure next request re-query from db
        }
        return ("success");
    }

    public String saveEdit() {
        return saveAdd();//use same method is ok
    }

    /**
     * Prepare for listing
     */
    public String search() {
        this.foxySessionData.setAction(LST);
        this.foxyTable.setFirst(0);
        return ("success");
    }

    public String editFactory() {
        return ("editfactory");
    }

    public String delete() {
        try {
            Session session = (Session) HibernateUtil.currentSession();
            Transaction tx = session.beginTransaction();
            String qstr = "DELETE FactoryMast t ";
            qstr = qstr.concat("WHERE t.id = :pid ");
            Query q = session.createQuery(qstr);
            q.setLong("pid", foxySessionData.getPageParameterLong());
            q.executeUpdate();
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
            FacesMessage fmsg = new FacesMessage(FacesMessage.SEVERITY_ERROR, e.getCause().toString(), e.getMessage());
            ctx.addMessage(null, fmsg);
            return (null);
        } finally {
            HibernateUtil.closeSession();
            ListData ld = (ListData) this.getBean("listData");
            ld.resetFactoryList();
        }

        return null;
    }
}
