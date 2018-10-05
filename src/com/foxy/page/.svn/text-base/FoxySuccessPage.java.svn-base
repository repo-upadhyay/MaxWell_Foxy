/*
 * FoxySuccessPage.java
 *
 * Created on June 20, 2006, 6:18 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package com.foxy.page;

import java.io.Serializable;


/**
 *
 * @author hcting
 */
public class FoxySuccessPage extends Page implements Serializable{
    private static String MENU_CODE = new String("FOXY");
    private String msg = null;
    
    /** Creates a new instance of FoxySupplierPage */
    public FoxySuccessPage() {
        super(new String("SuccessPage"));
        
        try {
            this.isAuthorize(MENU_CODE);
            //System.out.println(ctx.getApplication().getViewHandler().toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
        
    }
    
    public String getMsg() {
        return msg;
    }
    
    public void setMsg(String msg) {
        this.msg = msg;
    }    
}
