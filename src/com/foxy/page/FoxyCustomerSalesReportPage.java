/*
 * FoxyFactoryYearlyReportPage.java
 *
 * Created on June 20, 2006, 6:18 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */
package com.foxy.page;

import com.foxy.db.CustBrand;
import com.foxy.db.CustDivision;
import com.foxy.db.HibernateUtil;
import com.foxy.db.User;
import com.foxy.util.ListData;
import java.io.IOException;
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
import javax.faces.model.SelectItem;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFDataFormat;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.hibernate.Criteria;
import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Expression;

/**
 *
 * @author hcting
 */
public class FoxyCustomerSalesReportPage extends Page implements Serializable {

    private static String MENU_CODE = "FOXY";
    private DataModel custSalesListModel;
    private List divisionList = null;
    private List divisionAllBrandList = null;
    private String cnameCode = ""; //Defaulted to ALLSELECTED possible value
    private String country = null;
    private String mainfactory = null;
    private String custCode = null;
    private String custDivision = null;
    private String brand = null;
    private String season = null;
    private String colourTypeCode = null;
    private String graphicTypeCode = null;
    private Integer year = null;
    private Integer month = null;
    private String userid = null;
    private String title = "";
    private SimpleDateFormat fmt1 = new SimpleDateFormat("yyyy-MM-dd");
    private SimpleDateFormat fmt2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    private SimpleDateFormat fmt3 = new SimpleDateFormat("MMMM yyyy");
    private List resultList = null;  //List of brand for current custcode
    private List brandList = null;
    private List userList = null;

    public class ReportDataBean {

        private String cnameshort = null;
        private String mainFactory = null;
        private String refNo = null;
        private String month = null;
        private String location = null;
        private String customer = null;
        private String brand = null;
        private String division = null;
        private Date orderDate = null;
        private Date deliveryDate = null;
        private Date fabricDeliveryDate = null;
        private String updatedBy = null;
        private String style = null;
        private Double unitPrice = null;
        private Double qtyd = null;
        private Double qtyp = null;
        private Double totalValue = null;
        private String qunit = null;
        private String season = null;
        private String desc = null;
        private String colourType = null;
        private String graphicType = null;

        public String getCnameshort() {
            return cnameshort;
        }

        public void setCnameshort(String cnameshort) {
            this.cnameshort = cnameshort;
        }

        public String getMainFactory() {
            return mainFactory;
        }

        public void setMainFactory(String mainFactory) {
            this.mainFactory = mainFactory;
        }

        public String getCustomer() {
            return customer;
        }

        public void setCustomer(String customer) {
            this.customer = customer;
        }

        public String getBrand() {
            return brand;
        }

        public void setBrand(String brand) {
            this.brand = brand;
        }

        public String getDivision() {
            return division;
        }

        public void setDivision(String division) {
            this.division = division;
        }

        public String getLocation() {
            return location;
        }

        public void setLocation(String location) {
            this.location = location;
        }

        public String getMonth() {
            return month;
        }

        public void setMonth(String month) {
            this.month = month;
        }

        public Date getOrderDate() {
            return orderDate;
        }

        public void setOrderDate(Date orderDate) {
            this.orderDate = orderDate;
        }

        public Date getDeliveryDate() {
            return deliveryDate;
        }

        public void setDeliveryDate(Date deliveryDate) {
            this.deliveryDate = deliveryDate;
        }

        public void setFabricDeliveryDate(Date fabricDate) {
            this.fabricDeliveryDate = fabricDate;
        }

        public Date getFabricDeliveryDate() {
            return fabricDeliveryDate;
        }

        public void setUpdatedBy(String updatedBy) {
            this.updatedBy = updatedBy;
        }

        public String getUpdatedBy() {
            return updatedBy;
        }

        public Double getQtyd() {
            return qtyd;
        }

        public void setQtyd(Double qtyd) {
            this.qtyd = qtyd;
        }

        public void accumulateQtyD(Double qty) {
            if (qty != null) {
                if (this.qtyd == null) {
                    this.qtyd = qty;
                } else {
                    this.qtyd += qty;
                }
            }
        }

        public Double getQtyp() {
            return qtyp;
        }

        public void setQtyp(Double qtyp) {
            this.qtyp = qtyp;
        }

        public void accumulateQtyP(Double qty) {
            if (qty != null) {
                if (this.qtyp == null) {
                    this.qtyp = qty;
                } else {
                    this.qtyp += qty;
                }
            }
        }

        public String getQunit() {
            return qunit;
        }

        public void setQunit(String qunit) {
            this.qunit = qunit;
        }

        public String getRefNo() {
            return refNo;
        }

        public void setRefNo(String refNo) {
            this.refNo = refNo;
        }

        public String getSeason() {
            return season;
        }

        public void setSeason(String season) {
            this.season = season;
        }

        public String getStyle() {
            return style;
        }

        public void setStyle(String style) {
            this.style = style;
        }

        public Double getUnitPrice() {
            return unitPrice;
        }

        public void setUnitPrice(Double unitPrice) {
            this.unitPrice = unitPrice;
        }

        public Double getTotalValue() {
            return totalValue;
        }

        public void setTotalValue(Double totalValue) {
            this.totalValue = totalValue;
        }

        public void setTotalValue(Double unitprc, Double qtypcs) {
            if (unitprc != null && qtypcs != null) {
                this.totalValue = unitprc * qtypcs;
            }
        }

        public void accumulateTotalValue(Double val) {
            if (val != null) {
                if (this.totalValue == null) {
                    this.totalValue = val;
                } else {
                    this.totalValue += val;
                }
            }
        }

        //Additional method for logic build in
        public Double getDisplayQty() {
            if ("PCS".equals(this.qunit)) { //If pieces then take pcs quantity
                return this.qtyp;
            } else {
                return this.qtyd;
            }
        }

        public String getDesc() {
            return desc;
        }

        public void setDesc(String desc) {
            this.desc = desc;
        }

        public String getColourType() {
            return colourType;
        }

        public void setColourType(String colourType) {
            this.colourType = colourType;
        }

        public String getGraphicType() {
            return graphicType;
        }

        public void setGraphicType(String graphicType) {
            this.graphicType = graphicType;
        }
    }; //Inner class end

    public FoxyCustomerSalesReportPage() {
        super("CustomerOrderReportForm");

        try {
            this.isAuthorize(MENU_CODE);
            //System.out.println(ctx.getApplication().getViewHandler().toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //PROPERTY: Company Name
    public String getCnameCode() {
        return cnameCode;
    }

    public void setCnameCode(String cnameCode) {
        this.cnameCode = cnameCode;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getMainfactory() {
        return mainfactory;
    }

    public void setMainfactory(String mainfactory) {
        this.mainfactory = mainfactory;
    }

    public String getCustCode() {
        return custCode;
    }

    public void setCustCode(String custCode) {
        this.custCode = custCode;
    }

    public String getCustDivision() {
        return custDivision;
    }

    public void setCustDivision(String custDivision) {
        this.custDivision = custDivision;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getSeason() {
        return season;
    }

    public void setSeason(String season) {
        this.season = season;
    }

    public String getColourTypeCode() {
        return colourTypeCode;
    }

    public void setColourTypeCode(String colourTypeCode) {
        this.colourTypeCode = colourTypeCode;
    }

    public String getGraphicTypeCode() {
        return graphicTypeCode;
    }

    public void setGraphicTypeCode(String graphicTypeCode) {
        this.graphicTypeCode = graphicTypeCode;
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

    public String getUserid() {
        return userid;
    }

    public void setUserid(String userid) {
        this.userid = userid;
    }

//PROPERTY: mainFactory
    public String getCountryName() {
        ListData ld = (ListData) getBean("listData");
        return (ld.getCountryDesc(this.getCountry(), 1));
        //return this.mainFactory;
    }

    public String getCnameShort() {
        ListData ld = (ListData) getBean("listData");
        return (ld.getCompanyNameShort(this.getCnameCode(), 1));
    }

    public String getTitle() {
        ListData ld = (ListData) getBean("listData");
        if (this.cnameCode != null) {
            if (this.cnameCode.equals("ALLSELECTED")) {
                title = title + " Company[ All Companies ] ";
            } else {
                title = title + " Company[" + this.getCnameShort() + "] ";
            }
        }

        if (this.country != null) {
            if (this.country.equals("ALLSELECTED")) {
                title = title + " Country[ All Countries ] ";
            } else {
                title = title + " Country[" + this.getCountryName() + "] ";
            }
        }

        if (this.mainfactory != null) {
            if (this.mainfactory.equals("ALLSELECTED")) {
                title = title + " Factory[ All Factories ] ";
            } else {
                title = title + " Factory[" + ld.getFactoryNameShort(this.getMainfactory()) + "] ";
            }
        }

        if (this.custCode != null && this.custCode.length() > 0) {
            title = title + "CustCode [" + this.custCode + "] ";
        }

        if (this.custDivision != null && this.custDivision.length() > 0) {
            title = title + "Division [" + this.custDivision + "] ";
        }

        if (this.year != null && this.month != null) {
            title = "[" + fmt3.format(this.getFromDate()) + "] " + title;
        } else {

            if (this.getFromDate() != null) {
                title = title + "Delivery Date From [" + fmt1.format(this.getFromDate()) + "] ";
            }

            if (this.getToDate() != null) {
                title = title + "To [" + fmt1.format(this.getToDate()) + "] ";
            }
        }

        title = title + "  As At [" + fmt2.format(new Date()) + "]";


        return title;
    }

    public List getFactoryByCountryList() {
        ListData ld = (ListData) getBean("listData");
        return (ld.getFactoryListAllByCountry(this.country));
    }

//Ajax used to get list of devision of current customer code & brand code.
    public List getDivisionItemsList() {
        if (divisionList == null) {
            divisionList = new ArrayList();

            if (this.custCode != null && this.brand != null) { //customer code
                List resultList = null;
                try {
                    Session session = (Session) HibernateUtil.currentSession();
                    Transaction tx = session.beginTransaction();
                    Criteria crit = session.createCriteria(CustDivision.class);
                    crit.add(Expression.eq("custCode", this.custCode));
                    crit.add(Expression.eq("brandCode", this.brand));
                    resultList = crit.list();
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

                if (resultList.size() > 0) {
                    divisionList.add(new SelectItem("", "Pls select one")); //Always add a null items, event no records
                } else {
                    divisionList.add(new SelectItem("", "Empty")); //Always add a null items, event no records
                }

                for (int i = 0; i < resultList.size(); i++) {
                    CustDivision cdivision = (CustDivision) resultList.get(i);
                    divisionList.add(new SelectItem(cdivision.getDivCode(), cdivision.getDivCode() + " - " + cdivision.getDivDesc()));
                }
            } else {
                divisionList.add(new SelectItem("", "Empty")); //Always add a null items, event no records
            }
        }
        return divisionList;
    }

    //Ajax used to get list of devision of current customer code only.   
    public List getDivisionItemsForAllBrandList() {
        if (divisionAllBrandList == null) {
            divisionAllBrandList = new ArrayList();

            if (this.custCode != null) { //customer code
                List resultList = null;
                try {
                    Session session = (Session) HibernateUtil.currentSession();
                    Transaction tx = session.beginTransaction();
                    Criteria crit = session.createCriteria(CustDivision.class);
                    crit.add(Expression.eq("custCode", this.custCode));
                    resultList = crit.list();
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

                if (resultList.size() > 0) {
                    divisionAllBrandList.add(new SelectItem("", "Pls select one")); //Always add a null items, event no records
                } else {
                    divisionAllBrandList.add(new SelectItem("", "Empty")); //Always add a null items, event no records
                }

                for (int i = 0; i < resultList.size(); i++) {
                    CustDivision cdivision = (CustDivision) resultList.get(i);
                    divisionAllBrandList.add(new SelectItem(cdivision.getDivCode(), cdivision.getDivCode() + " - " + cdivision.getDivDesc()));
                }
            } else {
                divisionAllBrandList.add(new SelectItem("", "Empty")); //Always add a null items, event no records
            }
        }
        return divisionAllBrandList;
    }

    public List getBrandItemsList() {
        return getBrandItemsListGeneric(this.getCustCode());
    }

    public List getBrandItemsListGeneric(String currentcustcode) {

        //System.err.println("===>get bean list now");
        brandList = null;
        brandList = new ArrayList();
        brandList.add(new SelectItem("", "")); //Always add a null items, event no records


        if (currentcustcode != null) {
            try {
                Session session = (Session) HibernateUtil.currentSession();
                Transaction tx = session.beginTransaction();
                Criteria crit = session.createCriteria(CustBrand.class);
                //System.err.println("custCode = " + currentcustcode);
                crit.add(Expression.eq("custCode", currentcustcode));
                resultList = crit.list();
                //System.err.println("Result size = " + resultList.size());
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


            for (int i = 0; i < this.resultList.size(); i++) {
                CustBrand cbrand = (CustBrand) this.resultList.get(i);
                brandList.add(new SelectItem(cbrand.getBrandCode(), cbrand.getBrandCode() + " - " + cbrand.getBrandDesc()));
            }
        }

        return brandList;
    }

    public List getUserItemsList() {
        if (userList == null) {

            userList = new ArrayList();
            userList.add(new SelectItem("", "")); //Always add a null items, event no records

            try {
                Session session = (Session) HibernateUtil.currentSession();
                Transaction tx = session.beginTransaction();
                Criteria crit = session.createCriteria(User.class);
                //System.err.println("custCode = " + currentcustcode);
                crit.add(Expression.eq("userGroup", "MK"));
                resultList = crit.list();
                //System.err.println("Result size = " + resultList.size());
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


            for (int i = 0; i < this.resultList.size(); i++) {
                User cuser = (User) this.resultList.get(i);
                userList.add(new SelectItem(cuser.getUserId(), cuser.getUserId()));
            }
        }

        return userList;
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

////////////////////////////////////////////////////////
    public DataModel getCustSalesListModel() {

        //getCustSalesListModelXLSX();

        List<ReportDataBean> custOderList = null;
        if (this.country != null) {
            try {
                //System.err.println("Search for records " +  this.mainFactory + "  " + this.custCode + " " + this.fromDate + " " + this.toDate);
                Session session = (Session) HibernateUtil.currentSession();
                Transaction tx = session.beginTransaction();

                String qstr = "Select ord.custcode as custcode, ord.custbrand as custbrand, ord.custdivision as custdiv, ";
                qstr = qstr + " fm.factoryname as factory, os.orderid as orderid,  os.month as month, os.location as location, ";
                qstr = qstr + " os.qtydzn as qtydzn, os.qtypcs as qtypcs, ord.stylecode as stylecode, pm2.description as season , ";
                qstr = qstr + " ord.orderdate as orddate, os.delivery as delivery, ";
                qstr = qstr + " os.fabricdeliverydate as fabricdeliverydate, os.updusrid as updatedby, ";
                qstr = qstr + " ord.unitprice  as unitprice, SUBSTRING(ord.descf,1,50) as descf, ";
                qstr = qstr + " pm3.description as colourtype, pm4.description as graphictype, ";
                qstr = qstr + " pm5.shortdesc as cnameshort ";
                qstr = qstr + " from  ordsummary os ";
                qstr = qstr + " LEFT JOIN orders ord ON os.orderid = ord.orderid ";
                qstr = qstr + " LEFT JOIN factorymast fm ON fm.factorycode = os.mainfactory ";
                qstr = qstr + " LEFT JOIN parameter  pm2 ON pm2.category = 'SEA' AND pm2.code = ord.season ";
                qstr = qstr + " LEFT JOIN parameter  pm3 ON pm3.category = 'COLOR' AND pm3.code = ord.colourtypecode ";
                qstr = qstr + " LEFT JOIN parameter  pm4 ON pm4.category = 'GRAPH' AND pm4.code = ord.graphictypecode ";
                qstr = qstr + " LEFT JOIN parameter  pm5 ON pm5.category = 'CNAME' AND pm5.code = ord.cnamecode ";
                qstr = qstr + " where 1 = 1 ";

                if (this.cnameCode != null && this.cnameCode.equals("ALLSELECTED") == false) {
                    qstr = qstr + " AND  ord.cnamecode = :pcnameCode ";
                }

                if (this.country != null && this.country.equals("ALLSELECTED") == false) {
                    qstr = qstr + " AND  fm.countrycode = :porigin ";
                }

                if (this.mainfactory != null && this.mainfactory.equals("ALLSELECTED") == false) {
                    qstr = qstr + " AND  fm.factorycode = :pfactory ";
                }

                if (this.custCode != null && this.custCode.length() > 0) {
                    qstr = qstr + " AND ord.custCode = :pcustCode ";
                }

                if (this.custDivision != null && this.custDivision.length() > 0) {
                    qstr = qstr + " AND ord.custDivision = :pcustDivision ";
                }

                if (this.brand != null && this.brand.length() > 0) {
                    qstr = qstr + " AND ord.custBrand = :pcustBrand ";
                }

                if (this.season != null && this.season.length() > 0) {
                    qstr = qstr + " AND ord.season = :pseason ";
                }

                if (this.userid != null && this.userid.length() > 0) {
                    qstr = qstr + " AND ord.updusrid = :puserid ";
                }

                if (this.colourTypeCode != null && this.colourTypeCode.length() > 0) {
                    qstr = qstr + " AND ord.colourtypecode = :pcolourtypecode ";
                }

                if (this.graphicTypeCode != null && this.graphicTypeCode.length() > 0) {
                    qstr = qstr + " AND ord.graphictypecode = :pgraphictypecode ";
                }

                if (this.getFromDate() != null) {
                    qstr = qstr + " AND os.delivery >= :pdeliveryDateFrom ";
                }

                if (this.getToDate() != null) {
                    qstr = qstr + " AND os.delivery <= :pdeliveryDateTo ";
                }

                qstr = qstr + " Order by ord.custCode, ord.custBrand, ord.custDivision, os.orderId,  os.month, os.location ";


                //System.err.println("Search qstr  = " + qstr);


                SQLQuery q = session.createSQLQuery(qstr);


                //Set all parameter value if applicable
                if (this.cnameCode != null && this.cnameCode.equals("ALLSELECTED") == false) {
                    q.setString("pcnameCode", this.cnameCode);
                }

                if (this.country != null && this.country.equals("ALLSELECTED") == false) {
                    q.setString("porigin", this.country);
                }

                if (this.mainfactory != null && this.mainfactory.equals("ALLSELECTED") == false) {
                    q.setString("pfactory", this.mainfactory);
                }

                if (this.custCode != null && this.custCode.length() > 0) {
                    q.setString("pcustCode", this.custCode);
                }

                if (this.custDivision != null && this.custDivision.length() > 0) {
                    q.setString("pcustDivision", this.custDivision);
                }

                if (this.brand != null && this.brand.length() > 0) {
                    q.setString("pcustBrand", this.brand);
                }

                if (this.season != null && this.season.length() > 0) {
                    q.setString("pseason", this.season);
                }

                if (this.userid != null && this.userid.length() > 0) {
                    q.setString("puserid", this.userid);
                }

                if (this.colourTypeCode != null && this.colourTypeCode.length() > 0) {
                    q.setString("pcolourtypecode", this.colourTypeCode);
                }
                if (this.graphicTypeCode != null && this.graphicTypeCode.length() > 0) {
                    q.setString("pgraphictypecode", this.graphicTypeCode);
                }

                if (this.getFromDate() != null) {
                    q.setDate("pdeliveryDateFrom", this.getFromDate());
                }

                if (this.getToDate() != null) {
                    q.setDate("pdeliveryDateTo", this.getToDate());
                }


                q.addScalar("custcode", Hibernate.STRING);
                q.addScalar("custbrand", Hibernate.STRING);
                q.addScalar("custdiv", Hibernate.STRING);
                q.addScalar("factory", Hibernate.STRING);
                q.addScalar("orderid", Hibernate.STRING);
                q.addScalar("month", Hibernate.STRING);
                q.addScalar("location", Hibernate.STRING);
                q.addScalar("qtydzn", Hibernate.DOUBLE);
                q.addScalar("qtypcs", Hibernate.DOUBLE);
                q.addScalar("stylecode", Hibernate.STRING);
                q.addScalar("season", Hibernate.STRING);
                q.addScalar("orddate", Hibernate.DATE);
                q.addScalar("delivery", Hibernate.DATE);
                q.addScalar("fabricdeliverydate", Hibernate.DATE);
                q.addScalar("updatedby", Hibernate.STRING);
                q.addScalar("unitprice", Hibernate.DOUBLE);
                q.addScalar("descf", Hibernate.STRING);
                q.addScalar("colourtype", Hibernate.STRING);
                q.addScalar("graphictype", Hibernate.STRING);
                q.addScalar("cnameshort", Hibernate.STRING);



                //custOderList = q.list();
                Iterator it = q.list().iterator();
                if (custOderList == null) {
                    custOderList = new ArrayList();
                }

                //System.err.println("Search for records 2222");

                ReportDataBean subTotal = new ReportDataBean();
                ReportDataBean grandTotal = new ReportDataBean();
                grandTotal.setQtyd(new Double(0));
                grandTotal.setQtyp(new Double(0));
                Double d1 = null;
                Double d2 = null;

                while (it.hasNext()) {
                    Object[] tmpRow = (Object[]) it.next();
                    int i = 0;
                    //System.err.println("Search for records 333");
                    ReportDataBean obj = new ReportDataBean();
                    try {
                        obj.setCustomer((String) tmpRow[i++]);
                        obj.setBrand((String) tmpRow[i++]);
                        obj.setDivision((String) tmpRow[i++]);
                        obj.setMainFactory((String) tmpRow[i++]);
                        obj.setRefNo((String) tmpRow[i++]);
                        obj.setMonth((String) tmpRow[i++]);
                        obj.setLocation((String) tmpRow[i++]);
                        obj.setQtyd((Double) tmpRow[i++]);
                        d1 = (Double) tmpRow[i++];
                        obj.setQtyp(d1);
                        obj.setStyle((String) tmpRow[i++]);
                        obj.setSeason((String) tmpRow[i++]);
                        obj.setOrderDate((Date) tmpRow[i++]);
                        obj.setDeliveryDate((Date) tmpRow[i++]);
                        obj.setFabricDeliveryDate((Date) tmpRow[i++]);
                        obj.setUpdatedBy((String) tmpRow[i++]);
                        d2 = (Double) tmpRow[i++];
                        obj.setUnitPrice(d2);
                        obj.setDesc((String) tmpRow[i++]);
                        obj.setColourType((String) tmpRow[i++]);
                        obj.setGraphicType((String) tmpRow[i++]);
                        obj.setCnameshort((String) tmpRow[i++]);
                        obj.setTotalValue(d2, d1);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }



                    //System.err.println("Search for records3332222");
                    try {
                        if (!obj.getCustomer().equals(subTotal.getCustomer())
                                || !obj.getBrand().equals(subTotal.getBrand())
                                || !obj.getDivision().equals(subTotal.getDivision())) {
                            subTotal.setCustomer("Sub Total");
                            subTotal.setBrand(null);
                            subTotal.setDivision(null);
                            if (custOderList.size() > 0) { //First item can not be total
                                custOderList.add(subTotal);
                                grandTotal.accumulateQtyD(subTotal.getQtyd());
                                grandTotal.accumulateQtyP(subTotal.getQtyp());
                                grandTotal.accumulateTotalValue(subTotal.getTotalValue());
                            }
                            subTotal = new ReportDataBean();
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }

                    //System.err.println("Search for records33344444");


                    if (subTotal.getCustomer() == null) {
                        subTotal.setCustomer(obj.getCustomer());
                        subTotal.setBrand(obj.getBrand());
                        subTotal.setDivision(obj.getDivision());
                    }


                    custOderList.add(obj);

                    //System.err.println("Search for records 555555");
                    //Accumulate sub total
                    if (subTotal.getQtyp() == null) {
                        subTotal.setQtyp(obj.getQtyp());
                        subTotal.setQtyd(obj.getQtyd());
                        subTotal.setTotalValue(d2, d1);
                    } else {
                        subTotal.accumulateQtyP(obj.getQtyp());
                        subTotal.accumulateQtyD(obj.getQtyd());
                        if (d1 != null && d2 != null) {
                            subTotal.accumulateTotalValue(d1 * d2);
                        }
                    }

                }

                if (custOderList.size() > 0) { //First item can not be total

                    //Add in subtotal for last group
                    subTotal.setCustomer("Sub Total");
                    subTotal.setBrand(null);
                    subTotal.setDivision(null);
                    custOderList.add(subTotal);

                    //Add in grand total
                    grandTotal.accumulateQtyD(subTotal.getQtyd());
                    grandTotal.accumulateQtyP(subTotal.getQtyp());
                    grandTotal.accumulateTotalValue(subTotal.getTotalValue());
                    grandTotal.setCustomer("Grand Total");
                    grandTotal.setBrand(null);
                    grandTotal.setDivision(null);
                    custOderList.add(grandTotal);
                }


                //System.err.println("Search for records 111, size = " + custOderList.size());
                custSalesListModel = null;
                custSalesListModel = new ListDataModel();
                if (custOderList.isEmpty()) {
                    ReportDataBean os = new ReportDataBean();
                    custOderList.add(os);
                }

                custSalesListModel.setWrappedData(custOderList);
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
        return custSalesListModel;
    }

    public String CustSalesListModelXLSX() throws IOException {
        HttpServletResponse resp = (HttpServletResponse) this.ectx.getResponse();

        //DOC
        XSSFWorkbook wb = new XSSFWorkbook();

        //SHEET
        XSSFSheet sh = wb.createSheet("Customer Sales Report");
        sh.createFreezePane(0, 1, 0, 1);

        //Second sheet to keep search parameter info
        XSSFSheet sh2 = wb.createSheet("Search Parameter Detail info");

        this.foxySessionData.setAction(SCH);

        //System.err.println("Country = " + this.mainFactory);
        //System.err.println("CustCode = " + this.custCode);

        if (this.country != null) {
            try {
                //System.err.println("Search for records " +  this.mainFactory + "  " + this.custCode + " " + this.fromDate + " " + this.toDate);
                Session session = (Session) HibernateUtil.currentSession();
                Transaction tx = session.beginTransaction();

                String qstr = "Select os.orderid as orderid, os.month as month, os.location as location, ";
                qstr = qstr + " os.fabricdeliverydate as fabricdeliverydate, pm5.shortdesc as cnameshort, ";
                qstr = qstr + " ord.custcode as custcode, ord.custbrand as custbrand, ";
                qstr = qstr + " ord.custdivision as custdiv, pm2.description as season, os.delivery as delivery, ";
                qstr = qstr + " ord.stylecode as stylecode, ord.unitprice  as unitprice, os.qtydzn as qtydzn, ";
                qstr = qstr + " os.qtypcs as qtypcs, fm.factoryname as factory, ord.orderdate as orddate,  ";
                qstr = qstr + " os.updusrid as updatedby, ";
                qstr = qstr + " ord.descf as descf, ";
                qstr = qstr + " pm3.description as colourtype, pm4.description as graphictype, ";
                qstr = qstr + " ord.fabrication as fabrication ";
                qstr = qstr + " from  ordsummary os ";
                qstr = qstr + " LEFT JOIN orders ord ON os.orderid = ord.orderid ";
                qstr = qstr + " LEFT JOIN factorymast fm ON fm.factorycode = os.mainfactory ";
                qstr = qstr + " LEFT JOIN parameter  pm2 ON pm2.category = 'SEA' AND pm2.code = ord.season ";
                qstr = qstr + " LEFT JOIN parameter  pm3 ON pm3.category = 'COLOR' AND pm3.code = ord.colourtypecode ";
                qstr = qstr + " LEFT JOIN parameter  pm4 ON pm4.category = 'GRAPH' AND pm4.code = ord.graphictypecode ";
                qstr = qstr + " LEFT JOIN parameter  pm5 ON pm5.category = 'CNAME' AND pm5.code = ord.cnamecode ";
                qstr = qstr + " where 1 = 1 ";

                if (this.cnameCode != null && this.cnameCode.equals("ALLSELECTED") == false) {
                    qstr = qstr + " AND  ord.cnamecode = :pcnameCode ";
                }

                if (this.country != null && this.country.equals("ALLSELECTED") == false) {
                    qstr = qstr + " AND  fm.countrycode = :porigin ";
                }

                if (this.mainfactory != null && this.mainfactory.equals("ALLSELECTED") == false) {
                    qstr = qstr + " AND  fm.factorycode = :pfactory ";
                }

                if (this.custCode != null && this.custCode.length() > 0) {
                    qstr = qstr + " AND ord.custCode = :pcustCode ";
                }

                if (this.custDivision != null && this.custDivision.length() > 0) {
                    qstr = qstr + " AND ord.custDivision = :pcustDivision ";
                }

                if (this.brand != null && this.brand.length() > 0) {
                    qstr = qstr + " AND ord.custBrand = :pcustBrand ";
                }

                if (this.season != null && this.season.length() > 0) {
                    qstr = qstr + " AND ord.season = :pseason ";
                }

                if (this.userid != null && this.userid.length() > 0) {
                    qstr = qstr + " AND ord.updusrid = :puserid ";
                }

                if (this.colourTypeCode != null && this.colourTypeCode.length() > 0) {
                    qstr = qstr + " AND ord.colourtypecode = :pcolourtypecode ";
                }

                if (this.graphicTypeCode != null && this.graphicTypeCode.length() > 0) {
                    qstr = qstr + " AND ord.graphictypecode = :pgraphictypecode ";
                }

                if (this.getFromDate() != null) {
                    qstr = qstr + " AND os.delivery >= :pdeliveryDateFrom ";
                }

                if (this.getToDate() != null) {
                    qstr = qstr + " AND os.delivery <= :pdeliveryDateTo ";
                }

                qstr = qstr + " Order by ord.custCode, ord.custBrand, ord.custDivision, os.orderId,  os.month, os.location ";


                //System.err.println("Search qstr  = " + qstr);


                SQLQuery q = session.createSQLQuery(qstr);


                //Set all parameter value if applicable
                if (this.cnameCode != null && this.cnameCode.equals("ALLSELECTED") == false) {
                    q.setString("pcnameCode", this.cnameCode);
                }

                if (this.country != null && this.country.equals("ALLSELECTED") == false) {
                    q.setString("porigin", this.country);
                    //System.err.println("Country = " + this.mainFactory);
                }

                if (this.mainfactory != null && this.mainfactory.equals("ALLSELECTED") == false) {
                    q.setString("pfactory", this.mainfactory);
                }

                if (this.custCode != null && this.custCode.length() > 0) {
                    q.setString("pcustCode", this.custCode);
                    //ystem.err.println("CustCode = " + this.custCode);
                }

                if (this.custDivision != null && this.custDivision.length() > 0) {
                    q.setString("pcustDivision", this.custDivision);
                }

                if (this.brand != null && this.brand.length() > 0) {
                    q.setString("pcustBrand", this.brand);
                }

                if (this.season != null && this.season.length() > 0) {
                    q.setString("pseason", this.season);
                }

                if (this.userid != null && this.userid.length() > 0) {
                    q.setString("puserid", this.userid);
                }

                if (this.getFromDate() != null) {
                    q.setDate("pdeliveryDateFrom", this.getFromDate());
                }

                if (this.getToDate() != null) {
                    q.setDate("pdeliveryDateTo", this.getToDate());
                }


                q.addScalar("orderid", Hibernate.STRING);
                q.addScalar("month", Hibernate.STRING);
                q.addScalar("location", Hibernate.STRING);
                q.addScalar("fabricdeliverydate", Hibernate.DATE);
                q.addScalar("cnameshort", Hibernate.STRING);
                q.addScalar("custcode", Hibernate.STRING);
                q.addScalar("custbrand", Hibernate.STRING);
                q.addScalar("custdiv", Hibernate.STRING);
                q.addScalar("season", Hibernate.STRING);
                q.addScalar("delivery", Hibernate.DATE);
                q.addScalar("stylecode", Hibernate.STRING);
                q.addScalar("unitprice", Hibernate.DOUBLE);
                q.addScalar("qtydzn", Hibernate.DOUBLE);
                q.addScalar("qtypcs", Hibernate.DOUBLE);
                q.addScalar("factory", Hibernate.STRING);
                q.addScalar("orddate", Hibernate.DATE);
                q.addScalar("updatedby", Hibernate.STRING);
                q.addScalar("descf", Hibernate.STRING);
                q.addScalar("colourtype", Hibernate.STRING);
                q.addScalar("graphictype", Hibernate.STRING);
                q.addScalar("fabrication", Hibernate.STRING);


                Iterator it = q.list().iterator();
                Double d1;
                Double d2;


                int rowCount = 0;
                int col = 0;
                int i;
                String tmpstr;
                Double tmpDbl;
                Date tmpDate;
                XSSFCell cell_ptr;
                XSSFRow HeaderRow;

                //Write second sheet info first, to populate search parameter details
                HeaderRow = sh2.createRow(rowCount++);
                cell_ptr = HeaderRow.createCell(col++, XSSFCell.CELL_TYPE_STRING);
                cell_ptr.setCellValue("Parameter Description");
                HeaderRow = sh2.createRow(rowCount++);
                cell_ptr = HeaderRow.createCell(col++, XSSFCell.CELL_TYPE_STRING);
                cell_ptr.setCellValue(this.getTitle());


                //Preparing 1st sheet for data 
                rowCount = 0;
                col = 0;
                HeaderRow = sh.createRow(rowCount++);
                cell_ptr = HeaderRow.createCell(col++, XSSFCell.CELL_TYPE_STRING);
                cell_ptr.setCellValue("Ref No");
                cell_ptr = HeaderRow.createCell(col++, XSSFCell.CELL_TYPE_STRING);
                cell_ptr.setCellValue("Fabric Del");
                cell_ptr = HeaderRow.createCell(col++, XSSFCell.CELL_TYPE_STRING);
                cell_ptr.setCellValue("Company");
                cell_ptr = HeaderRow.createCell(col++, XSSFCell.CELL_TYPE_STRING);
                cell_ptr.setCellValue("Customer");
                cell_ptr = HeaderRow.createCell(col++, XSSFCell.CELL_TYPE_STRING);
                cell_ptr.setCellValue("Brand");
                cell_ptr = HeaderRow.createCell(col++, XSSFCell.CELL_TYPE_STRING);
                cell_ptr.setCellValue("Devision");
                cell_ptr = HeaderRow.createCell(col++, XSSFCell.CELL_TYPE_STRING);
                cell_ptr.setCellValue("Season");
                cell_ptr = HeaderRow.createCell(col++, XSSFCell.CELL_TYPE_STRING);
                cell_ptr.setCellValue("Delivery Date");
                cell_ptr = HeaderRow.createCell(col++, XSSFCell.CELL_TYPE_STRING);
                cell_ptr.setCellValue("Style");
                cell_ptr = HeaderRow.createCell(col++, XSSFCell.CELL_TYPE_STRING);
                cell_ptr.setCellValue("Unit Price");
                cell_ptr = HeaderRow.createCell(col++, XSSFCell.CELL_TYPE_STRING);
                cell_ptr.setCellValue("Qty Dzn");
                cell_ptr = HeaderRow.createCell(col++, XSSFCell.CELL_TYPE_STRING);
                cell_ptr.setCellValue("Qty Pcs");
                cell_ptr = HeaderRow.createCell(col++, XSSFCell.CELL_TYPE_STRING);
                cell_ptr.setCellValue("Total Value");
                cell_ptr = HeaderRow.createCell(col++, XSSFCell.CELL_TYPE_STRING);
                cell_ptr.setCellValue("MainFactory");
                cell_ptr = HeaderRow.createCell(col++, XSSFCell.CELL_TYPE_STRING);
                cell_ptr.setCellValue("Order Date");
                cell_ptr = HeaderRow.createCell(col++, XSSFCell.CELL_TYPE_STRING);
                cell_ptr.setCellValue("Updated By");
                cell_ptr = HeaderRow.createCell(col++, XSSFCell.CELL_TYPE_STRING);
                cell_ptr.setCellValue("Description");
                cell_ptr = HeaderRow.createCell(col++, XSSFCell.CELL_TYPE_STRING);
                cell_ptr.setCellValue("ColourType");
                cell_ptr = HeaderRow.createCell(col++, XSSFCell.CELL_TYPE_STRING);
                cell_ptr.setCellValue("GraphicType");
                cell_ptr = HeaderRow.createCell(col++, XSSFCell.CELL_TYPE_STRING);
                cell_ptr.setCellValue("Fabrication");


                XSSFCellStyle qtyStyle = wb.createCellStyle();
                XSSFCellStyle dateStyle = wb.createCellStyle();
                XSSFDataFormat format = wb.createDataFormat();
                qtyStyle.setDataFormat(format.getFormat("#,##0.00"));
                dateStyle.setDataFormat(format.getFormat("YYYY/MM/DD"));



                while (it.hasNext()) {
                    XSSFRow curRow = sh.createRow(rowCount++);
                    Object[] tmpRow = (Object[]) it.next();
                    i = 0;
                    col = 0;

                    //System.err.println("Search for records 333");
                    try {
                        //order id + month + location
                        tmpstr = (String) tmpRow[i++] + (String) tmpRow[i++] + (String) tmpRow[i++];
                        cell_ptr = curRow.createCell(col++, XSSFCell.CELL_TYPE_STRING);//Ref No
                        cell_ptr.setCellValue(tmpstr);

                        cell_ptr = curRow.createCell(col++, XSSFCell.CELL_TYPE_STRING);//fabricdeliverydate
                        cell_ptr.setCellStyle(dateStyle);
                        tmpDate = (Date) tmpRow[i++];
                        if (tmpDate != null) {
                            cell_ptr.setCellValue(tmpDate);
                        }

                        cell_ptr = curRow.createCell(col++, XSSFCell.CELL_TYPE_STRING);//Company short name
                        cell_ptr.setCellValue((String) tmpRow[i++]);

                        cell_ptr = curRow.createCell(col++, XSSFCell.CELL_TYPE_STRING);//Customer
                        cell_ptr.setCellValue((String) tmpRow[i++]);

                        cell_ptr = curRow.createCell(col++, XSSFCell.CELL_TYPE_STRING);//Brand
                        cell_ptr.setCellValue((String) tmpRow[i++]);

                        cell_ptr = curRow.createCell(col++, XSSFCell.CELL_TYPE_STRING);//Division
                        cell_ptr.setCellValue((String) tmpRow[i++]);

                        cell_ptr = curRow.createCell(col++, XSSFCell.CELL_TYPE_STRING);//Saeson
                        cell_ptr.setCellValue((String) tmpRow[i++]);

                        cell_ptr = curRow.createCell(col++, XSSFCell.CELL_TYPE_STRING);//Delivery Date
                        cell_ptr.setCellStyle(dateStyle);
                        tmpDate = (Date) tmpRow[i++];
                        if (tmpDate != null) {
                            cell_ptr.setCellValue(tmpDate);
                        }

                        cell_ptr = curRow.createCell(col++, XSSFCell.CELL_TYPE_STRING);//Style
                        cell_ptr.setCellValue((String) tmpRow[i++]);

                        cell_ptr = curRow.createCell(col++, XSSFCell.CELL_TYPE_NUMERIC);//unit price
                        d2 = (Double) tmpRow[i++];
                        cell_ptr.setCellStyle(qtyStyle);
                        cell_ptr.setCellValue(d2);

                        cell_ptr = curRow.createCell(col++, XSSFCell.CELL_TYPE_NUMERIC);//qty dzn
                        cell_ptr.setCellStyle(qtyStyle);
                        cell_ptr.setCellValue((Double) tmpRow[i++]);

                        cell_ptr = curRow.createCell(col++, XSSFCell.CELL_TYPE_NUMERIC);//qty pcs
                        d1 = (Double) tmpRow[i++];
                        cell_ptr.setCellStyle(qtyStyle);
                        cell_ptr.setCellValue(d1);




                        if (d1 != null && d2 != null) {
                            tmpDbl = d1 * d2;
                        } else {
                            tmpDbl = 0.00;
                        }
                        cell_ptr = curRow.createCell(col++, XSSFCell.CELL_TYPE_NUMERIC);//Total value
                        cell_ptr.setCellStyle(qtyStyle);
                        cell_ptr.setCellValue(tmpDbl);

                        cell_ptr = curRow.createCell(col++, XSSFCell.CELL_TYPE_STRING);//Main Factory
                        cell_ptr.setCellValue((String) tmpRow[i++]);
                        cell_ptr = curRow.createCell(col++, XSSFCell.CELL_TYPE_STRING);//Order Date
                        cell_ptr.setCellStyle(dateStyle);
                        tmpDate = (Date) tmpRow[i++];
                        if (tmpDate != null) {
                            cell_ptr.setCellValue(tmpDate);
                        }
                        cell_ptr = curRow.createCell(col++, XSSFCell.CELL_TYPE_STRING);//updated by
                        cell_ptr.setCellValue((String) tmpRow[i++]);
                        cell_ptr = curRow.createCell(col++, XSSFCell.CELL_TYPE_STRING);//description
                        cell_ptr.setCellValue((String) tmpRow[i++]);
                        cell_ptr = curRow.createCell(col++, XSSFCell.CELL_TYPE_STRING);//colourType
                        cell_ptr.setCellValue((String) tmpRow[i++]);
                        cell_ptr = curRow.createCell(col++, XSSFCell.CELL_TYPE_STRING);//graphicType
                        cell_ptr.setCellValue((String) tmpRow[i++]);
                        cell_ptr = curRow.createCell(col++, XSSFCell.CELL_TYPE_STRING);//fabrication
                        cell_ptr.setCellValue((String) tmpRow[i++]);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }

                }

                sh.autoSizeColumn(--col);
                sh.autoSizeColumn(--col);


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



            //END SHEET

            //resp.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
            resp.setContentType("application/msexcel");
            resp.setHeader("Content-Disposition", "attachment; filename=customer_sales_report.xlsx");

            ServletOutputStream httpout = resp.getOutputStream();
            wb.write(httpout);
            httpout.flush();
            //Force response complete to avoid faces reply
            this.ctx.responseComplete();

            //END DOC

        } else {
            System.err.println("No records for XLSX....!!! Search key is null");
        }
        return null;
    }
}
