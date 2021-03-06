/*
 * jasperReportPage.java
 *
 * Created on 9 December 2004, 17:22
 * Copyright Jonathan Buckland
 */
package com.foxy.page;

import javax.faces.*;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.File;
import java.util.HashMap;
import java.util.Map;
import javax.faces.context.FacesContext;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletRequest;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRExporterParameter;
import net.sf.jasperreports.engine.JasperPrint;

import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.export.JRHtmlExporter;
import net.sf.jasperreports.engine.export.JRHtmlExporterParameter;
import net.sf.jasperreports.engine.export.JRXlsExporter;
import net.sf.jasperreports.engine.export.JRXlsExporterParameter;
import  com.foxy.util.jasperRunner;




public class jasperReportPage {
    //String jasperfilepath = "/home/hcting/jasperreports";
    String jasperfilepath = "C:/apollo/testing/FoxyApp/jasperreports";
    public jasperReportPage() {
        // <editor-fold defaultstate="collapsed" desc="Creator-managed Component Initialization">
        try {
        } catch (Exception e) {
            throw e instanceof javax.faces.FacesException ? (FacesException) e: new FacesException(e);
        }
        // </editor-fold>
        // Additional user provided initialization code
    }
    
    
    
    public String actionGetUserPdfReport() {
        // User event code here...
        Map parameters = new HashMap();
        //String jasperfile = "/home/hcting/jasperreports/user.jasper";
        String jasperfile = this.jasperfilepath + File.separatorChar + "user.jasper";
        runPdfReport(jasperfile,"outputfilename",parameters);
        return null;
    }
    
    public String actionGetOrdersPdfReport() {
        // User event code here...
        Map parameters = new HashMap();
        //String jasperfile = "/home/hcting/jasperreports/orders.jasper";
        String jasperfile = this.jasperfilepath + File.separatorChar + "orders.jasper";
        runPdfReport(jasperfile,"outputfilename",parameters);
        return null;
    }
    
    public String actionGetOrdersXlsReport() {
        // User event code here...
        Map parameters = new HashMap();
        //String jasperfile = "/home/hcting/jasperreports/orders.jasper";
        String jasperfile = this.jasperfilepath + File.separatorChar + "orders.jasper";
        runXlsReport(jasperfile,"outputfilename",parameters);
        return null;
    }
    
    
    void runPdfReport(String report, String filename, Map parameters) {
        
        parameters.put("TESTVAR", new Integer(2));
        //SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        //parameters.put("DATE", new String(format.format(dt1)));
        
        
        jasperRunner mr = new jasperRunner();
        JasperPrint reportout =null;
        try{
            reportout = mr.makereport(parameters,report);
        }catch (Exception sqlex){
            sqlex.printStackTrace();
            reportout=null;
        }
        
        mr=null;
        
        byte[] pdf =null;
        
        try {
            //pdf = net.sf.jasperreports.engine.JasperManager.printReportToPdf(reportout); DEPRECATED
            pdf = JasperExportManager.exportReportToPdf(reportout);
        } catch (JRException ex3) {
            ex3.printStackTrace();
        }
        
        FacesContext faces = javax.faces.context.FacesContext.getCurrentInstance();
        HttpServletResponse response =(HttpServletResponse)faces.getExternalContext().getResponse();
        
        response.setContentType("application/pdf");
        response.setContentLength(pdf.length);
        response.setHeader("Pragma","no-cache"); //HTTP 1.0
        response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
        response.setDateHeader("Expires", 0); //prevents caching at the proxy server
        response.setHeader("Cache-Control", "private"); // HTTP 1.1
        response.setHeader("Cache-Control", "no-store"); // HTTP 1.1
        response.setHeader("Cache-Control", "max-stale=0"); // HTTP 1.1
        //response.setHeader("Content-disposition","inline; filename=\"MyPdf.pdf\"");
        response.setHeader("Content-disposition","attachment; filename=\""+filename+".pdf\"");
        ServletOutputStream out;
        try{
            out = response.getOutputStream();
            out.write(pdf);
        }catch (IOException qw){
            qw.printStackTrace();
        }
        
        faces.responseComplete();
    }
    
    
    void runXlsReport(String report, String filename, Map parameters) {
        
        parameters.put("TESTVAR", new Integer(2));
        //SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        //parameters.put("DATE", new String(format.format(dt1)));
        
        
        jasperRunner mr = new jasperRunner();
        JasperPrint reportout =null;
        try{
            reportout = mr.makereport(parameters,report);
        }catch (Exception sqlex){
            sqlex.printStackTrace();
            reportout=null;
        }
        
        mr=null;
        
        ByteArrayOutputStream xls = new ByteArrayOutputStream();
        try {
            //pdf = net.sf.jasperreports.engine.JasperManager.printReportToPdf(reportout); DEPRECATED
            //xls = JasperExportManager.
            JRXlsExporter exportXLS = new JRXlsExporter();
            //reportout.r
            exportXLS.setParameter(JRXlsExporterParameter.JASPER_PRINT, reportout);
            exportXLS.setParameter(JRXlsExporterParameter.OUTPUT_STREAM, xls);
            exportXLS.setParameter(JRXlsExporterParameter.IS_ONE_PAGE_PER_SHEET, Boolean.FALSE);
            exportXLS.setParameter(JRXlsExporterParameter.IS_DETECT_CELL_TYPE, Boolean.TRUE);
            exportXLS.setParameter(JRXlsExporterParameter.IS_WHITE_PAGE_BACKGROUND, Boolean.FALSE);
            exportXLS.setParameter(JRXlsExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS, Boolean.TRUE);
            exportXLS.setParameter(JRXlsExporterParameter.IS_FONT_SIZE_FIX_ENABLED, Boolean.TRUE);
            //exportXLS.setParameter(JRXlsExporterParameter., Boolean.TRUE);
            exportXLS.exportReport();//this will export report into xls as byte array
        } catch (JRException ex3) {
            ex3.printStackTrace();
        }
        
        FacesContext faces = javax.faces.context.FacesContext.getCurrentInstance();
        HttpServletResponse response =(HttpServletResponse)faces.getExternalContext().getResponse();
        
        response.setContentType("application/xls");
        response.setContentLength(xls.size());
        response.setHeader("Pragma","no-cache"); //HTTP 1.0
        response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
        response.setDateHeader("Expires", 0); //prevents caching at the proxy server
        response.setHeader("Cache-Control", "private"); // HTTP 1.1
        response.setHeader("Cache-Control", "no-store"); // HTTP 1.1
        response.setHeader("Cache-Control", "max-stale=0"); // HTTP 1.1
        //response.setHeader("Content-disposition","inline; filename=\"MyPdf.pdf\"");
        response.setHeader("Content-disposition","attachment; filename=\""+filename+".xls\"");
        ServletOutputStream out;
        try{
            out = response.getOutputStream();
            out.write(xls.toByteArray());
        }catch (IOException qw){
            qw.printStackTrace();
        }
        
        faces.responseComplete();
    }
    
    
    public String actionGetUserHtmlReport() {
        // User event code here...
        Map parameters = new HashMap();
        String jasperfile = this.jasperfilepath + File.separatorChar + "user.jasper";
        runHtmlReport(jasperfile,"outputfilename",parameters);
        return null;
    }
    
    
    void runHtmlReport(String report, String filename, Map parameters) {
        
        parameters.put("TESTVAR", new Integer(2));
        //SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        //parameters.put("DATE", new String(format.format(dt1)));
        
        
        jasperRunner mr = new jasperRunner();
        JasperPrint reportout =null;
        try{
            reportout = mr.makereport(parameters,report);
        }catch (Exception sqlex){
            sqlex.printStackTrace();
            reportout=null;
        }
        
        FacesContext faces = javax.faces.context.FacesContext.getCurrentInstance();
        HttpServletResponse response =(HttpServletResponse)faces.getExternalContext().getResponse();
        HttpServletRequest  resquest =(HttpServletRequest)faces.getExternalContext().getRequest();
        response.setContentType("text/html");
        response.setHeader("Pragma","no-cache"); //HTTP 1.0
        response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
        response.setDateHeader("Expires", 0); //prevents caching at the proxy server
        response.setHeader("Cache-Control", "private"); // HTTP 1.1
        response.setHeader("Cache-Control", "no-store"); // HTTP 1.1
        response.setHeader("Cache-Control", "max-stale=0"); // HTTP 1.1
        
        //response.setContentLength(pdf.length);
        //response.setHeader("Content-disposition","attachment; filename=\""+filename+".html\"");
        response.setHeader("Content-disposition", "filename=\""+filename+".html\"");
        
        
        try {
            JRHtmlExporter htmlexpt = new  JRHtmlExporter();
            htmlexpt.setParameter(JRExporterParameter.JASPER_PRINT, reportout);
            try {
                htmlexpt.setParameter(JRExporterParameter.OUTPUT_WRITER, response.getWriter());
            } catch (IOException ex) {
                ex.printStackTrace();
            }
            Map imagesMap = new HashMap();
            resquest.getSession().setAttribute("IMAGES_MAP", imagesMap);
            htmlexpt.setParameter(JRHtmlExporterParameter.IMAGES_MAP, imagesMap);
            htmlexpt.setParameter(JRHtmlExporterParameter.IMAGES_URI, "app/JasperImageServlet?image=");
            htmlexpt.exportReport();
        } catch (JRException ex3) {
            ex3.printStackTrace();
        } finally {
            faces.responseComplete();
        }
    }
}
