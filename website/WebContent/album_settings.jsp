<%--
    Document   : index
    Created on : Apr 2, 2010, 1:24:49 PM
    Author     : sen
    Modify     : xiaoxiao Apr 21,2010, 17:00 beijing
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>

<%@page import="logic.IVideo"%>
<%@page import="logic.Video"%>
<%@page import="logic.IUser"%>
<%@page import="logic.IChannel"%>
<%@page import="logic.EntityFactory"%>
<%@page import="utility.Misc"%>
<%@page import="servlet.ServletCommon"%>

<%
            IUser user = ServletCommon.getCurrentUser(session);
            int uid = user.getUserid();
            int aid = Integer.parseInt(request.getParameter("aid"));
            int hostid = Integer.parseInt(request.getParameter("hostid"));
            IChannel album = EntityFactory.getGroup(aid);
            String album_name = album.getName();
            String album_description = album.getDescription();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xml:lang="en" xmlns="http://www.w3.org/1999/xhtml" lang="en" xmlns:v="urn:schemas-microsoft-com:vml" >

    <head>
        <title>爱微视 iweishi</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta http-equiv="imagetoolbar" content="no" />
        <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7,chrome=1"/>
        <meta name="description" content="爱微视是网络视频的集散地" />
        <link rel="stylesheet" type="text/css" media="all" href="CSS/global.css" />
        <link rel="stylesheet" type="text/css" media="all" href="CSS/top_enter.css" />
        <link rel="stylesheet" type="text/css" media="all" href="CSS/settings.css" />
        <link href="CSS/homepage_header_none_enter.css" rel="stylesheet" type="text/css" />
        <link href="CSS/join_login.css" rel="stylesheet" type="text/css" />
        <link href="CSS/Join_Login2.css" rel="stylesheet" type="text/css" />
        <link rel="shortcut icon" href="pic/tablogo_final.png" type="image/x-icon"/>
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js" type="text/javascript"></script>
        <script type="text/javascript" src="colorbox/jquery.colorbox.js"></script>
        <link rel="stylesheet" href="colorbox/colorbox.css" type="text/css" media="screen" />

        <script type="text/javascript">
            var gHostid = <%= hostid %>;
            var gUserid = <%= user.getUserid()%>;
            var gUsername = "<%= user.getName()%>";
        </script>

        <script src="JS/common.js" type="text/javascript"></script>
        <script src="JS/push_frame.js" type="text/javascript"></script>
        <link href="CSS/footer.css" rel="stylesheet" type="text/css">

        <script src="JS/head_last.js" type="text/javascript"></script>
        <script src="JS/album_settings.js" type="text/javascript"></script>
        <!--[if IE 6]><script src="JS/hover.js" type="text/javascript"></script><![endif]-->

    </head>

    <body>
        <div id="outer_wrap">
            <div id="inner_wrap">
                <div id="everything">
                    <% if (user.getUserid() == ServletCommon.nobodyId) {%>
                    <%@include file="jspf/top_menu_nobody.jspf"%>
                    <%} else {%>
                    <%@include file="jspf/top_menu.jspf"%>
                    <%}%>

                    <div id="cap" ><!--[if gte IE 6]><img src="pic/top_cap.png"><![endif]--></div>
                    <div id="main">
                        <div class="album_header">
                            <div class="album" id="header">
                                <h1><a href=<%= "home.jsp?uid=" + uid %> id="settings_title"><%= album_name%></a> / 设置</h1>
                            </div>
                        </div>
                        <div class="columns">

                            <div id="columnA" class="column">

                                <ul class="" id="settings_menu">

                                    <li class="current faux_link" id="info">基本信息</li>
                                    <li class="faux_link delete faux_hover" id="delete">
                                        <strong>×</strong> 删除专辑
                                    </li>
                                </ul>

                                <div id="save_stuff">
                                    <input type="button" value="保存所有设置"  class="dark_blue_button" id="save_btn">
                                    <br/>
                                    <input type="button" value="返回"  class="green_button" id="goto_alb_btn">
                                </div>

                            </div>

                            <div id="columnB" class="column">
                                <div id="menus">
                                    <div id="info_area">
                                        <form id='<%= "aid" + aid %>' class="meta_frm" action="album_rename">
                                            <ul>
                                                <li>
                                                    <h3>专辑名称</h3>
                                                    <input type="text" value=<%= album_name%> name="title" id="title">
                                                </li>
                                                <li>
                                                    <h3>专辑描述</h3>
                                                    <input type="text" value=<%= album_description%> name="descrip" id="descrip">
                                                </li>
                                            </ul>
                                        </form>
                                    </div>   
                                </div>
                            </div>

                            <div id="columnC" class="column">
                                <div class="settings_notes" id="info_notes">
                                    <div class="nippleBox manateeCloud instruction">
                                        <div class="bar">
                                            <h4>专辑设置</h4>	</div>
                                        <div class="nipple"></div>
                                        <div class="content">

                                        </div>
                                    </div>		
                                </div>
                            </div>
                        </div>
                        <div class="clear"></div>
                        <%@include file="jspf/footer.jspf"%>
                    </div>
                </div>
            </div>
        </div>
        <img style="top: -3px;" class="sun"
             src="pic/land_sun.gif"><img
             style="position: fixed;*position: absolute; z-index: 20; top: 45px; right: -60px;*right: 0px;"
             id="cloud"
             src="pic/land_cloud.gif"><img
             style="top: 322px;" id="cloud2"
             src="pic/land_cloud2.gif">
        <div class="mask">
            <%@include file="jspf/loginbox.jspf"%>
        </div>
    </body>
</html>
