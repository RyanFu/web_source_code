/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package logic.parse;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.logging.Level;
import java.util.logging.Logger;
import logic.IVideo;
import logic.Video;
import net.sf.json.*;
import utility.Constant;
import utility.SimpleHttpClient;

/**
 *
 * @author xiaoxiao
 */
class YoukuVideoParser implements IVideoParser {

    static String pageurlPrefix = "http://v.youku.com/v_show/id_";
    static String pageurlPostfix = ".html";
    
    static String flashurlPrefix = "/sid/";
    static String flashurlPostfix = "/v.swf";

    static ArrayList<ThreePieceExtractor> extractors;

    YoukuVideoParser() {
         extractors = new ArrayList<ThreePieceExtractor>();
         extractors.add(new ThreePieceExtractor(
                 pageurlPrefix,
                 pageurlPostfix,
                 pageurlPrefix.length(),
                 pageurlPostfix.length()));
         extractors.add(new ThreePieceExtractor(
                 flashurlPrefix,
                 flashurlPostfix,
                 flashurlPrefix.length(),
                 flashurlPostfix.length()));
    }

    @Override
    public IVideo parse(String refer) {
        if (refer.contains("youku.com")) {
            IVideo v = this.parseFeedinInfo(refer);
            if (v != null && this.parseRemoteInfo(v)) {
                return v;
            } else {
                return null;
            }
        } else {
            return null;
        }
    }
    /**
     * 
     * @param url
     * @return
     */
    protected IVideo parseFeedinInfo(String refer) {
        //http://v.youku.com/v_show/id_XMTUzMzQ2MTgw.html
        //http://player.youku.com/player.php/sid/XMTUzMzQ2MTgw/v.swf
        //<embed src="http://player.youku.com/player.php/sid/XMTUzMzQ2MTgw/v.swf" quality="high" ...</embed>
        //
        // Notice embed is almost the same as flash url

        //http://v.youku.com/v_playlist/f4247027o1p0.html
        IVideo result = null;
        if (refer.contains("http://v.youku.com/v_playlist/")) {
            {
                BufferedReader input = null;
                try {
                    URL url = new URL(refer);
                    input = new BufferedReader(new InputStreamReader(url.openStream()));
                    while (true) {
                        String line = input.readLine();
                        if (line == null) {
                            break;
                        } else {
                            if (line.contains("http://player.youku.com/player.php")
                                    && line.contains("/sid/")) {
                                result = getIDInfo(line);
                                if (result != null)
                                    break;
                            }
                        }
                    }
                } catch (IOException ex) {
                    Logger.getLogger(YoukuVideoParser.class.getName()).log(Level.SEVERE, null, ex);
                } finally {
                    try {
                        if (input != null)
                            input.close();
                    } catch (IOException ex) {
                        Logger.getLogger(YoukuVideoParser.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }
            }

        } else {  //other
            result = getIDInfo(refer);
        }

        return result;
    }

    protected IVideo getIDInfo(String infoString) {
        Iterator<ThreePieceExtractor> it = extractors.iterator();
        String siteid = null;
        Video v = null;
        while(it.hasNext()) {
            ThreePieceExtractor extractor = it.next();
            siteid = extractor.extract(infoString);
            if (siteid == null) {
                siteid = extractor.extract(infoString + ".html");
            }
            if (siteid != null) {
                break;
            } 
        }
        if (siteid != null) {
            v = new Video();
            v.setResidentSite(Constant.YOUKU_SITE);
            v.setSiteSpecificID(siteid);
        }
        return v;
    
    }

    /*
     * JSON example:
     * 
     * {
     * "data":[
     * {
     * "tt":"0",
     * "ct":"a",
     * "cs":"2143",
     * "logo":"http:\/\/g2.ykimg.com\/1100641F464B870901E7B7006CB8922E98A9DD-2021-A37E-BB54-EB216D0D184C",
     * "seed":4496,
     * "tags":["2009","\u5c45\u6c11\u6d88\u8d39","\u4ef7\u683c\u4e0b\u964d","\u5927\u4e2d\u57ce\u5e02","\u623f\u4ef7\u4e0a\u6da8","\u5c71\u4e1c\u536b\u89c6","\u5c71\u4e1c\u7535\u89c6","\u65e9\u65b0\u95fb","20100226"],
     * "categories":"91",
     * "videoid":"38600097",
     * "username":"\u5c71\u4e1c\u536b\u89c6",
     * "userid":"7125138",
     * "title":"2009\u5e74\uff1a\u5c45\u6c11\u6d88\u8d39\u4ef7\u683c\u4e0b\u964d0.7%70\u4e2a\u5927\u4e2d\u57ce\u5e02\u623f\u4ef7\u4e0a\u6da81.5%",
     * "key1":"b3407e8b","key2":"89a8d53bd7d5da4c",
     * "seconds":"23.93",
     * "streamfileids":{"flv":"2*49*2*2*2*47*2*22*2*2*55*31*14*37*2*41*2*22*22*1*40*58*2*2*0*27*31*14*41*47*20*47*31*47*0*31*41*40*65*2*46*41*37*65*41*22*47*46*65*1*20*2*58*65*2*41*46*37*20*47*40*0*55*55*14*46*"},
     * "segs":{"flv":[{"no":"0","size":"751462","seconds":"24"}]},
     * "streamsizes":{"flv":"751462"},
     * "streamtypes":["flvhd","flv"]
     * }
     * ],
     * "user":{"id":0},
     * "controller":{"search_count":true,"mp4_restrict":1,"stream_mode":2}
     * }
     */
    protected boolean parseRemoteInfo(IVideo v) {
        try {
            if (v == null) {
                return false;
            }
            SimpleHttpClient client = new SimpleHttpClient();
            String s = client.get("http://v.youku.com/player/getPlayList/VideoIDS/"+v.getSiteSpecificID()+"/version/5/source/out");
            JSONObject json = JSONObject.fromObject(s);
            JSONArray dataarray = json.getJSONArray("data");
            if (dataarray.size() > 0) {
                JSONObject videoinfo = dataarray.getJSONObject(0);
                String largeSnapshot = videoinfo.getString("logo");
                // change large snapshot to smaller one
                v.setSnapshotURL(largeSnapshot.replaceFirst("ykimg.com/1", "ykimg.com/0"));
                v.setTitle(videoinfo.getString("title"));
                return true;
            }
            return false;
        } catch (net.sf.json.JSONException ex) {
            Logger.getLogger(CNTVVideoParser.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
}
