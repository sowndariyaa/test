/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package EMAC;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author AV-IT-PC408
 */
public class edit_add_pts extends HttpServlet {

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

            String rowCount = request.getParameter("rowCount");

            String apqp_no = "", action_for = "", action_points = "", res = "", dep = "", tdate = "", rtdate = "", remark = "", status = "", id = "", partno = "";
            String action_pointsVal = "", resVal = "", depVal = "", tdateVal = "", rtdateVal = "", remarkVal = "", statusVal = "", idVal = "", partnoVal = "";

            apqp_no = request.getParameter("apqp_no");
            action_for = request.getParameter("action_for");

            int row = Integer.parseInt(rowCount);
            row = row - 0;
//            out.print("<BR>"+row);

            double m = 8;
            for (int i = 1; i <= row; i++) {

                action_points = "action" + i;
                action_pointsVal = request.getParameter(action_points);

                res = "res" + i;
                resVal = request.getParameter(res);

                dep = "dep" + i;
                depVal = request.getParameter(dep);

                tdate = "tdate" + i;
                tdateVal = request.getParameter(tdate);

                rtdate = "rdate" + i;
                rtdateVal = request.getParameter(rtdate);

                status = "status" + i;
                statusVal = request.getParameter(status);

                remark = "remark" + i;
                remarkVal = request.getParameter(remark);

                partno = "partno" + i;
                partnoVal = request.getParameter(partno);

//                out.print("<BR>" + i + " " + apqp_no + " " + action_for + " " + action_pointsVal + " " + resVal + " " + depVal + " " + tdateVal + " " + rtdateVal + " " + remarkVal + " " + status + " " + username + " " + todaydate);
                PreparedStatement ps = con.prepareStatement("insert into  apqp_actions(apqp_no,part_no,actions_for,action_points,responsibility,department,"
                        + "tdate,rtdate,remark,status,added_by,added_date) values(?,?,?,?,?,?,?,?,?,?,?,?)");
                ps.setString(1, apqp_no);
                ps.setString(2, partnoVal);
                ps.setString(3, action_for);
                ps.setString(4, action_pointsVal);
                ps.setString(5, resVal);
                ps.setString(6, depVal);
                ps.setString(7, tdateVal);
                if (rtdateVal != null && !rtdateVal.isEmpty()) {
                    ps.setString(8, rtdateVal);
                } else {
                    ps.setDate(8, null);
                }
                ps.setString(9, remarkVal);
                ps.setString(10, statusVal);
                ps.setString(11, username);
                ps.setString(12, todaydate);
                m = ps.executeUpdate();

            }
//
            if (m > 0) {
                response.setContentType("text/html");
                out.println("<script type=\"text/javascript\">");
                out.write("setTimeout(function(){window.location.href='edit_act_pts.jsp?action_for=" + action_for + "&apqp=" + apqp_no + "'},4000)");
                out.println("</script>");
                out.println("<div class='zoomInLeft'>");
                out.println("<h2>APQP " + apqp_no + " Action Point's Data Saved...</h2>");
                out.println("</div>");
            } else {
                response.setContentType("text/html");
                out.println("<script type=\"text/javascript\">");
                out.write("setTimeout(function(){window.location.href='?action_for=" + action_for + "&apqp=" + apqp_no + "'},4000)");
                out.println("</script>");
                out.println("<div class='zoomInLeft'>");
                out.println("<h2>APQP " + apqp_no + " Action Point's Data Not Saved !</h2>");
                out.println("</div>");
            }

            con.close();
        } catch (Exception e) {

            out.println("<div id='zoomInLeft'>");
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
