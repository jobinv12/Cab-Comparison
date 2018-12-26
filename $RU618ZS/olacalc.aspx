<%@ Page Language="VB" AutoEventWireup="false" CodeFile="olacalc.aspx.vb" Inherits="olacalc" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
 
<h1>Fare Calculator  </h1>

  <br />
  Distance: <input type=text id="distance" value="3.9">
  <br />
  Time: <input type=text id="time" value="15">
  <br /> <br />

	Click on Category:
	<br /><br />
	<div onClick="ola_estimator('Micro');" style="background-color:yellow">
    Micro
  </div>
  <div onClick="ola_estimator('Mini');" style="background-color:white">
    Mini
  </div>
  <div onClick="ola_estimator('Prime');" style="background-color:yellow">
    Prime
  </div>
  <div onClick="ola_estimator('Lux');" style="background-color:white">
    Lux
  </div>
<script>
    function ola_estimator(category) {

        totalTime = document.getElementById('time').value;
        totalDistance = document.getElementById('distance').value;
        //check if above parameters are non negative values and are numbers only 

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

           

                //Calculation
                //Total Fare = Base Fare + (Cost Per Unit of Time * Total Time taken) + (Cost per Unit of Distance * Total Distance travelled)


                total = baseFare + (costPerMin * totalTime);


                if (totalDistance > 15) {
                    total = total + (15 * costPerKm1)
               						+ ((totalDistance - 15) * costPerKm2);
                } else {
                    total = total + (totalDistance * costPerKm1);

                }

                break;
            case "Mini":
                //code block
                baseFare = 80;
                costPerKm1 = 1; //(till 4)
                costPerKm2 = 10; //(after 4km)
                costPerMin = 1;

                //Calculation
                //Total Fare = Base Fare + (Cost Per Unit of Time * Total Time taken) + (Cost per Unit of Distance * Total Distance travelled)


                total = baseFare + (costPerMin * totalTime);


                if (totalDistance > 4) {
                    total = total + (4 * costPerKm1)
               						+ ((totalDistance - 4) * costPerKm2);
                } 
                }
                break;

            case "Prime":
                //code block
                baseFare = 80;
                costPerKm1 = 1; //(till 4)
                costPerKm2 = 13; //(after 4km)
                costPerMin = 1;

                //Calculation
                //Total Fare = Base Fare + (Cost Per Unit of Time * Total Time taken) + (Cost per Unit of Distance * Total Distance travelled)


                total = baseFare + (costPerMin * totalTime);


                if (totalDistance > 4) {
                    total = total + (4 * costPerKm1)
               						+ ((totalDistance - 4) * costPerKm2);
                } else {
                    total = total + (totalDistance * costPerKm1);

                }
                break;

            case "Lux":
                //code block
                break;

            default:
                //code block
        }


        alert("" + category + " Total Fare: " + total);

    }

</script>
</p>
    </div>
    </form>
</body>
</html>
