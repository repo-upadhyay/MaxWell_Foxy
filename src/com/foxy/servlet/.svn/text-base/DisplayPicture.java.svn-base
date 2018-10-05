/*
 * DisplayPicture.java
 *
 * Created on August 24, 2006, 3:38 PM
 */

package com.foxy.servlet;

import java.io.*;

import javax.servlet.*;
import javax.servlet.http.*;
import java.util.ResourceBundle;
import java.util.Locale;
import java.util.MissingResourceException;
import java.io.BufferedInputStream;

/**
 *
 * @author WINDOWS XP USER
 * @version
 */
public class DisplayPicture extends HttpServlet {
    private ResourceBundle foxyParam = null;
    private String ordId = null;
    
    /** Creates a new instance of DisplayPicture */
    public DisplayPicture() {
        Locale defaultEng = new Locale("en");
        //Always fixed to Eng, else path may have problems
        foxyParam = ResourceBundle.getBundle("Foxy", defaultEng);
    }
    
    
    
    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        
    }
    
    @Override
    public void destroy() {
    }
    
    
    private String getFoxyParam(String key){
        String val = null;
        try {
            val = foxyParam.getString(key);
        } catch ( MissingResourceException e ) {
            //e.printStackTrace();
            System.err.println("Parameter key [" + key + "] not found");
        }finally {
            
        }
        return  val;
    }
    
    
    /** Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        
        this.ordId = request.getParameter("imageid");
        //System.out.println("Now displaying image with ID: " + this.ordId);
        
        String filepath = this.getFoxyParam("FileUploadPath");
        String filename = this.ordId + ".jpg"; // Filename suggested in browser Save As dialog
        String contentType = "image/jpeg"; // For dialog, try application/x-download
        String infn = filepath +  File.separatorChar + filename;
        ServletOutputStream out = null;
        
        File f  =  new File(infn);
        if ( f.exists() == false){
            filename = "default.jpg";
            infn = filepath +  File.separatorChar + filename; //recreate string
        }
        
        try {
            out = response.getOutputStream();
            
            response.setHeader("Pragma","no-cache"); //HTTP 1.0
            response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
            response.setDateHeader("Expires", 0); //prevents caching at the proxy server
            response.setHeader("Cache-Control", "private"); // HTTP 1.1
            response.setHeader("Cache-Control", "no-store"); // HTTP 1.1
            response.setHeader("Cache-Control", "max-stale=0"); // HTTP 1.1
            response.setHeader("Content-disposition", "filename=" + filename);
            response.setContentType(contentType);
            out.write(this.getImage(infn));
        } catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        }finally {
            out.close();
        }
    }
    
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }
    
    /** Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }
    
    /** Returns a short description of the servlet.
     */
    @Override
    public String getServletInfo() {
        return "Displays a picture from the database identified by a parameter IMAGEID";
    }
    
    
    private byte[] getImage(String infn) {
        byte[] data = null;
        
        try {
            BufferedInputStream input =
                    new BufferedInputStream(new FileInputStream(infn));
            int contentLength = input.available();
            data = new byte[contentLength];
            input.read(data);
            input.close();
        }catch (Exception e) {
            e.printStackTrace();
        } finally{
        }
        return data;
    }
// </editor-fold>
}
