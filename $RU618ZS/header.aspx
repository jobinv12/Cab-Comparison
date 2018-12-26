<%@ Page Language="VB" AutoEventWireup="false" CodeFile="header.aspx.vb" Inherits="header" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
 
</head>
<style>
    ul {
    list-style-type: none;
    margin: 0px;
    padding:0px;
	overflow:hidden;
    background-color: grey;
	position: fixed;
	top:12px;
	width:76%;
        left: 24px;
        height: 33px;
    }

li {
padding:5px 20px 5px 20px;
  display:inline-block;
    float:left;
        width: 155px;
    }
li g
{
    color:Navy;
    text-align: center;
    font-size: 20px;
    text-decoration: blink;
    background-color: Lime;
    }

li a {
    color: black;
    text-align: center;
    padding: 14px 16px;
    text-decoration: none;
}
li a.active{
background-color:green;
color:white;
}

li a:hover:not(.active) {
    background-color: red;
	color:white;
}
    </style>
<body>
<script type="text/JavaScript">
  
</script>
</body>

<ul>
<script type="text/javascript">
    var step = 0
    var arr = new Array("ola%20logo.png", "uber%20logo.jpg", "auto.jpg")
    function slideimage() {
        if (!document.images)
            return
        document.images.nil.src = arr[step]
        if (step < 2)
            step++
        else
            step = 0
        setTimeout("slideimage()", 300)
    }
    slideimage()
    </script>
<li><g href="#GO">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; G0-FARE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </g></li>
  <li><a class="active" href="start.aspx">Home</a></li>
  <li><a href="#AboutUS">About Us</a></li>
</ul>

    <div style="margin-bottom:25%;padding:40px 16px;height:1000px;" >

        <img alt="" name="img" style="height: 498px; width:1136px;" src="prj1.png" /><br /><br />
    <script type="text/javascript">
        var step = 0
        var arr = new Array("prj1.png", "prj2.png", "prj3.png")
        function slideimage() {
            if (!document.images)
                return
            document.images.img.src = arr[step]
            if (step < 2)
                step++
            else
                step = 0
            setTimeout("slideimage()", 1000)
        }
        slideimage()
    </script>
    </div>
</body>
</html>
