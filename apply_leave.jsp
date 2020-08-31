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


        <!--Custom alert *** START *****-->
        <script>
            var ALERT_TITLE = "Oops!";
            var ALERT_BUTTON_TEXT = "Ok";
            if (document.getElementById) {
                window.alert = function (txt) {
                    createCustomAlert(txt);
                }
            }

            function createCustomAlert(txt


                    ) {
                d = document;
                if (d.getElementById("modalContainer")) {
                    return;
                }

                mObj = d.getElementsByTagName("body")[0].appendChild(d.createElement("div"));
                mObj.id = "modalContainer";
                mObj.style.height = d.documentElement.scrollHeight + "px";
                alertObj = mObj.appendChild(d.createElement("div"));
                alertObj.id = "alertBox";
                if (d.all && !window.opera) {
                    alertObj.style.top = document.documentElement.scrollTop + "px";
                }
                alertObj.style.left = (d.documentElement.scrollWidth - alertObj.offsetWidth) / 2 + "px";
                alertObj.style.visiblity = "visible";
                h1 = alertObj.appendChild(d.createElement("h1"));
                h1.appendChild(d.createTextNode(ALERT_TITLE));
                msg = alertObj.appendChild(d.createElement("p"));
                //msg.appendChild(d.createTextNode(txt));
                msg.innerHTML = txt;
                btn = alertObj.appendChild(d.createElement("a"));
                btn.id = "closeBtn";
                btn.appendChild(d.createTextNode(ALERT_BUTTON_TEXT));
                btn.href = "#";
                btn.focus();
                btn.onclick = function () {
                    removeCustomAlert();
                    return false;
                }

                alertObj.style.display = "block";
            }

            function removeCustomAlert


                    () {
                document.getElementsByTagName("body")[0].removeChild(document.getElementById("modalContainer"));
            }

        </script>
        <style>
            #modalContainer {
                background-color:rgba(0, 0, 0, 0.3);
                position:absolute;
                width:100%;
                height:100%;
                top:0px;
                left:0px;
                z-index:10000;
                background-image:url(tp.png); /* required by MSIE to prevent actions on lower z-index elements */
            }

            #alertBox {
                position:relative;
                width:350px;
                min-height:100px;
                margin-top:50px;
                border:1px solid #666;
                background-color:#fff;
                background-repeat:no-repeat;
                background-position:20px 30px;
                border-radius: 10px;
            }

            #modalContainer > #alertBox {
                position:fixed;
            }

            #alertBox h1 {
                margin:0;
                font:bold 1.0em verdana,arial;
                background-color:#3073BB;
                color:#FFF;
                border-bottom:1px solid #000;
                padding:2px 0 2px 5px;
                border-radius: 6px;
            }

            #alertBox p {
                font: 0.8em verdana,arial;
                height: 50px;
                padding-left: 0px;
                margin-left: 15px;
                margin-top: 14px;
            }

            #alertBox #closeBtn {
                display:block;
                position:relative;
                margin:5px auto;
                padding:7px;
                border:0 none;
                width:70px;
                font:0.7em verdana,arial;
                text-transform:uppercase;
                text-align:center;
                color:#FFF;
                background-color:#357EBD;
                border-radius: 3px;
                text-decoration:none;
            }

            /* unrelated styles */

            #mContainer {
                position:relative;
                width:600px;
                margin:auto;
                padding:5px;
                border-top:2px solid #000;
                border-bottom:2px solid #000;
                font:0.7em verdana,arial;
            }

            h1,h2 {
                margin:0;
                padding:4px;
                font:bold 1.5em verdana;
                border-bottom:1px solid #000;
            }

            code {
                font-size:1.2em;
                color:#069;
            }

            #credits {
                position:relative;
                margin:25px auto 0px auto;
                width:350px; 
                font:0.7em verdana;
                border-top:1px solid #000;
                border-bottom:1px solid #000;
                height:90px;
                padding-top:4px;
            }

            #credits img {
                float:left;
                margin:5px 10px 5px 0px;
                border:1px solid #000000;
                width:80px;
                height:79px;
            }

            .important {
                background-color:#F5FCC8;
                padding:2px;
            }

            code span {
                color:green;
            }
        </style>
        <!--Custom alert *** END *****-->





        <script>



            function from_leave_chk1_click() {


//Validation Start with No values in from date and To date *** START ***
                if (document.getElementById("from_date").value != "" && document.getElementById("to_date").value != "") {

                    document.getElementById("from_leave_half_div").style.display = "none"
                    var applied_leave = 0;
                    var sl = 0, cl = 0, el = 0;
                    var emp_no, from_date = "";
                    let totel_data = [], data, totel = 0;
                    var availabe_el_count = 0;
                    var mydate = new Date(from_date);
                    var from_date_year = mydate.getFullYear();
//Calculation for half day . based on availabe leave *** START ****
                    applied_leave = parseFloat($("#applied_leave").val()) + 0.5;
                    $("#applied_leave").val(applied_leave);
//Calculation for half day . based on availabe leave *** END ****


                    $("#leavetype option[value='1']").remove();
                    $("#leavetype option[value='2']").remove();
                    $("#leavetype option[value='3']").remove();
                    $("#leavetype option[value='4']").remove();
                    sl = document.getElementById("available_sl").value;
                    cl = document.getElementById("available_cl").value;
                    el = document.getElementById("available_el").value;
//For get the EL count in backend for current year how many EL choose *** START ***
                    $.ajax({
                        type: "POST",
                        url: "get_leave.jsp",
                        data: {emp_no: emp_no, year: from_date_year, check: "1"},
                        success: function (data) {
                            totel_data = data.split("&");
                            availabe_el_count = parseInt(totel_data[0]);
//availabele leave based leave category change *** START ***
                            if (applied_leave <= cl || applied_leave <= sl || applied_leave <= el) {
                                if (applied_leave >= 3 && el >= applied_leave && availabe_el_count < 2) {
                                    $('#leavetype').append(new Option("EL-Earn Leave", '3'));
                                }
                                if (applied_leave <= 6 && sl >= applied_leave) {
                                    $('#leavetype').append(new Option("SL-Sick Leave", '2'));
                                }
                                if (applied_leave <= 3 && cl >= applied_leave) {
                                    $('#leavetype').append(new Option("CL-Casual Leave", '1'));
                                }
                                $('#leavetype').append(new Option("LOP-Loss of Pay", '4'));
                            } else {
                                $('#leavetype').append(new Option("LOP-Loss of Pay", '4'));
                                alert("Sorry...! You dont have that much of availabe leave in any category...If you need it consider as a LOP");
//                        alert("Sorry...! You dont have that much of availabe leave in any cateory...");
//                        $("#from_date").val("");
//                        $("#to_date").val("");
//                        $("#applied_leave").val("");
//                        $("#availabel_leave").val("");
                                applied_leave = "";
                            }
                        }
                    });
//availabele leave based leave category change *** START ***

//For get the EL count in backend for current year how many EL choose *** END ***


//Assingn the avaliable leave for which leave choose **** START ****
                    if ($("#leavetype").val() == '1') {
                        $("#availabel_leave").val(cl)
                    }
                    if ($("#leavetype").val() == '2') {
                        $("#availabel_leave").val(sl)
                    }
                    if ($("#leavetype").val() == '3') {
                        $("#availabel_leave").val(el)
                    }
//Assingn the avaliable leave for which leave choose **** END ****
                    document.getElementById("from_leave_chk1").disabled = true;
                    document.getElementById("from_leave_chk2").disabled = false;
                }//Validation Start with No values in from date and To date *** END ***

                else {
                    alert("Please Choose the date first");
                    document.getElementById("from_leave_chk1").checked = false;
                    document.getElementById("from_leave_chk2").checked = false;
                    document.getElementById("to_leave_chk1").checked = false;
                    document.getElementById("to_leave_chk2").checked = false;
                    document.getElementById("from_leave_half_div").style.display = "none"
                    document.getElementById("to_leave_half_div").style.display = "none"
                }



            }




            function from_leave_chk2_click() {

                var applied_leave = 0;
//Validation Start with No values in from date and To date *** START ***

                if (document.getElementById("from_date").value != "" && document.getElementById("to_date").value != "") {

                    document.getElementById("from_leave_half_div").style.display = "block"

                    if ((document.getElementById("from_leave_chk2").checked == true) && (document.getElementById("to_leave_chk2").checked == true) && ($("#applied_leave").val() <= 1)) {
                        alert("Sorry...!!! One day leave only apply any one half");
                        document.getElementById("from_leave_half_div").style.display = "none"
                        document.getElementById("to_leave_half_div").style.display = "none"
                        document.getElementById("from_leave_chk2").checked = false;
                        document.getElementById("to_leave_chk2").checked = false;
                        $("#applied_leave").val("");
                        $("#availabel_leave").val("");
                        $("#from_date").val("");
                        $("#to_date").val("");
                    } else {

//Calculation for half day . based on availabe leave *** END ****

                        applied_leave = $("#applied_leave").val() - 0.5;
                        $("#applied_leave").val(applied_leave);
//Calculation for half day . based on availabe leave *** END ****


//for 1 day + day half day show 2nd half *** START ***
                        if (applied_leave > 1) {
                            $("#from_half option[value='2nd_half']").attr('selected', 'selected');
                        }
//for 1 day + day half day show 2nd half *** END ***






                        var sl = 0, cl = 0, el = 0;
                        var emp_no, from_date = "";
                        let totel_data = [], data, totel = 0;
                        var availabe_el_count = 0;
                        var date_fdate = new Date(document.getElementById("from_date").value);
                        var date_tdate = new Date(document.getElementById("to_date").value);
                        emp_no = document.getElementById("emp_no").value;
                        var mydate = new Date(from_date);
                        var from_date_year = mydate.getFullYear();
                        $("#leavetype option[value='1']").remove();
                        $("#leavetype option[value='2']").remove();
                        $("#leavetype option[value='3']").remove();
                        $("#leavetype option[value='4']").remove();
                        sl = document.getElementById("available_sl").value;
                        cl = document.getElementById("available_cl").value;
                        el = document.getElementById("available_el").value;
//For get the EL count in backend for current year how many EL choose *** START ***

                        $.ajax({
                            type: "POST",
                            url: "get_leave.jsp",
                            data: {emp_no: emp_no, year: from_date_year, check: "1"},
                            success: function (data) {
                                totel_data = data.split("&");
                                availabe_el_count = parseInt(totel_data[0]);
//For get the EL count in backend for current year how many EL choose *** END ***


                                if (applied_leave <= cl || applied_leave <= sl || applied_leave <= el) {


                                    if (applied_leave >= 3 && el >= applied_leave && availabe_el_count < 2) {
                                        $('#leavetype').append(new Option("EL-Earn Leave", '3'));
                                    }
                                    if (applied_leave <= 6 && sl >= applied_leave) {
                                        $('#leavetype').append(new Option("SL-Sick Leave", '2'));
                                    }
                                    if (applied_leave <= 3 && cl >= applied_leave) {
                                        $('#leavetype').append(new Option("CL-Casual Leave", '1'));
                                    }
                                    $('#leavetype').append(new Option("LOP-Loss of Pay", '4'));
                                } else {
                                    $('#leavetype').append(new Option("LOP-Loss of Pay", '4'));
                                    alert("Sorry...! You dont have that much of availabe leave in any category...If you need it consider as a LOP");
//                            alert("Sorry...! You dont have that much of availabe leave in any cateory...");
//                            $("#from_date").val("");
//                            $("#to_date").val("");
//                            $("#applied_leave").val("");
//                            $("#availabel_leave").val("");
                                    applied_leave = "";
                                }
                            }
                        });
                        if ($("#leavetype").val() == '1') {
                            $("#availabel_leave").val(cl)
                        }
                        if ($("#leavetype").val() == '2') {
                            $("#availabel_leave").val(sl)
                        }
                        if ($("#leavetype").val() == '3') {
                            $("#availabel_leave").val(el)
                        }

                        document.getElementById("from_leave_chk1").disabled = false;
                        document.getElementById("from_leave_chk2").disabled = true;
                    }

                }//Validation Start with No values in from date and To date *** END ***

                else {
                    alert("Please Choose the date first");
                    document.getElementById("from_leave_chk1").checked = false;
                    document.getElementById("from_leave_chk2").checked = false;
                    document.getElementById("to_leave_chk1").checked = false;
                    document.getElementById("to_leave_chk2").checked = false;
                    document.getElementById("from_leave_half_div").style.display = "none"
                    document.getElementById("to_leave_half_div").style.display = "none"

                }


            }







            function to_leave_chk1_click() {
//                document.getElementById("to_leave_half_div").style.display = "none";

                if (document.getElementById("from_date").value != "" && document.getElementById("to_date").value != "") {

                    document.getElementById("to_leave_half_div").style.display = "none"
                    var applied_leave = 0;
                    var sl = 0, cl = 0, el = 0;
                    var emp_no, from_date = "";
                    let totel_data = [], data, totel = 0;
                    var availabe_el_count = 0;
                    var date_fdate = new Date(document.getElementById("from_date").value);
                    var date_tdate = new Date(document.getElementById("to_date").value);
                    emp_no = document.getElementById("emp_no").value;
                    var mydate = new Date(from_date);
                    var from_date_year = mydate.getFullYear();
                    applied_leave = parseFloat($("#applied_leave").val()) + 0.5;
                    $("#applied_leave").val(applied_leave);
                    $("#leavetype option[value='1']").remove();
                    $("#leavetype option[value='2']").remove();
                    $("#leavetype option[value='3']").remove();
                    $("#leavetype option[value='4']").remove();
                    sl = document.getElementById("available_sl").value;
                    cl = document.getElementById("available_cl").value;
                    el = document.getElementById("available_el").value;
                    $.ajax({
                        type: "POST",
                        url: "get_leave.jsp",
                        data: {emp_no: emp_no, year: from_date_year, check: "1"},
                        success: function (data) {
                            totel_data = data.split("&");
                            availabe_el_count = parseInt(totel_data[0]);
                            if (applied_leave <= cl || applied_leave <= sl || applied_leave <= el) {


                                if (applied_leave >= 3 && el >= applied_leave && availabe_el_count < 2) {
                                    $('#leavetype').append(new Option("EL-Earn Leave", '3'));
                                }
                                if (applied_leave <= 6 && sl >= applied_leave) {
                                    $('#leavetype').append(new Option("SL-Sick Leave", '2'));
                                }
                                if (applied_leave <= 3 && cl >= applied_leave) {
                                    $('#leavetype').append(new Option("CL-Casual Leave", '1'));
                                }
                                $('#leavetype').append(new Option("LOP-Loss of Pay", '4'));
                            } else {
                                $('#leavetype').append(new Option("LOP-Loss of Pay", '4'));
                                alert("Sorry...! You dont have that much of availabe leave in any category...If you need it consider as a LOP");
//                        alert("Sorry...! You dont have that much of availabe leave in any cateory...");
////                        alert("Select From Date And To Date in Right Manner...");
//                        $("#from_date").val("");
//                        $("#to_date").val("");
//                        $("#applied_leave").val("");
//                        $("#availabel_leave").val("");
                                applied_leave = "";
                            }
                        }
                    });
                    if ($("#leavetype").val() == '1') {
                        $("#availabel_leave").val(cl)
                    }
                    if ($("#leavetype").val() == '2') {
                        $("#availabel_leave").val(sl)
                    }
                    if ($("#leavetype").val() == '3') {
                        $("#availabel_leave").val(el)
                    }
                    document.getElementById("to_leave_chk1").disabled = true;
                    document.getElementById("to_leave_chk2").disabled = false;
                } else {
                    alert("Please Choose the date first");
                    document.getElementById("from_leave_chk1").checked = false;
                    document.getElementById("from_leave_chk2").checked = false;
                    document.getElementById("to_leave_chk1").checked = false;
                    document.getElementById("to_leave_chk2").checked = false;
                    document.getElementById("from_leave_half_div").style.display = "none"
                    document.getElementById("to_leave_half_div").style.display = "none"
                }


            }




            function to_leave_chk2_click() {
                var applied_leave = 0;
                if (document.getElementById("from_date").value != "" && document.getElementById("to_date").value != "") {

                    document.getElementById("to_leave_half_div").style.display = "block"

                    if ((document.getElementById("from_leave_chk2").checked == true) && (document.getElementById("to_leave_chk2").checked == true) && ($("#applied_leave").val() <= 1)) {
                        alert("Sorry...!!! One day leave only apply any one half");
                        document.getElementById("from_leave_half_div").style.display = "none"
                        document.getElementById("to_leave_half_div").style.display = "none"
                        document.getElementById("from_leave_chk2").checked = false;
                        document.getElementById("to_leave_chk2").checked = false;
                        $("#applied_leave").val("");
                        $("#availabel_leave").val("");
                        $("#from_date").val("");
                        $("#to_date").val("");
                    } else {

                        applied_leave = $("#applied_leave").val() - 0.5;
                        $("#applied_leave").val(applied_leave);
                        var sl = 0, cl = 0, el = 0;
                        var emp_no, from_date = "";
                        let totel_data = [], data, totel = 0;
                        var availabe_el_count = 0;
                        var date_fdate = new Date(document.getElementById("from_date").value);
                        var date_tdate = new Date(document.getElementById("to_date").value);
                        emp_no = document.getElementById("emp_no").value;
                        var mydate = new Date(from_date);
                        var from_date_year = mydate.getFullYear();
//                        applied_leave = parseFloat($("#applied_leave").val()) + 0.5;
//                        $("#applied_leave").val(applied_leave);

                        $("#leavetype option[value='1']").remove();
                        $("#leavetype option[value='2']").remove();
                        $("#leavetype option[value='3']").remove();
                        $("#leavetype option[value='4']").remove();
                        sl = document.getElementById("available_sl").value;
                        cl = document.getElementById("available_cl").value;
                        el = document.getElementById("available_el").value;
                        $.ajax({
                            type: "POST",
                            url: "get_leave.jsp",
                            data: {emp_no: emp_no, year: from_date_year, check: "1"},
                            success: function (data) {
                                totel_data = data.split("&");
                                availabe_el_count = parseInt(totel_data[0]);
                                if (applied_leave <= cl || applied_leave <= sl || applied_leave <= el) {


                                    if (applied_leave >= 3 && el >= applied_leave && availabe_el_count < 2) {
                                        $('#leavetype').append(new Option("EL-Earn Leave", '3'));
                                    }
                                    if (applied_leave <= 6 && sl >= applied_leave) {
                                        $('#leavetype').append(new Option("SL-Sick Leave", '2'));
                                    }
                                    if (applied_leave <= 3 && cl >= applied_leave) {
                                        $('#leavetype').append(new Option("CL-Casual Leave", '1'));
                                    }
                                    $('#leavetype').append(new Option("LOP-Loss of Pay", '4'));
                                } else {
                                    $('#leavetype').append(new Option("LOP-Loss of Pay", '4'));
                                    alert("Sorry...! You dont have that much of availabe leave in any category...If you need it consider as a LOP");
//                            alert("Sorry...! You dont have that much of availabe leave in any cateory...");
//                        alert("Select From Date And To Date in Right Manner...");
//                            $("#from_date").val("");
//                            $("#to_date").val("");
//                            $("#applied_leave").val("");
//                            $("#availabel_leave").val("");
                                    applied_leave = "";
                                }
                            }
                        });
                        if ($("#leavetype").val() == '1') {
                            $("#availabel_leave").val(cl)
                        }
                        if ($("#leavetype").val() == '2') {
                            $("#availabel_leave").val(sl)
                        }
                        if ($("#leavetype").val() == '3') {
                            $("#availabel_leave").val(el)
                        }

                        document.getElementById("to_leave_chk1").disabled = false;
                        document.getElementById("to_leave_chk2").disabled = true;
                    }

                } else {
                    alert("Please Choose the date first");
                    document.getElementById("from_leave_chk1").checked = false;
                    document.getElementById("from_leave_chk2").checked = false;
                    document.getElementById("to_leave_chk1").checked = false;
                    document.getElementById("to_leave_chk2").checked = false;
                    document.getElementById("from_leave_half_div").style.display = "none"
                    document.getElementById("to_leave_half_div").style.display = "none"
                }


            }





            function from_date_click_sel() {
                document.getElementById("from_leave_chk1").checked = "checked";
                document.getElementById("from_leave_chk1").disabled = true;
            }
            function to_date_click_sel() {
                document.getElementById("to_leave_chk1").checked = "checked";
                document.getElementById("to_leave_chk1").disabled = true;
            }
            function  from_date_change_sel() {
                $("#leavetype option[value='1']").remove();
                $("#leavetype option[value='2']").remove();
                $("#leavetype option[value='3']").remove();
                $("#leavetype option[value='4']").remove();
                $("#applied_leave").val("");
                document.getElementById("from_leave_half_div").style.display = "none"
                document.getElementById("to_leave_half_div").style.display = "none"



                if (document.getElementById("from_date").value != "" && document.getElementById("to_date").value != "") {
                    document.getElementById("to_leave_chk1").checked = "checked";
                    var date_fdate = new Date(document.getElementById("from_date").value);
                    var date_tdate = new Date(document.getElementById("to_date").value);
                    var weekday = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
//                    alert(weekday[date_fdate.getDay()]);
                    if (((weekday[date_fdate.getDay()]) == "Sunday") || ((weekday[date_tdate.getDay()]) == "Sunday")) {
                        alert("Sorry...! Sunday not accepted.");
                        $("#from_date").val("");
                        $("#to_date").val("");
                        $("#applied_leave").val("");
                        $("#availabel_leave").val("");
                        document.getElementById("from_leave_chk1").checked = false;
                        document.getElementById("from_leave_chk2").checked = false;
                        document.getElementById("to_leave_chk1").checked = false;
                        document.getElementById("to_leave_chk2").checked = false;
                    } else {
                        var sl = 0, cl = 0, el = 0;
                        var check_fdate_tdate = 0;
                        var Difference_In_Time = 0;
                        var Difference_In_Days = 0;
                        var applied_leave = 0;
                        var availabe_leave = 0;
                        var availabe_el_count = 0;
                        let totel_data = [], data, totel = 0;
                        var emp_no, from_date = "";
                        var from_check_val = 0;
                        var to_check_val = 0;
                        emp_no = document.getElementById("emp_no").value;
                        var mydate = new Date(from_date);
                        var from_date_year = mydate.getFullYear();
                        check_fdate_tdate = date_tdate.getTime() - date_fdate.getTime();
                        if ((check_fdate_tdate > 0) || check_fdate_tdate == 0) {

                            sl = document.getElementById("available_sl").value;
                            cl = document.getElementById("available_cl").value;
                            el = document.getElementById("available_el").value;
                            Difference_In_Time = date_tdate.getTime() - date_fdate.getTime();
                            Difference_In_Days = Difference_In_Time / (1000 * 3600 * 24);
                            applied_leave = (Difference_In_Days + 1).toFixed(2);
                            Difference_In_Days = Difference_In_Days + 1;
                            applied_leave = Difference_In_Days;
                            $.ajax({
                                type: "POST",
                                url: "get_leave.jsp",
                                data: {emp_no: emp_no, year: from_date_year, check: "1"},
                                success: function (data) {
                                    totel_data = data.split("&");
                                    availabe_el_count = parseInt(totel_data[0]);


                                    if (applied_leave <= cl || applied_leave <= sl || applied_leave <= el) {

                                        if (applied_leave >= 3 && el >= applied_leave && availabe_el_count < 2) {
                                            $('#leavetype').append(new Option("EL-Earn Leave", '3'));
                                        }
                                        if (applied_leave <= 6 && sl >= applied_leave) {
                                            $('#leavetype').append(new Option("SL-Sick Leave", '2'));
                                        }
                                        if (applied_leave <= 3 && cl >= applied_leave) {
                                            $('#leavetype').append(new Option("CL-Casual Leave", '1'));
                                        }
//                                        if(applied_leave>)
                                        $('#leavetype').append(new Option("LOP-Loss of Pay", '4'));

                                    } else {

                                        $('#leavetype').append(new Option("LOP-Loss of Pay", '4'));
                                        alert("Sorry...! You dont have that much of availabe leave in any category...If you need it consider as a LOP");
                                        applied_leave = "";
                                    }


                                    if ($("#leavetype").val() == '1') {
                                        $("#availabel_leave").val(cl)
                                    }
                                    if ($("#leavetype").val() == '2') {
                                        $("#availabel_leave").val(sl)
                                    }
                                    if ($("#leavetype").val() == '3') {
                                        $("#availabel_leave").val(el)
                                    }

//                        alert("Your leave type" + $("#leavetype").val());
                                    $("#applied_leave").val(applied_leave);
                                }
                            });
                            document.getElementById("from_leave_chk1").disabled = true;
                            document.getElementById("from_leave_chk2").disabled = false;
                            document.getElementById("to_leave_chk1").disabled = false;
                            document.getElementById("to_leave_chk2").disabled = false;
                            if (applied_leave <= 1) {
                                document.getElementById("to_leave_chk1").disabled = true;
                                document.getElementById("to_leave_chk2").disabled = true;
                            }



                        } else {
                            alert("Select From Date And To Date in Right Manner...");
                            $("#from_date").val("");
                            $("#to_date").val("");
                            $("#applied_leave").val("");
                            $("#availabel_leave").val("");
                            document.getElementById("from_leave_chk1").checked = false;
                            document.getElementById("from_leave_chk2").checked = false;
                            document.getElementById("to_leave_chk1").checked = false;
                            document.getElementById("to_leave_chk2").checked = false;
                        }
                    }
                }

            }



            function  leave_type_change() {
                var leave_type = "";
                leave_type = document.getElementById("leavetype").value;
                if (leave_type == "1") {
                    document.getElementById("availabel_leave").value = document.getElementById("available_cl").value;
                } else if (leave_type == "2") {
                    document.getElementById("availabel_leave").value = document.getElementById("available_sl").value;
                } else if (leave_type == "3") {
                    document.getElementById("availabel_leave").value = document.getElementById("available_el").value;
                }
            }



            function  to_date_change_sel() {

                $("#leavetype option[value='1']").remove();
                $("#leavetype option[value='2']").remove();
                $("#leavetype option[value='3']").remove();
                $("#leavetype option[value='4']").remove();
                $("#applied_leave").val("");
                document.getElementById("from_leave_half_div").style.display = "none"
                document.getElementById("to_leave_half_div").style.display = "none"

                if (document.getElementById("from_date").value != "" && document.getElementById("to_date").value != "") {
                    document.getElementById("from_leave_chk1").checked = "checked";
                    var date_fdate = new Date(document.getElementById("from_date").value);
                    var date_tdate = new Date(document.getElementById("to_date").value);
                    var weekday = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
//                    alert(weekday[date_fdate.getDay()]);
                    if (((weekday[date_fdate.getDay()]) == "Sunday") || ((weekday[date_tdate.getDay()]) == "Sunday")) {
                        alert("Sorry...! Sunday not accepted.");
                        $("#from_date").val("");
                        $("#to_date").val("");
                        $("#applied_leave").val("");
                        $("#availabel_leave").val("");
                        document.getElementById("from_leave_chk1").checked = false;
                        document.getElementById("from_leave_chk2").checked = false;
                        document.getElementById("to_leave_chk1").checked = false;
                        document.getElementById("to_leave_chk2").checked = false;
                    } else {

                        var sl = 0, cl = 0, el = 0;
                        var check_fdate_tdate = 0;
                        var Difference_In_Time = 0;
                        var Difference_In_Days = 0;
                        var applied_leave = 0;
                        var availabe_leave = 0;
                        var availabe_el_count = 0;
                        let totel_data = [], data, totel = 0;
                        var emp_no, from_date = "";
                        var from_check_val = 0;
                        var to_check_val = 0;
                        emp_no = document.getElementById("emp_no").value;
                        var mydate = new Date(from_date);
                        var from_date_year = mydate.getFullYear();
                        check_fdate_tdate = date_tdate.getTime() - date_fdate.getTime();
                        if ((check_fdate_tdate > 0) || check_fdate_tdate == 0) {

                            sl = document.getElementById("available_sl").value;
                            cl = document.getElementById("available_cl").value;
                            el = document.getElementById("available_el").value;
//                    alert("SL=" + sl + "|CL" + cl + "|EL" + el);
//if($("#"))

                            Difference_In_Time = date_tdate.getTime() - date_fdate.getTime();
                            Difference_In_Days = Difference_In_Time / (1000 * 3600 * 24);
                            applied_leave = (Difference_In_Days + 1).toFixed(2);
                            Difference_In_Days = Difference_In_Days + 1;
                            applied_leave = Difference_In_Days;
                            $.ajax({
                                type: "POST",
                                url: "get_leave.jsp",
                                data: {emp_no: emp_no, year: from_date_year, check: "1"},
                                success: function (data) {
                                    totel_data = data.split("&");
                                    availabe_el_count = parseInt(totel_data[0]);
                                    if (applied_leave <= cl || applied_leave <= sl || applied_leave <= el) {


                                        if (applied_leave >= 3 && el >= applied_leave && availabe_el_count < 2) {
                                            $('#leavetype').append(new Option("EL-Earn Leave", '3'));
                                        }
                                        if (applied_leave <= 6 && sl >= applied_leave) {
                                            $('#leavetype').append(new Option("SL-Sick Leave", '2'));
                                        }
                                        if (applied_leave <= 3 && cl >= applied_leave) {
                                            $('#leavetype').append(new Option("CL-Casual Leave", '1'));
                                        }
                                        $('#leavetype').append(new Option("LOP-Loss of Pay", '4'));
                                    } else {
                                        $('#leavetype').append(new Option("LOP-Loss of Pay", '4'));
                                        alert("Sorry...! You dont have that much of availabe leave in any category...If you need it consider as a LOP");
//                                 alert("Select From Date And To Date in Right Manner...");
//                                $("#from_date").val("");
//                                $("#to_date").val("");
//                                $("#applied_leave").val("");
//                                $("#availabel_leave").val("");
//                                applied_leave = "";
                                    }


                                    if ($("#leavetype").val() == '1') {
                                        $("#availabel_leave").val(cl)
                                    }
                                    if ($("#leavetype").val() == '2') {
                                        $("#availabel_leave").val(sl)
                                    }
                                    if ($("#leavetype").val() == '3') {
                                        $("#availabel_leave").val(el)
                                    }

                                    $("#applied_leave").val(applied_leave);
                                }
                            });
                            document.getElementById("to_leave_chk1").disabled = true;
                            document.getElementById("to_leave_chk2").disabled = false;
                            document.getElementById("from_leave_chk1").disabled = false;
                            document.getElementById("from_leave_chk2").disabled = false;
                            if (applied_leave <= 1) {
//                                alert(applied_leave);
                                document.getElementById("to_leave_chk1").disabled = true;
                                document.getElementById("to_leave_chk2").disabled = true;
                            }

                        } else {
                            alert("Select From Date And To Date in Right Manner...");
                            $("#from_date").val("");
                            $("#to_date").val("");
                            $("#applied_leave").val("");
                            $("#availabel_leave").val("");
                            document.getElementById("from_leave_chk1").checked = false;
                            document.getElementById("from_leave_chk2").checked = false;
                            document.getElementById("to_leave_chk1").checked = false;
                            document.getElementById("to_leave_chk2").checked = false;
                        }
                    }
                }
            }</script>

        <script src="date_cal/ajax.js"></script>
        <script>
            $(function () {
                var dtToday = new Date();
                var month = dtToday.getMonth() + 1;
                //                                                                var day = '01';
                var year = dtToday.getFullYear();
                if (month < 10)
                    month = '0' + month.toString();
//                alert(month)
//                                                                if (day < 10)
//                                                                    day = '0' + day.toString();
                var minDate = year + '-' + month + '-' + '01';
                $('#from_date').attr('min', minDate);
            });</script>

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
                $('#to_date').attr('min', minDate);
            });</script>

    </head>

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
                String gender = "";
                Date date_of_join = null;

                ResultSet rs = st.executeQuery("select emp_name,parent_name,mobile_number,email,blood_group,dob,designation,"
                        + "department,division,branch,doj,dol,status,door_no,street_name,landmark,village_town,taluk,city,"
                        + "district,state,pin_code,dol_remark,Reporting_To,Gender from employee_master where emp_no='" + user + "' ");
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
                    gender = rs.getString(25);
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
                Double available = 0.0;
                Double check_available = 0.0;
                ResultSet ru = st.executeQuery("select emp_no,leave_type,leave_days,year,avaliable_leave,taken_leave,remark,status,added_by,added_date from leave_master where emp_no='" + user + "' and leave_type='CL' ");
                while (ru.next()) {
                    cl = ru.getString(3);
                    available = ru.getDouble(5);
                }

                if (check_available < 0.0) {
                    available = 0.0;
                }

                String sl = "";
                Double availablesl = 0.0;
                Double check_availablesl = 0.0;
                ResultSet rv = st.executeQuery("select emp_no,leave_type,leave_days,year,avaliable_leave,taken_leave,remark,status,added_by,added_date from leave_master where emp_no='" + user + "' and leave_type='SL' ");
                while (rv.next()) {
                    sl = rv.getString(3);
                    availablesl = rv.getDouble(5);

                }
                if (check_availablesl < 0.0) {
                    availablesl = 0.0;
                }

                String El = "";
                double availableel = 0;
                Double check_availableel = 0.0;
                ResultSet rw = st.executeQuery("select emp_no,leave_type,leave_days,year,avaliable_leave,taken_leave,remark,status,added_by,added_date from leave_master where emp_no='" + user + "' and leave_type='EL' ");
                while (rw.next()) {
                    El = rw.getString(3);
                    availableel = rw.getDouble(5);

                }

//                check_availableel = Double.parseDouble(availableel);
                if (check_availablesl < 0.0) {
                    availableel = 0.0;
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
                                <h1>Leave Request</h1>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="content mt-3">
                    <div class="animated fadeIn">
                        <div class="row"  >
                            <div class="col-lg-6"  >
                                <div class="card" style="border-radius: 10px;">
                                    <div class="card-body" >
                                        <!-- Credit Card -->
                                        <div id="pay-invoice" >
                                            <div class="card-body" >
                                                <div class="card-title">
                                                    <h4 class="text-center" >Apply Leave</h4>
                                                </div>
                                                <hr>
                                                <form action="../Insert_activity/Insert_apply_leave.jsp" method="post">

                                                    <input type="hidden" id="cl" name="cl" value="<%=available%>"/>
                                                    <input type="hidden" id="sl" name="sl" value="<%=availablesl%>"/>
                                                    <input type="hidden" id ="el" name="el" value="<%=availableel%>"/>


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
                                                            <label for="x_card_code" class="control-label mb-1">From Date</label>
                                                            <div class="input-group">
                                                                <input id="from_date" required="" name="from_date" type="date" onclick="from_date_click_sel()" onchange="from_date_change_sel()" class="form-control cc-exp"/>
                                                            </div>
                                                        </div>

                                                        <div class="col-6">
                                                            <label for="x_card_code" class="control-label mb-1">To Date</label>
                                                            <div class="input-group">
                                                                <input id="to_date" name="to_date"  required="" type="date"  onclick="to_date_click_sel()" onchange="to_date_change_sel()"  class="form-control cc-exp">
                                                            </div>
                                                        </div>


                                                    </div>
                                                    <div class="row">
                                                        <div class="col-6">
                                                            <div class="col-6">

                                                                <label for="x_card_code" class="control-label mb-1"> Full Day </label>
                                                                <div class="input-group">
                                                                    <input type="radio" style="margin-left: auto;margin-right: auto;"  onclick="from_leave_chk1_click()" id="from_leave_chk1" name="from_leave" value="fullday"> 
                                                                </div>
                                                            </div>
                                                            <div class="col-6">
                                                                <label for="x_card_code"  class="control-label mb-1"> Half Day </label>
                                                                <div class="input-group">
                                                                    <input type="radio" style="margin-left: auto;margin-right: auto;" onclick="from_leave_chk2_click()"id="from_leave_chk2" name="from_leave"  value="fullday"> 
                                                                </div>
                                                            </div>

                                                        </div>
                                                        <div class="col-6">
                                                            <div class="col-6">
                                                                <label for="x_card_code" class="control-label mb-1">Full Day</label>
                                                                <div class="input-group">
                                                                    <input type="radio" style="margin-left: auto;margin-right: auto;" onclick="to_leave_chk1_click()" id="to_leave_chk1" name="to_leave"  value="tofullday">   
                                                                </div>
                                                            </div>
                                                            <div class="col-6">
                                                                <label for="x_card_code" class="control-label mb-1">Half Day</label>
                                                                <div class="input-group">
                                                                    <input type="radio" style="margin-left: auto;margin-right: auto;" onclick="to_leave_chk2_click()" id="to_leave_chk2" name="to_leave"  value="tohalf_day">   
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>


                                                    <div class="row">
                                                        <div class="col-6">
                                                            <div id="from_leave_half_div" style="display: none;">
                                                                <div class="input-group">
                                                                    <select name="from_half" id="from_half" class="form-control-sm form-control">
                                                                        <option value="1st_half">1st Half</option>
                                                                        <option value="2nd_half">2nd Half</option>
                                                                    </select>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-6">

                                                            <div id="to_leave_half_div" style="display: none;">
                                                                <div class="input-group">
                                                                    <select name="to_half"  class="form-control-sm form-control">
                                                                        <option value="1st_half" id="tohalf">1st Half</option>
                                                                        <!--<option value="2nd_half">2nd Half</option>-->
                                                                    </select>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>



                                                    <div class="row" >
                                                        <div class="col-6">
                                                            <div class="form-group">
                                                                <label for="cc-exp" class="control-label mb-1">Applied Leave</label>
                                                                <input id="applied_leave" readonly="" required="" name="numdays" type="number" step="0.1" class="form-control cc-exp" value="" >
                                                            </div>
                                                        </div>
                                                        <div class="col-6">
                                                            <label for="x_card_code" class="control-label mb-1">Actual Available Leave</label>
                                                            <div class="input-group">
                                                                <input id="availabel_leave" readonly="" name="available"  step="0.1" type="number" class="form-control cc-cvc" value="" data-val="true" data-val-required="Please enter the security code" data-val-cc-cvc="Please entera valid security code" autocomplete="off">

                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-12">
                                                            <label class="form-control-plaintext">Leave Type</label>
                                                            <div class="input-group">
                                                                <select name="leavetype" id="leavetype" class="form-control" onchange="leave_type_change()">
                                                                    <!--                                                                    <option value="0">Please select Leave </option>
                                                                                                                                    <option value="EL">EL-Earned Leave</option>-->
                                                                    <% //if (gender.equals("F")) {%>
                                                                    <!--<option value="ML">ML-Maternity Leave</option>-->
                                                                    <% //}%>
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-12">

                                                            <div class="form-group">
                                                                <label for="cc-payment" >Reason</label>
                                                                <textarea name="reason"
                                                                          rows="5" cols="30"
                                                                          maxlength="200" value="" class="form-control" style="height: 70px"></textarea>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div>
                                                        <button type="submit" id="payment-button" value="Apply"  class="btn btn-lg btn-info btn-block">
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
                                <div class="card" style="border-radius: 10px;">
                                    <div class="card-body">
                                        <div class="stat-widget-one">
                                            <div class="stat-icon dib"><i class="ti-hand-point-right text-danger border-danger"></i></div>
                                            <div class="stat-content dib">
                                                <div class="stat-text">CL</div>
                                                <div class="stat-digit"><%=available%></div>
                                                <input type="hidden" id="available_cl" name="available_cl" value="<%=available%>">
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="card" style="border-radius: 10px;">
                                    <div class="card-body" >
                                        <div class="stat-widget-one">
                                            <div class="stat-icon dib"><i class="ti-hand-point-right text-danger border-danger"></i></div>
                                            <div class="stat-content dib">
                                                <div class="stat-text">SL</div>
                                                <div class="stat-digit"><%=availablesl%></div>
                                                <input type="hidden" id="available_sl" name="available_sl" value="<%=availablesl%>">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="card" style="border-radius: 10px;">
                                    <div class="card-body" >
                                        <div class="stat-widget-one">
                                            <div class="stat-icon dib"><i class="ti-hand-point-right text-success border-success"></i></div>
                                            <div class="stat-content dib">
                                                <div class="stat-text">EL</div>
                                                <div class="stat-digit"><%=availableel%></div>
                                                <input type="hidden" id="available_el" name="available_el" value="<%=availableel%>">
                                            </div>
                                        </div>
                                    </div>
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


            <%
                } catch (Exception e) {
                    out.print(e);
                }

            %>

    </body>
</html>
