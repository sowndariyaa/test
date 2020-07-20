<%-- 
    Document   : apply_leave
    Created on : 14 Jul, 2020, 10:04:56 AM
    Author     : AV-IT-PC560
--%>

<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="HRMS.Database_Connection"%>
<%@page import="java.sql.Date"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html class="no-js" lang="en">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>LMS</title>
        <meta name="description" content="Sufee Admin - HTML5 Admin Template">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <link rel="apple-touch-icon" href="apple-icon.png">
        <link rel="shortcut icon" href="favicon.ico">

        <link rel="stylesheet" href="../vendors/bootstrap/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="../vendors/font-awesome/css/font-awesome.min.css">
        <link rel="stylesheet" href="../vendors/themify-icons/css/themify-icons.css">
        <link rel="stylesheet" href="../vendors/flag-icon-css/css/flag-icon.min.css">
        <link rel="stylesheet" href="../vendors/selectFX/css/cs-skin-elastic.css">
        <link rel="stylesheet" href="../assets/css/style.css">
        <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,600,700,800' rel='stylesheet' type='text/css'>
    </head>
    <!--    <style>
              input {
      box-sizing: border-box;
      border-radius: 2px;
      border: 1px solid #999;
      cursor: pointer;
      outline: none;
      box-shadow: 3px 3px 0px #ddd;
    }
    
        </style>-->

    <body>
        <%

            try {
                String control = (String) session.getAttribute("control");
                String user = (String) session.getAttribute("user");
                String access = (String) session.getAttribute("access");

                session.setAttribute("control", control);
                session.setAttribute("user", user);
                session.setAttribute("access", access);

                Database_Connection obj = new Database_Connection();
                Connection con = obj.getConnection();
                Statement st = con.createStatement();

//            out.print(user);
                String name = "";
                String desig = "";
                String mobile_number = "";
                String blood_group = "";
                String department = "";
                String devision = "";
                String address = "";
                String emp_no = "";
                String Reporting_To = "";
                String branch = "";
                Date date_of_join = null;

                ResultSet rs = st.executeQuery("select emp_name,parent_name,mobile_number,email,blood_group,dob,designation,"
                        + "department,division,branch,doj,dol,status,door_no,street_name,landmark,village_town,taluk,city,"
                        + "district,state,pin_code,dol_remark,Reporting_To from employee_master where emp_no='" + user + "' ");
                while (rs.next()) {
                    name = rs.getString(1);
                    desig = rs.getString(7);
                    date_of_join = rs.getDate(11);
                    mobile_number = rs.getString(3);
                    blood_group = rs.getString(5);
                    department = rs.getString(8);
                    devision = rs.getString(9);
                    address = rs.getString(14) + "," + rs.getString(15) + "," + rs.getString(16) + ",	&nbsp;	&nbsp;	&nbsp;	&nbsp;	&nbsp;	&nbsp;	&nbsp;	&nbsp;	&nbsp;	&nbsp;	&nbsp;	&nbsp;	&nbsp;	&nbsp;	&nbsp;"
                            + "	&nbsp;	&nbsp;	&nbsp;	&nbsp;	&nbsp;	&nbsp;	&nbsp;	&nbsp;	&nbsp;	&nbsp;	&nbsp;	&nbsp;" + rs.getString(19) + "," + rs.getString(21) + "-" + rs.getString(22);
                    emp_no = user;
                    Reporting_To = rs.getString(24);
                    branch = rs.getString(10);
                }

                String leave_type = "";
                String leave_days = "";
                String year = "";
                String avaliable_leave = "";
                String taken_leave = "";
                ResultSet rt = st.executeQuery("select emp_no,leave_type,leave_days,year,avaliable_leave,taken_leave,remark,status,added_by,added_date from leave_master where emp_no='" + user + "' ");
                while (rt.next()) {
                    leave_type = rt.getString(2);
                    leave_days = rt.getString(3);
                    year = rt.getString(4);
                    avaliable_leave = rt.getString(5);
                    taken_leave = rt.getString(6);
                }
                String cl = "";
                String available = "";
                ResultSet ru = st.executeQuery("select emp_no,leave_type,leave_days,year,avaliable_leave,taken_leave,remark,status,added_by,added_date from leave_master where emp_no='" + user + "' and leave_type='CL' ");
                while (ru.next()) {
                    cl = ru.getString(3);
                    available = ru.getString(5);

                }

                String sl = "";
                String availablesl = "";
                ResultSet rv = st.executeQuery("select emp_no,leave_type,leave_days,year,avaliable_leave,taken_leave,remark,status,added_by,added_date from leave_master where emp_no='" + user + "' and leave_type='SL' ");
                while (rv.next()) {
                    sl = rv.getString(3);
                    availablesl = rv.getString(5);

                }
                String El = "";
                String availableel = "";
                ResultSet rw = st.executeQuery("select emp_no,leave_type,leave_days,year,avaliable_leave,taken_leave,remark,status,added_by,added_date from leave_master where emp_no='" + user + "' and leave_type='EL' ");
                while (rw.next()) {
                    El = rw.getString(3);
                    availableel = rw.getString(5);

                }


        %>
        <div><jsp:include page="../menu.jsp" />
            <div id="right-panel" class="right-panel">
                <header id="header" class="header">
                    <div class="header-menu">
                        <div class="col-sm-7">
                            <a id="menuToggle" class="menutoggle pull-left"><i class="fa fa fa-tasks"></i></a>
                            <div class="header-left" style="text-align: center">
                                <h2>Leave Management System</h2>
                            </div>
                        </div>
                        <div class="col-sm-5">
                            <div class="user-area dropdown float-right">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <img class="user-avatar rounded-circle" src="../images/download.png" alt="User Avatar">
                                </a>
                                <div class="user-menu dropdown-menu">
                                    <a class="nav-link" href="profile.jsp"><i class="fa fa-user"></i> My Profile</a>
                                    <a class="nav-link" href="#"><i class="fa fa-user"></i> Notifications <span class="count">13</span></a>
                                    <a class="nav-link" href="../index.jsp"><i class="fa fa-power-off"></i> Logout</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </header><!-- /header -->
                <div class="breadcrumbs">
                    <div class="col-sm-4">
                        <div class="page-header float-left">
                            <div class="page-title">
                                <h1>Leave Request</h1>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="content mt-3">
                    <div class="animated fadeIn">
                        <div class="row"  >
                            <div class="col-lg-6"  >
                                <div class="card" >
                                    <div class="card-body" >
                                        <!-- Credit Card -->
                                        <div id="pay-invoice" >
                                            <div class="card-body" >
                                                <div class="card-title">
                                                    <h3 class="text-center" >Apply Leave</h3>
                                                </div>
                                                <hr>
                                                <form action="" method="post" novalidate="novalidate">
                                                    <div class="row">
                                                        <div class="col-6">
                                                            <div class="form-group">
                                                                <label for="cc-exp" class="control-label mb-1">Name</label>
                                                                <input id="cc-exp" name="name" type="text" class="form-control cc-exp" value="<%=name%>" readonly=""  >
                                                            </div>
                                                        </div>
                                                        <div class="col-6">
                                                            <label for="x_card_code" class="control-label mb-1">Employee Number</label>
                                                            <div class="input-group">
                                                                <input id="x_card_code" name="emp_no" type="text" class="form-control cc-exp"  value="<%=emp_no%>"  readonly="" >

                                                            </div>
                                                        </div>
                                                        <div class="col-6">
                                                            <label for="x_card_code" class="control-label mb-1">Department</label>
                                                            <div class="input-group">
                                                                <input id="x_card_code" name="department" type="text" class="form-control cc-exp"  value="<%=department%>" readonly=""  >

                                                            </div>
                                                        </div>
                                                        <div class="col-6">
                                                            <label for="x_card_code" class="control-label mb-1">Reporting To</label>
                                                            <div class="input-group">
                                                                <input id="x_card_code" name="report" type="text" class="form-control cc-exp"  value="<%=Reporting_To%>" readonly=""  >

                                                            </div>
                                                        </div>
                                                        <div class="col-6">
                                                            <label for="x_card_code" class="control-label mb-1">Division</label>
                                                            <div class="input-group">
                                                                <input id="x_card_code" name="division" type="text" class="form-control cc-exp"  value="<%=devision%>" readonly=""  >

                                                            </div>
                                                        </div>
                                                        <div class="col-6">
                                                            <label for="x_card_code" class="control-label mb-1">Branch</label>
                                                            <div class="input-group">
                                                                <input id="x_card_code" name="branch" type="text" class="form-control cc-exp"  value="<%=branch%>" readonly=""  >

                                                            </div>
                                                        </div>
                                                        <script src="date_cal/ajax.js"></script>
                                                        <script>
                                                            $(function () {
                                                                var dtToday = new Date();
                                                                var month = dtToday.getMonth() + 1;
//                                                                var day = '01';
                                                                var year = dtToday.getFullYear();
                                                                if (month < 10)
                                                                    month = '0' + month.toString();
//                                                                if (day < 10)
//                                                                    day = '0' + day.toString();

                                                                var minDate = year + '-' + month + '-' + '01';
                                                                $('#txtDate').attr('min', minDate);
                                                            });
                                                        </script>
                                                        <div class="col-6">
                                                            <label for="x_card_code" class="control-label mb-1">From Date</label>
                                                            <div class="input-group">
                                                                <input id="txtDate" name="txtDate" type="date" class="form-control cc-exp"  onchange="changeFunc()" />

                                                                <!--<input type="date" id="txtDate" />-->
                                                            </div>
                                                        </div>

                                                        <div class="col-6">
                                                            <label for="x_card_code" class="control-label mb-1"></label>
                                                            <div class="input-group">
                                                                <input type="radio" id="chkPassport1" name="leave" value="fullday" onclick="ShowHideDiv(this)" onchange="changeFunc()"  style="margin-left: 10%;margin-top: 4%" />  <p>Fullday</p>  
                                                                <input type="radio" id="chkPassport" name="leave" value="halfday" onclick="ShowHideDiv(this)" style="margin-left: 20%;margin-top: 4%" />  <p>Half</p>  
                                                            </div>

                                                            <script type="text/javascript">
                                                                function ShowHideDiv(chkPassport) {
                                                                    var dvPassport = document.getElementById("dvPassport");
//                                                                    alert(dvPassport);
                                                                    dvPassport.style.display = chkPassport.checked ? "block" : "none";
                                                                }
                                                                function ShowHideDiv(chkPassport1) {
//                                                                    var dvPassport = document.getElementById("dvPassport");
                                                                    dvPassport.style.display = chkPassport.checked ? "block" : "none";
                                                                }



                                                            </script>
                                                            <div id="dvPassport" style="display: none">
                                                                <div class="input-group">
                                                                    <select name="leave" id="txtPassportNumber" class="form-control-sm form-control" onchange="changeFunc();"  >
                                                                        <option value="0">Please select</option>
                                                                        <option value="1st_half" id="half" >1st Half</option>
                                                                        <option value="2nd_half">2nd Half</option>
                                                                    </select>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-6">
                                                            <label for="x_card_code" class="control-label mb-1">To Date</label>
                                                            <div class="input-group">
                                                                <input id="datepicker" name="to_date" type="date" class="form-control cc-exp" onchange="changeFunc()"  value="" >

                                                            </div>

                                                        </div>

                                                        <div class="col-6">
                                                            <label for="x_card_code" class="control-label mb-1"></label>
                                                            <div class="input-group">
                                                                <input type="radio" id="chk1" name="leave"  value="tofullday" onclick="ShowHideDivs(this)" onchange="changeFunc()"   style="margin-left: 10%;margin-top: 4%" />  <p>Fullday</p>  
                                                                <input type="radio" id="chk2" name="leave"  value="tohalf_day" onclick="ShowHideDivs(this)" onchange="changeFunc()" style="margin-left: 20%;margin-top: 4%" />  <p>Half</p>  
                                                            </div>


                                                            <script type="text/javascript">
                                                                function ShowHideDivs(chk2) {
                                                                    var dvcheck = document.getElementById("dvcheck");
                                                                    dvcheck.style.display = chk2.checked ? "block" : "none";
                                                                }
                                                                function ShowHideDivs(chk1) {
                                                                    dvcheck.style.display = chk2.checked ? "block" : "none";
                                                                }
                                                                function changeFunc() {
                                                                    var order;
                                                                    if (document.getElementById('chkPassport1').checked == true) {
                                                                        order = "fullday";
                                                                    } else if (document.getElementById('chkPassport').checked == true) {
                                                                        order = "halfday";
                                                                    }
                                                                    var tooder;
                                                                    if (document.getElementById('chk2').checked == true) {
                                                                        tooder = "tohalf_day";
                                                                    } else {
                                                                        tooder = "tofullday";
                                                                    }
                                                                    if (tooder == "tohalf_day") {
                                                                        var selectBox = document.getElementById("txtPassportNumber");
                                                                        var selectedValue = selectBox.options[selectBox.selectedIndex].value;
                                                                        var selectBoxes = document.getElementById("txtPassportNumber2");
                                                                        var selectedValues = selectBoxes.options[selectBoxes.selectedIndex].value;
                                                                        alert(selectedValues);
                                                                        if (selectedValues == "tohalf") {
                                                                            var dropdt = new Date(document.getElementById("datepicker").value);
                                                                            var pickdt = new Date(document.getElementById("txtDate").value);
                                                                            document.getElementById("datepicker").disabled = false;
                                                                            var dropdt = new Date(document.getElementById("datepicker").value);
                                                                            var pickdt = new Date(document.getElementById("txtDate").value);
                                                                            var dat = parseFloat((dropdt - pickdt) / (24 * 3600 * 1000) + 0.5);
                                                                            document.getElementById("numdays2").value = dat;
                                                                        } else if (tooder == "tofullday") {
                                                                            var dropdt = new Date(document.getElementById("datepicker").value);
                                                                            var pickdt = new Date(document.getElementById("txtDate").value);
                                                                            document.getElementById("datepicker").disabled = false;
//                                                                              document.getElementById('outputBox').innerHTML = order;
//                                                                            document.getElementById('datepicker').value = '';
                                                                            var dropdt = new Date(document.getElementById("datepicker").value);
                                                                            var pickdt = new Date(document.getElementById("txtDate").value);
                                                                            var dat = parseFloat((dropdt - pickdt) / (24 * 3600 * 1000) + 1);
                                                                            document.getElementById("numdays2").value = dat;
                                                                        }
                                                                    }
                                                                    if (order == "halfday") {
                                                                        var selectBox = document.getElementById("txtPassportNumber");
                                                                        var selectedValue = selectBox.options[selectBox.selectedIndex].value;
//                                                                        alert(selectedValue);
                                                                        if (selectedValue == '1st_half') {
                                                                            var dropdt = new Date(document.getElementById("datepicker").value);
                                                                            var pickdt = new Date(document.getElementById("txtDate").value);
                                                                            document.getElementById('datepicker').value = document.getElementById('txtDate').value;
                                                                            document.getElementById("datepicker").disabled = true;
                                                                            document.getElementById("chk1").disabled = true;
                                                                            document.getElementById("chk2").disabled = true;
                                                                            var dat = parseFloat(0.5);
//                                                                            if ((dat == NaN) || (dat === " ")) {
//                                                                                var dat = "";
//                                                                            }
                                                                            alert(dat);
                                                                            document.getElementById("numdays2").value = dat;
                                                                        } else if (selectedValue == '2nd_half') {
                                                                            document.getElementById("datepicker").disabled = false;
                                                                            document.getElementById("chk1").disabled = false;
                                                                            document.getElementById("chk2").disabled = false;
//                                                                              document.getElementById('outputBox').innerHTML = order;
//                                                                            document.getElementById('datepicker').value = '';
                                                                            var dropdt = new Date(document.getElementById("datepicker").value);
                                                                            var pickdt = new Date(document.getElementById("txtDate").value);
                                                                            var dat = parseFloat((dropdt - pickdt) / (24 * 3600 * 1000) + 0.5);
                                                                            document.getElementById("numdays2").value = dat;

                                                                            if ((dat == NaN) || (dat === " ")) {
                                                                                var dat = "";
                                                                            }
//                                                                            document.getElementById('datepicker').value = '';
                                                                        } else {
//                                                                            document.getElementById("numdays2").value = '';
////                                                                            document.getElementById('datepicker').value = '';
//                                                                            document.getElementById("datepicker").disabled = false;
//                                                                            document.getElementById("chk1").disabled = false;
//                                                                            document.getElementById("chk2").disabled = false;
                                                                        }
                                                                    } else {
                                                                        if (order == 'fullday') {
                                                                            document.getElementById("chk1").disabled = false;
                                                                            document.getElementById("chk2").disabled = false;
                                                                            document.getElementById("datepicker").disabled = false;
                                                                            var dropdt = new Date(document.getElementById("datepicker").value);
                                                                            var pickdt = new Date(document.getElementById("txtDate").value);
                                                                            var dats = parseFloat((dropdt - pickdt) / (24 * 3600 * 1000) + 1);
                                                                            document.getElementById("numdays2").value = dats;
                                                                        }
                                                                    }
                                                                }



                                                            </script>



                                                            <div id="dvcheck" style="display: none">
                                                                <div class="input-group">
                                                                    <select name="leave" id="txtPassportNumber2" class="form-control-sm form-control" onchange="changeFunc();"  >
                                                                        <option value="0">Please select</option>
                                                                        <option value="1st_half" id="tohalf">1st Half</option>
                                                                        <!--<option value="2nd_half">2nd Half</option>-->
                                                                    </select>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label for="cc-payment" class="control-label mb-1">Reason</label>
                                                        <input id="cc-pament" name="reason" type="text" class="form-control" value=" ">
                                                    </div>


                                                    <div class="row">
                                                        <div class="col-6">
                                                            <div class="form-group">
                                                                <label for="cc-exp" class="control-label mb-1">Applied Leave</label>
                                                                <input id="numdays2" name="numdays" type="tel" class="form-control cc-exp" value="" >
                                                            </div>
                                                        </div>
                                                        <div class="col-6">
                                                            <label for="x_card_code" class="control-label mb-1">Actual Available Leave</label>
                                                            <div class="input-group">
                                                                <input id="x_card_code" name="available" type="tel" class="form-control cc-cvc" value="" data-val="true" data-val-required="Please enter the security code" data-val-cc-cvc="Please entera valid security code" autocomplete="off">

                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div>
                                                        <button id="payment-button" type="submit" class="btn btn-lg btn-info btn-block">
                                                            <i class="fa fa-send fa-lg"></i>&nbsp;
                                                            <span id="payment-button-amount">Apply</span>
                                                        </button>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>

                                    </div>
                                </div> <!-- .card -->

                            </div>
                            <!--/.col-->
                            <div class="col-lg-3 col-md-6" style="margin-left: 10%">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="stat-widget-one">
                                            <div class="stat-icon dib"><i class="ti-hand-point-right text-danger border-danger"></i></div>
                                            <div class="stat-content dib">
                                                <div class="stat-text">CL</div>
                                                <div class="stat-digit"><%=available%></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="card">
                                    <div class="card-body">
                                        <div class="stat-widget-one">
                                            <div class="stat-icon dib"><i class="ti-hand-point-right text-danger border-danger"></i></div>
                                            <div class="stat-content dib">
                                                <div class="stat-text">SL</div>
                                                <div class="stat-digit"><%=availablesl%></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="card">
                                    <div class="card-body">
                                        <div class="stat-widget-one">
                                            <div class="stat-icon dib"><i class="ti-hand-point-right text-success border-success"></i></div>
                                            <div class="stat-content dib">
                                                <div class="stat-text">EL</div>
                                                <div class="stat-digit"><%=availableel%></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>






                        </div>
                    </div>
                </div>
            </div><!-- .animated -->
        </div><!-- .content -->
    </div><!-- /#right-panel -->
    <!-- Right Panel -->
</div>

<script src="../vendors/jquery/dist/jquery.min.js"></script>
<script src="../vendors/popper.js/dist/umd/popper.min.js"></script>

<script src="../vendors/jquery-validation/dist/jquery.validate.min.js"></script>
<script src="../vendors/jquery-validation-unobtrusive/dist/jquery.validate.unobtrusive.min.js"></script>

<script src="../vendors/bootstrap/dist/js/bootstrap.min.js"></script>
<script src="../assets/js/main.js"></script>


<script type="text/javascript">
//                                                                function GetDays() {
//
//
//
//                                                                    var x = 0;
//                                                                    var dropdt = new Date(document.getElementById("datepicker").value);
//                                                                    var pickdt = new Date(document.getElementById("txtDate").value);
//                                                                    var today = new Date();
//                                                                    var selectBox1 = document.getElementById("txtPassportNumber");
//                                                                  
//                                                                    alert(selectBox1);
//
//                                                                    
//
//
//                                                                    return parseFloat((dropdt - pickdt) / (24 * 3600 * 1000) + 1);
//
//                                                                }
//                                                                
//                                                                
//                                                                
//
//
//
//                                                                function cal() {
//
//                                                                    if (document.getElementById("txtDate")) {
//                                                                        document.getElementById("numdays2").value = GetDays();
//                                                                    }
//                                                                }


</script>

<%
    } catch (Exception e) {
        out.print(e);
    }

%>
</body>
</html>
