/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package EMAC;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 *
 * @author AV-IT-PC560
 */
@MultipartConfig(maxFileSize = 16177216)
@WebServlet(name = "edit_1", urlPatterns = {"/edit_1"})
public class edit_1 extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession(true);
        try {

            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Loading</title>");
            out.println(" <link rel=\"stylesheet\" href=\"css/load.css\" type=\"text/css\">");
            out.println("</head>");
            out.println("<body>");

            String access = (String) session.getAttribute("access");
            String team = (String) session.getAttribute("team");
            String username = (String) session.getAttribute("username");
            Database_Connection obj = new Database_Connection();
            Connection con = obj.getConnection();
            Statement st = con.createStatement();

            DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            java.util.Date today = Calendar.getInstance().getTime();
            String todaydate = df.format(today);

            String apqp_no = request.getParameter("apqp");
            String plant = request.getParameter("plants");
            double mmm = 0;
            double m = 0;
            double mm = 0;

            String apqp_meeting_date = "", initial_input = "", complete_input = "", pcb_sig = "", customer_name = "", recipt_of_testing = "", receipt_of_bom = "", receipt_of_gbr = "", receipt_of_ain = "", recipt_of_pgm_file = "", receipt_of_xy = "", customer_req_date = "", crd_remark = "", closure_meeting_date = "", affect_doc_status = "", cust_doc_update_storage = "", cust_feedback = "", resub_feedback = "", feedback_remark = "", cust_feedback_storage = "", ppap_req = "", product_category = "", prod_cat_remark = "", input_status = "", shiped_part = "", pro_qty = "", project_leader = "", prod_sold_process = "", applications = "", validation = "", status = "", remark = "", pcba_part_no = "", sig_part_no = "", cust_part_no = "", pcba_rev = "", sig_revision = "";
            String feedback_rem = "";
//           String new_apqp_no="";
//           ResultSet rs=st.executeQuery("select apqp_no from  cft_members where apqp_no='"+apqp_no+"'");
//           while(rs.next()){
//             new_apqp_no=rs.getString(1);
//           }
//            
//              if(new_apqp_no.equals(apqp_no)){
//                
//           response.setContentType("text/html");  
//                 out.println("<script type=\"text/javascript\">");  
//                 out.println("alert('Cannot be Updated!!');");  
//                 out.write("setTimeout(function(){window.location.href='edit.jsp?apqp="+apqp_no+"'},1);");
//                 out.println("</script>");
//                  
//                                               }else{

            apqp_meeting_date = request.getParameter("apqp_meet");
            initial_input = request.getParameter("cust_rec");
            complete_input = request.getParameter("comp_cust_rec");
            pcb_sig = request.getParameter("pcb");
            customer_name = request.getParameter("cust_name");
            recipt_of_testing = request.getParameter("testing");
            receipt_of_bom = request.getParameter("bom");
            receipt_of_gbr = request.getParameter("gbr");
            receipt_of_ain = request.getParameter("ain");
            recipt_of_pgm_file = request.getParameter("file");
            receipt_of_xy = request.getParameter("xy");
            customer_req_date = request.getParameter("cust_req");
            crd_remark = request.getParameter("remarks");
            closure_meeting_date = request.getParameter("meeting");
            affect_doc_status = request.getParameter("status");
            cust_doc_update_storage = request.getParameter("store_loc");
            cust_feedback = request.getParameter("feed");
            resub_feedback = request.getParameter("resub");
            feedback_remark = request.getParameter("feedrem");
            feedback_rem = request.getParameter("feedback_rem");
            cust_feedback_storage = request.getParameter("feed_sto");
            ppap_req = request.getParameter("ppap");
            product_category = request.getParameter("category");
            prod_cat_remark = request.getParameter("catrem");
            input_status = request.getParameter("input");
            shiped_part = request.getParameter("part");
            pro_qty = request.getParameter("qty");
            project_leader = request.getParameter("leader");
            prod_sold_process = request.getParameter("prod_sold");
            applications = request.getParameter("app");
            validation = request.getParameter("valid");
            status = request.getParameter("stat");
            remark = request.getParameter("remark");
            cust_part_no = request.getParameter("cust_part_no");
            pcba_rev = request.getParameter("rev");
            sig_revision = request.getParameter("sig_rev");

            String shipment_date = request.getParameter("ship_date");
            String class_prod = request.getParameter("class_prod");
            String pcb_eng = request.getParameter("pcb_eng");

            String sig_eng = request.getParameter("sig_eng");

            if (shipment_date.equals("") || shipment_date.equals("null")) {
                shipment_date = null;
            }
            if (apqp_meeting_date.equals("") || apqp_meeting_date.equals("null")) {
                apqp_meeting_date = null;
            }
            if (initial_input.equals("") || initial_input.equals("null")) {
                initial_input = null;
            }
            if (complete_input.equals("") || complete_input.equals("null")) {
                complete_input = null;
            }
            if (customer_req_date.equals("") || customer_req_date.equals("null")) {
                customer_req_date = null;
            }
            if (closure_meeting_date.equals("") || closure_meeting_date.equals("null")) {
                closure_meeting_date = null;
            }
            String fair_report = "";
            fair_report = request.getParameter("fair_report");
            PreparedStatement p = con.prepareStatement("update  apqp_eil set apqp_meeting_date=?,initial_input=?,complete_input=?,pcb_sig=?,customer_name=?,recipt_of_testing=?,receipt_of_bom=?,receipt_of_gbr=?,receipt_of_ain=?,recipt_of_pgm_file=?,receipt_of_xy=?,customer_req_date=?,crd_remark=?,closure_meeting_date=?,affect_doc_status=?,cust_doc_update_storage=?,cust_feedback=?,resub_feedback=?,feedback_remark=?,cust_feedback_storage=?,ppap_req=?,product_category=?,prod_cat_remark=?,input_status=?,shiped_part=?,pro_qty=?,project_leader=?,prod_sold_process=?,application=?,validation=?,status=?,remark=?,shipment_date=?,class_product=?,resub_feedback_remark=?,fair_report=?,pcb_engineer=?,sig_engineer=? where apqp_no='" + apqp_no + "' ");

            p.setString(1, apqp_meeting_date);
            p.setString(2, initial_input);
            p.setString(3, complete_input);
            p.setString(4, pcb_sig);
            p.setString(5, customer_name);
            p.setString(6, recipt_of_testing);
            p.setString(7, receipt_of_bom);
            p.setString(8, receipt_of_gbr);
            p.setString(9, receipt_of_ain);
            p.setString(10, recipt_of_pgm_file);
            p.setString(11, receipt_of_xy);
            p.setString(12, customer_req_date);
            p.setString(13, crd_remark);
            p.setString(14, closure_meeting_date);
            p.setString(15, affect_doc_status);
            p.setString(16, cust_doc_update_storage);
            p.setString(17, cust_feedback);
            p.setString(18, resub_feedback);
            p.setString(19, feedback_remark);
            p.setString(20, cust_feedback_storage);
            p.setString(21, ppap_req);
            p.setString(22, product_category);
            p.setString(23, prod_cat_remark);
            p.setString(24, input_status);
            p.setString(25, "");
            p.setString(26, pro_qty);
            p.setString(27, project_leader);
            p.setString(28, prod_sold_process);
            p.setString(29, applications);
            p.setString(30, validation);
            p.setString(31, status);
            p.setString(32, remark);
            p.setString(33, shipment_date);
            p.setString(34, class_prod);
            p.setString(35, feedback_rem);
            p.setString(36, fair_report);
            p.setString(37, pcb_eng);
            p.setString(38, sig_eng);
            m = p.executeUpdate();
            m++;

            PreparedStatement ps = con.prepareStatement("update  apqp_master set plant=?,customer_name=?,status=? where apqp_no='" + apqp_no + "' ");

            ps.setString(1, plant);
            ps.setString(2, customer_name);
            ps.setString(3, status);
            mm = ps.executeUpdate();
            mm++;

            PreparedStatement ps1 = con.prepareStatement("update  apqp_aps set cust_part_no=?,pcba_rev=?,sig_revision=? where apqp_no='" + apqp_no + "' ");

            ps1.setString(1, cust_part_no);
            ps1.setString(2, pcba_rev);
            ps1.setString(3, sig_revision);
            mmm = ps1.executeUpdate();
            mmm++;

//            String path = "//10.44.50.150/temp_data/EMAC/";
            String path = "C://Users/AV-IT-PC560/Desktop/";
//            String basicfile = request.getParameter("basicfile");

            InputStream inputStream = null; // input stream of the upload file
            Part filePart_basicfile = null;
            filePart_basicfile = request.getPart("basicfile");

            if (filePart_basicfile != null && filePart_basicfile.getSize() != 0) {

//                String f1 = "";
//                FileInputStream fis1 = null;
//                f1 = path + basicfile;
//                fis1 = new FileInputStream(f1);
                int pdfcheck = 0;

                ResultSet r3 = st.executeQuery("select apqp_no from  apqp_basicpdf where apqp_no='" + apqp_no + "'");
                while (r3.next()) {
                    pdfcheck++;
                }
                if (pdfcheck > 0) {
                    PreparedStatement ps2 = con.prepareStatement("update  apqp_basicpdf set basic_pdf=?,added_by=?,added_date=? where apqp_no='" + apqp_no + "'");
                    inputStream = filePart_basicfile.getInputStream();
                    ps2.setBinaryStream(1, inputStream);
                    ps2.setString(2, username);
                    ps2.setString(3, todaydate);
                    m = ps2.executeUpdate();
                } else {

                    PreparedStatement ps2 = con.prepareStatement("insert into  apqp_basicpdf (apqp_no,basic_pdf,added_by,added_date) values(?,?,?,?) ");
                    inputStream = filePart_basicfile.getInputStream();
                    ps2.setString(1, apqp_no);
                    ps2.setBinaryStream(2, inputStream);
                    ps2.setString(3, username);
                    ps2.setString(4, todaydate);
                    m = ps2.executeUpdate();
                }

            } else {
                ps.setString(1, null);
            }

            if (m > 0 && mm > 0 && mmm > 0) {
                session.setAttribute("apqp", apqp_no);
                response.setContentType("text/html");
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Updated Successfully!!');");
                out.write("setTimeout(function(){window.location.href='apqp_edit.jsp?apqp=" + apqp_no + "&p=0'},1);");
                out.println("</script>");

                response.setContentType("text/html");
                out.println("<script type=\"text/javascript\">");
                out.write("setTimeout(function(){window.location.href='apqp_edit.jsp?apqp=" + apqp_no + "&p=0'},4000)");
                out.println("</script>");
                out.println("<div class='zoomInLeft'>");
                out.println("<h2>" + apqp_no + " APQP  Input's Added Successfully...</h2>");
                out.println("</div>");

            } else {

                response.setContentType("text/html");
                out.println("<script type=\"text/javascript\">");
                out.write("setTimeout(function(){window.location.href='apqp_edit.jsp?apqp=" + apqp_no + "&p=0'},4000)");
                out.println("</script>");
                out.println("<div class='zoomInLeft'>");
                out.println("<h2>" + apqp_no + " APQP  Input's Not Updated..</h2>");
                out.println("</div>");

            }
            con.close();
        } catch (Exception e) {
            out.println("<div class='zoomInLeft'>");
            out.println("<h2>Error : " + e + "</h2>");
            out.println("</div>");
        }

        out.println("</body>");
        out.println("</html>");
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
