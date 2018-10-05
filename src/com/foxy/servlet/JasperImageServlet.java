/*
 * DisplayPicture.java
 *
 * Created on August 24, 2006, 3:38 PM
 */

package com.foxy.servlet;

import java.io.*;

import javax.servlet.*;
import javax.servlet.http.*;
import java.util.Map;

/**
 *
 * @author WINDOWS XP USER
 * @version
 */
public class JasperImageServlet extends HttpServlet {
    
    @Override
    public void service(
            HttpServletRequest request,
            HttpServletResponse response
            ) throws IOException, ServletException {
        
        
        Map imagesMap = (Map)request.getSession().getAttribute("IMAGES_MAP");
        
        if (imagesMap != null) {
            String imageName = request.getParameter("image");
            if (imageName != null) {
                byte[] imageData = (byte[])imagesMap.get(imageName);
                
                //System.err.println("Img file name = [" + imageName + "] ");
                
                response.setContentLength(imageData.length);
                ServletOutputStream ouputStream = response.getOutputStream();
                ouputStream.write(imageData, 0, imageData.length);
                ouputStream.flush();
                ouputStream.close();
            }
        }
    }
}
