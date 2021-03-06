/*
 * FoxyMerchandiserReportsPage.java
 *
 * Created on June 20, 2006, 6:18 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */
package com.foxy.page;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import javax.faces.application.FacesMessage;
import com.foxy.db.HibernateUtil;
import com.foxy.util.ListData;
import java.io.Serializable;
import java.util.Date;
import java.util.List;
import java.util.ArrayList;
import java.util.Iterator;
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
public class FoxyMerchandiserReportsPage extends Page implements Serializable {

    private static String MENU_CODE = new String("FOXY");
    private DataModel dataListModel;
    private String country = null;
    private String mainfactory = null;
    private String merchandiser = null;
    private Integer year = null;
    private Integer month = null;
    private SimpleDateFormat fmt1 = new SimpleDateFormat("yyyy-MM-dd");
    private SimpleDateFormat fmt2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    private SimpleDateFormat fmt3 = new SimpleDateFormat("MMMM yyyy");
    private boolean searchByRefno = false;
    private String refNo = null;

    public class ReportDataBean {

        private String orderId = null;
        private String month = null;
        private String location = null;
        private String subLocation = null;
        private String stylecode = null;
        private String custCode = null;
        private String custBrand = null;
        private String custDivision = null;
        private String origin = null;
        private String wash = null;
        private String ship = null;
        private String poNumber = null;
        private String emb = null;
        private String mrForCust = null;
        private Date closeDate = null;
        private Date vesselDate = null;
        private Date fabricDate = null;
        private Date deliveryDate = null;
        private Date etd = null;
        private String category = null;
        private String destination = null;
        private Double qtyDzn = null;
        private String remark = null;

        public String getOrderId() {
            return orderId;
        }

        public void setOrderId(String orderId) {
            this.orderId = orderId;
        }

        public String getMonth() {
            return month;
        }

        public void setMonth(String month) {
            this.month = month;
        }

        public String getLocation() {
            return location;
        }

        public void setLocation(String location) {
            this.location = location;
        }

        public String getSubLocation() {
            return subLocation;
        }

        public void setSubLocation(String subLocation) {
            this.subLocation = subLocation;
        }

        public String getStylecode() {
            return stylecode;
        }

        public void setStylecode(String stylecode) {
            this.stylecode = stylecode;
        }

        public String getCustCode() {
            return custCode;
        }

        public void setCustCode(String custCode) {
            this.custCode = custCode;
        }

        public String getCustBrand() {
            return custBrand;
        }

        public void setCustBrand(String custBrand) {
            this.custBrand = custBrand;
        }

        public String getCustDivision() {
            return custDivision;
        }

        public void setCustDivision(String custDivision) {
            this.custDivision = custDivision;
        }

        public String getOrigin() {
            return origin;
        }

        public void setOrigin(String origin) {
            this.origin = origin;
        }

        public String getWash() {
            return wash;
        }

        public void setWash(String wash) {
            this.wash = wash;
        }

        public String getShip() {
            return ship;
        }

        public void setShip(String ship) {
            this.ship = ship;
        }

        public String getPoNumber() {
            return poNumber;
        }

        public void setPoNumber(String poNumber) {
            this.poNumber = poNumber;
        }

        public String getEmb() {
            return emb;
        }

        public void setEmb(String emb) {
            this.emb = emb;
        }

        public String getMrForCust() {
            return mrForCust;
        }

        public void setMrForCust(String mrForCust) {
            this.mrForCust = mrForCust;
        }

        public Date getVesselDate() {
            return vesselDate;
        }

        public void setVesselDate(Date vesselDate) {
            this.vesselDate = vesselDate;
        }

        public Date getFabricDate() {
            return fabricDate;
        }

        public void setFabricDate(Date fabricDate) {
            this.fabricDate = fabricDate;
        }

        public Date getEtd() {
            return etd;
        }

        public void setEtd(Date etd) {
            this.etd = etd;
        }

        public Date getCloseDate() {
            return closeDate;
        }

        public void setCloseDate(Date closeDate) {
            this.closeDate = closeDate;
        }

        public Date getDeliveryDate() {
            return deliveryDate;
        }

        public void setDeliveryDate(Date deliveryDate) {
            this.deliveryDate = deliveryDate;
        }

        public String getCategory() {
            return category;
        }

        public void setCategory(String category) {
            this.category = category;
        }

        public String getDestination() {
            return destination;
        }

        public void setDestination(String destination) {
            this.destination = destination;
        }

        public Double getQtyDzn() {
            return qtyDzn;
        }

        public void setQtyDzn(Double qtyDzn) {
            this.qtyDzn = qtyDzn;
        }

        public void accumulateQtyDzn(Double qtyDzn) {
            if (this.qtyDzn == null) {
                this.qtyDzn = qtyDzn;
            } else {
                this.qtyDzn += qtyDzn;
            }
        }

        public String getRemark() {
            return remark;
        }

        public void setRemark(String remark) {
            this.remark = remark;
        }
    }; //Inner class end

    public FoxyMerchandiserReportsPage() {
        super(new String("ProductionReportsForm"));

        try {
            this.isAuthorize(MENU_CODE);
            //System.out.println(ctx.getApplication().getViewHandler().toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public String getTitle() {
        ListData ld = (ListData) getBean("listData");
        String str = " ";

        if (this.year != null && this.month != null) {
            str += "(" + this.getCountryName() + ") ";
            if (this.mainfactory != null) {
                if (this.mainfactory.equals("ALLSELECTED")) {
                    str = str + " Factory[ All Factories ] ";
                } else {
                    str = str + " Factory[" + ld.getFactoryNameShort(this.getMainfactory()) + "] ";
                }
            }
            str += "Month [" + fmt3.format(this.getFromDate()) + "] ";

        } else {
            if (this.country == null || this.getFromDate() == null || this.getToDate() == null) {
                str = "Complete list of order reference number without any lots ";
            } else {
                str += "(" + this.getCountryName() + ") ";

                if (this.mainfactory != null) {
                    if (this.mainfactory.equals("ALLSELECTED")) {
                        str = str + " Factory[ All Factories ] ";
                    } else {
                        str = str + " Factory[" + ld.getFactoryNameShort(this.getMainfactory()) + "] ";
                    }
                }

                str += "Delivery Date From [" + fmt1.format(this.getFromDate()) + "] ";
                str += "To [" + fmt1.format(this.getToDate()) + "] ";
            }
        }

        if (this.searchByRefno) { //overwrite with oder id if search by refno only
            str = "Order Id [" + this.refNo + "] ";
        }

        str += "As At [" + fmt2.format(new Date()) + "] ";
        if (this.merchandiser != null) {
            str += "Merchandiser [" + this.merchandiser + "] ";
        }

        return str;
    }

    public List getFactoryByCountryList() {
        ListData ld = (ListData) getBean("listData");
        return (ld.getFactoryListAllByCountry(this.country));
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getCountryName() {
        ListData ld = (ListData) getBean("listData");
        return (ld.getCountryDesc(this.getCountry(), 0));
        //return this.country;
    }

    public String getMainfactory() {
        return mainfactory;
    }

    public void setMainfactory(String mainfactory) {
        this.mainfactory = mainfactory;
    }

    public Integer getYear() {
        return year;
    }

    public void setYear(Integer year) {
        this.year = year;
    }

    public Integer getMonth() {
        return month;
    }

    public void setMonth(Integer month) {
        this.month = month;
    }

    public String getMerchandiser() {
        return merchandiser;
    }

    public void setMerchandiser(String merchandiser) {
        this.merchandiser = merchandiser;
    }

    public void setRefNo(String refNo) {
        this.refNo = refNo;
    }

    public String getRefNo() {
        return refNo;
    }

    public boolean isSearchByRefno() {
        return searchByRefno;
    }

    public String searchByRefNo() {
        this.foxySessionData.setAction(LST);
        this.searchByRefno = true;
        return (null);
    }

    public String search() {
        this.foxySessionData.setAction(LST);

        if (this.year != null && this.month != null) {
            Calendar cal = Calendar.getInstance();
            // This is the right way to set the month
            cal.set(Calendar.YEAR, this.year);
            cal.set(Calendar.MONTH, (this.month - 1));
            cal.set(Calendar.DAY_OF_MONTH, cal.getActualMinimum(Calendar.DAY_OF_MONTH));
            //this.fromDate = cal.getTime();
            this.setFromDate(cal.getTime());

            cal.set(Calendar.DAY_OF_MONTH, cal.getActualMaximum(Calendar.DAY_OF_MONTH));
            //this.toDate = cal.getTime();
            this.setToDate(cal.getTime());
        }

        return (null);
    }

    public DataModel getProductionReportData() {
        List<ReportDataBean> recordList = null;
        if (this.country != null || this.refNo != null) {
            try {
                //System.err.println("Search for records " +  this.country + "  " + this.quota + " " + this.fromDate + " " + this.toDate);
                SQLQuery q = null;
                Session session = (Session) HibernateUtil.currentSession();
                Transaction tx = session.beginTransaction();

                String qstr = "SELECT od.orderid as orderid, os.month as month, os.location as location, ";
                qstr += "  oc.sublocation as sublocation, od.stylecode as stylecode, par2.shortdesc as origin, ";
                qstr += "  od.custcode as custcode, od.custbrand as custbrand, od.custdivision as custdivision, SUBSTRING(od.wash,1,10) as wash, ";
                qstr += "  os.ship as ship, os.delivery as delivery, oc.ponumber as ponumber, oc.closedate as closedate, ";
                qstr += "  oc.vesseldate vesseldate, oc.fabricdate as fabricdate, ";
                qstr += "  oc.mrforcust as custMr, oc.emb as emb, sh.etd as etd,  ";
                qstr += "  oc.qtydzn as qtydzn, SUBSTRING(oc.remark,1,15) as remark, ";
                qstr += "  cat.category as category, par1.shortdesc as destination ";
                qstr += "  FROM orders as od ";
                qstr += "  LEFT JOIN ordsummary as os on od.orderid = os.orderid ";
                qstr += "  LEFT JOIN ordconfirm as oc on oc.srefid  = os.srefid ";
                qstr += "  LEFT JOIN shipping   as sh on sh.crefid  = oc.crefid ";
                qstr += "  LEFT JOIN category   as cat on cat.catid = os.catid ";
                qstr += "  LEFT JOIN factorymast fm ON fm.factorycode = os.mainfactory ";
                qstr += "  LEFT JOIN parameter  as par1 on par1.code  = os.destination AND par1.category = 'DEST' ";
                qstr += "  LEFT JOIN parameter  as par2 on par2.code  = fm.countrycode AND par2.category = 'CNTY' ";
                qstr += "  WHERE od.status != 'D' ";

                if (this.searchByRefno) {
                    qstr += " AND od.orderid = :porderid ";
                    qstr += " ORDER BY orderid, month, location, sublocation ";
                    q = session.createSQLQuery(qstr);
                    q.setString("porderid", this.refNo);
                } else {
                    //List all order without any lot entered if one of the parameter leave blank
                    if (this.country == null || this.getFromDate() == null || this.getToDate() == null) {
                        qstr += " AND ISNULL(os.delivery) ";
                    } else { //put in filter only if all paramenter are specified
                        qstr += "  AND ( os.delivery >= :pdateStart AND  os.delivery <= :pdateEnd AND fm.countrycode = :porigin ) ";

                        if (this.mainfactory != null && this.mainfactory.equals("ALLSELECTED") == false) {
                            qstr = qstr + " AND  fm.factorycode = :pfactory ";
                        }

                    }

                    if (this.merchandiser != null) {
                        qstr += " AND  od.merchandiser = :pmerchandiser ";
                    }

                    qstr += " ORDER BY orderid, month, location, sublocation ";

                    //System.err.println("Test 1111111122222");
                    q = session.createSQLQuery(qstr);
                    //System.err.println("Test 1111111122222333333");
                    if (this.country != null && this.getFromDate() != null && this.getToDate() != null) {
                        q.setString("porigin", this.country);

                        if (this.mainfactory != null && this.mainfactory.equals("ALLSELECTED") == false) {
                            q.setString("pfactory", this.mainfactory);
                        }

                        q.setDate("pdateStart", this.getFromDate());
                        q.setDate("pdateEnd", this.getToDate());
                    }

                    if (this.merchandiser != null) {
                        q.setString("pmerchandiser", this.merchandiser);
                    }
                }//Filter for normal search fields

                //add scalar
                //line 1
                q.addScalar("orderid", Hibernate.STRING);
                q.addScalar("month", Hibernate.STRING);
                q.addScalar("location", Hibernate.STRING);
                //line 2
                q.addScalar("sublocation", Hibernate.STRING);
                q.addScalar("stylecode", Hibernate.STRING);
                q.addScalar("origin", Hibernate.STRING);
                //line 3
                q.addScalar("custcode", Hibernate.STRING);
                q.addScalar("custbrand", Hibernate.STRING);
                q.addScalar("custdivision", Hibernate.STRING);
                q.addScalar("wash", Hibernate.STRING);
                //line 4
                q.addScalar("ship", Hibernate.STRING);
                q.addScalar("delivery", Hibernate.DATE);
                q.addScalar("ponumber", Hibernate.STRING);
                q.addScalar("closedate", Hibernate.DATE);
                //line 4
                q.addScalar("vesseldate", Hibernate.DATE);
                q.addScalar("fabricdate", Hibernate.DATE);
                //line 5
                q.addScalar("custMr", Hibernate.STRING);
                q.addScalar("emb", Hibernate.STRING);
                q.addScalar("etd", Hibernate.DATE);
                //line 6
                q.addScalar("qtydzn", Hibernate.DOUBLE);
                q.addScalar("remark", Hibernate.STRING);
                //line 7
                q.addScalar("category", Hibernate.STRING);
                q.addScalar("destination", Hibernate.STRING);


                //recordList = q.list();
                //System.err.println("Test 111111112222233333344444444");
                Iterator it = q.list().iterator();

                //System.err.println("Total records = " + q.list().size());

                if (recordList == null) {
                    recordList = new ArrayList();
                }

                //System.err.println("Test 11111");
                Double d1 = null;
                ReportDataBean grandTotal = new ReportDataBean();
                try {
                    grandTotal.setOrderId(new String("Grand Total:"));
                    Double tmp = null;
                    while (it.hasNext()) {
                        int idx = 0;
                        Object[] tmpRow = (Object[]) it.next();
                        ReportDataBean obj = new ReportDataBean();
                        obj.setOrderId((String) tmpRow[idx++]);
                        obj.setMonth((String) tmpRow[idx++]);
                        obj.setLocation((String) tmpRow[idx++]);
                        obj.setSubLocation((String) tmpRow[idx++]);
                        obj.setStylecode((String) tmpRow[idx++]);
                        obj.setOrigin((String) tmpRow[idx++]);
                        obj.setCustCode((String) tmpRow[idx++]);
                        obj.setCustBrand((String) tmpRow[idx++]);
                        obj.setCustDivision((String) tmpRow[idx++]);
                        obj.setWash((String) tmpRow[idx++]);
                        obj.setShip((String) tmpRow[idx++]);
                        obj.setDeliveryDate((Date) tmpRow[idx++]);
                        obj.setPoNumber((String) tmpRow[idx++]);
                        obj.setCloseDate((Date) tmpRow[idx++]);
                        obj.setVesselDate((Date) tmpRow[idx++]);
                        obj.setFabricDate((Date) tmpRow[idx++]);
                        obj.setMrForCust((String) tmpRow[idx++]);
                        obj.setEmb((String) tmpRow[idx++]);
                        obj.setEtd((Date) tmpRow[idx++]);
                        d1 = (Double) tmpRow[idx++];
                        obj.setQtyDzn(d1);
                        grandTotal.accumulateQtyDzn(d1);
                        obj.setRemark((String) tmpRow[idx++]);
                        obj.setCategory((String) tmpRow[idx++]);
                        obj.setDestination((String) tmpRow[idx++]);

                        recordList.add(obj);
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }

                recordList.add(grandTotal);

                //System.err.println("Test 1111144444");
                if (dataListModel == null) {
                    //System.err.println("Search for records 333");
                    dataListModel = new ListDataModel();
                }

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
        } else {
            System.err.println("No records ....!!! Search key is null");
        }
        //Avoid null pointer exception
        if (dataListModel == null) {
            System.err.println("No records ....!!!");
            dataListModel = new ListDataModel();
        }

        return dataListModel;
    }
}
