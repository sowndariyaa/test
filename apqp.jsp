<%-- 
    Document   : apqp
    Created on : 15 Feb, 2018, 5:07:32 PM
    Author     : AV-IT-PC408
--%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="EMAC.Database_Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="icon" href="images/E-PNG.png" type="image/png" sizes="196x196"> 
        <title>Engineering Management And Control</title>
        <link rel="icon" type="image/png" href="images/favicon.ico">

        <script src="src/jquery-1.12.4.js"></script>
        <script src="src/jquery-ui.js"></script>

        <link rel="stylesheet" href="css/css1.css">  


        <script>
            function validate() {
                var row = document.getElementById("ph1_count").value;

                for (var i = 1; i <= row; i++) {

                    var x = document.getElementById("res" + i).value;
                    var z = document.getElementById("actual" + i).value;

                    if (x == "" || x == null) {
                    } else {
                        var y = document.getElementById("target" + i).value;
                        if (y == "" || y == null) {
                            if (z == "" || z == null) {
                                alert("Select Target  Date  ! ");
                                document.getElementById("target" + i).focus();
                                return false;
                            }
                        }
                    }
                }
            }
        </script>
        <script>

            function validate1() {
                var row1 = document.getElementById("ph2_count").value;

                for (var i = 1; i <= row1; i++) {
                    var x = document.getElementById("resp" + i).value;
                    var z = document.getElementById("actualdate" + i).value;

                    if (x == "" || x == null) {
                    } else {
                        var y = document.getElementById("targetdate" + i).value;
                        if (y == "" || y == null) {
                            if (z == "" || z == null) {
                                alert("Select Target Date  ! ");
                                document.getElementById("targetdate" + i).focus();
                                return false;
                            }
                        }
                    }
                }
            }
        </script>
        <script>

            function validate2() {
                var row = document.getElementById("ph3_count").value;

                for (var i = 1; i <= row; i++) {
                    var x = document.getElementById("respon" + i).value;
                    var z = document.getElementById("actual_date" + i).value;

                    if (x == "" || x == null) {
                    } else {
                        var y = document.getElementById("target_date" + i).value;
                        if (y == "" || y == null) {
                            if (z == "" || z == null) {
                                alert("Select Target Date  ! ");
                                document.getElementById("target_date" + i).focus();
                                return false;
                            }
                        }
                    }
                }
            }

            function validate3() {
                var row = document.getElementById("ph4_count").value;

                for (var i = 1; i <= row; i++) {
                    var x = document.getElementById("respons" + i).value;
                    var z = document.getElementById("actual_dates" + i).value;

                    if (x == "" || x == null) {
                    } else {
                        var y = document.getElementById("target_dates" + i).value;
                        if (y == "" || y == null) {
                            if (z == "" || z == null) {
                                alert("Select Target Date  ! ");
                                document.getElementById("target_dates" + i).focus();
                                return false;
                            }
                        }
                    }
                }
            }

            function validate4() {
                var row = document.getElementById("ph5_count").value;

                for (var i = 1; i <= row; i++) {
                    var x = document.getElementById("respon1" + i).value;
                    var z = document.getElementById("actual_date1" + i).value;

                    if (x == "" || x == null) {
                    } else {
                        var y = document.getElementById("target_date1" + i).value;
                        if (y == "" || y == null) {
                            if (z == "" || z == null) {
                                alert("Select Target Date  ! ");
                                document.getElementById("target_date1" + i).focus();
                                return false;
                            }
                        }
                    }
                }
            }


            function validate5() {
                var row = document.getElementById("ph6_count").value;

                for (var i = 1; i <= row; i++) {
                    var x = document.getElementById("respons2" + i).value;
                    var z = document.getElementById("actual_dates2" + i).value;

                    if (x == "" || x == null) {
                    } else {
                        var y = document.getElementById("target_dates2" + i).value;
                        if (y == "" || y == null) {
                            if (z == "" || z == null) {
                                alert("Select Target Date  ! ");
                                document.getElementById("target_dates2" + i).focus();
                                return false;
                            }
                        }
                    }
                }
            }

            function validate6() {
                var row = document.getElementById("ph7_count").value;
                for (var i = 1; i <= row; i++) {
                    var x = document.getElementById("res_phase4" + i).value;
                    var z = document.getElementById("actual_dates3" + i).value;
                    if (x == "" || x == null) {
                    } else {
                        var y = document.getElementById("tar_phase4" + i).value;
                        if (y == "" || y == null) {
                            if (z == "" || z == null) {
                                alert("Select Target Date  ! ");
                                document.getElementById("tar_phase4" + i).focus();
                                return false;
                            }
                        }
                    }
                }
            }

            function validate7() {
                var row = document.getElementById("ph8_count").value;

                for (var i = 1; i <= row; i++) {
                    var x = document.getElementById("respons8" + i).value;
                    var z = document.getElementById("actual_dates4" + i).value;

                    if (x == "" || x == null) {
                    } else {
                        var y = document.getElementById("target_dates8" + i).value;
                        if (y == "" || y == null) {
                            if (z == "" || y == null) {
                                alert("Select Target Date  ! ");
                                document.getElementById("target_dates8" + i).focus();
                                return false;
                            }
                        }
                    }
                }
            }




        </script>


        <style>
            table{
                margin-top: 50px;
            }



            th{
                text-align: left;
            }
            input[type=checkbox] {
                zoom: 1.5;
            }
            th{
                font-size: 14px;
            }
            td{
                font-size: 12px;
            }

        </style>
        <script>
            function myFunctionfeeds() {
                var xx = document.getElementById("feed").value;

                //alert(xx);
                var ss = "", ss1 = "";
                if (xx == "Re-Submission") {

                    ss = '<th colspan="1">Re-submission Feedback</th><td colspan="3"><select name="resub" id="resub"><option></option><option value="Accepted">Accepted</option>\n\
        <option value="Rejected">Rejected</option>\n\
        <option value="Re-Submission">Re-Submission</option>\n\
        <option value="Next PO Received">Next PO Received</option></select></td>';
                    ss1 = '<th colspan="1">Feedback Remarks</th><td colspan="3"><input type="text" name="feedback_rem" id="feedback_rem"></td>';
                    document.getElementById("feeds").innerHTML = ss;
                    document.getElementById("feedrem").innerHTML = ss1;
                } else {
                    document.getElementById("feeds").innerHTML = "";
                }
            }

            function myFunctionfeed() {
                var xx1 = document.getElementById("feed").value;
                //alert(xx);
                var ss1 = "", ss2 = "";
                if (xx1 == "Re-Submission") {
                    ss1 = '<th colspan="1">Re-submission Feedback</th><td colspan="3"><select name="resub" id="resub"><option value="Accepted">Accepted</option>\n\
                            <option value="Rejected">Rejected</option>\n\
                            <option value="Re-Submission">Re-Submission</option>\n\
                            <option value="Next PO Received">Next PO Received</option></select></td>';
                    ss2 = '<th colspan="1">Feedback Remarks</th><td colspan="3"><input type="text" name="feedback_rem" id="feedback_rem"></td>';
                    document.getElementById("feedsig").innerHTML = ss1;
                    document.getElementById("feedremsig").innerHTML = ss2;
                }
            }

            function myFunctionother(val) {
                if (val == "Others") {
                    var rr = '<input type="text" name="pc_other" id="pc_other" required placeholder="Enter Other Category Name"></td>';
                    document.getElementById("other").innerHTML = rr;
                }
            }
            function myFunctionothers(val) {
                if (val == "Others") {
                    var rr = '<input type="text" name="pc_other" id="pc_other" required placeholder="Enter Other Category Name"></td>';
                    document.getElementById("others").innerHTML = rr;
                }
            }
        </script>
        <script>
            function myFunction(val) {

                var type = document.getElementById("apqp_type").value;
                if (type == "PCB") {
                    var x = document.getElementById("part_no").value;
                    if (val == "PCB & SIG") {
                        $.ajax({
                            type: "post",
                            url: "apqp_getsigpart?pcbpart=" + x + "&type=PCB",
                            success: function (msg) {
                                $("#fetch").html(msg);
                            }
                        });
                    } else {
                        document.getElementById("fetch").innerHTML = "";
                    }

                } else if (type == "SIG") {
                    var x = document.getElementById("part_no").value;
                    if (val == "PCB & SIG") {
                        $.ajax({
                            type: "post",
                            url: "apqp_getsigpart?pcbpart=" + x + "&type=SIG",
                            success: function (msgs) {
                                $("#fetchs").html(msgs);
                            }
                        });
                    } else {
                        document.getElementById("fetchs").innerHTML = "";
                    }
                }

            }
//            function myFunctions(val) {
//                var x = document.getElementById("part_no").value;
//                if (val == "PCB & SIG") {
//                    $.ajax({
//                        type: "post",
//                        url: "apqp_getsigpart?pcbpart=" + x + "&type=SIG",
//                        success: function (msgs) {
//                            $("#fetchs").html(msgs);
//                        }
//                    });
//                } else {
//                    document.getElementById("fetchs").innerHTML = "";
//                }
//            }
        </script>


        <script>

            function myFunctionvalapp() {
                var yy = document.getElementById("valid").value;
                alert(yy)
                //alert(xxx3);
                var vv = "", vv1 = "";
                if (yy == "Yes") {

                    vv = '<th colspan="4" align="center">Validation Applicable</th>';
                    vv1 = '<td colspan="4">\n\
        <input type="checkbox" name="linkpartno" id="ass" value="Assembly">Assembly \n\
&nbsp;&nbsp;&nbsp;<input type="checkbox" name="linkpartno" id="tes" value="Testing">Testing\n\
&nbsp;&nbsp;&nbsp;<input type="checkbox" name="linkpartno" id="pac" value="Packing">Packing\n\
&nbsp;&nbsp;<input type="checkbox" name="linkpartno" id="fix" value="Fixture">Fixture\n\
&nbsp;&nbsp;&nbsp;<input type="checkbox" name="linkpartno" id="too" value="Tooling">Tooling\n\
&nbsp;&nbsp;&nbsp;<input type="checkbox" name="linkpartno" id="pro" value="Programming">Programming\n\
&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="linkpartno" id="ot" value="Others">Others</td>\n\
</tr>';
                    document.getElementById("valapp").innerHTML = vv;
                    document.getElementById("valapps").innerHTML = vv1;

                } else {
                    document.getElementById("valapp").innerHTML = "";
                    document.getElementById("valapps").innerHTML = "";
                }
            }
        </script>

        <style>
            /*            table input{
                            width: 180px;
                        }
                        table select{
                            width: 184px;
                        }*/


        </style>
    </head>
    <body>
        <div id="main">           
            <%@include file="header.jsp" %>   
            <div id="site_content">     
                <%                    try {
                        String team = (String) session.getAttribute("team");
                        String access = (String) session.getAttribute("access");
                        String username = (String) session.getAttribute("username");
                        Database_Connection obj = new Database_Connection();
                        Connection con = obj.getConnection();
                        Statement st = con.createStatement();
                        Statement st1 = con.createStatement();
                        Statement st2 = con.createStatement();

                        String types = request.getParameter("type");

//                        out.print("<br>" + types);
                        String level = "";
                        if (types.equals("PCB")) {
                            level = "PCBA";
                        } else if (types.equals("SIG")) {
                            level = "SIG";
                        } else {
                            level = "";
                        }

                        //  out.print("Selected Type : " + types);

                %>
                <div class="content">


                    <%                        String pcb = "", sig = "", type = "";
                        pcb = request.getParameter("pcb_part_no");
                        sig = request.getParameter("sig_part_no");

                        int aa = 0, apck = 0;
                        String apqp_no = "", last_apqp = "", apqp_fin = "";
                        int apqp_in = 0;
                        String apqpnew = "";
                        ResultSet rsa = st.executeQuery("select  MAX(apqp_no) apqp_no from  apqp_master order by id desc ");
                        while (rsa.next()) {
                            apqpnew = rsa.getString(1);
                            aa++;
                        }
                        if (aa > 0) {
                            apqp_no = apqpnew.substring(apqpnew.length() - 5, apqpnew.length());
                            apqp_in = Integer.parseInt(apqp_no);
                            apqp_in++;
                            apqp_fin = String.valueOf(apqp_in);
                            if (apqp_fin.length() < 5) {
                                int j5 = apqp_fin.length();
                                for (int i5 = j5; i5 < 5; i5++) {
                                    apqp_fin = "0" + apqp_fin;
                                }
                                apqp_no = "APQ-" + apqp_fin;
                            }
                        } else {
                            apqp_no = "APQ-00001";
                        }

                        String sig_prod_name = "";
                        String sig_part_no = "";
                        String sig_part_rev = "";

                        String pcb_prod_name = "";
                        String pcb_part_no = "";
                        String pcb_part_rev = "";
                        String pcb_engineer = "";
                        String sig_engineer = "";

                        String cus = "";

                        if (types.equals("PCB")) {

                            ResultSet rsx = st.executeQuery("select prod_name,part_no,plant,customer_name,cust_part_no,part_revision from  product_master_pcb  where part_no='" + pcb + "'  ");
                            while (rsx.next()) {
                                cus = rsx.getString(4);

                            }
                        } else {
                            ResultSet rsx = st.executeQuery("select prod_name,part_no,plant,customer_name,cust_part_no,part_revision from  product_master_sig  where part_no='" + sig + "'  ");
                            while (rsx.next()) {
                                cus = rsx.getString(4);

                            }
                        }
                        ResultSet rsv = st.executeQuery("select pcb_engineering,sig_engineering from  customer_master where customer_name='" + cus + "'");

                        while (rsv.next()) {
                            pcb_engineer = rsv.getString(1);
                            sig_engineer = rsv.getString(2);

                        }

                        ResultSet rs1 = null;
                        String prod_name = "", part_no1 = "", plant = "", cust_name = "", cust_part_no = "", part_rev = "";
                        int a = 0, b = 0;
                        if (types.equals("PCB")) {
                            type = "PCB";
                            rs1 = st.executeQuery("select a.sig_product_name,a.sig_part_no,b.part_revision,a.product_name from  product_master as a  join  product_master_sig as b on a.sig_part_no=b.part_no where a.part_no='" + pcb + "' ");
                            while (rs1.next()) {
                                sig_prod_name = rs1.getString(4);
                                sig_part_no = rs1.getString(2);
                                sig_part_rev = rs1.getString(3);
                            }
                            ResultSet rs = st.executeQuery("select prod_name,part_no,plant,customer_name,cust_part_no,part_revision from  product_master_pcb  where part_no='" + pcb + "'  ");
                            while (rs.next()) {
                                prod_name = rs.getString(1);
                                part_no1 = rs.getString(2);
                                plant = rs.getString(3);
                                cust_name = rs.getString(4);
                                cust_part_no = rs.getString(5);
                                part_rev = rs.getString(6);
                                a++;
                            }

                        }
                        if (types.equals("SIG")) {
                            type = "SIG";
                            rs1 = st.executeQuery("select a.product_name,a.part_no,b.part_revision from  product_master as a  join  product_master_pcb as b on a.part_no=b.part_no where a.sig_part_no='" + sig + "'");
                            while (rs1.next()) {
                                pcb_prod_name = rs1.getString(1);
                                pcb_part_no = rs1.getString(2);
                                pcb_part_rev = rs1.getString(3);
                            }

                            ResultSet rs = st.executeQuery("select prod_name,part_no,plant,customer_name,cust_part_no,part_revision from  product_master_sig  where part_no='" + sig + "'  ");
                            while (rs.next()) {
                                prod_name = rs.getString(1);
                                part_no1 = rs.getString(2);
                                plant = rs.getString(3);
                                cust_name = rs.getString(4);
//                                out.print("<br>" + cust_name);
                                cust_part_no = rs.getString(5);
                                part_rev = rs.getString(6);
                                a++;
                            }
                        }
                        rs1.close();

                    %>                                
                    <input type="hidden" name="sig_prod_name" id="sig_prod_name" value="<%=sig_prod_name%>">
                    <input type="hidden" name="sig_part_no" id="sig_part_no" value="<%=sig_part_no%>">
                    <input type="hidden" name="sig_part_rev" id="sig_part_rev" value="<%=sig_part_rev%>">
                    <input type="hidden" name="pcb_prod_name" id="pcb_prod_name" value="<%=pcb_prod_name%>">
                    <input type="hidden" name="pcb_part_no" id="pcb_part_no" value="<%=pcb_part_no%>">
                    <input type="hidden" name="pcb_part_rev" id="pcb_part_rev" value="<%=pcb_part_rev%>">
                    <%

                    %>
                    <form action="apqp_insert" method="post" >
                        <input type="hidden" name="apqp_type" id="apqp_type" value="<%=types%>">
                        <table>
                            <tr>
                                <th  colspan="5" style="text-align: center">Advanced Product Quality Planning </th>
                            </tr>
                            <tr>
                                <th style="text-align: left">Plant</th>
                                <td colspan="3">
                                    <select name="plants" id="plants" required="">
                                        <option value="<%=plant%>"><%=plant%></option>
                                        <option value="B7">B7</option>
                                        <option value="B8">B8</option>
                                    </select>
                                </td>
                            </tr>
                            <input type="hidden" name="type" id="type" value="<%=type%>">
                            <tr>
                                <th style="text-align: left">APQP Number</th>
                                <td colspan="3"><input type="text" name="apqp" id="apqp" value="<%=apqp_no%>" readonly="" required=""></td>
                            </tr>
                            <tr>
                                <th style="text-align: left">Customer Name</th>
                                <td colspan="3"><input type="text" name="cust_name" id="cust_name" value="<%=cust_name%>" size="50" readonly="" required=""></td>
                            </tr>
                            <tr>
                                <th style="text-align: left">Initial Input From Customer Received On</th>
                                <td colspan="3"><input type="date" name="ininput_crdate" id="ininput_crdate" required="" ></td>
                            </tr>
                            <tr>
                                <th style="text-align: left">APQP Meeting Date</th>
                                <td colspan="3"><input type="date" name="apqp_meet" id="apqp_meet"  ></td>
                            </tr>                                                                 
                            <tr>
                                <th style="text-align: left">PCB/SIG</th>
                                <td colspan="3">
                                    <select name="pcbsig" id="pcb"  onchange="myFunction(this.value)" required="">
                                        <option value="<%=type%>"><%=type%></option>
                                        <option value="PCB">PCB</option>
                                        <option value="PCB & SIG">PCB & SIG</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <th style="text-align: left"><%=level%> Product Name</th>
                                <td colspan="3"><input type="text" name="prod_name" id="prod_name" value="<%=prod_name%>" size="60" readonly="" required=""></td>
                            </tr>
                            <tr>
                                <th style="text-align: left"><%=level%> Part Number</th>
                                <td colspan="3"><input type="text" name="part_no" id="part_no" value="<%=part_no1%>" readonly="" required=""></td>
                            </tr>                                                                   
                            <tr>
                                <th style="text-align: left"><%=level%> Revision</th>
                                <td colspan="3"><input type="text" name="rev" id="rev" value="<%=part_rev%>" required=""></td>
                            </tr>  
                            <tr>
                                <th style="text-align: left"><%=level%> Customer Part Number</th>
                                <td colspan="3"><input type="text" name="cust_part_no" id="cust_part_no" value="<%=cust_part_no%>" readonly="" required=""></td>
                            </tr>
                            <tr>
                                <th style="text-align: left">PCB Engineer</th>
                                <td colspan="3"><input type="text" name="pcb_eng" id="pcb_eng" value="<%=pcb_engineer%>" readonly="" required=""></td>
                            </tr>
                            <tr>
                                <th style="text-align: left">SIG Engineer</th>
                                <td colspan="3"><input type="text" name="sig_eng" id="sig_eng" value="<%=sig_engineer%>" readonly="" required=""></td>
                            </tr>
                            <tr id="fetch"></tr>
                            <tr id="fetchss"></tr>
                            <tr id="fetchs"></tr>

                            <tr>
                                <th style="text-align: left">Product Status(FG/SFG)</th>
                                <td colspan="3">
                                    <select name="prod_status" id="prod_status" required="">
                                        <option value=""></option>
                                        <option value="FG">FG</option>
                                        <option value="SFG">SFG</option>
                                        <option value="TBD">TBD</option>
                                    </select>
                                </td>
                            </tr> 
                            <tr>
                                <th style="text-align: left">Customer Required Date</th>
                                <td colspan="3"><input type="date" name="cust_req" id="cust_req" required="" ></td>
                            </tr>
                            <tr>
                                <th style="text-align: left">Product Category</th>
                                <td colspan="4">
                                    <select name="category" id="category" onchange="myFunctionother(this.value)" style="float: left;" required="">
                                        <option value="Automotive">Automotive</option>
                                        <option value="Non Automotive">Non Automotive</option>
                                        <!--<option value="Others">Others</option>-->
                                    </select><div id="other"></div>
                                </td>
                            </tr>

                            <tr>
                                <th style="text-align: left">PPAP Requirements</th>
                                <td colspan="3">
                                    <select name="ppap" id="ppap" required="">
                                        <option value="Yes">Yes</option>
                                        <option value="No">No</option>
                                    </select>
                                </td>
                            </tr>                                    
                            <tr>
                                <th>Project leader</th>
                                <td colspan="3"><input type="text" name="leader" id="leader" required=""></td>
                            </tr>
                            <tr>
                                <th>Proto Quantity</th>
                                <td colspan="3"><input type="number" name="qty" id="qty" required=""></td>
                            </tr>
                            <tr>
                                <th>Class of the Product</th>
                                <td colspan="3"><input type="text" name="class_prod" id="class_prod" required="" ></td>
                            </tr>
                            <tr>
                                <th>Product Soldering Process</th>
                                <td colspan="3">
                                    <select name="prod_sold" id="prod_sold" required="">
                                        <option value="RoHS">RoHS</option>
                                        <option value="Non-RoHS">Non-RoHS</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <th>Application</th>
                                <td colspan="3"><input type="text" name="app" id="app" size="50" required=""></td>
                            </tr>                                    
                            <tr>
                                <th style="text-align: left">Receipt of Testing(PROCEDURE/SOFTWARE)</th>
                                <td colspan="3">
                                    <select name="testing" id="testing" required="">
                                        <option value="Yes">Yes</option>
                                        <option value="No">No</option>
                                        <option value="NA">NA</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <th style="text-align: left">Receipt of BOM</th>
                                <td colspan="3">
                                    <select name="bom" id="bom" required="">
                                        <option value="Yes">Yes</option>
                                        <option value="No">No</option>
                                        <option value="NA">NA</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <th style="text-align: left">Receipt of GBR</th>
                                <td colspan="3">
                                    <select name="gbr" id="gbr" required="">
                                        <option value="Yes">Yes</option>
                                        <option value="No">No</option>
                                        <option value="NA">NA</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <th style="text-align: left">Receipt of AIN(PCB/SIG)</th>
                                <td colspan="3">
                                    <select name="ain" id="ain" required="">
                                        <option value="Yes">Yes</option>
                                        <option value="No">No</option>
                                        <option value="NA">NA</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <th style="text-align: left">Receipt of Program Files</th>
                                <td colspan="3">
                                    <select name="file" id="file" required="">
                                        <option value="Yes">Yes</option>
                                        <option value="No">No</option>
                                        <option value="NA">NA</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <th style="text-align: left">Receipt of XY</th>
                                <td colspan="3">
                                    <select name="xy" id="xy" required="">
                                        <option value="Yes">Yes</option>
                                        <option value="No">No</option>
                                        <option value="NA">NA</option>
                                    </select>
                                </td>
                            </tr>    
                            <tr>
                                <th style="text-align: left">Customer Document Updated In Storage Location</th>
                                <td colspan="3"><input type="text" name="store_loc" id="store_loc" size="50" required="" ></td>
                            </tr>
                            <tr>
                                <th style="text-align: left">Input Status</th>
                                <td colspan="3">
                                    <select name="input_status" id="input" required="">
                                        <option value="All">All</option>
                                        <option value="Partial">Partial</option>
                                        <option value="NA">NA</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <th style="text-align: left">Complete Input From Customer Received On</th>
                                <td colspan="3"><input type="date" name="comp_cust_rec" id="comp_cust_rec" ></td>
                            </tr>
                            <tr>
                                <th style="text-align: left">Validation</th>
                                <!--<td colspan="3"><select name="valid" id="valid" onchange="myFunctionvalapp()">-->
                                <td colspan="3"><select name="valid" id="valid" required="" >
                                        <option></option>                                                
                                        <option value="Yes">Yes</option>
                                        <option value="No">No</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <th>Shipment Date</th>
                                <td colspan="3"><input type="date" name="ship_date" id="ship_date" disabled></td>
                            </tr>
                            <tr>
                                <th style="text-align: left">Closure Meeting Date</th>
                                <td colspan="3"><input type="date" name="cmd" id="cmd" disabled ></td>
                            </tr>                                    
                            <tr>
                                <th style="text-align: left">CRD Remarks</th>
                                <td colspan="3"><input type="text" name="crd_remarks" id="crd_remarks" size="50" disabled></td>
                            </tr>                                    
                            <tr>
                                <th style="text-align: left">Customer Feedback</th>
                                <td colspan="3">
                                    <select name="feed" id="feed"  onchange="myFunctionfeeds()" disabled="">
                                        <option value=""></option>
                                        <option value="Accepted">Accepted</option>
                                        <option value="Rejected">Rejected</option>
                                        <option value="Re-Submission">Re-Submission</option>
                                        <option value="Next PO Received">Next PO Received</option>
                                    </select>
                                </td>
                            </tr>
                            <tr id="feeds"></tr>
                            <tr id="feedrem"></tr>
                            <tr>
                                <th style="text-align: left">Customer Feedback Storage Location</th>
                                <td colspan="3"><input type="text" name="feed_sto" id="feed_sto" size="50" disabled></td>
                            </tr>                                                                      

                            <tr id="valapp"></tr>
                            <tr id="valapps"></tr>                                                                        
                            <tr>
                                <th style="text-align: left">Status</th>
                                <td colspan="3">
                                    <select name="stat" id="stat" required="" readonly="">
                                        <option value="Open">Open</option>
                                        <!--                                                <option value="Close">Close</option>
                                                                                        <option value="Obsolete">Obsolete</option>
                                                                                        <option value="Cancel">Cancel</option>-->
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <th style="text-align: left">Remarks</th>
                                <td colspan="3"><input type="text" name="remark" id="remark" size="50" ></td>
                            </tr>
                            <tr>
                                <td colspan="4" align="center">
                                    <input type="reset" value="Reset" id="popUpYes" class="but">
                                    &nbsp;&nbsp;&nbsp;&nbsp;
                                    <input type="submit" value="Save" class="but">                                            
                                </td>
                            </tr>   
                        </table>
                    </form>
                </div>                                                                 
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


        <%

                con.close();
            } catch (Exception e) {
                out.println(e);
            }
        %>


    </body>
</html>
