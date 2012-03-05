<%-- 
   Document   : userHomepage_enter
   Created on : 2010-4-30, 19:43:59
   Author     : xiaoxiao
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>

<%@page import="logic.IVideo"%>
<%@page import="logic.IUser"%>

<%@page import="logic.IChannel"%>
<%@page import="logic.Global"%>
<%@page import="logic.Video"%>
<%@page import="logic.User"%>
<%@page import="logic.EntityFactory"%>
<%@page import="logic.datatype.*"%>
<%@page import="logic.IEvent"%>
<%@page import="logic.datatype.JoinChannelEvent"%>

<%@page import="utility.Misc"%>
<%@page import="servlet.ServletCommon"%>
<%@page import="servlet.WebpageLayoutParam"%>

<%
// host: owner of this page.
            String suid = request.getParameter("uid");
            int uid = Integer.parseInt(suid);
            IUser host = EntityFactory.getUser(uid);
            String sname = host.getName();

// user: the one who is currently viewing the page.
            IUser user = ServletCommon.getCurrentUser(session);
            String prop = "TA";
            boolean showPushFrame = false;
            if (user.getUserid() == uid) // user is viewing his/her own home
            {
                prop = "我";
                showPushFrame = true; // only show push frame to host.
            }

            List channellist = host.getJoinedChannel(WebpageLayoutParam.NUM_TOPLIMIT_ALBUMS);
            Iterator<JoinChannelEvent> channelit = channellist.iterator();
            int cid = 0;

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xml:lang="en" xmlns="http://www.w3.org/1999/xhtml" lang="en" xmlns:v="urn:schemas-microsoft-com:vml" >

    <head>
        <title><%=host.getName()%>的个人主页 爱微视 iweishi</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta http-equiv="imagetoolbar" content="no" />
        <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7,chrome=1"/>
        <meta name="description" content="<%=host.getName()%>发现，收藏和看过的视频" />
        <link rel="stylesheet" type="text/css" media="all" href="CSS/global.css" />
        <link rel="stylesheet" type="text/css" media="all" href="CSS/top_enter.css" />
        <link href="CSS/Left_push_video.css" rel="stylesheet" type="text/css" />
        <link href="CSS/homepage_header_enter.css" rel="stylesheet" type="text/css" />
        <link href="CSS/Join_Login2.css" rel="stylesheet" type="text/css" />
        <link href="CSS/createAlbum.css" rel="stylesheet" type="text/css" />
        <link href="CSS/tabs.css" rel="stylesheet" type="text/css" />
        <link href="CSS/help_banner.css" rel="stylesheet" type="text/css" />
        <link href="CSS/videos_hot.css" rel="stylesheet" type="text/css" />
        <link href="CSS/userhomepage_enter.css" rel="stylesheet" type="text/css" />

        <link href="CSS/footer.css" rel="stylesheet" type="text/css" />
        <link rel="shortcut icon" href="pic/tablogo_final.png" type="image/x-icon"/>

        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js" type="text/javascript"></script>
        <script src="jquery_plugins/jquery.text-overflow.min.js" type="text/javascript"></script>
        <script type="text/javascript" src="colorbox/jquery.colorbox.js"></script>
        <link rel="stylesheet" href="colorbox/colorbox.css" type="text/css" media="screen" />
        <script src="JS/jquery_plugins.js" type="text/javascript"></script>
        <script type="text/javascript">
            var page_type = "home.jsp";
            var gUserid = <%= user.getUserid()%>;
            var gUsername = "<%= user.getName()%>";
            var gHostid = "<%= host.getUserid()%>";
            var gHostname = "<%= host.getName()%>";
        </script>
        <script src="JS/common.js" type="text/javascript"></script>
        <script src="JS/videolist.js" type="text/javascript"></script>
        <script src="JS/tab.js" type="text/javascript"></script>
        <script src="JS/home.js" type="text/javascript"></script>
        <script src="JS/push_frame.js" type="text/javascript"></script>
        <script src="JS/head_last.js" type="text/javascript"></script>

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
                        <div id="toolbar">
                            <%  if (user.getUserid() != uid) {
                            %>
                            <div id="contact_switch" class="toolbar_item">
                                <%
                                      if (user.getFollowee().contains(uid)) {
                                %>
                                <a  id="disfollow_me" href="#nogo">
                                    <div class="toolbar_image" id="toolbar_smiley_selected"></div>取消关注
                                </a>
                                <a  id="follow_me" class="mask" href="#nogo">
                                    <div id="toolbar_smiley" class="toolbar_image"></div>关注TA&nbsp;
                                </a>
                                <%} else {
                                %>
                                <a  id="disfollow_me" class="mask" href="#nogo">
                                    <div class="toolbar_image" id="toolbar_smiley_selected"></div>取消关注
                                </a>
                                <a  id="follow_me" href="#nogo">
                                    <div id="toolbar_smiley" class="toolbar_image"></div>关注TA&nbsp;
                                </a>
                                <%}
                                %>
                            </div>
                            <%
                              } else {%>
                            <div class="toolbar_item">
                                <a href="user_settings.jsp">
                                    <div id="toolbar_settings" class="toolbar_image"></div>
							设置
                                </a>
                            </div>
                            <%}%>
                        </div>

                        <div id="header">
                            <div class="portrait"><a href="home.jsp?uid=<%= host.getUserid()%>"><img src="pic/portrait/d.160149.jpg" alt=""  class="portrait" /></a></div>
                            <div class="rightside">
                                <div class="title"><%= host.getName()%></div>
                                <%
                                            if (host.getDescription() != null && !host.getDescription().equals("null")) {
                                %>
                                <div class="byline"><%= host.getDescription()%></div>
                                <%}%>
                                <div class="date">
                                    <span id="clip-timeago"><%= host.getJoinTime()%></span>
                                </div>
                            </div>
                            <div class="clear"></div>
                        </div>

                        <div class="columns">
                            <div class="column" id="columnA">
                                <div style="height: 20px;"></div>

                                <div class="tabs">
                                    <ul>
                                        <li id="collected_tab" class="active">
                                            <!--[if gte IE 6]><div class="tableft"><div class="tableft_tl"></div><div class="tableft_bottom"></div></div><![endif]-->

                                            <div  class="tab"><%=prop%>收藏的视频</div>
                                            <!--[if gte IE 6]> <div class="tabright"><div class="tabright_tr"></div><div class="tabright_bottom"></div></div><div class="clear"></div><![endif]-->
                                        </li>
                                        <li id="imported_tab">
                                            <!--[if gte IE 6]>  <div class="tableft"><div class="tableft_tl"></div><div class="tableft_bottom"></div></div><![endif]-->
                                            <div  class="tab"> <%=prop%>发现的视频</div>
                                            <!--[if gte IE 6]> <div class="tabright"><div class="tabright_tr"></div><div class="tabright_bottom"></div></div><div class="clear"></div>
                                             <![endif]--></li>
                                        <li id="watched_tab">
                                            <!--[if gte IE 6]><div class="tableft"><div class="tableft_tl"></div><div class="tableft_bottom"></div></div><![endif]-->
                                            <div  class="tab"> <%=prop%>看过的视频</div>
                                            <!--[if gte IE 6]><div class="tabright"><div class="tabright_tr"></div><div class="tabright_bottom"></div></div><div class="clear"></div><![endif]-->
                                        </li>

                                    </ul>

                                    <div class="clear"></div>
                                </div>
                                <!--[if gte IE 6]><div class="wrappertop"><div class="wrappertop_tr"><img src="pic/wraproundedcorners_tr.png"/></div><div class="clear"></div></div><![endif]-->

                                <div id="content_wrapper" class="softcorner native">
                                    <div class="toobar">
                                        <div class="divCreateAlbumBtnWrapper">
                                            <% if (user.getUserid() == uid) {
                                            %>
                                            <div class="almond">
                                                <a class="create_album" href="#nogo">新建专辑</a>
                                            </div>
                                            <div class="almond"><a class="create_album" href="#nogo"><img alt="新建专辑" src="pic/album_icon.png"/></a></div>
                                            <div class="almond album_setting mask">
                                                <a href="album_settings.jsp">更改专辑资料</a>
                                                <span>&nbsp; / &nbsp;</span>
                                            </div>
                                            <div class="almond">
                                                <a href="#nogo" id="add_video">添加视频</a>
                                                <span>&nbsp; / &nbsp;</span>
                                            </div>
                                            <% } else {%>
                                            <div class="almond">
                                                <a class="dropdown" href="#nogo">展开下拉菜单，看看TA的其他专辑是不是一样精彩？</a>
                                            </div>
                                            <div class="almond"><a class="dropdown" href="#nogo"><img alt="其他专辑" src="pic/album_icon.png"/></a></div>
                                            <%}%>
                                            <div id="inbox_dropdown_items" class="dropdown_items">
                                                <ul class="ulDropdown">
                                                    <li class="selected unpost" id="unpost">未放入任何专辑的收藏视频</li>
                                                    <%
                                                                while (channelit.hasNext()) {
                                                                    int aid = channelit.next().getGroupid();
                                                                    String aname = EntityFactory.getGroup(aid).getName();
                                                    %>
                                                    <li id='<%="aid" + aid%>' class="album_item" title="<%= aname%>" ><%= aname%></li>
                                                    <%
                                                                }
                                                                if (user.getUserid() == uid) {
                                                    %>
                                                    <li class="create_album">新建专辑</li>
                                                    <% }%>
                                                </ul>
                                            </div>
                                        </div>

                                        <span class="show">视频专辑</span>
                                        <div class="dropdown" id="inbox_dropdown">
                                            <div class="value" id="inbox_dropdown_value">未放入任何专辑的收藏视频</div>
                                        </div>
                                        <div class="clear"></div>
                                    </div>


                                    <div  id="loading_albumvideos" class="videoContentLoading mask">
                                        加载中......
                                    </div>
                                    <div  id="loading_imported_videos" class="videoContentLoading mask">
                                        加载中......
                                    </div>
                                    <div  id="loading_watched_videos" class="videoContentLoading mask">
                                        加载中......
                                    </div>
                                    <div id="collected_videos" class="videos_content last_open">
                                        <!--[if gte IE 6]><div class="video_meat_top"><div class="video_meat_top_tl"></div><div class="video_meat_top_tr"></div><div class="video_meat_tm"></div></div><![endif]-->
                                        <div class="videos_meat">
                                            <div class="clips">
                                                <div style="background-color: rgb(242, 245, 195); -moz-border-radius: 10px 10px 10px 10px;" class="softcorner native obiwan">
                                                    <div class="nipple"></div>
                                                    <div class="myonlyhope vimeo">
                                                        <% if (user.getUserid() == uid) {
                                                        %>
                                                        <div class="title">嗨，在这里可以制作自己的专辑哦！</div>
                                                        <p>爱微视会根据专辑的内容和题材将它推荐给感兴趣的观众，迅速准确帮你聚集人气。</p>
                                                        <%} else {%>
                                                        <div class="title">嗨，下拉菜单可以展开哦！</div>
                                                        <p>快去看看TA的其他专辑是不是一样精彩？</p>
                                                        <%}%>
                                                        <div class="undertaker">×</div>
                                                    </div>
                                                </div>
                                                <jsp:include page="jspf/homeclips.jsp?type=collected&uid=<%=host.getUserid()%>" />
                                                <div class="pagination ">
                                                    <ul>
                                                        <%
                                                                    int pages = ServletCommon.pagination(host.getCollectedVideoNumber(), WebpageLayoutParam.NUM_COLLECTED_VIDEOS);
                                                        %>
                                                        <li class="arrow"><a  href="#nogo"><img alt="previous" src="pic/page_arrow_prev_on.gif"/></a></li>
                                                        <li class="selected"><a  href="#nogo">1</a></li>
                                                        <% int i = 1;
                                                                    while (i < pages && i < WebpageLayoutParam.NUM_PAGES) {%>
                                                        <li><a  href="#nogo"><%= ++i%></a></li>
                                                        <%}
                                                                    if (i < pages) {%>
                                                        <li class="dots">...</li>
                                                        <li><a  href="#nogo"><%=pages%></a></li>
                                                        <%}
                                                        %>
                                                        <li class="arrow"><a  href="#nogo"><img alt="next" src="pic/page_arrow_next_on.gif" /></a></li>
                                                        <div class="clear"></div>
                                                    </ul>
                                                    <div class="clear"></div>
                                                </div>
                                            </div>
                                        </div>
                                        <!--[if gte IE 6]> <div class="video_meat_bottom"><div class="video_meat_bottom_bl"><img src="pic/blvideocontentroundedcorners.png" /></div><div class="video_meat_bottom_br"></div><div class="video_meat_bottom_bm"></div></div><![endif]-->
                                    </div>

                                    <div id="imported_videos" class="videos_content mask">
                                        <!--[if gte IE 6]><div class="video_meat_top"><div class="video_meat_top_tl"></div><div class="video_meat_top_tr"></div><div class="video_meat_tm"></div></div><![endif]-->
                                        <div class="videos_meat">
                                            <div class="clips">
                                                <div class="pagination ">
                                                    <ul>
                                                        <%
                                                                    pages = ServletCommon.pagination(host.getSubmitedVideoNumber(), WebpageLayoutParam.NUM_IMPORTED_VIDEOS);
                                                        %>
                                                        <li class="arrow"><a  href="#nogo"><img alt="previous" src="pic/page_arrow_prev_on.gif"/></a></li>
                                                        <li class="selected"><a  href="#nogo">1</a></li>
                                                        <% i = 1;
                                                                    while (i < pages && i < WebpageLayoutParam.NUM_PAGES) {%>
                                                        <li><a  href="#nogo"><%= ++i%></a></li>
                                                        <%}
                                                                    if (i < pages) {%>
                                                        <li class="dots">...</li>
                                                        <li><a  href="#nogo"><%=pages%></a></li>
                                                        <%}
                                                        %>
                                                        <li class="arrow"><a  href="#nogo"><img alt="next" src="pic/page_arrow_next_on.gif" /></a></li>
                                                        <div class="clear"></div>
                                                    </ul>
                                                    <div class="clear"></div>
                                                </div>
                                            </div>
                                        </div>
                                        <!--[if gte IE 6]> <div class="video_meat_bottom"><div class="video_meat_bottom_bl"><img src="pic/blvideocontentroundedcorners.png" /></div><div class="video_meat_bottom_br"></div><div class="video_meat_bottom_bm"></div></div><![endif]-->
                                    </div>
                                    <div id="watched_videos" class="videos_content mask">
                                        <!--[if gte IE 6]><div class="video_meat_top"><div class="video_meat_top_tl"></div><div class="video_meat_top_tr"></div><div class="video_meat_tm"></div></div><![endif]-->
                                        <div class="videos_meat">
                                            <div class="clips">
                                                <div class="pagination ">
                                                    <ul>
                                                        <%
                                                                    pages = ServletCommon.pagination(host.getWatchedVideoNumber(), WebpageLayoutParam.NUM_WATCHED_VIDEOS);
                                                        %>
                                                        <li class="arrow"><a  href="#nogo"><img alt="previous" src="pic/page_arrow_prev_on.gif"/></a></li>
                                                        <li class="selected"><a  href="#nogo">1</a></li>
                                                        <% i = 1;
                                                                    while (i < pages && i < WebpageLayoutParam.NUM_PAGES) {%>
                                                        <li><a  href="#nogo"><%= ++i%></a></li>
                                                        <%}
                                                                    if (i < pages) {%>
                                                        <li class="dots">...</li>
                                                        <li><a  href="#nogo"><%=pages%></a></li>
                                                        <%}
                                                        %>
                                                        <li class="arrow"><a  href="#nogo"><img alt="next" src="pic/page_arrow_next_on.gif" /></a></li>
                                                        <div class="clear"></div>
                                                    </ul>
                                                    <div class="clear"></div>
                                                </div>
                                            </div>
                                        </div>
                                        <!--[if gte IE 6]> <div class="video_meat_bottom"><div class="video_meat_bottom_bl"><img src="pic/blvideocontentroundedcorners.png" /></div><div class="video_meat_bottom_br"></div><div class="video_meat_bottom_bm"></div></div><![endif]-->
                                    </div>
                                </div>
                                <!--[if gte IE 6]> <div class="wrapper_bottom"><div class="wrpper_bottom_bl"></div><div class="wrapper_bottom_br"></div><div class="wrapper_bottom_bm"></div><div class="clear"></div></div><![endif]-->


                            </div>

                            <div class="column" id="columnB">

                                <div class="nippleBox soxsSoul">
                                    <div class="bar">
                                        <h4><%= sname%>的新鲜事</h4></div>
                                    <div class="nipple"></div>
                                    <div class="content myactivity">
                                        <ul class="profile_activity">
                                            <% List eventlist = host.GetMyNewEvents(6);
                                                        Iterator<IEvent> eventit = eventlist.iterator();
                                                        IEvent event = null;
                                                        while (eventit.hasNext()) {
                                                            event = eventit.next();
                                                            if (event instanceof SubmitEvent) {
                                                                SubmitEvent se = (SubmitEvent) event;
                                                                int sevideoid = se.getVideoid();
                                                                IVideo video = EntityFactory.getVideo(se.getVideoid());
                                                                IUser u = EntityFactory.getUser(se.getUserid());
                                            %>
                                            <li>
                                                <div class="digest">
                                                    <div style="color: rgb(150, 150, 150); font: 12px verdana,sans-serif; margin-bottom: 2px;"><%=Misc.pastTime(se.getTime())%> 以前</div>
                                                    发现了 <strong><a href="video.jsp?vid=<%= sevideoid%>"><%= video.getTitle()%></a></strong>
                                                </div>
                                                <img src="<%=video.getSnapshotURL()%>" alt="" title="<%=video.getTitle()%>"
                                                     class="portrait" height="40" width="40"/>
                                                <div class="clear"></div>
                                            </li>
                                            <%
                                                                                                            continue;
                                                                                                        }
                                            %>

                                            <%
                                                                                                        if (event instanceof UserRelationEvent) {
                                                                                                            UserRelationEvent ur = (UserRelationEvent) event;
                                                                                                            IUser fee = EntityFactory.getUser(ur.getFolloweeid());
                                            %>
                                            <li>
                                                <div class="digest">
                                                    <div style="color: rgb(150, 150, 150); font: 12px verdana,sans-serif; margin-bottom: 2px;">
                                                        <%=Misc.pastTime(ur.getTime())%> 以前
                                                    </div>
                                                    关注了<strong><a href="home.jsp?uid=<%= ur.getFolloweeid()%>"><%=fee.getName()%></a></strong>
                                                </div>
                                                <img src="<%=fee.getPhotoSmall()%>" alt="" title="<%=fee.getName()%>"
                                                     class="portrait"  height="40" width="40"/>
                                                <div class="clear"></div>
                                            </li>
                                            <% continue;
                                                                                                        }%>

                                            <% if (event instanceof VideoCommentEvent) {
                                                                                                            VideoCommentEvent vc = (VideoCommentEvent) event;
                                                                                                            IVideo video = EntityFactory.getVideo(vc.getVideoid());
                                                                                                            IUser u = EntityFactory.getUser(vc.getUserid());
                                            %>
                                            <li>                                              
                                                <div class="digest">
                                                    <div style="color: rgb(150, 150, 150); font: 12px
                                                         verdana,sans-serif; margin-bottom: 2px;"><%=Misc.pastTime(vc.getTime())%> 以前</div>
                                                    评论了 <strong><a href="video.jsp?vid=<%=vc.getVideoid()%>"><%=video.getTitle()%></a></strong>
                                                </div>
                                                <img src="<%=video.getSnapshotURL()%>" alt="" title="<%=video.getTitle()%>"
                                                     class="portrait"  height="40" width="40"/>
                                                <div class="clear"></div>

                                            </li>
                                            <% continue;
                                                                                                        }%>
                                            <%
                                                                                                        if (event instanceof RateEvent) { //评价
                                                                                                            RateEvent re = (RateEvent) event;
                                                                                                            IVideo video = EntityFactory.getVideo(re.getVideoid());
                                            %>

                                            <li>                                                                                        
                                                <div class="digest">
                                                    <div style="color: rgb(150, 150, 150); font: 12px
                                                         verdana,sans-serif; margin-bottom: 2px;"><%=Misc.pastTime(re.getTime())%> 以前</div>
                                                    评价了 <strong><a href="video.jsp?vid=<%=re.getVideoid()%>"><%=video.getTitle()%></a></strong>
                                                </div>
                                                <img src="<%=video.getSnapshotURL()%>" alt="" title="<%=video.getTitle()%>"
                                                     class="portrait"  height="30" width="30"/>
                                                <div class="clear"></div>

                                            </li>

                                            <% continue;
                                                                                                        }%>

                                            <%
                                                                                                        if (event instanceof WatchEvent) { //观看
                                                                                                            WatchEvent we = (WatchEvent) event;
                                                                                                            IVideo video = EntityFactory.getVideo(we.getVideoid());
                                            %>

                                            <li>                                              
                                                <div class="digest">
                                                    <div style="color: rgb(150, 150, 150); font: 12px
                                                         verdana,sans-serif; margin-bottom: 2px;"><%=Misc.pastTime(we.getTime())%> 以前</div>
                                                    观看了 <strong><a href="video.jsp?vid=<%= we.getVideoid()%>"><%=video.getTitle()%></a></strong>
                                                </div>
                                                <img src="<%=video.getSnapshotURL()%>" alt="" title="<%=video.getTitle()%>"
                                                     class="portrait"  height="40" width="40"/>

                                                <div class="clear"></div>
                                            </li>

                                            <% continue;
                                                                                                        }%>

                                            <%
                                                                                                        //if (event instanceof CollectEvent) { //收藏TODO

                                                                                                        //}
%>



                                            <% }%>


                                        </ul>
                                        <p ><a href="notready.jsp"><strong><%= sname%>的全部新鲜事</strong></a></p>

                                    </div>
                                </div>   <div class="nippleBox abrahamLincoln">
                                    <div class="bar">
                                        <h4><%= sname%>关注的人</h4>	</div>
                                    <div class="nipple"></div>
                                    <div class="content">
                                        <div class="profile_contacts">
                                            <ul>
                                                <%
                                                            List followeelist = host.getFollowee();
                                                            Iterator<Integer> followeeit = followeelist.iterator();
                                                            int followeeid = 0;
                                                            IUser followee = null;
                                                            int followeenum = 1;

                                                            while ((followeenum != 13) && followeeit.hasNext()) {
                                                                followeeid = followeeit.next().intValue();
                                                                followee = EntityFactory.getUser(followeeid);
                                                                ++followeenum;
                                                %>
                                                <li><a href="home.jsp?uid=<%= followeeid%>"><img src="pic/portrait/d.48.jpg"/><%= followee.getName()%></a></li>
                                                <% }%>
                                            </ul>

                                            <div class="clear"></div><p class="all"><a href="attention_and_fans_enter.jsp?uid=<%=suid%>"><strong>全部</strong></a></p>
                                        </div>	</div>
                                </div>        <div class="nippleBox organicFritos">
                                    <div class="bar">
                                        <h4><%= sname%>的粉丝</h4>	</div>
                                    <div class="nipple"></div>
                                    <div class="content">
                                        <div class="profile_contacts">
                                            <ul>
                                                <%
                                                            List followerlist = host.getFollower();
                                                            Iterator<Integer> followerit = followerlist.iterator();
                                                            int followerid = 0;
                                                            IUser follower = null;
                                                            int followernum = 1;

                                                            while ((followernum != 13) && followerit.hasNext()) {
                                                                followerid = followerit.next().intValue();
                                                                follower = EntityFactory.getUser(followerid);
                                                                ++followernum;
                                                %>
                                                <li><a href="home.jsp?uid=<%= followerid%>"><img src="pic/portrait/d.48.jpg"/><%= follower.getName()%></a></li>
                                                <% }%>
                                            </ul>

                                            <div class="clear"></div><p class="all"><a href="attention_and_fans_enter.jsp?uid=<%=suid%>"><strong>全部</strong></a></p>
                                        </div>	</div></div>
                                <!--<div class="nippleBox organicFritos arrogantSunflower">
                                    <div class="bar">
                                        <h4><%= sname%>的小组</h4>	</div>
                                    <div class="nipple"></div>
                                    <div class="content">
                                        <div class="profile_contacts">
                                            <ul>

                                                <li><a href="Group_Homepage_enter.jsp"><img src="pic/g18337-1.jpg"/>曼联</a></li>
                                                <li><a href="Group_Homepage_enter.jsp"><img src="pic/g18337-1.jpg"/>曼联</a></li>
                                                <li><a href="Group_Homepage_enter.jsp"><img src="pic/g18337-1.jpg"/>曼联</a></li>
                                                <li><a href="Group_Homepage_enter.jsp"><img src="pic/g18337-1.jpg"/>曼联</a></li>
                                                <li><a href="Group_Homepage_enter.jsp"><img src="pic/g18337-1.jpg"/>曼联</a></li>
                                            </ul>
                                            <div class="clear"></div>
                                            <p class="all"><a href="Group_Homepage_All_enter.jsp"><strong>全部</strong></a></p>
                                        </div>	</div></div>-->

                                <!--<div class="nippleBox ">
                                    <div class="bar" >
                                        <h4>广告</h4>	</div>
                                    <div class="nipple" ></div>
                                    <div class="content">
                                        <div class="ad" id="dfp-ad-1" style="width: 300px; height: 250px;"><img src="pic/PINGKI015.jpg" />


                                        </div>	</div>
                                </div>-->

                            </div>

                            <div class="clear"></div>
                        </div>
                        <%@include file="jspf/footer.jspf"%>
                    </div>
                </div>
            </div>
        </div>

        <img style="top: -3px;" class="sun"
             src="pic/land_sun.gif"/><img
             style="position: fixed; *position: absolute; z-index: 20; top: 45px; right: -60px; *right: 0px;"
             id="cloud"
             src="pic/land_cloud.gif"/><img
             style="top: 322px;" id="cloud2"
             src="pic/land_cloud2.gif"/>

        <div class="mask">
            <% if (showPushFrame) {%>
            <%@include file="jspf/push_frame.jspf"%>
            <div style="height: 20px;"></div>
            <%}%>
            <%@include file="jspf/loginbox.jspf"%>
            <%@include file="jspf/create_album.jspf"%>
            <%@include file="jspf/edit_album_ad.jspf"%>
        </div>
    </body>
</html>