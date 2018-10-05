/*
 * FoxyFileUploadPage.java
 *
 * Created on June 20, 2006, 6:18 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */
package com.foxy.page;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileFilter;
import java.io.IOException;
import java.io.InputStream;
import java.io.Serializable;
import java.util.MissingResourceException;
import java.util.ResourceBundle;
import java.util.Locale;
import java.util.regex.Pattern;
import org.apache.myfaces.custom.fileupload.UploadedFile;
import javax.faces.application.FacesMessage;
import com.foxy.db.HibernateUtil;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.Query;
import javax.media.jai.JAI;
import javax.media.jai.RenderedOp;
import javax.media.jai.Interpolation;
import java.awt.image.renderable.ParameterBlock;
import com.sun.media.jai.codec.FileSeekableStream;

public class FoxyFileUploadPage extends Page implements Serializable {

    private static String MENU_CODE = "FOXY";
    private UploadedFile upFiledObj;
    private ResourceBundle foxyParam = null;
    private String ordId = null;

    //Class constructor
    public FoxyFileUploadPage() {
        super("FileUploadForm");
        this.isAuthorize(MENU_CODE);
        Locale defaultEng = new Locale("en");
        //Always fixed to Eng, else path may have problems
        foxyParam = ResourceBundle.getBundle("Foxy", defaultEng);
        ordId = foxySessionData.getPageParameter();
        //ordId = "061001"; //testing
    }

    public boolean isOrdIdSet() {
        if (ordId == null) {
            return false;
        } else {
            return true;
        }
    }

    public String getOrdId() {
        return ordId;
    }

    public String getImgName() {
        return this.ordId + ".jpg";
    }

    public UploadedFile getUpFile() {
        return upFiledObj;
    }

    public void setUpFile(UploadedFile upFile) {
        upFiledObj = upFile;
    }

    private String getFoxyParam(String key) {
        String val = null;
        try {
            val = foxyParam.getString(key);
        } catch (MissingResourceException e) {
            //e.printStackTrace();
            //System.err.println("Parameter key [" + key + "] not found");
        } finally {
        }
        return val;
    }

    public boolean transferOrderId(String fromOrderId, String toOrderId) {
        String filepath = this.getFoxyParam("FileUploadPath");
        fromOrderId = filepath + File.separatorChar + fromOrderId + ".jpg";
        toOrderId = filepath + File.separatorChar + toOrderId + ".jpg";
        File fromFile = new File(fromOrderId);
        File toFile = new File(toOrderId);
        
        try {
            if (fromFile.exists()){
                fromFile.renameTo(toFile);
                System.out.println("TransferOrderID: Rename from " + fromOrderId + " to " + toOrderId);
            }else{
                //File not exist, ie: Not uploaded yet (don't do anything
                System.out.println("TransferOrderID: No File to Rename from " + fromOrderId + " to " + toOrderId);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            FacesMessage fmsg = new FacesMessage(FacesMessage.SEVERITY_ERROR, e.getCause().toString(), e.getMessage());
            ctx.addMessage(null, fmsg);
        } finally {
        }


        return true;
    }

    public String upload() throws IOException {
        int BUFFER_SIZE = 128;
        int outHeight = 200;
        int outWidth = 180;
        BufferedOutputStream os = null;
        FileSeekableStream imgStream = null;   //Do  not use fileload to avoid file locking in windows especially
        InputStream in = null;
        String filename = null;  //File name to keep for imtermediate file
        String ofilename = null;
        String filepath = null;
        String imgH = null;
        String imgW = null;
        int maxSize = 0;


        String str = this.getFoxyParam("ImageFileMaxSizeBytes");
        if (str != null) {
            maxSize = Integer.parseInt(str);
            if (upFiledObj.getSize() > maxSize) {
                String str1 = "File too big, Max file size allow is [" + maxSize + "] bytes";
                String str2 = "File uploaded has size [" + upFiledObj.getSize() + "] bytes";
                FacesMessage fmsg = new FacesMessage(FacesMessage.SEVERITY_ERROR, str1, str2);
                ctx.addMessage(null, fmsg);
                return null;
            }
        }

        str = upFiledObj.getContentType();
        //System.err.println(str + Pattern.matches("image/.*", str));
        if (Pattern.matches("image/.*", str) == false) {
            String str1 = "File format not supported, only images [gif,jpg,jpeg,bmp,png] file supported";
            String str2 = "File uploaded in format for [" + upFiledObj.getContentType() + "]";
            FacesMessage fmsg = new FacesMessage(FacesMessage.SEVERITY_ERROR, str1, str2);
            ctx.addMessage(null, fmsg);
            return null;
        }


        this.ectx.getApplicationMap().put("fileupload_bytes", upFiledObj.getBytes());
        this.ectx.getApplicationMap().put("fileupload_type", upFiledObj.getContentType());
        this.ectx.getApplicationMap().put("fileupload_name", upFiledObj.getName());



        //System.err.println("File size = " + upFiledObj.getSize());
        //System.err.println("File Name = " + upFiledObj.getName());
        //System.err.println("Content type = " + upFiledObj.getContentType());



        filepath = this.getFoxyParam("FileUploadPath");
        imgH = this.getFoxyParam("ImageFileHeightPixel");
        imgW = this.getFoxyParam("ImageFileWidthPixel");




        //Only take value from properties file if both parameter have value
        if (imgH != null && imgW != null) {
            outHeight = Integer.parseInt(imgH);
            outWidth = Integer.parseInt(imgW);
        }

        if (this.ordId == null) {
            System.err.println("Error uploading file, Order Id = Null");
            return "failed";
        }

        try {
            File dir = new File(filepath);
            // This filter only returns directories
            FileFilter fileFilter = new FileFilter() {
                @Override
                public boolean accept(File file) {
                    if (file.isFile()) {
                        //Expecting refno from session PageParameter
                        return Pattern.matches(ordId + ".*", file.getName());
                    } else {
                        return false;
                    }
                }
            };

            File[] files = dir.listFiles(fileFilter);

            if (files == null) {
                // Either dir does not exist or is not a directory
            } else {
                for (int i = 0; i < files.length; i++) {
                    // Get filename of file or directory
                    System.err.println("==>File found [" + i + "] = " + files[i]);
                    files[i].delete();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            FacesMessage fmsg = new FacesMessage(FacesMessage.SEVERITY_ERROR, e.getCause().toString(), e.getMessage());
            ctx.addMessage(null, fmsg);
        } finally {
        }

        // Here we save the uploaded file
        try {
            in = new BufferedInputStream(upFiledObj.getInputStream());
            filename = filepath + File.separatorChar + this.ordId + ".tmp";

            //System.err.println("Path config from properties = " + filename);
            os = new BufferedOutputStream(new FileOutputStream(filename));

            byte[] data = new byte[BUFFER_SIZE];
            int readSize;
            while ((readSize = in.read(data, 0, BUFFER_SIZE)) != -1) {
                os.write(data, 0, readSize);
            }

        } catch (IOException e) {
            e.printStackTrace();
            FacesMessage fmsg = new FacesMessage(FacesMessage.SEVERITY_ERROR, e.getCause().toString(), e.getMessage());
            ctx.addMessage(null, fmsg);
        } finally {
            in.close();
            os.close();
        }


        this.ectx.getApplicationMap().put("savedfilename", this.ordId + ".jpg");


        //System.err.println("Creating JAI obj");
        /* Create an operator to decode the image file. */
        //RenderedOp image1 = JAI.create("stream", stream);
        RenderedOp image1 = null;
        try {
            imgStream = new FileSeekableStream(filename);
            image1 = JAI.create("stream", imgStream); //use stream instead of fileload to avoid locking
        } catch (Exception e) {
            e.printStackTrace();
            image1 = null;
            FacesMessage fmsg = new FacesMessage(FacesMessage.SEVERITY_ERROR, e.getCause().toString(), e.getMessage());
            ctx.addMessage(null, fmsg);
        } finally {
        }


        if (image1 == null) {
            FacesMessage fmsg = new FacesMessage(FacesMessage.SEVERITY_ERROR, "Failed to read file as images",
                    "Incorrect/file format not supported");
            ctx.addMessage(null, fmsg);
            return null;
        }

        //System.err.println("Created JAI obj");
        RenderedOp image2 = null;
        try {
            int h1 = image1.getHeight();
            int w1 = image1.getWidth();
            //System.err.println("Org Image H=[" + h1 + "] w = [" + w1 + "]");

            Interpolation interp = Interpolation.getInstance(Interpolation.INTERP_BILINEAR);
            float xscal = (float) outWidth / image1.getWidth();
            float yscal = (float) outHeight / image1.getHeight();
            //System.err.println("scaling at  X=[" + xscal + "] Y = [" + yscal + "]");
            ParameterBlock params = new ParameterBlock();
            params.addSource(image1);
            params.add(xscal);         // x scale factor
            params.add(yscal);         // y scale factor
            params.add(0.0F);         // x translate
            params.add(0.0F);         // y translate
            params.add(interp);       // interpolation method

            /* Create an operator to scale image1. */
            image2 = JAI.create("scale", params);

            /* Get the width and height of image2. */
            int width = image2.getWidth();
            int height = image2.getHeight();

            //System.err.println("AFT SCALE Image H=[" + height + "] w = [" + width + "]");
            //System.err.println("Out file created ...");
            String otype = "JPEG";
            ofilename = this.ordId + ".jpg";
            String outfile = filepath + File.separatorChar + ofilename;
            JAI.create("filestore", image2, outfile, otype, null);
            outfile = null; //release the reference to the file
            //System.err.println("Aft Out file write ...");
        } catch (Exception e) {
            e.printStackTrace();
            image2 = null;
            FacesMessage fmsg = new FacesMessage(FacesMessage.SEVERITY_ERROR, e.getCause().toString(), e.getMessage());
            ctx.addMessage(null, fmsg);
        } finally {
            imgStream.close();
            image1.dispose();
            image2.dispose();
            image1 = null;
            image2 = null;
            System.gc(); //required to ensure output file from "filestore" been close, else will be lock in window only
            //this is a bug been fix in JAI release later
        }

        //Delete the temp file now
        try {
            File tmpfile = new File(filename);
            tmpfile.delete();
        } catch (SecurityException e) {
            e.printStackTrace();
            FacesMessage fmsg = new FacesMessage(FacesMessage.SEVERITY_ERROR, e.getCause().toString(), e.getMessage());
            ctx.addMessage(null, fmsg);
        } finally {
        }


        // Here we have saved the uploaded file, now update filename into database
        try {
            Session session = (Session) HibernateUtil.currentSession();
            Transaction tx = session.beginTransaction();
            String qstr = "UPDATE Orders ord SET  ";
            qstr = qstr.concat("ord.imgFile = :pimgFile ");
            qstr = qstr.concat("WHERE ord.orderId = :pordId ");

            Query q = session.createQuery(qstr);
            q.setString("pimgFile", ofilename);
            q.setString("pordId", this.ordId);
            q.executeUpdate();
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

        return "SUCCESS";
    }
}
