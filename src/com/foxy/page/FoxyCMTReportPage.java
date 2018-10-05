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
import java.io.File;
import java.io.FileInputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.MissingResourceException;
import java.util.ResourceBundle;
import javax.faces.application.FacesMessage;
import javax.faces.model.DataModel;
import javax.faces.model.ListDataModel;
import javax.faces.model.SelectItem;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFClientAnchor;
import org.apache.poi.xssf.usermodel.XSSFColor;
import org.apache.poi.xssf.usermodel.XSSFDataFormat;
import org.apache.poi.xssf.usermodel.XSSFDrawing;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFShape;
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
public class FoxyCMTReportPage extends Page implements Serializable {

    private static String MENU_CODE = "FOXY";
    private ResourceBundle foxyParam = null;
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
        private Double ftycmt = null;
        private Double ftycmtTotalValue = null;
        private Double costcmt = null;
        private Double costcmtTotalValue = null;
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

        public Double getFtycmt() {
            return ftycmt;
        }

        public void setFtycmt(Double ftycmt) {
            this.ftycmt = ftycmt;
        }

        public Double getFtycmtTotalValue() {
            return ftycmtTotalValue;
        }

        public void setFtycmtTotalValue(Double ftycmtvalue, Double qty_pcs) {
            if (ftycmtvalue != null && qty_pcs != null) {
                this.ftycmtTotalValue = ftycmtvalue * qty_pcs;
            }
        }

        public void accumulateFtycmtTotalValue(Double val) {
            if (val != null) {
                if (this.ftycmtTotalValue == null) {
                    this.ftycmtTotalValue = val;
                } else {
                    this.ftycmtTotalValue += val;
                }
            }
        }

        public Double getCostcmt() {
            return costcmt;
        }

        public void setCostcmt(Double costcmt) {
            this.costcmt = costcmt;
        }

        public Double getCostcmtTotalValue() {
            return costcmtTotalValue;
        }

        public void setCostcmtTotalValue(Double costcmtvalue, Double qty_pcs) {
            if (costcmtvalue != null && qty_pcs != null) {
                this.costcmtTotalValue = costcmtvalue * qty_pcs;
            }
        }

        public void accumulateCostCmtTotalValue(Double val) {
            if (val != null) {
                if (this.costcmtTotalValue == null) {
                    this.costcmtTotalValue = val;
                } else {
                    this.costcmtTotalValue += val;
                }
            }
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

    public FoxyCMTReportPage() {
        super("CMTReportForm");

        Locale defaultEng = new Locale("en");
        //Always fixed to Eng, else path may have problems
        foxyParam = ResourceBundle.getBundle("Foxy", defaultEng);
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
                title = title + "For [ All Companies ] ";
            } else {
                title = title + "For [" + this.getCnameShort() + "] ";
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

        title = title + " Group By StyleCode, LotID [OrderId,OrdMonth,OrdLocation]  As At [" + fmt2.format(new Date()) + "]";


        return title;
    }

    public List getFactoryByCountryList() {
        ListData ld = (ListData) getBean("listData");
        return (ld.getFactoryListAllByCountry(this.country));
    }
//Ajax used to get list of devision of current customer code and brand code.

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
                qstr = qstr + " pm5.shortdesc as cnameshort, ord.costcm as costcmt, ord.ftycm as ftycmt ";
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

                qstr = qstr + " Order by ord.stylecode, os.orderId,  os.month, os.location ";


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
                q.addScalar("costcmt", Hibernate.DOUBLE);
                q.addScalar("ftycmt", Hibernate.DOUBLE);



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
                Double d3 = null;
                Double d4 = null;

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
                        d3 = (Double) tmpRow[i++];
                        obj.setCostcmt(d3);
                        d4 = (Double) tmpRow[i++];
                        obj.setFtycmt(d4);
                        obj.setTotalValue(d2, d1);
                        obj.setCostcmtTotalValue(d3, d1);
                        obj.setFtycmtTotalValue(d4, d1);

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
                                grandTotal.accumulateCostCmtTotalValue(subTotal.getCostcmtTotalValue());
                                grandTotal.accumulateFtycmtTotalValue(subTotal.getFtycmtTotalValue());
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
                        subTotal.setCostcmtTotalValue(d3, d1);
                        subTotal.setFtycmtTotalValue(d4, d1);
                    } else {
                        subTotal.accumulateQtyP(obj.getQtyp());
                        subTotal.accumulateQtyD(obj.getQtyd());
                        if (d1 != null) {
                            if (d2 != null) {
                                subTotal.accumulateTotalValue(d1 * d2);
                            }
                            if (d3 != null) {
                                subTotal.accumulateCostCmtTotalValue(d1 * d3);
                            }
                            if (d4 != null) {
                                subTotal.accumulateFtycmtTotalValue(d1 * d4);
                            }
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
                    grandTotal.accumulateCostCmtTotalValue(subTotal.getCostcmtTotalValue());
                    grandTotal.accumulateFtycmtTotalValue(subTotal.getFtycmtTotalValue());
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
        String filename;  //File name to keep for imtermediate file
        String filepath = this.getFoxyParam("FileUploadPath");

        //DOC
        XSSFWorkbook wb = new XSSFWorkbook();

        //SHEET
        XSSFSheet sh = wb.createSheet("CMT Ad-Hoc Report");
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

                String qstr = "Select ord.stylecode as stylecode, os.orderid as orderid, os.month as month, os.location as location, ";
                qstr = qstr + " os.fabricdeliverydate as fabricdeliverydate, pm5.shortdesc as cnameshort, ";
                qstr = qstr + " ord.custcode as custcode, ord.custbrand as custbrand, ";
                qstr = qstr + " ord.custdivision as custdiv, pm2.description as season, os.delivery as delivery, ";
                qstr = qstr + " ord.unitprice as unitprice, ord.dailycap as dailycap, ord.actualoutput as actualoutput, os.qtydzn as qtydzn, ";
                qstr = qstr + " os.qtypcs as qtypcs, ord.costcm/12 as costcmt, ord.ftycm/12 as ftycmt, ";
                qstr = qstr + " fm.factoryname as factory, ord.orderdate as orddate,  ";
                qstr = qstr + " os.updusrid as updatedby, ord.ftyremark as ftyremark, ";
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

                qstr = qstr + " Order by ord.stylecode, os.orderId,  os.month, os.location ";

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


                q.addScalar("stylecode", Hibernate.STRING);
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
                q.addScalar("unitprice", Hibernate.DOUBLE);
                q.addScalar("dailycap", Hibernate.DOUBLE);
                q.addScalar("actualoutput", Hibernate.DOUBLE);
                q.addScalar("qtydzn", Hibernate.DOUBLE);
                q.addScalar("qtypcs", Hibernate.DOUBLE);
                q.addScalar("costcmt", Hibernate.DOUBLE);
                q.addScalar("ftycmt", Hibernate.DOUBLE);
                q.addScalar("factory", Hibernate.STRING);
                q.addScalar("orddate", Hibernate.DATE);
                q.addScalar("updatedby", Hibernate.STRING);
                q.addScalar("ftyremark", Hibernate.STRING);
                q.addScalar("descf", Hibernate.STRING);
                q.addScalar("colourtype", Hibernate.STRING);
                q.addScalar("graphictype", Hibernate.STRING);
                q.addScalar("fabrication", Hibernate.STRING);


                Iterator it = q.list().iterator();
                Double d1;
                Double d2;
                Double d3;
                Double d4;



                final int DefaultRowHigh = 15;
                final int MinimumImageRow = 3;//default to 4 rows, ie: 0,1,2,3 (count=3-0 = 3 NOT 4) -Minimum Image will occupied 4 Rows of DefaultRowHigh, less than this need to set row higher
                final int COLOR_ODD = 0; //ODD line color
                final int COLOR_EVEN = 1; //Even line color
                final int COLOR_GTOT = 2; //Grant total line color
                final int STYLE_MIDDLE = 0;//Line within a group (same style code)
                final int STYLE_BOTTOM = 1;//Last line (bottom) for each group (ie: last record for a style code -To draw bottom border)
                final int STYLE_GTOT = 2; //Grant total raw (ie: To draw border line with double thin line)
                final int DATAFMT_GEN = 0;
                final int DATAFMT_DATE = 1;
                final int DATAFMT_NUM = 2;
                final int COLOR_TYPE_COUNT = 3; //alternate row colors (2types only)
                final int STYLE_TYPE_COUNT = 3; //within each group need 2  type styles, ie:no-border and with bottom border
                final int DATAFMT_TYPE_COUNT = 3; //within each group need 3 datatypes, ie:General,Date and Money

                final int COL_WITH_NO_TOTAL = 0;
                final int COL_WITH_TOTAL = 1;

                ArrayList<Integer> list_coldatatype = new ArrayList<Integer>();
                ArrayList<Integer> list_colwithtotal = new ArrayList<Integer>();

                XSSFCellStyle[][][] styleArray;//Using array 0-Middle rows no border, 1-Last row with bottom border
                styleArray = new XSSFCellStyle[COLOR_TYPE_COUNT][STYLE_TYPE_COUNT][DATAFMT_TYPE_COUNT];//[alternatecolor][middlerow or bottomrow][data types]
                XSSFDataFormat format = wb.createDataFormat();

                XSSFColor[] colorArray = new XSSFColor[COLOR_TYPE_COUNT];
                colorArray[COLOR_ODD] = new XSSFColor(new java.awt.Color(203, 226, 253));
                colorArray[COLOR_EVEN] = new XSSFColor(new java.awt.Color(239, 250, 255));
                colorArray[COLOR_GTOT] = new XSSFColor(new java.awt.Color(252, 213, 180));

                BorderStyle[] borderStyleArray = new BorderStyle[STYLE_TYPE_COUNT];
                borderStyleArray[STYLE_MIDDLE] = BorderStyle.NONE;
                borderStyleArray[STYLE_BOTTOM] = BorderStyle.THIN;
                borderStyleArray[STYLE_GTOT] = BorderStyle.DOUBLE;

                short[] datafmtArray = new short[DATAFMT_TYPE_COUNT];
                datafmtArray[DATAFMT_GEN] = format.getFormat("");
                datafmtArray[DATAFMT_DATE] = format.getFormat("YYYY/MM/DD");
                datafmtArray[DATAFMT_NUM] = format.getFormat("#,##0.00");


                //Initialise 3-D array for all excel cell format required
                for (int colortype = 0; colortype < COLOR_TYPE_COUNT; colortype++) {
                    for (int styletyp = 0; styletyp < STYLE_TYPE_COUNT; styletyp++) {
                        for (int datafmttyp = 0; datafmttyp < DATAFMT_TYPE_COUNT; datafmttyp++) {
                            styleArray[colortype][styletyp][datafmttyp] = wb.createCellStyle();
                            styleArray[colortype][styletyp][datafmttyp].setFillForegroundColor(colorArray[colortype]);
                            styleArray[colortype][styletyp][datafmttyp].setFillPattern(FillPatternType.SOLID_FOREGROUND);
                            styleArray[colortype][styletyp][datafmttyp].setBorderBottom(borderStyleArray[styletyp]);
                            styleArray[colortype][styletyp][datafmttyp].setDataFormat(datafmtArray[datafmttyp]);
                            if (colortype == COLOR_GTOT) {//Set top border also for grant total
                                styleArray[colortype][styletyp][datafmttyp].setBorderTop(borderStyleArray[styletyp]);
                            }
                        }
                    }
                }

                int styleArrayIndex;
                int colorArrayIndex;

                int rowCount = 0;
                int rowStartPrevImg; //first row always start row 1
                int rowEndPrevImg;
                int rowStartCurImg = 1;
                int imggrpcounter = 0;
                int col = 0;
                int totcol = 0;
                int i;
                boolean needToProcessLastStylcode = false;
                File f;
                String tmpstylecode, prevstylecode = null;
                String tmpordid;
                String tmpstr;
                String prevOrderID = "default";

                Date tmpDate;
                XSSFCell cell_ptr;
                XSSFRow HeaderRow;
                XSSFRow tmpXSSFRow;

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

                list_coldatatype.add(col, new Integer(DATAFMT_GEN)); //Formating format
                list_colwithtotal.add(col, new Integer(COL_WITH_NO_TOTAL));
                cell_ptr = HeaderRow.createCell(col++, XSSFCell.CELL_TYPE_STRING);
                cell_ptr.setCellValue("Sketch");

                list_coldatatype.add(col, new Integer(DATAFMT_GEN));
                list_colwithtotal.add(col, new Integer(COL_WITH_NO_TOTAL));
                cell_ptr = HeaderRow.createCell(col++, XSSFCell.CELL_TYPE_STRING);
                cell_ptr.setCellValue("Style");

                list_coldatatype.add(col, new Integer(DATAFMT_GEN));
                list_colwithtotal.add(col, new Integer(COL_WITH_NO_TOTAL));
                cell_ptr = HeaderRow.createCell(col++, XSSFCell.CELL_TYPE_STRING);
                cell_ptr.setCellValue("Ref No");

                list_coldatatype.add(col, new Integer(DATAFMT_DATE));
                list_colwithtotal.add(col, new Integer(COL_WITH_NO_TOTAL));
                cell_ptr = HeaderRow.createCell(col++, XSSFCell.CELL_TYPE_STRING);
                cell_ptr.setCellValue("Fabric Del");

                list_coldatatype.add(col, new Integer(DATAFMT_GEN));
                list_colwithtotal.add(col, new Integer(COL_WITH_NO_TOTAL));
                cell_ptr = HeaderRow.createCell(col++, XSSFCell.CELL_TYPE_STRING);
                cell_ptr.setCellValue("Company");

                list_coldatatype.add(col, new Integer(DATAFMT_GEN));
                list_colwithtotal.add(col, new Integer(COL_WITH_NO_TOTAL));
                cell_ptr = HeaderRow.createCell(col++, XSSFCell.CELL_TYPE_STRING);
                cell_ptr.setCellValue("Customer");

                list_coldatatype.add(col, new Integer(DATAFMT_GEN));
                list_colwithtotal.add(col, new Integer(COL_WITH_NO_TOTAL));
                cell_ptr = HeaderRow.createCell(col++, XSSFCell.CELL_TYPE_STRING);
                cell_ptr.setCellValue("Brand");

                list_coldatatype.add(col, new Integer(DATAFMT_GEN));
                list_colwithtotal.add(col, new Integer(COL_WITH_NO_TOTAL));
                cell_ptr = HeaderRow.createCell(col++, XSSFCell.CELL_TYPE_STRING);
                cell_ptr.setCellValue("Devision");

                list_coldatatype.add(col, new Integer(DATAFMT_GEN));
                list_colwithtotal.add(col, new Integer(COL_WITH_NO_TOTAL));
                cell_ptr = HeaderRow.createCell(col++, XSSFCell.CELL_TYPE_STRING);
                cell_ptr.setCellValue("Season");

                list_coldatatype.add(col, new Integer(DATAFMT_DATE));
                list_colwithtotal.add(col, new Integer(COL_WITH_NO_TOTAL));
                cell_ptr = HeaderRow.createCell(col++, XSSFCell.CELL_TYPE_STRING);
                cell_ptr.setCellValue("Delivery Date");

                list_coldatatype.add(col, new Integer(DATAFMT_NUM));
                list_colwithtotal.add(col, new Integer(COL_WITH_NO_TOTAL));
                cell_ptr = HeaderRow.createCell(col++, XSSFCell.CELL_TYPE_STRING);
                cell_ptr.setCellValue("Unit Price");

                list_coldatatype.add(col, new Integer(DATAFMT_NUM));
                list_colwithtotal.add(col, new Integer(COL_WITH_NO_TOTAL));
                cell_ptr = HeaderRow.createCell(col++, XSSFCell.CELL_TYPE_STRING);
                cell_ptr.setCellValue("DailyCap/worker");

                list_coldatatype.add(col, new Integer(DATAFMT_NUM));
                list_colwithtotal.add(col, new Integer(COL_WITH_NO_TOTAL));
                cell_ptr = HeaderRow.createCell(col++, XSSFCell.CELL_TYPE_STRING);
                cell_ptr.setCellValue("ActualOutput(/dz)");

                list_coldatatype.add(col, new Integer(DATAFMT_NUM));
                list_colwithtotal.add(col, new Integer(COL_WITH_TOTAL));
                cell_ptr = HeaderRow.createCell(col++, XSSFCell.CELL_TYPE_STRING);
                cell_ptr.setCellValue("Qty Dzn");

                list_coldatatype.add(col, new Integer(DATAFMT_NUM));
                list_colwithtotal.add(col, new Integer(COL_WITH_TOTAL));
                cell_ptr = HeaderRow.createCell(col++, XSSFCell.CELL_TYPE_STRING);
                cell_ptr.setCellValue("Qty Pcs");

                list_coldatatype.add(col, new Integer(DATAFMT_NUM));
                list_colwithtotal.add(col, new Integer(COL_WITH_NO_TOTAL));
                cell_ptr = HeaderRow.createCell(col++, XSSFCell.CELL_TYPE_STRING);
                cell_ptr.setCellValue("CostCMT");

                list_coldatatype.add(col, new Integer(DATAFMT_NUM));
                list_colwithtotal.add(col, new Integer(COL_WITH_TOTAL));
                cell_ptr = HeaderRow.createCell(col++, XSSFCell.CELL_TYPE_STRING);
                cell_ptr.setCellValue("CostCMT_Total");

                list_coldatatype.add(col, new Integer(DATAFMT_NUM));
                list_colwithtotal.add(col, new Integer(COL_WITH_NO_TOTAL));
                cell_ptr = HeaderRow.createCell(col++, XSSFCell.CELL_TYPE_STRING);
                cell_ptr.setCellValue("FtyCMT");

                list_coldatatype.add(col, new Integer(DATAFMT_NUM));
                list_colwithtotal.add(col, new Integer(COL_WITH_TOTAL));
                cell_ptr = HeaderRow.createCell(col++, XSSFCell.CELL_TYPE_STRING);
                cell_ptr.setCellValue("FtyCMT_Total");

                list_coldatatype.add(col, new Integer(DATAFMT_NUM));
                list_colwithtotal.add(col, new Integer(COL_WITH_TOTAL));
                cell_ptr = HeaderRow.createCell(col++, XSSFCell.CELL_TYPE_STRING);
                cell_ptr.setCellValue("Total Value");

                list_coldatatype.add(col, new Integer(DATAFMT_GEN));
                list_colwithtotal.add(col, new Integer(COL_WITH_NO_TOTAL));
                cell_ptr = HeaderRow.createCell(col++, XSSFCell.CELL_TYPE_STRING);
                cell_ptr.setCellValue("MainFactory");

                list_coldatatype.add(col, new Integer(DATAFMT_DATE));
                list_colwithtotal.add(col, new Integer(COL_WITH_NO_TOTAL));
                cell_ptr = HeaderRow.createCell(col++, XSSFCell.CELL_TYPE_STRING);
                cell_ptr.setCellValue("Order Date");

                list_coldatatype.add(col, new Integer(DATAFMT_GEN));
                list_colwithtotal.add(col, new Integer(COL_WITH_NO_TOTAL));
                cell_ptr = HeaderRow.createCell(col++, XSSFCell.CELL_TYPE_STRING);
                cell_ptr.setCellValue("Updated By");

                list_coldatatype.add(col, new Integer(DATAFMT_GEN));
                list_colwithtotal.add(col, new Integer(COL_WITH_NO_TOTAL));
                cell_ptr = HeaderRow.createCell(col++, XSSFCell.CELL_TYPE_STRING);
                cell_ptr.setCellValue("fty Remark");

                list_coldatatype.add(col, new Integer(DATAFMT_GEN));
                list_colwithtotal.add(col, new Integer(COL_WITH_NO_TOTAL));
                cell_ptr = HeaderRow.createCell(col++, XSSFCell.CELL_TYPE_STRING);
                cell_ptr.setCellValue("Description");

                list_coldatatype.add(col, new Integer(DATAFMT_GEN));
                list_colwithtotal.add(col, new Integer(COL_WITH_NO_TOTAL));
                cell_ptr = HeaderRow.createCell(col++, XSSFCell.CELL_TYPE_STRING);
                cell_ptr.setCellValue("ColourType");

                list_coldatatype.add(col, new Integer(DATAFMT_GEN));
                list_colwithtotal.add(col, new Integer(COL_WITH_NO_TOTAL));
                cell_ptr = HeaderRow.createCell(col++, XSSFCell.CELL_TYPE_STRING);
                cell_ptr.setCellValue("GraphicType");

                list_coldatatype.add(col, new Integer(DATAFMT_GEN));
                list_colwithtotal.add(col, new Integer(COL_WITH_NO_TOTAL));
                cell_ptr = HeaderRow.createCell(col++, XSSFCell.CELL_TYPE_STRING);
                cell_ptr.setCellValue("Fabrication");


                totcol = col - 1; //col++ so need to -1
                XSSFRow prevImgRow;
                //rowCount = 1 here, 0 = heaeder row
                while (it.hasNext()) {
                    XSSFRow curRow = sh.createRow(rowCount++);
                    Object[] tmpRow = (Object[]) it.next();
                    i = 0;
                    col = 0;

                    //System.err.println("Search for records 333");
                    try {
                        //NOTE: Adding or Removing new column MUST update formula column ALSO!!!!
                        //Search for  "Formula column"
                        //order id + month + location

                        cell_ptr = curRow.createCell(col++);//Sketch cell (place holder to avoid null issue)
                        cell_ptr = curRow.createCell(col++);//Style code
                        tmpstylecode = (String) tmpRow[i++];
                        tmpordid = (String) tmpRow[i++];
                        cell_ptr.setCellValue(tmpstylecode);

                        tmpstr = (String) tmpordid + (String) tmpRow[i++] + (String) tmpRow[i++];
                        cell_ptr = curRow.createCell(col++);//Ref No
                        cell_ptr.setCellValue(tmpstr);

                        cell_ptr = curRow.createCell(col++);//fabricdeliverydate
                        tmpDate = (Date) tmpRow[i++];
                        if (tmpDate != null) {
                            cell_ptr.setCellValue(tmpDate);
                        }

                        cell_ptr = curRow.createCell(col++);//Company short name
                        cell_ptr.setCellValue((String) tmpRow[i++]);

                        cell_ptr = curRow.createCell(col++);//Customer
                        cell_ptr.setCellValue((String) tmpRow[i++]);

                        cell_ptr = curRow.createCell(col++);//Brand
                        cell_ptr.setCellValue((String) tmpRow[i++]);

                        cell_ptr = curRow.createCell(col++);//Division
                        cell_ptr.setCellValue((String) tmpRow[i++]);

                        cell_ptr = curRow.createCell(col++);//Saeson
                        cell_ptr.setCellValue((String) tmpRow[i++]);

                        cell_ptr = curRow.createCell(col++);//Delivery Date
                        tmpDate = (Date) tmpRow[i++];
                        if (tmpDate != null) {
                            cell_ptr.setCellValue(tmpDate);
                        }

                        cell_ptr = curRow.createCell(col++);//unit price
                        d1 = (Double) tmpRow[i++];
                        if (d1 != null) {
                            cell_ptr.setCellValue(d1);
                        }

                        cell_ptr = curRow.createCell(col++);//DailyCap
                        d1 = (Double) tmpRow[i++];
                        if (d1 != null) {
                            cell_ptr.setCellValue(d1);
                        }

                        cell_ptr = curRow.createCell(col++);//Actual Output
                        d1 = (Double) tmpRow[i++];
                        if (d1 != null) {
                            cell_ptr.setCellValue(d1);
                        }

                        cell_ptr = curRow.createCell(col++);//qty dzn
                        cell_ptr.setCellValue((Double) tmpRow[i++]);

                        cell_ptr = curRow.createCell(col++);//qty pcs
                        d2 = (Double) tmpRow[i++];
                        if (d2 != null) {
                            cell_ptr.setCellValue(d2);
                        }

                        cell_ptr = curRow.createCell(col++);//costCMT
                        d3 = (Double) tmpRow[i++];
                        if (d3 != null) {
                            cell_ptr.setCellValue(d3);
                        }

                        cell_ptr = curRow.createCell(col++);//costCMT_Total
                        cell_ptr.setCellFormula("O" + rowCount + "*P" + rowCount);//Formula column

                        cell_ptr = curRow.createCell(col++);//ftyCMT
                        d4 = (Double) tmpRow[i++];
                        if (d4 != null) {
                            cell_ptr.setCellValue(d4);
                        }

                        cell_ptr = curRow.createCell(col++);//ftyCMT_Total
                        cell_ptr.setCellFormula("O" + rowCount + "*R" + rowCount);//Formula column

                        cell_ptr = curRow.createCell(col++);//Total value
                        cell_ptr.setCellFormula("K" + rowCount + "*O" + rowCount);//Formula column

                        cell_ptr = curRow.createCell(col++);//Main factory
                        cell_ptr.setCellValue((String) tmpRow[i++]);
                        cell_ptr = curRow.createCell(col++);//Order Date
                        tmpDate = (Date) tmpRow[i++];
                        if (tmpDate != null) {
                            cell_ptr.setCellValue(tmpDate);
                        }
                        cell_ptr = curRow.createCell(col++);//updated by
                        cell_ptr.setCellValue((String) tmpRow[i++]);
                        cell_ptr = curRow.createCell(col++);//ftyremark
                        cell_ptr.setCellValue((String) tmpRow[i++]);
                        cell_ptr = curRow.createCell(col++);//description
                        cell_ptr.setCellValue((String) tmpRow[i++]);
                        cell_ptr = curRow.createCell(col++);//colourType
                        cell_ptr.setCellValue((String) tmpRow[i++]);
                        cell_ptr = curRow.createCell(col++);//graphicType
                        cell_ptr.setCellValue((String) tmpRow[i++]);
                        cell_ptr = curRow.createCell(col++);//fabrication
                        cell_ptr.setCellValue((String) tmpRow[i++]);

                        //Base on stycode decide what to do with col=0, sketch img (always rollback to prev order id to put in image
                        //this way we know how many row it occupied and we can adjust row high accordingly
                        //rowCount now is pointing to nexRow, so must use rowCount > 2, not 1, except for last row when same style code (inclusive last row)
                        if ((!tmpstylecode.equals(prevstylecode) && rowCount > 2) || !it.hasNext()) { //ignore first row no such thing prev row for firs row, Always proceed for last row.
                            imggrpcounter++;
                            rowEndPrevImg = rowCount - 2;
                            rowStartPrevImg = rowStartCurImg;
                            rowStartCurImg = rowCount - 1;

                            if (!it.hasNext()) {//Special handling for last record
                                if (tmpstylecode.equals(prevstylecode)) {//If belong to previous row stylecode (no changes), included it
                                    rowEndPrevImg++;//to count in last row if stylecode is the samen(inclusive last row)
                                    needToProcessLastStylcode = false;
                                } else {//If stylecode changes, meaning last record is new stylecode with single record only!!
                                    //set indicator to process this last row outside this loop independently (short of 1 loop)
                                    needToProcessLastStylcode = true;
                                }
                            }

                            int rowused;
                            int rowhigh = DefaultRowHigh; //default  row high (img fix into 4 rows, less than 4 need to increase row high
                            int rowImgUsed = MinimumImageRow;//default to 4 rows, ie: 0,1,2,3 (count=3-0 = 3 NOT 4)     
                            int dy1 = XSSFShape.EMU_PER_PIXEL * 3;//Offset 2-pixel from top one point
                            int dy2;

                            rowused = rowEndPrevImg - rowStartPrevImg;
                            //check if prev stylecode having minmum 4 rows (1,2,3,4 but 4-1 = 3 due to inclusive)
                            if (rowused < (rowImgUsed)) {//more than 4 row use default
                                rowhigh = (rowhigh * (rowImgUsed + 1)) / (rowused + 1);
                                rowImgUsed = rowused;
                            }

                            dy2 = (XSSFShape.EMU_PER_POINT * rowhigh) - dy1;

                            for (; rowused >= 0; rowused--) {
                                tmpXSSFRow = sh.getRow(rowEndPrevImg - rowused);
                                tmpXSSFRow.setHeightInPoints(rowhigh);
                            }

                            //Alternate background fill color to ease reading                            
                            int colindx;

                            if ((imggrpcounter % 2) == 0) {
                                colorArrayIndex = COLOR_EVEN;
                            } else {
                                colorArrayIndex = COLOR_ODD;
                            }
                            rowused = rowStartPrevImg;
                            while (rowused <= rowEndPrevImg) {
                                if (rowused != rowEndPrevImg) {
                                    styleArrayIndex = STYLE_MIDDLE;
                                } else {
                                    styleArrayIndex = STYLE_BOTTOM;
                                }

                                tmpXSSFRow = sh.getRow(rowused++);

                                for (colindx = totcol; colindx >= 0; colindx--) {
                                    tmpXSSFRow.getCell(colindx).setCellStyle(styleArray[colorArrayIndex][styleArrayIndex][list_coldatatype.get(colindx)]);
                                }
                            }


                            filename = filepath + File.separatorChar + prevOrderID + ".jpg";
                            f = new File(filename);
                            if (f.exists() == false) {
                                filename = filepath + File.separatorChar + "default.jpg";
                                f = new File(filename);
                            }

                            XSSFDrawing drawImg = sh.createDrawingPatriarch();
                            XSSFClientAnchor cltAnchor = new XSSFClientAnchor(0, dy1, 0, dy2, 0, rowStartPrevImg, 1, rowStartPrevImg + rowImgUsed);
                            cltAnchor.setAnchorType(2);
                            byte[] picData = null;
                            long length = f.length();
                            picData = new byte[(int) length];
                            FileInputStream picIn = new FileInputStream(f);
                            picIn.read(picData);
                            int index;
                            index = wb.addPicture(picData, XSSFWorkbook.PICTURE_TYPE_JPEG);
                            drawImg.createPicture(cltAnchor, index);
                        }

                        //keep a copy for next loop
                        prevstylecode = tmpstylecode;
                        prevOrderID = tmpordid;

                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }

                int rowused;
                int colindx;

                if (needToProcessLastStylcode) { //last record not yet format and image not created yet (style code differ from second last row)
                    imggrpcounter++;
                    rowEndPrevImg = rowCount - 1; //Must include current row, (Always inclusive current last row)
                    rowStartPrevImg = rowStartCurImg;
                   
                    int rowhigh = DefaultRowHigh; //default  row high (img fix into 4 rows, less than 4 need to increase row high
                    int rowImgUsed = MinimumImageRow;//default to 4 rows, ie: 0,1,2,3 (count=3-0 = 3 NOT 4)     
                    int dy1 = XSSFShape.EMU_PER_PIXEL * 3;//Offset 2-pixel from top one point
                    int dy2;

                    rowused = rowEndPrevImg - rowStartPrevImg;
                    //check if prev stylecode having minmum 4 rows (1,2,3,4 but 4-1 = 3 due to inclusive)
                    if (rowused < (rowImgUsed)) {//more than 4 row use default
                        rowhigh = (rowhigh * (rowImgUsed + 1)) / (rowused + 1);
                        rowImgUsed = rowused;
                    }

                    dy2 = (XSSFShape.EMU_PER_POINT * rowhigh) - dy1;

                    for (; rowused >= 0; rowused--) {
                        tmpXSSFRow = sh.getRow(rowEndPrevImg - rowused);
                        tmpXSSFRow.setHeightInPoints(rowhigh);
                    }

                    //Alternate background fill color to ease reading                                                

                    if ((imggrpcounter % 2) == 0) {
                        colorArrayIndex = COLOR_EVEN;
                    } else {
                        colorArrayIndex = COLOR_ODD;
                    }
                    rowused = rowStartPrevImg;
                    while (rowused <= rowEndPrevImg) {
                        if (rowused != rowEndPrevImg) {
                            styleArrayIndex = STYLE_MIDDLE;
                        } else {
                            styleArrayIndex = STYLE_BOTTOM;
                        }

                        tmpXSSFRow = sh.getRow(rowused++);

                        for (colindx = totcol; colindx >= 0; colindx--) {
                            tmpXSSFRow.getCell(colindx).setCellStyle(styleArray[colorArrayIndex][styleArrayIndex][list_coldatatype.get(colindx)]);
                        }
                    }


                    filename = filepath + File.separatorChar + prevOrderID + ".jpg";
                    f = new File(filename);
                    if (f.exists() == false) {
                        filename = filepath + File.separatorChar + "default.jpg";
                        f = new File(filename);
                    }

                    XSSFDrawing drawImg = sh.createDrawingPatriarch();
                    XSSFClientAnchor cltAnchor = new XSSFClientAnchor(0, dy1, 0, dy2, 0, rowStartPrevImg, 1, rowStartPrevImg + rowImgUsed);
                    cltAnchor.setAnchorType(2);
                    byte[] picData = null;
                    long length = f.length();
                    picData = new byte[(int) length];
                    FileInputStream picIn = new FileInputStream(f);
                    picIn.read(picData);
                    int index;
                    index = wb.addPicture(picData, XSSFWorkbook.PICTURE_TYPE_JPEG);
                    drawImg.createPicture(cltAnchor, index);
                }



                //Create Grant Total row
                XSSFRow curRow = sh.createRow(rowCount++);
                String cellRefIndex;
                curRow.setHeightInPoints(DefaultRowHigh + 4);//Make it 2-points higher than default
                for (colindx = 0; colindx <= totcol; colindx++) {
                    cell_ptr = curRow.createCell(colindx);

                    if (colindx == 1) {//Grant total words
                        cell_ptr.setCellValue("Grant Total:");
                    }

                    if (list_colwithtotal.get(colindx) == COL_WITH_TOTAL) {
                        cellRefIndex = cell_ptr.getReference();
                        cellRefIndex = cellRefIndex.substring(0, 1);//Only support up to column A-Z, more than this will fail!!!
                        cell_ptr.setCellFormula("SUM(" + cellRefIndex + "2:" + cellRefIndex + (rowCount - 1) + ")");
                    }

                    cell_ptr.setCellStyle(styleArray[COLOR_GTOT][STYLE_GTOT][list_coldatatype.get(colindx)]);
                }

                while (col > 0) { //don't resize first column (img)
                    sh.autoSizeColumn(col--);
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

            //END SHEET
            //resp.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
            resp.setContentType(
                    "application/msexcel");
            resp.setHeader(
                    "Content-Disposition", "attachment; filename=cmt_ad_hoc_report.xlsx");

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

    private String getFoxyParam(String key) {
        String val = null;
        try {
            val = foxyParam.getString(key);
        } catch (MissingResourceException e) {
            //e.printStackTrace();
            System.err.println("Parameter key [" + key + "] not found");
        } finally {
        }
        return val;
    }
}
