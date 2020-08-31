<%--
Document   : apply_leave
Created on : 14 Jul, 2020, 10:04:56 AM
Author     : AV-IT-PC560
--%>


<%@page import="java.util.Calendar"%>
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

            h6{
                font-size: 12px;

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

    <body >
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
//            Calendar calendar = Calendar.getInstance();
//            int lastDate = calendar.getActualMaximum(Calendar.DATE);
//            out.println("Last Day : " + lastDate);
//            out.print(lastDate=lastDate-1);

                String month_number = "";
                String years = "";
                String emp_no = "";
                String emp_name = "";
                
                if(access.equals("manager")){
                
                emp_no = request.getParameter("emp_nos");
                 user = emp_no;
                }
//                out.print(emp_no);

                month_number = request.getParameter("months");
                years = request.getParameter("years");

//                out.print(month_number);
//                out.print(years);
//                int i = 4;
                String req_date = years + "-" + month_number + "-01";
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Date date = sdf.parse(req_date);
                Calendar cal = Calendar.getInstance();
                cal.setTime(date);
//            out.print(cal.getActualMaximum(Calendar.DATE));

                int last_day = cal.getActualMaximum(Calendar.DATE);
//            out.print(last_day);
                int temp = 0;

                String i, j = "";
                i = request.getParameter("months");
                j = request.getParameter("years");

                String name = "";
                ResultSet rs = st.executeQuery("select emp_name,parent_name,mobile_number,email,blood_group,dob,designation,"
                        + "department,division,branch,doj,dol,status,door_no,street_name,landmark,village_town,taluk,city,"
                        + "district,state,pin_code,dol_remark from employee_master where emp_no='" + user + "'");
                while (rs.next()) {
                    name = rs.getString(1);
                }
                ResultSet rs1 = st.executeQuery("select emp_name,parent_name,mobile_number,email,blood_group,dob,designation,"
                        + "department,division,branch,doj,dol,status,door_no,street_name,landmark,village_town,taluk,city,"
                        + "district,state,pin_code,dol_remark from employee_master where emp_no='" + emp_no + "'");
                while (rs1.next()) {
                    emp_name = rs1.getString(1);
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
                    <div class="col-sm-12">
                        <div class="page-header float-left">
                            <div class="page-title">
                                <h1>View Attendance  &emsp;&emsp;&emsp;&emsp; <span class="badge badge-primary"><%=emp_name%></span></h1>
                            </div>
                        </div>
                    </div>
                </div>


                <div class="container-fluid" style="line-height: 3.9;font-family: serif">
                    <header>

                        <div class="row d-none d-sm-flex p-1 bg-dark text-white">
                        </div>
                    </header>


                    <div class="row border border-right-0 border-bottom-0">
                        <div class="day col-sm p-2 border border-left-0 border-top-0 text-truncate d-none d-sm-inline-block bg-light text-muted">
                            <h5 class="row align-items-center">
                                <span class="date col-1"></span>
                                <span class="col-1"></span>
                            </h5>
                            <p class="d-sm-none">No events</p>
                        </div>
                        <div class="day col-sm p-2 border border-left-0 border-top-0 text-truncate d-none d-sm-inline-block bg-light text-muted">
                            <h5 class="row align-items-center">
                                <span class="date col-1"></span>
                                <span class="col-1"></span>
                            </h5>
                            <p class="d-sm-none">No events</p>
                        </div>
                        <div class="day col-sm p-2 border border-left-0 border-top-0 text-truncate d-none d-sm-inline-block bg-light text-muted">
                            <h5 class="row align-items-center">
                                <span class="date col-1"></span>
                                <span class="col-1"></span>
                            </h5>
                            <p class="d-sm-none">No events</p>
                        </div>
                        <div class="day col-sm p-2 border border-left-0 border-top-0 text-truncate ">
                            <h5 class="row align-items-center">
                                <span class="date col-1"><%temp = last_day - last_day + 1;
                                    out.print(temp);

                                    SimpleDateFormat sdf2 = new SimpleDateFormat("EE");
                                    String D1 = "" + temp + "-" + i + "-" + j;
                                    Date d1 = new SimpleDateFormat("yyyy-MM-dd").parse(D1);
                                    String strD1 = sdf2.format(d1);
                                    
                                    
                                    
                                   
//out.print(D1);
                                    %></span>
                                    <%
//                                        out.print(D1);
                                        int dt1 = 0;
                                        ResultSet rs_get_att_det_1 = st.executeQuery("select emp_no,in_time,out_time,shift,status,attendance_date from att_master where emp_no='" + user + "' and attendance_date='" + D1 + "'");
                                        while (rs_get_att_det_1.next()) {
                                            out.print(rs_get_att_det_1.getString(6));
                                            dt1++;
                                        }
                                        if (dt1 == 0) {
                                    %>
                                <h5><span class="badge badge-success"></span></h5>
                                <h5><span class="badge badge-danger"></span></h5>
                                    <%} else {

                                        }%>



                            </h5>
                            <p class="d-sm-none"></p>
                            <span class="col-1"><%out.print(strD1);%></span>
                        </div>
                        <div class="day col-sm p-2 border border-left-0 border-top-0 text-truncate ">
                            <h5 class="row align-items-center">
                                <span class="date col-1"><%temp = last_day - last_day + 2;
                                    out.print(temp);

                                    String D2 = j + "-" + i + "-" + temp;
                                    Date d2 = new SimpleDateFormat("yyyy-MM-dd").parse(D2);
                                    String strD2 = sdf2.format(d2);

                                    %></span>
                                <span class="col-1"></span>
                            </h5>
                            <span class="col-1"><%out.print(strD2);%></span>
                        </div>
                        <div class="day col-sm p-2 border border-left-0 border-top-0 text-truncate ">
                            <h5 class="row align-items-center">
                                <span class="date col-1"><%temp = last_day - last_day + 3;
                                    out.print(temp);

                                    String D3 = j + "-" + i + "-" + temp;
                                    Date d3 = new SimpleDateFormat("yyyy-MM-dd").parse(D3);
                                    String strD3 = sdf2.format(d3);
                                    %></span>
                                <span class="col-1"></span>
                            </h5>
                            <span class="col-1"><%out.print(strD3);%></span>
                        </div>
                        <div class="day col-sm p-2 border border-left-0 border-top-0 text-truncate ">
                            <h5 class="row align-items-center">
                                <span class="date col-1"><%temp = last_day - last_day + 4;
                                    out.print(temp);

                                    String D4 = j + "-" + i + "-" + temp;
                                    Date d4 = new SimpleDateFormat("yyyy-MM-dd").parse(D4);
                                    String strD4 = sdf2.format(d4);
                                    %></span>
                                <span class="col-1"></span>
                            </h5>
                            <span class="date col-1"><%out.print(strD4);%></span>
                            <%
                                ResultSet rs_get_att_det_4 = st.executeQuery("select emp_no,in_time,out_time,shift,status,attendance_date from att_master where emp_no='" + user + "' and attendance_date='" + D4 + "'");
                                while (rs_get_att_det_4.next()) {
                                    if (rs_get_att_det_4.getString(5).equals("Present")) {
                            %>
                            <h5><span class="badge badge-success">PRESENT</span></h5>
                            <h6><span class="col-1">Intime  &nbsp;&nbsp;&nbsp;:<%=rs_get_att_det_4.getString(2)%></span>
                            </h6>
                            <h6><span class="col-1">Outtime :<%=rs_get_att_det_4.getString(3)%></span>
                            </h6>
                            <%
                            } else {
                            %>
                            <h5><span class="badge badge-danger">NOT PRESENT</span></h5>
                            <%
                                    }
                                }
                            %>

                        </div>
                        <div class="w-100"></div>
                        <div class="day col-sm p-2 border border-left-0 border-top-0 text-truncate ">
                            <h5 class="row align-items-center">
                                <span class="date col-1"><%temp = last_day - last_day + 5;
                                    out.print(temp);

                                    String D5 = j + "-" + i + "-" + temp;
                                    Date d5 = new SimpleDateFormat("yyyy-MM-dd").parse(D5);
                                    String strD5 = sdf2.format(d5);
                                    %></span>
                                <span class="col-1"></span>
                            </h5>
                            <span class="col-1"><%out.print(strD5);%></span>
                            <%
                                ResultSet rs_get_att_det_5 = st.executeQuery("select emp_no,in_time,out_time,shift,status,attendance_date from att_master where emp_no='" + user + "' and attendance_date='" + D5 + "'");
                                while (rs_get_att_det_5.next()) {
                                    if (rs_get_att_det_5.getString(5).equals("Present")) {
                            %>
                            <h5><span class="badge badge-success">PRESENT</span></h5>
                            <h6><span class="col-1">Intime  :<%=rs_get_att_det_5.getString(2)%></span>
                            </h6>
                            <h6><span class="col-1">Outtime :<%=rs_get_att_det_5.getString(3)%></span>
                            </h6>
                            <%
                            } else {
                            %>
                            <h5><span class="badge badge-danger">NOT PRESENT</span></h5>
                            <%
                                    }
                                }
                            %>
                        </div>
                        <div class="day col-sm p-2 border border-left-0 border-top-0 text-truncate ">
                            <h5 class="row align-items-center">
                                <span class="date col-1"><%temp = last_day - last_day + 6;
                                    out.print(temp);

                                    String D6 = j + "-" + i + "-" + temp;
                                    Date d6 = new SimpleDateFormat("yyyy-MM-dd").parse(D6);
                                    String strD6 = sdf2.format(d6);
                                    %></span>
                                <span class="col-1"></span>
                            </h5>
                            <span class="col-1"><%out.print(strD6);%></span>
                            <%
                                ResultSet rs_get_att_det_6 = st.executeQuery("select emp_no,in_time,out_time,shift,status,attendance_date from att_master where emp_no='" + user + "' and attendance_date='" + D6 + "'");
                                while (rs_get_att_det_6.next()) {
                                    if (rs_get_att_det_6.getString(5).equals("Present")) {
                            %>
                            <h5><span class="badge badge-success">PRESENT</span></h5>
                            <h6><span class="col-1">Intime  :<%=rs_get_att_det_6.getString(2)%></span>
                            </h6>
                            <h6><span class="col-1">Outtime :<%=rs_get_att_det_6.getString(3)%></span>
                            </h6>
                            <%
                            } else {
                            %>
                            <h5><span class="badge badge-danger">NOT PRESENT</span></h5>
                            <%
                                    }
                                }
                            %>
                        </div>
                        <div class="day col-sm p-2 border border-left-0 border-top-0 text-truncate ">
                            <h5 class="row align-items-center">
                                <span class="date col-1"><%temp = last_day - last_day + 7;
                                    out.print(temp);

                                    String D7 = j + "-" + i + "-" + temp;
                                    Date d7 = new SimpleDateFormat("yyyy-MM-dd").parse(D7);
                                    String strD7 = sdf2.format(d7);
                                    %></span>
                                <span class="col-1"></span>
                            </h5>
                            <span class="col-1"><%out.print(strD7);%></span>
                            <%
                                ResultSet rs_get_att_det_7 = st.executeQuery("select emp_no,in_time,out_time,shift,status,attendance_date from att_master where emp_no='" + user + "' and attendance_date='" + D7 + "'");
                                while (rs_get_att_det_7.next()) {
                                    if (rs_get_att_det_7.getString(5).equals("Present")) {
                            %>
                            <h5><span class="badge badge-success">PRESENT</span></h5>
                            <h6><span class="col-1">Intime  :<%=rs_get_att_det_7.getString(2)%></span>
                            </h6>
                            <h6><span class="col-1">Outtime :<%=rs_get_att_det_7.getString(3)%></span>
                            </h6>
                            <%
                            } else {
                            %>
                            <h5><span class="badge badge-danger">NOT PRESENT</span></h5>
                            <%
                                    }
                                }
                            %>
                        </div>
                        <div class="day col-sm p-2 border border-left-0 border-top-0 text-truncate ">
                            <h5 class="row align-items-center">
                                <span class="date col-1"><%temp = last_day - last_day + 8;
                                    out.print(temp);

                                    String D8 = j + "-" + i + "-" + temp;
                                    Date d8 = new SimpleDateFormat("yyyy-MM-dd").parse(D8);
                                    String strD8 = sdf2.format(d8);
                                    %></span>
                                <span class="col-1"></span>
                            </h5>
                            <span class="col-1"><%out.print(strD8);%></span>
                            <%
                                ResultSet rs_get_att_det_8 = st.executeQuery("select emp_no,in_time,out_time,shift,status,attendance_date from att_master where emp_no='" + user + "' and attendance_date='" + D8 + "'");
                                while (rs_get_att_det_8.next()) {
                                    if (rs_get_att_det_8.getString(5).equals("Present")) {
                            %>
                            <h5><span class="badge badge-success">PRESENT</span></h5>
                            <h6><span class="col-1">Intime  :<%=rs_get_att_det_8.getString(2)%></span>
                            </h6>
                            <h6><span class="col-1">Outtime :<%=rs_get_att_det_8.getString(3)%></span>
                            </h6>
                            <%
                            } else {
                            %>
                            <h5><span class="badge badge-danger">NOT PRESENT</span></h5>
                            <%
                                    }
                                }
                            %>
                        </div>
                        <div class="day col-sm p-2 border border-left-0 border-top-0 text-truncate ">
                            <h5 class="row align-items-center">
                                <span class="date col-1"><%temp = last_day - last_day + 9;
                                    out.print(temp);

                                    String D9 = j + "-" + i + "-" + temp;
                                    Date d9 = new SimpleDateFormat("yyyy-MM-dd").parse(D9);
                                    String strD9 = sdf2.format(d9);
                                    %></span>
                                <span class="col-1"></span>
                            </h5>
                            <span class="col-1"><%out.print(strD9);%></span>
                            <%
                                ResultSet rs_get_att_det_9 = st.executeQuery("select emp_no,in_time,out_time,shift,status,attendance_date from att_master where emp_no='" + user + "' and attendance_date='" + D9 + "'");
                                while (rs_get_att_det_9.next()) {
                                    if (rs_get_att_det_9.getString(5).equals("Present")) {
                            %>
                            <h5><span class="badge badge-success">PRESENT</span></h5>
                            <h6><span class="col-1">Intime  :<%=rs_get_att_det_9.getString(2)%></span>
                            </h6>
                            <h6><span class="col-1">Outtime :<%=rs_get_att_det_9.getString(3)%></span>
                            </h6>
                            <%
                            } else {
                            %>
                            <h5><span class="badge badge-danger">NOT PRESENT</span></h5>
                            <%
                                    }
                                }
                            %>
                        </div>
                        <div class="day col-sm p-2 border border-left-0 border-top-0 text-truncate ">
                            <h5 class="row align-items-center">
                                <span class="date col-1"><%temp = last_day - last_day + 10;
                                    out.print(temp);

                                    String D10 = j + "-" + i + "-" + temp;
                                    Date d10 = new SimpleDateFormat("yyyy-MM-dd").parse(D10);
                                    String strD10 = sdf2.format(d10);
                                    %></span>
                                <span class="col-1"></span>
                            </h5>
                            <span class="col-1"><%out.print(strD10);%></span>
                            <%
                                ResultSet rs_get_att_det_10 = st.executeQuery("select emp_no,in_time,out_time,shift,status,attendance_date from att_master where emp_no='" + user + "' and attendance_date='" + D10 + "'");
                                while (rs_get_att_det_10.next()) {
                                    if (rs_get_att_det_10.getString(5).equals("Present")) {
                            %>
                            <h5><span class="badge badge-success">PRESENT</span></h5>
                            <h6><span class="col-1">Intime  :<%=rs_get_att_det_10.getString(2)%></span>
                            </h6>
                            <h6><span class="col-1">Outtime :<%=rs_get_att_det_10.getString(3)%></span>
                            </h6>
                            <%
                            } else {
                            %>
                            <h5><span class="badge badge-danger">NOT PRESENT</span></h5>
                            <%
                                    }
                                }
                            %>
                        </div>
                        <div class="day col-sm p-2 border border-left-0 border-top-0 text-truncate ">
                            <h5 class="row align-items-center">
                                <span class="date col-1"><%temp = last_day - last_day + 11;
                                    out.print(temp);

                                    String D11 = j + "-" + i + "-" + temp;
                                    Date d11 = new SimpleDateFormat("yyyy-MM-dd").parse(D11);
                                    String strD11 = sdf2.format(d11);
                                    %></span>
                                <span class="col-1"></span>
                            </h5>
                            <span class="col-1"><%out.print(strD11);%></span>
                            <%
                                ResultSet rs_get_att_det_11 = st.executeQuery("select emp_no,in_time,out_time,shift,status,attendance_date from att_master where emp_no='" + user + "' and attendance_date='" + D11 + "'");
                                while (rs_get_att_det_11.next()) {
                                    if (rs_get_att_det_11.getString(5).equals("Present")) {
                            %>
                            <h5><span class="badge badge-success">PRESENT</span></h5>
                            <h6><span class="col-1">Intime  :<%=rs_get_att_det_11.getString(2)%></span>
                            </h6>
                            <h6><span class="col-1">Outtime :<%=rs_get_att_det_11.getString(3)%></span>
                            </h6>
                            <%
                            } else {
                            %>
                            <h5><span class="badge badge-danger">NOT PRESENT</span></h5>
                            <%
                                    }
                                }
                            %>
                        </div>
                        <div class="w-100"></div>
                        <div class="day col-sm p-2 border border-left-0 border-top-0 text-truncate ">
                            <h5 class="row align-items-center">
                                <span class="date col-1"><%temp = last_day - last_day + 12;
                                    out.print(temp);

                                    String D12 = j + "-" + i + "-" + temp;
                                    Date d12 = new SimpleDateFormat("yyyy-MM-dd").parse(D12);
                                    String strD12 = sdf2.format(d12);
                                    %></span>
                                <span class="col-1"></span>
                            </h5>
                            <span class="col-1"><%out.print(strD12);%></span>
                            <%
                                ResultSet rs_get_att_det_12 = st.executeQuery("select emp_no,in_time,out_time,shift,status,attendance_date from att_master where emp_no='" + user + "' and attendance_date='" + D12 + "'");
                                while (rs_get_att_det_12.next()) {
                                    if (rs_get_att_det_12.getString(5).equals("Present")) {
                            %>
                            <h5><span class="badge badge-success">PRESENT</span></h5>
                            <h6><span class="col-1">Intime  :<%=rs_get_att_det_12.getString(2)%></span>
                            </h6>
                            <h6><span class="col-1">Outtime :<%=rs_get_att_det_12.getString(3)%></span>
                            </h6>
                            <%
                            } else {
                            %>
                            <h5><span class="badge badge-danger">NOT PRESENT</span></h5>
                            <%
                                    }
                                }
                            %>
                        </div>
                        <div class="day col-sm p-2 border border-left-0 border-top-0 text-truncate ">
                            <h5 class="row align-items-center"> <span class="date col-1"><%temp = last_day - last_day + 13;
                                out.print(temp);

                                String D13 = j + "-" + i + "-" + temp;
                                Date d13 = new SimpleDateFormat("yyyy-MM-dd").parse(D13);
                                String strD13 = sdf2.format(d13);
                                    %></span>
                                <span class="col-1"></span>
                            </h5>
                            <span class="col-1"><%out.print(strD13);%></span>
                            <%
                                ResultSet rs_get_att_det_13 = st.executeQuery("select emp_no,in_time,out_time,shift,status,attendance_date from att_master where emp_no='" + user + "' and attendance_date='" + D13 + "'");
                                while (rs_get_att_det_13.next()) {
                                    if (rs_get_att_det_13.getString(5).equals("Present")) {
                            %>
                            <h5><span class="badge badge-success">PRESENT</span></h5>
                            <h6><span class="col-1">Intime  :<%=rs_get_att_det_13.getString(2)%></span>
                            </h6>
                            <h6><span class="col-1">Outtime :<%=rs_get_att_det_13.getString(3)%></span>
                            </h6>
                            <%
                            } else {
                            %>
                            <h5><span class="badge badge-danger">NOT PRESENT</span></h5>
                            <%
                                    }
                                }
                            %>
                        </div>
                        <div class="day col-sm p-2 border border-left-0 border-top-0 text-truncate ">
                            <h5 class="row align-items-center">
                                <span class="date col-1"><%temp = last_day - last_day + 14;
                                    out.print(temp);

                                    String D14 = j + "-" + i + "-" + temp;
                                    Date d14 = new SimpleDateFormat("yyyy-MM-dd").parse(D14);
                                    String strD14 = sdf2.format(d14);
                                    %></span>
                                <span class="col-1"></span>
                            </h5>
                            <span class="col-1"><%out.print(strD14);%></span>
                            <%
                                ResultSet rs_get_att_det_14 = st.executeQuery("select emp_no,in_time,out_time,shift,status,attendance_date from att_master where emp_no='" + user + "' and attendance_date='" + D14 + "'");
                                while (rs_get_att_det_14.next()) {
                                    if (rs_get_att_det_14.getString(5).equals("Present")) {
                            %>
                            <h5><span class="badge badge-success">PRESENT</span></h5>
                            <h6><span class="col-1">Intime  :<%=rs_get_att_det_14.getString(2)%></span>
                            </h6>
                            <h6><span class="col-1">Outtime :<%=rs_get_att_det_14.getString(3)%></span>
                            </h6>
                            <%
                            } else {
                            %>
                            <h5><span class="badge badge-danger">NOT PRESENT</span></h5>
                            <%
                                    }
                                }
                            %>
                        </div>
                        <div class="day col-sm p-2 border border-left-0 border-top-0 text-truncate ">
                            <h5 class="row align-items-center">
                                <span class="date col-1"><%temp = last_day - last_day + 15;
                                    out.print(temp);

                                    String D15 = j + "-" + i + "-" + temp;
                                    Date d15 = new SimpleDateFormat("yyyy-MM-dd").parse(D15);
                                    String strD15 = sdf2.format(d15);
                                    %></span>
                                <span class="col-1"></span>
                            </h5>
                            <span class="col-1"><%out.print(strD15);%></span>
                            <%
                                ResultSet rs_get_att_det_15 = st.executeQuery("select emp_no,in_time,out_time,shift,status,attendance_date from att_master where emp_no='" + user + "' and attendance_date='" + D15 + "'");
                                while (rs_get_att_det_15.next()) {
                                    if (rs_get_att_det_15.getString(5).equals("Present")) {
                            %>
                            <h5><span class="badge badge-success">PRESENT</span></h5>
                            <h6><span class="col-1">Intime  :<%=rs_get_att_det_15.getString(2)%></span>
                            </h6>
                            <h6><span class="col-1">Outtime :<%=rs_get_att_det_15.getString(3)%></span>
                            </h6>
                            <%
                            } else {
                            %>
                            <h5><span class="badge badge-danger">NOT PRESENT</span></h5>
                            <%
                                    }
                                }
                            %>
                        </div>
                        <div class="day col-sm p-2 border border-left-0 border-top-0 text-truncate ">
                            <h5 class="row align-items-center">
                                <span class="date col-1"><%temp = last_day - last_day + 16;
                                    out.print(temp);

                                    String D16 = j + "-" + i + "-" + temp;
                                    Date d16 = new SimpleDateFormat("yyyy-MM-dd").parse(D16);
                                    String strD16 = sdf2.format(d16);
                                    %></span>
                                <span class="col-1"></span>
                            </h5>
                            <span class="col-1"><%out.print(strD16);%></span>
                            <%
                                ResultSet rs_get_att_det_16 = st.executeQuery("select emp_no,in_time,out_time,shift,status,attendance_date from att_master where emp_no='" + user + "' and attendance_date='" + D16 + "'");
                                while (rs_get_att_det_16.next()) {
                                    if (rs_get_att_det_16.getString(5).equals("Present")) {
                            %>
                            <h5><span class="badge badge-success">PRESENT</span></h5>
                            <h6><span class="col-1">Intime  :<%=rs_get_att_det_16.getString(2)%></span>
                            </h6>
                            <h6><span class="col-1">Outtime :<%=rs_get_att_det_16.getString(3)%></span>
                            </h6>
                            <%
                            } else {
                            %>
                            <h5><span class="badge badge-danger">NOT PRESENT</span></h5>
                            <%
                                    }
                                }
                            %>
                        </div>
                        <div class="day col-sm p-2 border border-left-0 border-top-0 text-truncate ">
                            <h5 class="row align-items-center">
                                <span class="date col-1"><%temp = last_day - last_day + 17;
                                    out.print(temp);

                                    String D17 = j + "-" + i + "-" + temp;
                                    Date d17 = new SimpleDateFormat("yyyy-MM-dd").parse(D17);
                                    String strD17 = sdf2.format(d17);
                                    %></span>
                                <span class="col-1"></span>
                            </h5>
                            <span class="col-1"><%out.print(strD17);%></span>
                            <%
                                ResultSet rs_get_att_det_17 = st.executeQuery("select emp_no,in_time,out_time,shift,status,attendance_date from att_master where emp_no='" + user + "' and attendance_date='" + D17 + "'");
                                while (rs_get_att_det_17.next()) {
                                    if (rs_get_att_det_17.getString(5).equals("Present")) {
                            %>
                            <h5><span class="badge badge-success">PRESENT</span></h5>
                            <h6><span class="col-1">Intime  :<%=rs_get_att_det_17.getString(2)%></span>
                            </h6>
                            <h6><span class="col-1">Outtime :<%=rs_get_att_det_17.getString(3)%></span>
                            </h6>
                            <%
                            } else {
                            %>
                            <h5><span class="badge badge-danger">NOT PRESENT</span></h5>
                            <%
                                    }
                                }
                            %>
                        </div>
                        <div class="day col-sm p-2 border border-left-0 border-top-0 text-truncate ">
                            <h5 class="row align-items-center">
                                <span class="date col-1"><%temp = last_day - last_day + 18;
                                    out.print(temp);

                                    String D18 = j + "-" + i + "-" + temp;
                                    Date d18 = new SimpleDateFormat("yyyy-MM-dd").parse(D18);
                                    String strD18 = sdf2.format(d18);
                                    %></span>
                                <span class="col-1"></span>
                            </h5>
                            <span class="col-1"><%out.print(strD18);%></span>
                            <%
                                ResultSet rs_get_att_det_18 = st.executeQuery("select emp_no,in_time,out_time,shift,status,attendance_date from att_master where emp_no='" + user + "' and attendance_date='" + D18 + "'");
                                while (rs_get_att_det_18.next()) {
                                    if (rs_get_att_det_18.getString(5).equals("Present")) {
                            %>
                            <h5><span class="badge badge-success">PRESENT</span></h5>
                            <h6><span class="col-1">Intime  :<%=rs_get_att_det_18.getString(2)%></span>
                            </h6>
                            <h6><span class="col-1">Outtime :<%=rs_get_att_det_18.getString(3)%></span>
                            </h6>
                            <%
                            } else {
                            %>
                            <h5><span class="badge badge-danger">NOT PRESENT</span></h5>
                            <%
                                    }
                                }
                            %>
                        </div>
                        <div class="w-100"></div>
                        <div class="day col-sm p-2 border border-left-0 border-top-0 text-truncate ">
                            <h5 class="row align-items-center">
                                <span class="date col-1"><%temp = last_day - last_day + 19;
                                    out.print(temp);

                                    String D19 = j + "-" + i + "-" + temp;
                                    Date d19 = new SimpleDateFormat("yyyy-MM-dd").parse(D19);
                                    String strD19 = sdf2.format(d19);
                                    %></span>
                                <span class="col-1"></span>
                            </h5>
                            <span class="col-1"><%out.print(strD19);%></span>
                            <%
                                ResultSet rs_get_att_det_19 = st.executeQuery("select emp_no,in_time,out_time,shift,status,attendance_date from att_master where emp_no='" + user + "' and attendance_date='" + D19 + "'");
                                while (rs_get_att_det_19.next()) {
                                    if (rs_get_att_det_19.getString(5).equals("Present")) {
                            %>
                            <h5><span class="badge badge-success">PRESENT</span></h5>
                            <h6><span class="col-1">Intime  :<%=rs_get_att_det_19.getString(2)%></span>
                            </h6>
                            <h6><span class="col-1">Outtime :<%=rs_get_att_det_19.getString(3)%></span>
                            </h6>
                            <%
                            } else {
                            %>
                            <h5><span class="badge badge-danger">NOT PRESENT</span></h5>
                            <%
                                    }
                                }
                            %>
                        </div>
                        <div class="day col-sm p-2 border border-left-0 border-top-0 text-truncate ">
                            <h5 class="row align-items-center">
                                <span class="date col-1"><%temp = last_day - last_day + 20;
                                    out.print(temp);

                                    String D20 = j + "-" + i + "-" + temp;
                                    Date d20 = new SimpleDateFormat("yyyy-MM-dd").parse(D20);
                                    String strD20 = sdf2.format(d20);
                                    %></span>
                                <span class="col-1"></span>
                            </h5>
                            <span class="col-1"><%out.print(strD20);%></span>
                            <%
                                ResultSet rs_get_att_det_20 = st.executeQuery("select emp_no,in_time,out_time,shift,status,attendance_date from att_master where emp_no='" + user + "' and attendance_date='" + D20 + "'");
                                while (rs_get_att_det_20.next()) {
                                    if (rs_get_att_det_20.getString(5).equals("Present")) {
                            %>
                            <h5><span class="badge badge-success">PRESENT</span></h5>
                            <h6><span class="col-1">Intime  :<%=rs_get_att_det_20.getString(2)%></span>
                            </h6>
                            <h6><span class="col-1">Outtime :<%=rs_get_att_det_20.getString(3)%></span>
                            </h6>
                            <%
                            } else {
                            %>
                            <h5><span class="badge badge-danger">NOT PRESENT</span></h5>
                            <%
                                    }
                                }
                            %>
                        </div>
                        <div class="day col-sm p-2 border border-left-0 border-top-0 text-truncate ">
                            <h5 class="row align-items-center">
                                <span class="date col-1"><%temp = last_day - last_day + 21;
                                    out.print(temp);

                                    String D21 = j + "-" + i + "-" + temp;
                                    Date d21 = new SimpleDateFormat("yyyy-MM-dd").parse(D21);
                                    String strD21 = sdf2.format(d21);
                                    %></span>
                                <span class="col-1"></span>
                            </h5>
                            <span class="col-1"><%out.print(strD21);%></span>
                            <%
                                ResultSet rs_get_att_det_21 = st.executeQuery("select emp_no,in_time,out_time,shift,status,attendance_date from att_master where emp_no='" + user + "' and attendance_date='" + D21 + "'");
                                while (rs_get_att_det_21.next()) {
                                    if (rs_get_att_det_21.getString(5).equals("Present")) {
                            %>
                            <h5><span class="badge badge-success">PRESENT</span></h5>
                            <h6><span class="col-1">Intime  :<%=rs_get_att_det_21.getString(2)%></span>
                            </h6>
                            <h6><span class="col-1">Outtime :<%=rs_get_att_det_21.getString(3)%></span>
                            </h6>
                            <%
                            } else {
                            %>
                            <h5><span class="badge badge-danger">NOT PRESENT</span></h5>
                            <%
                                    }
                                }
                            %>
                        </div>
                        <div class="day col-sm p-2 border border-left-0 border-top-0 text-truncate ">
                            <h5 class="row align-items-center">
                                <span class="date col-1"><%temp = last_day - last_day + 22;
                                    out.print(temp);

                                    String D22 = j + "-" + i + "-" + temp;
                                    Date d22 = new SimpleDateFormat("yyyy-MM-dd").parse(D22);
                                    String strD22 = sdf2.format(d22);
                                    %></span>
                                <span class="col-1"></span>
                            </h5>
                            <span class="col-1"><%out.print(strD22);%></span>
                            <%
                                ResultSet rs_get_att_det_22 = st.executeQuery("select emp_no,in_time,out_time,shift,status,attendance_date from att_master where emp_no='" + user + "' and attendance_date='" + D22 + "'");
                                while (rs_get_att_det_22.next()) {
                                    if (rs_get_att_det_22.getString(5).equals("Present")) {
                            %>
                            <h5><span class="badge badge-success">PRESENT</span></h5>
                            <h6><span class="col-1">Intime  :<%=rs_get_att_det_22.getString(2)%></span>
                            </h6>
                            <h6><span class="col-1">Outtime :<%=rs_get_att_det_22.getString(3)%></span>
                            </h6>
                            <%
                            } else {
                            %>
                            <h5><span class="badge badge-danger">NOT PRESENT</span></h5>
                            <%
                                    }
                                }
                            %>
                        </div>
                        <div class="day col-sm p-2 border border-left-0 border-top-0 text-truncate ">
                            <h5 class="row align-items-center">
                                <span class="date col-1"><%temp = last_day - last_day + 23;
                                    out.print(temp);

                                    String D23 = j + "-" + i + "-" + temp;
                                    Date d23 = new SimpleDateFormat("yyyy-MM-dd").parse(D23);
                                    String strD23 = sdf2.format(d23);
                                    %></span>
                                <span class="col-1"></span>
                            </h5>
                            <span class="col-1"><%out.print(strD23);%></span>
                            <%
                                ResultSet rs_get_att_det_23 = st.executeQuery("select emp_no,in_time,out_time,shift,status,attendance_date from att_master where emp_no='" + user + "' and attendance_date='" + D23 + "'");
                                while (rs_get_att_det_23.next()) {
                                    if (rs_get_att_det_23.getString(5).equals("Present")) {
                            %>
                            <h5><span class="badge badge-success">PRESENT</span></h5>
                            <h6><span class="col-1">Intime  :<%=rs_get_att_det_23.getString(2)%></span>
                            </h6>
                            <h6><span class="col-1">Outtime :<%=rs_get_att_det_23.getString(3)%></span>
                            </h6>
                            <%
                            } else {
                            %>
                            <h5><span class="badge badge-danger">NOT PRESENT</span></h5>
                            <%
                                    }
                                }
                            %>
                        </div>
                        <div class="day col-sm p-2 border border-left-0 border-top-0 text-truncate ">
                            <h5 class="row align-items-center">
                                <span class="date col-1"><%temp = last_day - last_day + 24;
                                    out.print(temp);

                                    String D24 = j + "-" + i + "-" + temp;
                                    Date d24 = new SimpleDateFormat("yyyy-MM-dd").parse(D24);
                                    String strD24 = sdf2.format(d24);
                                    %></span>
                                <span class="col-1"></span>
                            </h5>
                            <span class="col-1"><%out.print(strD12);%></span>
                            <%
                                ResultSet rs_get_att_det_24 = st.executeQuery("select emp_no,in_time,out_time,shift,status,attendance_date from att_master where emp_no='" + user + "' and attendance_date='" + D24 + "'");
                                while (rs_get_att_det_24.next()) {
                                    if (rs_get_att_det_24.getString(5).equals("Present")) {
                            %>
                            <h5><span class="badge badge-success">PRESENT</span></h5>
                            <h6><span class="col-1">Intime  :<%=rs_get_att_det_24.getString(2)%></span>
                            </h6>
                            <h6><span class="col-1">Outtime :<%=rs_get_att_det_24.getString(3)%></span>
                            </h6>
                            <%
                            } else {
                            %>
                            <h5><span class="badge badge-danger">NOT PRESENT</span></h5>
                            <%
                                    }
                                }
                            %>
                        </div>
                        <div class="day col-sm p-2 border border-left-0 border-top-0 text-truncate ">
                            <h5 class="row align-items-center">
                                <span class="date col-1"><%temp = last_day - last_day + 25;
                                    out.print(temp);

                                    String D25 = j + "-" + i + "-" + temp;
                                    Date d25 = new SimpleDateFormat("yyyy-MM-dd").parse(D25);
                                    String strD25 = sdf2.format(d25);
                                    %></span>
                                <span class="col-1"></span>
                            </h5>
                            <span class="col-1"><%out.print(strD25);%></span>
                            <%
                                ResultSet rs_get_att_det_25 = st.executeQuery("select emp_no,in_time,out_time,shift,status,attendance_date from att_master where emp_no='" + user + "' and attendance_date='" + D25 + "'");
                                while (rs_get_att_det_25.next()) {
                                    if (rs_get_att_det_25.getString(5).equals("Present")) {
                            %>
                            <h5><span class="badge badge-success">PRESENT</span></h5>
                            <h6><span class="col-1">Intime  :<%=rs_get_att_det_25.getString(2)%></span>
                            </h6>
                            <h6><span class="col-1">Outtime :<%=rs_get_att_det_25.getString(3)%></span>
                            </h6>
                            <%
                            } else {
                            %>
                            <h5><span class="badge badge-danger">NOT PRESENT</span></h5>
                            <%
                                    }
                                }
                            %>
                        </div>
                        <div class="w-100"></div>
                        <div class="day col-sm p-2 border border-left-0 border-top-0 text-truncate ">
                            <h5 class="row align-items-center">
                                <span class="date col-1"><%temp = last_day - last_day + 26;
                                    out.print(temp);

                                    String D26 = j + "-" + i + "-" + temp;
                                    Date d26 = new SimpleDateFormat("yyyy-MM-dd").parse(D26);
                                    String strD26 = sdf2.format(d26);
                                    %></span>
                                <span class="col-1"></span>
                            </h5>
                            <span class="col-1"><%out.print(strD26);%></span>
                            <%
                                ResultSet rs_get_att_det_26 = st.executeQuery("select emp_no,in_time,out_time,shift,status,attendance_date from att_master where emp_no='" + user + "' and attendance_date='" + D26 + "'");
                                while (rs_get_att_det_26.next()) {
                                    if (rs_get_att_det_26.getString(5).equals("Present")) {
                            %>
                            <h5><span class="badge badge-success">PRESENT</span></h5>
                            <h6><span class="col-1">Intime  :<%=rs_get_att_det_26.getString(2)%></span>
                            </h6>
                            <h6><span class="col-1">Outtime :<%=rs_get_att_det_26.getString(3)%></span>
                            </h6>
                            <%
                            } else {
                            %>
                            <h5><span class="badge badge-danger">NOT PRESENT</span></h5>
                            <%
                                    }
                                }
                            %>
                        </div>
                        <div class="day col-sm p-2 border border-left-0 border-top-0 text-truncate ">
                            <h5 class="row align-items-center">
                                <span class="date col-1"><%temp = last_day - last_day + 27;
                                    out.print(temp);

                                    String D27 = j + "-" + i + "-" + temp;
                                    Date d27 = new SimpleDateFormat("yyyy-MM-dd").parse(D27);
                                    String strD27 = sdf2.format(d27);
                                    %></span>
                                <span class="col-1"></span>
                            </h5>
                            <span class="col-1"><%out.print(strD27);%></span>
                            <%
                                ResultSet rs_get_att_det_27 = st.executeQuery("select emp_no,in_time,out_time,shift,status,attendance_date from att_master where emp_no='" + user + "' and attendance_date='" + D27 + "'");
                                while (rs_get_att_det_27.next()) {
                                    if (rs_get_att_det_27.getString(5).equals("Present")) {
                            %>
                            <h5><span class="badge badge-success">PRESENT</span></h5>
                            <h6><span class="col-1">Intime  :<%=rs_get_att_det_27.getString(2)%></span>
                            </h6>
                            <h6><span class="col-1">Outtime :<%=rs_get_att_det_27.getString(3)%></span>
                            </h6>
                            <%
                            } else {
                            %>
                            <h5><span class="badge badge-danger">NOT PRESENT</span></h5>
                            <%
                                    }
                                }
                            %>
                        </div>



                        <%if (last_day >= 28) {
                        %>  
                        <div class="day col-sm p-2 border border-left-0 border-top-0 text-truncate">
                            <h5 class="row align-items-center">

                                <span class="date col-1"><%temp = last_day - last_day + 28;
                                    out.print(temp);

                                    String D28 = j + "-" + i + "-" + temp;
                                    Date d28 = new SimpleDateFormat("yyyy-MM-dd").parse(D28);
                                    String strD28 = sdf2.format(d28);

                                    %></span>

                            </h5>
                            <span class="col-1"><%out.print(strD28);%></span>
                            <%
                                ResultSet rs_get_att_det_28 = st.executeQuery("select emp_no,in_time,out_time,shift,status,attendance_date from att_master where emp_no='" + user + "' and attendance_date='" + D28 + "'");
                                while (rs_get_att_det_28.next()) {
                                    if (rs_get_att_det_28.getString(5).equals("Present")) {
                            %>
                            <h5><span class="badge badge-success">PRESENT</span></h5>
                            <h6><span class="col-1">Intime  :<%=rs_get_att_det_28.getString(2)%></span>
                            </h6>
                            <h6><span class="col-1">Outtime :<%=rs_get_att_det_28.getString(3)%></span>
                            </h6>
                            <%
                            } else {
                            %>
                            <h5><span class="badge badge-danger">NOT PRESENT</span></h5>
                            <%
                                    }
                                }
                            %>
                        </div>
                        <%} else {
                        %>
                        <div class="day col-sm p-2 border border-left-0 border-top-0 text-truncate d-none d-sm-inline-block bg-light text-muted">
                            <h5 class="row align-items-center">
                                <span class="col-1"></span>
                            </h5>
                        </div>
                        <%
                            }%>


                        <%if (last_day >= 29) {
                        %>  
                        <div class="day col-sm p-2 border border-left-0 border-top-0 text-truncate">
                            <h5 class="row align-items-center">

                                <span class="date col-1"><%temp = last_day - last_day + 29;
                                    out.print(temp);

                                    String D29 = j + "-" + i + "-" + temp;
                                    Date d29 = new SimpleDateFormat("yyyy-MM-dd").parse(D29);
                                    String strD29 = sdf2.format(d29);

                                    %></span>

                            </h5>
                            <span class="col-1"><%out.print(strD29);%></span>
                            <%
                                ResultSet rs_get_att_det_29 = st.executeQuery("select emp_no,in_time,out_time,shift,status,attendance_date from att_master where emp_no='" + user + "' and attendance_date='" + D29 + "'");
                                while (rs_get_att_det_29.next()) {
                                    if (rs_get_att_det_29.getString(5).equals("Present")) {
                            %>
                            <h5><span class="badge badge-success">PRESENT</span></h5>
                            <h6><span class="col-1">Intime  :<%=rs_get_att_det_8.getString(2)%></span>
                            </h6>
                            <h6><span class="col-1">Outtime :<%=rs_get_att_det_8.getString(3)%></span>
                            </h6>
                            <%
                            } else {
                            %>
                            <h5><span class="badge badge-danger">NOT PRESENT</span></h5>
                            <%
                                    }
                                }
                            %>
                        </div>
                        <%} else {
                        %>
                        <div class="day col-sm p-2 border border-left-0 border-top-0 text-truncate d-none d-sm-inline-block bg-light text-muted">
                            <h5 class="row align-items-center">
                                <span class="col-1"></span>
                            </h5>
                        </div>
                        <%
                            }%>


                        <%if (last_day >= 30) {
                        %>  
                        <div class="day col-sm p-2 border border-left-0 border-top-0 text-truncate">
                            <h5 class="row align-items-center">

                                <span class="date col-1"><%temp = last_day - last_day + 30;
                                    out.print(temp);

                                    String D30 = j + "-" + i + "-" + temp;
                                    Date d30 = new SimpleDateFormat("yyyy-MM-dd").parse(D30);
                                    String strD30 = sdf2.format(d30);

                                    %></span>

                            </h5>
                            <span class="col-1"><%out.print(strD30);%></span>
                            <%
                                ResultSet rs_get_att_det_30 = st.executeQuery("select emp_no,in_time,out_time,shift,status,attendance_date from att_master where emp_no='" + user + "' and attendance_date='" + D30 + "'");
                                while (rs_get_att_det_30.next()) {
                                    if (rs_get_att_det_30.getString(5).equals("Present")) {
                            %>
                            <h5><span class="badge badge-success">PRESENT</span></h5>
                            <h6><span class="col-1">Intime  :<%=rs_get_att_det_30.getString(2)%></span>
                            </h6>
                            <h6><span class="col-1">Outtime :<%=rs_get_att_det_30.getString(3)%></span>
                            </h6>
                            <%
                            } else {
                            %>
                            <h5><span class="badge badge-danger">NOT PRESENT</span></h5>
                            <%
                                    }
                                }
                            %>
                        </div>
                        <%} else {
                        %>
                        <div class="day col-sm p-2 border border-left-0 border-top-0 text-truncate d-none d-sm-inline-block bg-light text-muted">
                            <h5 class="row align-items-center">
                                <span class="col-1"></span>
                            </h5>
                        </div>
                        <%
                            }%>


                        <%if (last_day >= 31) {
                        %>  
                        <div class="day col-sm p-2 border border-left-0 border-top-0 text-truncate">
                            <h5 class="row align-items-center">

                                <span class="date col-1"><%temp = last_day - last_day + 31;
                                    out.print(temp);

                                    String D31 = j + "-" + i + "-" + temp;
                                    Date d31 = new SimpleDateFormat("yyyy-MM-dd").parse(D31);
                                    String strD31 = sdf2.format(d31);

                                    %></span>

                            </h5>
                            <span class="col-1"><%out.print(strD31);%></span>
                            <%
                                ResultSet rs_get_att_det_31 = st.executeQuery("select emp_no,in_time,out_time,shift,status,attendance_date from att_master where emp_no='" + user + "' and attendance_date='" + D31 + "'");
                                while (rs_get_att_det_31.next()) {
                                    if (rs_get_att_det_31.getString(5).equals("Present")) {
                            %>
                            <h5><span class="badge badge-success">PRESENT</span></h5>
                            <h6><span class="col-1">Intime  :<%=rs_get_att_det_31.getString(2)%></span>
                            </h6>
                            <h6><span class="col-1">Outtime :<%=rs_get_att_det_31.getString(3)%></span>
                            </h6>
                            <%
                            } else {
                            %>
                            <h5><span class="badge badge-danger">NOT PRESENT</span></h5>
                            <%
                                    }
                                }
                            %>
                        </div>
                        <%} else {
                        %>
                        <div class="day col-sm p-2 border border-left-0 border-top-0 text-truncate d-none d-sm-inline-block bg-light text-muted">
                            <h5 class="row align-items-center">
                                <span class="col-1"></span>
                            </h5>
                        </div>
                        <%
                            }%>


                        <div class="day col-sm p-2 border border-left-0 border-top-0 text-truncate d-none d-sm-inline-block bg-light text-muted">
                            <h5 class="row align-items-center">
                                <span class="date col-1"></span>
                                <span class="col-1"></span>
                            </h5>
                            <p class="d-sm-none">No events</p>
                        </div>
                        <div class="w-100"></div>
                        <div class="day col-sm p-2 border border-left-0 border-top-0 text-truncate d-none d-sm-inline-block bg-light text-muted">
                            <h5 class="row align-items-center">
                                <span class="date col-1"></span>
                            </h5>
                            <p class="d-sm-none">No events</p>
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
