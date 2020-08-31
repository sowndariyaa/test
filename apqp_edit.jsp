<%-- 
    Document   : apqp_edit
    Created on : 1 Apr, 2019, 3:00:06 PM
    Author     : AV-IT-PC428
--%>

<%@page import="java.sql.DriverManager"%>
<%@page import="getDateEMAC.getShippingDate"%>
<%@page import="java.util.ArrayList"%>
<%@page import="getDateEMAC.getPhase"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="EMAC.Database_Connection"%>

<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"  contentType="text/html"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Engineering Management And Control</title>
        <link rel="stylesheet" href="css/css2.css">      
        <link rel="stylesheet" href="css/edit_newapqp.css">            
        <link rel="stylesheet" href="css/jquery-ui.css">
        <link rel="stylesheet" href="/resources/demos/style.css">
        <script src="src/jquery-1.12.4.js"></script>
        <script src="src/jquery-ui.js"></script>
        <script>
            $(function () {
                $("#tabs").tabs();
            });
        </script>
        <script>
            $(function () {
                $("#tabs").tabs();
            });
        </script>
        <!-- 
        Start of downloading Excel
        -->
        <script>

            var tablesToExcel = (function () {
                var uri = 'data:application/vnd.ms-excel;base64,'
                        , tmplWorkbookXML = '<?xml version="1.0"?><?mso-application progid="Excel.Sheet"?><Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet" xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet">'
                        + '<DocumentProperties xmlns="urn:schemas-microsoft-com:office:office"><Author>Axel Richter</Author><Created>{created}</Created></DocumentProperties>'
                        + '<Styles>'
                        + '<Style ss:ID="Currency"><NumberFormat ss:Format="Currency"></NumberFormat></Style>'
                        + '<Style ss:ID="Date"><NumberFormat ss:Format="Medium Date"></NumberFormat></Style>'
                        + '</Styles>'
                        + '{worksheets}</Workbook>'
                        , tmplWorksheetXML = '<Worksheet ss:Name="{nameWS}"><Table>{rows}</Table></Worksheet>'
                        , tmplCellXML = '<Cell{attributeStyleID}{attributeFormula}><Data ss:Type="{nameType}">{data}</Data></Cell>'
                        , base64 = function (s) {
                            return window.btoa(unescape(encodeURIComponent(s)))
                        }
                , format = function (s, c) {
                    return s.replace(/{(\w+)}/g, function (m, p) {
                        return c[p];
                    })
                }
                return function (tables, wsnames, wbname, appname) {
                    var ctx = "";
                    var workbookXML = "";
                    var worksheetsXML = "";
                    var rowsXML = "";

                    for (var i = 0; i < tables.length; i++) {
                        if (!tables[i].nodeType)
                            tables[i] = document.getElementById(tables[i]);
                        for (var j = 0; j < tables[i].rows.length; j++) {
                            rowsXML += '<Row>'
                            for (var k = 0; k < tables[i].rows[j].cells.length; k++) {
                                var dataType = tables[i].rows[j].cells[k].getAttribute("data-type");
                                var dataStyle = tables[i].rows[j].cells[k].getAttribute("data-style");
                                var dataValue = tables[i].rows[j].cells[k].getAttribute("data-value");
                                dataValue = (dataValue) ? dataValue : tables[i].rows[j].cells[k].innerHTML;
                                var dataFormula = tables[i].rows[j].cells[k].getAttribute("data-formula");
                                dataFormula = (dataFormula) ? dataFormula : (appname == 'Calc' && dataType == 'DateTime') ? dataValue : null;
                                ctx = {attributeStyleID: (dataStyle == 'Currency' || dataStyle == 'Date') ? ' ss:StyleID="' + dataStyle + '"' : ''
                                    , nameType: (dataType == 'Number' || dataType == 'DateTime' || dataType == 'Boolean' || dataType == 'Error') ? dataType : 'String'
                                    , data: (dataFormula) ? '' : dataValue
                                    , attributeFormula: (dataFormula) ? ' ss:Formula="' + dataFormula + '"' : ''
                                };
                                rowsXML += format(tmplCellXML, ctx);
                            }
                            rowsXML += '</Row>'
                        }
                        ctx = {rows: rowsXML, nameWS: wsnames[i] || 'Sheet' + i};
                        worksheetsXML += format(tmplWorksheetXML, ctx);
                        rowsXML = "";
                    }

                    ctx = {created: (new Date()).getTime(), worksheets: worksheetsXML};
                    workbookXML = format(tmplWorkbookXML, ctx);

                    console.log(workbookXML);

                    var link = document.createElement("A");
                    link.href = uri + base64(workbookXML);
                    link.download = wbname || 'Workbook.xls';
                    link.target = '_blank';
                    document.body.appendChild(link);
                    link.click();
                    document.body.removeChild(link);
                }
            })();
        </script>   

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
            function myFunctionfeeds(val) {

                if (val == "Re-Submission") {

                    var ss = '<th colspan="1">Re-submission Feedback</th>\n\
                                <td colspan="3">\n\
                                <select name="resub" id="resub">\n\
                                        <option></option>\n\
                                        <option value="Accepted">Accepted</option>\n\
                                        <option value="Rejected">Rejected</option>\n\
                                        <option value="Re-Submission">Re-Submission</option>\n\
                                        <option value="Next PO Received">Next PO Received</option>\n\
                                </select>\n\
                                </td>';

                    var ss1 = '<th colspan="1">Re-Submission Feedback Remarks</th>  \n\
                                <td colspan="3">\n\
                                    <input type="text" name="feedback_rem" id="feedback_rem">\n\
                                </td>';
                    document.getElementById("feed1").innerHTML = ss;
                    document.getElementById("feed2").innerHTML = ss1;

                } else {
                    document.getElementById("feed1").innerHTML = "";
                    document.getElementById("feed2").innerHTML = "";
                }
            }
        </script>
        <style>

            body{
                font-family:Verdana, Geneva, sans-serif;
                font-size:14px;}

            #slidingDiv {
                height:2120px;
                width:943px;
                background-color: #EFF3E5;
                padding:10px;
                margin-top:10px;
                border-bottom:5px solid #EFF3E5;
                display:none;
            }
            #slidingDiv_2{
                height:2250px;
                background-color: #EFF3E5;
                padding:10px;
                width:950px;
                margin-top:10px;
                border-bottom:5px solid #EFF3E5;
                display:none;    
            }

            #slidingDiv1{
                height:1200px;
                background-color: #EFF3E5;
                padding:20px;
                margin-top:10px;
                border-bottom:5px solid #EFF3E5;
                display:none;
            }
            #slidingDiv_21{
                height:1400px;
                background-color: #EFF3E5;
                padding:20px;
                margin-top:10px;
                border-bottom:5px solid #EFF3E5;
                display:none;
            }
            #slidingDiv11{
                height:930px;
                background-color: #EFF3E5;
                padding:20px;
                margin-top:10px;
                border-bottom:5px solid #EFF3E5;
                display:none;  
            }

            #slidingDiv_211{
                height:1300px;
                background-color: #EFF3E5;
                padding:20px;
                margin-top:10px;
                border-bottom:5px solid #EFF3E5;
                display:none;
            }

            #slidingDiv111, #slidingDiv_2111{
                height:1300px;
                background-color: #EFF3E5;
                padding:20px;
                margin-top:10px;
                border-bottom:5px solid #EFF3E5;
                display:none;
            }
            #slidingDiv_21112{
                height:1170px;
                background-color: #EFF3E5;
                padding:10px;
                margin-top:10px;
                border-bottom:5px solid #EFF3E5;
                display:none;
            }
            #slidingDiv_21113{
                height:10800px;
                background-color: #EFF3E5;
                padding:10px;
                margin-top:10px;
                border-bottom:5px solid #EFF3E5;
                display:none;
            }
        </style>
        <script src="src/showHide.js"></script>
        <script type="text/javascript">

            $(document).ready(function () {


                $('.show_hide').showHide({
                    speed: 1000, // speed you want the toggle to happen	
                    easing: '', // the animation effect you want. Remove this line if you dont want an effect and if you haven't included jQuery UI
                    changeText: 1, // if you dont want the button text to change, set this to 0
                    showText: 'PHASE I PCBA View', // the button text to show when a div is closed
                    hideText: 'PHASE I PCBA Close' // the button text to show when a div is open

                });


            });

            $(document).ready(function () {
                $('.show_hide1').showHide({
                    speed: 1000, // speed you want the toggle to happen	
                    easing: '', // the animation effect you want. Remove this line if you dont want an effect and if you haven't included jQuery UI
                    changeText: 1, // if you dont want the button text to change, set this to 0
                    showText: 'PHASE II PCBA View', // the button text to show when a div is closed
                    hideText: 'PHASE II PCBA Close' // the button text to show when a div is open

                });


            });

            $(document).ready(function () {


                $('.show_hide2').showHide({
                    speed: 1000, // speed you want the toggle to happen	
                    easing: '', // the animation effect you want. Remove this line if you dont want an effect and if you haven't included jQuery UI
                    changeText: 1, // if you dont want the button text to change, set this to 0
                    showText: 'PHASE III PCBA View', // the button text to show when a div is closed
                    hideText: 'PHASE III PCBA Close' // the button text to show when a div is open

                });


            });

            $(document).ready(function () {


                $('.show_hide3').showHide({
                    speed: 1000, // speed you want the toggle to happen	
                    easing: '', // the animation effect you want. Remove this line if you dont want an effect and if you haven't included jQuery UI
                    changeText: 1, // if you dont want the button text to change, set this to 0
                    showText: 'PHASE IV View', // the button text to show when a div is closed
                    hideText: 'PHASE IV Close' // the button text to show when a div is open

                });


            });

            $(document).ready(function () {


                $('.show_hide4').showHide({
                    speed: 1000, // speed you want the toggle to happen	
                    easing: '', // the animation effect you want. Remove this line if you dont want an effect and if you haven't included jQuery UI
                    changeText: 1, // if you dont want the button text to change, set this to 0
                    showText: 'Others View', // the button text to show when a div is closed
                    hideText: 'Others Close' // the button text to show when a div is open

                });


            });

            $(document).ready(function () {


                $('.show_hide5').showHide({
                    speed: 1000, // speed you want the toggle to happen	
                    easing: '', // the animation effect you want. Remove this line if you dont want an effect and if you haven't included jQuery UI
                    changeText: 1, // if you dont want the button text to change, set this to 0
                    showText: 'Manufacturability View', // the button text to show when a div is closed
                    hideText: 'Manufacturability Close' // the button text to show when a div is open

                });


            });
        </script>  

        <!--SIG-->
        <script>

            $(document).ready(function () {


                $('.show_hider').showHide({
                    speed: 1000, // speed you want the toggle to happen	
                    easing: '', // the animation effect you want. Remove this line if you dont want an effect and if you haven't included jQuery UI
                    changeText: 1, // if you dont want the button text to change, set this to 0
                    showText: 'PHASE I SIG View', // the button text to show when a div is closed
                    hideText: 'PHASE I SIG Close' // the button text to show when a div is open

                });


            });

            $(document).ready(function () {


                $('.show_hidere').showHide({
                    speed: 1000, // speed you want the toggle to happen	
                    easing: '', // the animation effect you want. Remove this line if you dont want an effect and if you haven't included jQuery UI
                    changeText: 1, // if you dont want the button text to change, set this to 0
                    showText: 'PHASE II SIG View', // the button text to show when a div is closed
                    hideText: 'PHASE II SIG Close' // the button text to show when a div is open

                });


            });

            $(document).ready(function () {


                $('.show_hideres').showHide({
                    speed: 1000, // speed you want the toggle to happen	
                    easing: '', // the animation effect you want. Remove this line if you dont want an effect and if you haven't included jQuery UI
                    changeText: 1, // if you dont want the button text to change, set this to 0
                    showText: 'PHASE III SIG View', // the button text to show when a div is closed
                    hideText: 'PHASE III SIG Close' // the button text to show when a div is open

                });


            });

            $(document).ready(function () {


                $('.show_hideresh').showHide({
                    speed: 1000, // speed you want the toggle to happen	
                    easing: '', // the animation effect you want. Remove this line if you dont want an effect and if you haven't included jQuery UI
                    changeText: 1, // if you dont want the button text to change, set this to 0
                    showText: 'SIG View', // the button text to show when a div is closed
                    hideText: 'SIG Close' // the button text to show when a div is open

                });


            });
        </script>
        <script>
            function shipment_date() {
                var x = document.getElementById("com_input_date").value;
                if (x == "" || x == null) {
                    alert("Complete Input from Customer Received Date Empty!");
                    document.getElementById("meet_date").value = ""
                    document.getElementById("com_input_date").focus();
                    return false;

                }
            }
        </script>


        <script>
            function sendRedirect(val) {
//                var x = document.getElementById("action_for").value;
                if (val == "All") {
                    var c = document.getElementById("apqp").value;
                    window.location.href = "action_point_close.jsp?apqp_no=" + c;
                }
            }
        </script>
        <script>
            function checkValid(val) {
                if (val == "" || val == null) {

                } else {
                    var v = document.getElementById("ps_status").value;
                    if (v == "FG" || v == "SFG") {

                    } else {
                        alert("Product Status Only For (FG/SFG)");
                        document.getElementById("ps_status").focus();
                        return false;
                    }
                }
            }
        </script>
        <script>
            function Validation() {
                var sd = document.getElementById("ship_date").value;
                var md = document.getElementById("meet_date").value;
                var cd = document.getElementById("com_input_date").value;

                if (md == "" || md == null) {
                } else {
                    var crd = document.getElementById("remarks").value;
                    if (crd == "" || crd == null) {
                        alert("CRD Remarks is Empty !");
                        document.getElementById("remarks").focus();
                        return false;
                    }
                    var meet = document.getElementById("com_input_date").value;
                    if (meet == "") {
                        alert("Complete Input Date is Empty !");
                        document.getElementById("com_input_date").focus();
                        return false;
                    } else {
                    }
                    var ship_date = document.getElementById("ship_date").value;
                    if (ship_date == "") {
                        alert("Shipment Date is Empty !");
                        document.getElementById("ship_date").focus();
                        return false;
                    } else {
                    }
                }

                var cusfeed = document.getElementById("feed").value;
                if (cusfeed == "Accepted" || cusfeed == "Next PO Received") {

                    var feedrem = document.getElementById("feedrem").value;
                    if (feedrem == "" || feedrem == null || feedrem == "null") {
                        alert("Feedback Remarks	is Empty !");
                        document.getElementById("feedrem").focus();
                        return false;
                    }
                    var feed_sto = document.getElementById("feed_sto").value;
                    if (feed_sto == "" || feed_sto == null || feed_sto == "null") {
                        alert("Customer Feedback Storage Location is Empty ! ");
                        document.getElementById("feed_sto").focus();
                        return false;
                    }
                } else if (cusfeed == "Rejected" || cusfeed == "Re-Submission") {

                    var feedrem = document.getElementById("feedrem").value;
                    if (feedrem == "" || feedrem == null || feedrem == "null") {
                        alert("Feedback Remarks	is Empty !");
                        document.getElementById("feedrem").focus();
                        return false;
                    }
                }



                var x = document.getElementById("meet_date").value;
                if (x == "" || x == null) {
                } else {

                    var v = document.getElementById("ps_status").value;
                    if (v == "FG" || v == "SFG") {

                    } else {
                        alert("Product Status Only For (FG/SFG)");
                        document.getElementById("ps_status").focus();
                        return false;
                    }

//                    var basicfile = document.getElementById("basicfile").value;
//                    if (basicfile == "" || basicfile == null) {
//                        alert("Select PDF for Basic Input and Capacity Planning ! ");
//                        document.getElementById("basicfile").focus();
//                        return false;
//                    }




                }

                var cusfeed = document.getElementById("feed").value;
                if (cusfeed == "" || cusfeed == null) {
                } else {
                    var feedstor = document.getElementById("feed_sto").value;
                    if (feedstor == "" || feedstor == null) {
                        alert("Customer Feedback Storage Location Empty ! ");
                        document.getElementById("feed_sto").focus();
                        return false;
                    }
                }

            }


        </script>
    </head>
    <body>
        <div id="main">

            <%@include file="header.jsp" %>   

            <%                try {

                    HttpSession sessions = request.getSession(true);
                    String team = (String) session.getAttribute("team");
                    String access = (String) session.getAttribute("access");
                    String username = (String) session.getAttribute("username");

                    Database_Connection obj = new Database_Connection();
                    Connection con = obj.getConnection();
                    Statement st = con.createStatement();
                    Statement st_1 = con.createStatement();
                    Statement st1 = con.createStatement();
                    Statement sts2 = con.createStatement();
                    Statement sts3 = con.createStatement();
                    Statement sts4 = con.createStatement();
                    Statement sts5 = con.createStatement();
                    Statement sts6 = con.createStatement();
                    Statement sts = con.createStatement();
                    Statement sts1 = con.createStatement();
                    String apqp_no = request.getParameter("apqp");
//                    apqp_no = "APQ-00002";
                    session.setAttribute("apqp", apqp_no);

                    String p = request.getParameter("p");

                    Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                    String url1, username1, password1;
                    url1 = "jdbc:sqlserver://10.44.50.15;databaseName=Av_ppc";
                    username1 = "balaji_sap";
                    password1 = "sap123";
                    Connection con1 = DriverManager.getConnection(url1, username1, password1);
                    Statement stx = con1.createStatement();

//                    out.print("<BR> APQP No : "+apqp_no);
//                    out.print("<BR> Page No : "+p);
                    Date apqp_meeting_date = null;
                    Date initial_input = null;
                    Date complete_input = null;
                    Date customer_req_date = null;
                    Date closure_meeting_date = null;
                    Date shipment_date = null;

                    getPhase cls = new getPhase();

                    ResultSet ch = null;
                    ResultSet ch1 = null;
                    ResultSet ch2 = null;
                    ResultSet ch3 = null;
                    ResultSet ch4 = null;
                    ResultSet ch5 = null;
                    ResultSet ch6 = null;

                    DateFormat df = new SimpleDateFormat("dd/MM/yyyy ");
                    java.util.Date today = Calendar.getInstance().getTime();
                    String todaydate = df.format(today);

                    String product_names = "", pcba_part_nos = "", sig_part_nos = "", proto_qtys = "", prod_sold_processs = "", apps = "", project_leaders = "", pcb_sigs = "", class_prods = "";
                    String pcb_prod_names = "", sig_prod_names = "", pcb_cust_names = "", sig_cust_names = "", ship_date = "";
                    Date meeting_dates = null;
                    Date crds = null;
                    Date shipment_dates = null;

                    String class_prod = "";
                    String pcb_sig = "", customer_name = "", recipt_of_testing = "", receipt_of_bom = "", receipt_of_gbr = "", receipt_of_ain = "", recipt_of_pgm_file = "", receipt_of_xy = "", crd_remark = "", affect_doc_status = "", cust_doc_update_storage = "", cust_feedback = "", resub_feedback = "", feedback_remark = "", cust_feedback_storage = "", ppap_req = "", product_category = "", prod_cat_remark = "", input_status = "", shiped_part = "", pro_qty = "", project_leader = "", prod_sold_process = "", applications = "", validation = "", status = "", remark = "", pcba_part_no = "", sig_part_no = "", cust_part_no = "", pcba_rev = "", sig_revision = "";
                    String resub_remark = "";
                    String pcb_engineer = "", sig_engineer = "";
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

                    <input type="hidden" name="apqp" id="apqp" value="<%=apqp_no%>">
                    <%

                        String plant = "";
                        ch3 = sts3.executeQuery("select plant from  apqp_master where apqp_no='" + apqp_no + "' ");
                        while (ch3.next()) {
                            plant = ch3.getString(1);
                        }

                        getShippingDate cls1 = new getShippingDate();
                        String fair_rep = "";
                        ch = sts.executeQuery("select a.apqp_meeting_date,a.initial_input,a.complete_input,a.pcb_sig,a.customer_name,a.recipt_of_testing,"
                                + "a.receipt_of_bom,a.receipt_of_gbr,a.receipt_of_ain,a.recipt_of_pgm_file,a.receipt_of_xy,"
                                + "a.customer_req_date,a.crd_remark,a.closure_meeting_date,a.affect_doc_status,a.cust_doc_update_storage,"
                                + "a.cust_feedback,a.resub_feedback,a.feedback_remark,a.cust_feedback_storage,a.ppap_req,a.product_category,"
                                + "a.prod_cat_remark,a.input_status,a.shiped_part,a.pro_qty,a.project_leader,a.prod_sold_process,a.application,"
                                + "a.validation,a.status,a.remark,b.pcba_part_no,b.sig_part_no,b.cust_part_no,b.pcba_rev,b.sig_revision,"
                                + "a.shipment_date,a.class_product,a.resub_feedback_remark,a.fair_report,a.pcb_engineer,sig_engineer from  apqp_eil as a join  apqp_aps as b on a.apqp_no=b.apqp_no "
                                + "where a.apqp_no='" + apqp_no + "'");
                        while (ch.next()) {
                            apqp_meeting_date = ch.getDate(1);
                            initial_input = ch.getDate(2);
                            complete_input = ch.getDate(3);
                            pcb_sig = ch.getString(4);
                            customer_name = ch.getString(5);
                            recipt_of_testing = ch.getString(6);
                            receipt_of_bom = ch.getString(7);
                            receipt_of_gbr = ch.getString(8);
                            receipt_of_ain = ch.getString(9);
                            recipt_of_pgm_file = ch.getString(10);
                            receipt_of_xy = ch.getString(11);
                            customer_req_date = ch.getDate(12);
                            crd_remark = ch.getString(13);
                            closure_meeting_date = ch.getDate(14);
                            affect_doc_status = ch.getString(15);
//                            out.print(affect_doc_status);
                            cust_doc_update_storage = ch.getString(16);
                            cust_feedback = ch.getString(17);
                            resub_feedback = ch.getString(18);
                            feedback_remark = ch.getString(19);
                            cust_feedback_storage = ch.getString(20);
                            ppap_req = ch.getString(21);
                            product_category = ch.getString(22);
                            prod_cat_remark = ch.getString(23);
                            input_status = ch.getString(24);
                            shiped_part = ch.getString(25);
                            pro_qty = ch.getString(26);
                            project_leader = ch.getString(27);
                            prod_sold_process = ch.getString(28);
                            applications = ch.getString(29);
                            validation = ch.getString(30);
                            status = ch.getString(31);
                            remark = ch.getString(32);
                            pcba_part_no = ch.getString(33);
                            sig_part_no = ch.getString(34);
                            cust_part_no = ch.getString(35);
                            pcba_rev = ch.getString(36);
                            sig_revision = ch.getString(37);
                            shipment_date = ch.getDate(38);
                            class_prod = ch.getString(39);
                            resub_remark = ch.getString(40);
                            fair_rep = ch.getString(41);
                            pcb_engineer = ch.getString(42);
                            sig_engineer = ch.getString(43);

                        }

                        String pcba_prod_name = "";
                        ch1 = sts1.executeQuery("select a.prod_name from  product_master_pcb as a join  apqp_aps as b on a.part_no=b.pcba_part_no where b.apqp_no='" + apqp_no + "' ");
                        while (ch1.next()) {
                            pcba_prod_name = ch1.getString(1);
                        }

                        String sig_prod_name = "";
                        ch2 = sts2.executeQuery("select a.prod_name from  product_master_sig as a join  apqp_aps as b on a.part_no=b.sig_part_no where b.apqp_no='" + apqp_no + "' ");
                        while (ch2.next()) {
                            sig_prod_name = ch2.getString(1);
                        }

                        if (p.equals("0")) {
                    %>  


                    <h1>Engineering Input Logging <%=apqp_no%></h1>
                    <a href="apqp_rclose.jsp?apqp_no=<%=apqp_no%>"><input type="button" value="Review and Close" class="but"></a>
                    <form name="first" action="review_close.jsp" method="post" />
                    <input type="hidden" name="number" value="<%=apqp_no%>"/>
                    <input type="hidden" name="type" value="APQP"/>
                    <!--<input type="submit" value="&nbsp;Review And Close &nbsp;" class="but"/>-->
                    <!--<a href="vpdf.jsp" target="_blank">View Pdf</a>-->
                    </form>                                        
                    <form action="edit_1"   onsubmit="return Validation()" method="post" enctype="multipart/form-data" name="form">
                        
                        <!--<form action="#" method="post" onsubmit="return Validation()">-->
                        <table id="tbl1" class="table1excel">
                            <tr>
                                <th  colspan="4" style="text-align: center">Advanced Product Quality Planning</th>
                            </tr>
                            <tr>
                                <th style="text-align: left">Plant</th>
                                <td colspan="3">
                                    <input type="text" name="plants" id="plants" value="<%=plant%>" readonly="">

                                </td>
                            </tr>
                            <tr>
                                <th style="text-align: left">APQP Number</th>
                                <td colspan="3"><input type="text" name="apqp" id="apqp" value="<%=apqp_no%>" readonly=""></td>
                            </tr>
                            <tr>
                                <th style="text-align: left">Customer Name</th>
                                <td colspan="3"><input type="text" name="cust_name" id="cust_name" value="<%=customer_name%>" readonly="" size="50"></td>
                            </tr>
                            <tr>
                                <th style="text-align: left">Initial Input From Customer Received On</th>
                                <td colspan="3"><input type="date" name="cust_rec" value="<%=initial_input%>"></td>
                            </tr>
                            <tr>
                                <th style="text-align: left">APQP Meeting Date</th>
                                <!--<td colspan="3"><input type="date" name="apqp_meet" class="datepicker_recurring_start" value="<%//=apqp_meeting_date%>"></td>-->
                                <td colspan="3"><input type="date" name="apqp_meet" id="meet_date1" value="<%=apqp_meeting_date%>" ></td>
                            </tr>
                            <tr>
                                <th style="text-align: left">PCB/SIG</th>
                                <td colspan="3"><select name="pcb" id="pcb" >
                                        <option value="<%=pcb_sig%>"><%=pcb_sig%></option>                     
                                        <option value="PCB">PCB</option>
                                        <option value="SIG">SIG</option>
                                        <option value="PCB & SIG">PCB & SIG</option>
                                    </select>
                                </td>
                            </tr>  
                            <tr>
                                <th style="text-align: left">PCBA Product Name</th>
                                <td colspan="3"><%=pcba_prod_name%></td>
                            </tr>
                            <tr>
                                <th style="text-align: left">PCBA Part Number</th>
                                <td colspan="3"><input type="text" name="part_no" id="part_no" value="<%=pcba_part_no%>" readonly=""></td>
                            </tr>
                            <tr>
                                <th style="text-align: left">PCBA Revision</th>
                                <td colspan="3"><input type="text" name="rev" id="rev" value="<%=pcba_rev%>" readonly=""></td>
                            </tr>
                            <tr>
                                <th>SIG Product Name</th>
                                <td colspan="3"><%=sig_prod_name%></td>
                            </tr>
                            <tr>
                                <th>SIG Part Number</th>
                                <td colspan="3">
                                    <%
                                        if (sig_part_no.equals("") || sig_part_no.equals("null") || sig_part_no.equals("NULL"))
                                    %>
                                    <input type="text" name="sig_part" id="sig_part" value="<%=sig_part_no%>" readonly=""></td>
                            </tr>
                            <tr>
                                <th>SIG Revision</th>
                                    <%
                                        if (sig_revision.equals("null")) {
                                    %>
                                <td colspan="3"><input type="text" name="sig_rev" id="sig_rev" value="" readonly=""></td>
                                    <%} else {%>

                                <td colspan="3"><input type="text" name="sig_rev" id="sig_rev" value="<%=sig_revision%>" readonly=""></td>

                                <%}%>
                            </tr>
                            <tr>
                                <th style="text-align: left">Customer Part Number</th>
                                <td colspan="3"><input type="text" name="cust_part_no" id="cust_part_no" value="<%=cust_part_no%>"></td>
                            </tr>

                            <tr>
                                <th style="text-align: left">PCBA Engineer</th>
                                <td colspan="3"><input type="text" name="pcb_eng" id="pcb_eng" value="<%=pcb_engineer%>" readonly="" required=""></td>
                            </tr>
                            <tr>
                                <th style="text-align: left">SIG Engineer</th>
                                <td colspan="3"><input type="text" name="sig_eng" id="sig_eng" value="<%=sig_engineer%>" readonly="" required=""></td>
                            </tr>



                            <tr>
                                <th style="text-align: left">Product Status(FG/SFG)</th>
                                <td colspan="3">
                                    <select name="status" id="ps_status" >
                                        <option value="<%=affect_doc_status%>"><%=affect_doc_status%></option>
                                        <!--<option value="FG"</option>-->
                                        <option value="FG">FG</option>
                                        <option value="SFG">SFG</option>
                                        <option value="TBD">TBD</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <th style="text-align: left">Customer Required Date</th>
                                <td colspan="3"><input type="text" name="cust_req"   value="<%=customer_req_date%>" class="datepicker_recurring_start"></td>
                            </tr>
                            <tr>
                                <th style="text-align: left">Product Category</th>
                                <td colspan="4"><select name="category" id="category">
                                        <option value="<%=product_category%>"><%=product_category%></option>
                                        <option value="Automotive">Automotive</option>
                                        <option value="Non Automotive">Non Automotive</option>                                        
                                    </select></td>
                            </tr>
                            <tr>
                                <th style="text-align: left">PPAP Requirements</th>
                                <td colspan="3">
                                    <select name="ppap" id="ppap">

                                        <option value="<%=ppap_req%>"><%=ppap_req%></option>
                                        <option value="Yes">Yes</option>
                                        <option value="No">No</option>
                                        <option value="NA">NA</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <th>Project leader</th>
                                <td colspan="3"><input type="text" name="leader" id="leader" value="<%=project_leader%>"></td>
                            </tr>
                            <tr>
                                <th>Proto Quantity</th>
                                <td colspan="3"><input type="text" name="qty" id="qty" value="<%=pro_qty%>"></td>
                            </tr>
                            <tr>
                                <th>Class of the Product</th>
                                <td colspan="3"><input type="text" name="class_prod" id="class_prod" value="<%=class_prod%>"></td>
                            </tr>
                            <tr>
                                <th>Product Soldering Process</th>
                                <td colspan="3">
                                    <select name="prod_sold" id="prod_sold">
                                        <option value="<%=prod_sold_process%>"><%=prod_sold_process%></option>
                                        <option value="RoHS">RoHS</option>
                                        <option value="Non-RoHS">Non-RoHS</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <th>Application</th>

                                <td colspan="3"><textarea name="app" id="app" value="<%=applications%>"   ><%=applications%></textarea></td>
                            </tr>
                            <tr>
                                <th style="text-align: left">Receipt of Testing(PROCEDURE/SOFTWARE)</th>
                                <td colspan="3"><select name="testing" id="testing">
                                        <option value="<%=recipt_of_testing%>"><%=recipt_of_testing%></option>
                                        <option value="Yes">Yes</option>
                                        <option value="No">No</option>
                                        <option value="NA">NA</option>

                                    </select></td>
                            </tr>
                            <tr>
                                <th style="text-align: left">Receipt of BOM</th>
                                <td colspan="3"><select name="bom" id="bom">
                                        <option value="<%=receipt_of_bom%>"><%=receipt_of_bom%></option>
                                        <option value="Yes">Yes</option>
                                        <option value="No">No</option>
                                        <option value="NA">NA</option>

                                    </select></td>
                            </tr>
                            <tr>
                                <th style="text-align: left">Receipt of GBR</th>
                                <td colspan="3"><select name="gbr" id="gbr">
                                        <option value="<%=receipt_of_gbr%>"><%=receipt_of_gbr%></option>
                                        <option value="Yes">Yes</option>
                                        <option value="No">No</option>
                                        <option value="NA">NA</option>

                                    </select></td>
                            </tr>
                            <tr>
                                <th style="text-align: left">Receipt of AIN(PCB/SIG)</th>
                                <td colspan="3"><select name="ain" id="ain">
                                        <option value="<%=receipt_of_ain%>"><%=receipt_of_ain%></option>
                                        <option value="Yes">Yes</option>
                                        <option value="No">No</option>
                                        <option value="NA">NA</option>

                                    </select></td>
                            </tr>
                            <tr>
                                <th style="text-align: left">Receipt of Program Files</th>
                                <td colspan="3"><select name="file" id="file">
                                        <option value="<%=recipt_of_pgm_file%>"><%=recipt_of_pgm_file%></option>
                                        <option value="Yes">Yes</option>
                                        <option value="No">No</option>
                                        <option value="NA">NA</option>

                                    </select></td>
                            </tr>
                            <tr>
                                <th style="text-align: left">Receipt of XY</th>
                                <td colspan="3">
                                    <select name="xy" id="xy">
                                        <option value="<%=receipt_of_xy%>"><%=receipt_of_xy%></option>
                                        <option value="Yes">Yes</option>
                                        <option value="No">No</option>
                                        <option value="NA">NA</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <th style="text-align: left">Customer Document Updated In Storage Location</th>
                                <td colspan="3"><textarea name="store_loc" id="store_loc" value="<%=cust_doc_update_storage%>" size="50"><%=cust_doc_update_storage%></textarea></td>
                            </tr>
                            <tr>
                                <th style="text-align: left">Input Status</th>
                                <td colspan="3">
                                    <select name="input" id="input">
                                        <option value="<%=input_status%>"><%=input_status%></option>
                                        <option value="All">All</option>
                                        <option value="Partial">Partial</option>
                                        <option value="NA">NA</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <th style="text-align: left">Complete Input From Customer Received On</th>
                                <td colspan="3"><input type="date" name="comp_cust_rec" id="com_input_date" value="<%=complete_input%>"></td>
                            </tr>
                            <tr>
                                <th style="text-align: left">Validation</th>
                                <td colspan="3">
                                    <select name="valid" id="valid">
                                        <option value="<%=validation%>"><%=validation%></option>
                                        <option value="Yes">Yes</option>
                                        <option value="No">No</option>
                                        <option value="NA">NA</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>

                                <th>Shipment Date :
                                    <%

                                        if (affect_doc_status.equals("FG")) {

                                            if (!sig_part_no.equals("")) {

                                                ResultSet r3 = st.executeQuery("select plant from  product_master where sig_part_no='" + sig_part_no + "'");
                                                while (r3.next()) {
                                                    plant = r3.getString(1);
                                                }
                                                ResultSet r2 = stx.executeQuery("select top 1 inserted_date from invoice_history_b7 where  apart_no='" + sig_part_no + "' order by id desc ");
                                                while (r2.next()) {
                                                    ship_date = r2.getString(1).substring(0, 10);
                                                }

                                            } else if (!pcba_part_no.equals("") && sig_part_no.equals("")) {

                                                ResultSet r3 = st.executeQuery("select plant from  product_master where part_no='" + pcba_part_no + "'");
                                                while (r3.next()) {
                                                    plant = r3.getString(1);
                                                }
                                                ResultSet r2 = stx.executeQuery("select top 1 inserted_date from invoice_history_b7 where  apart_no='" + pcba_part_no + "' order by id desc ");
                                                while (r2.next()) {
                                                    ship_date = r2.getString(1).substring(0, 10);
                                                }

                                            } else {
                                                ship_date = "-";
                                            }

                                        }

                                        if (affect_doc_status.equals("FG")) {
                                    %>
                                    <BR>Exim Shipping Date :
                                    <font style="color: #000678;font-size: 16px;">
                                    <%
//                                        out.print(ship_date);
                                    %>       
                                    </font>
                                    <%                                        }
                                    %>
                                    <BR> 
                                </th>
                                <td colspan="3">
                                    <input type="date" name="ship_date" id="ship_date"  value="<%=ship_date%>" onfocusout="return shipment_date()" >
                                </td>
                            </tr>
                            <tr>
                                <th style="text-align: left">Closure Meeting Date</th>
                                <td colspan="3"><input type="date" name="meeting" id="meet_date"  value="<%=closure_meeting_date%>" ></td>
                            </tr>
                            <tr>
                                <th style="text-align: left">CRD Remarks</th>
                                <td colspan="3"><input type="text" name="remarks" id="remarks" value="<%=crd_remark%>"></td>
                            </tr>
                            <tr>
                                <td>Fair Report</td>
                                <%
                                    if (fair_rep == null) {

                                %> 

                                <td>
                                    <input type="text" name="fair_report" value="<%=""%>">
                                </td>

                                <%
                                } else {
                                %>
                                <td>
                                    <input type="text" name="fair_report" value="<%=fair_rep%>">
                                </td>
                                <%
                                    }
                                %>
                            </tr>

                            <%
                                // out.print(cust_feedback);
                                if (cust_feedback.equals("Re-Submission")) {
                                    //    out.print(feedback_remark);
%>
                            <tr>
                                <th style="text-align: left" >Customer Feedback</th>
                                <td colspan="3"><input type="text"  name="feed" value="<%=cust_feedback%>" readonly=""></td>
                            </tr>

                            <tr>
                                <th>Re-submission Feedback</th>  
                                <td>
                                    <select name="resub" id="resub">
                                        <option><%=resub_feedback%></option>
                                        <option value="Accepted">Accepted</option>
                                        <option value="Rejected">Rejected</option>
                                        <option value="Re-Submission">Re-Submission</option>
                                        <option value="Next PO Received">Next PO Received</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <th>Re-Submission Feedback Remarks</th>
                                <td colspan="3"><input type="text" name="feedback_rem" id="feedback_rem" value="<%=resub_remark%>" size="50" required=""></td>
                            </tr>
                            <%
                            } else {
                            %>
                            <tr>
                                <th style="text-align: left">Customer Feedback</th>
                                <td colspan="3">
                                    <select name="feed" id="feed" onchange="myFunctionfeeds(this.value)" >
                                        <option value="<%=cust_feedback%>"><%=cust_feedback%></option>
                                        <option value="Accepted">Accepted</option>
                                        <option value="Rejected">Rejected</option>
                                        <option value="Re-Submission">Re-Submission</option>
                                        <option value="Next PO Received">Next PO Received</option>
                                    </select>
                                </td>
                            </tr>

                            <%
                                if (feedback_remark == null) {
                            %>

                            <tr>
                                <th>Feedback Remarks</th>
                                <td colspan="3"><input type="text" name="feedrem" id="feedrem" value="" size="50"></td>
                            </tr>
                            <%
                            } else {
                            %>
                            <tr>
                                <th>Feedback Remarks</th>
                                <td colspan="3"><input type="text" name="feedrem" id="feedrem" value="<%=feedback_remark%>" size="50"></td>
                            </tr>

                            <%}%>
                            <tr id="feed1"></tr>
                            <tr id="feed2"></tr>

                            <%
                                }
                            %>
                            <%
                                if (cust_feedback_storage == null) {
                            %>

                            <tr>
                                <th style="text-align: left">Customer Feedback Storage Location</th>
                                <td colspan="3"><textarea name="feed_sto" id="feed_sto" value=""></textarea></td>
                            </tr>
                            <%
                            } else {
                            %>
                            <tr>
                                <th style="text-align: left">Customer Feedback Storage Location</th>
                                <td colspan="3"><textarea name="feed_sto" id="feed_sto" value="<%=cust_feedback_storage%>"><%=cust_feedback_storage%></textarea></td>
                            </tr>

                            <%}%>
                            <tr>
                                <th style="text-align: left">Status</th>
                                <td colspan="3"><select name="stat" id="stat">
                                        <option value="<%=status%>"><%=status%></option>
                                        <option value="Open">Open</option>
                                        <!--                                        <option value="Close">Close</option>-->
                                        <option value="Obsolete">Obsolete</option>
                                        <option value="Cancel">Cancel</option>

                                    </select></td>
                            </tr>
                            <tr>
                                <th style="text-align: left">Remarks</th>
                                <td colspan="3"><input type="text" name="remark" id="remark" value="<%=remark%>" size="50"></td>
                            </tr>
                            <tr>
                                <td>Basic Input and Capacity Planning</td>
                                <td>
                                    <%
                                        int checkbf = 0;
                                        ResultSet rsbf = st.executeQuery("select basic_pdf from  apqp_basicpdf where apqp_no='" + apqp_no + "' ");
                                        while (rsbf.next()) {
                                            checkbf++;
                                        }
                                        if (checkbf > 0) {
                                    %>
                                    <a href="viewbf.jsp?apqp_no=<%=apqp_no%>" target="_blank"><img src="images/pdf.png" height="40" width="30"></a>
                                    <input type="file" name="basicfile" id="basicfile" >
                                    <%
                                    } else {
                                    %>                                                        
                                    <input type="file" name="basicfile" id="basicfile" >
                                    <%
                                        }
                                    %>
                                    <input type="hidden" name="checkbf" value="<%=checkbf%>">
                                </td>
                            </tr>

                            <!--                            <tr>
                                                            <th>Product Category Remark</th>
                                                            <td colspan="3"><input type="text" name="catrem" id="catrem" value="<%//=prod_cat_remark%>" size="50"></td>
                                                        </tr>-->
                            <tr>
                                <td colspan="2" align="center"><input type="submit" value="Submit" class="but"></td>
                            </tr>
                            <input type="hidden" name="apqp" id="apqp" value="<%=apqp_no%>">
                        </table>
                    </form>

                    <%
                    } else if (p.equals("1")) {
                    %>
                    <form action="edit_doc" method="post" >
                        <%
                            //String apqp_no="";
                            apqp_no = request.getParameter("apqp");

                            ArrayList<String> doc_for = new ArrayList();
                            ArrayList<String> document = new ArrayList();
                            ArrayList<String> doc_key = new ArrayList();

                            String prov_bom = "", stencil = "", apqp_status = "";
                            ch4 = sts4.executeQuery("select pro_bom,stencil,status from  apqp_master where apqp_no='" + apqp_no + "'");
                            while (ch4.next()) {
                                prov_bom = ch4.getString(1);
//                                        out.print("<br>" + prov_bom);
                                stencil = ch4.getString(2);
//                                         out.print("<br>" + stencil);
                                apqp_status = ch4.getString(3);
//                                         out.print("<br>" + apqp_status);
                            }
                        %>
                        <input type="hidden" name="apqp_status" id="apqp_status" value="<%=apqp_status%>">
                        <table id="tbl2" class="table2excel">
                            <tr>
                                <th  colspan="5" style="text-align: center">APQP Documents To Be Released</th>
                            </tr>
                            <tr>
                                <td colspan="2">APQP Number</td>
                                <td colspan="3"><input type="text" name="apqp" id="apqp" value="<%=apqp_no%>" readonly="" style="background: none;border: none;"></td>
                            </tr>                            
                            <tr>
                                <th>S No</th>
                                <th>Category</th>
                                <th>Document</th>
                                <th>Status</th>
                                <th>Remark</th>
                            </tr>
                            <%
                                int ic = 1;
                                ch5 = sts5.executeQuery("select id,document,doc_for,doc_released,remark  from  apqp_edc where apqp_no='" + apqp_no + "' ");
                                while (ch5.next()) {
                            %>
                            <tr><td><%=ic%>
                                <td><input type="text" name="category" value="<%=ch5.getString(3)%>" readonly="" style="width: 50px;border: none;background: none;"></td>
                                <td><%=ch5.getString(2)%></td>
                                <td>
                                    <input type="hidden" value="<%=ch5.getString(1)%>" name="dcid">
                                    <select name="statusdc">
                                        <option value="<%=ch5.getString(4)%>"><%=ch5.getString(4)%></option>
                                        <option value="Open">Open</option>
                                        <%if (team.equals("DC")) {%>
                                        <option value="Close">Close</option>
                                        <%} else if (access.equals("admin")) {%>
                                        <option value="Close">Close</option>
                                        <%}%>
                                        <option value="Hold">Hold</option>
                                        <option value="Obsolete">Obsolete</option>

                                    </select>
                                </td> 
                                <td><input type="text" name="remarkdc" value="<%=ch5.getString(5)%>"/></td></tr>
                                    <%
                                        doc_for.add(ch5.getString(3));
                                        document.add(ch5.getString(5));
                                        doc_key.add(ch5.getString(2));

                                        //                     for(String doc : doc_for){
                                        //                                             out.print("<BR>"+doc);
                                        //                     }
                                        //                  

                                    %>

                            <% ic++;
                                }%>   

                            <tr><td align="center" colspan="5">
                                    <input type="submit" value="Save" class="but">
                                </td>
                            </tr>
                        </table>
                    </form>
                    <form action="add_doc" method="post">
                        <table>
                            <tr>
                                <th  colspan="2">APQP Documents To Be Released</th>
                            </tr>
                            <tr>
                                <th style="text-align: left">APQP Number</th>
                                <td><input type="text" name="apqp" id="apqp" value="<%=apqp_no%>" readonly="" size="9"></td>
                            </tr>

                            <!--                            <tr>
                                                            <th>Provisional BOM</th>
                                                            <td>    
                                                                <select name="prov_bom" id="prov_bom">
                                                                    <option value="Open">Open</option>
                                                                    <option value="Close">Close</option>
                                                                    <option value="NA">NA</option>
                                                                </select>
                                                            </td></tr> 
                            
                                                        <tr>
                                                            <th>Stencil</th>
                                                            <td>    
                                                                <select name="stencil" id="stencil">
                                                                    <option value="Open">Open</option>
                                                                    <option value="Close">Close</option>
                                                                    <option value="NA">NA</option>
                                                                </select>
                                                            </td>
                                                        </tr> -->

                            <tr>
                                <th>Category</th>
                                <th>Document</th>
                            </tr>

                            <%
                                //String doc = "";
//                                for (int i = 0; i < doc_for.size(); i++) {
//                                    if (i == 0) {
//                                        doc = " doc_key not like '%" + doc_key.get(i) + "%'";
//                                    } else if (i > 0) {
//                                        doc = doc + " and doc_key not like '%" + doc_key.get(i) + "%' ";
//                                        
//                                    }
////                                            out.print(doc_key.get(i)+"<br>");
//                                }
                                //out.print(doc);
//                                if (doc.equals("")) {
//                                    ch6 = sts6.executeQuery("select id,doc_for,document from  document order by id ");
//                                } else {
//                                    ch6 = sts6.executeQuery("select id,doc_for,document from  document where  " + doc + " order by id ");
//                                }

                                // ResultSet stf = st.executeQuery("select ");
                                if (pcb_sig.toLowerCase().equals("pcb")) {
                                    ch6 = st.executeQuery("select id,doc_for,document from  document where doc_for='PCB' order by id");
                                    while (ch6.next()) {
                                        //out.print(ch6.getString(2));                                   
%>
                            <tr>
                                <td><%=ch6.getString(2)%></td>
                                <td><input type="checkbox" name="id" value="<%=ch6.getString(1)%>"/><%=ch6.getString(3)%></td>
                            </tr>
                            <%}%>
                            <%}
                                if (pcb_sig.toLowerCase().equals("sig")) {
                                    ResultSet stk = st.executeQuery("select id,doc_for,document from  document where doc_for='SIG' order by id");
                                    while (stk.next()) {
                                        //out.print(ch6.getString(2));                                   
%>
                            <tr>
                                <td><%=stk.getString(2)%></td>
                                <td><input type="checkbox" name="id" value="<%=stk.getString(1)%>"/><%=stk.getString(3)%></td>
                            </tr> 
                            <%}%>
                            <%}
                                if (pcb_sig.toLowerCase().equals("pcb & sig")) {
                                    ResultSet stk = st.executeQuery("select id,doc_for,document from  document where doc_for='SIG' or doc_for='PCB' order by doc_for");
                                    while (stk.next()) {
                                        //out.print(ch6.getString(2));                                   
%>
                            <tr>
                                <td><%=stk.getString(2)%></td>
                                <td><input type="checkbox" name="id" value="<%=stk.getString(1)%>"/><%=stk.getString(3)%></td>
                            </tr> 
                            <%}%>
                            <%}%>







                            <!--//                                ResultSet stk1 = st.executeQuery("select id,doc_for,document from  document where doc_for='GEN' order by id");-->
                            <!--//                                while (stk1.next()) {-->
                            <!--//                                    //out.print(ch6.getString(2));-->                                   
                            <!--//                            <tr>-->
                            <!--//                                <td>//stk1.getString(2)%></td>-->
                            <!--//                                <td><input type="checkbox" name="id" value=" //stk1.getString(1)"/>//stk1.getString(3)%></td>-->
                            <!--//                            </tr>-->                           

                            <tr>
                                <td align="center" colspan="2">
                                    <input type="submit" value="Save"  id="popUpYes" class="but" >
                                </td>
                            </tr>
                        </table>
                    </form>
                    <%
                    } else if (p.equals("2")) {
                        apqp_no = (String) session.getAttribute("apqp");
                    %>
                    <form action="edit_act_pts.jsp" method="post"  onsubmit="return Validation()" name="form">
                        <table>
                            <tr>
                                <th colspan="2" style="text-align: center;">APQP Action Points</th>
                            </tr>
                            <tr>
                                <td>Action Point</td>
                                <td>   
                                    <select name="action_for" id="action_for" onchange="sendRedirect(this.value)">
                                        <option value="Initial">Initial</option>
                                        <option value="Closure">Closure</option>
                                        <option value="Post APQP">Post APQP</option>
                                        <option value="Customer Feedback">Customer Feedback</option>
                                        <option value="All">All</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>APQP Number</td>
                                <td>
                                    <input type="text" name="apqp" id="apqp" value="<%=apqp_no%>" readonly="">
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" align="center"> 
                                    <input type="submit" value="Next"  id="popUpYes" class="but">
                                </td>
                            </tr>
                            <input type="hidden" name="apqp" id="apqp" <%=apqp_no%>>
                        </table>  


                    </form>    
                    <%
                    } else if (p.equals("3")) {

                        Statement st2 = null;
                        ResultSet rs = null;
                        ResultSet rs1 = null;
                        ResultSet rs2 = null;

                        st1 = con.createStatement();
                        st2 = con.createStatement();

                        rs = st.executeQuery("select a.pcba_part_no,a.sig_part_no,b.pro_qty,b.project_leader,b.prod_sold_process,b.application,b.customer_req_date,b.apqp_meeting_date,b.pcb_sig,b.shipment_date,b.class_product from  apqp_aps as a join  apqp_eil as b on a.apqp_no=b.apqp_no where a.apqp_no='" + apqp_no + "'");
                        while (rs.next()) {
                            pcba_part_nos = rs.getString(1);
                            sig_part_nos = rs.getString(2);
                            proto_qtys = rs.getString(3);
                            project_leaders = rs.getString(4);
                            prod_sold_processs = rs.getString(5);
                            apps = rs.getString(6);
                            crds = rs.getDate(7);
                            meeting_dates = rs.getDate(8);
                            pcb_sigs = rs.getString(9);
                            shipment_dates = rs.getDate(10);
                            class_prods = rs.getString(11);

                            rs1 = st1.executeQuery("select prod_name,customer_name from   product_master_pcb where part_no='" + rs.getString(1) + "'");
                            while (rs1.next()) {
                                pcb_prod_names = rs1.getString(1);
                                pcb_cust_names = rs1.getString(2);
                            }

                            rs2 = st2.executeQuery("select prod_name,customer_name from   product_master_sig where part_no='" + rs.getString(2) + "'");
                            while (rs2.next()) {
                                sig_prod_names = rs2.getString(1);
                                sig_cust_names = rs2.getString(2);
                            }

                        }


                    %>
                    <a href="#" class="show_hide" rel="#slidingDiv">PHASE I PCBA</a><br />
                    <div id="slidingDiv">
                        <!--Fill this space with really interesting content.-->
                        <script>
                            function vplpcb() {
                                var row = document.getElementById("ph1_count").value - 1;
                                for (var i = 1; i <= row; i++) {
                                    var res = document.getElementById("res" + i).value;
                                    var tdate = document.getElementById("target" + i).value;
                                    var adate = document.getElementById("actual" + i).value;
                                    if (res != "") {
                                        if (tdate == "" && adate == "") {
                                            alert("Enter Target Date or Actual Date");
                                            document.getElementById("target" + i).focus();
                                            return false;
                                        }
                                    } else {
                                        if (tdate != "" || adate != "") {
                                            alert("Enter Responsibility Name !");
                                            document.getElementById("res" + i).focus();
                                            return false;
                                        }
                                    }
                                }
                            }
                        </script>


                        <!--<form action="editphase1_pcba" method="post" onsubmit=" return vp1_pcb()">-->
                        <form action="editphase1_pcba" method="post" onsubmit="return vplpcb()">
                            <table>
                                <tr>
                                    <th colspan="4" style="text-align: center;">APQP Timing Plan </th>
                                    <th colspan="1">APQP&nbsp;&nbsp;Number</th>
                                    <th colspan="4"><font style="font-weight: normal"><%=apqp_no%></font></th>
                                </tr>
                                <%

                                    if (pcb_sigs.equals("PCB")) {
                                %>
                                <tr>
                                    <th colspan="2">Product Name :<font style="font-weight: normal">  <%=pcb_prod_names%></font></th>
                                    <th colspan="1">PCBA Part #:</th>
                                    <th colspan="2"><font style="font-weight: normal"><%=pcba_part_nos%></font></th>
                                    <th>Customer&nbsp;Name&nbsp;:</th>
                                    <th colspan="3" style="width: 5%;">&nbsp;&nbsp;<font style="font-weight: normal"><%=pcb_cust_names%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></th>
                                </tr>

                                <tr>
                                    <th colspan="2">Proto Qty : <font style="font-weight: normal"><%=proto_qtys%></font></th>
                                    <th colspan="1">SIG Part #:</th>
                                    <th colspan="2"><font style="font-weight: normal">NA</font></th>
                                    <th>CRD :</th>
                                    <th colspan="3" style="width: 5%;"><font style="font-weight: normal"><%=crds%></font></th>
                                </tr>
                                <tr>
                                    <th colspan="2">Project Leader : <font style="font-weight: normal"><%=project_leaders%></font></th>
                                    <th colspan="1">Meeting Date :</th>
                                    <th colspan="2"><font style="font-weight: normal"><%=meeting_dates%></font></th>
                                    <th>Shipment Date :</th>
                                    <th colspan="3" style="width: 5%;"><font style="font-weight: normal"><%=shipment_dates%></font></th>
                                </tr>
                                <tr>
                                    <th colspan="2">Product Soldering Process(RoHS/Non-RoHS) :<font style="font-weight: normal"><%=prod_sold_processs%></font></th>
                                    <th colspan="3">Class of the Product:<font style="font-weight: normal"><%=class_prods%></font></th>
                                    <th colspan="1">Application: </th>
                                    <th colspan="4"><font style="font-weight: normal"><%=apps%></font></th>

                                </tr>
                                <tr>
                                    <th rowspan="2">S.NO</th>
                                    <th colspan="1" rowspan="2">Parameters / Inputs</th>
                                    <th colspan="2">Responsibility and Target Date for Non available parameters</th>
                                    <th rowspan="2">Actual Date</th>
                                    <th rowspan="2" colspan="4">Remarks</th>
                                </tr>
                                <tr>
                                    <th>Responsibility </th> 
                                    <th>Target Date</th>   
                                </tr>

                                <%
                                } else if (pcb_sigs.equals("SIG")) {
                                %>
                                <tr>
                                    <th colspan="2">Product Name :<font style="font-weight: normal"><%=sig_prod_names%></font></th>
                                    <th colspan="1">PCBA Part # :</th>
                                    <th colspan="2"><font style="font-weight: normal">NA</font></th>
                                    <th>Customer&nbsp;Name&nbsp;:</th>
                                    <th colspan="3">&nbsp;&nbsp;<font style="font-weight: normal"><%=sig_cust_names%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></th>
                                </tr>

                                <tr>
                                    <th colspan="2">Proto Qty :  <font style="font-weight: normal"><%=proto_qtys%></font></th>
                                    <th colspan="1">SIG Part # :</th>
                                    <th colspan="2"><font style="font-weight: normal"><%=sig_part_nos%></font></th>
                                    <th>CRD :</th>
                                    <th colspan="3">&nbsp;<font style="font-weight: normal"><%=crds%>&nbsp;</font></th>
                                </tr>
                                <tr>
                                    <th colspan="2">Project Leader :  <font style="font-weight: normal"><%=project_leaders%></font></th>
                                    <th colspan="1">Meeting Date :</th>
                                    <th colspan="2"><font style="font-weight: normal"><%=meeting_dates%></font></th>
                                    <th>Shipment Date :</th>
                                    <th colspan="3" style="width: 5%;"><font style="font-weight: normal"><%=shipment_dates%></font></th>
                                </tr>
                                <tr>
                                    <th colspan="2">Product Soldering Process(RoHS/Non-RoHS) :<font style="font-weight: normal"><%=prod_sold_processs%></font></th>
                                    <th colspan="3">Class of the Product:<font style="font-weight: normal"><%=class_prods%></font></th>
                                    <th colspan="1">Application: </th>
                                    <th colspan="4"><font style="font-weight: normal"><%=apps%></font></th>

                                </tr>
                                <tr>
                                    <th rowspan="2">S.NO</th>
                                    <th colspan="1" rowspan="2">Parameters / Inputs</th>
                                    <th colspan="2">Responsibility and Target Date for Non available parameters</th>
                                    <th rowspan="2">Actual Date</th>
                                    <th rowspan="2" colspan="4">Remarks</th>
                                </tr>
                                <tr>
                                    <th>Responsibility </th> 
                                    <th>Target Date</th>   
                                </tr>


                                <%
                                } else if (pcb_sigs.equals("SIG")) {
                                %>
                                <tr>
                                    <th colspan="2">Product Name :<font style="font-weight: normal"><%=sig_prod_names%></font></th>
                                    <th colspan="1">PCBA Part # :</th>
                                    <th colspan="2"><font style="font-weight: normal">NA</font></th>
                                    <th>Customer&nbsp;Name&nbsp;:</th>
                                    <th colspan="3">&nbsp;&nbsp;<font style="font-weight: normal"><%=sig_cust_names%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></th>
                                </tr>

                                <tr>
                                    <th colspan="2">Proto Qty :  <font style="font-weight: normal"><%=proto_qtys%></font></th>
                                    <th colspan="1">SIG Part # :</th>
                                    <th colspan="2"><font style="font-weight: normal"><%=sig_part_nos%></font></th>
                                    <th>CRD :</th>
                                    <th colspan="3">&nbsp;<font style="font-weight: normal"><%=crds%>&nbsp;</font></th>
                                </tr>
                                <tr>
                                    <th colspan="2">Project Leader :  <font style="font-weight: normal"><%=project_leaders%></font></th>
                                    <th colspan="1">Meeting Date :</th>
                                    <th colspan="2"><font style="font-weight: normal"><%=meeting_dates%></font></th>
                                    <th>Shipment Date :</th>
                                    <th colspan="3" style="width: 5%;"><font style="font-weight: normal"><%=shipment_dates%></font></th>
                                </tr>
                                <tr>
                                    <th colspan="2">Product Soldering Process(RoHS/Non-RoHS) :<font style="font-weight: normal"><%=prod_sold_processs%></font></th>
                                    <th colspan="3">Class of the Product:<font style="font-weight: normal"><%=class_prods%></font></th>
                                    <th colspan="1">Application: </th>
                                    <th colspan="4"><font style="font-weight: normal"><%=apps%></font></th>

                                </tr>
                                <tr>
                                    <th rowspan="2">S.NO</th>
                                    <th colspan="1" rowspan="2">Parameters / Inputs</th>
                                    <th colspan="2">Responsibility and Target Date for Non available parameters</th>
                                    <th rowspan="2">Actual Date</th>
                                    <th rowspan="2" colspan="4">Remarks</th>
                                </tr>
                                <tr>
                                    <th>Responsibility </th> 
                                    <th>Target Date</th>   
                                </tr>

                                <%
                                } else {
                                %>
                                <tr>
                                    <%
                                        if (!sig_prod_names.equals("")) {
                                    %>

                                    <th colspan="2">Product Name :<font style="font-weight: normal"><%=sig_prod_names%></font></th>
                                    <th colspan="1">PCBA Part # :</th>
                                    <th colspan="2"><font style="font-weight: normal"><%=pcba_part_nos%></font></th>
                                    <th>Customer&nbsp;Name&nbsp;:</th>
                                    <th colspan="3">&nbsp;&nbsp;<font style="font-weight: normal"><%=pcb_cust_names%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></th>

                                    <%
                                    } else {
                                    %>


                                    <th colspan="2">Product Name :<font style="font-weight: normal"><%=pcb_prod_names%></font></th>
                                    <th colspan="1">PCBA Part # :</th>
                                    <th colspan="2"><font style="font-weight: normal"><%=pcba_part_nos%></font></th>
                                    <th>Customer&nbsp;Name&nbsp;:</th>
                                    <th colspan="3">&nbsp;&nbsp;<font style="font-weight: normal"><%=pcb_cust_names%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></th>
                                        <%
                                            }
                                        %>

                                </tr>
                                <tr>
                                    <th colspan="2">Proto Qty :  <font style="font-weight: normal"><%=proto_qtys%></font></th>
                                    <th colspan="1">SIG Part # :</th>
                                    <th colspan="2"><font style="font-weight: normal"><%=sig_part_nos%></font></th>
                                    <th>CRD :</th>
                                    <th colspan="3">&nbsp;<font style="font-weight: normal"><%=crds%>&nbsp;</font></th>
                                </tr>
                                <tr>
                                    <th colspan="2">Project Leader :  <font style="font-weight: normal"><%=project_leaders%></font></th>
                                    <th colspan="1">Meeting Date :</th>
                                    <th colspan="2"><font style="font-weight: normal"><%=meeting_dates%></font></th>
                                    <th>Shipment Date :</th>
                                    <th colspan="3" style="width: 5%;"><font style="font-weight: normal"><%=shipment_dates%></font></th>
                                </tr>
                                <tr>
                                    <th colspan="2">Product Soldering Process(RoHS/Non-RoHS) :<font style="font-weight: normal"><%=prod_sold_processs%></font></th>
                                    <th colspan="3">Class of the Product:<font style="font-weight: normal"><%=class_prods%></font></th>
                                    <th colspan="1">Application: </th>
                                    <th colspan="4"><font style="font-weight: normal"><%=apps%></font></th>

                                </tr>
                                <tr>
                                    <th rowspan="2">S.NO</th>
                                    <th colspan="1" rowspan="2">Parameters / Inputs</th>
                                    <th colspan="2">Responsibility and Target Date for Non available parameters</th>
                                    <th rowspan="2">Actual Date</th>
                                    <th rowspan="2" colspan="4">Remarks</th>
                                </tr>
                                <tr>
                                    <th>Responsibility </th> 
                                    <th>Target Date</th>   
                                </tr>

                                <%
                                    }
                                %>
                                <input type="hidden" name="apqp_no" id="apqp_no" value="<%=apqp_no%>">
                                <input type="hidden" name="type"  value="PCBA">


                                <tr>
                                    <th colspan="7">PHASE I -  Plan & Define</th>
                                </tr>
                                <tr>
                                    <th colspan="7" style="text-align: center">PCBA</th>
                                </tr>                                      
                                <%
                                    int ab = 1;
                                    int ph1_count = 1;
                                    String res = "";
                                    ResultSet reA = st.executeQuery("select id,sno,parameters from  parameter_master where type='PCBA' and phase='PHASE I -  Plan & Define' and type='PCBA'");
                                    while (reA.next()) {
                                        res = cls.checkTimeHistory(apqp_no, reA.getString(2), reA.getString(3));
                                %>
                                <tr>
                                    <%
                                        if (res.equals("Yes")) {
                                            //   out.print(res+", ");
                                            ResultSet rsa = st_1.executeQuery("select sno,parameters_input,responsibility,target_date,actual_date,remark from  time_history where sno='" + reA.getString(2) + "' and parameters_input='" + reA.getString(3) + "' and apqp_no='" + apqp_no + "' and type='PCBA'");
                                            while (rsa.next()) {
                                    %>
                                    <td>
                                        <%
                                            String psno = rsa.getString(1);
                                            out.print(psno.substring(4, psno.length()));
                                        %>
                                        <input type="hidden" name="sno<%=ph1_count%>" value="<%=rsa.getString(1)%>"></td>
                                    <td><%=rsa.getString(2)%><input type="hidden" name="para<%=ph1_count%>" value="<%=rsa.getString(2)%>"></td>
                                    <td><input type="text" name="res<%=ph1_count%>" id="res<%=ph1_count%>" value="<%=rsa.getString(3)%>"></td>
                                    <td><input type="date" name="target<%=ph1_count%>" id="target<%=ph1_count%>" value="<%=rsa.getDate(4)%>"></td>
                                    <td><input type="date" name="actual<%=ph1_count%>" id="actual<%=ph1_count%>" value="<%=rsa.getDate(5)%>"></td>
                                    <td colspan="2"><textarea name="remark<%=ph1_count%>" id="remark<%=ph1_count%>"  ><%=rsa.getString(6)%></textarea></td>                                        

                                    <%
                                        }
                                    } else {

                                    %>
                                    <td><%=ab%><input type="hidden" name="sno<%=ph1_count%>" value="<%=reA.getString(2)%>"></td>
                                    <td><%=reA.getString(3)%><input type="hidden" name="para<%=ph1_count%>" value="<%=reA.getString(3)%>"></td>
                                    <td><input type="text" name="res<%=ph1_count%>" id="res<%=ph1_count%>" ></td>
                                    <td><input type="date" name="target<%=ph1_count%>" id="target<%=ph1_count%>"></td>
                                    <td><input type="date" name="actual<%=ph1_count%>" id="actual<%=ph1_count%>"></td>
                                    <td colspan="2"><textarea name="remark<%=ph1_count%>" id="remark<%=ph1_count%>"  ></textarea></td>
                                </tr>
                                <%
                                        }
                                        ab++;
                                        ph1_count++;
                                        res = "";
                                    }
                                %> 

                                <tr>
                                    <td colspan="7" align="center"><input type="submit" name="Save" value="Save" class="but"></td>
                                </tr>
                                <input  type="hidden" id="ph1_count" name="ph1_count" value="<%=ph1_count%>">
                            </table>
                        </form>
                    </div>

                    <a href="#" class="show_hider" rel="#slidingDiv_2">PHASE I SIG</a><br />
                    <div id="slidingDiv_2">
                        <script>
                            function vplsig() {
                                var row = document.getElementById("ph1_counts").value - 1;
                                for (var i = 1; i <= row; i++) {
                                    var res = document.getElementById("ress" + i).value;
                                    var tdate = document.getElementById("targets" + i).value;
                                    var adate = document.getElementById("actuals" + i).value;
                                    if (res != "") {
                                        if (tdate == "" && adate == "") {
                                            alert("Enter Target Date or Actual Date");
                                            document.getElementById("targets" + i).focus();
                                            return false;
                                        }
                                    } else {
                                        if (tdate != "" || adate != "") {
                                            alert("Enter Responsibility Name !");
                                            document.getElementById("ress" + i).focus();
                                            return false;
                                        }
                                    }
                                }
                            }
                        </script>

                        <form action="editphase1_sig" method="post" onsubmit="return vplsig()" >
                            <table>
                                <tr>
                                    <th colspan="4" style="text-align: center;">APQP Timing Plan</th>
                                    <th colspan="1">APQP&nbsp;&nbsp;Number</th>
                                    <th colspan="4"><font style="font-weight: normal"><%=apqp_no%></font></th>
                                </tr>
                                <%
                                    if (pcb_sigs.equals("PCB")) {
                                %>
                                <tr>
                                    <th colspan="2">Product Name :<font style="font-weight: normal"> <%=pcb_prod_names%></font></th>
                                    <th colspan="1">PCBA Part #:</th>
                                    <th colspan="2"><font style="font-weight: normal"><%=pcba_part_nos%></font></th>
                                    <th>Customer&nbsp;Name&nbsp;:</th>
                                    <th colspan="3" style="width: 5%;">&nbsp;&nbsp;<font style="font-weight: normal"><%=pcb_cust_names%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></th>
                                </tr>

                                <tr>
                                    <th colspan="2">Proto Qty : <font style="font-weight: normal"><%=proto_qtys%></font></th>
                                    <th colspan="1">SIG Part #:</th>
                                    <th colspan="2"><font style="font-weight: normal">NA</font></th>
                                    <th>CRD :</th>
                                    <th colspan="3" style="width: 5%;"><font style="font-weight: normal"><%=crds%></font></th>
                                </tr>
                                <tr>
                                    <th colspan="2">Project Leader : <font style="font-weight: normal"><%=project_leaders%></font></th>
                                    <th colspan="1">Meeting Date :</th>
                                    <th colspan="2"><font style="font-weight: normal"><%=meeting_dates%></font></th>
                                    <th>Shipment Date :</th>
                                    <th colspan="3" style="width: 5%;"><font style="font-weight: normal"><%=shipment_dates%></font></th>
                                </tr>
                                <tr>
                                    <th colspan="2">Product Soldering Process(RoHS/Non-RoHS) :<font style="font-weight: normal"><%=prod_sold_processs%></font></th>
                                    <th colspan="3">Class of the Product:<font style="font-weight: normal"><%=class_prods%></font></th>
                                    <th colspan="1">Application: </th>
                                    <th colspan="4"><font style="font-weight: normal"><%=apps%></font></th>

                                </tr>
                                <tr>
                                    <th rowspan="2">S.NO</th>
                                    <th colspan="1" rowspan="2">Parameters / Inputs</th>
                                    <th colspan="2">Responsibility and Target Date for Non available parameters</th>
                                    <th rowspan="2">Actual Date</th>
                                    <th rowspan="2" colspan="4">Remarks</th>
                                </tr>
                                <tr>
                                    <th>Responsibility </th> 
                                    <th>Target Date</th>   
                                </tr>

                                <%
                                } else if (pcb_sigs.equals("SIG")) {
                                %>
                                <tr>
                                    <th colspan="2">Product Name :<font style="font-weight: normal"><%=sig_prod_names%></font></th>
                                    <th colspan="1">PCBA Part # :</th>
                                    <th colspan="2"><font style="font-weight: normal">NA</font></th>
                                    <th>Customer&nbsp;Name&nbsp;:</th>
                                    <th colspan="3">&nbsp;&nbsp;<font style="font-weight: normal"><%=sig_cust_names%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></th>
                                </tr>

                                <tr>
                                    <th colspan="2">Proto Qty :  <font style="font-weight: normal"><%=proto_qtys%></font></th>
                                    <th colspan="1">SIG Part # :</th>
                                    <th colspan="2"><font style="font-weight: normal"><%=sig_part_nos%></font></th>
                                    <th>CRD :</th>
                                    <th colspan="3">&nbsp;<font style="font-weight: normal"><%=crds%>&nbsp;</font></th>
                                </tr>
                                <tr>
                                    <th colspan="2">Project Leader :  <font style="font-weight: normal"><%=project_leaders%></font></th>
                                    <th colspan="1">Meeting Date :</th>
                                    <th colspan="2"><font style="font-weight: normal"><%=meeting_dates%></font></th>
                                    <th>Shipment Date :</th>
                                    <th colspan="3" style="width: 5%;"><font style="font-weight: normal"><%=shipment_dates%></font></th>
                                </tr>
                                <tr>
                                    <th colspan="2">Product Soldering Process(RoHS/Non-RoHS) :<font style="font-weight: normal"><%=prod_sold_processs%></font></th>
                                    <th colspan="3">Class of the Product:<font style="font-weight: normal"><%=class_prods%></font></th>
                                    <th colspan="1">Application: </th>
                                    <th colspan="4"><font style="font-weight: normal"><%=apps%></font></th>

                                </tr>
                                <tr>
                                    <th rowspan="2">S.NO</th>
                                    <th colspan="1" rowspan="2">Parameters / Inputs</th>
                                    <th colspan="2">Responsibility and Target Date for Non available parameters</th>
                                    <th rowspan="2">Actual Date</th>
                                    <th rowspan="2" colspan="4">Remarks</th>
                                </tr>
                                <tr>
                                    <th>Responsibility </th> 
                                    <th>Target Date</th>   
                                </tr>

                                <%
                                } else {
                                %>

                                <tr>
                                    <%
                                        if (!sig_prod_names.equals("")) {
                                    %>

                                    <th colspan="2">Product Name :<font style="font-weight: normal"><%=sig_prod_names%></font></th>
                                    <th colspan="1">PCBA Part # :</th>
                                    <th colspan="2"><font style="font-weight: normal"><%=pcba_part_nos%></font></th>
                                    <th>Customer&nbsp;Name&nbsp;:</th>
                                    <th colspan="3">&nbsp;&nbsp;<font style="font-weight: normal"><%=pcb_cust_names%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></th>

                                    <%
                                    } else {
                                    %>


                                    <th colspan="2">Product Name :<font style="font-weight: normal"><%=pcb_prod_names%></font></th>
                                    <th colspan="1">PCBA Part # :</th>
                                    <th colspan="2"><font style="font-weight: normal"><%=pcba_part_nos%></font></th>
                                    <th>Customer&nbsp;Name&nbsp;:</th>
                                    <th colspan="3">&nbsp;&nbsp;<font style="font-weight: normal"><%=pcb_cust_names%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></th>
                                        <%
                                            }
                                        %>

                                </tr>

                                <tr>
                                    <th colspan="2">Proto Qty :  <font style="font-weight: normal"><%=proto_qtys%></font></th>
                                    <th colspan="1">SIG Part # :</th>
                                    <th colspan="2"><font style="font-weight: normal"><%=sig_part_nos%></font></th>
                                    <th>CRD :</th>
                                    <th colspan="3">&nbsp;<font style="font-weight: normal"><%=crds%>&nbsp;</font></th>
                                </tr>
                                <tr>
                                    <th colspan="2">Project Leader :  <font style="font-weight: normal"><%=project_leaders%></font></th>
                                    <th colspan="1">Meeting Date :</th>
                                    <th colspan="2"><font style="font-weight: normal"><%=meeting_dates%></font></th>
                                    <th>Shipment Date :</th>
                                    <th colspan="3" style="width: 5%;"><font style="font-weight: normal"><%=shipment_dates%></font></th>
                                </tr>
                                <tr>
                                    <th colspan="2">Product Soldering Process(RoHS/Non-RoHS) :<font style="font-weight: normal"><%=prod_sold_processs%></font></th>
                                    <th colspan="3">Class of the Product:<font style="font-weight: normal"><%=class_prods%></font></th>
                                    <th colspan="1">Application: </th>
                                    <th colspan="4"><font style="font-weight: normal"><%=apps%></font></th>

                                </tr>
                                <tr>
                                    <th rowspan="2">S.NO</th>
                                    <th colspan="1" rowspan="2">Parameters / Inputs</th>
                                    <th colspan="2">Responsibility and Target Date for Non available parameters</th>
                                    <th rowspan="2">Actual Date</th>
                                    <th rowspan="2" colspan="4">Remarks</th>
                                </tr>
                                <tr>
                                    <th>Responsibility </th> 
                                    <th>Target Date</th>   
                                </tr>

                                <%
                                    }
                                %>
                                <input type="hidden" name="apqp_no" id="apqp_no" value="<%=apqp_no%>">
                                <input type="hidden" name="type"  value="SIG Level">


                                <tr>
                                    <th colspan="7">PHASE I -  Plan & Define</th>
                                </tr>
                                <tr>
                                    <th colspan="7" style="text-align: center">SIG Level</th>
                                </tr>

                                <%
                                    int ac = 1;
                                    int ph1_counts = 1;
                                    String ress = "";
                                    ResultSet reAs = st.executeQuery("select id,sno,parameters from  parameter_master where phase='PHASE I -  Plan & Define' and type='SIG Level'");
                                    while (reAs.next()) {
                                        ress = cls.checkTimeHistory(apqp_no, reAs.getString(2), reAs.getString(3));
                                %>
                                <tr>
                                    <%
                                        if (ress.equals("Yes")) {
                                            //   out.print(res+", ");
                                            ResultSet rsas = st_1.executeQuery("select sno,parameters_input,responsibility,target_date,actual_date,remark from  time_history where sno='" + reAs.getString(2) + "' and parameters_input='" + reAs.getString(3) + "' and apqp_no='" + apqp_no + "' and type='SIG Level'");
                                            while (rsas.next()) {
                                    %>
                                    <td>
                                        <%
                                            String psno = rsas.getString(1);
                                            out.print(psno.substring(4, psno.length()));
                                        %>
                                        <input type="hidden" name="sno<%=ph1_counts%>" value="<%=rsas.getString(1)%>"></td>
                                    <td><%=rsas.getString(2)%><input type="hidden" name="para<%=ph1_counts%>" value="<%=rsas.getString(2)%>"></td>
                                    <td><input type="text" name="res<%=ph1_counts%>" id="ress<%=ph1_counts%>" value="<%=rsas.getString(3)%>"></td>
                                    <td><input type="date" name="target<%=ph1_counts%>" id="targets<%=ph1_counts%>" value="<%=rsas.getDate(4)%>"></td>
                                    <td><input type="date" name="actual<%=ph1_counts%>" id="actuals<%=ph1_counts%>" value="<%=rsas.getDate(5)%>"></td>
                                    <td colspan="2"><textarea name="remark<%=ph1_counts%>" id="remark<%=ph1_counts%>"  ><%=rsas.getString(6)%></textarea></td>                                        

                                    <%
                                        }
                                    } else {

                                    %>
                                    <td><%=ac%><input type="hidden" name="sno<%=ph1_counts%>" value="<%=reAs.getString(2)%>"></td>
                                    <td><%=reAs.getString(3)%><input type="hidden" name="para<%=ph1_counts%>" value="<%=reAs.getString(3)%>"></td>
                                    <td><input type="text" name="res<%=ph1_counts%>" id="res<%=ph1_counts%>" ></td>
                                    <td><input type="date" name="target<%=ph1_counts%>" id="target<%=ph1_counts%>"></td>
                                    <td><input type="date" name="actual<%=ph1_counts%>" id="actual<%=ph1_counts%>"></td>
                                    <td colspan="2"><textarea name="remark<%=ph1_counts%>" id="remark<%=ph1_counts%>"  ></textarea></td>
                                </tr>
                                <%
                                        }
                                        ac++;
                                        ph1_counts++;
                                        ress = "";
                                    }
                                %> 
                                <tr>
                                <input  type="hidden" id="ph1_counts" name="ph1_counts" value="<%=ph1_counts%>">
                                <td colspan="7" align="center"><input type="submit" name="Save" value="Save" class="but"></td>
                                </tr>
                                </tr>

                            </table>
                        </form>
                    </div> 

                    <%
                    } else if (p.equals("4")) {
                    %>
                    <a href="#" class="show_hide1" rel="#slidingDiv1">PHASE II PCBA</a><br />
                    <div id="slidingDiv1">

                        <script>
                            function vp2pcb() {
                                var row = document.getElementById("ph2_count").value - 1;
//                                alert(row);
                                for (var i = 1; i <= row; i++) {
                                    var res = document.getElementById("resp2" + i).value;
                                    var tdate = document.getElementById("targetp2" + i).value;
                                    var adate = document.getElementById("actualp2" + i).value;
                                    if (res != "") {
                                        if (tdate == "" && adate == "") {
                                            alert("Enter Target Date or Actual Date");
                                            document.getElementById("targetp2" + i).focus();
                                            return false;
                                        }
                                    } else {
                                        if (tdate != "" || adate != "") {
                                            alert("Enter Responsibility Name !");
                                            document.getElementById("resp2" + i).focus();
                                            return false;
                                        }
                                    }
                                }
                            }
                        </script>

                        <%
                            Statement st2 = null;
                            ResultSet rs = null;
                            ResultSet rs1 = null;
                            ResultSet rs2 = null;

                            st1 = con.createStatement();
                            st2 = con.createStatement();

                            rs = st.executeQuery("select a.pcba_part_no,a.sig_part_no,b.pro_qty,b.project_leader,b.prod_sold_process,b.application,b.customer_req_date,b.apqp_meeting_date,b.pcb_sig,b.shipment_date,b.class_product from  apqp_aps as a join  apqp_eil as b on a.apqp_no=b.apqp_no where a.apqp_no='" + apqp_no + "'");
                            while (rs.next()) {
                                pcba_part_nos = rs.getString(1);
//                                out.print(pcba_part_nos);
                                sig_part_nos = rs.getString(2);
                                proto_qtys = rs.getString(3);
                                project_leaders = rs.getString(4);
                                prod_sold_processs = rs.getString(5);
                                apps = rs.getString(6);
                                crds = rs.getDate(7);
                                meeting_dates = rs.getDate(8);
                                pcb_sigs = rs.getString(9);
                                shipment_dates = rs.getDate(10);
                                class_prods = rs.getString(11);

                                rs1 = st1.executeQuery("select prod_name,customer_name from   product_master_pcb where part_no='" + rs.getString(1) + "'");
                                while (rs1.next()) {
                                    pcb_prod_names = rs1.getString(1);
                                    pcb_cust_names = rs1.getString(2);
                                }

                                rs2 = st2.executeQuery("select prod_name,customer_name from   product_master_sig where part_no='" + rs.getString(2) + "'");
                                while (rs2.next()) {
                                    sig_prod_names = rs2.getString(1);
                                    sig_cust_names = rs2.getString(2);
                                }

                            }
                        %>
                        <form action="editphase2_pcba" method="post" onsubmit="return vp2pcb()">
                            <table>
                                <tr>
                                    <th colspan="4" style="text-align: center;">APQP Timing Plan </th>
                                    <th colspan="1">APQP&nbsp;&nbsp;Number</th>
                                    <th colspan="4"><font style="font-weight: normal"><%=apqp_no%></font></th>
                                </tr>
                                <%

                                    if (pcb_sigs.equals("PCB")) {
                                %>
                                <tr>
                                    <th colspan="2">Product Name :<font style="font-weight: normal">  <%=pcb_prod_names%></font></th>
                                    <th colspan="1">PCBA Part #:</th>
                                    <th colspan="2"><font style="font-weight: normal"><%=pcba_part_nos%></font></th>
                                    <th>Customer&nbsp;Name&nbsp;:</th>
                                    <th colspan="3" style="width: 5%;">&nbsp;&nbsp;<font style="font-weight: normal"><%=pcb_cust_names%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></th>
                                </tr>

                                <tr>
                                    <th colspan="2">Proto Qty : <font style="font-weight: normal"><%=proto_qtys%></font></th>
                                    <th colspan="1">SIG Part #:</th>
                                    <th colspan="2"><font style="font-weight: normal">NA</font></th>
                                    <th>CRD :</th>
                                    <th colspan="3" style="width: 5%;"><font style="font-weight: normal"><%=crds%></font></th>
                                </tr>
                                <tr>
                                    <th colspan="2">Project Leader : <font style="font-weight: normal"><%=project_leaders%></font></th>
                                    <th colspan="1">Meeting Date :</th>
                                    <th colspan="2"><font style="font-weight: normal"><%=meeting_dates%></font></th>
                                    <th>Shipment Date :</th>
                                    <th colspan="3" style="width: 5%;"><font style="font-weight: normal"><%=shipment_dates%></font></th>
                                </tr>
                                <tr>
                                    <th colspan="2">Product Soldering Process(RoHS/Non-RoHS) :<font style="font-weight: normal"><%=prod_sold_processs%></font></th>
                                    <th colspan="3">Class of the Product:<font style="font-weight: normal"><%=class_prods%></font></th>
                                    <th colspan="1">Application: </th>
                                    <th colspan="4"><font style="font-weight: normal"><%=apps%></font></th>

                                </tr>
                                <tr>
                                    <th rowspan="2">S.NO</th>
                                    <th colspan="1" rowspan="2">Parameters / Inputs</th>
                                    <th colspan="2">Responsibility and Target Date for Non available parameters</th>
                                    <th rowspan="2">Actual Date</th>
                                    <th rowspan="2" colspan="4">Remarks</th>
                                </tr>
                                <tr>
                                    <th>Responsibility </th> 
                                    <th>Target Date</th>   
                                </tr>

                                <%
                                } else if (pcb_sigs.equals("SIG")) {
                                %>
                                <tr>
                                    <th colspan="2">Product Name :<font style="font-weight: normal"><%=sig_prod_names%></font></th>
                                    <th colspan="1">PCBA Part # :</th>
                                    <th colspan="2"><font style="font-weight: normal">NA</font></th>
                                    <th>Customer&nbsp;Name&nbsp;:</th>
                                    <th colspan="3">&nbsp;&nbsp;<font style="font-weight: normal"><%=sig_cust_names%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></th>
                                </tr>

                                <tr>
                                    <th colspan="2">Proto Qty :  <font style="font-weight: normal"><%=proto_qtys%></font></th>
                                    <th colspan="1">SIG Part # :</th>
                                    <th colspan="2"><font style="font-weight: normal"><%=sig_part_nos%></font></th>
                                    <th>CRD :</th>
                                    <th colspan="3">&nbsp;<font style="font-weight: normal"><%=crds%>&nbsp;</font></th>
                                </tr>
                                <tr>
                                    <th colspan="2">Project Leader :  <font style="font-weight: normal"><%=project_leaders%></font></th>
                                    <th colspan="1">Meeting Date :</th>
                                    <th colspan="2"><font style="font-weight: normal"><%=meeting_dates%></font></th>
                                    <th>Shipment Date :</th>
                                    <th colspan="3" style="width: 5%;"><font style="font-weight: normal"><%=shipment_dates%></font></th>
                                </tr>
                                <tr>
                                    <th colspan="2">Product Soldering Process(RoHS/Non-RoHS) :<font style="font-weight: normal"><%=prod_sold_processs%></font></th>
                                    <th colspan="3">Class of the Product:<font style="font-weight: normal"><%=class_prods%></font></th>
                                    <th colspan="1">Application: </th>
                                    <th colspan="4"><font style="font-weight: normal"><%=apps%></font></th>

                                </tr>
                                <tr>
                                    <th rowspan="2">S.NO</th>
                                    <th colspan="1" rowspan="2">Parameters / Inputs</th>
                                    <th colspan="2">Responsibility and Target Date for Non available parameters</th>
                                    <th rowspan="2">Actual Date</th>
                                    <th rowspan="2" colspan="4">Remarks</th>
                                </tr>
                                <tr>
                                    <th>Responsibility </th> 
                                    <th>Target Date</th>   
                                </tr>

                                <%
                                } else {
                                %>
                                <tr>
                                    <%
                                        if (!sig_prod_names.equals("")) {
                                    %>

                                    <th colspan="2">Product Name :<font style="font-weight: normal"><%=sig_prod_names%></font></th>
                                    <th colspan="1">PCBA Part # :</th>
                                    <th colspan="2"><font style="font-weight: normal"><%=pcba_part_nos%></font></th>
                                    <th>Customer&nbsp;Name&nbsp;:</th>
                                    <th colspan="3">&nbsp;&nbsp;<font style="font-weight: normal"><%=pcb_cust_names%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></th>

                                    <%
                                    } else {
                                    %>


                                    <th colspan="2">Product Name :<font style="font-weight: normal"><%=pcb_prod_names%></font></th>
                                    <th colspan="1">PCBA Part # :</th>
                                    <th colspan="2"><font style="font-weight: normal"><%=pcba_part_nos%></font></th>
                                    <th>Customer&nbsp;Name&nbsp;:</th>
                                    <th colspan="3">&nbsp;&nbsp;<font style="font-weight: normal"><%=pcb_cust_names%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></th>
                                        <%
                                            }
                                        %>

                                </tr>
                                <tr>
                                    <th colspan="2">Proto Qty :  <font style="font-weight: normal"><%=proto_qtys%></font></th>
                                    <th colspan="1">SIG Part # :</th>
                                    <th colspan="2"><font style="font-weight: normal"><%=sig_part_nos%></font></th>
                                    <th>CRD :</th>
                                    <th colspan="3">&nbsp;<font style="font-weight: normal"><%=crds%>&nbsp;</font></th>
                                </tr>
                                <tr>
                                    <th colspan="2">Project Leader :  <font style="font-weight: normal"><%=project_leaders%></font></th>
                                    <th colspan="1">Meeting Date :</th>
                                    <th colspan="2"><font style="font-weight: normal"><%=meeting_dates%></font></th>
                                    <th>Shipment Date :</th>
                                    <th colspan="3" style="width: 5%;"><font style="font-weight: normal"><%=shipment_dates%></font></th>
                                </tr>
                                <tr>
                                    <th colspan="2">Product Soldering Process(RoHS/Non-RoHS) :<font style="font-weight: normal"><%=prod_sold_processs%></font></th>
                                    <th colspan="3">Class of the Product:<font style="font-weight: normal"><%=class_prods%></font></th>
                                    <th colspan="1">Application: </th>
                                    <th colspan="4"><font style="font-weight: normal"><%=apps%></font></th>

                                </tr>
                                <tr>
                                    <th rowspan="2">S.NO</th>
                                    <th colspan="1" rowspan="2">Parameters / Inputs</th>
                                    <th colspan="2">Responsibility and Target Date for Non available parameters</th>
                                    <th rowspan="2">Actual Date</th>
                                    <th rowspan="2" colspan="4">Remarks</th>
                                </tr>
                                <tr>
                                    <th>Responsibility </th> 
                                    <th>Target Date</th>   
                                </tr>

                                <%
                                    }
                                %>
                                <input type="hidden" name="apqp_no" id="apqp_no" value="<%=apqp_no%>">
                                <input type="hidden" name="type" value="PCBA">


                                <tr>
                                    <th colspan="7">PHASE II - Product Design & Development</th>
                                </tr>
                                <tr>
                                    <th colspan="7" style="text-align: center">PCBA</th>
                                </tr>



                                <%
                                    int ph2_count = 1;
                                    String res2 = "";
                                    ResultSet reA2 = st.executeQuery("select id,sno,parameters from  parameter_master where type='PCBA' and phase='PHASE II - Product Design & Development' and type='PCBA'");
                                    while (reA2.next()) {
                                        res2 = cls.checkTimeHistory(apqp_no, reA2.getString(2), reA2.getString(3));
                                %>
                                <tr>
                                    <%
                                        if (res2.equals("Yes")) {
                                            //   out.print(res+", ");
                                            ResultSet rsa2 = st_1.executeQuery("select sno,parameters_input,responsibility,target_date,actual_date,remark from  time_history where sno='" + reA2.getString(2) + "' and parameters_input='" + reA2.getString(3) + "' and apqp_no='" + apqp_no + "' and type='PCBA'");
                                            while (rsa2.next()) {
                                    %>
                                    <td>
                                        <%
                                            String psno = rsa2.getString(1);
                                            out.print(psno.substring(4, psno.length()));
                                        %>
                                        <input type="hidden" name="sno<%=ph2_count%>" value="<%=rsa2.getString(1)%>"></td>
                                    <td><%=rsa2.getString(2)%><input type="hidden" name="para<%=ph2_count%>" value="<%=rsa2.getString(2)%>"></td>
                                    <td><input type="text" name="res<%=ph2_count%>" id="resp2<%=ph2_count%>" value="<%=rsa2.getString(3)%>"></td>
                                    <td><input type="date" name="target<%=ph2_count%>" id="targetp2<%=ph2_count%>" value="<%=rsa2.getDate(4)%>"></td>
                                    <td><input type="date" name="actual<%=ph2_count%>" id="actualp2<%=ph2_count%>" value="<%=rsa2.getDate(5)%>"></td>
                                    <td colspan="2"><textarea name="remark<%=ph2_count%>" id="remark<%=ph2_count%>"  ><%=rsa2.getString(6)%></textarea></td>                                        

                                    <%
                                        }
                                    } else {

                                    %>
                                    <td>
                                        <%                                                String psno1 = reA2.getString(2);
                                            out.print(psno1.substring(4, psno1.length()));
                                        %>
                                        <input type="hidden" name="sno<%=ph2_count%>" value="<%=reA2.getString(2)%>"></td>
                                    <td><%=reA2.getString(3)%><input type="hidden" name="para<%=ph2_count%>" value="<%=reA2.getString(3)%>"></td>
                                    <td><input type="text" name="res<%=ph2_count%>" id="res<%=ph2_count%>" ></td>
                                    <td><input type="date" name="target<%=ph2_count%>" id="target<%=ph2_count%>"></td>
                                    <td><input type="date" name="actual<%=ph2_count%>" id="actual<%=ph2_count%>"></td>
                                    <td colspan="2"><textarea name="remark<%=ph2_count%>" id="remark<%=ph2_count%>"  ></textarea></td>
                                </tr>
                                <%
                                        }
                                        ph2_count++;
                                        res2 = "";
                                    }
                                %> 
                                <tr>
                                    <td colspan="7" align="center">
                                        <input type="submit" name="Save" value="Save" class="but">
                                    </td>
                                </tr>
                                <input  type="hidden" id="ph2_count" name="ph2_count" value="<%=ph2_count%>">
                            </table> 
                        </form>
                    </div>
                    <a href="#" class="show_hidere" rel="#slidingDiv_21">PHASE II SIG</a><br />
                    <div id="slidingDiv_21">

                        <script>
                            function vp2sig() {
                                var row = document.getElementById("ph2s_count").value - 1;

                                for (var i = 1; i <= row; i++) {
                                    var res = document.getElementById("ress2" + i).value;
                                    var tdate = document.getElementById("targets2" + i).value;
                                    var adate = document.getElementById("actuals2" + i).value;
                                    if (res != "") {
                                        if (tdate == "" && adate == "") {
                                            alert("Enter Target Date or Actual Date");
                                            document.getElementById("targets2" + i).focus();
                                            return false;
                                        }
                                    } else {
                                        if (tdate != "" || adate != "") {
                                            alert("Enter Responsibility Name !");
                                            document.getElementById("ress2" + i).focus();
                                            return false;
                                        }
                                    }
                                }
                            }
                        </script>

                        <form action="editphase2_sig" method="post" onsubmit="return vp2sig()">
                            <table>
                                <tr>
                                    <th colspan="4" style="text-align: center;">APQP Timing Plan</th>
                                    <th colspan="1">APQP&nbsp;&nbsp;Number</th>
                                    <th colspan="4"><font style="font-weight: normal"><%=apqp_no%></font></th>
                                </tr>
                                <%
                                    if (pcb_sigs.equals("PCB")) {
                                %>
                                <tr>
                                    <th colspan="2">Product Name :<font style="font-weight: normal"> <%=pcb_prod_names%></font></th>
                                    <th colspan="1">PCBA Part #:</th>
                                    <th colspan="2"><font style="font-weight: normal"><%=pcba_part_nos%></font></th>
                                    <th>Customer&nbsp;Name&nbsp;:</th>
                                    <th colspan="3" style="width: 5%;">&nbsp;&nbsp;<font style="font-weight: normal"><%=pcb_cust_names%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></th>
                                </tr>

                                <tr>
                                    <th colspan="2">Proto Qty : <font style="font-weight: normal"><%=proto_qtys%></font></th>
                                    <th colspan="1">SIG Part #:</th>
                                    <th colspan="2"><font style="font-weight: normal">NA</font></th>
                                    <th>CRD :</th>
                                    <th colspan="3" style="width: 5%;"><font style="font-weight: normal"><%=crds%></font></th>
                                </tr>
                                <tr>
                                    <th colspan="2">Project Leader : <font style="font-weight: normal"><%=project_leaders%></font></th>
                                    <th colspan="1">Meeting Date :</th>
                                    <th colspan="2"><font style="font-weight: normal"><%=meeting_dates%></font></th>
                                    <th>Shipment Date :</th>
                                    <th colspan="3" style="width: 5%;"><font style="font-weight: normal"><%=shipment_dates%></font></th>
                                </tr>
                                <tr>
                                    <th colspan="2">Product Soldering Process(RoHS/Non-RoHS) :<font style="font-weight: normal"><%=prod_sold_processs%></font></th>
                                    <th colspan="3">Class of the Product:<font style="font-weight: normal"><%=class_prods%></font></th>
                                    <th colspan="1">Application: </th>
                                    <th colspan="4"><font style="font-weight: normal"><%=apps%></font></th>
                                </tr>
                                <tr>
                                    <th rowspan="2">S.NO</th>
                                    <th colspan="1" rowspan="2">Parameters / Inputs</th>
                                    <th colspan="2">Responsibility and Target Date for Non available parameters</th>
                                    <th rowspan="2">Actual Date</th>
                                    <th rowspan="2" colspan="4">Remarks</th>
                                </tr>
                                <tr>
                                    <th>Responsibility </th> 
                                    <th>Target Date</th>   
                                </tr>

                                <%
                                } else if (pcb_sigs.equals("SIG")) {
                                %>
                                <tr>
                                    <th colspan="2">Product Name :<font style="font-weight: normal"><%=sig_prod_names%></font></th>
                                    <th colspan="1">PCBA Part # :</th>
                                    <th colspan="2"><font style="font-weight: normal">NA</font></th>
                                    <th>Customer&nbsp;Name&nbsp;:</th>
                                    <th colspan="3">&nbsp;&nbsp;<font style="font-weight: normal"><%=sig_cust_names%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></th>
                                </tr>

                                <tr>
                                    <th colspan="2">Proto Qty :  <font style="font-weight: normal"><%=proto_qtys%></font></th>
                                    <th colspan="1">SIG Part # :</th>
                                    <th colspan="2"><font style="font-weight: normal"><%=sig_part_nos%></font></th>
                                    <th>CRD :</th>
                                    <th colspan="3">&nbsp;<font style="font-weight: normal"><%=crds%>&nbsp;</font></th>
                                </tr>
                                <tr>
                                    <th colspan="2">Project Leader :  <font style="font-weight: normal"><%=project_leaders%></font></th>
                                    <th colspan="1">Meeting Date :</th>
                                    <th colspan="2"><font style="font-weight: normal"><%=meeting_dates%></font></th>
                                    <th>Shipment Date :</th>
                                    <th colspan="3" style="width: 5%;"><font style="font-weight: normal"><%=shipment_dates%></font></th>
                                </tr>
                                <tr>
                                    <th colspan="2">Product Soldering Process(RoHS/Non-RoHS) :<font style="font-weight: normal"><%=prod_sold_processs%></font></th>
                                    <th colspan="3">Class of the Product:<font style="font-weight: normal"><%=class_prods%></font></th>
                                    <th colspan="1">Application: </th>
                                    <th colspan="4"><font style="font-weight: normal"><%=apps%></font></th>

                                </tr>
                                <tr>
                                    <th rowspan="2">S.NO</th>
                                    <th colspan="1" rowspan="2">Parameters / Inputs</th>
                                    <th colspan="2">Responsibility and Target Date for Non available parameters</th>
                                    <th rowspan="2">Actual Date</th>
                                    <th rowspan="2" colspan="4">Remarks</th>
                                </tr>
                                <tr>
                                    <th>Responsibility </th> 
                                    <th>Target Date</th>   
                                </tr>

                                <%
                                } else {
                                %>

                                <tr>
                                    <%
                                        if (!sig_prod_names.equals("")) {
                                    %>

                                    <th colspan="2">Product Name :<font style="font-weight: normal"><%=sig_prod_names%></font></th>
                                    <th colspan="1">PCBA Part # :</th>
                                    <th colspan="2"><font style="font-weight: normal"><%=pcba_part_nos%></font></th>
                                    <th>Customer&nbsp;Name&nbsp;:</th>
                                    <th colspan="3">&nbsp;&nbsp;<font style="font-weight: normal"><%=pcb_cust_names%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></th>

                                    <%
                                    } else {
                                    %>


                                    <th colspan="2">Product Name :<font style="font-weight: normal"><%=pcb_prod_names%></font></th>
                                    <th colspan="1">PCBA Part # :</th>
                                    <th colspan="2"><font style="font-weight: normal"><%=pcba_part_nos%></font></th>
                                    <th>Customer&nbsp;Name&nbsp;:</th>
                                    <th colspan="3">&nbsp;&nbsp;<font style="font-weight: normal"><%=pcb_cust_names%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></th>
                                        <%
                                            }
                                        %>

                                </tr>

                                <tr>
                                    <th colspan="2">Proto Qty :  <font style="font-weight: normal"><%=proto_qtys%></font></th>
                                    <th colspan="1">SIG Part # :</th>
                                    <th colspan="2"><font style="font-weight: normal"><%=sig_part_nos%></font></th>
                                    <th>CRD :</th>
                                    <th colspan="3">&nbsp;<font style="font-weight: normal"><%=crds%>&nbsp;</font></th>
                                </tr>
                                <tr>
                                    <th colspan="2">Project Leader :  <font style="font-weight: normal"><%=project_leaders%></font></th>
                                    <th colspan="1">Meeting Date :</th>
                                    <th colspan="2"><font style="font-weight: normal"><%=meeting_dates%></font></th>
                                    <th>Shipment Date :</th>
                                    <th colspan="3" style="width: 5%;"><font style="font-weight: normal"><%=shipment_dates%></font></th>
                                </tr>
                                <tr>
                                    <th colspan="2">Product Soldering Process(RoHS/Non-RoHS) :<font style="font-weight: normal"><%=prod_sold_processs%></font></th>
                                    <th colspan="3">Class of the Product:<font style="font-weight: normal"><%=class_prods%></font></th>
                                    <th colspan="1">Application: </th>
                                    <th colspan="4"><font style="font-weight: normal"><%=apps%></font></th>

                                </tr>
                                <tr>
                                    <th rowspan="2">S.NO</th>
                                    <th colspan="1" rowspan="2">Parameters / Inputs</th>
                                    <th colspan="2">Responsibility and Target Date for Non available parameters</th>
                                    <th rowspan="2">Actual Date</th>
                                    <th rowspan="2" colspan="4">Remarks</th>
                                </tr>
                                <tr>
                                    <th>Responsibility </th> 
                                    <th>Target Date</th>   
                                </tr>

                                <%
                                    }
                                %>
                                <input type="hidden" name="apqp_no" id="apqp_no" value="<%=apqp_no%>">
                                <input type="hidden" name="type" value="SIG Level">


                                <tr>
                                    <th colspan="7">PHASE II - Product Design & Development</th>
                                </tr>
                                <tr>
                                    <th colspan="7" style="text-align: center">SIG Level</th>
                                </tr>
                                <%
                                    int ph2s_count = 1;
                                    String res2s = "";
                                    ResultSet reA2s = st.executeQuery("select id,sno,parameters from  parameter_master where phase='PHASE II - Product Design & Development' and type='SIG Level'");
                                    while (reA2s.next()) {
                                        res2s = cls.checkTimeHistory(apqp_no, reA2s.getString(2), reA2s.getString(3));
                                %>
                                <tr>
                                    <%
                                        if (res2s.equals("Yes")) {
                                            //   out.print(res+", ");
                                            ResultSet rsa2s = st_1.executeQuery("select sno,parameters_input,responsibility,target_date,actual_date,remark from  time_history where sno='" + reA2s.getString(2) + "' and parameters_input='" + reA2s.getString(3) + "' and apqp_no='" + apqp_no + "' and type='SIG Level'");
                                            while (rsa2s.next()) {
                                    %>
                                    <td>
                                        <%
                                            String psno = rsa2s.getString(1);
                                            out.print(psno.substring(4, psno.length()));
                                        %>
                                        <input type="hidden" name="sno<%=ph2s_count%>" value="<%=rsa2s.getString(1)%>"></td>
                                    <td><%=rsa2s.getString(2)%><input type="hidden" name="para<%=ph2s_count%>" value="<%=rsa2s.getString(2)%>"></td>
                                    <td><input type="text" name="res<%=ph2s_count%>" id="ress2<%=ph2s_count%>" value="<%=rsa2s.getString(3)%>"></td>
                                    <td><input type="date" name="target<%=ph2s_count%>" id="targets2<%=ph2s_count%>" value="<%=rsa2s.getDate(4)%>"></td>
                                    <td><input type="date" name="actual<%=ph2s_count%>" id="actuals2<%=ph2s_count%>" value="<%=rsa2s.getDate(5)%>"></td>
                                    <td colspan="2"><textarea name="remark<%=ph2s_count%>" id="remark<%=ph2s_count%>"  ><%=rsa2s.getString(6)%></textarea></td>                                        

                                    <%
                                        }
                                    } else {

                                    %>
                                    <td>
                                        <%                                                String psno1 = reA2s.getString(2);
                                            out.print(psno1.substring(4, psno1.length()));
                                        %>
                                        <input type="hidden" name="sno<%=ph2s_count%>" value="<%=reA2s.getString(2)%>"></td>
                                    <td><%=reA2s.getString(3)%><input type="hidden" name="para<%=ph2s_count%>" value="<%=reA2s.getString(3)%>"></td>
                                    <td><input type="text" name="res<%=ph2s_count%>" id="res<%=ph2s_count%>" ></td>
                                    <td><input type="date" name="target<%=ph2s_count%>" id="target<%=ph2s_count%>"></td>
                                    <td><input type="date" name="actual<%=ph2s_count%>" id="actual<%=ph2s_count%>"></td>
                                    <td colspan="2"><textarea name="remark<%=ph2s_count%>" id="remark<%=ph2s_count%>"  ></textarea></td>
                                </tr>
                                <%
                                        }
                                        ph2s_count++;
                                        res2s = "";
                                    }
                                %> 
                                <tr>
                                    <td colspan="7" align="center"><input type="submit" name="Save" value="Save" class="but"></td>
                                </tr>
                                <input  type="hidden" id="ph2s_count" name="ph2s_count" value="<%=ph2s_count%>">
                            </table>
                        </form>
                    </div>    


                    <%
                    } else if (p.equals("5")) {
                    %>

                    <a href="#" class="show_hide2" rel="#slidingDiv11">PHASE III PCBA</a><br />
                    <div id="slidingDiv11">
                        <script>
                            function vp3pcb() {
                                var row = document.getElementById("ph3_count").value - 1;
                                for (var i = 1; i <= row; i++) {
                                    var res = document.getElementById("resp3" + i).value;
                                    var tdate = document.getElementById("targetp3" + i).value;
                                    var adate = document.getElementById("actualp3" + i).value;
                                    if (res != "") {
                                        if (tdate == "" && adate == "") {
                                            alert("Enter Target Date or Actual Date");
                                            document.getElementById("targetp3" + i).focus();
                                            return false;
                                        }
                                    } else {
                                        if (tdate != "" || adate != "") {
                                            alert("Enter Responsibility Name !");
                                            document.getElementById("resp3" + i).focus();
                                            return false;
                                        }
                                    }
                                }
                            }
                        </script>
                        <%
                            Statement st2 = null;
                            ResultSet rs = null;
                            ResultSet rs1 = null;
                            ResultSet rs2 = null;

                            st1 = con.createStatement();
                            st2 = con.createStatement();

                            rs = st.executeQuery("select a.pcba_part_no,a.sig_part_no,b.pro_qty,b.project_leader,b.prod_sold_process,b.application,b.customer_req_date,b.apqp_meeting_date,b.pcb_sig,b.shipment_date,b.class_product from  apqp_aps as a join  apqp_eil as b on a.apqp_no=b.apqp_no where a.apqp_no='" + apqp_no + "'");
                            while (rs.next()) {
                                pcba_part_nos = rs.getString(1);
                                sig_part_nos = rs.getString(2);
                                proto_qtys = rs.getString(3);
                                project_leaders = rs.getString(4);
                                prod_sold_processs = rs.getString(5);
                                apps = rs.getString(6);
                                crds = rs.getDate(7);
                                meeting_dates = rs.getDate(8);
                                pcb_sigs = rs.getString(9);
                                shipment_dates = rs.getDate(10);
                                class_prods = rs.getString(11);

                                rs1 = st1.executeQuery("select prod_name,customer_name from   product_master_pcb where part_no='" + rs.getString(1) + "'");
                                while (rs1.next()) {
                                    pcb_prod_names = rs1.getString(1);
                                    pcb_cust_names = rs1.getString(2);
                                }

                                rs2 = st2.executeQuery("select prod_name,customer_name from   product_master_sig where part_no='" + rs.getString(2) + "'");
                                while (rs2.next()) {
                                    sig_prod_names = rs2.getString(1);
                                    sig_cust_names = rs2.getString(2);
                                }

                            }
                        %>
                        <form action="editphase3_pcba" method="post" onsubmit="return vp3pcb()">
                            <table >
                                <tr>
                                    <th colspan="4" style="text-align: center;">APQP Timing Plan</th>
                                    <th colspan="1">APQP&nbsp;&nbsp;Number</th>
                                    <th colspan="4"><font style="font-weight: normal"><%=apqp_no%></font></th>
                                </tr>
                                <%
                                    if (pcb_sigs.equals("PCB")) {
                                %>
                                <tr>
                                    <th colspan="2">Product Name :<font style="font-weight: normal"> <%=pcb_prod_names%></font></th>
                                    <th colspan="1">PCBA Part #:</th>
                                    <th colspan="2"><font style="font-weight: normal"><%=pcba_part_nos%></font></th>
                                    <th>Customer&nbsp;Name&nbsp;:</th>
                                    <th colspan="3" style="width: 5%;">&nbsp;&nbsp;<font style="font-weight: normal"><%=pcb_cust_names%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></th>
                                </tr>

                                <tr>
                                    <th colspan="2">Proto Qty : <font style="font-weight: normal"><%=proto_qtys%></font></th>
                                    <th colspan="1">SIG Part #:</th>
                                    <th colspan="2"><font style="font-weight: normal">NA</font></th>
                                    <th>CRD :</th>
                                    <th colspan="3" style="width: 5%;"><font style="font-weight: normal"><%=crds%></font></th>
                                </tr>
                                <tr>
                                    <th colspan="2">Project Leader : <font style="font-weight: normal"><%=project_leaders%></font></th>
                                    <th colspan="1">Meeting Date :</th>
                                    <th colspan="2"><font style="font-weight: normal"><%=meeting_dates%></font></th>
                                    <th>Shipment Date :</th>
                                    <th colspan="3" style="width: 5%;"><font style="font-weight: normal"><%=shipment_dates%></font></th>
                                </tr>
                                <tr>
                                    <th colspan="2">Product Soldering Process(RoHS/Non-RoHS) :<font style="font-weight: normal"><%=prod_sold_processs%></font></th>
                                    <th colspan="3">Class of the Product:<font style="font-weight: normal"><%=class_prods%></font></th>
                                    <th colspan="1">Application: </th>
                                    <th colspan="4"><font style="font-weight: normal"><%=apps%></font></th>

                                </tr>
                                <tr>
                                    <th rowspan="2">S.NO</th>
                                    <th colspan="1" rowspan="2">Parameters / Inputs</th>
                                    <th colspan="2">Responsibility and Target Date for Non available parameters</th>
                                    <th rowspan="2">Actual Date</th>
                                    <th rowspan="2" colspan="4">Remarks</th>
                                </tr>
                                <tr>
                                    <th>Responsibility </th> 
                                    <th>Target Date</th>   
                                </tr>

                                <%
                                } else if (pcb_sig.equals("SIG")) {
                                %>
                                <tr>
                                    <th colspan="2">Product Name :<font style="font-weight: normal"><%=sig_prod_names%></font></th>
                                    <th colspan="1">PCBA Part # :</th>
                                    <th colspan="2"><font style="font-weight: normal">NA</font></th>
                                    <th>Customer&nbsp;Name&nbsp;:</th>
                                    <th colspan="3">&nbsp;&nbsp;<font style="font-weight: normal"><%=sig_cust_names%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></th>
                                </tr>

                                <tr>
                                    <th colspan="2">Proto Qty :  <font style="font-weight: normal"><%=proto_qtys%></font></th>
                                    <th colspan="1">SIG Part # :</th>
                                    <th colspan="2"><font style="font-weight: normal"><%=sig_part_nos%></font></th>
                                    <th>CRD :</th>
                                    <th colspan="3">&nbsp;<font style="font-weight: normal"><%=crds%>&nbsp;</font></th>
                                </tr>
                                <tr>
                                    <th colspan="2">Project Leader :  <font style="font-weight: normal"><%=project_leaders%></font></th>
                                    <th colspan="1">Meeting Date :</th>
                                    <th colspan="2"><font style="font-weight: normal"><%=meeting_dates%></font></th>
                                    <th>Shipment Date :</th>
                                    <th colspan="3" style="width: 5%;"><font style="font-weight: normal"><%=shipment_dates%></font></th>
                                </tr>
                                <tr>
                                    <th colspan="2">Product Soldering Process(RoHS/Non-RoHS) :<font style="font-weight: normal"><%=prod_sold_processs%></font></th>
                                    <th colspan="3">Class of the Product:<font style="font-weight: normal"><%=class_prods%></font></th>
                                    <th colspan="1">Application: </th>
                                    <th colspan="4"><font style="font-weight: normal"><%=apps%></font></th>

                                </tr>
                                <tr>
                                    <th rowspan="2">S.NO</th>
                                    <th colspan="1" rowspan="2">Parameters / Inputs</th>
                                    <th colspan="2">Responsibility and Target Date for Non available parameters</th>
                                    <th rowspan="2">Actual Date</th>
                                    <th rowspan="2" colspan="4">Remarks</th>
                                </tr>
                                <tr>
                                    <th>Responsibility </th> 
                                    <th>Target Date</th>   
                                </tr>

                                <%
                                } else {
                                %>

                                <tr>
                                    <%
                                        if (!sig_prod_names.equals("")) {
                                    %>

                                    <th colspan="2">Product Name :<font style="font-weight: normal"><%=sig_prod_names%></font></th>
                                    <th colspan="1">PCBA Part # :</th>
                                    <th colspan="2"><font style="font-weight: normal"><%=pcba_part_nos%></font></th>
                                    <th>Customer&nbsp;Name&nbsp;:</th>
                                    <th colspan="3">&nbsp;&nbsp;<font style="font-weight: normal"><%=pcb_cust_names%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></th>

                                    <%
                                    } else {
                                    %>


                                    <th colspan="2">Product Name :<font style="font-weight: normal"><%=pcb_prod_names%></font></th>
                                    <th colspan="1">PCBA Part # :</th>
                                    <th colspan="2"><font style="font-weight: normal"><%=pcba_part_nos%></font></th>
                                    <th>Customer&nbsp;Name&nbsp;:</th>
                                    <th colspan="3">&nbsp;&nbsp;<font style="font-weight: normal"><%=pcb_cust_names%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></th>
                                        <%
                                            }
                                        %>

                                </tr>

                                <tr>
                                    <th colspan="2">Proto Qty :  <font style="font-weight: normal"><%=proto_qtys%></font></th>
                                    <th colspan="1">SIG Part # :</th>
                                    <th colspan="2"><font style="font-weight: normal"><%=sig_part_nos%></font></th>
                                    <th>CRD :</th>
                                    <th colspan="3">&nbsp;<font style="font-weight: normal"><%=crds%>&nbsp;</font></th>
                                </tr>
                                <tr>
                                    <th colspan="2">Project Leader :  <font style="font-weight: normal"><%=project_leaders%></font></th>
                                    <th colspan="1">Meeting Date :</th>
                                    <th colspan="2"><font style="font-weight: normal"><%=meeting_dates%></font></th>
                                    <th>Shipment Date :</th>
                                    <th colspan="3" style="width: 5%;"><font style="font-weight: normal"><%=shipment_dates%></font></th>
                                </tr>
                                <tr>
                                    <th colspan="2">Product Soldering Process(RoHS/Non-RoHS) :<font style="font-weight: normal"><%=prod_sold_processs%></font></th>
                                    <th colspan="3">Class of the Product:<font style="font-weight: normal"><%=class_prods%></font></th>
                                    <th colspan="1">Application: </th>
                                    <th colspan="4"><font style="font-weight: normal"><%=apps%></font></th>

                                </tr>
                                <tr>
                                    <th rowspan="2">S.NO</th>
                                    <th colspan="1" rowspan="2">Parameters / Inputs</th>
                                    <th colspan="2">Responsibility and Target Date for Non available parameters</th>
                                    <th rowspan="2">Actual Date</th>
                                    <th rowspan="2" colspan="4">Remarks</th>
                                </tr>
                                <tr>
                                    <th>Responsibility </th> 
                                    <th>Target Date</th>   
                                </tr>

                                <%
                                    }
                                %>
                                <input type="hidden" name="apqp_no" id="apqp_no" value="<%=apqp_no%>">
                                <input type="hidden" name="type" value="PCBA">


                                <tr>
                                    <th colspan="7">PHASE III - Process Design & Development</th>
                                </tr>
                                <tr>
                                    <th colspan="7" style="text-align: center">PCBA</th>
                                </tr>
                                <%
                                    int ph3_count = 1;
                                    String res3 = "";
                                    ResultSet reA3 = st.executeQuery("select id,sno,parameters from  parameter_master where type='PCBA' and phase='PHASE III - Process Design & Development' and type='PCBA'");
                                    while (reA3.next()) {
                                        res3 = cls.checkTimeHistory(apqp_no, reA3.getString(2), reA3.getString(3));
                                %>
                                <tr>
                                    <%
                                        if (res3.equals("Yes")) {
                                            //   out.print(res+", ");
                                            ResultSet rsa3 = st_1.executeQuery("select sno,parameters_input,responsibility,target_date,actual_date,remark from  time_history where sno='" + reA3.getString(2) + "' and parameters_input='" + reA3.getString(3) + "' and apqp_no='" + apqp_no + "' and type='PCBA'");
                                            while (rsa3.next()) {
                                    %>
                                    <td>
                                        <%
                                            String psno = rsa3.getString(1);
                                            out.print(psno.substring(4, psno.length()));
                                        %>
                                        <input type="hidden" name="sno<%=ph3_count%>" value="<%=rsa3.getString(1)%>">
                                    </td>
                                    <td><%=rsa3.getString(2)%><input type="hidden" name="para<%=ph3_count%>" value="<%=rsa3.getString(2)%>"></td>
                                    <td><input type="text" name="res<%=ph3_count%>" id="resp3<%=ph3_count%>" value="<%=rsa3.getString(3)%>"></td>
                                    <td><input type="date" name="target<%=ph3_count%>" id="targetp3<%=ph3_count%>" value="<%=rsa3.getDate(4)%>"></td>
                                    <td><input type="date" name="actual<%=ph3_count%>" id="actualp3<%=ph3_count%>" value="<%=rsa3.getDate(5)%>"></td>
                                    <td colspan="2"><textarea name="remark<%=ph3_count%>" id="remark<%=ph3_count%>"  ><%=rsa3.getString(6)%></textarea></td>                                        

                                    <%
                                        }
                                    } else {

                                    %>
                                    <td>
                                        <%                                            String psno3 = reA3.getString(2);
                                            out.print(psno3.substring(4, psno3.length()));
                                        %>
                                        <input type="hidden" name="sno<%=ph3_count%>" value="<%=reA3.getString(2)%>"></td>
                                    <td><%=reA3.getString(3)%><input type="hidden" name="para<%=ph3_count%>" value="<%=reA3.getString(3)%>"></td>
                                    <td><input type="text" name="res<%=ph3_count%>" id="resp3<%=ph3_count%>" ></td>
                                    <td><input type="date" name="target<%=ph3_count%>" id="targetp3<%=ph3_count%>"></td>
                                    <td><input type="date" name="actual<%=ph3_count%>" id="actualp3<%=ph3_count%>"></td>
                                    <td colspan="2"><textarea name="remark<%=ph3_count%>" id="remark<%=ph3_count%>"  ></textarea></td>
                                </tr>
                                <%
                                        }
                                        ph3_count++;
                                        res3 = "";
                                    }
                                %> 
                                <tr>
                                    <td colspan="7" align="center"><input type="submit" name="Save" value="Save" class="but"></td>
                                </tr>
                                <input  type="hidden" id="ph3_count" name="ph3_count" value="<%=ph3_count%>">
                            </table> 
                        </form>
                    </div>
                    <a href="#" class="show_hideres" rel="#slidingDiv_211">PHASE III SIG</a><br />
                    <div id="slidingDiv_211">
                        <script>
                            function vp3sig() {
                                var row = document.getElementById("phps3_count").value - 1;
                                for (var i = 1; i <= row; i++) {
                                    var res = document.getElementById("resps3" + i).value;
                                    var tdate = document.getElementById("targetps3" + i).value;
                                    var adate = document.getElementById("actualps3" + i).value;
                                    if (res != "") {
                                        if (tdate == "" && adate == "") {
                                            alert("Enter Target Date or Actual Date");
                                            document.getElementById("targetps3" + i).focus();
                                            return false;
                                        }
                                    } else {
                                        if (tdate != "" || adate != "") {
                                            alert("Enter Responsibility Name !");
                                            document.getElementById("resps3" + i).focus();
                                            return false;
                                        }
                                    }
                                }
                            }
                        </script>
                        <form action="editphase3_sig" method="post" onsubmit="return vp3sig()">
                            <table >
                                <tr>
                                    <th colspan="4" style="text-align: center;">APQP Timing Plan</th>
                                    <th colspan="1">APQP&nbsp;&nbsp;Number</th>
                                    <th colspan="4"><font style="font-weight: normal"><%=apqp_no%></font></th>
                                </tr>
                                <%
                                    if (pcb_sigs.equals("PCB")) {
                                %>
                                <tr>
                                    <th colspan="2">Product Name :<font style="font-weight: normal"> <%=pcb_prod_names%></font></th>
                                    <th colspan="1">PCBA Part #:</th>
                                    <th colspan="2"><font style="font-weight: normal"><%=pcba_part_nos%></font></th>
                                    <th>Customer&nbsp;Name&nbsp;:</th>
                                    <th colspan="3" style="width: 5%;">&nbsp;&nbsp;<font style="font-weight: normal"><%=pcb_cust_names%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></th>
                                </tr>

                                <tr>
                                    <th colspan="2">Proto Qty : <font style="font-weight: normal"><%=proto_qtys%></font></th>
                                    <th colspan="1">SIG Part #:</th>
                                    <th colspan="2"><font style="font-weight: normal">NA</font></th>
                                    <th>CRD :</th>
                                    <th colspan="3" style="width: 5%;"><font style="font-weight: normal"><%=crds%></font></th>
                                </tr>
                                <tr>
                                    <th colspan="2">Project Leader : <font style="font-weight: normal"><%=project_leaders%></font></th>
                                    <th colspan="1">Meeting Date :</th>
                                    <th colspan="2"><font style="font-weight: normal"><%=meeting_dates%></font></th>
                                    <th>Shipment Date :</th>
                                    <th colspan="3" style="width: 5%;"><font style="font-weight: normal"><%=shipment_dates%></font></th>
                                </tr>
                                <tr>
                                    <th colspan="2">Product Soldering Process(RoHS/Non-RoHS) :<font style="font-weight: normal"><%=prod_sold_processs%></font></th>
                                    <th colspan="3">Class of the Product:<font style="font-weight: normal"><%=class_prods%></font></th>
                                    <th colspan="1">Application: </th>
                                    <th colspan="4"><font style="font-weight: normal"><%=apps%></font></th>

                                </tr>
                                <tr>
                                    <th rowspan="2">S.NO</th>
                                    <th colspan="1" rowspan="2">Parameters / Inputs</th>
                                    <th colspan="2">Responsibility and Target Date for Non available parameters</th>
                                    <th rowspan="2">Actual Date</th>
                                    <th rowspan="2" colspan="4">Remarks</th>
                                </tr>
                                <tr>
                                    <th>Responsibility </th> 
                                    <th>Target Date</th>   
                                </tr>

                                <%
                                } else if (pcb_sigs.equals("SIG")) {
                                %>
                                <tr>
                                    <th colspan="2">Product Name :<font style="font-weight: normal"><%=sig_prod_names%></font></th>
                                    <th colspan="1">PCBA Part # :</th>
                                    <th colspan="2"><font style="font-weight: normal">NA</font></th>
                                    <th>Customer&nbsp;Name&nbsp;:</th>
                                    <th colspan="3">&nbsp;&nbsp;<font style="font-weight: normal"><%=sig_cust_names%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></th>
                                </tr>

                                <tr>
                                    <th colspan="2">Proto Qty :  <font style="font-weight: normal"><%=proto_qtys%></font></th>
                                    <th colspan="1">SIG Part # :</th>
                                    <th colspan="2"><font style="font-weight: normal"><%=sig_part_nos%></font></th>
                                    <th>CRD :</th>
                                    <th colspan="3">&nbsp;<font style="font-weight: normal"><%=crds%>&nbsp;</font></th>
                                </tr>
                                <tr>
                                    <th colspan="2">Project Leader :  <font style="font-weight: normal"><%=project_leaders%></font></th>
                                    <th colspan="1">Meeting Date :</th>
                                    <th colspan="2"><font style="font-weight: normal"><%=meeting_dates%></font></th>
                                    <th>Shipment Date :</th>
                                    <th colspan="3" style="width: 5%;"><font style="font-weight: normal"><%=shipment_dates%></font></th>
                                </tr>
                                <tr>
                                    <th colspan="2">Product Soldering Process(RoHS/Non-RoHS) :<font style="font-weight: normal"><%=prod_sold_processs%></font></th>
                                    <th colspan="3">Class of the Product:<font style="font-weight: normal"><%=class_prods%></font></th>
                                    <th colspan="1">Application: </th>
                                    <th colspan="4"><font style="font-weight: normal"><%=apps%></font></th>

                                </tr>
                                <tr>
                                    <th rowspan="2">S.NO</th>
                                    <th colspan="1" rowspan="2">Parameters / Inputs</th>
                                    <th colspan="2">Responsibility and Target Date for Non available parameters</th>
                                    <th rowspan="2">Actual Date</th>
                                    <th rowspan="2" colspan="4">Remarks</th>
                                </tr>
                                <tr>
                                    <th>Responsibility </th> 
                                    <th>Target Date</th>   
                                </tr>

                                <%
                                } else {
                                %>
                                <tr>
                                    <%
                                        if (!sig_prod_names.equals("")) {
                                    %>

                                    <th colspan="2">Product Name :<font style="font-weight: normal"><%=sig_prod_names%></font></th>
                                    <th colspan="1">PCBA Part # :</th>
                                    <th colspan="2"><font style="font-weight: normal"><%=pcba_part_nos%></font></th>
                                    <th>Customer&nbsp;Name&nbsp;:</th>
                                    <th colspan="3">&nbsp;&nbsp;<font style="font-weight: normal"><%=pcb_cust_names%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></th>

                                    <%
                                    } else {
                                    %>


                                    <th colspan="2">Product Name :<font style="font-weight: normal"><%=pcb_prod_names%></font></th>
                                    <th colspan="1">PCBA Part # :</th>
                                    <th colspan="2"><font style="font-weight: normal"><%=pcba_part_nos%></font></th>
                                    <th>Customer&nbsp;Name&nbsp;:</th>
                                    <th colspan="3">&nbsp;&nbsp;<font style="font-weight: normal"><%=pcb_cust_names%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></th>
                                        <%
                                            }
                                        %>

                                </tr>

                                <tr>
                                    <th colspan="2">Proto Qty :  <font style="font-weight: normal"><%=proto_qtys%></font></th>
                                    <th colspan="1">SIG Part # :</th>
                                    <th colspan="2"><font style="font-weight: normal"><%=sig_part_nos%></font></th>
                                    <th>CRD :</th>
                                    <th colspan="3">&nbsp;<font style="font-weight: normal"><%=crds%>&nbsp;</font></th>
                                </tr>
                                <tr>
                                    <th colspan="2">Project Leader :  <font style="font-weight: normal"><%=project_leaders%></font></th>
                                    <th colspan="1">Meeting Date :</th>
                                    <th colspan="2"><font style="font-weight: normal"><%=meeting_dates%></font></th>
                                    <th>Shipment Date :</th>
                                    <th colspan="3" style="width: 5%;"><font style="font-weight: normal"><%=shipment_dates%></font></th>
                                </tr>
                                <tr>
                                    <th colspan="2">Product Soldering Process(RoHS/Non-RoHS) :<font style="font-weight: normal"><%=prod_sold_processs%></font></th>
                                    <th colspan="3">Class of the Product:<font style="font-weight: normal"><%=class_prods%></font></th>
                                    <th colspan="1">Application: </th>
                                    <th colspan="4"><font style="font-weight: normal"><%=apps%></font></th>

                                </tr>
                                <tr>
                                    <th rowspan="2">S.NO</th>
                                    <th colspan="1" rowspan="2">Parameters / Inputs</th>
                                    <th colspan="2">Responsibility and Target Date for Non available parameters</th>
                                    <th rowspan="2">Actual Date</th>
                                    <th rowspan="2" colspan="4">Remarks</th>
                                </tr>
                                <tr>
                                    <th>Responsibility </th> 
                                    <th>Target Date</th>   
                                </tr>

                                <%
                                    }
                                %>
                                <input type="hidden" name="apqp_no" id="apqp_no" value="<%=apqp_no%>">
                                <input type="hidden" name="type" value="SIG Level">


                                <tr>
                                    <th colspan="7">PHASE III - Process Design & Development</th>
                                </tr>
                                <tr>
                                    <th colspan="7" style="text-align: center">SIG Level</th>
                                </tr>
                                <%
                                    int ph3s_count = 1;
                                    String res3s = "";
                                    ResultSet reA3s = st.executeQuery("select id,sno,parameters from  parameter_master where phase='PHASE III - Process Design & Development' and type='SIG Level'");
                                    while (reA3s.next()) {
                                        res3s = cls.checkTimeHistory(apqp_no, reA3s.getString(2), reA3s.getString(3));
                                %>
                                <tr>
                                    <%
                                        if (res3s.equals("Yes")) {
                                            //   out.print(res+", ");
                                            ResultSet rsa3s = st_1.executeQuery("select sno,parameters_input,responsibility,target_date,actual_date,remark from  time_history where sno='" + reA3s.getString(2) + "' and parameters_input='" + reA3s.getString(3) + "' and apqp_no='" + apqp_no + "' and type='SIG Level'");
                                            while (rsa3s.next()) {
                                    %>
                                    <td>
                                        <%
                                            String psno = rsa3s.getString(1);
                                            out.print(psno.substring(4, psno.length()));
                                        %>
                                        <input type="hidden" name="sno<%=ph3s_count%>" value="<%=rsa3s.getString(1)%>"></td>
                                    <td><%=rsa3s.getString(2)%><input type="hidden" name="para<%=ph3s_count%>" value="<%=rsa3s.getString(2)%>"></td>
                                    <td><input type="text" name="res<%=ph3s_count%>" id="resps3<%=ph3s_count%>" value="<%=rsa3s.getString(3)%>"></td>
                                    <td><input type="date" name="target<%=ph3s_count%>" id="targetps3<%=ph3s_count%>" value="<%=rsa3s.getDate(4)%>"></td>
                                    <td><input type="date" name="actual<%=ph3s_count%>" id="actualps3<%=ph3s_count%>" value="<%=rsa3s.getDate(5)%>"></td>
                                    <td colspan="2"><textarea name="remark<%=ph3s_count%>" id="remark<%=ph3s_count%>"  ><%=rsa3s.getString(6)%></textarea></td>                                        

                                    <%
                                        }
                                    } else {

                                    %>
                                    <td>
                                        <%                                                String psno1 = reA3s.getString(2);
                                            out.print(psno1.substring(4, psno1.length()));
                                        %>
                                        <input type="hidden" name="sno<%=ph3s_count%>" value="<%=reA3s.getString(2)%>"></td>
                                    <td><%=reA3s.getString(3)%><input type="hidden" name="para<%=ph3s_count%>" value="<%=reA3s.getString(3)%>"></td>
                                    <td><input type="text" name="res<%=ph3s_count%>" id="resps3<%=ph3s_count%>" ></td>
                                    <td><input type="date" name="target<%=ph3s_count%>" id="targetps3<%=ph3s_count%>"></td>
                                    <td><input type="date" name="actual<%=ph3s_count%>" id="actualps3<%=ph3s_count%>"></td>
                                    <td colspan="2"><textarea name="remark<%=ph3s_count%>" id="remark<%=ph3s_count%>"  ></textarea></td>
                                </tr>
                                <%
                                        }
                                        ph3s_count++;
                                        res3s = "";
                                    }
                                %> 
                                <tr>
                                    <td colspan="7" align="center"><input type="submit" name="Save" value="Save" class="but"></td>
                                </tr>
                                <input  type="hidden" id="phps3_count" name="ph3s_count" value="<%=ph3s_count%>">
                            </table>
                        </form>
                    </div> 
                    <%
                    } else if (p.equals("6")) {
                    %>
                    <a href="#" class="show_hide3" rel="#slidingDiv_2111">PHASE IV General</a><br />
                    <div id="slidingDiv_2111">
                        <script>
                            function vp4gen() {
                                var row = document.getElementById("phg4_count").value - 1;
                                for (var i = 1; i <= row; i++) {
                                    var res = document.getElementById("resg4" + i).value;
                                    var tdate = document.getElementById("targetg4" + i).value;
                                    var adate = document.getElementById("actualg4" + i).value;
                                    if (res != "") {
                                        if (tdate == "" && adate == "") {
                                            alert("Enter Target Date or Actual Date");
                                            document.getElementById("targetg4" + i).focus();
                                            return false;
                                        }
                                    } else {
                                        if (tdate != "" || adate != "") {
                                            alert("Enter Responsibility Name !");
                                            document.getElementById("resg4" + i).focus();
                                            return false;
                                        }
                                    }
                                }
                            }
                        </script>


                        <%
                            Statement st2 = null;
                            ResultSet rs = null;
                            ResultSet rs1 = null;
                            ResultSet rs2 = null;

                            st1 = con.createStatement();
                            st2 = con.createStatement();

                            rs = st.executeQuery("select a.pcba_part_no,a.sig_part_no,b.pro_qty,b.project_leader,b.prod_sold_process,b.application,b.customer_req_date,b.apqp_meeting_date,b.pcb_sig,b.shipment_date,b.class_product from  apqp_aps as a join  apqp_eil as b on a.apqp_no=b.apqp_no where a.apqp_no='" + apqp_no + "'");
                            while (rs.next()) {
                                pcba_part_nos = rs.getString(1);
                                sig_part_nos = rs.getString(2);
                                proto_qtys = rs.getString(3);
                                project_leaders = rs.getString(4);
                                prod_sold_processs = rs.getString(5);
                                apps = rs.getString(6);
                                crds = rs.getDate(7);
                                meeting_dates = rs.getDate(8);
                                pcb_sigs = rs.getString(9);
                                shipment_dates = rs.getDate(10);
                                class_prods = rs.getString(11);

                                rs1 = st1.executeQuery("select prod_name,customer_name from   product_master_pcb where part_no='" + rs.getString(1) + "'");
                                while (rs1.next()) {
                                    pcb_prod_names = rs1.getString(1);
                                    pcb_cust_names = rs1.getString(2);
                                }

                                rs2 = st2.executeQuery("select prod_name,customer_name from   product_master_sig where part_no='" + rs.getString(2) + "'");
                                while (rs2.next()) {
                                    sig_prod_names = rs2.getString(1);
                                    sig_cust_names = rs2.getString(2);
                                }

                            }
                        %>
                        <form action="editphase_general" method="post" onsubmit="return vp4gen()">
                            <table>
                                <tr>
                                    <th colspan="4" style="text-align: center;">APQP Timing Plan </th>
                                    <th colspan="1">APQP&nbsp;&nbsp;Number</th>
                                    <th colspan="4"><font style="font-weight: normal"><%=apqp_no%></font></th>
                                </tr>
                                <%

                                    if (pcb_sigs.equals("PCB")) {
                                %>
                                <tr>
                                    <th colspan="2">Product Name :<font style="font-weight: normal">  <%=pcb_prod_names%></font></th>
                                    <th colspan="1">PCBA Part #:</th>
                                    <th colspan="2"><font style="font-weight: normal"><%=pcba_part_nos%></font></th>
                                    <th>Customer&nbsp;Name&nbsp;:</th>
                                    <th colspan="3" style="width: 5%;">&nbsp;&nbsp;<font style="font-weight: normal"><%=pcb_cust_names%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></th>
                                </tr>

                                <tr>
                                    <th colspan="2">Proto Qty : <font style="font-weight: normal"><%=proto_qtys%></font></th>
                                    <th colspan="1">SIG Part #:</th>
                                    <th colspan="2"><font style="font-weight: normal">NA</font></th>
                                    <th>CRD :</th>
                                    <th colspan="3" style="width: 5%;"><font style="font-weight: normal"><%=crds%></font></th>
                                </tr>
                                <tr>
                                    <th colspan="2">Project Leader : <font style="font-weight: normal"><%=project_leaders%></font></th>
                                    <th colspan="1">Meeting Date :</th>
                                    <th colspan="2"><font style="font-weight: normal"><%=meeting_dates%></font></th>
                                    <th>Shipment Date :</th>
                                    <th colspan="3" style="width: 5%;"><font style="font-weight: normal"><%=shipment_dates%></font></th>
                                </tr>
                                <tr>
                                    <th colspan="2">Product Soldering Process(RoHS/Non-RoHS) :<font style="font-weight: normal"><%=prod_sold_processs%></font></th>
                                    <th colspan="3">Class of the Product:<font style="font-weight: normal"><%=class_prods%></font></th>
                                    <th colspan="1">Application: </th>
                                    <th colspan="4"><font style="font-weight: normal"><%=apps%></font></th>

                                </tr>
                                <tr>
                                    <th rowspan="2">S.NO</th>
                                    <th colspan="1" rowspan="2">Parameters / Inputs</th>
                                    <th colspan="2">Responsibility and Target Date for Non available parameters</th>
                                    <th rowspan="2">Actual Date</th>
                                    <th rowspan="2" colspan="4">Remarks</th>
                                </tr>
                                <tr>
                                    <th>Responsibility </th> 
                                    <th>Target Date</th>   
                                </tr>

                                <%
                                } else if (pcb_sigs.equals("SIG")) {
                                %>
                                <tr>
                                    <th colspan="2">Product Name :<font style="font-weight: normal"><%=sig_prod_names%></font></th>
                                    <th colspan="1">PCBA Part # :</th>
                                    <th colspan="2"><font style="font-weight: normal">NA</font></th>
                                    <th>Customer&nbsp;Name&nbsp;:</th>
                                    <th colspan="3">&nbsp;&nbsp;<font style="font-weight: normal"><%=sig_cust_names%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></th>
                                </tr>

                                <tr>
                                    <th colspan="2">Proto Qty :  <font style="font-weight: normal"><%=proto_qtys%></font></th>
                                    <th colspan="1">SIG Part # :</th>
                                    <th colspan="2"><font style="font-weight: normal"><%=sig_part_nos%></font></th>
                                    <th>CRD :</th>
                                    <th colspan="3">&nbsp;<font style="font-weight: normal"><%=crds%>&nbsp;</font></th>
                                </tr>
                                <tr>
                                    <th colspan="2">Project Leader :  <font style="font-weight: normal"><%=project_leaders%></font></th>
                                    <th colspan="1">Meeting Date :</th>
                                    <th colspan="2"><font style="font-weight: normal"><%=meeting_dates%></font></th>
                                    <th>Shipment Date :</th>
                                    <th colspan="3" style="width: 5%;"><font style="font-weight: normal"><%=shipment_dates%></font></th>
                                </tr>
                                <tr>
                                    <th colspan="2">Product Soldering Process(RoHS/Non-RoHS) :<font style="font-weight: normal"><%=prod_sold_processs%></font></th>
                                    <th colspan="3">Class of the Product:<font style="font-weight: normal"><%=class_prods%></font></th>
                                    <th colspan="1">Application: </th>
                                    <th colspan="4"><font style="font-weight: normal"><%=apps%></font></th>

                                </tr>
                                <tr>
                                    <th rowspan="2">S.NO</th>
                                    <th colspan="1" rowspan="2">Parameters / Inputs</th>
                                    <th colspan="2">Responsibility and Target Date for Non available parameters</th>
                                    <th rowspan="2">Actual Date</th>
                                    <th rowspan="2" colspan="4">Remarks</th>
                                </tr>
                                <tr>
                                    <th>Responsibility </th> 
                                    <th>Target Date</th>   
                                </tr>


                                <%
                                } else {
                                %>
                                <tr>
                                    <%
                                        if (!sig_prod_names.equals("")) {
                                    %>

                                    <th colspan="2">Product Name :<font style="font-weight: normal"><%=sig_prod_names%></font></th>
                                    <th colspan="1">PCBA Part # :</th>
                                    <th colspan="2"><font style="font-weight: normal"><%=pcba_part_nos%></font></th>
                                    <th>Customer&nbsp;Name&nbsp;:</th>
                                    <th colspan="3">&nbsp;&nbsp;<font style="font-weight: normal"><%=pcb_cust_names%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></th>

                                    <%
                                    } else {
                                    %>


                                    <th colspan="2">Product Name :<font style="font-weight: normal"><%=pcb_prod_names%></font></th>
                                    <th colspan="1">PCBA Part # :</th>
                                    <th colspan="2"><font style="font-weight: normal"><%=pcba_part_nos%></font></th>
                                    <th>Customer&nbsp;Name&nbsp;:</th>
                                    <th colspan="3">&nbsp;&nbsp;<font style="font-weight: normal"><%=pcb_cust_names%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></th>
                                        <%
                                            }
                                        %>

                                </tr>
                                <tr>
                                    <th colspan="2">Proto Qty :  <font style="font-weight: normal"><%=proto_qtys%></font></th>
                                    <th colspan="1">SIG Part # :</th>
                                    <th colspan="2"><font style="font-weight: normal"><%=sig_part_nos%></font></th>
                                    <th>CRD :</th>
                                    <th colspan="3">&nbsp;<font style="font-weight: normal"><%=crds%>&nbsp;</font></th>
                                </tr>
                                <tr>
                                    <th colspan="2">Project Leader :  <font style="font-weight: normal"><%=project_leaders%></font></th>
                                    <th colspan="1">Meeting Date :</th>
                                    <th colspan="2"><font style="font-weight: normal"><%=meeting_dates%></font></th>
                                    <th>Shipment Date :</th>
                                    <th colspan="3" style="width: 5%;"><font style="font-weight: normal"><%=shipment_dates%></font></th>
                                </tr>
                                <tr>
                                    <th colspan="2">Product Soldering Process(RoHS/Non-RoHS) :<font style="font-weight: normal"><%=prod_sold_processs%></font></th>
                                    <th colspan="3">Class of the Product:<font style="font-weight: normal"><%=class_prods%></font></th>
                                    <th colspan="1">Application: </th>
                                    <th colspan="4"><font style="font-weight: normal"><%=apps%></font></th>

                                </tr>
                                <tr>
                                    <th rowspan="2">S.NO</th>
                                    <th colspan="1" rowspan="2">Parameters / Inputs</th>
                                    <th colspan="2">Responsibility and Target Date for Non available parameters</th>
                                    <th rowspan="2">Actual Date</th>
                                    <th rowspan="2" colspan="4">Remarks</th>
                                </tr>
                                <tr>
                                    <th>Responsibility </th> 
                                    <th>Target Date</th>   
                                </tr>
                                <%
                                    }
                                %>
                                <input type="hidden" name="apqp_no" id="apqp_no" value="<%=apqp_no%>">
                                <input type="hidden" name="type"  value="General">


                                <tr>
                                    <th colspan="7">PHASE IV - Product/Process Validation</th>
                                </tr>
                                <tr>
                                    <th colspan="7" style="text-align: center">General</th>
                                </tr>

                                <tr>
                                    <%
                                        int ph4_count = 1;
                                        String res4 = "";
                                        ResultSet reA4 = st.executeQuery("select id,sno,parameters from  parameter_master where type='General' and phase='PHASE IV - Product/Process Validation' ");
                                        while (reA4.next()) {
                                            res4 = cls.checkTimeHistory(apqp_no, reA4.getString(2), reA4.getString(3));
                                    %>
                                <tr>
                                    <%
                                        if (res4.equals("Yes")) {
                                            //   out.print(res+", ");
                                            ResultSet resg4 = st_1.executeQuery("select sno,parameters_input,responsibility,target_date,actual_date,remark from  time_history where sno='" + reA4.getString(2) + "' and parameters_input='" + reA4.getString(3) + "' and apqp_no='" + apqp_no + "' and type='General'");
                                            while (resg4.next()) {
                                    %>
                                    <td style="text-align: center;">
                                        <%
                                            String psno = resg4.getString(1);
                                            out.print(psno.substring(5, psno.length()));
                                        %>
                                        <input type="hidden" name="sno<%=ph4_count%>" value="<%=resg4.getString(1)%>"></td>
                                    <td><%=resg4.getString(2)%><input type="hidden" name="para<%=ph4_count%>" value="<%=resg4.getString(2)%>"></td>
                                    <td><input type="text" name="res<%=ph4_count%>" id="resg4<%=ph4_count%>" value="<%=resg4.getString(3)%>"></td>
                                    <td><input type="date" name="target<%=ph4_count%>" id="targetg4<%=ph4_count%>" value="<%=resg4.getDate(4)%>"></td>
                                    <td><input type="date" name="actual<%=ph4_count%>" id="actualg4<%=ph4_count%>" value="<%=resg4.getDate(5)%>"></td>
                                    <td colspan="2"><textarea name="remark<%=ph4_count%>" id="remark<%=ph4_count%>"  ><%=resg4.getString(6)%></textarea></td>                                        

                                    <%
                                        }
                                    } else {

                                    %>
                                    <td>
                                        <%                                                String psno4 = reA4.getString(2);
                                            out.print(psno4.substring(5, psno4.length()));
                                        %>
                                        <input type="hidden" name="sno<%=ph4_count%>" value="<%=reA4.getString(2)%>"></td>
                                    <td><%=reA4.getString(3)%><input type="hidden" name="para<%=ph4_count%>" value="<%=reA4.getString(3)%>"></td>
                                    <td><input type="text" name="res<%=ph4_count%>" id="resg4<%=ph4_count%>" ></td>
                                    <td><input type="date" name="target<%=ph4_count%>" id="targetg4<%=ph4_count%>"></td>
                                    <td><input type="date" name="actual<%=ph4_count%>" id="actualg4<%=ph4_count%>"></td>
                                    <td colspan="2"><textarea name="remark<%=ph4_count%>" id="remark<%=ph4_count%>"  ></textarea></td>
                                </tr>
                                <%
                                        }
                                        ph4_count++;
                                        res4 = "";
                                    }
                                %> 
                                <tr>
                                    <td colspan="7" align="center"><input type="submit" name="Save" value="Save" class="but"></td>
                                </tr>
                                <input  type="hidden" id="phg4_count" name="ph4_count" value="<%=ph4_count%>">
                            </table> 
                        </form>
                    </div>                    
                    <%
                    } else if (p.equals("7")) {
                    %>
                    <a href="#" class="show_hide4" rel="#slidingDiv_21112">Others</a><br />
                    <div id="slidingDiv_21112">

                        <%
                            Statement st2 = null;
                            ResultSet rs = null;
                            ResultSet rs1 = null;
                            ResultSet rs2 = null;

                            st1 = con.createStatement();
                            st2 = con.createStatement();

                            rs = st.executeQuery("select a.pcba_part_no,a.sig_part_no,b.pro_qty,b.project_leader,b.prod_sold_process,b.application,b.customer_req_date,b.apqp_meeting_date,b.pcb_sig,b.shipment_date,b.class_product from  apqp_aps as a join  apqp_eil as b on a.apqp_no=b.apqp_no where a.apqp_no='" + apqp_no + "'");
                            while (rs.next()) {
                                pcba_part_nos = rs.getString(1);
                                sig_part_nos = rs.getString(2);
                                proto_qtys = rs.getString(3);
                                project_leaders = rs.getString(4);
                                prod_sold_processs = rs.getString(5);
                                apps = rs.getString(6);
                                crds = rs.getDate(7);
                                meeting_dates = rs.getDate(8);
                                pcb_sigs = rs.getString(9);
                                shipment_dates = rs.getDate(10);
                                class_prods = rs.getString(11);

                                rs1 = st1.executeQuery("select prod_name,customer_name from   product_master_pcb where part_no='" + rs.getString(1) + "'");
                                while (rs1.next()) {
                                    pcb_prod_names = rs1.getString(1);
                                    pcb_cust_names = rs1.getString(2);
                                }

                                rs2 = st2.executeQuery("select prod_name,customer_name from   product_master_sig where part_no='" + rs.getString(2) + "'");
                                while (rs2.next()) {
                                    sig_prod_names = rs2.getString(1);
                                    sig_cust_names = rs2.getString(2);
                                }

                            }
                        %>
                        <script>
                            function vplpcb() {
                                var row = document.getElementById("ph2_count").value - 1;
                                for (var i = 1; i <= row; i++) {
                                    var res = document.getElementById("res" + i).value;
                                    var tdate = document.getElementById("target" + i).value;
                                    var adate = document.getElementById("actual" + i).value;
                                    if (res != "") {
                                        if (tdate == "" && adate == "") {
                                            alert("Enter Target Date or Actual Date");
                                            document.getElementById("target" + i).focus();
                                            return false;
                                        }
                                    } else {
                                        if (tdate != "" || adate != "") {
                                            alert("Enter Responsibility Name !");
                                            document.getElementById("res" + i).focus();
                                            return false;
                                        }
                                    }
                                }
                            }
                        </script>
                        <form action="edit_others" method="post" onsubmit="return vplpcb()" >
                            <!--                        <form action="edit_others" method="post">-->
                            <table >
                                <tr>
                                    <th colspan="4" style="text-align: center;">APQP Timing Plan</th>
                                    <th colspan="1">APQP&nbsp;&nbsp;Number</th>
                                    <th colspan="4"><font style="font-weight:normal"><%=apqp_no%></font></th>
                                </tr>
                                <%
                                    if (pcb_sigs.equals("PCB")) {
                                %>
                                <tr>
                                    <th colspan="2">Product Name :<font style="font-weight: normal"> <%=pcb_prod_names%></font></th>
                                    <th colspan="1">PCBA Part #:</th>
                                    <th colspan="2"><font style="font-weight: normal"><%=pcba_part_nos%></font></th>
                                    <th>Customer&nbsp;Name&nbsp;:</th>
                                    <th colspan="3" style="width: 5%;">&nbsp;&nbsp;<font style="font-weight: normal"><%=pcb_cust_names%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></th>
                                </tr>

                                <tr>
                                    <th colspan="2">Proto Qty : <font style="font-weight: normal"><%=proto_qtys%></font></th>
                                    <th colspan="1">SIG Part #:</th>
                                    <th colspan="2"><font style="font-weight: normal">NA</font></th>
                                    <th>CRD :</th>
                                    <th colspan="3" style="width: 5%;"><font style="font-weight: normal"><%=crds%></font></th>
                                </tr>
                                <tr>
                                    <th colspan="2">Project Leader : <font style="font-weight: normal"><%=project_leaders%></font></th>
                                    <th colspan="1">Meeting Date :</th>
                                    <th colspan="2"><font style="font-weight: normal"><%=meeting_dates%></font></th>
                                    <th>Shipment Date :</th>
                                    <th colspan="3" style="width: 5%;"><font style="font-weight: normal"><%=shipment_dates%></font></th>
                                </tr>
                                <tr>
                                    <th colspan="2">Product Soldering Process(RoHS/Non-RoHS) :<font style="font-weight: normal"><%=prod_sold_processs%></font></th>
                                    <th colspan="3">Class of the Product:<font style="font-weight: normal"><%=class_prods%></font></th>
                                    <th colspan="1">Application: </th>
                                    <th colspan="4"><font style="font-weight: normal"><%=apps%></font></th>

                                </tr>
                                <tr>
                                    <th rowspan="2">S.NO</th>
                                    <th colspan="1" rowspan="2">Parameters / Inputs</th>
                                    <th colspan="2">Responsibility and Target Date for Non available parameters</th>
                                    <th rowspan="2">Actual Date</th>
                                    <th rowspan="2" colspan="4">Remarks</th>
                                </tr>
                                <tr>
                                    <th>Responsibility</th> 
                                    <th>Target Date</th>   
                                </tr>

                                <%
                                } else if (pcb_sigs.equals("SIG")) {
                                %>
                                <tr>
                                    <th colspan="2">Product Name :<font style="font-weight: normal"><%=sig_prod_names%></font></th>
                                    <th colspan="1">PCBA Part # :</th>
                                    <th colspan="2"><font style="font-weight: normal">NA</font></th>
                                    <th>Customer&nbsp;Name&nbsp;:</th>
                                    <th colspan="3">&nbsp;&nbsp;<font style="font-weight: normal"><%=sig_cust_names%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></th>
                                </tr>

                                <tr>
                                    <th colspan="2">Proto Qty :  <font style="font-weight: normal"><%=proto_qtys%></font></th>
                                    <th colspan="1">SIG Part # :</th>
                                    <th colspan="2"><font style="font-weight: normal"><%=sig_part_nos%></font></th>
                                    <th>CRD :</th>
                                    <th colspan="3">&nbsp;<font style="font-weight: normal"><%=crds%>&nbsp;</font></th>
                                </tr>
                                <tr>
                                    <th colspan="2">Project Leader :  <font style="font-weight: normal"><%=project_leaders%></font></th>
                                    <th colspan="1">Meeting Date :</th>
                                    <th colspan="2"><font style="font-weight: normal"><%=meeting_dates%></font></th>
                                    <th>Shipment Date :</th>
                                    <th colspan="3" style="width: 5%;"><font style="font-weight: normal"><%=shipment_dates%></font></th>
                                </tr>
                                <tr>
                                    <th colspan="2">Product Soldering Process(RoHS/Non-RoHS) :<font style="font-weight: normal"><%=prod_sold_processs%></font></th>
                                    <th colspan="3">Class of the Product:<font style="font-weight: normal"><%=class_prods%></font></th>
                                    <th colspan="1">Application: </th>
                                    <th colspan="4"><font style="font-weight: normal"><%=apps%></font></th>

                                </tr>
                                <tr>
                                    <th rowspan="2">S.NO</th>
                                    <th colspan="1" rowspan="2">Parameters / Inputs</th>
                                    <th colspan="2">Responsibility and Target Date for Non available parameters</th>
                                    <th rowspan="2">Actual Date</th>
                                    <th rowspan="2" colspan="4">Remarks</th>
                                </tr>
                                <tr>
                                    <th>Responsibility </th> 
                                    <th>Target Date</th>   
                                </tr>

                                <%
                                } else {
                                %>
                                <tr>
                                    <%
                                        if (!sig_prod_names.equals("")) {
                                    %>

                                    <th colspan="2">Product Name :<font style="font-weight: normal"><%=sig_prod_names%></font></th>
                                    <th colspan="1">PCBA Part # :</th>
                                    <th colspan="2"><font style="font-weight: normal"><%=pcba_part_nos%></font></th>
                                    <th>Customer&nbsp;Name&nbsp;:</th>
                                    <th colspan="3">&nbsp;&nbsp;<font style="font-weight: normal"><%=pcb_cust_names%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></th>

                                    <%
                                    } else {
                                    %>


                                    <th colspan="2">Product Name :<font style="font-weight: normal"><%=pcb_prod_names%></font></th>
                                    <th colspan="1">PCBA Part # :</th>
                                    <th colspan="2"><font style="font-weight: normal"><%=pcba_part_nos%></font></th>
                                    <th>Customer&nbsp;Name&nbsp;:</th>
                                    <th colspan="3">&nbsp;&nbsp;<font style="font-weight: normal"><%=pcb_cust_names%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></th>
                                        <%
                                            }
                                        %>

                                </tr>

                                <tr>
                                    <th colspan="2">Proto Qty :  <font style="font-weight: normal"><%=proto_qtys%></font></th>
                                    <th colspan="1">SIG Part # :</th>
                                    <th colspan="2"><font style="font-weight: normal"><%=sig_part_nos%></font></th>
                                    <th>CRD :</th>
                                    <th colspan="3">&nbsp;<font style="font-weight: normal"><%=crds%>&nbsp;</font></th>
                                </tr>
                                <tr>
                                    <th colspan="2">Project Leader :  <font style="font-weight: normal"><%=project_leaders%></font></th>
                                    <th colspan="1">Meeting Date :</th>
                                    <th colspan="2"><font style="font-weight: normal"><%=meeting_dates%></font></th>
                                    <th>Shipment Date :</th>
                                    <th colspan="3" style="width: 5%;"><font style="font-weight: normal"><%=shipment_dates%></font></th>
                                </tr>
                                <tr>
                                    <th colspan="2">Product Soldering Process(RoHS/Non-RoHS) :<font style="font-weight: normal"><%=prod_sold_processs%></font></th>
                                    <th colspan="3">Class of the Product:<font style="font-weight: normal"><%=class_prods%></font></th>
                                    <th colspan="1">Application: </th>
                                    <th colspan="4"><font style="font-weight: normal"><%=apps%></font></th>

                                </tr>
                                <tr>
                                    <th rowspan="2">S.NO</th>
                                    <th colspan="1" rowspan="2">Parameters / Inputs</th>
                                    <th colspan="2">Responsibility and Target Date for Non available parameters</th>
                                    <th rowspan="2">Actual Date</th>
                                    <th rowspan="2" colspan="4">Remarks</th>
                                </tr>
                                <tr>
                                    <th>Responsibility </th> 
                                    <th>Target Date</th>   
                                </tr>

                                <%
                                    }
                                %>
                                <input type="hidden" name="apqp_no" id="apqp_no" value="<%=apqp_no%>">
                                <input type="hidden" name="type"  value="Others">


                                <tr>
                                    <th colspan="7">Others</th>
                                </tr>
                                <tr>
                                    <th colspan="7" style="text-align: center">Others</th>
                                </tr>

                                <tr>
                                    <%
                                        int pho_count = 1;
                                        String reso = "";
                                        ResultSet reAo = st.executeQuery("select id,sno,parameters from  parameter_master where type='Others' and phase='Others' ");
                                        while (reAo.next()) {
                                            reso = cls.checkTimeHistory(apqp_no, reAo.getString(2), reAo.getString(3));
                                    %>
                                <tr>
                                    <%
                                        if (reso.equals("Yes")) {
                                            //   out.print(res+", ");
                                            ResultSet resgo = st_1.executeQuery("select sno,parameters_input,responsibility,target_date,actual_date,remark from  time_history where sno='" + reAo.getString(2) + "' and parameters_input='" + reAo.getString(3) + "' and apqp_no='" + apqp_no + "' and type='Others'");
                                            while (resgo.next()) {
                                    %>
                                    <td>
                                        <%
                                            String psno = resgo.getString(1);
                                            out.print(psno.substring(3, psno.length()));
                                        %>
                                        <input type="hidden" name="sno<%=pho_count%>" value="<%=resgo.getString(1)%>"></td>
                                    <td><%=resgo.getString(2)%><input type="hidden" name="para<%=pho_count%>" value="<%=resgo.getString(2)%>"></td>
                                    <td><input type="text" name="res<%=pho_count%>" id="res<%=pho_count%>" value="<%=resgo.getString(3)%>"></td>
                                    <td><input type="date" name="target<%=pho_count%>" id="target<%=pho_count%>" value="<%=resgo.getDate(4)%>"></td>
                                    <td><input type="date" name="actual<%=pho_count%>" id="actual<%=pho_count%>" value="<%=resgo.getDate(5)%>"></td>
                                    <td colspan="2"><textarea name="remark<%=pho_count%>" id="remark<%=pho_count%>"  ><%=resgo.getString(6)%></textarea></td>                                        

                                    <%
                                        }
                                    } else {

                                    %>
                                    <td>
                                        <%                                                    String psno4 = reAo.getString(2);
                                            out.print(psno4.substring(3, psno4.length()));
                                        %>
                                        <input type="hidden" name="sno<%=pho_count%>" value="<%=reAo.getString(2)%>"></td>
                                    <td><%=reAo.getString(3)%><input type="hidden" name="para<%=pho_count%>" value="<%=reAo.getString(3)%>"></td>
                                    <td><input type="text" name="res<%=pho_count%>" id="res<%=pho_count%>" ></td>
                                    <td><input type="date" name="target<%=pho_count%>" id="target<%=pho_count%>"></td>
                                    <td><input type="date" name="actual<%=pho_count%>" id="actual<%=pho_count%>"></td>
                                    <td colspan="2"><textarea name="remark<%=pho_count%>" id="remark<%=pho_count%>"  ></textarea></td>
                                </tr>
                                <%
                                        }
                                        pho_count++;
                                        reso = "";
                                    }
                                %> 
                                <tr>
                                    <td colspan="7" align="center"><input type="submit" name="Save" value="Save" class="but"></td>
                                </tr>
                                <input  type="hidden" id="ph2_count" name="pho_count" value="<%=pho_count%>">
                            </table> 
                        </form>

                    </div>
                    <%
                    } else if (p.equals("8")) {

                        Statement ss = null;
                        Statement ss1 = null;
                        Statement ss2 = null;
                        Statement ss3 = null;
                        Statement ss4 = null;
                        ResultSet xx = null;
                        ResultSet xx1 = null;
                        ResultSet xx2 = null;
                        ResultSet xx3 = null;
                        ResultSet xx4 = null;

                        ss = con.createStatement();
                        ss1 = con.createStatement();
                        ss2 = con.createStatement();
                        ss3 = con.createStatement();
                        ss4 = con.createStatement();

                        Date meeting_datee = null;
                        Date crde = null;
                        Date shipment_datee = null;
                        String pcb_reve = "", sig_reve = "";
                        String product_namee = "", pcba_part_noe = "", sig_part_noe = "", proto_qtye = "", prod_sold_processe = "", appe = "", project_leadere = "", pcb_sige = "", class_prode = "";
                        String pcb_prod_namee = "", sig_prod_namee = "", pcb_cust_namee = "", sig_cust_namee = "";
                        xx = ss.executeQuery("select a.pcba_part_no,a.sig_part_no,b.pro_qty,b.project_leader,b.prod_sold_process,b.application,b.customer_req_date,b.apqp_meeting_date,b.pcb_sig,b.shipment_date,b.class_product from  apqp_aps as a join  apqp_eil as b on a.apqp_no=b.apqp_no where a.apqp_no='" + apqp_no + "'");
                        while (xx.next()) {
                            pcba_part_noe = xx.getString(1);
                            sig_part_noe = xx.getString(2);
                            proto_qtye = xx.getString(3);
                            project_leadere = xx.getString(4);
                            prod_sold_processe = xx.getString(5);
                            appe = xx.getString(6);
                            crde = xx.getDate(7);
                            meeting_datee = xx.getDate(8);
                            pcb_sige = xx.getString(9);
                            shipment_datee = xx.getDate(10);
                            class_prode = xx.getString(11);

                            xx1 = ss1.executeQuery("select prod_name,customer_name,part_revision from   product_master_pcb where part_no='" + xx.getString(1) + "'");
                            while (xx1.next()) {
                                pcb_prod_namee = xx1.getString(1);
                                pcb_cust_namee = xx1.getString(2);
                                pcb_reve = xx1.getString(3);
                            }

                            xx2 = ss2.executeQuery("select prod_name,customer_name,part_revision from   product_master_sig where part_no='" + xx.getString(2) + "'");
                            while (xx2.next()) {
                                sig_prod_namee = xx2.getString(1);
                                sig_cust_namee = xx2.getString(2);
                                sig_reve = xx2.getString(3);
                            }

                        }


                    %>

                    <a href="#" class="show_hide5" rel="#slidingDiv_21113">Manufacturability</a><br />

                    <div id="slidingDiv_21113">
                        <form action="edit_manufact" method="post">
                            <table>
                                <tr>
                                    <th colspan="2">PCBA Manufacturability Review</th>
                                    <th  colspan="2">APQP No </th>
                                    <th><font style="font-weight: normal"><%=apqp_no%></font></th>
                                <input type="hidden" name="apqp_no" id="apqp_no" value="<%=apqp_no%>">
                                </tr>
                                <%
                                    if (pcb_sige.equals("PCB")) {
                                %>
                                <tr>
                                    <th style="width: 14%;">Product Name </th>
                                    <th><font style="font-weight: normal"> <%=pcb_prod_namee%></font></th>
                                    <th colspan="2">Customer Name </th>
                                    <th><font style="font-weight: normal"><%=pcb_cust_namee%></font> </th>
                                </tr>

                                <tr>
                                    <th>PCBA part# </th>
                                    <th><font style="font-weight: normal"><%=pcba_part_noe%></th>
                                    <th colspan="2">Application </th>
                                    <th><font style="font-weight: normal"><%=appe%></font></th>

                                </tr>
                                <tr>
                                    <th >SIG Part# </th>
                                    <th><font style="font-weight: normal"><%=sig_part_noe%></font></th>
                                    <th colspan="2">Proto Qty </th>
                                    <th><font style="font-weight: normal"><%=proto_qtye%></font></th>

                                </tr>
                                <tr>
                                    <th>Product Revision </th>
                                    <th><font style="font-weight: normal"><%=pcb_reve%></font></th>
                                    <th colspan="2">CRD  </th>
                                    <th><font style="font-weight: normal"><%=crde%></font></th>

                                </tr>
                                <tr>
                                    <th>Soldering Process  </th>

                                    <th><font style="font-weight: normal"><%=prod_sold_processe%></font></th>
                                    <th colspan="2">Meeting Date </th>
                                    <th><font style="font-weight: normal"><%=meeting_datee%></font></th>

                                </tr>


                                <%
                                } else if (pcb_sige.equals("SIG")) {
                                %>
                                <tr>
                                    <th style="width: 14%;">Product Name </th>
                                    <th><font style="font-weight: normal"> <%=sig_prod_namee%></font></th>
                                    <th colspan="2">Customer Name </th>
                                    <th><font style="font-weight: normal"><%=sig_cust_namee%></font> </th>
                                </tr>

                                <tr>
                                    <th>PCBA part# </th>
                                    <th><font style="font-weight: normal"><%=pcba_part_noe%></th>
                                    <th colspan="2">Application </th>
                                    <th><font style="font-weight: normal"><%=appe%></font></th>

                                </tr>
                                <tr>
                                    <th>SIG Part# </th>
                                    <th><font style="font-weight: normal"><%=sig_part_noe%></font></th>
                                    <th colspan="2">Proto Qty </th>
                                    <th><font style="font-weight: normal"><%=proto_qtye%></font></th>

                                </tr>
                                <tr>
                                    <th>Product Revision </th>
                                    <th><font style="font-weight: normal"><%=sig_reve%></font></th>
                                    <th colspan="2">CRD </th>
                                    <th><font style="font-weight: normal"><%=crde%></font></th>

                                </tr>
                                <tr>
                                    <th>Soldering Process  </th>
                                    <th><font style="font-weight: normal"><%=prod_sold_processe%></font></th>
                                    <th colspan="2">Meeting Date </th>
                                    <th><font style="font-weight: normal"><%=meeting_datee%></font></th>

                                </tr>
                                <%
                                } else {
                                %>

                                <%
                                    if (!sig_prod_namee.equals("")) {

                                %>
                                <tr>
                                    <th style="width: 14%;">Product Name </th>

                                    <th><font style="font-weight: normal"> <%=sig_prod_namee%></font></th>
                                    <th colspan="2">Customer Name </th>
                                    <th><font style="font-weight: normal"><%=sig_cust_namee%></font> </th>
                                </tr>

                                <tr>
                                    <th>PCBA part# </th>
                                    <th><font style="font-weight: normal"><%=pcba_part_noe%></th>
                                    <th colspan="2">Application </th>
                                    <th><font style="font-weight: normal"><%=appe%></font></th>

                                </tr>
                                <tr>
                                    <th>SIG Part# </th>
                                    <th><font style="font-weight: normal"><%=sig_part_noe%></font></th>
                                    <th colspan="2">Proto Qty </th>
                                    <th><font style="font-weight: normal"><%=proto_qtye%></font></th>

                                </tr>
                                <tr>
                                    <th>Product Revision </th>
                                    <th><font style="font-weight: normal"><%=sig_reve%></font></th>
                                    <th colspan="2">CRD  </th>
                                    <th><font style="font-weight: normal"><%=crde%></font></th>

                                </tr>
                                <tr>
                                    <th>Soldering Process  </th>

                                    <th><font style="font-weight: normal"><%=prod_sold_processe%></font></th>
                                    <th colspan="2">Meeting Date </th>
                                    <th><font style="font-weight: normal"><%=meeting_datee%></font></th>

                                </tr>
                                <%
                                } else {
                                %>
                                <tr>
                                    <th style="width: 14%;">Product Name </th>
                                    <th><font style="font-weight: normal"> <%=pcb_prod_namee%></font></th>
                                    <th colspan="2">Customer Name </th>
                                    <th><font style="font-weight: normal"><%=pcb_cust_namee%></font> </th>
                                </tr>

                                <tr>
                                    <th>PCBA part# </th>
                                    <th><font style="font-weight: normal"><%=pcba_part_noe%></th>
                                    <th colspan="2">Application </th>
                                    <th><font style="font-weight: normal"><%=appe%></font></th>

                                </tr>
                                <tr>
                                    <th >SIG Part# </th>
                                    <th><font style="font-weight: normal"><%=sig_part_noe%></font></th>
                                    <th colspan="2">Proto Qty </th>
                                    <th><font style="font-weight: normal"><%=proto_qtye%></font></th>

                                </tr>
                                <tr>
                                    <th>Product Revision </th>
                                    <th><font style="font-weight: normal"><%=pcb_reve%></font></th>
                                    <th colspan="2">CRD  </th>
                                    <th><font style="font-weight: normal"><%=crde%></font></th>

                                </tr>
                                <tr>
                                    <th >Soldering Process  </th>

                                    <th><font style="font-weight: normal"><%=prod_sold_processe%></font></th>
                                    <th colspan="2">Meeting Date </th>
                                    <th><font style="font-weight: normal"><%=meeting_datee%></font></th>

                                </tr>

                                <%
                                        }
                                    }
                                %>
                                <%
                                    int man_count = 1;
                                    String rm = "", added_by = "", review_by = "", approve_by = "";
                                    ResultSet rsm = st.executeQuery("select sno,check_points,status,comments,note_action from  manufacture_review order by id ");
                                    while (rsm.next()) {
                                        rm = cls.checkManufacture(apqp_no, rsm.getString(1));

                                        if (rsm.getString(1).equals("1") || rsm.getString(1).equals("2") || rsm.getString(1).equals("3") || rsm.getString(1).equals("4") || rsm.getString(1).equals("5") || rsm.getString(1).equals("6") || rsm.getString(1).equals("7") || rsm.getString(1).equals("8") || rsm.getString(1).equals("9") || rsm.getString(1).equals("10") || rsm.getString(1).equals("11") || rsm.getString(1).equals("12") || rsm.getString(1).equals("13") || rsm.getString(1).equals("14") || rsm.getString(1).equals("15")) {
                                %>                                
                                <tr style="text-align: center;font-weight: bold;background-color: #2f5b43;color: white;">
                                    <th style="text-align: center;color: white;">S No</th>
                                    <th style="text-align: center;color: white;"><u><%=rsm.getString(2)%></u></th>
                                    <th style="text-align: center;color: white;"><u>YES/NO/NA</u></th>
                                    <th style="text-align: center;color: white;"><u>Comments</u></th>
                                    <th style="text-align: center;color: white;"><u>Notes/Action Items</u></th>
                                </tr>

                                <%
                                } else {
                                %>
                                <tr>
                                    <%
                                        if (rm.equals("Yes")) {
                                            //   out.print(res+", ");
                                            ResultSet resm = st_1.executeQuery("select sno,check_points,status,comments,note_action,added_by,reviewed_by,approved_by from  manufacture_history where sno='" + rsm.getString(1) + "' and apqp_no='" + apqp_no + "' ");
                                            while (resm.next()) {
                                                added_by = resm.getString(6);
                                                review_by = resm.getString(7);
                                                approve_by = resm.getString(8);
                                    %>
                                    <td style="text-align: center;">
                                        <%
//                                            String psno = resm.getString(1);
                                            out.print(resm.getString(1));
//                                            out.print(psno.substring(4, psno.length()));
%>
                                        <input type="hidden" name="sno<%=man_count%>" value="<%=resm.getString(1)%>"></td>
                                    <td><%=resm.getString(2)%><input type="hidden" name="check_point<%=man_count%>" value="<%=resm.getString(2)%>"></td>
                                    <td>
                                        <select name="stat<%=man_count%>" id="stat<%=man_count%>">
                                            <%
                                                if (resm.getString(3).equals("Yes")) {
                                            %>
                                            <option value="Yes">Yes</option>
                                            <option value="No">No</option>
                                            <option value="NA">NA</option>
                                            <%
                                            } else if (resm.getString(3).equals("NA")) {
                                            %>
                                            <option value="NA">NA</option>
                                            <option value="Yes">Yes</option>                                                    
                                            <option value="No">No</option>                                                    
                                            <%
                                            } else if (resm.getString(3).equals("No")) {
                                            %>
                                            <option value="No">No</option>                                                     
                                            <option value="Yes">Yes</option>                                                    
                                            <option value="NA">NA</option>
                                            <%
                                            } else {
                                            %>
                                            <option value="NA">NA</option>
                                            <option value="No">No</option>                                                     
                                            <option value="Yes">Yes</option>                                                                                                        
                                            <%
                                                }
                                            %>
                                        </select>
                                    </td>
                                    <td><%=resm.getString(4)%></td>
                                    <td colspan="2"><textarea name="note<%=man_count%>" id="note<%=man_count%>" ><%=resm.getString(5)%></textarea></td>
                                        <%
                                            }
                                        } else {

                                        %>
                                    <td style="text-align: center;">
                                        <%                                        out.print(rsm.getString(1));
                                        %>
                                        <input type="hidden" name="sno<%=man_count%>" value="<%=rsm.getString(1)%>"></td>
                                    <td><%=rsm.getString(2)%><input type="hidden" name="check_point<%=man_count%>" value="<%=rsm.getString(2)%>"></td>
                                    <td>
                                        <select name="stat<%=man_count%>" id="stat<%=man_count%>">                                                   
                                            <option value="NA">NA</option>
                                            <option value="No">No</option>
                                            <option value="Yes">Yes</option>                                                      
                                        </select>
                                    </td>
                                    <td><%=rsm.getString(4)%></td>
                                    <td colspan="2"><textarea name="note<%=man_count%>" id="note<%=man_count%>" ></textarea></td>
                                </tr>
                                <%
                                            }
                                            man_count++;
                                        }
                                        rm = "";
                                    }
                                %> 

                                <tr>
                                    <td colspan="5" align='center'>
                                        <input  type="hidden" id="man_count" name="man_count" value="<%=man_count%>">
                                        <font style="font-weight: bold">Prepared By :</font>
                                        <input type="text" name="prepared" id="prepared" value="<%=added_by%>"> 
                                        <font style="font-weight: bold">Reviewed By:</font>
                                        <input type="text" name="Reviewed" id="Reviewed" value="<%=review_by%>">  
                                        <font style="font-weight: bold">Approved By :</font>
                                        <input type="text" name="Approved" id="Approved" value="<%=approve_by%>">
                                    </td>
                                </tr>
                                <tr><td colspan="5">AP-EG-F17-13</td></tr>
                                <tr>
                                    <td colspan="5" style="text-align: center;"><input type="submit" name='submit' value="Save" class="but"></td>
                                </tr>
                            </table>
                        </form>

                    </div>

                    <%
                    } else if (p.equals("9")) {
                    %>
                    <h3>  Validation Details</h3>

                    <!--// new Added--> 

                    <table>
                        <tr>
                            <th style="text-align: center;">S.NO</th>
                            <th style="text-align: center;">Val No</th>
                            <th style="text-align: center;">APQP No</th>
                            <th style="text-align: center;">Part No</th>
                            <th style="text-align: center;">Type</th>
                            <th style="text-align: center;">Status</th>
                        </tr> 
                        <%
                            int ii = 1;
                            getPhase cls2 = new getPhase();
                            ResultSet sa = st.executeQuery("select distinct val_no,part_no,status from  master_validation where val_type='" + apqp_no + "' ");
                            while (sa.next()) {
                        %>
                        <tr>
                            <td style="text-align: center;"><%=ii%></td>
                            <td><a href="edit_validations.jsp?val_no=<%=sa.getString(1)%>&apqp_no=<%=apqp_no%>" style="font-weight: bold;color: #0f800f;text-decoration: none;"><%=sa.getString(1)%></a></td>

                            <td><%=apqp_no%></td>
                            <td><%=sa.getString(2)%></td>
                            <td>
                                <%
                                    out.print(cls2.getValidFor(sa.getString(1)));
                                %>
                            </td>
                            <td><%=sa.getString(3)%></td>
                        </tr>
                        <%
                                ii++;
                            }
                        %>
                    </table>    

                    <!--<form action="val_aff_part" method="post" onsubmit="return validation_check()">-->
                    <!--<form action="#" method="post" onsubmit="return validation_check()">-->
                    <form action="val_aff_part" method="post" onsubmit="return validation_check()">
                        <table>                              
                            <tr><th colspan="3">Add Validations Details </th></tr>
                            <tr>
                                <th>Validation Type</th>
                                <td colspan="2"><input type="text" value="<%=apqp_no%>" name="apqp_no" readonly size="13"/></td>
                            </tr>
                            <tr>
                                <th>part_no</th>
                                <td colspan="2"><input type="text" name="all" id="part_no" value="View All"  readonly size="13"/></td>
                            </tr>                              
                            <tr>
                                <th>S.no</th>
                                <th>Part Number</th>
                                <th>Validation For</th>
                            </tr>
                            <%
                                int i = 1;

                                ResultSet rsp1 = st1.executeQuery("select pcba_part_no,sig_part_no from  apqp_aps where  apqp_no='" + apqp_no + "' ");
                                while (rsp1.next()) {
                            %>
                            <tr>
                                <td style="text-align: center;"><input type="hidden" name="rowcount" value="<%=i%>"/><%=i%></td>
                                <td><input type="checkbox" name="part_no" class="cats<%=i%>" value="<%=rsp1.getString(1)%>" onclick="return false;" style="width:24px;"/><%=rsp1.getString(1)%></td>                                                                
                                <td>
                                    <div class="multiselect">
                                        <label><input type="checkbox" name="val_for<%=rsp1.getString(1)%>" class="select_part<%=i%>" value="Assembly" onclick="return scheck(<%=i%>)">Assembly</label><br>
                                        <label><input type="checkbox" name="val_for<%=rsp1.getString(1)%>" class="select_part<%=i%>" value="Testing" onclick="return scheck(<%=i%>)">Testing</label><br>
                                        <label> <input type="checkbox" name="val_for<%=rsp1.getString(1)%>" class="select_part<%=i%>" value="Packing" onclick="return scheck(<%=i%>)">Packing</label><br>
                                        <label><input type="checkbox" name="val_for<%=rsp1.getString(1)%>" class="select_part<%=i%>" value="Fixture" onclick="return scheck(<%=i%>)">Fixture</label><br>
                                        <label> <input type="checkbox" name="val_for<%=rsp1.getString(1)%>" class="select_part<%=i%>" value="Tooling" onclick="return scheck(<%=i%>)">Tooling</label><br>
                                        <label> <input type="checkbox" name="val_for<%=rsp1.getString(1)%>" class="select_part<%=i%>" value="Programming" onclick="return scheck(<%=i%>)">Programming</label>
                                    </div>
                                </td>
                            </tr>
                            <%
                                if (rsp1.getString(2).equals("")) {

                                } else {
                                    i++;
                            %>
                            <td style="text-align: center;"><input type="hidden" name="rowcount" value="<%=i%>"/><%=i%></td>
                            <td><input type="checkbox" name="part_no" class="cats<%=i%>" value="<%=rsp1.getString(2)%>" onclick="return false;" style="width:24px;"/><%=rsp1.getString(2)%></td>                                                                
                            <td>
                                <div class="multiselect">
                                    <label><input type="checkbox" name="val_for<%=rsp1.getString(2)%>" class="select_part<%=i%>" value="Assembly" onclick="return scheck(<%=i%>)">Assembly</label><br>
                                    <label><input type="checkbox" name="val_for<%=rsp1.getString(2)%>" class="select_part<%=i%>" value="Testing" onclick="return scheck(<%=i%>)">Testing</label><br>
                                    <label> <input type="checkbox" name="val_for<%=rsp1.getString(2)%>" class="select_part<%=i%>" value="Packing" onclick="return scheck(<%=i%>)">Packing</label><br>
                                    <label><input type="checkbox" name="val_for<%=rsp1.getString(2)%>" class="select_part<%=i%>" value="Fixture" onclick="return scheck(<%=i%>)">Fixture</label><br>
                                    <label> <input type="checkbox" name="val_for<%=rsp1.getString(2)%>" class="select_part<%=i%>" value="Tooling" onclick="return scheck(<%=i%>)">Tooling</label><br>
                                    <label> <input type="checkbox" name="val_for<%=rsp1.getString(2)%>" class="select_part<%=i%>" value="Programming" onclick="return scheck(<%=i%>)">Programming</label>
                                </div>
                            </td>
                            <%
                                    }

                                    i++;
                                }
                            %>      
                            <tr>
                                <td colspan="3" style="text-align: center;">
                                    <input type="hidden" id="rowCount" name="rowCount" value="<%=i%>">
                                    <input type="submit" value="Proceed" class="but"/>
                                </td>
                            </tr>
                        </table>

                    </form>

                    <!--<button  onclick="tablesToExcel(['tbl1', 'tbl2'], ['ProductDay1', 'ProductDay2'], 'TestBook.xls', 'Excel')" class="but">Export to Excel</button>-->

                    <%
                        }
                    %>
                </div>
            </div>

            <div id="scroll">
                <a title="Scroll to the top" class="top" href="#"><img src="images/top.png" alt="top" /></a>
            </div>
            <footer>
                <!-- <p><img src="images/twitter.png" alt="twitter" />&nbsp;<img src="images/facebook.png" alt="facebook" />&nbsp;<img src="images/rss.png" alt="rss" /></p>
                -->  <p><a href="#">Home</a> | <a href="#">New Product</a> | <a href="#">Change Orders</a> | <a href="#">Tracker</a> | <a href="#">Validation</a></p>
                <p>Copyright &copy; Avalon Technologies Pvt Ltd | <a href="#">Design By Balaji.K</a></p>
            </footer>
            <%
                    con.close();
                } catch (Exception e) {
                    out.print("<BR>Error : " + e);
                }
            %>
        </div>

        <!--<script src="js/checkbox.js" type="text/javascript"></script>-->
        <script>
            function scheck(n) {

                $(".cats" + n).each(function () {
                    this.checked = true;
                });
                var c = "", b = "";
                var checked = false;
                var unchecked = false;
                var checks = document.getElementsByClassName("select_part" + n);

                for (var i = 0; i < checks.length; i++) {
                    if (checks[i].checked)
                        checked = true;
                    else
                        unchecked = true;
                }
                if (checked == false) {

                    $(".cats" + n).each(function () {
                        this.checked = false;
                    });
                }
            }
        </script>
    </body>
</html>
