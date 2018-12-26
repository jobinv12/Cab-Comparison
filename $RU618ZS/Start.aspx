<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Start.aspx.vb" Inherits="Start" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <style type="text/css">
       
        {
            font-family: Cambria;
            font-size: 35pt;
            color: HighlightText;
            width: 56pt;
        }
        .style1
        {
            width: 333px;
        }
        #Button1
        {
        }
        </style>
    
 </head>
<body>
    <form id="form1" runat="server">
    <asp:Panel ID="Panel1" runat="server">
    </asp:Panel>
<script type="text/javascript" src="http://maps.google.com/maps/api/js?key=AIzaSyBDi89JWuQWOxH-tx6Mvdq53qcBmrpZoFA&libraries=places&sensor=false"></script>

<script type="text/javascript">
    var source, destination;
    var directionsDisplay;
//    var directionsService = new google.maps.DirectionsService();
//    google.maps.event.addDomListener(window, 'load', function () {
//        new google.maps.places.SearchBox(document.getElementById('txtSource'));
//        new google.maps.places.SearchBox(documen.getElementById('txtDestination'));
//        directionsDisplay = new google.maps.DirectionsRenderer({ 'draggable': true });
//    });
    //    function initMap() {
    //      var map = new google.maps.Map(document.getElementById('map'), {
    //center: { lat: -34.397, lng: 150.644 },
    //              zoom: 6
    //        });
    //      var infoWindow = new google.maps.InfoWindow({ map: map });
    // Try HTML5 geolocation.
    //    if (navigator.geolocation) {
    //      navigator.geolocation.getCurrentPosition(function (position) {
    //        var pos = {
    //          lat: position.coords.latitude,
    //        lng: position.coords.longitude
    //                    };
    //                    infoWindow.setPosition(pos);
    //                    infoWindow.setContent('Location found.');
    //                    map.setCenter(pos);
    //                }, function () {
    //                    handleLocationError(true, infoWindow, map.getCenter());
    //                });
    //            } else {
    //                // Browser doesn't support Geolocation
    //                handleLocationError(false, infoWindow, map.getCenter());
    //            }
    //        }
    //        function handleLocationError(browserHasGeolocation, infoWindow, pos) {
    //            infoWindow.setPosition(pos);
    //            infoWindow.setContent(browserHasGeolocation ?'Error: The Geolocation service failed.' :'Error: Your browser doesn\'t support geolocation.');
    //        }

    function GetRoute() {
        var bangalore = new google.maps.LatLng(12.9716, 77.5946);
        var mapOptions = {
            zoom: 7,
            center: bangalore 
        };
        map = new google.maps.Map(document.getElementById('dvMap'), mapOptions);
        directionsDisplay.setMap(map);
        directionsDisplay.setPanel(document.getElementById('dvPanel'));

        //*********DIRECTIONS AND ROUTE**********************//
        source = document.getElementById("txtSource").value;
        destination = document.getElementById("txtDestination").value;

        // Instantiate a directions service.
        directionsService = new google.maps.DirectionsService,
        directionsDisplay = new google.maps.DirectionsRenderer({
            map: map
        }),
        markerA = new google.maps.Marker({
            position: source,
            title: "point A",
            label: "A",
            map: map
        }),
        markerB = new google.maps.Marker({
            position: destination,
            title: "point B",
            label: "B",
            map: map
        });


        var request = {
            origin: source,
            destination: destination,
            travelMode: google.maps.TravelMode.DRIVING
        };
        directionsService.route(request, function (response, status) {
            if (status == google.maps.DirectionsStatus.OK) {
                directionsDisplay.setDirections(response);
            } else {
                window.alert('Directions request failed due to ' + status);
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
                dvDistance.innerHTML = "";
                dvDistance.innerHTML += "Distance: " + distance + "<br />";
                dvDistance.innerHTML += "Duration:" + duration;

            } else {
                alert("Unable to find the distance via road.");
            }

        });
    }
        

</script>
<script type="text/javascript">
function ola()
{
traveltime = document.getElementById('duration').value;
dist = document.getElementById('distance').value;
 var baseFare;
        var costPerKm1;
        var costPerKm2; //(after 15km for micro)
        var costPerMin;
        var total = 0;


        switch (category) {
            case "Micro":
                baseFare = 40;
                costPerKm1 = 6; //(till 15)
                costPerKm2 = 12; //(after 15km)
                costPerMin = 1;

    //Total Fare = Base Fare + (Cost Per Unit of Time * Total Time taken) + (Cost per Unit of Distance * Total Distance travelled)
    total = baseFare + (costPerMin * totalTime);


    if (totalDistance > 15) {
        total = total + (15 * costPerKm1)
               						+ ((totalDistance - 15) * costPerKm2);
    } else {
        total = total + (totalDistance * costPerKm1);
         }
        
}
</script>
    <table border="0" cellpadding="0" cellspacing="3">
        <tr>
            <td colspan="2" bgcolor="#996633">
                <br />
                LOCATION:&nbsp;&nbsp;&nbsp;
                <input type="text" id="txtSource" value="" style="width: 200px" />&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DESTINATION:&nbsp;&nbsp;&nbsp;
                <input type="text" id="txtDestination" value="" style="width: 200px" />
                <br />
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <input type="button" value="Get Route" onclick="GetRoute()" />
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <div id="dvDistance">
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div id="dvMap" style="width: 500px; height: 500px; background-color:GrayText;">
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                </div>
            </td>
            <td class="style1">
                <div id="dvPanel" 
                    style="width: 500px; height: 500px; clip: rect(auto, auto, 200px, auto);">
                    
                    <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        
                </div>
            </td>
        </tr>
    </table>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    </form>
</body>
</html>

