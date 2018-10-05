/*
 * FoxyReportPage.java
 *
 * Created on June 20, 2006, 6:18 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */
package com.foxy.page;

import com.foxy.bean.FoxySessionData;
import com.foxy.db.Category;
import com.foxy.db.HibernateUtil;
import com.foxy.db.OrderSummary;
import com.foxy.db.Orders;
import com.foxy.util.ListData;
import com.foxy.util.OrderFormPageUtil;
import com.itextpdf.text.*;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.List;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.classic.Session;

/**
 *
 * @author eric
 */
public class FoxyReportPage extends Page implements Serializable {

    private static String MENU_CODE = "FOXY";
    private Date fromDate;
    private Date toDate;
    private Integer year;
    private Integer month;
    private String country;
    private String merchandiser;
    private String shipStat;
    private String curOrdId = null;
    private ResourceBundle foxyParam = null;

    public class descAlpha implements Comparator {

        /**
         * Compare two object. Callback for sort or TreeMap. effectively returns
         * a-b; orders descending
         *
         * @param pFirst first object a to be compared
         *
         * @param pSecond second object b to be compared
         *
         * @return +1 if a>b, 0 if a=b, -1 if a<b
         */
        public final int compare(Object pFirst, Object pSecond) {
            String str1 = (String) pFirst;
            String str2 = (String) pSecond;
            int ret = str1.compareTo(str2);

            ret = ret * -1; //reverse the order becode descending
            return ret;
        } // end compare
    };

    /**
     * Creates a new instance of FoxyReportSummary
     */
    public FoxyReportPage() {
        super("OrderReportForm");
        try {
            /*
             * Get session data
             */
            if (this.foxySessionData == null) {
                this.foxySessionData = (FoxySessionData) getBean("foxySessionData");
            }
            this.foxySessionData.setAction(SCH);
            curOrdId = this.foxySessionData.getOrderId();

            Locale defaultEng = new Locale("en");
            //Always fixed to Eng, else path may have problems
            foxyParam = ResourceBundle.getBundle("Foxy", defaultEng);

        } catch (Exception e) {
            e.printStackTrace();
        }
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

    public String OrderEntryForm() {
        HttpServletResponse resp = (HttpServletResponse) this.ectx.getResponse();
        ServletOutputStream out = null;
        PdfPCell cell = null;
        String filename = null;  //File name to keep for imtermediate file
        String filepath = null;
        TreeMap<String, Integer> sortedRmk = null;
        ListData ld = (ListData) getBean("listData");


        SimpleDateFormat fmt = new SimpleDateFormat("EEE, d MMM yyyy HH:mm:ss");
        SimpleDateFormat fmt2 = new SimpleDateFormat("dd-MMM-yyyy");
        SimpleDateFormat fmt3 = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
        SimpleDateFormat fmt4 = new SimpleDateFormat("yyyMMddHHmmss");
        Date dNow = new Date();
        Date tmpdate;

        Font font18 = new Font(Font.FontFamily.HELVETICA, 18);
        Font font14 = new Font(Font.FontFamily.HELVETICA, 14);
        Font font16 = new Font(Font.FontFamily.HELVETICA, 16);
        Font font12 = new Font(Font.FontFamily.HELVETICA, 12);
        Font font10 = new Font(Font.FontFamily.HELVETICA, 10);
        Font font8 = new Font(Font.FontFamily.HELVETICA, 8);
        Font font7 = new Font(Font.FontFamily.HELVETICA, 7);
        Font font6 = new Font(Font.FontFamily.HELVETICA, 6);

        Font tblHeader = new Font(Font.FontFamily.HELVETICA, 8);
        Font tblBody = new Font(Font.FontFamily.HELVETICA, 8);

        Rectangle border_l = new Rectangle(0f, 0f);
        //border_l.setBorderWidth(3);
        border_l.setBorderWidthLeft(1f);
        border_l.setBorderWidthBottom(0f);
        border_l.setBorderWidthRight(0f);
        border_l.setBorderWidthTop(1f);
        border_l.setBorderColor(BaseColor.GRAY);


        Rectangle border_lc = new Rectangle(0f, 0f);
        border_lc.setBorderWidthLeft(0f);
        border_lc.setBorderWidthBottom(0f);
        border_lc.setBorderWidthRight(1f);
        border_lc.setBorderWidthTop(1f);
        border_lc.setBorderColor(BaseColor.GRAY);

        Rectangle border_rc = new Rectangle(0f, 0f);
        border_rc.setBorderWidthLeft(0f);
        border_rc.setBorderWidthBottom(0f);
        border_rc.setBorderWidthRight(0f);
        border_rc.setBorderWidthTop(1f);
        border_rc.setBorderColor(BaseColor.GRAY);

        Rectangle border_r = new Rectangle(0f, 0f);
        border_r.setBorderWidthLeft(0f);
        border_r.setBorderWidthBottom(0f);
        border_r.setBorderWidthRight(1f);
        border_r.setBorderWidthTop(1f);
        border_r.setBorderColor(BaseColor.GRAY);

        Rectangle detail_r = new Rectangle(0f, 0f);
        detail_r.setBorderWidthLeft(0f);
        detail_r.setBorderWidthBottom(1f);
        detail_r.setBorderWidthRight(0f);
        detail_r.setBorderWidthTop(0f);


        //Document A4 size
        //595 x 842 pixels will give you the equivalent to an A4 (8.27" x 11.69") sheet of paper @ 72 dots-per-inch
        //(Rectangle pageSize, float marginLeft, float marginRight, float marginTop, float marginBottom)
        Document document = new Document(PageSize.A4, 36, 36, 36, 54);
        ByteArrayOutputStream baos = new ByteArrayOutputStream();

        try {
            filepath = this.getFoxyParam("FileUploadPath");
            filename = filepath + File.separatorChar + this.curOrdId + ".jpg";

            File f = new File(filename);
            if (f.exists() == false) {
                filename = filepath + File.separatorChar + "default.jpg";
            }


            Image img = Image.getInstance(filename);
            img.setBorder(1);
            img.scalePercent(50);


            PdfWriter writer = PdfWriter.getInstance(document, baos);
            writer.setPageEvent(new OrderFormPageUtil());
            document.open();

            /*
             * Content Here
             */
            PdfPTable datatable = new PdfPTable(4);     // Create table with 4 columns
            PdfPTable innertable = new PdfPTable(2);

            PdfPTable toptable = new PdfPTable(2);
            PdfPTable headertable = new PdfPTable(2);

            PdfPTable detailtable = new PdfPTable(11);
            PdfPTable remarktable = new PdfPTable(3); //Table for remarks if any
            //PdfPTable footertable = new PdfPTable(3);

            int colWidths[] = {15, 35, 15, 35};   // Column width

            int headerColWidths[] = {60, 40};   // Column width
            headertable.setWidths(headerColWidths);
            headertable.setWidthPercentage(100); // percentage
            headertable.getDefaultCell().setBorder(0);
            headertable.getDefaultCell().setHorizontalAlignment(Element.ALIGN_RIGHT);
            headertable.getDefaultCell().setVerticalAlignment(Element.ALIGN_BOTTOM);

            int topColWidths[] = {50, 50};   // Column width
            toptable.setWidths(topColWidths);
            toptable.setWidthPercentage(100); // percentage
            toptable.getDefaultCell().setBorder(0);
            toptable.getDefaultCell().setFixedHeight(100);
            toptable.getDefaultCell().setHorizontalAlignment(Element.ALIGN_LEFT);
            toptable.getDefaultCell().setVerticalAlignment(Element.ALIGN_CENTER);

            int innerColWidths[] = {30, 70};   // Column width
            innertable.setWidths(innerColWidths);
            innertable.setWidthPercentage(100); // percentage
            innertable.getDefaultCell().setBorder(0);
            innertable.getDefaultCell().setHorizontalAlignment(Element.ALIGN_LEFT);
            innertable.getDefaultCell().setVerticalAlignment(Element.ALIGN_CENTER);

            datatable.setWidths(colWidths);
            datatable.setWidthPercentage(100); // percentage
            datatable.getDefaultCell().setPadding(3);
            datatable.getDefaultCell().setBorderWidth(1);
            datatable.getDefaultCell().setBorderColor(BaseColor.GRAY);
            datatable.getDefaultCell().setHorizontalAlignment(Element.ALIGN_LEFT);
            datatable.getDefaultCell().setVerticalAlignment(Element.ALIGN_CENTER);

            int detailColWidths[] = {12, 20, 15, 15, 14, 12, 10, 10, 10, 14, 10};   // Column width
            detailtable.setWidths(detailColWidths);
            detailtable.setWidthPercentage(100); // percentage
            detailtable.getDefaultCell().setPadding(3);
            detailtable.getDefaultCell().setBorder(0);
            detailtable.getDefaultCell().setBorderWidthBottom(1);
            detailtable.getDefaultCell().setHorizontalAlignment(Element.ALIGN_LEFT);
            detailtable.getDefaultCell().setVerticalAlignment(Element.ALIGN_CENTER);


            int remarkColWidths[] = {12, 70, 18};   // Column width
            remarktable.setWidths(remarkColWidths);
            remarktable.setWidthPercentage(100); // percentage
            remarktable.getDefaultCell().setPadding(3);
            remarktable.getDefaultCell().setBorder(0);
            remarktable.getDefaultCell().setBorderWidthBottom(1);
            remarktable.getDefaultCell().setHorizontalAlignment(Element.ALIGN_LEFT);
            remarktable.getDefaultCell().setVerticalAlignment(Element.ALIGN_CENTER);

            // Get data from database
            Session session = (Session) HibernateUtil.currentSession();
            List order = session.createQuery("from Orders where orderid = '" + curOrdId + "'  AND status != 'D'").list();

            headertable.addCell(new Phrase("Order Entry Form", font12));

            String tmpDateStr = null;
            // Populate table with data
            for (int i = 0; i < order.size(); i++) {
                Orders ord = (Orders) order.get(i);

                if (ord.getUpdUsrId() == null) {
                    headertable.addCell(new Phrase("Created by " + ord.getInsUsrId() + " on " + fmt.format(ord.getInsTime()), font7));
                } else {
                    headertable.addCell(new Phrase("Last Updated by " + ord.getUpdUsrId() + " on " + fmt.format(ord.getUpdTime()), font7));
                }

                //do not pass in 0 to close hibernate session for Company Name
                String companyNameFull = ld.getCompanyNameFull(ord.getCnameCode(), 1);
                cell = new PdfPCell(new Phrase(companyNameFull, font12));

                cell.setColspan(1);
                cell.setBorder(0);
                cell.setVerticalAlignment(Element.ALIGN_BOTTOM);
                toptable.addCell(cell);

                cell = new PdfPCell(img, false); //Don't use fix to cell, else image scale would not work
                cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                cell.setVerticalAlignment(Element.ALIGN_BOTTOM);
                cell.setColspan(1);
                cell.setBorder(0);
                toptable.addCell(cell);

                //Row  1
                cell = new PdfPCell(new Phrase("Customer Code", font10));
                cell.cloneNonPositionParameters(border_l);
                datatable.addCell(cell);

                cell = new PdfPCell(new Phrase(": " + ord.getCustCode(), font10));
                cell.cloneNonPositionParameters(border_lc);
                datatable.addCell(cell);

                cell = new PdfPCell(new Phrase("Merchandiser", font10));
                cell.cloneNonPositionParameters(border_rc);
                datatable.addCell(cell);

                cell = new PdfPCell(new Phrase(": " + ord.getMerchandiser(), font10));
                cell.cloneNonPositionParameters(border_r);
                datatable.addCell(cell);

                //Row  2
                cell = new PdfPCell(new Phrase("Brand/Division", font10));
                cell.cloneNonPositionParameters(border_l);
                datatable.addCell(cell);

                cell = new PdfPCell(new Phrase(": " + ord.getCustBrand() + " / " + ord.getCustDivision(), font10));
                cell.cloneNonPositionParameters(border_lc);
                datatable.addCell(cell);


                cell = new PdfPCell(new Phrase("NEW ORDER", font10));
                cell.cloneNonPositionParameters(border_rc);
                datatable.addCell(cell);

                cell = new PdfPCell(new Phrase("/ AMENDMENT / STOCK / CANCEL", font10));
                cell.cloneNonPositionParameters(border_r);
                datatable.addCell(cell);


                //Row  3
                cell = new PdfPCell(new Phrase("Style No", font10));
                cell.cloneNonPositionParameters(border_l);
                datatable.addCell(cell);

                cell = new PdfPCell(new Phrase(": " + ord.getStyleCode(), font10));
                cell.cloneNonPositionParameters(border_lc);
                datatable.addCell(cell);

                cell = new PdfPCell(new Phrase("Unit Price", font10));
                cell.cloneNonPositionParameters(border_rc);
                datatable.addCell(cell);

                cell = new PdfPCell(new Phrase(": US$" + ord.getUnitPrice() + "/pc", font10));
                cell.cloneNonPositionParameters(border_r);
                datatable.addCell(cell);


                //Row  4
                cell = new PdfPCell(new Phrase("Our Ref #", font10));
                cell.cloneNonPositionParameters(border_l);
                datatable.addCell(cell);

                cell = new PdfPCell(new Phrase(": " + ord.getOrderId(), font10));
                cell.cloneNonPositionParameters(border_lc);
                datatable.addCell(cell);

                cell = new PdfPCell(new Phrase("Price Term", font10));
                cell.cloneNonPositionParameters(border_rc);
                datatable.addCell(cell);

                cell = new PdfPCell(new Phrase(": " + ord.getPriceTerm(), font10));
                cell.cloneNonPositionParameters(border_r);
                datatable.addCell(cell);

                //Row  5
                cell = new PdfPCell(new Phrase("Ord Date", font10));
                cell.cloneNonPositionParameters(border_l);
                datatable.addCell(cell);

                tmpdate = ord.getOrderDate();
                if (tmpdate == null) {
                    cell = new PdfPCell(new Phrase(": ", font10));
                } else {
                    cell = new PdfPCell(new Phrase(": " + fmt2.format(ord.getOrderDate()), font10));
                }
                cell.cloneNonPositionParameters(border_lc);
                datatable.addCell(cell);

                cell = new PdfPCell(new Phrase("Season", font10));
                cell.cloneNonPositionParameters(border_rc);
                datatable.addCell(cell);

                cell = new PdfPCell(new Phrase(": " + ord.getSeason(), font10));
                cell.cloneNonPositionParameters(border_r);
                datatable.addCell(cell);


                //Row  6
                cell = new PdfPCell(new Phrase("Description", font10));
                cell.cloneNonPositionParameters(border_l);
                datatable.addCell(cell);

                cell = new PdfPCell(new Phrase(": " + ord.getDescription(), font10));
                cell.cloneNonPositionParameters(border_lc);
                //cell.setColspan(3); //span across all the rest of 3 col (to force it occupy full row)
                datatable.addCell(cell);

                cell = new PdfPCell(new Phrase("Graphic Emb", font10));
                cell.cloneNonPositionParameters(border_rc);
                datatable.addCell(cell);

                //since order table keep Graphic Type code, need to use listdata to get detail/name/desc
                String graphicType = ld.getGraphicTypeDesc(ord.getGraphicTypeCode());
                cell = new PdfPCell(new Phrase(": " + graphicType, font10));
                cell.cloneNonPositionParameters(border_r);
                datatable.addCell(cell);

                //Row  7
                cell = new PdfPCell(new Phrase("Fabric Type", font10));
                cell.cloneNonPositionParameters(border_l);
                datatable.addCell(cell);

                cell = new PdfPCell(new Phrase(": " + ord.getFabricType(), font10));
                cell.cloneNonPositionParameters(border_lc);
                //cell.setColspan(3); //span across all the rest of 3 col (to force it occupy full row)
                datatable.addCell(cell);

                cell = new PdfPCell(new Phrase("Colouring", font10));
                cell.cloneNonPositionParameters(border_rc);
                datatable.addCell(cell);

                //since order table keep Graphic Type code, need to use listdata to get detail/name/desc
                String colourType = ld.getColourTypeDesc(ord.getColourTypeCode());
                cell = new PdfPCell(new Phrase(": " + colourType, font10));
                cell.cloneNonPositionParameters(border_r);
                datatable.addCell(cell);

                //Row  8
                cell = new PdfPCell(new Phrase("Fabrication", font10));
                cell.cloneNonPositionParameters(border_l);
                datatable.addCell(cell);

                cell = new PdfPCell(new Phrase(": " + ord.getFabrication(), font10));
                cell.cloneNonPositionParameters(border_lc);
                cell.setColspan(3); //span across all the rest of 3 col (to force it occupy full row)
                datatable.addCell(cell);


                //Row  9
                cell = new PdfPCell(new Phrase("Fabric Mill", font10));
                cell.cloneNonPositionParameters(border_l);
                datatable.addCell(cell);


                cell = new PdfPCell(new Phrase(": " + ord.getFabricMill(), font10));
                cell.cloneNonPositionParameters(border_lc);
                datatable.addCell(cell);


                cell = new PdfPCell(new Phrase("DailyCap/worker", font10));
                cell.cloneNonPositionParameters(border_rc);
                datatable.addCell(cell);

                if (ord.getDailyCap() != null) {
                    cell = new PdfPCell(new Phrase(": " + ord.getDailyCap() + " dz/cm", font10));
                } else {
                    cell = new PdfPCell(new Phrase(": ", font10));
                }
                cell.cloneNonPositionParameters(border_r);
                datatable.addCell(cell);


                //Row  10
                cell = new PdfPCell(new Phrase("Fabric YY/DZ", font10));
                cell.cloneNonPositionParameters(border_l);
                datatable.addCell(cell);

                cell = new PdfPCell(new Phrase(": " + ord.getFabricYyDz(), font10));
                cell.cloneNonPositionParameters(border_lc);
                datatable.addCell(cell);

                cell = new PdfPCell(new Phrase("Wash Type", font10));
                cell.cloneNonPositionParameters(border_rc);
                datatable.addCell(cell);

                cell = new PdfPCell(new Phrase(": " + ord.getWash(), font10));
                cell.cloneNonPositionParameters(border_r);
                datatable.addCell(cell);


                //Row  11
                cell = new PdfPCell(new Phrase("Fabric Price", font10));
                cell.cloneNonPositionParameters(border_l);
                datatable.addCell(cell);

                cell = new PdfPCell(new Phrase(": " + ord.getFabricPrice(), font10));
                cell.cloneNonPositionParameters(border_lc);
                datatable.addCell(cell);

                cell = new PdfPCell(new Phrase("Wash Cost", font10));
                cell.cloneNonPositionParameters(border_rc);
                datatable.addCell(cell);

                cell = new PdfPCell(new Phrase(": " + ord.getSwash(), font10));
                cell.cloneNonPositionParameters(border_r);
                datatable.addCell(cell);


                //Row  12
                cell = new PdfPCell(new Phrase("Costing CMT", font10));
                cell.cloneNonPositionParameters(border_l);
                datatable.addCell(cell);

                cell = new PdfPCell(new Phrase(": " + ord.getCostCm(), font10));
                cell.cloneNonPositionParameters(border_lc);
                datatable.addCell(cell);

                cell = new PdfPCell(new Phrase("Costing Basic Trim", font10));
                cell.cloneNonPositionParameters(border_rc);
                datatable.addCell(cell);

                cell = new PdfPCell(new Phrase(": " + ord.getDoubleStrValue(ord.getCostBasicTrim()), font10));
                cell.cloneNonPositionParameters(border_r);
                datatable.addCell(cell);


                //Row 13
                cell = new PdfPCell(new Phrase("Costing Add Trim", font10));
                cell.cloneNonPositionParameters(border_l);
                datatable.addCell(cell);

                cell = new PdfPCell(new Phrase(":" + ord.getDoubleStrValue(ord.getCostAddTrim()), font10));
                cell.cloneNonPositionParameters(border_lc);
                datatable.addCell(cell);

                cell = new PdfPCell(new Phrase("Graphic/EMB Cost", font10));
                cell.cloneNonPositionParameters(border_rc);
                datatable.addCell(cell);

                cell = new PdfPCell(new Phrase(": " + ord.getGcost(), font10));
                cell.cloneNonPositionParameters(border_r);
                datatable.addCell(cell);


                //Row  14
                cell = new PdfPCell(new Phrase("Factory CMT", font10));
                cell.cloneNonPositionParameters(border_l);
                datatable.addCell(cell);

                cell = new PdfPCell(new Phrase(": " + ord.getFtyCm(), font10));
                cell.cloneNonPositionParameters(border_lc);
                datatable.addCell(cell);

                cell = new PdfPCell(new Phrase("Factory Trim", font10));
                cell.cloneNonPositionParameters(border_rc);
                datatable.addCell(cell);

                cell = new PdfPCell(new Phrase(":" + ord.getDoubleStrValue(ord.getFtyTrim()), font10));
                cell.cloneNonPositionParameters(border_r);
                datatable.addCell(cell);

                //Row 15
                cell = new PdfPCell(new Phrase("Actual Output", font10));
                cell.cloneNonPositionParameters(border_l);
                datatable.addCell(cell);

                if (ord.getActualOutput() != null) {
                    cell = new PdfPCell(new Phrase(": " + ord.getDoubleStrValue(ord.getActualOutput()) + "/cm", font10));
                } else {
                    cell = new PdfPCell(new Phrase(":", font10));
                }
                cell.cloneNonPositionParameters(border_lc);
                datatable.addCell(cell);

                cell = new PdfPCell(new Phrase("Actual CMT", font10));
                cell.cloneNonPositionParameters(border_rc);
                datatable.addCell(cell);

                cell = new PdfPCell(new Phrase(":" + ord.getDoubleStrValue(ord.getActualCm()), font10));
                cell.cloneNonPositionParameters(border_r);
                datatable.addCell(cell);

                //Row 16
                cell = new PdfPCell(new Phrase("Actual Trim", font10));
                cell.cloneNonPositionParameters(border_l);
                datatable.addCell(cell);

                cell = new PdfPCell(new Phrase(": " + ord.getDoubleStrValue(ord.getActualTrim()), font10));
                cell.cloneNonPositionParameters(border_lc);
                datatable.addCell(cell);

                cell = new PdfPCell(new Phrase("", font10));
                cell.cloneNonPositionParameters(border_rc);
                datatable.addCell(cell);

                cell = new PdfPCell(new Phrase("", font10));
                cell.cloneNonPositionParameters(border_r);
                datatable.addCell(cell);

                border_l.setBorderWidthBottom(1f);
                border_lc.setBorderWidthBottom(1f);
                border_rc.setBorderWidthBottom(1f);
                border_r.setBorderWidthBottom(1f);

                //Row 14
                cell = new PdfPCell(new Phrase("Remark", font10));
                cell.cloneNonPositionParameters(border_l);
                datatable.addCell(cell);

                cell = new PdfPCell(new Phrase(": " + ord.getRemark(), font10));
                cell.cloneNonPositionParameters(border_lc);
                cell.setColspan(3); //span across all the rest of 3 col (to force it occupy full row)
                datatable.addCell(cell);


                cell = new PdfPCell(new Phrase("", font10));
                cell.cloneNonPositionParameters(border_rc);
                datatable.addCell(cell);

                cell = new PdfPCell(new Phrase("", font10));
                cell.cloneNonPositionParameters(border_r);
                datatable.addCell(cell);
            }

            // Get data from database
            List orders = session.createQuery("from OrderSummary where orderid = '"
                    + curOrdId + "' AND status != 'D' order by month, location").list();

            detailtable.addCell(new Phrase("SubRef #", tblHeader));
            //Right align col header
            cell = new PdfPCell(new Phrase("Quantity", tblHeader));
            cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
            cell.setPaddingRight(10f);
            cell.cloneNonPositionParameters(detail_r);
            detailtable.addCell(cell);

            detailtable.addCell(new Phrase("Delivery", tblHeader));
            detailtable.addCell(new Phrase("Fabric Date", tblHeader));
            detailtable.addCell(new Phrase("Destination", tblHeader));
            detailtable.addCell(new Phrase("Category", tblHeader));
            detailtable.addCell(new Phrase("Quota", tblHeader));
            detailtable.addCell(new Phrase("ITax", tblHeader));
            detailtable.addCell(new Phrase("Ship By", tblHeader));
            detailtable.addCell(new Phrase("Factory", tblHeader));
            detailtable.addCell(new Phrase("Method", tblHeader));

            datatable.setHeaderRows(1); // this is the end of the table header


            Category cat = null;
            String rmkStr = null;
            Boolean firstRmk = true;
            for (int i = 0; i < orders.size(); i++) {
                OrderSummary ords = (OrderSummary) orders.get(i);
                detailtable.addCell(new Phrase(ords.getMonth() + ords.getLocation(), font8));

                //Dynamic quantity column
                if ("PCS".equals(ords.getUnit())) {
                    cell = new PdfPCell(new Phrase(ords.getQtyPcsRounded() + " pcs", font8));
                } else {
                    cell = new PdfPCell(new Phrase(ords.getQtyDznRounded() + " dzn", font8));
                }
                cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                cell.setPaddingRight(10f);
                cell.cloneNonPositionParameters(detail_r);
                detailtable.addCell(cell);

                tmpdate = ords.getDelivery();
                if (tmpdate != null) {
                    detailtable.addCell(new Phrase(fmt2.format(ords.getDelivery()), font8));
                } else {
                    detailtable.addCell(new Phrase("UNKNOWN", font8));
                }
                tmpdate = ords.getFabricDeliveryDate();
                if (tmpdate != null) {
                    detailtable.addCell(new Phrase(fmt2.format(tmpdate), font8));
                } else {
                    detailtable.addCell(new Phrase(" ", font8));
                }

                detailtable.addCell(new Phrase(ld.getDestinationDesc(ords.getDestination(), 1), font8));
                cat = ld.getCategory(ords.getCatId(), 1);
                if (cat != null) {
                    detailtable.addCell(new Phrase(cat.getCategory(), font8));
                } else {
                    detailtable.addCell(new Phrase("Unkown", font8));
                }
                detailtable.addCell(new Phrase(ords.getQuota(), font8));
                detailtable.addCell(new Phrase(ords.getImportTax(), font8));
                detailtable.addCell(new Phrase(ords.getShip(), font8));
                detailtable.addCell(new Phrase(ld.getFactoryNameShort(ords.getMainFactory()), font8));
                detailtable.addCell(new Phrase(ords.getOrderMethod(), font8));

                //Add in to display remark if no empty or null
                rmkStr = ords.getRemark();
                if (rmkStr != null) {
                    if (rmkStr.length() > 0) {
                        if (firstRmk) {
                            descAlpha da = new descAlpha();
                            sortedRmk = new TreeMap(da);
                            firstRmk = false;
                            remarktable.addCell(new Phrase("SubRef#", tblHeader));
                            remarktable.addCell(new Phrase("Remark", tblHeader));
                            remarktable.addCell(new Phrase("Last Update/By", tblHeader));
                        }
                        if (ords.getUpdUsrId() == null) {
                            sortedRmk.put(fmt4.format(ords.getInsTime()), i);
                        } else {
                            sortedRmk.put(fmt4.format(ords.getUpdTime()), i);
                        }
                    }
                }
            }//End for inner loop

            if (sortedRmk != null) {
                if (sortedRmk.size() > 0) {
                    Set st = sortedRmk.entrySet();
                    Iterator it = st.iterator();
                    Integer idx = null;
                    while (it.hasNext()) {
                        Map.Entry me = (Map.Entry) it.next();
                        idx = (Integer) me.getValue();
                        OrderSummary ords = (OrderSummary) orders.get(idx);

                        remarktable.addCell(new Phrase(ords.getMonth() + ords.getLocation(), font10));
                        remarktable.addCell(new Phrase(ords.getRemark(), font8));
                        if (ords.getUpdUsrId() == null) {
                            remarktable.addCell(new Phrase(fmt3.format(ords.getInsTime()) + "/" + ords.getInsUsrId(), font7));
                        } else {
                            remarktable.addCell(new Phrase(fmt3.format(ords.getUpdTime()) + "/" + ords.getUpdUsrId(), font7));
                        }

                    }
                }
            }

            document.add(headertable);
            document.add(new Paragraph(" "));
            document.add(toptable);
            document.add(new Paragraph(" "));
            document.add(datatable);
            document.add(new Paragraph(" "));
            document.add(detailtable);
            if (firstRmk == false) {
                document.add(new Paragraph(" "));
                document.add(remarktable);
            }
            document.add(new Paragraph(" "));
            document.close();
        } catch (DocumentException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        resp.setContentType("application/pdf");
        resp.setHeader("Content-Disposition", "attachment; filename=OEF-" + curOrdId + ".pdf");
        resp.setContentLength(baos.size());

        try {
            out = resp.getOutputStream();
            baos.writeTo(out);
            out.flush();
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            HibernateUtil.closeSession();
        }
        this.ctx.responseComplete();
        return null;
    }

    public String getMonthX() {
        if (this.foxySessionData.getPageParameter() == null) {
            Date dNow = new Date();
            SimpleDateFormat fmt = new SimpleDateFormat("M");
            return (fmt.format(dNow));
        } else {
            return this.foxySessionData.getPageParameter();
        }
    }

    public String PrevMonth() {
        this.foxySessionData.setPageParameter(String.valueOf(Integer.parseInt(this.foxySessionData.getPageParameter()) - 1));
        System.out.println("!!!! " + this.foxySessionData.getPageParameter());
        return ("success");
    }

    public String NextMonth() {
        this.foxySessionData.setPageParameter(String.valueOf(Integer.parseInt(this.foxySessionData.getPageParameter()) + 1));
        System.out.println("!!!! " + this.foxySessionData.getPageParameter());
        return ("success");
    }

    public String SubmitReport() {
        System.out.println(this.getFromDate());
        System.out.println(this.getToDate());
        System.out.println(this.getCountry());
        this.foxySessionData.setAction(LST);
        return ("success");
    }

//PROPERTY: fromDate
    public String getFromDateDb() {
        SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
        System.out.println(fmt.format(this.fromDate));
        return fmt.format(this.fromDate);
    }

    public Date getFromDate() {
        return this.fromDate;
    }

    public void setFromDate(Date newValue) {
        this.fromDate = newValue;
    }

//PROPERTY: month
    public Integer getMonth() {
        return this.month;
    }

    public String getMonthD() {
        switch (this.month) {
            case 1:
                return ("January");
            case 2:
                return ("February");
            case 3:
                return ("March");
            case 4:
                return ("April");
            case 5:
                return ("May");
            case 6:
                return ("June");
            case 7:
                return ("July");
            case 8:
                return ("August");
            case 9:
                return ("September");
            case 10:
                return ("October");
            case 11:
                return ("November");
            case 12:
                return ("December");
        }
        return null;
    }

    public void setMonth(Integer newValue) {
        this.month = newValue;
    }

//PROPERTY: year
    public Integer getYear() {
        return this.year;
    }

    public void setYear(Integer newValue) {
        this.year = newValue;
    }

//PROPERTY: toDate
    public String getToDateDb() {
        SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
        System.out.println(fmt.format(this.toDate));
        return fmt.format(this.toDate);
    }

    public Date getToDate() {
        return this.toDate;
    }

    public void setToDate(Date newValue) {
        this.toDate = newValue;
    }

//PROPERTY: country
    public String getCountryName() {
        ListData ld = (ListData) getBean("listData");
        return (ld.getCountryDesc(this.getCountry(), 0));
        //return this.country;
    }

    public String getCountry() {
        return this.country;
    }

    public void setCountry(String newValue) {
        this.country = newValue;
    }

//PROPERTY: merchandiser
    public String getMerchandiserName() {
        ListData ld = (ListData) getBean("listData");
        return (ld.getMerchandiser(this.getMerchandiser()).getFullName());
        //return this.country;
    }

    public String getMerchandiser() {
        return this.merchandiser;
    }

    public void setMerchandiser(String newValue) {
        this.merchandiser = newValue;
    }

//PROPERTY: shipStat
    public String getShipStatD() {
        ListData ld = (ListData) getBean("listData");
        return (ld.getMerchandiser(this.getMerchandiser()).getFullName());
        //return this.country;
    }

    public String getShipStat() {
        return this.shipStat;
    }

    public void setShipStat(String newValue) {
        this.shipStat = newValue;
    }
}
