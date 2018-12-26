<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="_Default" %>

<asp:Content ID="HeaderContent" ContentPlaceHolderID="Head" runat="server">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">

    <table>
    <tr>
    <td>
    <asp:Timer ID="Timer1" Interval="2000" runat="server">
    </asp:Timer>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="Timer1" EventName="Tick" />
        </Triggers>
        <ContentTemplate>
            <asp:AdRotator ID="AdRotator1" runat="server" Height="400px" Width="800px" ToolTip="Go-Fare"
                Target="_self" AdvertisementFile="~/Advertisements.xml" />
        </ContentTemplate>
    </asp:UpdatePanel>
    </td>
    <td>
        <b><h1>How much does a Cab cost? Which Cab service is right for me?</h1></b>
    <h2>Go-Fare calculates the cost of your Ola and Uber ride in bangalore city.</h2><h2> Simply enter your pickup and dropoff locations to get the price estimate of a variety of Ola and Uber Cab services available in your area.</h2></p>
   </td>
   </tr>
    </table>
 </asp:Content>
