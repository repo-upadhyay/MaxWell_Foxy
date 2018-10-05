/*
 * ListData.java
 *
 * Created on July 4, 2006, 5:10 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */
package com.foxy.util;

import com.foxy.db.Category;
import com.foxy.db.Customer;
import com.foxy.db.HibernateUtil;
import com.foxy.db.Parameter;
import com.foxy.db.User;
import com.foxy.db.FactoryMast;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.faces.model.SelectItem;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.Query;
import org.hibernate.Transaction;
import org.hibernate.criterion.Expression;
import org.hibernate.criterion.Order;

/**
 *
 * @author eric
 */
public class ListData {

    private Date dNow = null;
    private int saveCurrentYear = 0;
    private SimpleDateFormat fmt = new SimpleDateFormat("yyyy");
    private List orderIdYear = null;
    private List shipStat = null;
    private List paramCatList = null;
    private List customer = null;
    private List merchandiser = null;
    private List category = null;
    private List parameterList = null;
    private List country = null;
    private List countryView = null;
    private List factoryList = null;
    private List factoryListAll = null;
    private List season = null;
    private List destination = null;
    private List shipType = null;
    private List lot = null;
    private List statList = null;
    private List userGroupList = null;
    private List unitList = null;
    private List iunitList = null;
    private List taxList = null;
    private List ordMethod = null;
    private List priceTerm = null;
    private List itemList = null;
    private List itemListWithAll = null;
    private List forexList = null;
    private List custFederatedList = null;
    private List companyName = null;
    private List companyNameAll = null;
    private List colouringType = null;
    private List graphicType = null;

    /**
     * Creates a new instance of ListData
     */
    public ListData() {
        //Add in all parameter's category code used in parameters tables (can change to select from database!!)
        if (paramCatList == null) {
            paramCatList = new ArrayList();
            paramCatList.add(new SelectItem("", "  "));
            paramCatList.add(new SelectItem("CNTY", "Countries of Origin"));
            paramCatList.add(new SelectItem("DEST", "Destination Country"));
            paramCatList.add(new SelectItem("ITAX", "Importer Tax Type"));
            paramCatList.add(new SelectItem("ORDMD", "Order Method"));
            paramCatList.add(new SelectItem("LOT", "Preconfigured Lot list"));
            paramCatList.add(new SelectItem("PTERM", "Price Term"));
            paramCatList.add(new SelectItem("SEA", "Seasons"));
            paramCatList.add(new SelectItem("SHIP", "Shipment type"));
            paramCatList.add(new SelectItem("UNIT", "Unit for quantity"));
            paramCatList.add(new SelectItem("UGRP", "User groups code"));
            paramCatList.add(new SelectItem("CNAME", "Company Name"));
            paramCatList.add(new SelectItem("COLOR", "Colour Type"));
            paramCatList.add(new SelectItem("GRAPH", "Graphics Embellishment"));
        }
    }

    public void resetParamList(String pcode) {
        boolean bFound = false;
        if (pcode.equals("CNTY")) {
            this.country = null;
            bFound = true;
        }
        if (pcode.equals("CNTY")) {
            this.countryView = null;
            bFound = true;
        }
        if (pcode.equals("SEA")) {
            this.season = null;
            bFound = true;
        }
        if (pcode.equals("DEST")) {
            this.destination = null;
            bFound = true;
        }
        if (pcode.equals("SHIP")) {
            this.shipType = null;
            bFound = true;
        }
        if (pcode.equals("LOT")) {
            this.lot = null;
            bFound = true;
        }
        if (pcode.equals("UGRP")) {
            this.userGroupList = null;
            bFound = true;
        }
        if (pcode.equals("UNIT")) {
            this.unitList = null;
            bFound = true;
        }
        if (pcode.equals("ITAX")) {
            this.taxList = null;
            bFound = true;
        }
        if (pcode.equals("ORDMD")) {
            this.ordMethod = null;
            bFound = true;
        }
        if (pcode.equals("PTERM")) {
            this.priceTerm = null;
            bFound = true;
        }
        if (pcode.equals("CNAME")) {
            this.companyName = null;
            bFound = true;
        }
        if (pcode.equals("COLOR")) {
            this.colouringType = null;
            bFound = true;
        }
        if (pcode.equals("GRAPH")) {
            this.graphicType = null;
            bFound = true;
        }


        if (bFound == false) {
            System.err.println("Calling to reset an unknown type of parameter [" + pcode + "]");
        }
    }

    //List of options listing for customer federated option field filters
    public List getCustFederatedList() {
        if (custFederatedList == null) {
            custFederatedList = new ArrayList();
            custFederatedList.add(new SelectItem("", "All"));
            custFederatedList.add(new SelectItem("1", "Federated"));
            custFederatedList.add(new SelectItem("0", "Non-Federated"));
        }
        return custFederatedList;
    }

    //For parameter maintanance screen combo box (list constructed by this class constructor)
    public List getParamCatList() {
        return paramCatList;
    }

    /**
     * *** Start section for all method returning a list of items ***
     */
    // CategoryList method
    //Used by category admin screen to force reload list
    public void resetCategory() {
        //System.err.println("Calling to reset category");
        this.category = null;
    }

    public List getCategoryList() {
        List paramList = new ArrayList();
        parameterList = null;
        if (this.category == null) {
            try {
                Session session = (Session) HibernateUtil.currentSession();
                this.category = session.createQuery("from Category order by country, category").list();
            } catch (Exception e) {
                //HibernateUtil.closeSession();
                e.printStackTrace();
            } finally {
                HibernateUtil.closeSession();
            }
        }
        for (int i = 0; i < this.category.size(); i++) {
            if (i == 0) {
                paramList.add(new SelectItem("", "  "));
            }
            Category cat = (Category) this.category.get(i);
            paramList.add(new SelectItem(cat.getCatId().toString(), cat.getCategory() + " - " + cat.getDesc()));
        }
        return paramList;
    }

    // Order Year
    public List getOrderIdYear() {
        dNow = new Date();
        int curYear = Integer.parseInt(fmt.format(dNow));

        //Bug fix to cater year list get update once cross year
        if (curYear != saveCurrentYear) { //Not same if cross year
            saveCurrentYear = curYear; //set it to be same, saveCurrentYear default to 0
            this.orderIdYear = null;//Set to null to force rebuild the list
        }

        if (this.orderIdYear == null) {
            this.orderIdYear = new ArrayList();
            int nextYear = curYear + 1;
            this.orderIdYear.add(new SelectItem("", ""));
            this.orderIdYear.add(new SelectItem(String.valueOf(curYear), String.valueOf(curYear)));
            this.orderIdYear.add(new SelectItem(String.valueOf(nextYear), String.valueOf(nextYear)));
        }
        return (this.orderIdYear);
    }

    // Ship Status
    public List getShipStatus() {
        if (this.shipStat == null) {
            this.shipStat = new ArrayList();
            this.shipStat.add(new SelectItem("Yes", "Yes"));
            this.shipStat.add(new SelectItem("No", "No"));
        }
        return (this.shipStat);
    }

    //Used by customer admin screen to force reload list
    public void resetCustomer() {
        //System.err.println("Calling to reset customer");
        this.customer = null;
    }

    /**
     * Returns a List with SelectItem instances for the Customer
     */
    public List getCustomerList() {
        List paramList = new ArrayList();
        parameterList = null;

        if (this.customer == null) {
            try {
                Session session = (Session) HibernateUtil.currentSession();
                this.customer = session.createQuery("from Customer order by custname").list();
            } catch (Exception e) {
                //HibernateUtil.closeSession();
                e.printStackTrace();
            } finally {
                HibernateUtil.closeSession();
            }
        }
        for (int i = 0; i < this.customer.size(); i++) {
            if (i == 0) {
                paramList.add(new SelectItem("", "  "));
            }
            Customer param = (Customer) customer.get(i);
            paramList.add(new SelectItem(param.getCustCode(), param.getCustName()));
        }
        return paramList;
    }

    //Used by user admin screen to force reload list
    public void resetMerchandiser() {
        //System.err.println("Calling to reset MR");
        this.merchandiser = null;
    }

    /**
     * Returns a List with SelectItem instances for the Merchandiser
     */
    public List getMerchandiserList() {
        List paramList = new ArrayList();
        parameterList = null;
        if (this.merchandiser == null) {
            try {
                Session session = (Session) HibernateUtil.currentSession();
                this.merchandiser = session.createQuery("from User as user where "
                        + "user.userGroup ='MC' order by fullname").list();
            } catch (Exception e) {
                //HibernateUtil.closeSession();
                e.printStackTrace();
            } finally {
                HibernateUtil.closeSession();
            }
        }
        for (int i = 0; i < this.merchandiser.size(); i++) {
            if (i == 0) {
                paramList.add(new SelectItem("", "  "));
            }
            User usr = (User) this.merchandiser.get(i);
            paramList.add(new SelectItem(usr.getUserId(), usr.getFullName()));
        }
        return paramList;
    }

    // StatList
    public List getStatList() {
        if (this.statList == null) {
            this.statList = this.getParameterExList("STAT", "code");
        }
        return (this.statList);
    }

    // UserGroupList
    public List getUserGroupList() {
        if (this.userGroupList == null) {
            this.userGroupList = this.getParameterExList("UGRP", "code");
        }
        return (this.userGroupList);
    }

    // SeasonList
    public List getSeasonList() {
        if (this.season == null) {
            this.season = this.getParameterList("SEA", "description");
        }
        return (this.season);
    }

    // CountryList
    public List getCountryList() {
        if (this.country == null) {
            this.country = this.getParameterExList("CNTY", "sequence");
        }
        return (this.country);
    }

    // CountryViewList
    public List getCountryViewList() {
        if (this.countryView == null) {
            this.countryView = this.getParameterExList("CNTY", "sequence", true);
        }
        return (this.countryView);
    }

    // Factory List
    public void resetFactoryList() {
        this.factoryList = null;
        this.factoryListAll = null;
    }

    public List getFactoryList() {
        if (this.factoryList == null) {
            this.factoryList = this.getFactoryItemListing("ALL", false);
        }
        return (this.factoryList);
    }

    public List getFactoryListAll() {
        if (this.factoryListAll == null) {
            this.factoryListAll = this.getFactoryItemListing("ALL", true);
        }
        return (this.factoryListAll);
    }

    public List getFactoryListAllByCountry(String countryCode) {
        return this.getFactoryItemListing(countryCode, true);
    }

    public String getFactoryNameLong(String mainFactoryCode) {
        return this.getFactoryName(mainFactoryCode, "LONG");
    }

    public String getFactoryNameShort(String mainFactoryCode) {
        return this.getFactoryName(mainFactoryCode, "SHORT");
    }

    private String getFactoryName(String mainFactoryCode, String shortorlong) {
        String tmpfactoryName = "UNKNOWN";

        try {
            Session session = (Session) HibernateUtil.currentSession();
            Query qry = session.createQuery("from FactoryMast as fmast where fmast.factoryCode = '" + mainFactoryCode + "'");
            this.parameterList = qry.list();
            if (!this.parameterList.isEmpty()) {
                FactoryMast fmast = (FactoryMast) this.parameterList.get(0);
                if (shortorlong.equals("LONG")) {
                    tmpfactoryName = fmast.getFactoryNameLong();
                } else {//SHORT
                    tmpfactoryName = fmast.getFactoryName();
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            //HibernateUtil.closeSession();
        } finally {
            //DO NOT CLOSE CURRENT SESSION HibernateUtil.closeSession();
        }

        return tmpfactoryName;
    }

    private List getFactoryItemListing(String countrycode, boolean withAllSelected) {
        List newList = new ArrayList();
        int resultsize;
        try {
            Session session = (Session) HibernateUtil.currentSession();
            Transaction tx = session.beginTransaction();
            Criteria crit = session.createCriteria(FactoryMast.class);
            if (!"ALL".equals(countrycode)) {
                crit.add(Expression.eq("countryCode", countrycode));
            }
            crit.addOrder(Order.asc("seqNo"));

            this.parameterList = crit.list();
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
            //HibernateUtil.closeSession();
        } finally {
            //HibernateUtil.closeSession();
        }

        resultsize = parameterList.size();
        if (resultsize > 0) {
            if (withAllSelected) {
                if (resultsize > 1) { //If == 1, no need ALLSELECTED option
                    newList.add(new SelectItem("ALLSELECTED", "---ALL---"));
                }
            } else {
                newList.add(new SelectItem("", " "));
            }
        } else {
            newList.add(new SelectItem("EMPTY", "--EMPTY--"));
        }
        for (int i = 0; i < this.parameterList.size(); i++) {
            FactoryMast fmast = (FactoryMast) this.parameterList.get(i);
            newList.add(new SelectItem(fmast.getFactoryCode(), fmast.getFactoryCode() + " - " + this.getCountryDesc(fmast.getCountryCode(), 1) + " - " + fmast.getFactoryName()));
        }
        return newList;
    }

    // CompanyList
    public List getCompanyNameList() {
        if (this.companyName == null) {
            this.companyName = this.getParameterList("CNAME", "sequence");
        }
        return (this.companyName);
    }

    public List getCompanyNameListAll() {
        if (this.companyNameAll == null) {
            this.companyNameAll = this.getParameterExList("CNAME", "sequence", true);
        }
        return (this.companyNameAll);
    }

    // Graphic Type List
    public List getGraphicTypeList() {
        if (this.graphicType == null) {
            this.graphicType = this.getParameterList("GRAPH", "code");
        }
        return (this.graphicType);
    }

    //Getting Graphic Type Name based on Graphic Type Code
    public String getGraphicTypeDesc(String code) {
        if (code != null) {
            return (this.getParameterDesc("GRAPH", code, "desc", 1));
        }
        return null;
    }

    // Colour Type List
    public List getColourTypeList() {
        if (this.colouringType == null) {
            this.colouringType = this.getParameterList("COLOR", "code");
        }
        return (this.colouringType);
    }
    //Getting Colour type Name based on colour type code

    public String getColourTypeDesc(String code) {
        if (code != null) {
            return (this.getParameterDesc("COLOR", code, "desc", 1));
        }
        return null;
    }

    // DestinationList
    public List getDestinationList() {
        if (this.destination == null) {
            this.destination = this.getParameterExList("DEST", "description");
        }
        return (this.destination);
    }

    // ShipTypeList
    public List getShipTypeList() {
        if (this.shipType == null) {
            this.shipType = this.getParameterList("SHIP", "description");
        }
        return (this.shipType);
    }

    // LotList
    public List getLotList() {
        if (this.lot == null) {
            this.lot = this.getParameterList("LOT", "code");
        }
        return (this.lot);
    }

    // UnitList
    public List getUnitList() {
        if (this.unitList == null) {
            this.unitList = this.getParameterExList("UNIT", "sequence");
        }
        return (this.unitList);
    }

    // UnitList for Inventory
    public List getInvUnitList() {
        if (this.iunitList == null) {
            this.iunitList = this.getParameterExList("IUNIT", "sequence");
        }
        return (this.iunitList);
    }

    // Tax List
    public List getTaxList() {
        if (this.taxList == null) {
            this.taxList = this.getParameterExList("ITAX", "sequence");
        }
        return (this.taxList);
    }

    // Order Method List
    public List getOrdMethodList() {
        if (this.ordMethod == null) {
            this.ordMethod = this.getParameterExList("ORDMD", "sequence");
        }
        return (this.ordMethod);
    }

    // Order Method List
    public List getPriceTermList() {
        if (this.priceTerm == null) {
            this.priceTerm = this.getParameterExList("PTERM", "sequence");
        }
        return (this.priceTerm);
    }

    // Items Listing Method
    public List getSupItemList() {
        if (this.itemList == null) {
            this.itemList = this.getParameterExList("ITEM", "sequence");
        }
        return (this.itemList);
    }

    // Items Listing Method with ALL element
    public List getSupItemListWithAll() {
        if (this.itemListWithAll == null) {
            this.itemListWithAll = this.getParameterExList("ITEM", "sequence", true);
        }
        return (this.itemListWithAll);
    }

    // Forex Currency Code Listing Method
    public List getForexCurrencyList() {
        if (this.forexList == null) {
            this.forexList = this.getParameterExList("FOREX", "sequence");
        }
        return (this.forexList);
    }

    // ParameterList compilation common method
    private List getParameterList(String paramGroup, String orderBy) {
        List paramList = new ArrayList();

        try {
            Session session = (Session) HibernateUtil.currentSession();
            Query qry = session.createQuery("from Parameter as param where param.category = :pGroup order by " + orderBy);
            qry.setString("pGroup", paramGroup);

            this.parameterList = qry.list();
        } catch (Exception e) {
            //HibernateUtil.closeSession();
            e.printStackTrace();
        } finally {
            HibernateUtil.closeSession();
        }


        for (int i = 0; i < this.parameterList.size(); i++) {
            if (i == 0) {
                paramList.add(new SelectItem("", "  "));
            }
            Parameter param = (Parameter) this.parameterList.get(i);
            paramList.add(new SelectItem(param.getCode(), param.getDescription()));
        }
        return paramList;
    }

    private List getParameterExList(String paramGroup, String orderBy) {
        return getParameterExList(paramGroup, orderBy, false);
    }

    private List getParameterExList(String paramGroup, String orderBy, boolean withAllElement) {
        List paramList = new ArrayList();

        try {
            Session session = (Session) HibernateUtil.currentSession();
            Query qry = session.createQuery("from Parameter as param where param.category = :pGroup order by " + orderBy);
            qry.setString("pGroup", paramGroup);

            this.parameterList = qry.list();
        } catch (Exception e) {
            e.printStackTrace();
            //HibernateUtil.closeSession();
        } finally {
            HibernateUtil.closeSession();
        }

        for (int i = 0; i < this.parameterList.size(); i++) {
            if (i == 0) {
                if (withAllElement) {
                    paramList.add(new SelectItem("ALLSELECTED", "---ALL---"));
                } else {
                    paramList.add(new SelectItem("", " "));
                }
            }
            Parameter param = (Parameter) this.parameterList.get(i);
            paramList.add(new SelectItem(param.getCode(), param.getCode() + " - " + param.getDescription()));
        }
        return paramList;
    }

    /*
     * Translation
     */
    public Customer getCustomer(String code) {
        List result = new ArrayList();
        if (code != null) {
            try {
                Session session = (Session) HibernateUtil.currentSession();
                Query qry = session.createQuery("from Customer as c where c.custCode = :pcode");
                qry.setString("pcode", code);

                result = qry.list();
            } catch (Exception e) {
                e.printStackTrace();
                //HibernateUtil.closeSession();
            } finally {
                HibernateUtil.closeSession();
            }
        }

        if (result.size() > 0) {
            Customer cust = (Customer) result.get(0);
            return cust;
        } else {
            return null;
        }
    }

    public User getMerchandiser(String userId) {
        List result = new ArrayList();
        if (userId != null) {
            try {
                Session session = (Session) HibernateUtil.currentSession();
                Query qry = session.createQuery("from User as user where user.userId = :puserId");
                qry.setString("puserId", userId);

                result = qry.list();
            } catch (Exception e) {
                //HibernateUtil.closeSession();
                e.printStackTrace();
            } finally {
                HibernateUtil.closeSession();
            }
        }

        if (result.size() > 0) {
            User usr = (User) result.get(0);
            return usr;
        } else {
            return null;
        }
    }

    public String getSeasonDesc(String code) {
        if (code != null) {
            return (this.getParameterDesc("SEA", code, "desc", 0));
        }
        return null;
    }

    public String getCountryDesc(String code, int close) {
        if (code != null) {
            return (this.getParameterDesc("CNTY", code, "desc", close));
        }
        return null;
    }

    public String getDestinationDesc(String code, int close) {
        if (code != null) {
            return (getParameterDesc("DEST", code, "desc", close));
        }
        return null;
    }

    public String getDestinationShortDesc(String code, int close) {
        if (code != null) {
            return (getParameterDesc("DEST", code, "short", close));
        }
        return null;
    }

    public String getCompanyNameFull(String code, int close) {
        if (code != null) {
            return (getParameterDesc("CNAME", code, "desc", close));
        }
        return null;
    }

    public String getCompanyNameShort(String code, int close) {
        if (code != null) {
            return (getParameterDesc("CNAME", code, "short", close));
        }
        return null;
    }

    public String getParameterDesc(String category, String code, String type, int close) {
        List result = new ArrayList();
        if (code != null && category != null) {
            try {
                Session session = (Session) HibernateUtil.currentSession();
                Query qry = session.createQuery("from Parameter as p where p.category = :pcat and p.code = :pcode");
                qry.setString("pcat", category);
                qry.setString("pcode", code);

                result = qry.list();
                if (close == 0) {
                    HibernateUtil.closeSession();
                }
            } catch (Exception e) {
                e.printStackTrace();
                HibernateUtil.closeSession();
            } finally {
            }
        }

        if (result.size() > 0) {
            Parameter param = (Parameter) result.get(0);
            if (type.equals("desc")) {
                return param.getDescription();
            } else {
                return param.getShortDesc();
            }
        } else {
            return null;
        }
    }

    public Category getCategory(Long catId, int close) {
        List result = new ArrayList();
        if (catId != null) {
            try {
                Session session = (Session) HibernateUtil.currentSession();

                Query qry = session.createQuery("from Category as c where c.catId = :pcatId");
                qry.setDouble("pcatId", catId);

                result = qry.list();

                if (close == 0) {
                    HibernateUtil.closeSession();
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                //HibernateUtil.closeSession();
            }
        }
        if (result.size() > 0) {
            Category cat = (Category) result.get(0);
            return cat;
        } else {
            return null;
        }
    }
}
