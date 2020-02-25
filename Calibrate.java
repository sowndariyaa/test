/* Developed By Balaji.K (SAP ABAP) Emp No:5997
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author AV-IT-PC345
 */
public class Calibrate extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        /* TODO output your page here. You may use following sample code. */
        try {
            
                String saveFile = "";
        String contentType = request.getContentType();
        if ((contentType != null) && (contentType.indexOf("multipart/form-data") >= 0)) {
            DataInputStream in = new DataInputStream(request.getInputStream());
            int formDataLength = request.getContentLength();

            byte dataBytes[] = new byte[formDataLength];
            int byteRead = 0;
            int totalBytesRead = 0;
            while (totalBytesRead < formDataLength) {
                byteRead = in.read(dataBytes, totalBytesRead, formDataLength);
                totalBytesRead += byteRead;
            }
            String file = new String(dataBytes);
            saveFile = file.substring(file.indexOf("filename=\"") + 10);
            saveFile = saveFile.substring(0, saveFile.indexOf("\n"));
            saveFile = saveFile.substring(saveFile.lastIndexOf("\\") + 1, saveFile.indexOf("\""));
            int lastIndex = contentType.lastIndexOf("=");
            String boundary = contentType.substring(lastIndex + 1, contentType.length());
            int pos;
            

            if (saveFile.equals("") || saveFile == "") {
                response.setContentType("text/html");
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Not Update  ! ');");
                out.write("setTimeout(function(){window.location.href='home.jsp'},1)");
                out.println("</script>");
            }
//out.print(saveFile);
            pos = file.indexOf("filename=\"");
            pos = file.indexOf("\n", pos) + 1;
            pos = file.indexOf("\n", pos) + 1;
            pos = file.indexOf("\n", pos) + 1;
            int boundaryLocation = file.indexOf(boundary, pos) - 4;
            int startPos = ((file.substring(0, pos)).getBytes()).length;
            int endPos = ((file.substring(0, boundaryLocation)).getBytes()).length;
            File ff = new File(saveFile);
//            out.print(ff);
            FileOutputStream fileOut = new FileOutputStream(ff);
            fileOut.write(dataBytes, startPos, (endPos - startPos));
            fileOut.flush();
            fileOut.close();
            
            
            
            
            

            HttpSession session = request.getSession(true);
            String username = session.getAttribute("username").toString();
            session.setAttribute("username", username);
            RequestDispatcher rd = null;
            int flag = 0;
//            String path = "//10.44.1.150/temp_data/Cable Calibration Daily Update/";
//            String path = "//10.44.50.150/temp_data/cable calibration/";
//            String file = request.getParameter("file");
//            String update = "";

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String date = sdf.format(new Date());

            String Plant = request.getParameter("Plant");
            String Ins_cat = request.getParameter("Ins_cat");
            String Name_of_ins = request.getParameter("Name_of_ins");
            String Iden_no = request.getParameter("Iden_no");
            String Cus_name = request.getParameter("Cus_name");
            String Cus_id_no = request.getParameter("Cus_id_no");
            String Make = request.getParameter("Make");
            String Mod_no = request.getParameter("Mod_no");
            String S_no = request.getParameter("S_no");
            String Range_in_degc = request.getParameter("Range_in_degc");
            String Least_Count = request.getParameter("Least_Count");
            String Accuracy = request.getParameter("Accuracy");
            String Calib_frq = request.getParameter("Calib_frq");
            String Docalib = request.getParameter("Docalib");
            String Due_docalib = request.getParameter("Due_docalib");
            String Calib_month = request.getParameter("Calib_month");
            String Calib_due_mon = request.getParameter("Calib_due_mon");
            String Lead_Time_Days = request.getParameter("Lead_Time_Days");
            String Calib_days_alert = request.getParameter("Calib_days_alert");
            String calib_agency = request.getParameter("calib_agency");
            String Curr_cer_no = request.getParameter("Curr_cer_no");
            String Location = request.getParameter("Location");
            String His_card_ref_no = request.getParameter("His_card_ref_no");

            String STATUS = request.getParameter("Status");
//            update = path + file;
//            out.println(update);
            FileInputStream fis = new FileInputStream(ff);
            

            final String connectionURL = "jdbc:sqlserver://10.44.50.15;databaseName=AV_Cable_Calib";
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            Connection con = DriverManager.getConnection(connectionURL, "balaji_sap", "sap123");
            final Statement st = con.createStatement();
            final PreparedStatement pst = con.prepareStatement("insert into calib_mast values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");

            pst.setString(1, Plant);
            pst.setString(2, Ins_cat);
            pst.setString(3, Name_of_ins);
            pst.setString(4, Iden_no);
            pst.setString(5, Cus_name);
            pst.setString(6, Cus_id_no);
            pst.setString(7, Make);
            pst.setString(8, Mod_no);
            pst.setString(9, S_no);
            pst.setString(10, Range_in_degc);
            pst.setString(11, Least_Count);
            pst.setString(12, Accuracy);
            pst.setString(13, Calib_frq);
            pst.setString(14, Docalib);
            pst.setString(15, Due_docalib);
            pst.setString(16, Calib_month);
            pst.setString(17, Calib_due_mon);
            pst.setString(18, Lead_Time_Days);
            pst.setString(19, Calib_days_alert);
            pst.setString(20, calib_agency);
            pst.setString(21, Curr_cer_no);
            pst.setString(22, Location);
            pst.setString(23, His_card_ref_no);
            pst.setString(24, STATUS);
            pst.setBinaryStream(25, fis);

            pst.executeUpdate();
            flag = 1;
            if (flag == 1) {
                String msg = "Instrument added Successfully";
                out.println("<b><font color='red'>instrument added successfully!</font></b>");
                request.setAttribute("msg", "Welcome To Index");
                rd = request.getRequestDispatcher("Report.jsp");
                rd.forward(request, response);
            } else {

                String msg = "Please verify your Data That Doesn't Added With Database";
                out.println("<b><font color='red'>Please verify your Data That Doesn't Added With Database. Try Again!</font></b>");
                rd = request.getRequestDispatcher("Calibrate.jsp");
                rd.forward(request, response);

            }
            
        }

        } catch (Exception e) {
            out.print(e);
            out.close();
        }

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
