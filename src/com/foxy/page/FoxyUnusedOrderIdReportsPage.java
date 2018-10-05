/*
 * FoxyUnusedOrderIdReportsPage.java
 *
 * Created on June 20, 2006, 6:18 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */
package com.foxy.page;

import com.foxy.db.HibernateUtil;
import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import javax.faces.application.FacesMessage;
import javax.faces.model.DataModel;
import javax.faces.model.ListDataModel;
import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author hcting
 */
public class FoxyUnusedOrderIdReportsPage extends Page implements Serializable {

    private static String MENU_CODE = "FOXY";
    private DataModel dataListModel;
    private SimpleDateFormat fmt1 = new SimpleDateFormat("yyyy-MM-dd");
    private SimpleDateFormat fmt2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    public class ReportDataBean {

        private String oldOrderId = null;
        private String newOrderId = null;
        private Date insTime = null;
        private String insUser = null;

        public String getOldOrderId() {
            return oldOrderId;
        }

        public void setOldOrderId(String oldOrderId) {
            this.oldOrderId = oldOrderId;
        }

        public String getNewOrderId() {
            return newOrderId;
        }

        public void setNewOrderId(String newOrderId) {
            this.newOrderId = newOrderId;
        }

        public Date getInsTime() {
            return insTime;
        }

        public void setInsTime(Date insTime) {
            this.insTime = insTime;
        }

        public String getInsUser() {
            return insUser;
        }

        public void setInsUser(String insUser) {
            this.insUser = insUser;
        }
    }; //Inner class end

    public FoxyUnusedOrderIdReportsPage() {
        super(new String("UnusedOrderIdReportsForm"));
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.MONTH, -6);

        try {
            this.isAuthorize(MENU_CODE);

            this.setToDate(cal.getTime());
            //System.out.println(ctx.getApplication().getViewHandler().toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public String getTitle() {

        String str = "Unused OrderId Report ";

        str += " Activity Since [" + fmt1.format(this.getToDate()) + "] ";

        str += "As At [" + fmt2.format(new Date()) + "] ";

        return str;
    }

    public String search() {
        this.foxySessionData.setAction(LST);
        return (null);
    }

    public DataModel getUnusedOrderIdReportData() {
        List<ReportDataBean> recordList = null;
        if (dataListModel == null && this.foxySessionData.getAction().equals(LST)) {
            try {
                SQLQuery q;
                Session session = (Session) HibernateUtil.currentSession();
                Transaction tx = session.beginTransaction();

                String qstr = "SELECT t.oldorderid as oldorderid, t.neworderid as neworderid, ";
                qstr += " t.insusrid as insuserid, t.instime as instime ";
                qstr += " FROM orderno_replaced as t ";
                qstr += " WHERE instime >= :ptoDate ";
                qstr += " ORDER BY instime DESC ";

                q = session.createSQLQuery(qstr);
                q.setDate("ptoDate", this.getToDate());

                //add scalar
                //line 1
                q.addScalar("oldorderid", Hibernate.STRING);
                q.addScalar("neworderid", Hibernate.STRING);
                q.addScalar("insuserid", Hibernate.STRING);
                q.addScalar("instime", Hibernate.TIMESTAMP);

                Iterator it = q.list().iterator();

                if (recordList == null) {
                    recordList = new ArrayList();
                }

                ReportDataBean grandTotal = new ReportDataBean();
                try {
                    while (it.hasNext()) {
                        int idx = 0;
                        Object[] tmpRow = (Object[]) it.next();
                        ReportDataBean obj = new ReportDataBean();
                        obj.setOldOrderId((String) tmpRow[idx++]);
                        obj.setNewOrderId((String) tmpRow[idx++]);
                        obj.setInsUser((String) tmpRow[idx++]);
                        obj.setInsTime((Date) tmpRow[idx++]);
                        recordList.add(obj);
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }

                dataListModel = new ListDataModel();

                //System.err.println("Test 111115555");
                dataListModel.setWrappedData(recordList);
                //System.err.println("Test 11111666");
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

        //Avoid null pointer exception
        if (dataListModel == null) {
            dataListModel = new ListDataModel();
        }

        return dataListModel;
    }
}
