<%-- 
    Document   : Calibrate
    Created on : Jan 21, 2013, 11:26:55 AM
    Author     : Developed By Balaji.K (SAP ABAP) Emp No:5997
--%>

<%@page import="java.sql.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head><LINK REL="SHORTCUT ICON" HREF="images/favicon.ico" /> 
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <title>Avalon Technologies Pvt Ltd</title>
        <link rel="stylesheet" type="text/css" href="css/style.css" />

    </head>

    <body>
        <!--<form action="Calibrate" method="post" name="form" onsubmit="return checkdate(fdate), checkdate1(tdate)" >-->
          <form ENCTYPE="multipart/form-data" ACTION="Calibrate" METHOD=POST name="form" onsubmit="return checkdate(fdate), checkdate1(tdate)">
      
            <div id="container">
                <div id="holder" class="clearfix">
                    <div id="logo">
                        <h1>Avalon Technologies Pvt Ltd</h1>
                    </div>
                    <center><h3> <Strong>Calibration Tracking System</Strong></h3></center> 
                    <div id="navigation">
                        <ul> <li><a href="Calibrate.jsp">Add Instrument</a></li> &nbsp;|&nbsp;<li><a href="Resultfull.jsp">Master Report</a></li>&nbsp;|&nbsp;<li><a href="Datewisecalib.jsp">Date Wise Reports</a></li>&nbsp;|&nbsp;<li><a href="Report.jsp"> Instrument Report </a></li>&nbsp;|&nbsp;
                            <li> <a href="RepTab.jsp"> Calibration Alert </a></li>&nbsp;|&nbsp;<li><a href="Selectval.jsp">Edit_Instrument </a></li>&nbsp;|&nbsp;<li> <a href="history_report.jsp"> History Report </a></li>&nbsp;|&nbsp;<li> <a href="fix_type.jsp"> Fixture type</a></li>
                        </ul>		
                    </div>

                    <% String username = session.getAttribute("username").toString();%>
                    <%session.setAttribute("username", username);%>



                    <div id="header"></div>
                    <div id="content">
                        <div class="entry">
                            <center>  <h3>  <u><p>Register New Instrument</p></u></h3></center>
                            <table width="459" border="0" height="146">
                                <tr>
                                    <td width="128">Plant</td>
                                    <td width="230"><Select name="Plant">
                                            <option value="B7">B7</option>
                                            <option value="B8">B8</option>

                                        </Select></td>
                                </tr>
                                <tr>
                                    <td width="128">Instrument_Category</td>
                                    <td width="230"><input type="text" name="Ins_cat" /></td>
                                </tr>
                                <tr>
                                    <td width="128">Name_of_Instrument </td>
                                    <td width="230"><input type="text" name="Name_of_ins" /></td>
                                </tr>
                                <tr>
                                    <td width="128">Identification_No</td>
                                    <td width="230"><input type="text" name="Iden_no" id="Iden_no" onmouseout="validate()" /></td>
                                </tr>
                                <input type="hidden" name="Cus_name"/>
                                <tr>
                                    <input type="hidden" name="Cus_id_no" /></td>
                                </tr>
                                <tr>
                                    <td width="128">Make</td>
                                    <td width="230"><input type="text" name="Make" /></td>
                                </tr>
                                <tr>
                                    <td width="128">Model_Number</td>
                                    <td width="230"><input type="text" name="Mod_no" /></td>
                                </tr>
                                <tr>
                                    <td width="128">Serial_Number</td>
                                    <td width="230"><input type="text" name="S_no" /></td>
                                </tr>
                                <tr>
                                    <td width="128">Range_in_DEGC</td>
                                    <td width="230"><input type="text" name="Range_in_degc" /></td>
                                </tr>
                                <tr>
                                    <td width="128">Least_Count</td>
                                    <td width="230"><input type="text" name="Least_Count" value="±" /></td>
                                </tr>
                                <tr>
                                    <td width="128">Accuracy</td>
                                    <td width="230"><input type="text" name="Accuracy" value="±" /></td>
                                </tr>

                                <tr>
                                    <td width="128">Date_of_Calibration</td>
                                    <td width="230"><input type="date" name="Docalib" id="fdate" />(DD-MM-YYYY)</td>
                                </tr>

                                <tr>
                                    <td>Calibration_frequency</td>
                                    <td>
                                        <!--<select name="period" id="period" onchange="testingpro()">-->
                                        <select name="Calib_frq" id="period" onchange="Empty()" >
                                            <option value=""></option>
                                            <option value="Days">Days</option>
                                            <option value="monthly">Monthly</option>
                                            <option value="3 month">3 Month</option>
                                            <option value="4 month">4 Month</option>
                                            <option value="6 month">6 month</option>
                                            <option value="9 month">9 month</option>
                                            <option value="1 year">1 year</option>
                                            <option value="2 year">2 year</option>
                                            <option value="3 year">3 year</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr id="temp1"   ></tr>


                                <tr>
                                    <td width="128">Due_date_of_Calibration</td>
                                    <td width="230"><input type="text" name="Due_docalib" id="todate" />(DD-MM-YYYY)</td>
                                </tr>
                                <tr>
                                    <td width="128">Calibrated_month</td>
                                    <td width="230"><select name="Calib_month">
                                            <option value="Jan">Jan</option>
                                            <option value="Feb">Feb</option>
                                            <option value="Mar">Mar</option>
                                            <option value="Apr">Apr</option>
                                            <option value="May">May</option>
                                            <option value="June">June</option>
                                            <option value="July">July</option>
                                            <option value="Aug">Aug</option>
                                            <option value="Sep">Sep</option>
                                            <option value="Oct">Oct</option>
                                            <option value="Nov">Nov</option>
                                            <option value="Dec">Dec</option>

                                        </select></td>
                                </tr>
                                <tr>
                                    <td width="128">Calibration_Due_Month </td>
                                    <td width="230"><Select name="Calib_due_mon">
                                            <option value="Jan">Jan</option>
                                            <option value="Feb">Feb</option>
                                            <option value="Mar">Mar</option>
                                            <option value="Apr">Apr</option>
                                            <option value="May">May</option>
                                            <option value="June">June</option>
                                            <option value="July">July</option>
                                            <option value="Aug">Aug</option>
                                            <option value="Sep">Sep</option>
                                            <option value="Oct">Oct</option>
                                            <option value="Nov">Nov</option>
                                            <option value="Dec">Dec</option>
                                        </Select></td>
                                </tr>
                                <tr>
                                    <td width="128">Lead_Time_Days</td>
                                    <td width="230"><input type="text" name="Lead_Time_Days" onKeyPress="return checkIt(event)" /></td>
                                </tr>
                                <tr>
                                    <td width="128">Calibration_Days_Alert</td>
                                    <td width="230"><input type="text" name="Calib_days_alert"  /></td>
                                </tr>
                                <tr>
                                    <td width="128">Calibration_Agency</td>
                                    <td width="230"><select name="calib_agency">
                                            <option value="INTERNAL">INTERNAL</option>
                                            <option value="EXTERNAL">EXTERNAL</option>
                                        </select></td>
                                </tr><tr>
                                    <td width="128">Current_Certificate_No</td>
                                    <td width="230"><input type="text" name="Curr_cer_no" /></td>
                                </tr>
                                <tr>
                                    <td width="128">Location</td>
                                    <td width="230"><input type="text"  name="Location"/></td>
                                </tr>  
                                <tr>
                                    <td width="128">History_Card_Ref_No </td>
                                    <td width="230"><input type="text" name="His_card_ref_no" onKeyPress="return checkIt(event)" /></td>
                                </tr>

                                <tr>
                                    <td width="128">STATUS</td>
                                    <td width="230"><select name="Status">
                                            <option value=""></option>
                                            <option value="AA-CM-F24-00">AA-CM-F24-00</option>
                                            <option value="Under Maintenance">Under Service</option>
                                            <option value="Under Calibration">Under Calibration</option> 
                                            <option value="Waiting For Certificate">Waiting For Certificate</option>
                                            <option value="Calibration Completed">Calibration Completed</option>
                                            <option value="Scrap">Scrap</option>
                                            <option value="Others">Others</option>
                                        </select></td>
                                </tr>
                                <tr> <td>Insert Certificate</td><td><input type="file" name="file" /></td></tr>  


                                <tr>
                                    <td></td>
                                    <td><label>
                                            <input type="reset" name="clear" value="Reset" />&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" name="Submit" value="Save"  />
                                        </label></td>
                                </tr>

                            </table>
                            Please Upload Files From This location: <a href="file://10.44.1.150/temp_data/Calibration Daily Update/">\\10.44.1.150\Temp_data\Cable Calibration Daily Update</a>
                            <p>&nbsp;</p>
                        </div>

                    </div>





                    <%

                    %>
                </div>
                <div id="footer">
                    <a href="javascript:if(confirm('Close window?'))window.close()">Sign out</a>
                    <li><a href="notinuse.jsp">Under Service</a></li>	
                    <span id="copyright">Design by Avalon Technologies Pvt Ltd</span>

                </div>
            </div>

            <SCRIPT LANGUAGE="JavaScript">
                function checkIt(evt) {
                    evt = (evt) ? evt : window.event
                    var charCode = (evt.which) ? evt.which : evt.keyCode
                    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                        alert('this field accepts number only');
                        return false
                    }
                    status = ""
                    return true
                }
                function validate() {
                    var dt = document.forms[0].Iden_no
                    if (document.forms[0].Iden_no.value == "") {
                        alert("'Identification number' field cannot be empty.");

                        dt.focus()
                        return false;
                    } else
                        return true
                }

                function checkdate(fdate)
                {
                    var validformat = /^\d{4}\-\d{2}\-\d{2}$/
                    var dt = document.form.fdate

                    if (!validformat.test(fdate.value))
                    {
                        alert("Invalid From Date ");
                        document.form.fdate.value = "";
                        dt.focus()
                        return false
                    } else
                        return true
                }
                function checkdate1(tdate)
                {
                    var validformat = /^\d{4}\-\d{2}\-\d{2}$/
                    var dat = document.form.tdate

                    if (!validformat.test(tdate.value))
                    {
                        alert("Invalid To Date!");
                        document.form.tdate.value = "";
                        dat.focus()
                        return false
                    } else
                        return true

                }


            </script>
            <script type="text/javascript">


                function Empty() {

                    var fdate = document.getElementById("fdate").value;
                    if (fdate == null || fdate == "") {
                        alert("Enter From Date ! ");
                        document.getElementById("fdate").focus();
                        document.getElementById("period").value = "";
                        return false;
                    }
                    var xx = document.getElementById("period").value;
                    var ss1 = "";
                    if (xx == "Days") {
                        ss1 = '<td>Days</td><td><input type="number" name="period1"  onkeyup="DaysCount(this.value)"></td>';
                        document.getElementById("temp1").innerHTML = ss1;
                        document.getElementById("todate").value = "";
                    } else {
                        document.getElementById("temp1").innerHTML = "";
                        var p = document.getElementById("period").value;
                        var d = new Date(fdate);
                        console.log(d.toLocaleDateString());
                        if (p == "monthly") {
                            d.setMonth(d.getMonth() + 1);
                            console.log(d.toLocaleDateString());
                            var c = new Date(d);
                            c.setDate(c.getDate() - 1);
                            var dd = c.getDate();
                            dd = dd < 10 ? '0' + dd : dd;
                            var mm = c.getMonth() + 1;
                            mm = mm < 10 ? '0' + mm : mm;
                            var yy = c.getFullYear();

                            var someFormattedDate = yy + '-' + mm + '-' + dd;
//                            var someFormattedDate = dd + '-' + mm + '-' + yy;

                            document.getElementById('todate').value = someFormattedDate;
                        } else if (p == "3 month") {
                            d.setMonth(d.getMonth() + 3);
                            console.log(d.toLocaleDateString());
                            var c = new Date(d);
                            c.setDate(c.getDate() - 1);
                            var dd = c.getDate();
                            dd = dd < 10 ? '0' + dd : dd;
                            var mm = c.getMonth() + 1;
                            mm = mm < 10 ? '0' + mm : mm;
                            var yy = c.getFullYear();

                            var someFormattedDate = yy + '-' + mm + '-' + dd;
//                            var someFormattedDate = dd + '-' + mm + '-' + yy;

                            document.getElementById('todate').value = someFormattedDate;
                        } else if (p == "4 month") {
                            d.setMonth(d.getMonth() + 4);
                            console.log(d.toLocaleDateString());
                            var c = new Date(d);
                            c.setDate(c.getDate() - 1);
                            var dd = c.getDate();
                            dd = dd < 10 ? '0' + dd : dd;
                            var mm = c.getMonth() + 1;
                            mm = mm < 10 ? '0' + mm : mm;
                            var yy = c.getFullYear();

                            var someFormattedDate = yy + '-' + mm + '-' + dd;
//                            var someFormattedDate = dd + '-' + mm + '-' + yy;

                            document.getElementById('todate').value = someFormattedDate;
                        } else if (p == "6 month") {
                            d.setMonth(d.getMonth() + 6);
                            console.log(d.toLocaleDateString());
                            var c = new Date(d);
                            c.setDate(c.getDate() - 1);
                            var dd = c.getDate();
                            dd = dd < 10 ? '0' + dd : dd;
                            var mm = c.getMonth() + 1;
                            mm = mm < 10 ? '0' + mm : mm;
                            var yy = c.getFullYear();

                            var someFormattedDate = yy + '-' + mm + '-' + dd;
//                            var someFormattedDate = dd + '-' + mm + '-' + yy;

                            document.getElementById('todate').value = someFormattedDate;
                        } else if (p == "9 month") {
                            d.setMonth(d.getMonth() + 9);
                            console.log(d.toLocaleDateString());
                            var c = new Date(d);
                            c.setDate(c.getDate() - 1);
                            var dd = c.getDate();
                            dd = dd < 10 ? '0' + dd : dd;
                            var mm = c.getMonth() + 1;
                            mm = mm < 10 ? '0' + mm : mm;
                            var yy = c.getFullYear();

                            var someFormattedDate = yy + '-' + mm + '-' + dd;
//                            var someFormattedDate = dd + '-' + mm + '-' + yy;

                            document.getElementById('todate').value = someFormattedDate;
                        } else if (p == "1 year") {
                            d.setMonth(d.getMonth() + 12);
                            console.log(d.toLocaleDateString());
                            var c = new Date(d);
                            c.setDate(c.getDate() - 1);
                            var dd = c.getDate();
                            dd = dd < 10 ? '0' + dd : dd;
                            var mm = c.getMonth() + 1;
                            mm = mm < 10 ? '0' + mm : mm;
                            var yy = c.getFullYear();

                            var someFormattedDate = yy + '-' + mm + '-' + dd;
//                            var someFormattedDate = dd + '-' + mm + '-' + yy;

                            document.getElementById('todate').value = someFormattedDate;
                        } else if (p == "2 year") {
                            d.setMonth(d.getMonth() + 24);
                            console.log(d.toLocaleDateString());
                            var c = new Date(d);
                            c.setDate(c.getDate() - 1);
                            var dd = c.getDate();
                            dd = dd < 10 ? '0' + dd : dd;
                            var mm = c.getMonth() + 1;
                            mm = mm < 10 ? '0' + mm : mm;
                            var yy = c.getFullYear();

                            var someFormattedDate = yy + '-' + mm + '-' + dd;
//                            var someFormattedDate = dd + '-' + mm + '-' + yy;

                            document.getElementById('todate').value = someFormattedDate;
                        } else if (p == "3 year") {
                            d.setMonth(d.getMonth() + 36);
                            console.log(d.toLocaleDateString());
                            var c = new Date(d);
                            c.setDate(c.getDate() - 1);
                            var dd = c.getDate();
                            dd = dd < 10 ? '0' + dd : dd;
                            var mm = c.getMonth() + 1;
                            mm = mm < 10 ? '0' + mm : mm;
                            var yy = c.getFullYear();

                            var someFormattedDate = yy + '-' + mm + '-' + dd;
//                            var someFormattedDate = dd + '-' + mm + '-' + yy;

                            document.getElementById('todate').value = someFormattedDate;
                        } else if (p == "" || p == null) {

                            document.getElementById("todate").value = "";
                        }
                    }
                }

                function DaysCount(val) {
                    var fdate = document.getElementById("fdate").value;
                    if (fdate == null || fdate == "") {
                        alert("Enter From Date ! ");
                        document.getElementById("fdate").focus();
                        document.getElementById("period").value = "";
                        return false;
                    }
                    if (val == "" || val == null) {
                        document.getElementById('todate').value = "";
                    } else {
                        var x = document.getElementById("fdate").value;
                        var y = parseInt(val);
                        var date = new Date(x);
                        var newdate = new Date(date);
                        newdate.setDate(newdate.getDate() + y);
                        var dd = newdate.getDate();
                        dd = dd < 10 ? '0' + dd : dd;
                        var mm = newdate.getMonth() + 1;
                        mm = mm < 10 ? '0' + mm : mm;
                        var y = newdate.getFullYear();
                        var someFormattedDate = y + '-' + mm + '-' + dd;
//                        var someFormattedDate = dd + '-' + mm + '-' + y;

                        document.getElementById('todate').value = someFormattedDate;
                    }
                }

            </script>                         



        </form>
    </body>
</html>