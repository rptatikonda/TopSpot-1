<%@page import="topspot.ConnectToCloudSQL"%>
<%@page import="topspot.BuildingTrendDetails"%>
<%@page import="java.util.*"%>
<%@ page import="java.util.List"%>
<%@ page import="java.sql.*"%>
<%@page import="topspot.ValuePieChartHelper"%>
<%@page import="topspot.TopspotBean"%>
<%@ page import="com.topspot.common.Constants" %>
<%@ page import="com.topspot.ConnectionUtil" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html class="sidebar sidebar-discover">
<head>
<style>
.toptobottom {
    width: 0;
    word-wrap: break-word;
    text-align: center;
}
.floatLeft{
    /*float: Left;*/
}
.mar_left_50 {
    margin-left: 50px;
}
.width_71_p {
  /*  width: 72%;*/ 
  float: left;
}
.pad_5 {
    padding: 5px;
    float: left;
}
.pad_7 {
    padding: 7px;
}
.mar_right_3 {
    margin-right: 3px;
}
.mar_left_-3
{
    margin-left: -3px;
}
.shortterm
{
    /*margin-top: 274px;*/
}
#tblLongTerm, #tblShortTerm, #tbl_rt_LongTerm, #tbl_rt_ShortTerm {
    font-size:9px;
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script src="js/components/library/jquery/jquery.min.js?v=v1.0.3-rc2&sv=v0.0.1.1"></script>
    <script src="js/components/library/jquery/jquery-migrate.min.js?v=v1.0.3-rc2&sv=v0.0.1.1"></script>
    <script src="js/components/library/modernizr/modernizr.js?v=v1.0.3-rc2&sv=v0.0.1.1"></script>
    <script src="js/components/plugins/less-js/less.min.js?v=v1.0.3-rc2&sv=v0.0.1.1"></script>
    <script src="js/components/modules/admin/charts/flot/assets/lib/excanvas.js?v=v1.0.3-rc2"></script>
    <script src="js/components/plugins/browser/ie/ie.prototype.polyfill.js?v=v1.0.3-rc2&sv=v0.0.1.1"></script>
    <script>
    
    function selectedBuildingOne(selectedBuidling){
    	$('#buildingOne').text("");
    	$('#buildingOne').text(selectedBuidling);
    	$('#hid_Building1').val(selectedBuidling);
    }
    
    function selectedBuildingTwo(selectedBuidling){
    	$('#buildingTwo').text("");
    	$('#buildingTwo').text(selectedBuidling);
    	$('#hid_Building2').val(selectedBuidling);
    }

    function selectedBuildingThree(selectedBuidling){
    	$('#buildingThree').text("");
    	$('#buildingThree').text(selectedBuidling);
    	$('#hid_Building3').val(selectedBuidling);
    }

    if ( /*@cc_on!@*/ false && document.documentMode === 10)
    {
        document.documentElement.className += ' ie ie10';
    }
    </script>
    
     <link rel="stylesheet" href="css/admin/module.admin.stylesheet-complete.sidebar_type.discover.min.css"/>
    
    <!--dropdown menu-->
    <link rel="stylesheet" href="css/topspot_style.css"/>
    <!--<script src="../assets/components/core/js/jquery-1.2.3.min.js"></script>-->
    <script src="js/components/core/js/menu.js"></script>
    <!--dropdown menu end-->
    
    <!--expand div-->
    <link rel="stylesheet" href="css/style_exp.css"/>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">
    <link rel="stylesheet" type="text/css" href="tcal.css" />
    <!--<script type="text/javascript" src="js/jquery.min.js"></script>-->
    <script type="text/javascript" src="tcal.js"></script> 
    <script src="js/components/core/js/ddaccordion.js"></script>
        <script type="text/javascript" src="https://www.google.com/jsapi"></script>
       <script type="text/javascript">
        //Initialize 2nd demo:
        ddaccordion.init({
            headerclass : "tabContentSec", //Shared CSS class name of headers group
            contentclass : "tabContent_data", //Shared CSS class name of contents group
            revealtype : "click", //Reveal content when user clicks or onmouseover the header? Valid value: "click", "clickgo", or "mouseover"
            mouseoverdelay : 200, //if revealtype="mouseover", set delay in milliseconds before header expands onMouseover
            collapseprev : false, //Collapse previous content (so only one open at any time)? true/false 
            defaultexpanded : [ 0 ], //index of content(s) open by default [0, 1, etc]. [] denotes no content.
            onemustopen : false, //Specify whether at least one header should be open always (so never all headers closed)
            animatedefault : false, //Should contents open by default be animated into view?
            persiststate : true, //persist state of opened contents within browser session?
            toggleclass : [ "closedlanguage", "openlanguage" ], //Two CSS classes to be applied to the header when it's collapsed and expanded, respectively ["class1", "class2"]
            //togglehtml: ["prefix", "<img src='images/plus.png' style='width:18px; height:18px; float:left; margin-top:6px;' /> ", "<img src='images/minus.png' style='width:18px; height:18px; float:left; margin-top:6px;' />  "], //Additional HTML added to the header when it's collapsed and expanded, respectively  ["position", "html1", "html2"] (see docs)
            animatespeed : "fast", //speed of animation: integer in milliseconds (ie: 200), or keywords "fast", "normal", or "slow"
            oninit : function(expandedindices) { //custom code to run when headers have initalized
                //do nothing
            },
            onopenclose : function(header, index, state, isuseractivated) { //custom code to run whenever a header is opened or closed
                //do nothing
            }
        })
    </script>
    <script type='text/javascript' src='js/growthreturnmatrix.js'></script>
</head>


<form action="growthreturnmatrix.jsp" method="post">
   <!-- Main Container Fluid -->
    <div class="container-fluid menu-hidden">
    <!--  Side Menu -->
 		<%@ include file="includes/Menu.jsp" %>
    <!--  Side Menu -->
    
      <!-- Content -->
        <div id="content">
          <%@ include file="includes/header.jsp" %>
            <div class="innerLR">
                <h2 class="margin-none">Analytics &nbsp;<i class="fa fa-fw fa-pencil text-muted"></i>
                </h2>
                <div class="row">
                    <div class="col-md-8" style="width:100%">
                         <div class="subnav">
                            <ul id="nav">
                                <li><select id="ddBuildings"></select></li>
                                </ul>
                       </div>
                        <!-- Widget -->
                        <div class=" widget widget-body-white " style="width:100%; min-height: 578px;">
                        
                            <div class="widget-body innerAll" style="min-height:575px;">
                                <!-- Chart with lines and fill with no points -->
                              <!--  <div id="chart_lines_fill_nopoints_2" class="flotchart-holder"></div>-->
                                <div class="rightBlock">
                                  <div class="loader">
                       				 <img src="img/loader.gif">
              				      </div>
								  <div class="wrapper" id="dataContainer">
                        <div style="float:left; width:100%;">
                            <div class="floatLeft">
                                <label>Long Term</label>
                            </div>
                            <div class="floatLeft width_71_p pad_5">
                                <table frame="box" rules="all" cellpadding="3" id="tblLongTerm" >
                                    <tr><th></th><th colspan="9">GROWTH</th></tr>
                                    <tr><td rowspan="12"><div class="toptobottom pad_7 mar_right_3 mar_left_-3">RETURN</div></td><td></td><td>1%</td><td>2%</td><td>3%</td><td>4%</td><td>5%</td><td>6%</td><td>7%</td><td>8%</td></tr>
                                    <tr><td>4%</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
                                    <tr><td>5%</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
                                    <tr><td>6%</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
                                    <tr><td>7%</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
                                    <tr><td>8%</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
                                    <tr><td>9%</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
                                    <tr><td>10%</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
                                    <tr><td>11%</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
                                    <tr><td>12%</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
                                    <tr><td>13%</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
                                    <tr><td>14%</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
                                </table>
                            </div>
                            <div class="floatLeft mar_left_50 pad_5" id="tbl_rt_LongTerm">
                                <table frame="box" rules="all" cellpadding="3">
                                    <tr><td>Average Rent</td><td></td></tr>
                                    <tr><td>Average Price</td><td></td></tr>
                                    <tr><td>Median</td><td></td></tr>
                                    <tr><td>Mode</td><td></td></tr>
                                    <tr><td>stDev</td><td></td></tr>
                                    <tr><td>Varience</td><td></td></tr>
                                    <tr><td>Kurtosis</td><td></td></tr>
                                    <tr><td>Skewness</td><td></td></tr>
                                    <tr><td>Min</td><td></td></tr>
                                    <tr><td>Max</td><td></td></tr>
                                    <tr><td>Sum</td><td></td></tr>
                                    <tr><td>Volume</td><td>2531314.29</td></tr>
                                </table>
                            </div>
                        </div>

                        <div style="margin-top:30px;">
                            <div class="shortterm">
                                <label>Short Term</label>
                            </div>
                           
                            <div class="floatLeft width_71_p pad_5">
                                <table frame="box" rules="all" cellpadding="3" id="tblShortTerm">
                                    <tr><th></th><th colspan="9">GROWTH</th></tr>
                                    <tr><td rowspan="12"><div class="toptobottom pad_7 mar_right_3 mar_left_-3">RETURN</div></td><td></td><td>1%</td><td>2%</td><td>3%</td><td>4%</td><td>5%</td><td>6%</td><td>7%</td><td>8%</td></tr>
                                    <tr><td>4%</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
                                    <tr><td>5%</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
                                    <tr><td>6%</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
                                    <tr><td>7%</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
                                    <tr><td>8%</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
                                    <tr><td>9%</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
                                    <tr><td>10%</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
                                    <tr><td>11%</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
                                    <tr><td>12%</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
                                    <tr><td>13%</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
                                    <tr><td>14%</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
                                </table>
                            </div>
                            <div class="floatLeft mar_left_50 pad_5">
                                <table frame="box" rules="all" cellpadding="3" id="tbl_rt_ShortTerm">
                                    <tr><td>Average Rent</td><td></td></tr>
                                    <tr><td>Average Price</td><td></td></tr>
                                    <tr><td>Median</td><td></td></tr>
                                    <tr><td>Mode</td><td></td></tr>
                                    <tr><td>stDev</td><td></td></tr>
                                    <tr><td>Varience</td><td></td></tr>
                                    <tr><td>Kurtosis</td><td></td></tr>
                                    <tr><td>Skewness</td><td></td></tr>
                                    <tr><td>Min</td><td></td></tr>
                                    <tr><td>Max</td><td></td></tr>
                                    <tr><td>Sum</td><td></td></tr>
                                    <tr><td>Volume</td><td>2531314.29</td></tr>
                                </table>
                            </div>
                        </div>
                    </div>
							 </div>
							 <div style="clear:both;"></div>
                            </div>
                        </div>
                      
                       
                        </div>
                        <!-- // End Widget -->
                    
                    </div>
                  
                </div>
            </div>
        </div>
        <!-- // Content END -->
         <div class="clearfix"></div>
            <!--  Side Menu -->
    <%@ include file="includes/footer.jsp" %>
    <!--  Side Menu -->
       

        
        
         <!-- Global -->
   	 <script data-id="App.Config">
	    var App = {};
	    var basePath = '',
	        commonPath = 'js',
	        rootPath = '/',
	        DEV = false,
	        componentsPath = 'js/components/';
	    var primaryColor = '#3695d5',
	        dangerColor = '#b55151',
	        successColor = '#609450',
	        infoColor = '#4a8bc2',
	        warningColor = '#ab7a4b',
	        inverseColor = '#45484d';
	    var themerPrimaryColor = primaryColor;
    </script>
    	
    <script src="js/components/library/bootstrap/js/bootstrap.min.js?v=v1.0.3-rc2&sv=v0.0.1.1"></script>
    <script src="js/components/plugins/nicescroll/jquery.nicescroll.min.js?v=v1.0.3-rc2&sv=v0.0.1.1"></script>
    <script src="js/components/plugins/breakpoints/breakpoints.js?v=v1.0.3-rc2&sv=v0.0.1.1"></script>
    <script src="js/components/plugins/preload/pace/pace.min.js?v=v1.0.3-rc2&sv=v0.0.1.1"></script>
    <script src="js/components/plugins/preload/pace/preload.pace.init.js?v=v1.0.3-rc2&sv=v0.0.1.1"></script>
    <script src="js/components/core/js/animations.init.js?v=v1.0.3-rc2"></script>
    <script src="js/components/modules/admin/charts/flot/assets/lib/jquery.flot.js?v=v1.0.3-rc2"></script>
    <script src="js/components/modules/admin/charts/flot/assets/lib/jquery.flot.resize.js?v=v1.0.3-rc2"></script>
    <script src="js/components/modules/admin/charts/flot/assets/lib/plugins/jquery.flot.tooltip.min.js?v=v1.0.3-rc2"></script>
    <script src="js/components/modules/admin/charts/flot/assets/custom/js/flotcharts.common.js?v=v1.0.3-rc2"></script>
    <script src="js/components/modules/admin/charts/flot/assets/custom/js/flotchart-line-2.init.js?v=v1.0.3-rc2"></script>
    <script src="js/components/modules/admin/charts/flot/assets/custom/js/flotchart-mixed-1.init.js?v=v1.0.3-rc2"></script>
    <script src="js/components/modules/admin/charts/flot/assets/custom/js/flotchart-bars-horizontal.init.js?v=v1.0.3-rc2"></script>
    <script src="js/components/modules/admin/charts/easy-pie/assets/lib/js/jquery.easy-pie-chart.js?v=v1.0.3-rc2"></script>
    <script src="js/components/modules/admin/charts/easy-pie/assets/custom/easy-pie.init.js?v=v1.0.3-rc2"></script>
    <script src="js/components/modules/admin/charts/sparkline/jquery.sparkline.min.js?v=v1.0.3-rc2"></script>
    <script src="js/components/modules/admin/charts/sparkline/sparkline.init.js?v=v1.0.3-rc2"></script>
    <script src="js/components/modules/admin/maps/vector/assets/lib/jquery-jvectormap-1.2.2.min.js?v=v1.0.3-rc2&sv=v0.0.1.1"></script>
    <script src="js/components/modules/admin/maps/vector/assets/lib/maps/jquery-jvectormap-world-mill-en.js?v=v1.0.3-rc2&sv=v0.0.1.1"></script>
    <script src="js/components/modules/admin/maps/vector/assets/custom/maps-vector.world-map-markers.init.js?v=v1.0.3-rc2&sv=v0.0.1.1"></script>
    <script src="js/components/core/js/sidebar.main.init.js?v=v1.0.3-rc2"></script>
    <script src="js/components/core/js/sidebar.discover.init.js?v=v1.0.3-rc2"></script>
    <script src="js/components/core/js/core.init.js?v=v1.0.3-rc2"></script>
</form>

</html>