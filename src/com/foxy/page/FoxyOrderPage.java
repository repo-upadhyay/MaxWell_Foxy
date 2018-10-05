/*
 * FoxyOrderPage.java
 *
 * Created on June 20, 2006, 6:18 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */
package com.foxy.page;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.faces.application.FacesMessage;
import javax.faces.context.ExternalContext;
import javax.faces.context.FacesContext;
import javax.faces.model.DataModel;
import javax.faces.model.ListDataModel;
import javax.faces.model.SelectItem;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Expression;
import org.hibernate.criterion.Order;

import com.foxy.bean.FoxySessionData;
import com.foxy.data.FoxyOrderDetaiData;
import com.foxy.db.Category;
import com.foxy.db.CustBrand;
import com.foxy.db.CustDivision;
import com.foxy.db.HibernateUtil;
import com.foxy.db.OrderConfirm;
import com.foxy.db.OrderNoReplaced;
import com.foxy.db.OrderNoReserved;
import com.foxy.db.OrderSummary;
import com.foxy.db.Orders;
import com.foxy.util.ListData;
import com.foxy.util.OrderNumber;

/**
 *
 * @author eric
 */
public class FoxyOrderPage extends Page implements Serializable {

    private static String MENU_CODE = "FOXY";
    private DataModel orderDetailModel;
    private List brandList = null;
    private List divisionList = null;
    private List ordNoReservedList = null;
    //private List orderList = new ArrayList();
    private String orderId = null;
    private String orderIdYear = null;
    private String mainFactoryCode = null;
    private String cnameCode = "CN1";
    private Date orderDate = Calendar.getInstance(Locale.US).getTime();
    private String customer = null;
    private String custBrandCode = null;
    private String custDivisionCode = null;
    private String style = null;
    private String season = null;
    private Double unitPrice = null;
    private Double qtyDzn = null;
    private Double qtyPcs = null;
    private Double dailyCap = null;
    private String colourTypeCode = null;
    private String graphicTypeCode = null;
    private String merchandiser = null;
    private String description = null;
    private String fabrication = null;
    private String fabricType = null;
    private Double horizontal = null;
    private Double vertical = null;
    private String remark = null;
    private String priceTerm = "FOB"; //Default to FOB
    private String fabricMill = null;
    private String fabricYyDz = null;
    private String fabricPrice = null;
    private Double costCm = null;
    private Double costBasicTrim = null;
    private Double costAddTrim = null;
    private Double ftyCm = null;
    private String ftyRemark = null;
    private Double ftyTrim = null;
    private Double actualOutput = null;
    private Double actualCm = null;
    private Double actualTrim = null;
    private String wash = null;
    private String swash = null;
    private String gcost = null;
    private String quotaUom = null;
    private String uom = null;
    private String recordStamp = null;
    private String duplicatefrom = "";
    private List searchTypes = new ArrayList();
    private String remarkMarketing = null;

    /**
     * Creates a new instance of FoxyMainPage
     */
    public FoxyOrderPage() {
        super("OrderForm");
        //getOrder(this.orderId);
        this.isAuthorize(MENU_CODE);

        /*
         * Get session data
         */
        if (this.foxySessionData == null) {
            this.foxySessionData = (FoxySessionData) getBean("foxySessionData");
        }

        /*
         * Set default action
         */
        if (this.foxySessionData.getAction() == null) {
            this.foxySessionData.setAction("ADD");
        }

        /*
         * Added in to cater for duplicate new order from existing one
         * foxySessionData.getAction = ADD
         * foxySessionData.getOrderId != null
         */
        if (this.foxySessionData.getAction().equals(ADD)
                && this.foxySessionData.getOrderId() != null) {
            //Retrieve all details info for orderId we wanted to duplicate from
            if (this.customer == null) { //this is constructor, so will be call once any where.  redundant?
                this.getOrderUpd(this.foxySessionData.getOrderId());
                this.orderId = null;
                this.orderIdYear = null;
                this.recordStamp = null;
                this.duplicatefrom = " via Dup[" + this.foxySessionData.getOrderId() + "]";
            }
        } else {
            this.duplicatefrom = "";
        }

        /*
         * Retrive data from database if action is enq
         */
        if (this.foxySessionData.getAction().equals(ENQ)) {
            if (this.ectx.getRequestParameterMap().containsKey("recordid")) {
                this.foxySessionData.setPageParameter(this.ectx.getRequestParameterMap().get("recordid").toString());
            }

            if (this.foxySessionData.getOrderId() != null) {
                this.foxySessionData.setPageParameter(this.foxySessionData.getOrderId());
            }
            this.getOrderEnq(this.foxySessionData.getPageParameter());
        }

        /*
         * Retrive data from database if action is enq
         */
        if (this.foxySessionData.getAction().equals(UPD)) {
            if (this.foxySessionData.getPageParameter() != null) {
                this.getOrderUpd(this.foxySessionData.getPageParameter());
            } else {
                /*
                 * Added in to fallback to session bean info getOrder if pageParameter not contain orderid
                 */
                this.getOrderUpd(this.foxySessionData.getOrderId());
            }
        }
        if (this.foxySessionData.getAction().equals(SCH)
                || this.foxySessionData.getAction().equals(LST)) {
            this.searchTypes.add(new SelectItem("1", "Ref Number", "selected"));
            this.searchTypes.add(new SelectItem("2", "Style Code", ""));
            this.searchTypes.add(new SelectItem("3", "Season", ""));
        }
    }

    private String smartGetNewOrderId() {
        /*
         * Auto generate orderId based on orderNo table value or user reserved no
         * 
         */
        if ("AUTOGENERATE".equals(this.orderId)) {
            OrderNumber ordNo = new OrderNumber();
            this.setOrderId(ordNo.getOrderNumber(Integer.parseInt(this.getMainFactoryCode()), this.orderIdYear, true));
        } else if (!"".equals(this.orderId)) {//using reserved value booked by current user id, need to delete orderid selected from the pool
            try {
                Session session = (Session) HibernateUtil.currentSession();
                Transaction tx = session.beginTransaction();
                String qstr = "DELETE OrderNoReserved r WHERE r.reservedNo = :rOrdId";
                Query q = session.createQuery(qstr);
                q.setString("rOrdId", this.getOrderId());
                q.executeUpdate();
                tx.commit();
                session.clear();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return this.getOrderId();
    }

    public String getDuplicatefrom() {
        return duplicatefrom;
    }

    private void getOrderEnq(String orderid) {
        try {
            Session session = (Session) HibernateUtil.currentSession();
            Transaction tx = session.beginTransaction();
            List result = session.createQuery("from Orders where orderid = '"
                    + orderid + "'").list();
            tx.commit();
            session.clear();
            ListData ld = (ListData) getBean("listData");
            for (int i = 0; i < result.size(); i++) {
                Orders od = (Orders) result.get(i);
                this.orderId = od.getOrderId();
                this.orderDate = od.getOrderDate();
                this.customer = ld.getCustomer(od.getCustCode()).getCustName();
                this.custBrandCode = od.getCustBrand();
                this.custDivisionCode = od.getCustDivision();
                this.style = od.getStyleCode();
                this.season = ld.getSeasonDesc(od.getSeason());
                this.unitPrice = od.getUnitPrice();
                this.merchandiser = ld.getMerchandiser(od.getMerchandiser()).getFullName();
                this.description = od.getDescription();
                this.fabrication = od.getFabrication();
                this.remark = od.getRemark();
                this.horizontal = od.getHorizontal();
                this.vertical = od.getVertical();
                this.dailyCap = od.getDailyCap();
                this.colourTypeCode = od.getColourTypeCode();
                this.graphicTypeCode = od.getGraphicTypeCode();
                this.remarkMarketing = od.getRemarkMarketing();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void getOrderUpd(String orderid) {
        try {
            SimpleDateFormat sdf1 = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
            Session session = (Session) HibernateUtil.currentSession();
            Transaction tx = session.beginTransaction();
            List result = session.createQuery("from Orders where orderid = '"
                    + orderid + "'").list();
            tx.commit();
            session.clear();
            for (int i = 0; i < result.size(); i++) {
                Orders od = (Orders) result.get(i);
                this.orderId = od.getOrderId();
                this.orderDate = od.getOrderDate();
                this.cnameCode = od.getCnameCode();
                this.customer = od.getCustCode();
                this.custBrandCode = od.getCustBrand();
                this.custDivisionCode = od.getCustDivision();
                this.style = od.getStyleCode();
                this.season = od.getSeason();
                this.unitPrice = od.getUnitPrice();
                this.merchandiser = od.getMerchandiser();
                this.description = od.getDescription();
                this.dailyCap = od.getDailyCap();
                this.colourTypeCode = od.getColourTypeCode();
                this.graphicTypeCode = od.getGraphicTypeCode();
                this.fabrication = od.getFabrication();
                this.fabricType = od.getFabricType();
                this.remark = od.getRemark();
                this.horizontal = od.getHorizontal();
                this.vertical = od.getVertical();
                this.priceTerm = od.getPriceTerm();
                this.fabricMill = od.getFabricMill();
                this.fabricPrice = od.getFabricPrice();
                this.fabricYyDz = od.getFabricYyDz();
                this.costCm = od.getCostCm();
                this.costBasicTrim = od.getCostBasicTrim();
                this.costAddTrim = od.getCostAddTrim();
                this.ftyCm = od.getFtyCm();
                this.ftyRemark = od.getFtyRemark();
                this.ftyTrim = od.getFtyTrim();
                this.actualCm = od.getActualCm();
                this.actualOutput = od.getActualOutput();
                this.actualTrim = od.getActualTrim();
                this.wash = od.getWash();
                this.swash = od.getSwash();
                this.gcost = od.getGcost();
                this.quotaUom = od.getQuotaUom();
                this.uom = od.getUom();
                if (od.getInsUsrId() != null) {
                    this.recordStamp = "Created [" + od.getInsUsrId() + " - " + sdf1.format(od.getInsTime()) + "]";
                } else {
                    this.recordStamp = "Created [ No Record ]";
                }

                if (od.getUpdUsrId() != null) {
                    this.recordStamp = this.recordStamp + "     Last Update [" + od.getUpdUsrId() + " - " + sdf1.format(od.getUpdTime()) + "]";
                } else {
                    this.recordStamp = this.recordStamp + "     Last Update [No Update On Record yet]";
                }
                this.setSessionObject1((Object) od);//save in session bean
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public String save() {
        Orders order = new Orders();

        if (ectx.getRequestParameterMap().containsKey("UpdAddForm:OrderIdD")) {
            this.orderId = ectx.getRequestParameterMap().get("UpdAddForm:OrderIdD").toString();
            order.setOrderId(this.orderId);
        } else {
            order.setOrderId(this.smartGetNewOrderId());
            //New order, clear session cache object to ensure dirty record been used
            this.setSessionObject1((Object) null);
        }

        try {
            Session session = (Session) HibernateUtil.currentSession();
            Transaction tx = session.beginTransaction();
            order.setCnameCode(this.getCnameCode());
            order.setCustCode(this.getCustomer());
            order.setCustBrand(this.getCustBrandCode());
            order.setCustDivision(this.getCustDivisionCode());
            order.setStyleCode(this.getStyle());
            order.setSeason(this.getSeason());
            order.setMerchandiser(this.getMerchandiser());
            order.setOrderDate(this.getDate());
            order.setUnitPrice(this.getUnitPrice());
            order.setQtyDzn(this.getQtyDzn());
            order.setQtyPcs(this.getQtyPcs());
            order.setDescription(this.getDescription());
            order.setFabrication(this.getFabrication());
            order.setFabricType(this.getFabricType());
            order.setDailyCap(this.getDailyCap());
            order.setColourTypeCode(this.getColourTypeCode());
            order.setGraphicTypeCode(this.getGraphicTypeCode());
            order.setRemark(this.getRemark());
            order.setHorizontal(this.getHorizontal());
            order.setVertical(this.getVertical());
            order.setPriceTerm(this.getPriceTerm());
            order.setFabricMill(this.getFabricMill());
            order.setFabricPrice(this.getFabricPrice());
            order.setFabricYyDz(this.getFabricYyDz());
            order.setCostCm(this.getCostCm());
            order.setCostBasicTrim(this.getCostBasicTrim());
            order.setCostAddTrim(this.getCostAddTrim());
            order.setFtyCm(this.getFtyCm());
            order.setFtyRemark(this.getFtyRemark());
            order.setFtyTrim(this.getFtyTrim());
            order.setActualCm(this.getActualCm());
            order.setActualOutput(this.getActualOutput());
            order.setActualTrim(this.getActualTrim());
            order.setWash(this.getWash());
            order.setSwash(this.getSwash());
            order.setGcost(this.getGcost());
            order.setQuotaUom(this.getQuotaUom());
            order.setUom(this.getUom());
            order.setStatus("A");
            
            Orders tmpobj = (Orders) this.getSessionObject1(Orders.class);
            if (tmpobj != null) {//Need to update back ins info seen not using persistant bean
                order.setInsTime(tmpobj.getInsTime());
                order.setInsUsrId(tmpobj.getInsUsrId());
                order.setImgFile(tmpobj.getImgFile());//need to save back, else will be null aft upd
            }
            session.saveOrUpdate(order);

            tx.commit();
            session.clear();
            HibernateUtil.closeSession();
        } catch (Exception e) {
            e.printStackTrace();
            return ("success");
        }
        this.getOrderEnq(this.orderId);
        this.foxySessionData.setPageParameter(this.orderId);
        this.foxySessionData.setAction(ADD);
        this.foxySessionData.setOrderId(this.orderId);
        return ("ADD_DETAIL");
    }

    public String execOrderIdTransfer() {
        /*
         * 1. Update ordsummary table
         * 2. Update ordconfirm table
         * 3. Update orders table
         * 4. Insert a new record into orerno_repalaced table
         */
        String oldOrderId = this.foxySessionData.getOrderId();
        String newOrderId = this.smartGetNewOrderId();
        FoxyFileUploadPage filemove = new FoxyFileUploadPage();

        //Save new order id into session beans for shortcut to use and serve as active order id
        this.foxySessionData.setOrderId(newOrderId);

        //UPDATE ordsummary set orderid = 'newOrderID' where orderid = 'oldOrderId'
        //UPDATE ordconfirm set orderid = 'newOrderID' where orderid = 'oldOrderId'
        //UPDATE orders     set orderid = 'newOrderID' where orderid = 'oldOrderId'
        //INSERT oldOrderID, newOrderId, 'A', INTO orderno_replaced;
        try {
            String userid = null;
            ExternalContext tmpectx = FacesContext.getCurrentInstance().getExternalContext();
            if (tmpectx != null) {
                userid = tmpectx.getRemoteUser();
            }

            Session session = (Session) HibernateUtil.currentSession();

            session.clear();
            Transaction tx = (Transaction) session.beginTransaction();


            String qstr = "UPDATE OrderSummary SET orderId = :pnewOrderId WHERE orderId = :poldOrderId";
            //set parameter value
            Query q = session.createQuery(qstr);
            q.setString("pnewOrderId", newOrderId);
            q.setString("poldOrderId", oldOrderId);
            //this.printCallCounter(qstr);
            q.executeUpdate();
            tx.commit();
            session.clear();

            tx = (Transaction) session.beginTransaction();
            qstr = "UPDATE OrderConfirm SET orderId = :pnewOrderId WHERE orderId = :poldOrderId";
            q = session.createQuery(qstr);
            q.setString("pnewOrderId", newOrderId);
            q.setString("poldOrderId", oldOrderId);
            //this.printCallCounter(qstr);
            q.executeUpdate();
            tx.commit();
            session.clear();

            //Only update last update userid and time for orders table, the rest is detail, need to remain same
            tx = (Transaction) session.beginTransaction();
            qstr = "UPDATE Orders SET orderId = :pnewOrderId, updUsrId = :pupdUsrId, updTime = now() WHERE orderId = :poldOrderId";
            q = session.createQuery(qstr);
            q.setString("pnewOrderId", newOrderId);
            q.setString("poldOrderId", oldOrderId);
            q.setString("pupdUsrId", userid);
            //this.printCallCounter(qstr);
            q.executeUpdate();
            tx.commit();
            session.clear();

            //Insert record inro OrderNoReplaced table
            OrderNoReplaced ordIdReplaced = new OrderNoReplaced();
            ordIdReplaced.setNewOrderId(newOrderId);
            ordIdReplaced.setOldOrderId(oldOrderId);
            ordIdReplaced.setStatus("A");
            tx = (Transaction) session.beginTransaction();
            session.saveOrUpdate(ordIdReplaced);
            tx.commit();
            filemove.transferOrderId(oldOrderId, newOrderId);

        } catch (HibernateException e) {
            //do something here with the exception
            e.printStackTrace();
            FacesMessage fmsg = new FacesMessage(FacesMessage.SEVERITY_ERROR, e.getCause().toString(), e.getMessage());
            ctx.addMessage(null, fmsg);
        } catch (Exception e) {
            //e.printStackTrace();
            FacesMessage fmsg = new FacesMessage(FacesMessage.SEVERITY_ERROR, e.getCause().toString(), e.getMessage());
            ctx.addMessage(null, fmsg);
        } finally {
            HibernateUtil.closeSession();
        }
        return "success";
    }

    public DataModel getOrderDetail() {
        Double totalDzn = new Double(0.0);
        Double totalPcs = new Double(0.0);
        ListData ld = (ListData) getBean("listData");
        //Performance improvement
        if (orderDetailModel == null) {
            try {
                orderDetailModel = new ListDataModel();
                Session session = (Session) HibernateUtil.currentSession();
                List ordSum = session.createQuery("from OrderSummary where orderid = '"
                        + this.orderId + "' and status != 'D' order by month, location").list();
                if (ordSum.size() <= 0) {
                    FoxyOrderDetaiData odDs = new FoxyOrderDetaiData();
                    this.tableList.add(odDs);
                }
                for (int i = 0; i < ordSum.size(); i++) {
                    FoxyOrderDetaiData odDs = new FoxyOrderDetaiData();
                    OrderSummary os = (OrderSummary) ordSum.get(i);

                    List result = session.createQuery("from Category where catId = " + os.getCatId()).list();
                    if (result.size() > 0) { //Check to ensure no array out of bound exception if cat not found
                        Category cat = (Category) result.get(0);
                        odDs.setCategory(cat.getCategory());
                    }

                    odDs.setMonth(os.getMonth());
                    odDs.setDestName(ld.getDestinationDesc(os.getDestination(), 1));
                    odDs.setDestShortName(ld.getDestinationShortDesc(os.getDestination(), 1));
                    odDs.setLocation(os.getLocation());
                    odDs.setOrderMethod(os.getOrderMethod());
                    odDs.setDelivery(os.getDelivery());
                    odDs.setFabricDate(os.getFabricDeliveryDate());

                    odDs.setMainFactoryShortName(ld.getFactoryNameShort(os.getMainFactory()));
                    odDs.setRemark(os.getRemark());
                    odDs.setQuantityDzn(os.getQtyDzn());
                    odDs.setQuantityPcs(os.getQtyPcs());
                    odDs.setUnit(os.getUnit());
                    this.tableList.add(odDs);

                    List ordCon = session.createQuery("from OrderConfirm where orderid = '"
                            + this.orderId + "' and srefid = " + os.getId() + " and status != 'D' order by month, location, sublocation").list();

                    //List ordCon = session.createQuery("from OrderConfirm where orderid = '" +
                    //        this.orderId + "' and month = '" + os.getMonth() + "' and location = '" + os.getLocation() + "' and status != 'D' order by month, location, sublocation").list();

                    totalDzn = 0.0;
                    totalPcs = 0.0;

                    if (ordCon.size() <= 0) {
                        FoxyOrderDetaiData tot = new FoxyOrderDetaiData();
                        tot.setMonth(os.getMonth());
                        tot.setLocation(os.getLocation());
                        tot.setMainFactoryShortName(ld.getFactoryNameShort(os.getMainFactory()));
                        tot.setCategory(odDs.getCategory());
                        tot.setOrderMethod(os.getOrderMethod());
                        tot.setDelivery(os.getDelivery());
                        tot.setDestName(odDs.getDestName());
                        tot.setDestShortName(odDs.getDestShortName());

                        this.tableList.add(tot);
                    }

                    for (int j = 0; j < ordCon.size(); j++) {
                        FoxyOrderDetaiData odDc = new FoxyOrderDetaiData();
                        OrderConfirm oc = (OrderConfirm) ordCon.get(j);

                        /*
                         * result = session.createQuery("from Category where catId =
                         * '" + oc.getCategory() +"'").list(); cat = (Category)
                         * result.get(0);
                         odDc.setCategory(cat.getCategory());
                         */

                        odDc.setMonth(oc.getMonth());
                        odDc.setMainFactoryShortName(ld.getFactoryNameShort(os.getMainFactory()));
                        odDc.setCategory(odDs.getCategory());
                        odDc.setOrderMethod(os.getOrderMethod());
                        odDc.setDelivery(os.getDelivery());
                        odDc.setDestName(odDs.getDestName());
                        odDc.setDestShortName(odDs.getDestShortName());

                        odDc.setPoNumber(oc.getPoNumber());
                        odDc.setPoDate(oc.getPoDate());
                        odDc.setLocation(oc.getLocation());
                        odDc.setSubLocation(oc.getSubLocation());
                        odDc.setQuantityDzn(oc.getQtyDzn());
                        odDc.setQuantityPcs(oc.getQtyPcs());
                        odDc.setUnit(os.getUnit());
                        odDc.setVesselDate(oc.getVesselDate());
                        odDc.setFabricDate(oc.getFabricDate());
                        this.tableList.add(odDc);
                        totalDzn += oc.getQtyDzn();
                        totalPcs += oc.getQtyPcs();
                        if (j == (ordCon.size() - 1)) {
                            FoxyOrderDetaiData tot = new FoxyOrderDetaiData();
                            tot.setMonth(oc.getMonth());
                            tot.setLocation(os.getLocation());
                            tot.setMainFactoryShortName(ld.getFactoryNameShort(os.getMainFactory()));
                            tot.setCategory(odDs.getCategory());
                            tot.setOrderMethod(os.getOrderMethod());
                            tot.setDelivery(os.getDelivery());
                            tot.setDestName(odDs.getDestName());
                            tot.setDestShortName(odDs.getDestShortName());

                            tot.setQuantityDzn(totalDzn);
                            tot.setQuantityPcs(totalPcs);
                            tot.setUnit(os.getUnit());
                            this.tableList.add(tot);
                        }
                    }
                }
                orderDetailModel.setWrappedData(tableList);
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                HibernateUtil.closeSession();
            }
        }
        return orderDetailModel;
    }

    public List getBrandItemsList() {
        if (brandList == null) {
            List resultList = null;
            brandList = new ArrayList();

            if (this.customer != null) { //customer code
                try {
                    Session session = (Session) HibernateUtil.currentSession();
                    Transaction tx = session.beginTransaction();
                    Criteria crit = session.createCriteria(CustBrand.class);
                    crit.add(Expression.eq("custCode", this.customer));
                    resultList = crit.list();

                    tx.commit();
                } catch (HibernateException e) {
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
                    brandList.add(new SelectItem(new String(""), new String("Pls select one"))); //Always add a null items, event no records
                } else {
                    brandList.add(new SelectItem(new String(""), new String("Empty"))); //Always add a null items, event no records
                }
                for (int i = 0; i < resultList.size(); i++) {
                    CustBrand cbrand = (CustBrand) resultList.get(i);
                    brandList.add(new SelectItem(cbrand.getBrandCode(), cbrand.getBrandCode() + " - " + cbrand.getBrandDesc()));
                }
            } else {
                brandList.add(new SelectItem(new String(""), new String("Empty"))); //Always add a null items, event no records
            }
        }

        return brandList;
    }

    public List getDivisionItemsList() {
        if (divisionList == null) {
            divisionList = new ArrayList();


            if (this.customer != null && this.custBrandCode != null) { //customer code
                List resultList = null;
                try {
                    Session session = (Session) HibernateUtil.currentSession();
                    Transaction tx = session.beginTransaction();
                    Criteria crit = session.createCriteria(CustDivision.class);
                    crit.add(Expression.eq("custCode", this.customer));
                    crit.add(Expression.eq("brandCode", this.custBrandCode));
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
                    divisionList.add(new SelectItem(new String(""), new String("Pls select one"))); //Always add a null items, event no records
                } else {
                    divisionList.add(new SelectItem(new String(""), new String("Empty"))); //Always add a null items, event no records
                }

                for (int i = 0; i < resultList.size(); i++) {
                    CustDivision cdivision = (CustDivision) resultList.get(i);
                    divisionList.add(new SelectItem(cdivision.getDivCode(), cdivision.getDivCode() + " - " + cdivision.getDivDesc()));
                }
            } else {
                divisionList.add(new SelectItem(new String(""), new String("Empty"))); //Always add a null items, event no records
            }
        }
        return divisionList;
    }

    public List getOrdNoReservedList() {
        if (ordNoReservedList == null) {
            ordNoReservedList = new ArrayList();
            List resultList = null;
            String userid = null;

            userid = this.getUserId();

            //System.err.println(this.orderIdYear + " " + this.mainFactoryCode + " " + userid);
            if (this.orderIdYear != null && this.mainFactoryCode != null && userid != null) { //Only start query if both paramter not null
                try {
                    Session session = (Session) HibernateUtil.currentSession();
                    Transaction tx = session.beginTransaction();
                    Criteria crit = session.createCriteria(OrderNoReserved.class);
                    crit.add(Expression.eq("year", Integer.parseInt(this.orderIdYear)));
                    crit.add(Expression.eq("mainFactory", Integer.parseInt(this.mainFactoryCode)));
                    crit.add(Expression.eq("forUserId", userid));
                    crit.add(Expression.ge("expiredOn", Calendar.getInstance(Locale.US).getTime()));//Do not list expired items
                    crit.addOrder(Order.asc("reservedNo"));
                    resultList = crit.list();

                    tx.commit();
                } catch (HibernateException e) {
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
                    ordNoReservedList.add(new SelectItem("", "Pls select one")); //Always add a null items, event no records
                }

                ordNoReservedList.add(new SelectItem("AUTOGENERATE", "Auto Generate / Using Expired RefNum")); //Always add a null items, event no records

                for (int i = 0; i < resultList.size(); i++) {
                    OrderNoReserved ordNoRsv = (OrderNoReserved) resultList.get(i);
                    ordNoReservedList.add(new SelectItem(ordNoRsv.getReservedNo(), ordNoRsv.getReservedNo() + " ExpOn[" + ordNoRsv.getExpiredOnFmted() + "]"));
                }
            } else {
                ordNoReservedList.add(new SelectItem("", "Please Select Year & Factory")); //Always add a null items, event no records
            }
        }

        return ordNoReservedList;
    }

    public String onYearOrFactoryChange() {
        this.ordNoReservedList = null;
        return null;
    }

    //action for ajax call
    public String onCustCodeChange() {
        //force to reset the brand and division list
        this.brandList = null;
        this.divisionList = null;
        return null; //Need to return null to disable page flow to take effect
    }

    //action for ajax call
    public String onCustBrandChange() {
        //Force to reset the division list (reload)
        this.divisionList = null;
        return null; //Need to return null to disable page flow to take effect
    }

    /**
     * Retrive data from database
     */
    //Page flow method call
    public String enquire() {
        this.foxySessionData.setAction(ENQ);
        if (this.foxySessionData.getPageParameter() != null) {
            this.foxySessionData.setOrderId(this.foxySessionData.getPageParameter());
            this.getOrderEnq(this.foxySessionData.getOrderId());
        }
        return ("OrderEnqSuccess");
    }

    /**
     * Update database
     */
    public String update() {
        this.foxySessionData.setAction(ENQ);
        return ("success");
    }

    /**
     * Prepare for update action
     */
    public String edit() {
        this.foxySessionData.setAction(UPD);
        this.getOrderUpd(this.getOrderIdD());
        return ("EditOrder");
    }

    /**
     * Delete from database
     */
    public String delete() {
        this.foxySessionData.setAction(ENQ);

        try {
            Session session = (Session) HibernateUtil.currentSession();
            Transaction tx = session.beginTransaction();

            List child = session.createQuery("from OrderSummary where orderid = '"
                    + this.getOrderId() + "'").list();
            if (child.size() > 0) {
                FacesMessage fmsg = new FacesMessage(FacesMessage.SEVERITY_ERROR, "@ Error: Child exist for Ref. Number [" + this.getOrderId() + "], delete not allowed.", "");
                ctx.addMessage(null, fmsg);
                return ("success");
            }

            List result = session.createQuery("from Orders where orderid = '"
                    + this.getOrderId() + "'").list();
            if (result.size() == 1) {
                Orders od = (Orders) result.get(0);
                od.setStatus("D");
                session.saveOrUpdate(od);
            }

            /*
             * delete from order summary
             */
            int resultos = session.createQuery("delete from OrderSummary where orderid = "
                    + this.getOrderId()).executeUpdate();
            /*
             * List resultOS = session.createQuery("from OrderSummary where
             * orderid = '" + this.getOrderId() + "'").list(); if
             * (resultOS.size() > 0) { for (int i = 0; i < resultOS.size(); i
             * ++) { OrderSummary os = (OrderSummary) resultOS.get(i); int
             * resultSP = session.createQuery("delete from OrderSummary where
             * orderid = " + this.getOrderId()).executeUpdate();
             * //os.setStatus("D"); //session.saveOrUpdate(os); }
             }
             */
            List resultOC = session.createQuery("from OrderConfirm where orderid = '"
                    + this.getOrderId() + "'").list();
            if (resultOC.size() > 0) {
                for (int j = 0; j < resultOC.size(); j++) {
                    OrderConfirm oc = (OrderConfirm) resultOC.get(j);
                    /*
                     * oc.setStatus("D");
                     session.saveOrUpdate(oc);
                     */

                    int resultoc = session.createQuery("delete from Shipping where crefid = "
                            + oc.getId()).executeUpdate();

                    /*
                     * List resultSP = session.createQuery("from Shipping where
                     * crefid = " + oc.getId()).list(); if (resultSP.size() ==
                     * 1) { Shipping sp = (Shipping) resultSP.get(0);
                     * sp.setStatus("D"); session.saveOrUpdate(sp); } else {
                     * continue; }
                     */


                }
                int resultSP = session.createQuery("delete from OrderConfirm where orderid = '"
                        + this.getOrderId() + "'").executeUpdate();
            }

            tx.commit();
            session.clear();
            HibernateUtil.closeSession();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ("success");
    }

    //Page flow method call
    public String orderInstruction() {
        this.foxySessionData.setAction(ADD);
        this.foxySessionData.setPageParameter(String.valueOf(this.getOrderId()));
        return ("ADD_DETAIL");
    }

    //Page flow method call
    public String poEntry() {
        this.foxySessionData.setAction(ENQ);
        this.foxySessionData.setPageParameter(String.valueOf(this.getOrderId()));
        return ("ADD_PO");
    }

    //Page flow method call
    public String shipEntry() {
        this.foxySessionData.setAction(new String(ENQ));
        this.foxySessionData.setPageParameter(String.valueOf(this.getOrderId()));
        return ("ADD_SHIP");
    }

    //Page Header menu shortcut call
    //Page flow method call
    public String shortCut() {
        //this.foxySessionData.setAction(ENQ);
        //this.foxySessionData.setPageParameter(String.valueOf(this.getOrderId()));
        return ("go_enqOrder");
    }

    /**
     * Below are getter and setter for foxy parameter
     */
    //PROPERTY: orderId
    public String getOrderId() {
        return this.orderId;
    }

    public String getOrderIdD() {
        return this.orderId;
    }

    public void setOrderId(String newValue) {
        this.orderId = newValue;
    }

    public void setOrderIdD(String newValue) {
        this.orderId = newValue;
    }

    //PROPERTY: orderIdYear
    public String getOrderIdYear() {
        return this.orderIdYear;
    }

    public void setOrderIdYear(String newValue) {
        this.orderIdYear = newValue;
    }

    //PROPERTY: mainFactoryCode
    public String getMainFactoryCode() {
        return this.mainFactoryCode;
    }

    public void setMainFactoryCode(String newValue) {
        this.mainFactoryCode = newValue;
    }

    //PROPERTY: orderDate
    public Date getDate() {
        return this.orderDate;
    }

    public void setDate(Date newValue) {
        this.orderDate = newValue;
    }

    //PROPERTY: Company Name
    public String getCnameCode() {
        return cnameCode;
    }

    public void setCnameCode(String cnameCode) {
        this.cnameCode = cnameCode;
    }

    //PROPERTY: customer
    public String getCustomer() {
        return this.customer;
    }

    public void setCustomer(String newValue) {
        this.customer = newValue;
    }

    //PROPERTY: custBrandCode
    public String getCustBrandCode() {
        return this.custBrandCode;
    }

    public void setCustBrandCode(String newValue) {
        this.custBrandCode = newValue;
    }

    //PROPERTY: custDivisionCode
    public String getCustDivisionCode() {
        return this.custDivisionCode;
    }

    public void setCustDivisionCode(String newValue) {
        this.custDivisionCode = newValue;
    }

    //PROPERTY: style
    public String getStyle() {
        return this.style;
    }

    public void setStyle(String newValue) {
        this.style = newValue;
    }

    //PROPERTY: season
    public String getSeason() {
        return this.season;
    }

    public void setSeason(String newValue) {
        this.season = newValue;
    }
    //PROPERTY: searchTypes

    public List getSearchTypes() {
        return this.searchTypes;
    }

    public void setSearchTypes(List newValue) {
        this.searchTypes = newValue;
    }
    //PROPERTY: unitPrice

    public Double getUnitPrice() {
        return this.unitPrice;
    }

    public void setUnitPrice(Double newValue) {
        this.unitPrice = newValue;
    }
    //PROPERTY: qtyDzn

    public Double getQtyDzn() {
        return this.qtyDzn;
    }

    public void setQtyDzn(Double newValue) {
        this.qtyDzn = newValue;
    }
    //PROPERTY: qtyPcs

    public Double getQtyPcs() {
        return this.qtyPcs;
    }

    public void setQtyPcs(Double newValue) {
        this.qtyPcs = newValue;
    }

    public Double getDailyCap() {
        return dailyCap;
    }

    public void setDailyCap(Double dailyCap) {
        this.dailyCap = dailyCap;
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

    //PROPERTY: merchandiser
    public String getMerchandiser() {
        return this.merchandiser;
    }

    public void setMerchandiser(String newValue) {
        this.merchandiser = newValue;
    }

    //PROPERTY: description
    public String getDescription() {
        return this.description;
    }

    public void setDescription(String newValue) {
        this.description = newValue;
    }
    //PROPERTY: horizontal

    public Double getHorizontal() {
        return this.horizontal;
    }

    public void setHorizontal(Double newValue) {
        this.horizontal = newValue;
    }
    //PROPERTY: vertical

    public Double getVertical() {
        return this.vertical;
    }

    public void setVertical(Double newValue) {
        this.vertical = newValue;
    }
    //PROPERTY: fabrication

    public String getFabrication() {
        return this.fabrication;
    }

    public void setFabrication(String newValue) {
        this.fabrication = newValue;
    }

    //PROPERTY: fabricType
    public String getFabricType() {
        return fabricType;
    }

    public void setFabricType(String fabricType) {
        this.fabricType = fabricType;
    }

    //PROPERTY: priceTerm
    public String getPriceTerm() {
        return this.priceTerm;
    }

    public void setPriceTerm(String newValue) {
        this.priceTerm = newValue;
    }
    //PROPERTY: fabricMill

    public String getFabricMill() {
        return this.fabricMill;
    }

    public void setFabricMill(String newValue) {
        this.fabricMill = newValue;
    }
    //PROPERTY: fabricYyDz

    public String getFabricYyDz() {
        return this.fabricYyDz;
    }

    public void setFabricYyDz(String newValue) {
        this.fabricYyDz = newValue;
    }
    //PROPERTY: fabricPrice

    public String getFabricPrice() {
        return this.fabricPrice;
    }

    public void setFabricPrice(String newValue) {
        this.fabricPrice = newValue;
    }
    //PROPERTY: costCm

    public Double getCostCm() {
        return this.costCm;
    }

    public void setCostCm(Double newValue) {
        this.costCm = newValue;
    }

    public Double getCostBasicTrim() {
        return costBasicTrim;
    }

    public void setCostBasicTrim(Double costBasicTrim) {
        this.costBasicTrim = costBasicTrim;
    }

    public Double getCostAddTrim() {
        return costAddTrim;
    }

    public void setCostAddTrim(Double costAddTrim) {
        this.costAddTrim = costAddTrim;
    }

    //PROPERTY: ftyCm
    public Double getFtyCm() {
        return this.ftyCm;
    }

    public void setFtyCm(Double newValue) {
        this.ftyCm = newValue;
    }

    //PROPERTY: ftyRemark
    public String getFtyRemark() {
        return ftyRemark;
    }

    public void setFtyRemark(String ftyRemark) {
        this.ftyRemark = ftyRemark;
    }

    public Double getFtyTrim() {
        return ftyTrim;
    }

    public void setFtyTrim(Double ftyTrim) {
        this.ftyTrim = ftyTrim;
    }

    public Double getActualOutput() {
        return actualOutput;
    }

    public void setActualOutput(Double actualOutput) {
        this.actualOutput = actualOutput;
    }

    public Double getActualCm() {
        return actualCm;
    }

    public void setActualCm(Double actualCm) {
        this.actualCm = actualCm;
    }

    public Double getActualTrim() {
        return actualTrim;
    }

    public void setActualTrim(Double actualTrim) {
        this.actualTrim = actualTrim;
    }

    //PROPERTY: wash
    public String getWash() {
        return this.wash;
    }

    public void setWash(String newValue) {
        this.wash = newValue;
    }
    //PROPERTY: swash

    public String getSwash() {
        return this.swash;
    }

    public void setSwash(String newValue) {
        this.swash = newValue;
    }
    //PROPERTY: gcost

    public String getGcost() {
        return this.gcost;
    }

    public void setGcost(String newValue) {
        this.gcost = newValue;
    }
    //PROPERTY: quotaUom

    public String getQuotaUom() {
        return this.quotaUom;
    }

    public void setQuotaUom(String newValue) {
        this.quotaUom = newValue;
    }
    //PROPERTY: uom

    public String getUom() {
        return this.uom;
    }

    public void setUom(String newValue) {
        this.uom = newValue;
    }

    public String getRecordStamp() {
        return this.recordStamp;
    }

    //PROPERTY: remark
    public String getRemark() {
        return this.remark;
    }

    public void setRemark(String newValue) {
        this.remark = newValue;
    }

	public String getRemarkMarketing() {
		return remarkMarketing;
	}

	public void setRemarkMarketing(String remarkMarketing) {
		this.remarkMarketing = remarkMarketing;
	}
}
