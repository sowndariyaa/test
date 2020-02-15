<%-- 
    Document   : single_apqp_points
    Created on : 19 Mar, 2018, 10:41:24 AM
    Author     : AV-IT-PC408
--%>

<%@page import="java.util.Date"%>
<%@page import="EMAC.Database_Connection"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Engineering Management And Control</title>

        <link rel="icon" type="image/png" href="images/favicon.ico">

        <!--  <script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
              <script  src="js/index.js"></script>-->
        <!--******** SEARCH**************-->

        <script src="src/jquery.min.js"></script>

        <script src='src/jquery-customselect.js'></script>
        <link href='src/jquery-customselect.css' rel='stylesheet' />


        <link rel="stylesheet" href="css/ssty.css">
        <link rel="stylesheet" href="css/ss.css">   


    </head>
    <body>
        <div id="main">
            <header>
                <div id="logo">
                    <div id="logo_text">
                        <!-- class="logo_colour", allows you to change the colour of the text -->
                        <h1><a href="#">Avalon <span class="logo_colour">EMAC</span></a></h1>
                        <h2>Avalon Technologies Pvt Ltd</h2>
                    </div>
                </div>
                <nav id='cssmenu' >
                    <div class="logo"><a href="index.html"> </a></div>
                    <div id="head-mobile"></div>
                    <div class="button"></div>
                    <ul>
                        <li class=''><a href='home.jsp'>HOME</a></li>
                        <li><a href='#'>ADD</a>
                            <ul>
                                <li><a href='add_user.jsp'>Add User</a> </li>
                                <li><a href='add_prod.jsp'>Add Product</a> </li>
                                <li><a href='link_prod.jsp'>Link Products</a> </li>
                                <li><a href='edit_prod.jsp'>Edit Products</a> </li>

                            </ul>
                        </li>
                        <li><a href='#'>APQP</a>
                            <ul>
                                <li><a href='new_apqp.jsp'>New APQP</a> </li>
                                <li><a href='edit_apqp.jsp'>Edit APQP</a></li>


                                <li><a href='insert_single.jsp'>Add APQP</a></li>
                                <li><a href='single_edc.jsp'>Add Affected Documents</a></li>
                                <li><a href='single_act_pts.jsp'>Add Action Points</a></li>
                                <li><a href='phase.jsp'>Add Phases</a></li>
                                <li><a href='pcba_manufacture.jsp'>Add Manufacturability  </a></li>

                            </ul>
                        </li>
                        <li><a href='#'>REPORTS</a>
                            <ul>
                                <li><a href='report.jsp'>Link Product</a> </li>
                                <li><a href='apqp_rep.jsp'>APQP Report</a></li>
                                <li><a href='rev_history.jsp'>Revision History</a></li>


                            </ul>
                        </li>

                        <li><a href=''>VALIDATION</a>
                            <ul>
                                <li><a href='valid.jsp'>Validation</a> </li>        
                                <li><a href='edit_valid.jsp'>Edit Validation</a> </li>        
                            </ul>
                        </li>

                        <li><a href=''>CHANGE CONTROL</a>
                            <ul>
                                <li><a href=''>Internal Change</a> </li>        
                                <li><a href='external.jsp'>Customer Change</a></li>        
                                <li><a href=''>Temporary Deviation</a> </li>        

                            </ul>
                        </li>
                        <li><a href=''>EDIT CONTROL</a>
                            <ul>
                                <li><a href=''>Add Documents</a> </li>        
                                <li><a href='ecp_dis.jsp'>ECP&nbsp;Disposition</a></li>        
                                <li><a href=''></a> </li>    
                            </ul>
                        </li>
                        <li><a href='#'>PRODUCTS</a>
                            <ul>
                                <li><a href='#'>Product 1</a>
                                    <ul>
                                        <li><a href='#'>Sub Product</a></li>
                                        <li><a href='#'>Sub Product</a></li>
                                    </ul>
                                </li>
                                <li><a href='#'>Product 2</a>
                                    <ul>
                                        <li><a href='#'>Sub Product</a></li>
                                        <li><a href='#'>Sub Product</a></li>
                                    </ul>
                                </li>
                            </ul>
                        </li>

                        <li><a href='logout'>LOGOUT</a></li>
                    </ul>
                </nav>
            </header>
            <div id="site_content">
                <div class="content">
                    <form action="single_act_points" method="post"   name="form">

                        <%
                            try {
                                String team = (String) session.getAttribute("team");
                                String access = (String) session.getAttribute("access");
                                String username = (String) session.getAttribute("username");
                                Database_Connection obj = new Database_Connection();
                                Connection con = obj.getConnection();
                                Statement st = con.createStatement();

                                String actions_pts = "", apqp_no = "";
                                actions_pts = request.getParameter("action_for");
                                apqp_no = request.getParameter("apqp_no");

                                Statement st1 = null;
                                Statement st2 = null;
                                ResultSet rs = null;
                                ResultSet rs1 = null;
                                ResultSet rs2 = null;

                                st1 = con.createStatement();
                                st2 = con.createStatement();

//                          out.println("<br> TEST "+actions_pts);
                                //                out.println("<br>"+apqp_no);

                        %>


                        <input type="hidden" name="apqp_no" id="apqp_no" value="<%=apqp_no%>">
                        <input type="hidden" name="action_for" id="action_for" value="<%=actions_pts%>">


                        <a href="new_cft.jsp?apqp_no=<%=apqp_no%>&action_for=<%=actions_pts%>"><input type="button" value="CFT Members" /></a> 

                        <%

                            Date closure_meeting_date = null;
                            Date apqp_meeting_date = null;
                            String pcba_part_no = "", sig_part_no = "", pcb_sig = "";
                            String pcb_prod_name = "", sig_prod_name = "";
                            rs = st.executeQuery("select a.apqp_meeting_date,a.closure_meeting_date,a.pcb_sig,b.pcba_part_no,b.sig_part_no from AV_EMAC.DBO.apqp_eil as a join AV_EMAC.DBO.apqp_aps as b on a.apqp_no=b.apqp_no where a.apqp_no='" + apqp_no + "'");
                            while (rs.next()) {
                                apqp_meeting_date = rs.getDate(1);
                                closure_meeting_date = rs.getDate(2);
                                pcb_sig = rs.getString(3);
                                pcba_part_no = rs.getString(4);
                                sig_part_no = rs.getString(5);

                                rs1 = st1.executeQuery("select prod_name from  AV_EMAC.DBO.product_master_pcb where part_no='" + rs.getString(4) + "'");
                                while (rs1.next()) {
                                    pcb_prod_name = rs1.getString(1);
                                }

                                rs2 = st2.executeQuery("select prod_name from  AV_EMAC.DBO.product_master_sig where part_no='" + rs.getString(5) + "'");
                                while (rs2.next()) {
                                    sig_prod_name = rs2.getString(1);
                                }

                            }
                            //                out.println("<br>"+apqp_meeting_date);
                            //                out.println("<br>"+closure_meeting_date);
                            //                out.println("<br>"+pcba_part_no);
                            //                out.println("<br>"+sig_part_no);
                            //                out.println("<br>"+pcb_prod_name);
                            //                out.println("<br>"+sig_prod_name);
                            //                out.println("<br>"+pcb_sig);

                        %>





                        <table id="dataTable"   >
                            <input type="hidden" value="<%=actions_pts%>" name="action_for"/>
                            <tr><th colspan="9"><center> <%=actions_pts%> Action Points</center></th></tr>
                                <%if (pcb_sig.equals("PCB")) {%>
                            <tr>
                                <th colspan="3">PCB Product  No:</th><td colspan="2"><%=pcba_part_no%></td><th >PCB Product Name:</th><td colspan="3"><%=pcb_prod_name%></td> 
                            </tr>
                            <%} else if (pcb_sig.equals("SIG")) {%>
                            <tr>
                                <th colspan="3">SIG Product  No:</th><td colspan="2"><%=sig_part_no%></td><th > SIG Product Name:</th><td colspan="3"><%=sig_prod_name%></td> 
                            </tr>
                            <%} else {%>
                            <tr>
                                <th colspan="3">PCB Product  No:</th><td colspan="2"><%=pcba_part_no%></td><th >PCB Product Name:</th><td colspan="3"><%=pcb_prod_name%></td> 
                            </tr>
                            <tr>
                                <th colspan="3">SIG Product  No:</th><td colspan="2"><%=sig_part_no%></td><th > SIG Product Name:</th><td colspan="3"><%=sig_prod_name%></td> 
                            </tr>




                            <%}%>

                            <%
                                out.print(actions_pts);
                            %>
                            <tr>
                                <th colspan="2">APQP Number</th><td colspan="2"><%=apqp_no%></td>
                                    <%if (actions_pts.equals("Initial") || actions_pts.equals("Post APQP")) {%>
                                <th >Date:</th><td colspan="4"><%=apqp_meeting_date%>
                                    <%} else {%>
                                <th >Closure Date:</th><td colspan="4"><%=closure_meeting_date%>
                                    <%}%>
                                </td> 
                            </tr>  

                            <input type="hidden" name="pcb_part_no" id="pcb_part_no" value="<%=pcba_part_no%>">
                            <input type="hidden" name="pcb_product_name" id="pcb_product_name"value="<%=pcb_prod_name%>">
                            <input type="hidden" name="sig_part_no" id="sig_part_no" value="<%=sig_part_no%>">
                            <input type="hidden" name="sig_product_name" id="sig_product_name" value="<%=sig_prod_name%>">
                            <input type="hidden" name="apqp_meeting_date" id="apqp_meeting_date" value="<%=apqp_meeting_date%>">
                            <input type="hidden" name="apqp_closure_date" id="apqp_closure_date" value="<%=closure_meeting_date%>">
                            <input type="hidden" name="apqp_no" id="apqp_no" value="<%=apqp_no%>">
                            <input type="hidden" name="pcb_sig" id="pcb_sig" value="<%=pcb_sig%>">

                            <tr><th></th><th colspan="2" >Actions</th><th> Responsibility</th><th> Department</th><th> Target Date</th><th>Remark</th></tr>

                            <!--       <tr>
                                       <td><input type="checkbox"></td>
                                             <td colspan="2"><textarea name="action" id="action" rows="3" cols="30" maxlength="500"></textarea></td>
                                       <td><input type="text" name="responsibilty" id="resposibility" maxlength="30" size="20"/></td>
                                       <td><input type="text" name="department" id="department" maxlength="30"/></td>
                                       <td><input type="date" name="target_date" id="target_date" size="10" maxlength="30"/>
                                        
                                       </td>
                                       
                                       <td><input type="text" name="remark" id="remark" maxlength="30"/></td>
                             
                                 </tr>-->

                            <input type="hidden" name="count" id="count" value="0">
                        </table>
                        <center>

                            <input type="submit" value="Save">   &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                            <INPUT type="button" value="Add Row" onclick="addRow('dataTable')" />

                            <INPUT type="button" value="Delete Row" onclick="deleteRow('dataTable')" />

                        </center> 


                    </form>
                </div>
            </div>
            <div id="scroll">
                <a title="Scroll to the top" class="top" href="#"><img src="/EMAC/images/top.png" alt="top" /></a>
            </div>
            <footer>
                <!-- <p><img src="images/twitter.png" alt="twitter" />&nbsp;<img src="images/facebook.png" alt="facebook" />&nbsp;<img src="images/rss.png" alt="rss" /></p>
                -->  <p><a href="#">Home</a> | <a href="#">New Product</a> | <a href="#">Change Orders</a> | <a href="#">Tracker</a> | <a href="#">Validation</a></p>
                <p>Copyright &copy; Avalon Technologies Pvt Ltd | <a href="#">Design By Balaji.K</a></p>
            </footer>
        </div>

        <!--add and delete--> 
        <SCRIPT language="javascript">
            function addRow(tableID) {

                var table = document.getElementById(tableID);

                var rowCount = table.rows.length;
                var row = table.insertRow(rowCount);

                var cell1 = row.insertCell(0);
                var element1 = document.createElement("input");
                element1.type = "checkbox";
                element1.name = "checkbox" + rowCount;
                element1.id = "checkbox" + rowCount;
                cell1.appendChild(element1);

                //			var cell2 = row.insertCell(1);
                ////		
                //			cell2.innerHTML = rowCount-5;
                //			cell2.innerHTML = rowCount + 1;

                var pcb_sig = document.getElementById("pcb_sig").value;
                //alert(pcb_sig);
                if (pcb_sig == "PCB & SIG") {
                    var cell2 = row.insertCell(1);
                    cell2.innerHTML = rowCount - 4;

                } else if (pcb_sig != "PCB & SIG") {
                    var cell2 = row.insertCell(1);

                    cell2.innerHTML = rowCount - 3;
                }

                var cell3 = row.insertCell(2);
                var element2 = document.createElement("textarea");
                element2.type = "text";
                element2.name = "action" + rowCount;
                element2.id = "action" + rowCount;
                element2.rows = "3";
                element2.cols = "30";
                cell3.appendChild(element2);



                var cell4 = row.insertCell(3);
                var element3 = document.createElement("input");
                element3.type = "text";
                element3.name = "responsibilty" + rowCount;
                element3.id = "responsibilty" + rowCount;
                cell4.appendChild(element3);



                var cell5 = row.insertCell(4);
                var element4 = document.createElement("select");
                element4.options[element4.options.length] = new Option("Engineering");
                element4.options[element4.options.length] = new Option("SIG Quality");
                element4.options[element4.options.length] = new Option("PCB Quality");
                element4.options[element4.options.length] = new Option("IQC");
                element4.options[element4.options.length] = new Option("THT");
                element4.options[element4.options.length] = new Option("SMT");
                element4.options[element4.options.length] = new Option("Maintenance");
                element4.options[element4.options.length] = new Option("IT");
                element4.options[element4.options.length] = new Option("Industrial Engineering");
                element4.options[element4.options.length] = new Option("SIG");
                element4.options[element4.options.length] = new Option("Process Developement");
                element4.options[element4.options.length] = new Option("Purchase");
                element4.options[element4.options.length] = new Option("Program Management");
                element4.options[element4.options.length] = new Option("Stores");
                element4.options[element4.options.length] = new Option("Planning Management");
                element4.options[element4.options.length] = new Option("Management");
                element4.options[element4.options.length] = new Option("Others");
                element4.options[element4.options.length] = new Option("Business Developement");
                element4.options[element4.options.length] = new Option("Sourcing");
                element4.name = "department" + rowCount;
                element4.id = "department" + rowCount;
                cell5.appendChild(element4);

                var cell6 = row.insertCell(5);
                var element5 = document.createElement("input");
                element5.type = "date";
                element5.name = "target_date" + rowCount;
                element5.id = "target_date" + rowCount;
                cell6.appendChild(element5);

                var cell7 = row.insertCell(6);
                var element6 = document.createElement("textarea");
                element6.type = "text";
                element6.name = "remark" + rowCount;
                element6.id = "remark" + rowCount;
                element6.rows = "3";
                element6.cols = "25";
                cell7.appendChild(element6);





                //  alert(rowCount);
                document.getElementById("count").value = rowCount;

            }

            function deleteRow(tableID) {
                try {
                    var table = document.getElementById(tableID);
                    var rowCount = table.rows.length;

                    for (var i = 0; i < rowCount; i++) {
                        var row = table.rows[i];
                        var chkbox = row.cells[0].childNodes[0];
                        if (null != chkbox && true == chkbox.checked) {
                            table.deleteRow(i);
                            rowCount--;
                            i--;
                        }


                    }

                } catch (e) {
                    alert(e);
                }
            }

        </SCRIPT>
        <!--add and delete--> 

        <%
            } catch (Exception e) {
                out.println("<BR>Error : " + e);
            }
        %>    
    </body>
</html>
