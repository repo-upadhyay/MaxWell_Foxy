/*
 * FoxyCRptsFabricAccsPage.java
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
public class FoxyCRptsFabricAccsPage extends Page implements Serializable {

    private static String MENU_CODE = new String("FOXY");
    private DataModel dataListModel;
    private String invType = null;
    private String refno = null;
    private String country = null;
    private Date Jan01 = null;
    private SimpleDateFormat fmt1 = new SimpleDateFormat("yyyy-MM-dd");
    private SimpleDateFormat fmt2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    public class ReportDataBean {

        private String invoice = null;
        private Date invdate = null;
        private Double qty = null;
        private String unit = null;
        private String supplier = null;
        private String type = null;
        private Double value = null;
        private String currency = null;
        private Double basevalue = null;
        private Double unitcost = null;
        private String itemdesc = null;
        private String remarks = null;
        private Double forexrate = null;
        private Double assignedQty = null;
        private Double assignedUnitcost = null;
        private Double assignedBasevalue = null;
        private Double assignedFocval = null;
        private String assignedItemdesc = null;
        private String assignedRefno = null;

        public String getInvoice() {
            return invoice;
        }

        public void setInvoice(String invoice) {
            this.invoice = invoice;
        }

        public Date getInvdate() {
            return invdate;
        }

        public void setInvdate(Date invdate) {
            this.invdate = invdate;
        }

        public Double getQty() {
            return qty;
        }

        public void setQty(Double qty) {
            this.qty = qty;
        }

        public String getUnit() {
            return unit;
        }

        public void setUnit(String unit) {
            this.unit = unit;
        }

        public String getSupplier() {
            return supplier;
        }

        public void setSupplier(String supplier) {
            this.supplier = supplier;
        }

        public String getType() {
            return type;
        }

        public void setType(String type) {
            this.type = type;
        }

        public Double getValue() {
            return value;
        }

        public void setValue(Double value) {
            this.value = value;
        }

        public String getCurrency() {
            return currency;
        }

        public void setCurrency(String currency) {
            this.currency = currency;
        }

        public Double getBasevalue() {
            return basevalue;
        }

        public void setBasevalue(Double basevalue) {
            this.basevalue = basevalue;
        }

        public Double getUnitcost() {
            return unitcost;
        }

        public void setUnitcost(Double unitcost) {
            this.unitcost = unitcost;
        }

        public String getItemdesc() {
            return itemdesc;
        }

        public void setItemdesc(String itemdesc) {
            this.itemdesc = itemdesc;
        }

        public String getRemarks() {
            return remarks;
        }

        public void setRemarks(String remarks) {
            this.remarks = remarks;
        }

        public Double getForexrate() {
            return forexrate;
        }

        public void setForexrate(Double forexrate) {
            this.forexrate = forexrate;
        }

        public void AccumulateAssgnQty(Double qty) {
            if (qty != null) {
                if (this.assignedQty == null) {
                    this.assignedQty = qty;
                } else {
                    this.assignedQty += qty;
                }
            }
        }

        public Double getAssignedQty() {
            return assignedQty;
        }

        public void setAssignedQty(Double assignedQty) {
            this.assignedQty = assignedQty;
        }

        public Double getAssignedUnitcost() {
            return assignedUnitcost;
        }

        public void setAssignedUnitcost(Double assignedUnitcost) {
            this.assignedUnitcost = assignedUnitcost;
        }

        public Double getAssignedBasevalue() {
            return assignedBasevalue;
        }

        public void setAssignedBasevalue(Double assignedBasevalue) {
            this.assignedBasevalue = assignedBasevalue;
        }

        public void AccumulateAssgnBasevalue(Double tmpval) {
            if (tmpval != null) {
                if (this.assignedBasevalue == null) {
                    this.assignedBasevalue = tmpval;
                } else {
                    this.assignedBasevalue += tmpval;
                }
            }
        }

        public Double getAssignedFocval() {
            return assignedFocval;
        }

        public void setAssignedFocval(Double assignedFocval) {
            this.assignedFocval = assignedFocval;
        }

        public String getAssignedRefno() {
            return assignedRefno;
        }

        public void setAssignedRefno(String assignedRefno) {
            this.assignedRefno = assignedRefno;
        }

        public String getAssignedItemdesc() {
            return assignedItemdesc;
        }

        public void setAssignedItemdesc(String assignedItemdesc) {
            this.assignedItemdesc = assignedItemdesc;
        }
    }; //Inner class end

    public FoxyCRptsFabricAccsPage() {
        super(new String("FabricAccsReportsForm"));

        try {
            this.isAuthorize(MENU_CODE);
            //System.out.println(ctx.getApplication().getViewHandler().toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public String getInvType() {
        return invType;
    }

    public void setInvType(String invType) {
        this.invType = invType;
    }

    public String getRefno() {
        return refno;
    }

    public void setRefno(String refno) {
        this.refno = refno;
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

    public String getTitle() {
        String str = " ";
        if (this.invType != null) {
            if (this.invType.equals("ALLSELECTED")) {
                str += " [All Inv Types] ";
            } else {
                str += " [" + this.invType + "] ";
            }
        }

        if (this.refno != null) {
            str += " RefNo[" + this.refno + "] ";
        } else if (this.getFromDate() != null && this.getToDate() == null) {
            str += " Key-In Date [" + fmt1.format(this.getFromDate()) + "] ";
        } else {
            if (this.country.length() > 0) {
                str += " Made in [" + this.getCountryName() + "]";
            }
            if (this.getFromDate() != null && this.getToDate() != null) {
                str += " From [" + fmt1.format(this.getFromDate()) + "] ";
                str += " To [" + fmt1.format(this.getToDate()) + "] ";
            }
        }
        str += " As At [" + fmt2.format(new Date()) + "] ";
        return str;
    }

    public String search() {
        this.foxySessionData.setAction(LST);
        this.refno = null;
        return (null);
    }

    public String searchByRefNo() {
        this.foxySessionData.setAction(LST);
        this.setFromDate(null);
        return (null);
    }

    public String searchInsDate() {
        this.foxySessionData.setAction(LST);
        this.refno = null;
        this.setToDate(null);
        return (null);
    }

    /**
     * *******************************************************************************************************************************
     *
     */
    public DataModel getReportData() {
        List<ReportDataBean> dataList = null;
        Date tmpstartd = this.getFromDate();
        System.err.println("from date=" + tmpstartd);
        if (tmpstartd != null || this.refno != null) {
            try {
                Session session = (Session) HibernateUtil.currentSession();
                Transaction tx = session.beginTransaction();

                String qstr = " SELECT a.invoice as invoice, a.invdate as invdate, a.quantity as qty, a.unit as unit, a.supplier as supplier, ";
                qstr += " a.type as type, a.value as value, a.currency as currency, a.basevalue as basevalue, a.unitcost as unitcost, ";
                qstr += " a.itemdesc as itemdesc, a.remarks as remarks, a.forexrate as forexrate, ";
                qstr += " m.quantity as assgn_qty, m.unitcost as assgn_unitcost, m.focval as assgn_focval, ";
                qstr += " m.itemdesc as assgn_itemdesc, CONCAT(os.orderid, os.month, os.location) as assgn_refno";
                qstr += " FROM invmovement m  ";
                qstr += " LEFT JOIN inventory a ON a.invrefid = m.invrefid ";
                qstr += " LEFT JOIN ordsummary os ON os.srefid = m.srefid ";
                qstr += " LEFT JOIN factorymast fm ON fm.factorycode = os.mainfactory ";
                if (this.refno == null && this.getToDate() != null) {
                    qstr += " WHERE a.type = :ptype AND a.invdate >= :pstartDate AND a.invdate <= :pendDate ";
                    if (this.country.length() > 0) {
                        qstr += " AND fm.countrycode = :porigin ";
                    }
                } else if (this.refno == null && tmpstartd != null) {
                    qstr += " WHERE m.instime >= :pinstime1 ";
                    qstr += " AND m.instime <  :pinstime2 ";

                } else {
                    if (this.invType.equals("ALLSELECTED")) {
                        qstr += " WHERE os.orderid = :porderid ";
                    } else {
                        qstr += " WHERE a.type = :ptype AND os.orderid = :porderid ";
                    }
                }
                qstr += " ORDER BY a.invoice ";
                //System.err.println("SQL=[" +  qstr + "]");

                SQLQuery q = session.createSQLQuery(qstr);
                //Set filters
                if (this.refno == null && this.getToDate() != null) {
                    q.setDate("pstartDate", tmpstartd);
                    q.setDate("pendDate", this.getToDate());
                    q.setString("ptype", this.invType);
                    if (this.country.length() > 0) {
                        q.setString("porigin", this.country);
                        //System.err.println("SQL Origin =[" +  this.country + "]");
                    }
                } else if (this.refno == null && tmpstartd != null) {
                    Calendar cal = Calendar.getInstance();
                    cal.setTime(tmpstartd);
                    cal.add(Calendar.DAY_OF_MONTH, 1);
                    Date tmpFromDate2 = cal.getTime();
                    q.setDate("pinstime1", tmpstartd);
                    q.setDate("pinstime2", tmpFromDate2);

                } else {
                    if (!this.invType.equals("ALLSELECTED")) {
                        q.setString("ptype", this.invType);
                    }
                    q.setString("porderid", this.refno);

                }

                //set data binding
                q.addScalar("invoice", Hibernate.STRING);
                q.addScalar("invdate", Hibernate.DATE);
                q.addScalar("qty", Hibernate.DOUBLE);
                q.addScalar("unit", Hibernate.STRING);
                q.addScalar("supplier", Hibernate.STRING);
                q.addScalar("type", Hibernate.STRING);
                q.addScalar("value", Hibernate.DOUBLE);
                q.addScalar("currency", Hibernate.STRING);
                q.addScalar("basevalue", Hibernate.DOUBLE);
                q.addScalar("unitcost", Hibernate.DOUBLE);
                q.addScalar("itemdesc", Hibernate.STRING);
                q.addScalar("remarks", Hibernate.STRING);
                q.addScalar("forexrate", Hibernate.DOUBLE);
                q.addScalar("assgn_qty", Hibernate.DOUBLE);
                q.addScalar("assgn_unitcost", Hibernate.DOUBLE);
                q.addScalar("assgn_focval", Hibernate.DOUBLE);
                q.addScalar("assgn_itemdesc", Hibernate.STRING);
                q.addScalar("assgn_refno", Hibernate.STRING);


                Iterator it = q.list().iterator();
                tx.commit();

                if (dataList == null) {
                    dataList = new ArrayList();
                }

                String tmpinvoice = null;
                String previnvoice = null;
                Double d1 = null;
                Double tmpforex = null;
                Double tmpunitcost = null;
                Double tmpval = null;
                Double tmpInvoiceTotalBaseVal1 = null;
                Double tmpInvoiceTotalBaseVal2 = null;
                ReportDataBean grandTotal = new ReportDataBean();
                grandTotal.setInvoice("Grand Total");
                ReportDataBean subTotal = new ReportDataBean();
                subTotal.setInvoice("SubTotal");

                try { //loop of all applicable order id
                    while (it.hasNext()) {
                        Object[] tmpRow = (Object[]) it.next();
                        int i = 0;
                        ReportDataBean obj = new ReportDataBean();


                        tmpinvoice = (String) tmpRow[i++];
                        if (!tmpinvoice.equals(previnvoice)) {
                            obj.setInvoice(tmpinvoice);
                            obj.setInvdate((Date) tmpRow[i++]);
                            obj.setQty((Double) tmpRow[i++]);
                            obj.setUnit((String) tmpRow[i++]);
                            obj.setSupplier((String) tmpRow[i++]);
                            obj.setType((String) tmpRow[i++]);
                            obj.setValue((Double) tmpRow[i++]);
                            obj.setCurrency((String) tmpRow[i++]);
                            tmpInvoiceTotalBaseVal2 = tmpInvoiceTotalBaseVal1;
                            tmpInvoiceTotalBaseVal1 = (Double) tmpRow[i++];
                            obj.setBasevalue(tmpInvoiceTotalBaseVal1);
                            obj.setUnitcost((Double) tmpRow[i++]);
                            obj.setItemdesc((String) tmpRow[i++]);
                            obj.setRemarks((String) tmpRow[i++]);
                        } else {
                            i += 11;
                        }
                        tmpforex = (Double) tmpRow[i++];
                        obj.setForexrate(tmpforex);
                        d1 = (Double) tmpRow[i++];
                        obj.setAssignedQty(d1);
                        tmpunitcost = (Double) tmpRow[i++];
                        obj.setAssignedUnitcost(tmpunitcost);
                        tmpval = super.roundDouble(d1 * tmpunitcost * tmpforex, 2);
                        obj.setAssignedBasevalue(tmpval);
                        obj.setAssignedFocval((Double) tmpRow[i++]);
                        obj.setAssignedItemdesc((String) tmpRow[i++]);
                        obj.setAssignedRefno((String) tmpRow[i++]);

                        if (previnvoice == null || tmpinvoice.equals(previnvoice)) {
                            subTotal.AccumulateAssgnQty(d1);
                            subTotal.AccumulateAssgnBasevalue(tmpval);
                            grandTotal.AccumulateAssgnQty(d1);
                            grandTotal.AccumulateAssgnBasevalue(tmpval);
                            if (previnvoice == null) {
                                previnvoice = tmpinvoice;
                            }
                        } else {
                            tmpInvoiceTotalBaseVal2 -= subTotal.getAssignedBasevalue();
                            subTotal.setBasevalue(tmpInvoiceTotalBaseVal2);
                            dataList.add(subTotal);
                            subTotal = new ReportDataBean();
                            subTotal.setInvoice("SubTotal");
                            subTotal.AccumulateAssgnQty(d1);
                            subTotal.AccumulateAssgnBasevalue(tmpval);
                            grandTotal.AccumulateAssgnQty(d1);
                            grandTotal.AccumulateAssgnBasevalue(tmpval);
                            previnvoice = tmpinvoice;
                        }

                        dataList.add(obj);
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }

                //dataList.add(grandTotal);

                if (dataListModel == null) {
                    //System.err.println("Search for records 333");
                    dataListModel = new ListDataModel();
                }

                if (tmpInvoiceTotalBaseVal1 != null) {
                    tmpInvoiceTotalBaseVal1 -= subTotal.getAssignedBasevalue();
                    subTotal.setBasevalue(tmpInvoiceTotalBaseVal1);
                }
                dataList.add(subTotal);
                dataList.add(grandTotal);
                dataListModel.setWrappedData(dataList);

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
