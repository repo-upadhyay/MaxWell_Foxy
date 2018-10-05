/*
 * OrderFormPageUtil.java
 *
 * Created on September 26, 2006, 12:12 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package com.foxy.util;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfPageEventHelper;
import com.itextpdf.text.pdf.PdfWriter;

/**
 *
 * @author eric
 */
public class OrderFormPageUtil extends PdfPageEventHelper {
    
    /** Creates a new instance of OrderFormPageUtil */
    public OrderFormPageUtil() {
    }
    
    @Override
    public void onEndPage(PdfWriter writer, Document document) {
        try {
            Font font10 = new Font(Font.FontFamily.HELVETICA, 10);
            Font font7 = new Font(Font.FontFamily.HELVETICA, 7);
                        
            PdfPTable footertable = new PdfPTable(3);
            Rectangle page = document.getPageSize();
            
            Rectangle noBorderRect = new Rectangle(0f, 0f);
            noBorderRect.setBorderWidthLeft(0f);
            noBorderRect.setBorderWidthBottom(0f);
            noBorderRect.setBorderWidthRight(0f);
            noBorderRect.setBorderWidthTop(0f);
            PdfPCell cell = null;
            
            int footerColWidths[] = { 35, 35, 30 };   // Column width
            footertable.setWidths(footerColWidths);
            footertable.setWidthPercentage(100); // percentage
            footertable.getDefaultCell().setBorder(0);
            footertable.getDefaultCell().setHorizontalAlignment(Element.ALIGN_LEFT);
            footertable.getDefaultCell().setVerticalAlignment(Element.ALIGN_TOP);
            
            footertable.addCell(new Phrase("Checked By : ________________", font10));
            footertable.addCell(new Phrase("Confirmed By : ________________", font10));
            footertable.addCell(new Phrase("Prepared By : ________________", font10));
            
            cell = new PdfPCell(new Phrase("Please refer to appendix for detail if any [ YES / NO ]",font7));
            cell.cloneNonPositionParameters(noBorderRect);
            cell.setColspan(3); //span across all the rest of 3 col (to force it occupy full row)
            footertable.addCell(cell);
            
            footertable.setTotalWidth(page.getWidth() - document.leftMargin() - document.rightMargin());            
            footertable.writeSelectedRows(0, -1, document.leftMargin(), document.bottomMargin() - 10, writer.getDirectContent());
        } catch (Exception e) {
            e.printStackTrace();
        }
        
    }
}
