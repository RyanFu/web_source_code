<%--
    Document   : index
    Created on : Apr 2, 2010, 1:24:49 PM
    Author     : sen
    Modify     : xiaoxiao Apr 21,2010, 17:00 beijing
--%>

<%@page import="java.util.Random"%>
<%@page import="utility.Misc"%>
<%@page import="logic.datatype.SubmitEvent"%>
<%@page import="servlet.ServletCommon"%>
<%@page import="logic.IUser"%>
<%@page import="logic.datatype.CollectEvent"%>
<%@page import="java.util.List"%>
<%@page import="logic.IVideo"%>
<%@page import="logic.EntityFactory"%>
<%@page import="cms.IndexContentManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
            IUser user = ServletCommon.getCurrentUser(session);
            if (user != ServletCommon.nobody) {
                response.sendRedirect("user_index.jsp");
            }
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xml:lang="en" xmlns="http://www.w3.org/1999/xhtml" lang="en" xmlns:v="urn:schemas-microsoft-com:vml" >

    <head>
        <title>爱微视 iweishi 你的视频私生活</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta http-equiv="imagetoolbar" content="no" />
        <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7,chrome=1"/>
        <meta name="description" content="爱微视 你的视频私生活" />
        <link href="CSS/all.css" rel="stylesheet" type="text/css" />


        <link rel="shortcut icon" href="pic/slogo.png" type="image/x-icon"/>

        <!--<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
        <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js" type="text/javascript"></script>-->
        <script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.5.1.min.js"></script>
        <script src="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.10/jquery-ui.min.js" type="text/javascript"></script>
        <link href="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.10/themes/cupertino/jquery-ui.css" rel="stylesheet" type="text/css"/>
        <script type="text/javascript" src="colorbox/jquery.colorbox.js"></script>
        <link rel="stylesheet" href="colorbox/colorbox.css" type="text/css" media="screen" />

        <!-- sina weibo connect -->
        <script type="text/javascript" src="http://js.wcdn.cn/t3/platform/js/api/wb.js" charset="utf-8"></script>
        <link type="text/css" rel="stylesheet" href="http://js.wcdn.cn/t3/style/css/common/card.css" />

        <script type="text/javascript">
            var user_id = <%= user.getUserid()%>;
            var user_name = "<%= user.getName()%>";
            var user_photo_small = "<%=user.getPhotoSmall()%>"
        </script>
        <script src="js/tools.js" type="text/javascript"></script>
        <script src="js/all.js" type="text/javascript"></script>
    </head>

    <body class="green_background">
        <div id="outer_wrap">
            <div id="inner_wrap">
                <div id="everything">

                    <%@include file="jspf/top_menu_nobody.jspf"%>

                    <div id="main">

                        <div id="header">
                            <div id="loginbox">
                                <div id="login_head">
                                    <div id="nav_login" class="nav">
                                        <a id="login_link" class="active" href="#nogo">登录</a>
                                        <span> |</span>
                                        <a id="join_link"  href="#nogo">注册</a>
                                    </div>
                                </div>
                                <div id="login_body">
                                    <form id="login"  action="../login" method="post">
                                        <label for="login_email">
											登录邮箱
                                        </label>
                                        <div class="rounded_input green_bg">
                                            <input id="login_email" class="" name="email" type="text" value="" />
                                        </div>
                                        <label for="login_password">
											密码
                                        </label>
                                        <div class="rounded_input green_bg">
                                            <input id="login_password" class="" name="password" type="password" />
                                        </div>
                                        <label id="remember_label" for="remember">记住登陆状态</label>
                                        <input id="remember" name="autologin" type="checkbox" />
                                        <a id="forgot_link"	href="#nogo">忘记密码？</a>
                                        <!-- <span id="sina_connect_btn"></span>
                                        -->
                                        <input id="login_button" class="Login_Button" value=""	type="submit" />
                                        <!--
										<div class="renrenConnect">
							            	<div>&nbsp;或使用人人连接登录</div>
							            	<div class="renrenConectButton"><img alt="人人连接" src="pic/connect_light_large.png" /></div>
							            </div>
							       		-->
                                    </form>
                                    <form id="join" class="mask" action="../join" method="post">
                                        <div class="rounded_input red_long_bg"  id="join_email">
                                            <input id="input_email" class="float_left" name="email" type="text" value="登陆邮箱" />
                                            <div class="float_right email_wrong mask">该邮箱已被注册</div>
                                            <div class="clear"></div>
                                        </div>

                                        <div class="rounded_input red_mid_bg"  id="join_password">
                                            <input id="input_password" class="float_left" name="password" value="" type="password" style="display:none"/>
                                            <input id="show_password" class="float_left" name="nouse" value="密码" type="text" style="text-align:right;"/>
                                            <div class="float_right pw_wrong mask">需要6-16字符</div>
                                            <div class="clear"></div>
                                        </div>

                                        <div class="rounded_input red_short_wrong_bg" id="join_invite_code">
                                            <input id="input_invite_code" class="float_left" name="invite_code" type="text" value="邀请码" />
                                            <div class="float_right ic_wrong">"friends"</div>
                                            <div class="clear"></div>
                                        </div>
                                        <input id="tos" checked="checked" type="checkbox" />
                                        <label id="tos_lable" for="tos">
												我已经阅读并同意了
                                            <a href="user_agreement.jsp" target="_blank">用户协议</a>
                                        </label>
                                        <input id="join_button" class="join_Button" value="" type="submit" />
                                    </form>
                                </div>
                            </div>
                            <%
                                        IVideo hv;
                                        IUser hu, hsubmitter;
                                        String verb, ago, ctext;
                                        if (new Random().nextInt() > 0) {
                                            SubmitEvent hf = EntityFactory.getUser(1601).getSubmitedVideo(0, 1).get(0);
                                            hv = EntityFactory.getVideo(hf.getVideoid());
                                            hsubmitter = hu = EntityFactory.getUser(hf.getUserid());
                                            verb = "发现了";
                                            ago = Misc.pastTime(hf.getTime());
                                            ctext = hf.getComment();
                                        } else {
                                            CollectEvent hf = EntityFactory.getUser(1601).getCollectedVideo(0, 1).get(0);
                                            hv = EntityFactory.getVideo(hf.getVideoid());
                                            hu = EntityFactory.getUser(hf.getUserid());
                                            hsubmitter = EntityFactory.getUser(hv.getFirstSubmitUserid());
                                            verb = "收藏了";
                                            ago = Misc.pastTime(hf.getTime());
                                            ctext = hf.getComment();
                                        }
                            %>
                            <div class="head_video" id="head_feed">
                                <div class="head_video_inner">
                                    <div class="left_bar">
                                        <div class="head_photo">
                                            <a href="home.jsp?uid=<%=hu.getUserid()%>">
                                                <img src="<%=hu.getPhotoSmall()%>" />
                                            </a>
                                        </div>
                                    </div>
                                    <div class="video_content">
                                        <div class="title">
                                            <a href="home.jsp?uid=1601" class="user_name"><%=hu.getName()%></a>
                                            <span class="act"><%=verb%></span>
                                            <a href="#nogo" class="album_name mask"></a>
                                            <span class="time float_right"><%=ago%>前</span>
                                            <div class="clear"></div>
                                        </div>
                                        <div class="detailwrap">
                                            <div class="collect_text"><%=ctext%></div>
                                            <div class="detail">
                                                <div class="video_pic">
                                                    <a href="video.jsp?vid=<%=hv.getVideoid()%>" target="_blank">
                                                        <img width="120px" height="90px" src="<%=hv.getSnapshotURL()%>" alt="video pic"/>
                                                    </a>
                                                </div>
                                                <div class="video_des">
                                                    <div class="videos_info">
                                                        <div class="vtitle">
                                                            <a href="video.jsp?vid=<%=hv.getVideoid()%>" target="_blank" class="video_name"><%=hv.getTitle()%></a>
                                                        </div>
                                                        <div>
                                                            <span>发现者</span>
                                                            <a href="home.jsp?uid=<%=hsubmitter.getUserid()%>" class="submitter"><%=hsubmitter.getName()%></a>
                                                            <span class="submit_time">&nbsp;<%=hv.getTime()%></span>
                                                        </div>
                                                        <div class="content">
                                                            <span><%=hv.getSummary()%></span>
                                                        </div>
                                                    </div>
                                                    <div class="stat">
                                                        <div class="play_count_img"></div>
                                                        <div class="float_left play_count">观看(<%=hv.getWatchUserCount()%>)</div>
                                                        <div class="comment_count_img"></div>
                                                        <div class="float_left"><a href="#nogo">评论</a><span class="comment_count">(<%=hv.getCommentCount()%>)</span></div>
                                                        <div class="clear"></div>
                                                    </div>
                                                </div>
                                                <div class="play">
                                                    <a href="video.jsp?vid=<%=hv.getVideoid()%>" target="_blank"></a>
                                                    <div class="clear"></div>
                                                </div>
                                                <div class="clear"></div>
                                            </div>
                                        </div>

                                        <!--<div>
                                            <ul>
                                                <li>
                                                    <a class="float" href="#nogo">
                                                        <img src="pic/face/faceA45.png" width="25px" height="25px" alt="photo"/>
                                                    </a>
                                                    <div class="float reply_byline">
                                                        <a href="#nogo">倪黎阳</a>
                                                        <span>2011-01-14 20:14</span>
                                                        <div class="reply">
																	我拜，我是牛！此文是牡丹！
                                                            <a href="#nogo">回复</a>
                                                        </div>
                                                    </div>
                                                    <div class="clear"></div>
                                                </li>
                                            </ul>
                                        </div>-->
                                    </div>
                                    <div class="clear"></div>
                                </div>
                            </div>
                            <div class="clear"></div>
                        </div>
                        <div id="hot_links">
                            <ul>
                                <li class="hot_link_img custom"></li>
                                <li class="hot_link">
                                    <div><span>海量定制微视频</span></div>
                                    <div ="english_span">Videos for you</div>
                                </li>
                                <li class="hot_link_img  follow"></li>
                                <li class="hot_link">
                                    <div><span>关注达人知世界</span></div>
                                    <div class="english_span">Connect with the makers</div>
                                </li>
                                <li class="hot_link_img build_up"></li>
                                <li class="hot_link">
                                    <div><span>自制视频收藏夹</span></div>
                                    <div class="english_span">Build up your collection</div>
                                </li>
                                <li class="hot_link_img reach"></li>
                                <li class="hot_link">
                                    <div><span>一键视频分天下</span></div>
                                    <div class="english_span">Reach your audience</div>
                                </li>
                                <div class="clear"></div>
                            </ul>
                        </div>

                        <div class="columns">
                            <div class="column_hot10">
                                <div id="hot_video_renren" class=" hot_video_title"></div>
                                <%
                                            IndexContentManager icm = IndexContentManager.getInstance();
                                            List<CollectEvent> renrenList = EntityFactory.getUser(icm.getQzoneRobotId()).getCollectedVideo(0, 5);
                                %>
                                <div class="hot_video_clips">
                                    <div class="hot10_wrap">
                                        <div class="hot10_innerwrap ">
                                            <%
                                                        int vcount = 0;
                                                        int vcountie6 = 1;
                                                        for (CollectEvent ce : renrenList) {
                                                            IVideo video = EntityFactory.getVideo(ce.getVideoid());
                                            %>
                                            <div class="hot_video">
                                                <div class="thumbnail" title="<%=video.getTitle()%>" style="background-image:url('<%= video.getSnapshotURL()%>')"><a class="play" target="_blank" href="<%= "video.jsp?vid=" + video.getVideoid()%>">"></a><div class="video_num" style="background:url('pic/no1.png') -<%= vcount%>px 0px no-repeat;_background:none;_filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(enabled=true, sizingMethod=scale, src='pic/ie6/no0<%= vcountie6%>.png');"></div></div>
                                                <div class="video_info">
                                                    <div class="video_title"><a target="_blank" title="<%=video.getTitle()%>" href="<%= "video.jsp?vid=" + video.getVideoid()%>"><%=video.getTitle()%></a></div>
                                                    <div class="video_discription"><%=video.getSummary()%></div>
                                                </div>
                                            </div>
                                            <%
                                                            vcount = vcount + 50;
                                                            ++vcountie6;
                                                        }
                                            %>
                                            <div class="clear"></div>
                                        </div>
                                    </div>

                                </div>
                            </div>
                            <div class="column_hot10">
                                <div id="hot_video_qzone" class="hot_video_title ">
                                </div>
                                <div class="hot_video_clips">
                                    <div class="hot10_wrap">
                                        <div class="hot10_innerwrap ">
                                            <%
                                                        vcount = 0;
                                                        vcountie6 = 1;
                                                        List<CollectEvent> qzoneList = EntityFactory.getUser(icm.getQzoneRobotId()).getCollectedVideo(30, 5);
                                                        for (CollectEvent ce : qzoneList) {
                                                            IVideo video = EntityFactory.getVideo(ce.getVideoid());
                                            %>
                                            <div class="hot_video">
                                                <%--<div class="video_num" style="background:url('pic/no1.png') -<%= vcount%>px 0px no-repeat;"></div>--%>
                                                <div class="thumbnail" title="<%=video.getTitle()%>" style="background-image:url('<%= video.getSnapshotURL()%>')"><a class="play" target="_blank" href="<%= "video.jsp?vid=" + video.getVideoid()%>">"></a><div class="video_num" style="background:url('pic/no1.png') -<%= vcount%>px 0px no-repeat;_background:none;_filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(enabled=true, sizingMethod=scale, src='pic/ie6/no0<%= vcountie6%>.png');"></div></div>
                                                <div class="video_info">
                                                    <div class="video_title"><a target="_blank" title="<%=video.getTitle()%>" href="<%= "video.jsp?vid=" + video.getVideoid()%>"><%=video.getTitle()%></a></div>
                                                    <div class="video_discription"><%=video.getSummary()%></div>
                                                </div>
                                            </div>
                                            <%
                                                            vcount = vcount + 50;
                                                            ++vcountie6;
                                                        }
                                            %>
                                            <div class="clear"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="column_hot10">
                                <div id="hot_video_kaixin" class="hot_video_title ">
                                </div>
                                <div class="hot_video_clips">
                                    <div class="hot10_wrap">
                                        <div class="hot10_innerwrap ">
                                            <%
                                                        vcount = 0;
                                                        vcountie6 = 1;
                                                        List<CollectEvent> kaixinList = EntityFactory.getUser(icm.getQzoneRobotId()).getCollectedVideo(60, 5);
                                                        for (CollectEvent ce : kaixinList) {
                                                            IVideo video = EntityFactory.getVideo(ce.getVideoid());
                                            %>
                                            <div class="hot_video">
                                                <%--<div class="video_num" style="background:url('pic/no1.png') -<%= vcount%>px 0px no-repeat;"></div>--%>
                                                <div class="thumbnail" title="<%=video.getTitle()%>" style="background-image:url('<%= video.getSnapshotURL()%>')"><a class="play" target="_blank" href="<%= "video.jsp?vid=" + video.getVideoid()%>">"></a><div class="video_num" style="background:url('pic/no1.png') -<%= vcount%>px 0px no-repeat;_background:none;_filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(enabled=true, sizingMethod=scale, src='pic/ie6/no0<%= vcountie6%>.png');"></div></div>
                                                <div class="video_info">
                                                    <div class="video_title"><a target="_blank" title="<%=video.getTitle()%>" href="<%= "video.jsp?vid=" + video.getVideoid()%>"><%=video.getTitle()%></a></div>
                                                    <div class="video_discription"><%=video.getSummary()%></div>
                                                </div>
                                            </div>
                                            <%
                                                            vcount = vcount + 50;
                                                            ++vcountie6;
                                                        }
                                            %>
                                            <div class="clear"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="column_hot10">
                                <div id="hot_video_iweishi" class="hot_video_title">
                                </div>
                                <div class="hot_video_clips">
                                    <div class="hot10_wrap">
                                        <div class="hot10_innerwrap ">
                                            <%
                                                        vcount = 0;
                                                        vcountie6 = 1;
                                                        List<CollectEvent> iweishiList = EntityFactory.getUser(icm.getIweishiRobotId()).getCollectedVideo(0, 5);
                                                        for (CollectEvent ce : iweishiList) {
                                                            IVideo video = EntityFactory.getVideo(ce.getVideoid());
                                            %>
                                            <div class="hot_video">
                                                <%--<div class="video_num" style="background:url('pic/no1.png') -<%= vcount%>px 0px no-repeat;"></div>--%>
                                                <div class="thumbnail" title="<%=video.getTitle()%>" style="background-image:url('<%= video.getSnapshotURL()%>')"><a class="play" target="_blank" href="<%= "video.jsp?vid=" + video.getVideoid()%>">"></a><div class="video_num" style="background:url('pic/no1.png') -<%= vcount%>px 0px no-repeat;_background:none;_filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(enabled=true, sizingMethod=scale, src='pic/ie6/no0<%= vcountie6%>.png');"></div></div>
                                                <div class="video_info">
                                                    <div class="video_title"><a target="_blank" title="<%=video.getTitle()%>" href="<%= "video.jsp?vid=" + video.getVideoid()%>"><%=video.getTitle()%></a></div>
                                                    <div class="video_discription"><%=video.getSummary()%></div>
                                                </div>
                                            </div>
                                            <%
                                                            vcount = vcount + 50;
                                                            ++vcountie6;
                                                        }
                                            %>
                                            <div class="clear"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="clear"></div>
                        </div>
                    </div>
                    <%@include file="jspf/footer.jspf"%>
                </div>
            </div>
        </div>
        <script type="text/javascript">
            WB.core.load(['connect', 'client', 'widget.base', 'widget.atWhere'], function() {
                var cfg = {
                    key: '2390155024',
                    xdpath: 'http://www.iweishi.cn/xd.html'
                };
                WB.connect.init(cfg);
                WB.client.init(cfg);

                //connect with sina weibo
                WB.widget.base.connectButton(document.getElementById("sina_connect_btn"), {
                    login: function(o) {
                        alert(o.screen_name);
                    },
                    logout: function() {
                        alert("sina weibo logout!");
                    }
                });
            });
        </script>
    </body>
</html>
