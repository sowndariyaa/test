<%-- 
    Document   : edit_act_pts
    Created on : 12 Mar, 2018, 10:42:24 AM
    Author     : AV-IT-PC408
--%>

<%@page import="java.util.Date"%>
<%@page import="EMAC.Database_Connection"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="javax.servlet.http.HttpServlet"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Engineering Management And Control</title>
        <link rel="icon" type="image/png" href="images/favicon.ico">
        <script src="src/jquery.min.js"></script>
        <script src='src/jquery-customselect.js'></script>
        <link href='src/jquery-customselect.css' rel='stylesheet' />
        <link rel="stylesheet" href="css/css2.css">
        <link rel="stylesheet" href="css/edit_newapqp.css"> 
        <!--<link rel="stylesheet" href="css/aligncss.css">-->         
        <script type="text/javascript" src="jss/jquery.min.js"></script>
        <script type="text/javascript" src="jss/jquery-ui.min.js"></script>
        <link rel="stylesheet" type="text/css" href="jss/jquery-ui.css">
        <script type="text/javascript">
            $(window).load(function () {
                $('body').on('focus', ".datepicker_recurring_start", function () {
                    $(this).datepicker();
                });
            });
        </script>


        <script>
            function Valid() {
                var row = document.getElementById('valfirst').rows.length;
                var rend = row - 6;
                //alert(rstart+" "+rend);                   
                for (var i = 1; i <= rend; i++) {
                    var tdate = document.getElementById("tdate" + i).value;
                    var rtdate = document.getElementById("rtdate" + i).value;
                    if (tdate !== "" && rtdate !== "") {
                        if ((tdate !== "" && rtdate !== "")) {
                            var td = new Date(tdate);
                            var rtd = new Date(rtdate);
                            if (td >= rtd) {
                                alert(" Target Date lesser than Revised Target Date ! ");
                                document.getElementById("rtdate" + i).focus();
                                //document.getElementById("rtdate"+i).value="";
                                return false;
                            }
                        }
                    }
                }

            }
        </script>

    </head>
    <body>
        <div id="main">
            <%@include file="header.jsp" %>   
            <%                try {
                    String team = (String) session.getAttribute("team");
                    String username = (String) session.getAttribute("username");
                    String access = (String) session.getAttribute("access");

                    Database_Connection obj = new Database_Connection();
                    Connection con = obj.getConnection();
                    Statement st = con.createStatement();

                    String actions_pts = "", apqp_no = "";
                    actions_pts = request.getParameter("action_for");
                    apqp_no = request.getParameter("apqp");

                    Statement st1 = null;
                    Statement st2 = null;
                    ResultSet rs = null;
                    ResultSet rs1 = null;
                    ResultSet rs2 = null;

                    st1 = con.createStatement();
                    st2 = con.createStatement();

                    String pcba_part_no = "", sig_part_no = "", pcb_sig = "";
                    String pcb_prod_name = "", sig_prod_name = "";

                    Date apqp_meeting_date = null;
                    Date closure_meeting_date = null;

                    rs = st.executeQuery("select a.apqp_meeting_date,a.closure_meeting_date,a.pcb_sig,b.pcba_part_no,b.sig_part_no from  apqp_eil as a join  apqp_aps as b on a.apqp_no=b.apqp_no where a.apqp_no='" + apqp_no + "'");
                    while (rs.next()) {

                        apqp_meeting_date = rs.getDate(1);
                        closure_meeting_date = rs.getDate(2);
                        pcb_sig = rs.getString(3);

                        pcba_part_no = rs.getString(4);
                        sig_part_no = rs.getString(5);

                        rs1 = st1.executeQuery("select prod_name from   product_master_pcb where part_no='" + pcba_part_no + "'");
                        while (rs1.next()) {

                            pcb_prod_name = rs1.getString(1);
                        }

                        rs2 = st2.executeQuery("select prod_name from   product_master_sig where part_no='" + sig_part_no + "'");
                        while (rs2.next()) {
                            sig_prod_name = rs2.getString(1);
                        }

                    }

            %>
            <div id="new_menus">
                <li class="newmenu"><a href="apqp_edit.jsp?apqp=<%=apqp_no%>&p=0">APQP</a></li>
                <li class="newmenu"><a href="apqp_edit.jsp?apqp=<%=apqp_no%>&p=1">Affected Documents</a></li>
                <li class="newmenu"><a href="apqp_edit.jsp?apqp=<%=apqp_no%>&p=2">Action Points</a></li>
                <li class="newmenu"><a href="apqp_edit.jsp?apqp=<%=apqp_no%>&p=3">Phase I</a></li>
                <li class="newmenu"><a href="apqp_edit.jsp?apqp=<%=apqp_no%>&p=4">Phase II</a></li>
                <li class="newmenu"><a href="apqp_edit.jsp?apqp=<%=apqp_no%>&p=5">Phase III</a></li>
                <li class="newmenu"><a href="apqp_edit.jsp?apqp=<%=apqp_no%>&p=6">Phase IV</a></li>
                <li class="newmenu"><a href="apqp_edit.jsp?apqp=<%=apqp_no%>&p=7">Others</a></li>
                <li class="newmenu"><a href="apqp_edit.jsp?apqp=<%=apqp_no%>&p=8">Manufacture Review</a></li>
                <li class="newmenu"><a href="apqp_edit.jsp?apqp=<%=apqp_no%>&p=9">Validation</a></li>
            </div>
            <div id="site_content">
                <div class="content">
                    <%
                    %>
                    <form action="edit_act_pts" method="post" onsubmit="return Valid()" >
                        <!--<form action="#" method="post" onsubmit="return Valid()" >-->
                        <table style="width: 1050px;" id="valfirst">
                            <input type="hidden" value="<%=actions_pts%>" name="action_for"/>
                            <input type="hidden" value="<%=apqp_no%>" name="apqp_no" id="apqp_no"/>
                            <tr><th colspan="11"><center> <%=actions_pts%> Action Points</center></th></tr>

                            <%if (pcb_sig.equals("PCB")) {%>
                            <tr>
                                <td colspan="3">PCB Product  No:</td><td colspan="2"><%=pcba_part_no%></td><td colspan="2">PCB Product Name:</td><td colspan="2" ><%=pcb_prod_name%></td> 
                            </tr>
                            <%} else if (pcb_sig.equals("SIG")) {%>
                            <tr>
                                <td colspan="3">SIG Product  No:</td><td colspan="2"><%=sig_part_no%></td><td colspan="2"> SIG Product Name:</td><td colspan="2"><%=sig_prod_name%></td> 
                            </tr>
                            <%} else {%>
                            <tr>
                                <td colspan="3">PCB Product  No:</td><td colspan="2"><%=pcba_part_no%></td><td colspan="2" >PCB Product Name:</td><td colspan="2"><%=pcb_prod_name%></td> 
                            </tr>
                            <tr>
                                <td colspan="3">SIG Product  No:</td><td colspan="2"><%=sig_part_no%></td><td colspan="2" > SIG Product Name:</td><td colspan="2"><%=sig_prod_name%></td> 
                            </tr>
                            <%}%>
                            <tr>
                                <td colspan="3">APQP Number</td><td colspan="2"><%=apqp_no%></td>
                                <%if (actions_pts.equals("Initial") || actions_pts.equals("Post APQP")) {%>
                                <td colspan="2">Date:</td><td colspan="4"><%=apqp_meeting_date%>
                                    <%} else {%>
                                <td colspan="2">Closure Date:</td><td colspan="2"> <%=closure_meeting_date%>
                                    <%}%>
                                </td> 
                            </tr>
                            <input type="hidden" name="pcb_part_no" id="pcb_part_no" value="<%=pcba_part_no%>">
                            <input type="hidden" name="pcb_product_name" id="pcb_product_name"value="<%=pcb_prod_name%>">
                            <input type="hidden" name="sig_part_no" id="sig_part_no" value="<%=sig_part_no%>">
                            <input type="hidden" name="sig_product_name" id="sig_product_name" value="<%=sig_prod_name%>">
                            <input type="hidden" name="apqp_meeting_date" id="apqp_meeting_date" value="<%=apqp_meeting_date%>">
                            <input type="hidden" name="apqp_closure_date" id="apqp_closure_date" value="<%=closure_meeting_date%>">
                            <input type="hidden" name="apqp" id="apqp" value="<%=apqp_no%>">
                            <input type="hidden" name="pcb_sig" id="pcb_sig" value="<%=pcb_sig%>">

                            <tr>
                                <td>S.NO</td>
                                <td>Part No</td>
                                <td>Actions</td>
                                <td>Responsibility</td>
                                <td>Department</td>
                                <td>Target Date</td>
                                <td>Revised Target Date </td>
                                <td>Status</td>
                                <td>Remark</td></tr>
                                <%
                                    int i = 1;
                                    String fl = "", acc_read = "";
//                                      out.print(access);

                                    if (access.equals("admin")) {
//                                        out.print("test123");
                                        acc_read = "";
                                    } else {
                                        acc_read = "readonly";
                                    }

                                    ResultSet ret = st.executeQuery("select action_points,responsibility,department,tdate,rtdate,remark,status,id,part_no from  apqp_actions where apqp_no='" + apqp_no + "' and actions_for='" + actions_pts + "' order by id");
                                    while (ret.next()) {
                                        if (ret.getString(7).equals("Close")) {
                                            acc_read = "readonly";
                                        }
                                %>
                            <tr>
                                <td><%=i%></td>
                                <td><input type="text" name="partno<%=i%>" value="<%=ret.getString(9)%>" readonly="" style="width: 120px;" required=""></td>
                                <td><textarea name="action<%=i%>" id="action<%=ret.getString(1)%>" <%=acc_read%> value="<%=ret.getString(1)%>" style="width: 180px;" readonly=""><%=ret.getString(1)%></textarea></td>
                                <td><input type="text" name="responsibilty<%=i%>" id="resposibility<%=i%>" value="<%=ret.getString(2)%>" style="width: 100px;" <%=fl%> readonly=""/></td>
                                <td>
                                    <select name="department<%=i%>" id="department<%=i%>" >
                                        <option value="<%=ret.getString(3)%>"><%=ret.getString(3)%></option>                                        
                                        <%
                                            String query = "select department,id from  action_dep where status='Active' order by id";
                                            ResultSet csk = st1.executeQuery(query);
                                            while (csk.next()) {
                                        %>
                                        <option value="<%=csk.getString(1)%>"><%=csk.getString(1)%></option>
                                        <%                    }
                                        %>
                                    </select>
                                </td>
                                <td><input type="date" name="tdate<%=i%>" id="tdate<%=i%>"  value="<%=ret.getDate(4)%>" readonly="" style="width: 120px;" <%=fl%>/></td>
                                <td><input type="date" name="rtdate<%=i%>" id="rtdate<%=i%>"  value="<%=ret.getDate(5)%>" <%=fl%> style="width: 120px;" /></td>
                                <td>
                                    <select name="status<%=i%>" id="status<%=i%>" style="width: 120px;" >
                                        <option value="<%=ret.getString(7)%>"><%=ret.getString(7)%></option>
                                        <%
                                            if (access.equals("admin")) {
                                        %>
                                        <option value="Open">Open</option>
                                        <option value="Close">Close</option>
                                        <option value="Hold">Hold</option>
                                        <option value="Obsolete">Obsolete</option>
                                        <option value="Delete">Delete</option>
                                        <%
                                            }
                                            else {%>
                                        <option value="Open">Open</option>
                                        <option value="Hold">Hold</option>
                                        <option value="Obsolete">Obsolete</option>

                                        <%}%>

                                    </select><input type="hidden" name="id<%=i%>" value="<%=ret.getString(8)%>">                                
                                </td> 
                                <td>
                                    <input type="text" name="remark<%=i%>" id="remark<%=i%>" value="<%=ret.getString(6)%>" style="width: 120px;">
                                </td>
                            </tr>
                            <%
                                    i++;
                                    fl = "";
                                }
                            %>
                            <tr>
                                <td colspan="9" style="text-align: center;"><input type="hidden" name="rowCount" value="<%=i%>">
                                    <input type="submit" value="Save" class="but" />
                                </td>                                    
                            </tr>
                        </table>
                    </form>
                    <!--2nd form start--> 
                    <form action="edit_add_pts" method="post" onsubmit="return Validation()">
                        <table id="tBody" style="font-size: 12px;width: 900px" >
                            <input type="hidden" value="<%=actions_pts%>" name="action_for"/>
                            <input type="hidden" value="" name="rowCount" id="rowcount"/>
                            <input type="hidden" value="<%=apqp_no%>" name="apqp_no" />
                            <tr><th colspan="18"><center> <%=actions_pts%> Action Points</center></th></tr>
                                <%if (pcb_sig.equals("PCB")) {%>
                            <tr>
                                <td colspan="3">PCB Product  No:</td><td colspan="1"><%=pcba_part_no%></td><td >PCB Product Name:</td><td colspan="5"><%=pcb_prod_name%></td> 
                            </tr>
                            <%} else if (pcb_sig.equals("SIG")) {%>
                            <tr>
                                <td colspan="3">SIG Product  No:</td><td colspan="1"><%=sig_part_no%></td><td > SIG Product Name:</td><td colspan="5"><%=sig_prod_name%></td> 
                            </tr>
                            <%} else if (pcb_sig.equals("PCB & SIG")) {%>
                            <tr>
                                <td colspan="1">PCB Product  No:</td><td colspan="1"><%=pcba_part_no%></td><td >PCB Product Name:</td><td colspan="1"><%=pcb_prod_name%></td> 

                                <td colspan="1">SIG Product  No:</td><td colspan="1"><%=sig_part_no%></td><td > SIG Product Name:</td><td colspan="3"><%=sig_prod_name%></td> 
                            </tr>
                            <%}%>
                            <tr>
                                <td colspan="2">APQP Number</td><td colspan="2"><%=apqp_no%></td>
                                <%if (actions_pts.equals("Initial") || actions_pts.equals("Post APQP")) {%>
                                <td >Date:</td><td colspan="5"><%=apqp_meeting_date%>
                                    <%} else {%>
                                <td >Closure Date:</td><td colspan="10"><%=closure_meeting_date%>
                                    <%}%>
                                </td> 
                            </tr>  

                            <input type="hidden" name="pcb_part_no" id="pcb_part_no" value="<%=pcba_part_no%>">
                            <input type="hidden" name="pcb_product_name" id="pcb_product_name"value="<%=pcb_prod_name%>">
                            <input type="hidden" name="sig_part_no" id="sig_part_no" value="<%=sig_part_no%>">
                            <input type="hidden" name="sig_product_name" id="sig_product_name" value="<%=sig_prod_name%>">
                            <input type="hidden" name="apqp_meeting_date" id="apqp_meeting_date" value="<%=apqp_meeting_date%>">
                            <input type="hidden" name="apqp_closure_date" id="apqp_closure_date" value="<%=closure_meeting_date%>">
                            <input type="hidden" name="apqp" id="apqp" value="<%=apqp_no%>">
                            <input type="hidden" name="pcb_sig" id="pcb_sig" value="<%=pcb_sig%>">

                            <tr><td>S.NO</td><td>Part No</td><td>Actions</td><td> Responsibility</td><td> Department</td><td> Target Date</td><td>Revised Target Date </td><td>Status</td><td colspan="2">Remark</td></tr>


                            <input type="hidden" name="count" id="count" value="1">


                        </table>
                        <center>    
                            <%
                                if (actions_pts.equals("Initial") || actions_pts.equals("Closure") || actions_pts.equals("Customer Feedback") || actions_pts.equals("Post APQP") ) {
                            %>
                            <a href="apqp_cft.jsp?apqpno=<%=apqp_no%>&action=<%=actions_pts%>"><input type="button"  height="26" class="but"  value="CFT Members" /></a>&nbsp;&nbsp;&nbsp;
                                <%
                                    }
                                %>
                            <input type="button"  height="26" id="remove" class="deletebutton but" value="Remove" />&nbsp;&nbsp;&nbsp;
                            <input type="button" class="addrow but" id="addrow" value="Add" />&nbsp;&nbsp;&nbsp;
                            <input type="submit" value="Submit" class="but" >                                                      
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

        <script type="text/javascript" src="js/addrow.js"></script>  <!-- Fetch Data Value -->
        <script src="js/onchange_fetch_data.js" type="text/javascript"></script>
        <script>

                        var tot = 0;
                        var n = 0;
                        //    <<<<<<<<<<<<<<<<<<<<<     add row table function start         >>>>>>>>>>>>>>>>>>>>>>>>     
                        $(document).ready(function () {
                            var rowInd = 0;
                            $(".deletebutton").click(function () {
                                var sno = 0;
                                $("#tBody").find('input[name="chk"]').each(function () {
                                    if ($(this).is(":checked")) {
                                        rowInd--;
                                        if (rowInd == 1) {
                                            document.getElementById("totalcost").value = "";
                                        }
                                        $(this).parents("tr").remove();
                                    }
                                });
                                $('#discount').val("0");
                                sno = $('#tBody tr').length;
                                rowInd = $('#tBody tr').length - 1;
                                var counter = 1;
                                $('.sno').each(function () {

                                    tot = rowInd;
                                    var ar = this.id;
                                    var val = ar.replace("s_no", "");
                                    alert(val + " " + counter);


                                    $('#s_no' + val).attr('name', 's_no' + counter);
                                    $('#action' + val).attr('name', 'action' + counter);
                                    $('#res' + val).attr('name', 'res' + counter);
                                    $('#dep' + val).attr('name', 'dep' + counter);
                                    $('#tdate' + val).attr('name', 'tdate' + counter);
                                    $('#rdate' + val).attr('name', 'rdate' + counter);
                                    $('#status' + val).attr('name', 'status' + counter);
                                    $('#remark' + val).attr('name', 'remark' + counter);

                                    $('#actions' + val).attr('id', 'actions' + counter);
                                    $('#responses' + val).attr('id', 'responses' + counter);
                                    $('#departments' + val).attr('id', 'departments' + counter);
                                    $('#targets' + val).attr('id', 'targets' + counter);
                                    $('#rtdates' + val).attr('id', 'rtdates' + counter);
                                    $('#statuses' + val).attr('id', 'statuses' + counter);
                                    $('#remarks' + val).attr('id', 'remarks' + counter);
                                    $('#action' + val).attr('id', 'action' + counter);
                                    $('#res' + val).attr('id', 'res' + counter);
                                    $('#dep' + val).attr('id', 'dep' + counter);
                                    $('#tdate' + val).attr('id', 'tdate' + counter);
                                    $('#rdate' + val).attr('id', 'rdate' + counter);
                                    $('#status' + val).attr('id', 'status' + counter);
                                    $('#remark' + val).attr('id', 'remark' + counter);
                                    $('#s_nos' + val).attr('id', 's_nos' + counter);
                                    $('#s_no' + val).attr('id', 's_no' + counter);

                                    $('#s_no' + counter).attr('value', counter);
                                    counter++;

                                });

//                                overAllcost();
//                                totalCost();

                            });


                            $(".addrow").click(function () {

                                $('#discount').val("0");
                                var rowInd = $('#tBody tr').length - 4;
                                var sup_name = $("#sup").val();
                                rowInd++;
//                                alert(rowInd);
                                if (rowInd > 5) {
                                    alert("5 Rows Only Allowed ! ");
                                    return false;
                                }

                                tot = rowInd;
//                                alert(tot);
                                var markup = "<tr>" +
                                        "<input type='hidden' name='rowCount' id='rowCount' value='" + rowInd + "'>" +
                                        "<td><div id = 's_nos" + rowInd + "'><input type='text' id='s_no" + rowInd + "' name='s_no" + rowInd + "' class='sno' value='" + rowInd + "' style='color:black;width:20px;text-align:center;border:none;background:none;' readonly ></div></td>" +
                                        "<td><div id = 'partnos" + rowInd + "' style='color:black;'></div></td>" +
                                        "<td><div id = 'actions" + rowInd + "' style='color:black;'><input type='text' name='action" + rowInd + "' id='action" + rowInd + "' style='width:150px;' required></div></td>" +
                                        "<td><div id = 'responses" + rowInd + "'><input type='text' name='res" + rowInd + "' id='res" + rowInd + "' style='width:120px;' required ></div></td>" +
                                        "<td><div id = 'departments" + rowInd + "'></div></td>" +
                                        "<td><div id = 'targets" + rowInd + "'><input type='date' name='tdate" + rowInd + "' id='tdate" + rowInd + "' style='width: 130px;color: black;' required ></div></td>" +
                                        "<td><div id = 'rtdates" + rowInd + "'><input type='date' name='rdate" + rowInd + "' id='rdate" + rowInd + "' style='width:130px;color:black;' ></div></td>" +
                                        "<td><div id = 'statuses" + rowInd + "'><select name='status" + rowInd + "' id='status" + rowInd + "' style='width: 116px;color: black;border:none;' required >\n\
                                \n\
                                <option value='Open'>Open</option>\n\
                                <option value='Close'>Close</option>\n\
                                </select></div></td>" +
                                        "<td><div id = 'remarks" + rowInd + "'><input type='text' name='remark" + rowInd + "' id='remark" + rowInd + "' style='width:110px;text-transform: uppercase;color:black;' ></div></td>" +
                                        "<td><div id ='chk" + rowInd + "'><input type='checkbox' id='cbox" + rowInd + "' name='chk' class='chkbox' style='width:20px;'></div></td>" +
                                        "</tr>";
                                $("#tBody").append(markup);

//                                overAllcost();
//                                totalCost();
                                //alert("Test");
                                $.ajax({
                                    type: "post",
                                    url: "getDepartment.jsp?row=" + rowInd, //here you can use servlet,jsp, etc
                                    // data: "input=" +$('#ip').val()+"&output="+$('#op').val(),
                                    success: function (msg) {
                                        $("#departments" + rowInd + "").html(msg);
                                    }
                                });

                                var apqp = $('#apqp_no').val();
                                $.ajax({
                                    type: "post",
                                    url: "getPartnos.jsp?row=" + rowInd + "&apqpno=" + apqp, //here you can use servlet,jsp, etc
                                    // data: "input=" +$('#ip').val()+"&output="+$('#op').val(),
                                    success: function (msg) {
                                        $("#partnos" + rowInd + "").html(msg);
                                    }
                                });



                                $('#ad_count_row').val(rowInd);

                            });
                        });
                        //      <<<<<<<<<<<<<<<<<<<<<  Add row table function End   >>>>>>>>>>>>>>>>>>>>>>  
        </script>    
        <script>
            function Validation() {
                var row = document.getElementById('tBody').rows.length;
                if (row > 4) {
                    var x = row - 4;
                    document.getElementById("rowcount").value = x;
                } else {
                    alert("Add Row !");
                    return false;
                }
            }
        </script>
        <%
                con.close();
            } catch (Exception e) {
                out.println(e);
            }
        %>    
    </body>
</html>
