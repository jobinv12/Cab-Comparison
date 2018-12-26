<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false"
    CodeFile="gmaps.aspx.vb" Inherits="gmaps" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
    <html xmlns="http://www.w3.org/1999/xhtml">
    <title></title>
    <style type="text/css">
       
        {
            font-family: Cambria;
            font-size: 35pt;
            color: HighlightText;
            width: 56pt;
        }
        #Button1
        {
            height: 13px;
            width: 14px;
        }
        .style1
        {
            color:Black;
            width: 561px;
        }
        .style2
        {
            color:Black;
            width: 1173px;
        }
        .style3
        {
            color:Black;
            width: 112px;
        }
        .style4
        {
            color:Black;
            height: 39px;
        }
        .style5
        {
            color:Black;
            width: 230px;
        }
        .style6
        {
            color:Black;
            height: 39px;
            width: 230px;
        }
        .style7
        {
            color:Black;
            width: 230px;
            height: 25px;
        }
        .style8
        {
            color:Black;
            height: 25px;
        }
        .style13
        {
            color:Black;
            width: 230px;
            height: 26px;
        }
        .style14
        {
            color:Black;
            height: 26px;
        }
        .style15
        {
            color: Black;
            width: 112px;
            height: 37px;
        }
        .style16
        {
            color:Black;
            width: 230px;
            height: 37px;
        }
        .style17
        {
            color:Black;
            height: 37px;
        }
        </style>
    </head>
    <body>
                          
        <asp:Panel ID="Panel1" runat="server">
        </asp:Panel>
        <script type="text/javascript" src="http://maps.google.com/maps/api/js?key=AIzaSyBDi89JWuQWOxH-tx6Mvdq53qcBmrpZoFA&libraries=places&sensor=false"></script>
        <script type="text/javascript">

            var source, destination;
            var directionsDisplay;
            var getRouteSuccess = false;
            var directionsService = new google.maps.DirectionsService();
            google.maps.event.addDomListener(window, 'load', function () {
                new google.maps.places.SearchBox(document.getElementById('txtSource'));
                new google.maps.places.SearchBox(document.getElementById('txtDestination'));
                directionsDisplay = new google.maps.DirectionsRenderer({ 'draggable': true });
            });


            function GetRoute() {
                hideTable();
                var distanceAsNo = 0;
                var durationAsNo = 0;
                var bangalore = new google.maps.LatLng(12.58, 77.59);
                var mapOptions = {
                    zoom: 7,
                    center: bangalore
                };
                map = new google.maps.Map(document.getElementById('dvMap'), mapOptions);
                directionsDisplay.setMap(map);


                //*********DIRECTIONS AND ROUTE**********************//
                source = document.getElementById("txtSource").value;
                destination = document.getElementById("txtDestination").value;

                // Instantiate a directions service.
                  if (directionsDisplay != null) {
                    directionsDisplay.setMap(null);
                 directionsDisplay = null;
                             }

                   directionsService = new google.maps.DirectionsService();

                directionsDisplay = new google.maps.DirectionsRenderer({
                    map: map
                });


                var request = {
                    origin: source,
                    destination: destination,
                    travelMode: google.maps.TravelMode.DRIVING
                };
                directionsService.route(request, function (response, status) {
                    if (status == google.maps.DirectionsStatus.OK) {
                        getRouteSuccess = true;
                        document.getElementById("compareFaresBtn").disabled = false;
                        directionsDisplay.setDirections(response);
                    } else {
                        getRouteSuccess = false;
                        document.getElementById("compareFaresBtn").disabled = true;
                        window.alert('Directions request failed due to ' + status + '.Please Enter A Valid Source And Destination'  );
                    }
                });



                //*********DISTANCE AND DURATION**********************//
                var service = new google.maps.DistanceMatrixService();
                service.getDistanceMatrix({
                    origins: [source],
                    destinations: [destination],
                    travelMode: google.maps.TravelMode.DRIVING,
                    unitSystem: google.maps.UnitSystem.METRIC,
                    avoidHighways: false,
                    avoidTolls: false
                }, function (response, status) {
                    if (status == google.maps.DistanceMatrixStatus.OK && response.rows[0].elements[0].status != "ZERO_RESULTS") {
                        var distance = response.rows[0].elements[0].distance.text;
                        var duration = response.rows[0].elements[0].duration.text;
                        var dvDistance = document.getElementById("dvDistance");
                        var dvDuration = document.getElementById("dvDuration");
                        dvDistance.innerHTML = "Distance: " + distance;
                        dvDuration.innerHTML = "Duration: " + duration;
                        durationAsNo = Math.round((response.rows[0].elements[0].duration.value) / 60);
                        
                        document.getElementById("dur").value = durationAsNo;

                        distanceAsNo = (response.rows[0].elements[0].distance.value) / 1000;
                       
                        document.getElementById("dist").value = distanceAsNo;
                    } else {
                        alert("Unable to find the distance via road.");
                    }

                });
            }

            function hideTable() {
                document.getElementById('dvPanel').style.visibility = "hidden";
                
            }

            function CompareFares() {
                                         
                document.getElementById('dvPanel').style.visibility = "visible";
               

                //CABS FARE CALCULATION

                totalDistance = parseInt(document.getElementById('dist').value);
                totalTime = parseInt(document.getElementById('dur').value);
                
                var baseFare;
                var costPerKm1;
                var costPerKm2; //(after 15km only for micro)
                var costPerMin;
                var total = 0;

                //Calculation
                //Total Fare = Base Fare + (Cost Per Unit of Time * Total Time taken) + (Cost per Unit of Distance * Total Distance travelled)

                //OLA_MICRO
                {
                    baseFare = 40;
                    costPerKm1 = 6; //(till 15)
                    costPerKm2 = 12; //(after 15km)
                    costPerMin = 1;

                    total = baseFare + (costPerMin * totalTime);
                    // alert("Initial total: " + total);
                    if (totalDistance > 15) {
                        Micro_total = total + (15 * costPerKm1)
                                       						+ ((totalDistance - 15) * costPerKm2);
                    } else {
                        Micro_total = total + (totalDistance * costPerKm1);

                    }

                    document.getElementById('microTotal').innerHTML = "" + Micro_total;
                }

                //OLA MINI
                {
                    baseFare = 80;
                    costPerKm1 = 10; //(after 4KM)
                    costPerMin = 1;

                    total = baseFare + (costPerMin * totalTime);


                    if (totalDistance > 4) {
                        Mini_total = total + ((totalDistance - 4) * costPerKm1);
                    }
                    document.getElementById('miniTotal').innerHTML = "" + Mini_total;
                }

                //OLA PRIME
                {
                    baseFare = 80;
                    costPerKm1 = 13; //(till 4)
                    costPerMin = 1;

                    total = baseFare + (costPerMin * totalTime);

                    if (totalDistance > 4) {
                        Prime_total = total + (totalDistance * costPerKm1);
                    }
                    document.getElementById('primeTotal').innerHTML = "" + Prime_total;
                }
                //UBER GO
                {
                    baseFare = 35;
                    costPerKm1 = 7; //(till 4)
                    costPerMin = 1;

                    total = baseFare + (costPerMin * totalTime);

                    if (totalDistance > 1) {
                        Go_total = total + (totalDistance * costPerKm1);
                    }
                    document.getElementById('goTotal').innerHTML = "" + Go_total;
                }

                //UBER X
                {
                    baseFare = 40;
                    costPerKm1 = 8; //
                    costPerMin = 1;

                    total = baseFare + (costPerMin * totalTime);
                    if (totalDistance > 0) {
                        X_total = total + (totalDistance * costPerKm1);
                    }
                    document.getElementById('xTotal').innerHTML = "" + X_total;
                }

                // UBER XL
                {
                    baseFare = 80;
                    costPerKm1 = 17; //
                    costPerMin = 1;

                    total = baseFare + (costPerMin * totalTime);

                    if (totalDistance > 0) {
                        XL_total = total + (totalDistance * costPerKm1);
                    }
                    document.getElementById('xlTotal').innerHTML = "" + XL_total;
                }
                //AUTO

                {
                    baseFare = 25;
                    costPerKm1 = 13; //
                    costPerMin = 1;

                    total = baseFare + (costPerMin * totalTime);

                    if (totalDistance > 1.9) {
                        AUTO_total = total + (totalDistance * costPerKm1);
                    }
                    document.getElementById('autoTotal').innerHTML = "" + AUTO_total;
                }
            }
        </script>
        <table border="1" cellpadding="0" cellspacing="3" style="width: 915px" >
            <tr>
                <td bgcolor="#0099FF" class="style2">
                    <br />
                    <b>SOURCE</b>:&nbsp;&nbsp;&nbsp;
                    <input type="text" id="txtSource" value="" style="width: 200px" ;/>&nbsp;&nbsp;&nbsp;
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b>DESTINATION</b>:&nbsp;&nbsp;&nbsp;
                    <input type="text" id="txtDestination" value="" style="width: 200px" />
                    <br />
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <br />
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="button" class="btn" value="Get Route" onclick="GetRoute()"/>
                        <input type="button" id="compareFaresBtn" class="btn" value="Compare Fares" disabled="disabled" onclick="CompareFares('FareChart')"/></td>
            </tr>
		</table>
            <table>
                <tr>
                    <td class="style1">
                        <div id="dvDistance">
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="style1">
                        <div id="dvDuration">
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;</td>
                </tr>
                <tr>
                    <td class="style1">
                        <div id="dvMap" style="width: 500px; height: 500px;">
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        </div>
                    </td>
                    <td>
                        <div id="dvPanel" style="width: 500px; height: 500px; margin-left: 0px; visibility: hidden;">
                           <li type="none" >
                            <table border="1"  style="height: 159px; width: 497px">
                                <th class="style15">
                                  <center>Cabs</center>  
                                </th>
                                <th class="style16">
                                 <center>Category</center>   
                                </th>
                                <th class="style17">
                               <center>Fare</center>     
                                </th>
                                <tr>
                                    <td border="1" rowspan="4" class="style3">
                                    <center>OLA</center>
                                    </td>
                                    <td border="1" class="style5">
                                       <center>MINI</center>
                                    </td>
                                    <td border="1" id="miniTotal" class="style4">
                                    </td>
                                    <tr>
                                        <td border="1" class="style6">
                                          <center>MICRO</center>
                                        </td>
                                        <td border="1" id="microTotal" class="style4">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td border="1" class="style6">
                                         <center>PRIME</center>
                                        </td>
                                        <td border="1" id="primeTotal" class="style8">
                                        </td>
                                    </tr>
                                </tr>
                            </table>
                            </li>
                            <br />
                            <li type="none">
                            <table border="1" style="height: 137px; width: 497px">
                                <tr>
                                    <td border="1" rowspan="3" class="style3">
                                      <center>UBER</center>
                                    </td>
                                    <td  border="1"class="style13">
                                  <center>UBER GO</center>      
                                    </td>
                                    <td border="1" id="goTotal" class="style14">
                                    </td>
                                </tr>
                                <tr>
                                    <td  border="1" class="style13">
                                     <center>UBER X</center> 
                                    </td>
                                    <td border="1" id="xTotal"class="style14">
                                    </td>
                                </tr>
                                <tr>
                                    <td border="1" class="style7">
                                    <center>UBER XL</center>    
                                    </td>
                                    <td border="1" id="xlTotal" class="style8">
                                   
                                    </td>
                                </tr>
                </tr>
                </table>
                </li>      
                          <table border="1"  style="height: 46px; width: 497px; margin-top: 24px;">
                                <tr>
                                    <td  border="1" rowspan="1" class="style3">
                                       <center>AUTO</center> 
                                    </td>
                                    <td border="1" class="style13">
                                  <center>AUTO</center>      
                                    </td>
                                    <td border="1" id="autoTotal" class="style8"></td>
            </table>
            </li>
            <input type="hidden" id="dur" value="" />
            <input type="hidden" id="dist" value="" />
            </div> </td> </tr>
        </table>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    </body>
    </html>
</asp:Content>
