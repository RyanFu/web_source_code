<%--
    Document   : user_index.jsp
    Created on : 2010-4-30, 19:25:29
    Author     : xiaoxiao
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>

<%@page import="logic.IVideo"%>
<%@page import="logic.IUser"%>
<%@page import="logic.IChannel"%>
<%@page import="logic.Video"%>
<%@page import="logic.User"%>
<%@page import="logic.EntityFactory"%>
<%@page import="logic.datatype.JoinChannelEvent"%>

<%@page import="utility.Misc"%>
<%@page import="servlet.ServletCommon"%>
<%@page import="servlet.WebpageLayoutParam"%>

<%
            IUser user = ServletCommon.getCurrentUser(session);

            if (user.getUserid() == ServletCommon.nobodyId) {
                response.sendRedirect("index.jsp");
            }

            String autologin = request.getParameter("autologin");
            if (autologin != null && autologin.equals("on")) {
                ServletCommon.generateAutoLoginCookies(response, session, user);
            }
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xml:lang="en" xmlns="http://www.w3.org/1999/xhtml" lang="en" xmlns:v="urn:schemas-microsoft-com:vml" xmlns:xn="http:///www.renren.com/2009/xnml">

    <head>
        <title>爱微视 iweishi</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta http-equiv="imagetoolbar" content="no" />
        <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7,chrome=1"/>
        <meta name="description" content="爱微视是视频集散地..." />
        <link rel="stylesheet" type="text/css" media="all" href="CSS/global.css" />
        <link rel="stylesheet" type="text/css" media="all" href="CSS/top_enter.css" />
        <link href="CSS/Left_push_video.css" rel="stylesheet" type="text/css" />
        <link href="CSS/homepage_header_enter.css" rel="stylesheet" type="text/css" />
        <link href="CSS/tabs.css" rel="stylesheet" type="text/css" />
        <link href="CSS/help_banner.css" rel="stylesheet" type="text/css" />
        <link href="CSS/videos_hot.css" rel="stylesheet" type="text/css" />
        <link href="CSS/activity.css" rel="stylesheet" type="text/css" />
        <link href="CSS/top10videos.css" rel="stylesheet" type="text/css" />
        <link href="CSS/footer.css" rel="stylesheet" type="text/css"/>
        <link href="CSS/createAlbum.css" rel="stylesheet" type="text/css" />

        <link rel="shortcut icon" href="pic/tablogo_final.png" type="image/x-icon"/>
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js" type="text/javascript"></script>
        <script src="JS/jquery_plugins.js" type="text/javascript"></script>
        <script src="jquery_plugins/jquery.text-overflow.min.js" type="text/javascript"></script>
        <script type="text/javascript" src="colorbox/jquery.colorbox.js"></script>
        <link rel="stylesheet" href="colorbox/colorbox.css" type="text/css" media="screen" />

        <script type="text/javascript">
            var page_type = "user_index.jsp";
            var gUserid = <%= user.getUserid()%>;
            var gUsername = "<%= user.getName()%>";
        </script>
        <script src="JS/common.js" type="text/javascript"></script>
        <script src="JS/videolist.js" type="text/javascript"></script>
        <script src="JS/tab.js" type="text/javascript"></script>
        <script src="JS/push_frame.js" type="text/javascript"></script>
        <script src="JS/ignite.js" type="text/javascript"></script>
        <link href="CSS/ignite.css" rel="stylesheet" type="text/css" />

        <script src="JS/head_last.js" type="text/javascript"></script>
    </head>

    <body>
        <div id="outer_wrap">
            <div id="inner_wrap">
                <div id="everything">

                    <%@include file="jspf/top_menu.jspf"%>
                    <div id="cap" ><!--[if gte IE 6]><img src="pic/top_cap.png"><![endif]--></div>
                    <div id="main">
                        <!-- <iframe src="Iframe_homepage_header_enter.jsp" frameborder="0" style="position:relative;z-index:2;height:80px;width: 980px;"></iframe>
                        -->
                        <div id="header" >
                            <h1>欢迎回来, <strong><%= user.getName()%></strong></h1>
                            <div id="intro">
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;爱微视是网络视频的集散地，在这里你可以收藏和发现众多视频分享网站上的视频，在这里你也可以制作视频专辑并分享到众多社区网站，在这里你还可以通过视频结识志同道合的朋友！此外为了更好地服务用户，我们希望占用你一点点时间以获得你珍贵的<a target="_blank" rel="nofollow" href="http://www.askform.cn/96374-126152.aspx">用户体验</a>。

                            </div>
                        </div>

                        <div class="columns">
                            <div class="column" id="columnA">
                                <div style="height: 20px;"></div>

                                <%@include file="jspf/push_frame.jspf"%>
                                <div  style="height: 20px;"></div>
                                <div class="tabs">
                                    <ul>
                                        <li id="hot_tab">
                                            <!--[if gte IE 6]><div class="tableft"><div class="tableft_tl"></div><div class="tableft_bottom"></div></div><![endif]-->

                                            <div  class="tab">微视箱</div>
                                            <!--[if gte IE 6]> <div class="tabright"><div class="tabright_tr"></div><div class="tabright_bottom"></div></div><div class="clear"></div><![endif]-->
                                        </li>
                                        <li id="new_tab">
                                            <!--[if gte IE 6]>  <div class="tableft"><div class="tableft_tl"></div><div class="tableft_bottom"></div></div><![endif]-->
                                            <div  class="tab"  > 最新收藏</div>
                                            <!--[if gte IE 6]> <div class="tabright"><div class="tabright_tr"></div><div class="tabright_bottom"></div></div><div class="clear"></div>
                                             <![endif]--></li>
                                        <li id="activity_tab">
                                            <!--[if gte IE 6]><div class="tableft"><div class="tableft_tl"></div><div class="tableft_bottom"></div></div><![endif]-->
                                            <div  class="tab" > 友邻动态</div>
                                            <!--[if gte IE 6]><div class="tabright"><div class="tabright_tr"></div><div class="tabright_bottom"></div></div><div class="clear"></div><![endif]-->
                                        </li>

                                        <li id="newAlbumTab" class="active">
                                            <!--[if gte IE 6]><div class="tableft"><div class="tableft_tl"></div><div class="tableft_bottom"></div></div><![endif]-->
                                            <div  class="tab" > 火热活动</div>
                                            <!--[if gte IE 6]><div class="tabright"><div class="tabright_tr"></div><div class="tabright_bottom"></div></div><div class="clear"></div><![endif]-->
                                        </li>

                                    </ul>

                                    <div class="clear"></div>
                                </div>

                                <!--[if gte IE 6]><div class="wrappertop"><div class="wrappertop_tr"><img src="pic/wraproundedcorners_tr.png"/></div><div class="clear"></div></div><![endif]-->

                                <div id="content_wrapper" class="softcorner native">

                                    <div  id="loading" class="videoContentLoading mask">
                                        加载中......
                                    </div>
                                    <div id="video_hotlist" class="videos_content mask">
                                        <!--[if gte IE 6]><div class="video_meat_top"><div class="video_meat_top_tl"></div><div class="video_meat_top_tr"></div><div class="video_meat_tm"></div></div><![endif]-->
                                        <div class="videos_meat">
                                            <div class="clips">
                                                <div style="background-color: rgb(242, 245, 195); -moz-border-radius: 10px 10px 10px 10px;" class="softcorner native obiwan">
                                                    <div class="nipple"></div>
                                                    <div class="myonlyhope vimeo">
                                                        <div class="title">嗨，在这里你可以发现众多你喜欢的火热视频！</div>
                                                        <p>微视箱有每天更新的全网最火视频以及爱微视给你的量身推荐。还在犹豫什么，爱它就看吧！</p>
                                                        <div class="undertaker">×</div>
                                                    </div>
                                                </div>
                                                <a id="more_hot" class="next" href="#nogo">更多</a>
                                            </div>
                                        </div>
                                        <!--[if gte IE 6]> <div class="video_meat_bottom"><div class="video_meat_bottom_bl"><img src="pic/blvideocontentroundedcorners.png" /></div><div class="video_meat_bottom_br"></div><div class="video_meat_bottom_bm"></div></div><![endif]-->
                                    </div>
                                    <div id="video_newlist" class="videos_content mask">
                                        <!--[if gte IE 6]><div class="video_meat_top"><div class="video_meat_top_tl"></div><div class="video_meat_top_tr"></div><div class="video_meat_tm"></div></div><![endif]-->
                                        <div class="videos_meat">
                                            <div class="clips">
                                                <div style="background-color: rgb(242, 245, 195); -moz-border-radius: 10px 10px 10px 10px;" class="softcorner native obiwan">
                                                    <div class="nipple"></div>
                                                    <div class="myonlyhope vimeo">
                                                        <div class="title">嗨，在这里你可以发现众多好看的最新视频！</div>
                                                        <p>这里有每天实时更新的全网最新视频。跟随潮流，看大家都在关注什么，永远不OUT！</p>
                                                        <div class="undertaker">×</div>
                                                    </div>
                                                </div>
                                                <a id="more_new" class="next" href="#nogo">更多</a>
                                            </div>
                                        </div>
                                        <!--[if gte IE 6]> <div class="video_meat_bottom"><div class="video_meat_bottom_bl"><img src="pic/blvideocontentroundedcorners.png" /></div><div class="video_meat_bottom_br"></div><div class="video_meat_bottom_bm"></div></div><![endif]-->
                                    </div>
                                    <div id="my_activity" class="activity_content softcorner native activity_bubble mask" >
                                        <!--[if gte IE 6]><div class="video_meat_top"><div class="video_meat_top_tl"></div><div class="video_meat_top_tr"></div><div class="video_meat_tm"></div></div><![endif]-->
                                        <div id="my_activity_insides" class="activity_content_insides">
                                            <div class="activity">
                                            </div>
                                            <a id="more_my_activity" class="activity_next" href="#nogo">更多</a>
                                            <div class="clear"></div>
                                        </div>
                                        <!--[if gte IE 6]> <div class="video_meat_bottom"><div class="video_meat_bottom_bl"><img src="pic/blvideocontentroundedcorners.png" /></div><div class="video_meat_bottom_br"></div><div class="video_meat_bottom_bm"></div></div><![endif]-->
                                    </div>

                                    <div id="albumNewlist" class="albumContent">
                                        <!--[if gte IE 6]><div class="video_meat_top"><div class="video_meat_top_tl"></div><div class="video_meat_top_tr"></div><div class="video_meat_tm"></div></div><![endif]-->
                                        <div class="albumMeat">
                                            <div class="clips">
                                                <div style="background-color: rgb(242, 245, 195); -moz-border-radius: 10px 10px 10px 10px;" class="softcorner native obiwan">
                                                    <div class="nipple"></div>
                                                    <div class="myonlyhope vimeo">
                                                        <div class="title">嗨，看看爱微视最近的火热专题！</div>
                                                        <p>有更潮更in的活动主题？联系<a href="mailto:iweishi2010@gmail.com?Subject=Topic%20Idea">爱微视</a>，自己做主角~</p>
                                                        <div class="undertaker">×</div>
                                                    </div>
                                                </div>
                                                <jsp:include page="jspf/newAlbumlist.jsp" />
                                            </div>
                                        </div>
                                        <!--[if gte IE 6]> <div class="video_meat_bottom"><div class="video_meat_bottom_bl"><img src="pic/blvideocontentroundedcorners.png" /></div><div class="video_meat_bottom_br"></div><div class="video_meat_bottom_bm"></div></div><![endif]-->
                                    </div>
                                </div>
                                <!--[if gte IE 6]> <div class="wrapper_bottom"><div class="wrpper_bottom_bl"></div><div class="wrapper_bottom_br"></div><div class="wrapper_bottom_bm"></div><div class="clear"></div></div><![endif]-->

                            </div>
                            <jsp:include page="jspf/user_index_columnB.jsp" />
                            <div class="clear"></div>
                        </div>
                        <%@include file="jspf/footer.jspf"%>
                    </div>

                </div>
            </div>
        </div>

        <img style="top: -3px;" class="sun"
             src="pic/land_sun.gif"/><img
             style="position: fixed;*position: absolute; z-index: 20; top: 45px; right: -60px;*right: 0px;"
             id="cloud"
             src="pic/land_cloud.gif"/><img
             style="top: 322px;" id="cloud2"
             src="pic/land_cloud2.gif"/>
        <div class="mask">
            <%@include file="jspf/ignite.jspf"%>

            <%@include file="jspf/create_album.jspf"%>
        </div>

        <script type="text/javascript" src="http://static.connect.renren.com/js/v1.0/FeatureLoader.jsp"></script>
        <script type="text/javascript">
            XN_RequireFeatures(["EXNML"], function()
            {
                XN.Main.init("16356ddc758343a39400837e79f1a18e", "/xd_receiver.html");
            });
        </script>

    </body>
</html>
