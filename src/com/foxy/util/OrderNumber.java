/*
 * OrderNumber.java
 *
 * Created on July 5, 2006, 7:58 AM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */
package com.foxy.util;

import com.foxy.db.HibernateUtil;
import com.foxy.db.HibernateUtilInternal;
import com.foxy.db.OrderNo;
import com.foxy.db.OrderNoReserved;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Expression;
import org.hibernate.criterion.Order;

/**
 *
 * @author eric
 */
public class OrderNumber {

    Integer orderId = null;
    OrderNo ordno = null;
    Date dNow = null;
    SimpleDateFormat fmt = new SimpleDateFormat("yyyy");
    SimpleDateFormat sfmt = new SimpleDateFormat("yy");

    /**
     * Creates a new instance of OrderNumber
     */
    public OrderNumber() {
        dNow = new Date();
        //System.out.println("Curr Year " + fmt.format(dNow));
    }

    public String getOrderNumber(Integer mainFactoryCode, String orderYear, boolean considerReused) {
        List result = null;
        String refNum = null;
        List resultList;
        OrderNoReserved ordReservedId;
        Session session;
        Transaction tx;

        //System.out.println("Curr Year " + fmt.format(dNow));

        //1st: Check if OrderNoReserved tables having expired order number to reused.
        if (considerReused) {
            try {
                session = (Session) HibernateUtilInternal.currentSession();
                tx = session.beginTransaction();
                Criteria crit = session.createCriteria(OrderNoReserved.class);
                crit.add(Expression.eq("year", Integer.parseInt(orderYear)));
                crit.add(Expression.eq("mainFactory", mainFactoryCode));
                crit.add(Expression.lt("expiredOn", Calendar.getInstance(Locale.US).getTime()));//Only get those expired items
                crit.addOrder(Order.asc("reservedNo"));
                resultList = crit.list();
                //expired refNum booked found, re-used it
                if (resultList.size() > 0) {
                    ordReservedId = (OrderNoReserved) resultList.get(0);
                    refNum = ordReservedId.getReservedNo(); //Nolonger == null
                    System.out.println(dNow.toString() + "  Reserved OrderId expired and reused [refnum:" + ordReservedId.getReservedNo()
                            + "  ReservedBy:" + ordReservedId.getForUserId() + " expiredOn:" + ordReservedId.getExpiredOn().toString()
                            + "]");
                    session.delete(ordReservedId);
                }
                tx.commit();
            } catch (HibernateException e) {
                e.printStackTrace();
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                HibernateUtilInternal.closeSession();
            }
        }


        //2nd: If no reserved orderid to be reuse, create a new one
        if (refNum == null) {
            try {
                session = (Session) HibernateUtilInternal.currentSession();
                tx = session.beginTransaction();
                result = session.createQuery("from OrderNo where mainfactory =" + mainFactoryCode + " and year=" + orderYear).list();
                if (result.isEmpty()) {
                    ordno = new OrderNo();
                    ordno.setMainFactory(mainFactoryCode);
                    ordno.setYear(Integer.parseInt(orderYear));
                    ordno.setSequence(1);
                    session.saveOrUpdate(ordno);
                    orderId = new Integer(1);
                } else {
                    ordno = (OrderNo) result.get(0);
                    orderId = ordno.getSequence() + 1;
                    ordno.setSequence(this.orderId);
                }
                tx.commit();
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                HibernateUtilInternal.closeSession();
            }

            refNum = orderYear.substring(2);
            if (refNum.equals("13")) { //Using 6chars format before year 14, To be remove after year 13
                refNum = (refNum + String.valueOf((mainFactoryCode * 1000) + (orderId)));
            } else { //using 7chars format after year 14
                refNum = (refNum + String.valueOf((mainFactoryCode * 10000) + (orderId)));
            }
        }
        return refNum;
    }
}
