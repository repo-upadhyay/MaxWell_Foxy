/*
 * FoxyOrderPage.java
 *
 * Created on June 20, 2006, 6:18 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */
package com.foxy.page;

import com.foxy.bean.FoxySessionData;
import com.foxy.data.FoxyOrderList;
import com.foxy.db.HibernateUtil;
import com.foxy.db.Orders;
import com.foxy.util.FoxyPagedDataModel;
import com.foxy.util.ListData;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import javax.faces.application.FacesMessage;
import javax.faces.model.DataModel;
import javax.faces.model.SelectItem;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author eric
 */
public class FoxyOrderSearchPage extends Page implements Serializable {

    private static String MENU_CODE = "FOXY";
    private DataModel orderDetailModel;
    private DataModel orderListModel = null;
    private List searchTypes = new ArrayList();
    private ListData ld = null;
    private Integer count = 0;

    /**
     * Creates a new instance of FoxyMainPage
     */
    public FoxyOrderSearchPage() {
        super("OrderSearchForm");
        //getOrder(this.orderId);
        this.isAuthorize(MENU_CODE);

        /*
         * Get session data
         */
        if (this.foxySessionData == null) {
            this.foxySessionData = (FoxySessionData) getBean("foxySessionData");
        }

        this.searchTypes.add(new SelectItem("1", "Ref Number", "selected"));
        this.searchTypes.add(new SelectItem("2", "Style Code", ""));
        this.searchTypes.add(new SelectItem("3", "Season", ""));
    }

    public DataModel getOrderList() {
        //Added in to get total row count
        Number numofRec = null;
        int firstrow;
        int pagesize;

        firstrow = this.foxyTable.getFirst();
        pagesize = this.foxyTable.getRows();

        //If new search,then tahe default first row value, else take from session memory of last user click
        //save value in session beans
        if (this.foxySessionData != null) {
            if (this.foxySessionData.getTableRows() == 0) {
                this.foxySessionData.setTableFirstRow(firstrow);
                this.foxySessionData.setTableRows(pagesize);
                orderListModel = null;
            } else if (this.foxySessionData.isBackToList()) {
                /**
                 * *******
                 * this line invalidated UIDATA!!??
                 *
                 * BUG TO BE FIX!! once setFirst been called, need to click
                 * twice on 2nd page onward to go to linked page!! UIDATA seems
                 * invalidated and need extra click to re-serialize firstrow =
                 * this.foxySessionData.getTableFirstRow(); pagesize =
                 * this.foxySessionData.getTableRows();
                 * this.foxyTable.setFirst(firstrow); *********
                 */
                //firstrow = this.foxySessionData.getTableFirstRow();
                //pagesize = this.foxySessionData.getTableRows();
                //this.foxyTable.setFirst(firstrow);
                orderListModel = null;
                //turn this off to avoid multiple call to this code, 
                //where reset oderlistmodel and generate new SQL query
                this.foxySessionData.setBackToList(false);
            }
        }

        if (ld == null) {
            ld = (ListData) getBean("listData");
        }

        //Only query if orderListModel = null;
        if (this.searchKey != null && orderListModel == null) {
            try {
                //this.printCallCounter("SQLEXEC OrderSearchPage");
                List result = null;
                Session session = (Session) HibernateUtil.currentSession();
                Transaction tx = session.beginTransaction();

                if (this.searchType != null && this.searchType.equals("3")) {
                    result = session.createQuery("select count(*) as num from Orders as orders where orders.season in "
                            + "(select code from Parameter as param where param.category='SEA' and "
                            + "param.description like '%" + this.searchKey.replace('*', '%') + "%') and status != 'D'").list();
                } else if (this.searchType != null && this.searchType.equals("2")) {
                    result = session.createQuery("select count(*) as num from Orders as orders where "
                            + "orders.styleCode like '" + this.searchKey.replace('*', '%') + "' and status != 'D'").list();
                } else {
                    result = session.createQuery("select count(*) as num from Orders as orders where "
                            + "orders.orderId like '" + this.searchKey.replace('*', '%') + "' and status != 'D'").list();
                }

                numofRec = Integer.parseInt(result.get(0).toString());
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

            numofRec = numofRec == null ? 0 : numofRec.intValue();
        }


        try {
            List result = null;
            if (this.searchKey != null && orderListModel == null) {
                Session session = (Session) HibernateUtil.currentSession();
                Transaction tx = session.beginTransaction();

                if (this.searchType != null && this.searchType.equals("3")) {
                    result = session.createQuery("from Orders as orders where orders.season in "
                            + "(select code from Parameter as param where param.category='SEA' and "
                            + "param.description like '%" + this.searchKey.replace('*', '%') + "%') and status != 'D' "
                            + "order by orderdate desc ").setFirstResult(firstrow).setMaxResults(pagesize).list();

                } else if (this.searchType != null && this.searchType.equals("2")) {
                    result = session.createQuery("from Orders as orders where "
                            + "orders.styleCode like '" + this.searchKey.replace('*', '%') + "' and status != 'D' "
                            + "order by orderdate desc ").setFirstResult(firstrow).setMaxResults(pagesize).list();
                } else {
                    result = session.createQuery("from Orders as orders where "
                            + "orders.orderId like '" + this.searchKey.replace('*', '%') + "' and status != 'D' "
                            + "order by orderdate desc ").setFirstResult(firstrow).setMaxResults(pagesize).list();
                }
                tx.commit();
                for (int i = 0; i < result.size(); i++) {
                    Orders ord = (Orders) result.get(i);
                    FoxyOrderList odl = new FoxyOrderList();
                    odl.setOrderId(ord.getOrderId());
                    odl.setCompanyNameShort(ld.getCompanyNameShort(ord.getCnameCode(), 1));
                    odl.setOrderDate(ord.getOrderDate());
                    odl.setStyleCode(ord.getStyleCode());
                    odl.setCustCode(ord.getCustCode());
                    odl.setCustName(ld.getCustomer(ord.getCustCode()).getCustName());
                    odl.setCustBrand(ord.getCustBrand());
                    odl.setCustDivision(ord.getCustDivision());
                    odl.setSeason(ord.getSeason());
                    odl.setSeasonD(ld.getSeasonDesc(ord.getSeason()));
                    odl.setMerchandiserName(ld.getMerchandiser(ord.getMerchandiser()).getFullName());
                    odl.setImgFile(ord.getImgFile());
                    this.tableList.add(odl);
                }

                orderListModel = new FoxyPagedDataModel(this.tableList, numofRec.intValue(), pagesize);
            }
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
        //save current list pagination and pagesize in session  bean
        if (this.foxySessionData != null) {
            this.foxySessionData.setTableFirstRow(firstrow);
            this.foxySessionData.setTableRows(pagesize);
        }
        return orderListModel;
    }

    /**
     * Prepare for listing
     */
    public String search() {
        this.foxySessionData.setAction(LST);
        this.foxyTable.setFirst(0);
        this.foxySessionData.setTableFirstRow(0);
        return ("success");
    }

    //Page flow method call
    public String newSearch() {
        this.foxySessionData.setAction(SCH);
        this.foxySessionData.setTableFirstRow(0);
        this.foxySessionData.setTableRows(0);
        this.foxySessionData.setSearchKey(null);
        this.foxySessionData.setSearchType("1");
        this.foxySessionData.setBackToList(false);
        return ("NewOrderSearch");
    }

    //Page flow method call
    public String backToList() {
        this.foxySessionData.setAction(LST);
        this.foxySessionData.setBackToList(true);
        return ("BackToList");
    }
    

    //Page flow method call
    //Action method to link to image update page
    public String uploadImage() {
        this.foxySessionData.setOrderId(this.foxySessionData.getPageParameter());
        return ("uploadimage");
    }

    //Page flow method call
    //Action method to link to Order Confirmation Form filtering and download page
    public String downloadOrderConfirmationForm() {
        this.foxySessionData.setOrderId(this.foxySessionData.getPageParameter());
        return ("downloadOrderConfirmationForm");
    }

    //Page flow method call
    /**
     * Action method to link to New order screen with reference to selected
     * order id used to copy order info from existing order no selected
     *
     * @return
     */
    public String duplicateNewOrderForm() {
        this.foxySessionData.setOrderId(this.foxySessionData.getPageParameter());
        this.foxySessionData.setAction(ADD);
        return ("duplicateNewOrderForm");
    }
    
    /**
     * Action method to link to New order screen with reference to selected
     * order id used to copy order info from existing order no selected
     *
     * @return
     */
    public String orderIdTransferForm() {
        this.foxySessionData.setOrderId(this.foxySessionData.getPageParameter());
        this.foxySessionData.setAction(UPD);
        return ("OrderIdTransferForm");
    }
    
    //PROPERTY: searchTypes
    public List getSearchTypes() {
        return this.searchTypes;
    }

    public void setSearchTypes(List newValue) {
        this.searchTypes = newValue;
    }
}
