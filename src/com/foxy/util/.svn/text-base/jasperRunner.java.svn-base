package com.foxy.util;

import java.io.ByteArrayInputStream;
import java.util.Map;
import java.sql.*;
import java.io.InputStream;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRParameter;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.fill.JRFileVirtualizer;

import net.sf.jasperreports.engine.util.JRLoader;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperExportManager;





/**
 * @author test
 * @version 1.0
 */

public class jasperRunner {
    private final String dataSrc = "java:comp/env/jdbc/mysql";
    
    JasperReport jasperReportsub[] = {null,null,null,null,null,null,null,null,null,null};
    int subReportCount=0;
    
    
    
    public JasperPrint makereport(Map params, String report) throws SQLException {
        JasperReport jasperReport = null;
        JasperPrint jasperPrint = null;
        InitialContext ctx;
        DataSource ds=null;
        Connection conn=null;
        Statement stmt=null;
        
        try{
            // Obtain a connection
            ctx = new InitialContext();
            ds = (DataSource) ctx.lookup(this.dataSrc);
            conn = ds.getConnection();
            
            // make and execute the statement
            stmt = conn.createStatement();
        }catch(Exception as){
            as.printStackTrace();
        }
        
        //This is for subreport support (some null pointer bugs)
        //Map params3 = doparams(params,jasperReport);   //(params,jasperReport);
        
        try {
            jasperReport = (JasperReport)JRLoader.loadObject(report);
        } catch (JRException ex) {
            System.out.print(ex);
        }
        
        try {
            JRFileVirtualizer vf = new JRFileVirtualizer(20, "c:\tmp");
            params.put(JRParameter.REPORT_VIRTUALIZER, vf);
            jasperPrint = JasperFillManager.fillReport(jasperReport,params,conn);
        } catch (JRException ex1) {
            ex1.printStackTrace();
            System.out.print(ex1);
        }
        // Or to view report in the JasperViewer
        
        return jasperPrint;
    }
    
    
    /** Unused method **/
    public Map doparams(Map params2, JasperReport report) throws SQLException {
        
        JRParameter returnedparams[] = report.getParameters();
        
        int i,j;
        String temp=null,temp2 = null,s=null;
        
        InitialContext ctx=null;
        DataSource ds=null;
        
        try{
            ctx = new InitialContext();
            ds = (DataSource) ctx.lookup(this.dataSrc);
        }catch(NamingException nw){
        }
        
        Connection conn = ds.getConnection();
        
        // make and execute the statement
        Statement stmt = conn.createStatement();
        
        Blob dbresult = null;
        ResultSet rs;
        
        ByteArrayInputStream ss=null;
        InputStream is=null;
        
        
        j=returnedparams.length;
        for(i=0;i<j;i++) {
            if(returnedparams[i].isForPrompting()&&returnedparams[i].getDescription()!=null ) {
                temp2 = returnedparams[i].getName();
                temp = returnedparams[i].getValueClass().toString();
                
                if(temp.equals("class net.sf.jasperreports.engine.JasperReport")) {
                    try {
                        rs = stmt.executeQuery("SELECT * FROM reports WHERE report_name='"+ returnedparams[i].getDescription() +"'");
                        if(rs.next()) {
                            dbresult = rs.getBlob("report_data");
                            is = dbresult.getBinaryStream();
                        }
                        jasperReportsub[subReportCount] = (JasperReport)JRLoader.loadObject(is);
                    } catch(Exception e3) {
                        System.out.println(e3);
                    }
                    
                    params2.put(temp2, jasperReportsub[subReportCount++]);
                }
            }
        }
        return params2;
    }
    
    /** Unused method **/
    void processreport(JasperPrint reportout, String reportname, String filenamestr) {
        byte[] jbpdf=null;
        
        try {
            jbpdf = JasperExportManager.exportReportToPdf(reportout);
        } catch (JRException ex3) {
            ex3.printStackTrace();
        }
        
    }
}