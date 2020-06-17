<%-- 
    Document   : makeprf
    Created on : 14 Jul, 2016, 3:41:52 PM
    Author     : Pc294
--%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <LINK REL="SHORTCUT ICON" HREF="/MRO/images/name.ico"/>
        <link rel="stylesheet" href="/MRO/stores/css/makeprf.css">
        <title>Avalon Maintenance</title>
        <script type="text/javascript">
            window.history.forward(1);
            function noBack()
            {
                window.history.forward();
            }
        </script>	
        <script>
            //         <<<<<<<<<<<<<<    Validation Script              >>>>>>>>>>>
            function validateForm()
            {
                var x = document.getElementById("unit").value;
                if (x == null || x == "") {
                    alert("Select Unit");
                    document.getElementById("unit").focus();
                    return false;
                }
                var x = document.getElementById("division").value;
                if (x == null || x == "") {
                    alert("Select Division");
                    document.getElementById("division").focus();
                    return false;
                }
                var x = document.getElementById("required_date").value;
                if (x == null || x == "") {
                    alert("Select Required Date");
                    document.getElementById("required_date").focus();
                    return false;
                }
                var x = document.getElementById("currency").value;
                if (x == null || x == "") {
                    alert("Select Currency");
                    document.getElementById("currency").focus();
                    return false;
                }
                var x = document.getElementById("creator_id").value;
                if (x == null || x == "") {
                    alert("Enter PRF Creator Name ");
                    document.getElementById("creator_id").focus();
                    return false;
                }
                var x = document.getElementById("adrowval").value;
                if (x == "" || x == null) {
                    alert("Add Atleast One Line Item ! ");
                    document.getElementById("addrow").focus();
                    return false;
                }

                var x = document.getElementById("ad_count_row").value;

                for (var i = 1; i <= x; i++) {

                    var pn = document.getElementById("partno" + i).value;
                    if (pn == "" || pn == null) {
//                        alert("Select " + i + " Part Number ! ");
                        document.getElementById("partno" + i).focus();
                        return false;
                    }

                    var qty = document.getElementById("quantity" + i).value;
                    if (qty == "" || qty == null || qty == 0) {
                        alert("Enter " + i + " Quantity ! ");
                        document.getElementById("quantity" + i).focus();
                        return false;
                    }

                    var uom = document.getElementById("uom" + i).value;
                    if (uom == "" || uom == null) {
                        alert("Select " + i + " UOM ! ");
                        document.getElementById("uom" + i).focus();
                        return false;
                    }

                    var unitcost = document.getElementById("unitcost" + i).value;
                    if (unitcost == "" || unitcost == null || unitcost == 0) {
                        alert("Enter " + i + " Unit Cost ! ");
                        document.getElementById("unitcost" + i).focus();
                        return false;
                    }

                    var remark = document.getElementById("uremark" + i).value;
                    if (remark == "" || remark == null) {
                        alert("Enter " + i + " Remark ! ");
                        document.getElementById("uremark" + i).focus();
                        return false;
                    }

                }
            }
        </script>                          

        <!--<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>-->                                               

        <script type="text/javascript" src="js/addrow.js"></script>  <!-- Fetch Data Value -->

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
                            if (rowInd == 0) {
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
                        //alert(val + " " + counter);

                        
						$('#s_no' + val).attr('name', 's_no' + counter);
                        $('#part_des' + val).attr('name', 'part_des' + counter);
                        $('#partno' + val).attr('name', 'partno' + counter);
                        $('#suppliername' + val).attr('name', 'suppliername' + counter);
                        $('#quantity' + val).attr('name', 'quantity' + counter);
                        $('#uom' + val).attr('name', 'uom' + counter);
                        $('#cat' + val).attr('name', 'cat' + counter);
                        $('#unitcost' + val).attr('name', 'unitcost' + counter);
                        $('#oacost' + val).attr('name', 'oacost' + counter);
                        $('#uremark' + val).attr('name', 'uremark' + counter);

                        $('#descriptions' + val).attr('id', 'descriptions' + counter);
                        $('#part_des' + val).attr('id', 'part_des' + counter);
                        $('#partno' + val).attr('id', 'partno' + counter);
                        $('#suppliername' + val).attr('id', 'suppliername' + counter);
                        $('#quantity' + val).attr('id', 'quantity' + counter);
                        $('#uom' + val).attr('id', 'uom' + counter);
                        $('#cat' + val).attr('id', 'cat' + counter);
                        $('#unitcost' + val).attr('id', 'unitcost' + counter);
                        $('#oacost' + val).attr('id', 'oacost' + counter);
                        $('#descriptions' + val).attr('id', 'descriptions' + counter);
                        $('#partnos' + val).attr('id', 'partnos' + counter);
                        $('#suppliernames' + val).attr('id', 'suppliernames' + counter);
                        $('#quantitys' + val).attr('id', 'quantitys' + counter);
                        $('#uoms' + val).attr('id', 'uoms' + counter);
                        $('#cates' + val).attr('id', 'cates' + counter);
                        $('#unitcosts' + val).attr('id', 'unitcosts' + counter);
                        $('#oacosts' + val).attr('id', 'oacosts' + counter);
                        $('#uremarks' + val).attr('id', 'uremarks' + counter);
                        $('#s_nos' + val).attr('id', 's_nos' + counter);
                        $('#s_no' + val).attr('id', 's_no' + counter);

                        $('#s_no' + counter).attr('value', counter);
                        counter++;

                    });

                    overAllcost();
                    totalCost();

                });

                $(".addrow").click(function () {
                    $('#discount').val("0");
                    var rowInd = $('#tBody tr').length - 1;
                    var sup_name = $("#sup").val();
                    rowInd++;
                    // alert(rowInd);
                    tot = rowInd;
                    var markup = "<tr>" +
                            "<input type='hidden' name='rowCount' id='rowCount' value='" + rowInd + "'>" +
                            "<td><div id = 's_nos" + rowInd + "'><input type='text' id='s_no" + rowInd + "' name='s_no" + rowInd + "' class='sno' value='" + rowInd + "' style='color:black;' readonly size='4'></div></td>" +
                            //  "<td><div id = 'descriptions"+rowInd+"'><input type='text' name='description"+rowInd+"' id='description"+rowInd+"' class='des' style='border:none;-webkit-appearance: none;width:250px;'  required ></div></td>"+
                            "<td><div id = 'descriptions" + rowInd + "' style='color:black;'></div></td>" +
                            "<td><div id = 'partnos" + rowInd + "' required=''></div></td>" +
                            "<td><div id = 'suppliernames" + rowInd + "'><input type='text' name='suppliername" + rowInd + "' id='suppliername" + rowInd + "' class='sup' value='" + sup_name + "' readonly style='width: 240px;border:none;text-transform: uppercase;color:black;'></div></td>" +
                            "<td><div id = 'quantitys" + rowInd + "'><input type='text' name='quantity" + rowInd + "' id='quantity" + rowInd + "' class='qua' onkeyup='overAllcost(),totalCost()' onkeypress='return isNumberKey(event)' min='0' value='0' max='1000' style='width:50px;color:black;' oncopy='return false' onpaste='return false'></div></td>" +
                            "<td><div id = 'uoms" + rowInd + "'><select name='uom" + rowInd + "' id='uom" + rowInd + "' class='uom'  style='width: 116px;color: black;border:none;' required ><option></option><option value='EA'>EACH</option><option value='MTR'>METER</option><option value='FT'>FEET</option><option value='SET'>SET</option><option value='LTR'>LITTER</option><option value='KG'>KG</option><option value='BOX'>BOX</option><option value='LOT'>LOT</option><option value='SQF'>SQF</option><option value='SQM'>SQM</option><option value='COIL'>COIL</option></select></div></td>" +
                            "<td><div id = 'cates" + rowInd + "'><select name='cat" + rowInd + "' id='cat" + rowInd + "' class='cats'  style='width: 116px;color: black;border:none;' required ><option></option><option value='Machine'>Machine</option><option value='Utility'>Utility</option><option value='Equipment'>Equipment</option></select></div></td>" +
                            "<td><div id = 'unitcosts" + rowInd + "'><input type='text' name='unitcost" + rowInd + "' id='unitcost" + rowInd + "' class='uni' onkeyup='overAllcost(),totalCost()' onkeypress='return isNumberKey(event)' style='width:70px;color:black;' value='0' oncopy='return false' onpaste='return false'></div></td>" +
                            "<td><div id = 'oacosts" + rowInd + "'><input type='text' name='oacost" + rowInd + "' id='oacost" + rowInd + "' class='oac' readonly style='width:100px;color:black;'></div></td>" +
                            "<td><div id = 'uremarks" + rowInd + "'><input type='text' name='uremark" + rowInd + "' id='uremark" + rowInd + "' class='ure' style='width:110px;text-transform: uppercase;color:black;' required></div></td>" +
                            "<td><div id ='chk" + rowInd + "'><input type='checkbox' id='cbox" + rowInd + "' name='chk' class='chkbox' style='width:20px;'></div></td>" +
                            "</tr>";
                    $("#tBody").append(markup);
                    $("input:hidden#adrowval").val("ROWADD");
                    overAllcost();
                    totalCost();



                    //                $.ajax({                    
                    //                    type: "post",
                    //                    url: "data_vendorname.jsp", //here you can use servlet,jsp, etc
                    //                   // data: "input=" +$('#ip').val()+"&output="+$('#op').val(),
                    //                    success: function(msg){      
                    //                            $("#suppliername"+rowInd+"").html(msg);
                    //                    }
                    //                });





                    $.ajax({
                        type: "post",
                        url: "fetch_mcode.jsp?row=" + rowInd, //here you can use servlet,jsp, etc
                        // data: "input=" +$('#ip').val()+"&output="+$('#op').val(),
                        success: function (msg) {
                            $("#partnos" + rowInd + "").html(msg);
                        }
                    });



//                       $("#partno" + rowInd + "").on('input', function () {
//                           alert("TEST");
//                           var attrName = $(this).attr("id");
//                           alert(attrName);
//                           var device = this.value;
//   //                            alert(device);
//                           for (var i = 1; i <= 40; i++) {
//                               if (attrName == "partno" + i + "") {
//
//                                   //alert("devicename"+i);
//   //                                    alert(attrName);
//                                   // alert(i+" "+rowInd);
//                                   $.ajax({
//                                       type: "post",
//                                       url: "onchange/fetch_part_des.jsp?part_no=" + device + "&id=" + i,
//                                       success: function (msg) {
//
//                                           $("#descriptions" + i + "").html(msg);
//   //                                             alert( $("#descriptions"+i+"").val());
//                                       }
//                                   });
//                                   break;
//                               }
//                           }
//
//                       });





                    $('.datepicker').pickmeup({
                        position: 'center',
                        hide_on_select: true
                    });

                    $('#ad_count_row').val(rowInd);

                });
            });
            //      <<<<<<<<<<<<<<<<<<<<<  Add row table function End   >>>>>>>>>>>>>>>>>>>>>>  
        </script>                         

        <script>
            function Call(row) {


                var partno = document.getElementById("partno" + row).value;
                if (partno == "" || partno == null) {
                    alert("Select Part Number ! ");
                    document.getElementById("uom" + row).value = "";
                    document.getElementById("partno" + row).focus();
                    return  false;
                } else {
                    $.ajax({
                        type: "post",
                        url: "onchange/fetch_part_des.jsp?part_no=" + partno + "&id=" + row,
                        success: function (msg) {

                            $("#descriptions" + row + "").html(msg);
                            //                                             alert( $("#descriptions"+i+"").val());
                        }
                    });
                }



            }
        </script>
        <!--<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>-->          

        <script>
            //       <<<<<<<<<<<<<<<<<<<<<     Overallcost function start         >>>>>>>>>>>>>>>>>>>>>>>>   
            /*  var tot=0;
             var n=0; */

            function overAllcost() {
                //var rowCount =document.getElementById("rowCount").value; 
                //alert("dddd");
                // tot = rowInd;
                //alert(tot+"----");
                for (var i = 1; i <= tot; i++) {
                    var one = document.getElementById("quantity" + i).value;
                    var two = document.getElementById("unitcost" + i).value;
                    var avvy = one * two;
                    n = parseFloat(avvy).toFixed(2);
                    //tot=tot+n;
                    document.getElementById("oacost" + i).value = n;
                    //document.getElementById("totalcost").value= tot;
                }
            }
            function totalCost() {
                //alert("sdaaa");
                //tot=tot+n;
                var twoPlacedFloat = 0;
                var finalTotal = 0;
                for (var i = 1; i <= tot; i++) {
                    finalTotal = finalTotal + parseFloat(document.getElementById("oacost" + i).value);
                    twoPlacedFloat = parseFloat(finalTotal).toFixed(2);
                }
                document.getElementById("totalcost").value = twoPlacedFloat;
                document.getElementById("totco").value = twoPlacedFloat;
                //document.getElementById("totalcost").value= avvy;   
            }
            //       <<<<<<<<<<<<<<<<<<<<<     Overallcost function End         >>>>>>>>>>>>>>>>>>>>>>>>  
        </script>
        <script>
            //       <<<<<<<<<<<<<<<<    onkeypress function  Start    >>>>>>>>>>>>
            function isNumberKey(evt)
            {
                var charCode = (evt.which) ? evt.which : evt.keyCode;
                if (charCode != 46 && charCode > 31
                        && (charCode < 48 || charCode > 57))
                    return false;
                return true;
            }
            //       <<<<<<<<<<<<<<<<    onkeypress function  Start    >>>>>>>>>>>>
        </script>
        <script>
            function isCharacterKey(evt) {
                var inputValue = evt.charCode;
                if (!(inputValue >= 65 && inputValue <= 120) && (inputValue != 32 && inputValue != 0)) {
                    evt.preventDefault();
                }
            }
        </script>
        <script>
            function verifying() {
                var x = document.getElementById("creator_id");
                alert("Onces Verifying Your Inputs after Submit");
            }
        </script>

        <script src="js/onchange_fetch_data.js" type="text/javascript"></script>
        <script type="text/javascript">
            function Unit() {
                var unit = document.getElementById("unit").value;
                //alert(unit);
                $.ajax({
                    type: 'GET',
                    url: 'onchange_fetchdata_makeprf_unit.jsp?',
                    data: 'unit=' + unit,
                    success: function (response) {
                        document.getElementById("division").innerHTML = response;
                    }
                });
            }
        </script>
    </head>
    <body>
        <div id="main">
            <div id="header"><jsp:include page="header.jsp" /></div>
            <%

                HttpSession sessions = request.getSession(true);
                if ((sessions.getAttribute("emp_name") == null) || (sessions.getAttribute("emp_name") == "")) {
                    response.sendRedirect("../index.jsp");
                }

                String sup_name = session.getAttribute("sup_name").toString();//request.getParameter("sup_name");
                String pay="",inco="";
                   String connectionURL = "jdbc:sqlserver://10.44.50.15;databaseName=Maintenance";
                    Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                    Connection con = DriverManager.getConnection(connectionURL, "balaji_sap", "sap123");
                    Statement st = con.createStatement();
                ResultSet tr = st.executeQuery("select payment_terms,inco_terms from vendor_history where vendor_name='"+sup_name+"' ");
                while(tr.next()){
                pay = tr.getString(1);
                inco = tr.getString(2);
                }
                // out.println(sup_name);
            %>
            <div id="content">   
                <input type="hidden" id="ad_count_row" name="ad_count_row" value="">
                <input type="hidden" value="<%=sup_name%>" id="sup">
                <input type="hidden" value="" id="totco">
                <!--<center><img src="/MRO/images/make.png" style="margin-left: 240px;"></center>-->               
                <form name="form2" method="post" action="../insert_makeprf" onsubmit="return validateForm()"><br>   
                    <!--<form name="form2" method="post" action="#" onsubmit="return validateForm()"><br>-->   
                    <!--                            <input type="hidden" name="rowCount" value="" id="rowCount"> dont delete this row-->
                    <div id="scrollTableContainer">                               
                        <div id="tHeadContainer">
                            <!--<center><font style="color: white;font-size: 18px;font-weight:inherit;">Make PRF</font></center>-->

                            <div id="first_content">                                         
                                <table style="width: 1100px;" id="first_table">                        
                                    <tr><td>
                                            Unit:<select name="unit" id="unit" style="border: none;" onchange="Unit(this.value)" required="">
                                                <option></option>
                                                <option value="B7">B7</option>
                                                <option value="B8">B8</option>
                                                <option value="ATS">ATS</option>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            Division:
                                            <select name="division" id="division" style="border: none;" required="">
                                                <!--                     <option></option>
                                                                     <option>PCB</option>
                                                                     <option>CABLE</option>
                                                                     <option>MAGNETIC</option>
                                                                     <option>PLASTICS</option>
                                                                     <option>METAL</option>                     -->
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            Required Date :
                                            <input type="text" name="required_date" id="required_date" size="6" class="datepicker" readonly style="width: 100px;border: none; color: black;" required="">
                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            Currency:<select name="currency" id="currency" style="border: none;" required="">
                                                <option></option>
                                                <option value="INR">INR</option>
                                                <option value="USD">USD</option>
                                                <option value="EUR">EUR</option>
                                                <option value="JPY">JPY</option>
                                                <option value="GBP">GBP</option>
                                            </select>                 
                                        </td></tr> 
                                </table>
                            </div>

                            <!-- <table id="tHead">
                                  
                                <tr class="thclass" style="height: 30px;">                                            
                                     <td>S No</td>
                                     <td>Description</td>
                                     <td>Part No</td>
                                     <td>Supplier Name</td>
                                     <td>Qty</td>
                                     <td>UOM</td>
                                     <td>Unit Cost</td>
                                     <td>Over all Cost</td>
                                     <td>Usage & Remark</td>  
                                     <td>Chk</td>  
                                </tr>
                            </table> -->
                        </div><!-- tHeadContainer -->
                        <div id="tBodyContainer" class="tBodyContainer">

                            <table id="tBody">                    
                                <tr class="thclass" style="height: 30px;color:#020223;">                                            
                                    <td>S No</td>
                                    <td>Description</td>
                                    <td>Part No</td>
                                    <td>Supplier Name</td>
                                    <td>Qty</td>
                                    <td>UOM</td>
                                    <td>Category</td>
                                    <td>Unit Cost</td>
                                    <td>Over all Cost</td>
                                    <td>Usage & Remark</td>  
                                    <!-- <td>Chk</td>   -->
                                </tr>                   

                            </table>   

                        </div><!-- tBodyContainer -->
                    </div><!-- scrollTableContainer -->
                    <input type="hidden" name="adrowval" id="adrowval" value="">
                    <div id="table2">
                        <br>
                        <p style="margin-top: -10px;">
                            <!--PRF Creator Name : <input type="text" id="creator_id" name="creator_name" onkeypress="return isCharacterKey(event)" onblur="verifying()" style="width: 180px;background-color:#020223;font-size: 18px;">-->
                            PRF Creator Name : <input type="text" id="creator_id" name="creator_name" onkeypress="return isCharacterKey(event)"  style="width: 180px;background-color: white;color: #020223;font-size: 14px;border: none;">
                            Discount : <input type="number" name="discount" id="discount" value="0" required="" onkeyup="return disCount(this.value)" style="width: 80px;background-color:white;font-size: 14px;border: none;color: #020223;">
                            <font style="margin-left: 128px;font-size: 20px;">Total Cost :  <input type="text" name="totalcost" id="totalcost" size="12" readonly style="width: 150px;height:25px;font-size: 20px;background-color: rgb(0, 104, 139);border: none;"></font>
                    </div>   

                    <input type="button" class="addrow" id="addrow" value="Add"  style="background-color: white; margin-left: 60px;width: 60px;height:30px;font-weight: bold;color: black;" onclick="Vendor()"/>&nbsp;&nbsp;                             
                    <input type="button"  height="26" id="remove" class="deletebutton" value="Remove"   style="background-color: white;width: 68px;height:30px;font-weight: bold;color: black;"/>&nbsp;&nbsp;                            
                    &nbsp;&nbsp;&nbsp;&nbsp;														<!-- onclick="deleteRow('tBody')" -->
                    <input type="submit" value="Submit" style="background-color: white;width: 60px;height:30px;margin-left:2px;margin-top:10px;font-weight: bold;color: black;" >                                                      
               <%

               %>
                
                </form>                          
            </div>               
        </div>
        <link rel="stylesheet" href="../date/css/pickmeup.css" type="text/css" />
        <link rel="stylesheet" media="screen" type="text/css" href="../date/css/demo.css" />
        <script type="text/javascript" src="../date/js/jquery.js"></script>
        <script type="text/javascript" src="../date/js/jquery.pickmeup.js"></script>
        <script type="text/javascript" src="../date/js/demo.js"></script>


        <script>
                        $(function () {
                            $('.datepicker').pickmeup({
                                position: 'center',
                                hide_on_select: true
                            });
                        });
        </script>
        <script>
            $(document).on('focus', ".datepicke", function () {
                $(this).datepicker();
            });
        </script>

        <script>
            $(document).ready(function () {
                //iterate through each textboxes and add keyup
                //handler to trigger sum event
                $(".txt").each(function () {
                    $(this).keyup(function () {
                        calculateSum();
                    });
                });
            });
            function calculateSum() {

                var sum = 0;
                //iterate through each textboxes and add the values
                $(".txt").each(function () {
                    //add only if the value is number
                    if (!isNaN(this.value) && this.value.length != 0) {
                        sum += parseFloat(this.value);
                    }
                });
                //.toFixed() method will roundoff the final sum to 2 decimal places
                $("#sum").html(sum.toFixed(2));
            }
        </script>

        <script>
            function disCount(val) {
                var totv = document.getElementById("totalcost").value;
                var tov = document.getElementById("totco").value;
                var result = parseFloat(tov) - parseFloat(val);

                if (val == "0" || val == "") {
                    var x = document.getElementById("tBody").rows.length - 1;
                    var z = 0.0;
                    //alert(x);
                    for (var y = 1; y <= x; y++) {
                        var a = document.getElementById("oacost" + y).value;
                        z = z + parseFloat(a);
                    }

                    document.getElementById("totalcost").value = z.toFixed(2);
                } else {
                    document.getElementById("totalcost").value = result.toFixed(2);
                }
                //alert(val);

            }
        </script>


    </body>
</html>
