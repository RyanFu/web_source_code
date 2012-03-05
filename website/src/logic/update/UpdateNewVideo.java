/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package logic.update;

import logic.Global;

/**
 *
 * @author xiaoxiao
 */
public class UpdateNewVideo extends Updater {
    public static final int UPDATE_INTERVAL = 1 * 60 * 60 * 1000;

    @Override
    public int getUpdateInterval() {
        return  UPDATE_INTERVAL;
    }

    @Override
    public void run() {
        Global.updateNewVideoPool();
    }
}
