<%--
    Document   : apply_leave
    Created on : 14 Jul, 2020, 10:04:56 AM
    Author     : AV-IT-PC560
--%>


<%@page import="java.sql.DriverManager"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="HRMS.Database_Connection"%>
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

        <script src="/HRMS/Bootstrap files/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script src="/HRMS/Bootstrap files/3.4.1/js/bootstrap.min.js"></script>
        <script src="../Bootstrap files/timer/jquery.min.js"></script>
        <script src="../Bootstrap files/timer/moment.min.js"></script>
        <script src="../Bootstrap files/timer/bootstrap-datetimepicker.min.js"></script>
        <link rel="stylesheet" href="../Bootstrap files/timer/bootstrap-datetimepicker.min.css" />



        <style>
            input {
                box-sizing: border-box;
                border-radius: 2px;
                border: 1px solid #999;
                cursor: pointer;
                outline: none;
                box-shadow: 3px 3px 0px #ddd;
            }

            h3 {
                font-family: 'Open Sans', sans-serif;
            }


        </style>
        <script type="text/javascript">
            window.onload = function () {
                //Reference the DropDownList.
                var ddlYears = document.getElementById("ddlYears");

                //Determine the Current Year.
                var currentYear = (new Date()).getFullYear();

                //Loop and add the Year values to DropDownList.
                for (var i = 2019; i <= currentYear; i++) {
                    var option = document.createElement("OPTION");
                    option.innerHTML = i;
                    option.value = i;
                    ddlYears.appendChild(option);
                }
            };
        </script>

        <script>
            $(document).ready(function () {

                let totel_data = [], data, totel = 0;
                var available_permission;
                $("#from_date").change(function () {
                    $("#input_from_time").val("");
                    $("#input_to_time").val("");
                    var emp_no, apply_date;
                    emp_no = $("#emp_no").val();
                    apply_date = $("#from_date").val();
                    var mydate = new Date(apply_date);
                    var apply_month_no = mydate.getMonth();
                    apply_month_no = apply_month_no + 1;
//                    alert(apply_month_no);

                    $.ajax({
                        type: "POST",
                        url: "get_permission.jsp",
                        data: {emp_no: emp_no, month: apply_month_no, check: "1"},
                        success: function (data) {
//                            alert(data);
                            totel_data = data.split("&");
                            available_permission = parseFloat(totel_data[0]);
//                            alert(available_permission);
//                            alert(typeof (available_permission));

                            if (available_permission >= 2) {
                                alert("Sorry...You dont have permission for this month");
                                $("#available_permission").val("");
                                $("#from_date").val("");
                            } else {
                                var new_leave = 2;
                                $("#available_permission").val(new_leave - available_permission);
                            }
                        }

                    });
//
                });
            });



            function span_from_time() {
                var from_time = "";
                var start_time = "", end_time = "";
                start_time = $("#input_from_time").val();
                end_time = $("#input_to_time").val();
                from_time = $("#from_date").val();

                if ((from_time == "") || (from_time == null)) {
                    $("#input_from_time").val("");
                    $("#input_to_time").val("");
                    $("#from_date").val("");
                    alert("Please choose Date first..");
                }

                if ((start_time != "") && (end_time != "")) {

                    start_time = $("#input_from_time").val();
                    end_time = $("#input_to_time").val();

                    var len_start_time = start_time.length;
                    var len_to_time = end_time.length;
                    var str_from_dt = "";
                    var str_to_dt = "";

                    if (len_start_time < 8) {
                        str_from_dt = from_time + " " + "0" + start_time.substr(0, 4) + ":00 " + start_time.substr(start_time.length - 2);
                    } else {
                        str_from_dt = from_time + " " + start_time.substr(0, 5) + ":00 " + start_time.substr(start_time.length - 2);
                    }
                    var date_from = new Date(str_from_dt);


                    if (len_start_time < 8) {
                        str_to_dt = from_time + " " + "0" + end_time.substr(0, 4) + ":00 " + end_time.substr(end_time.length - 2);
                    } else {
                        str_to_dt = from_time + " " + end_time.substr(0, 5) + ":00 " + end_time.substr(end_time.length - 2);
                    }
                    var date_to = new Date(str_to_dt);



                    var diff = (date_to.getTime() - date_from.getTime()) / 1000;
                    diff /= 60;
                    if (diff < 0) {
                        diff = 0;
                    }

                    var fin_diff = Math.abs(Math.round(diff));
//                alert(fin_diff);

                    if ((fin_diff % 60 == 0) && (fin_diff != 0)) {
                        var ava_permiss = $("#available_permission").val();
                        var min_ava_per = ava_permiss * 60;
//                        alert("min_ava_per" + min_ava_per);
//                        alert("fin_diff" + fin_diff);
                        if (min_ava_per >= fin_diff) {
//                        alert(fin_diff);
                            $("#apply_permission").val(fin_diff / 60);
                        } else {
                            alert("Your selected permission duration is excess...")
                        }

                    } else {
                        alert("Please select the valid date range...");
                        $("#input_from_time").val("");
                        $("#input_to_time").val("");
                    }
                }
            }



            function  span_to_time() {
                var from_time = "";
                var start_time = "", end_time = "";
                start_time = $("#input_from_time").val();
                end_time = $("#input_to_time").val();
                from_time = $("#from_date").val();

                if ((from_time == "") || (from_time == null)) {
                    $("#input_from_time").val("");
                    $("#input_to_time").val("");
                    $("#from_date").val("");
                    alert("Please choose Date first..");
                }

                if ((start_time != "") && (end_time != "")) {

                    start_time = $("#input_from_time").val();
                    end_time = $("#input_to_time").val();

                    var len_start_time = start_time.length;
                    var len_to_time = end_time.length;
                    var str_from_dt = "";
                    var str_to_dt = "";

                    if (len_start_time < 8) {
                        str_from_dt = from_time + " " + "0" + start_time.substr(0, 4) + ":00 " + start_time.substr(start_time.length - 2);
                    } else {
                        str_from_dt = from_time + " " + start_time.substr(0, 5) + ":00 " + start_time.substr(start_time.length - 2);
                    }
                    var date_from = new Date(str_from_dt);


                    if (len_start_time < 8) {
                        str_to_dt = from_time + " " + "0" + end_time.substr(0, 4) + ":00 " + end_time.substr(end_time.length - 2);
                    } else {
                        str_to_dt = from_time + " " + end_time.substr(0, 5) + ":00 " + end_time.substr(end_time.length - 2);
                    }
                    var date_to = new Date(str_to_dt);



                    var diff = (date_to.getTime() - date_from.getTime()) / 1000;
                    diff /= 60;
                    if (diff < 0) {
                        diff = 0;
                    }

                    var fin_diff = Math.abs(Math.round(diff));
//                alert(fin_diff);

                    if ((fin_diff % 60 == 0) && (fin_diff != 0)) {
                        var ava_permiss = $("#available_permission").val();
                        var min_ava_per = ava_permiss * 60;
//                        alert("min_ava_per" + min_ava_per);
//                        alert("fin_diff" + fin_diff);
                        if (min_ava_per >= fin_diff) {
//                        alert(fin_diff);
                            $("#apply_permission").val(fin_diff / 60);
                        } else {
                            alert("Your selected permission duration is excess...")
                        }

                    } else {
                        alert("Please select the valid date range...");
                        $("#input_from_time").val("");
                        $("#input_to_time").val("");
                    }
                }
            }
        </script>



        <script>
            function  dpt_sel() {
                let totel_data = [], data, totel = 0;
                var dpt_name = "";
                var options = "";
                dpt_name = $("#dpts_id").val();
//                alert(dpt_name);
                $.ajax({
                    type: "POST",
                    url: "get_empno_department_wise.jsp",
                    data: {dpt_name: dpt_name, access: "manager"},
                    success: function (data) {
//                        alert(data);
                        totel_data = data.split("&");
//                        alert(totel_data[]);
                        options += "<option></option>";
                        for (let i = 1; i < totel_data.length; i++) {
//                            alert(totel_data[i]);
                            options += "<option value='" + totel_data[i] + "'>" + totel_data[i] + "</option>";
                        }
                        $("#emp_nos").html(options);
                    }
                });


            }
        </script>

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

                String connectionURL = "jdbc:sqlserver://10.44.50.15;databaseName=hrpay";
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                con = DriverManager.getConnection(connectionURL, "balaji_sap", "sap123");
                Statement sta = con.createStatement();

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
                                    <img class="user-avatar rounded-circle"  <img src="/HRMS/user/getimg.jsp?emp_no=<%=user%>" alt="User Avatar">
                                </a>
                                <p class="text-right" style="margin-left: 20%"><%=name%></p>
                                <div class="user-menu dropdown-menu">
                                    <a class="nav-link" href="profile.jsp"   <i class="fa fa-user"></i> My Profile</a>
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
                                <h1>View Attendance</h1>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="content mt-3">
                    <div class="animated fadeIn">
                        <div class="row"  >
                            <div class="col-lg-6">
                                <div class="card" >
                                    <div class="card-body" >
                                        <!-- Credit Card -->
                                        <div id="pay-invoice" >
                                            <div class="card-body" >
                                                <div class="card-title">
                                                    <h4 class="text-center" >Attendance</h4>
                                                </div>
                                                <hr>
                                                <form action="/HRMS/user/calender_view.jsp" method="post">
                                                    <input type="hidden" name="pa" value="1">
                                                    <input type="hidden" name="emp_no" value="<%=user%>">
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
                                                                <input id="emp_no" name="emp_no" type="text" class="form-control cc-exp"  value="<%=emp_no%>"  readonly="" >
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="row">
                                                        <div class="col-6">
                                                            <div class="form-group">
                                                                <label for="cc-exp" class="control-label mb-1">Select Year</label>
                                                                <select id="ddlYears" class="form-control" name="years"></select>
                                                            </div>
                                                        </div>
                                                        <div class="col-6">
                                                            <label for="x_card_code" class="control-label mb-1">Select Month</label>
                                                            <div class="input-group">
                                                                <select name="months" id="months" class="form-control" >
                                                                    <option selected value='1'>Janaury</option>
                                                                    <option value='2'>February</option>
                                                                    <option value='3'>March</option>
                                                                    <option value='4'>April</option>
                                                                    <option value='5'>May</option>
                                                                    <option value='6'>June</option>
                                                                    <option value='7'>July</option>
                                                                    <option value='8'>August</option>
                                                                    <option value='9'>September</option>
                                                                    <option value='10'>October</option>
                                                                    <option value='11'>November</option>
                                                                    <option value='12'>December</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <%

                                                        String access_boss = "";
                                                        ResultSet rsb = st.executeQuery("select access,boss_emp_no,emp_no from report_str where emp_no='" + user + "'  ");
                                                        while (rsb.next()) {
                                                            access_boss = rsb.getString(1);
                                                        }
//                                                        out.print(access_boss);
                                                        if ((access_boss.equals("manager"))) {
                                                    %>

                                                    <div class="row">
                                                        <div class="col-6">
                                                            <div class="form-group">
                                                                <label for="cc-exp" class="control-label mb-1">Select Department</label>
                                                                <select name="months" id="dpts_id" class="form-control" onchange="dpt_sel();" required="" >
                                                                    <option ></option>
                                                                    <%                                                                        ResultSet rsa = st.executeQuery("select hod_emp_no,department from department_head where hod_emp_no='" + user + "' order by id desc  ");
                                                                        while (rsa.next()) {
                                                                    %>
                                                                    <option  value="<%=rsa.getString(2)%>"><%=rsa.getString(2)%></option>
                                                                    <%
                                                                        }
                                                                    %>
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="col-6">
                                                            <label for="x_card_code" class="control-label mb-1">Select Emp No</label>
                                                            <div class="input-group">
                                                                <select name="emp_nos" id="emp_nos" class="form-control" required="" >

                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <%
                                                        }
                                                    %>


                                                    <br>
                                                    <div>
                                                        <button id="payment-button" type="submit" class="btn btn-lg btn-info btn-block">
                                                            <i class="fa fa-eye"></i>&nbsp;
                                                            <span id="payment-button-amount">View</span>
                                                        </button>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>

                                    </div>
                                </div> <!-- .card -->

                            </div>

                        </div>
                    </div>
                </div>
            </div><!-- .animated -->
        </div><!-- .content -->


        <script src="../vendors/jquery/dist/jquery.min.js"></script>
        <script src="../vendors/popper.js/dist/umd/popper.min.js"></script>

        <script src="../vendors/jquery-validation/dist/jquery.validate.min.js"></script>
        <script src="../vendors/jquery-validation-unobtrusive/dist/jquery.validate.unobtrusive.min.js"></script>

        <script src="../vendors/bootstrap/dist/js/bootstrap.min.js"></script>
        <script src="../assets/js/main.js"></script>
        <!--<script src="date_cal/ajax.js"></script>-->
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
                                                                        $('#from_date').attr('min', minDate);
                                                                    });
        </script>



        <%    } catch (Exception ex) {
                out.print(ex.toString());
            }
        %>
    </body>
</html>
