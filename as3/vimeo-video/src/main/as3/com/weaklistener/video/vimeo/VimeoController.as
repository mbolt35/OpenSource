////////////////////////////////////////////////////////////////////////////////
//
//  WEAKLISTENER.COM - http://www.weaklistener.com
//  Copyright© 2009 Matt Bolt <mattbolt@weaklistener.com>
//  All Rights Reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License"); you may not
//  use this file except in compliance with the License. You may obtain a copy of
//  the License at http://www.apache.org/licenses/LICENSE-2.0 Unless required by
//  applicable law or agreed to in writing, software distributed under the License
//  is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND,
//  either express or implied. See the License for the specific language governing
//  permissions and limitations under the License.
//
////////////////////////////////////////////////////////////////////////////////

package com.weaklistener.video.vimeo {

    //----------------------------------
    //  imports
    //----------------------------------
    import com.weaklistener.utils.DisplayObjectUtil;
    import com.weaklistener.video.VideoPlayerOptions;
    import flash.display.DisplayObject;

    import flash.net.URLRequest;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.events.MouseEvent;
	import flash.utils.Timer;
	import flash.system.Security;

    /**
     * This class
     *
     * @author Matt Bolt, WeakListener(C) 2009
     */
    public class VimeoController {

        //--------------------------------------------------------------------------
        //
        //  Variables
        //
        //--------------------------------------------------------------------------

        /**
         * @private
         * the player container
         */
        private var vimeoContainer:Sprite = new Sprite();

        /**
         * @private
         * the vimeo player mask
         */
		private var vimeoMask:Sprite = new Sprite();

        /**
         * @private
         * the vimeo player api
         */
        private var _vimeoPlayer:Object;

        /**
         * @private
         * the current video id
         */
        private var _currentId:String;

        /**
         * @private
         * the current volume
         */
        private var _currentVolume:int = 75;

        //--------------------------------------------------------------------------
        //
        //  Constructor
        //
        //--------------------------------------------------------------------------

        /**
         * <code>VimeoController</code> Constructor.
         */
        public function VimeoController(vimeoObject:Object, options:VideoPlayerOptions) {
            _vimeoPlayer = vimeoObject;

            new LoadObserver(_vimeoPlayer).observe(function(obj:Object):void {
                _vimeoPlayer.api_setVolume(75);
                _vimeoPlayer.disableMouseMove();


                //handleOptions(options);
            });

            _currentId = options.videoId;
        }

        private function handleOptions(options:VideoPlayerOptions):void{
            if (!options.useChrome) {
                new DisplayObjectUtil
                 DisplayObjectUtil.reverseWalkDisplayObjects(DisplayObject(_vimeoPlayer), function(dispObj:DisplayObject):void {
                    trace(dispObj);

                });
            }
        }

        private function isChrome(displayObject:DisplayObject):Boolean {
            var name:String = displayObject.name;

            return name == "vimeo_logo"
                || name == "timeline"
                || name == "volume"
                || name == "playbar"
                || name == "unlike"
                || name == "like"
                || name == "art"
                || name == "timecode_txt"
                || name == "scaling_button"
                || name == "hd_button"
                || name == "embed_button"
                || name == "share_button"
                || name == "like_button";
        }

        //--------------------------------------------------------------------------
        //
        //  Methods
        //
        //--------------------------------------------------------------------------

        /**
         * This method plays the video.
         */
        public function play():void {
           _vimeoPlayer.api_play();
        }
		
        /**
         * This method pauses the video.
         */
		public function pause():void {
            _vimeoPlayer.api_pause();
        }

        /**
         * This method stops the download of the video.
         */
        public function stop():void {
            _vimeoPlayer.api_unload();
        }

        /**
		 * Seek to specific loaded time in the video (seconds)
		 */
        public function seekTo(newTime:int):void {
            _vimeoPlayer.api_seekTo(newTime);
        }

        /**
         * This method sets the dimensions of the player to the
         * <code>width</code> and <code>height</code> parameters
         *
         * @param	width The new width of the player (in pixels).
         *
         * @param	height The new height of the player (in pixels).
         */
        public function playerDimensions(width:int, height:int):void {
            _vimeoPlayer.api_setSize(width, height);
        }

        //--------------------------------------------------------------------------
        //
        //  Properties
        //
        //--------------------------------------------------------------------------

        /**
         * This property contains the id of the video currently being
         * played (or is loaded).
         */
        public function get videoId():String {
            return _currentId;
        }

        /**
         * @private
         */
        public function set videoId(value:String):void {
            if (_currentId == value) {
                return;
            }

            _currentId = value;
            _vimeoPlayer.api_loadVideo(_currentId);
        }

		/**
		 * This property contains the total duration of the video in
         * seconds.
		 */
		public function get duration():int {
            return _vimeoPlayer.api_getDuration();
        }

        /**
         * This property contains the total elapsed time of the video.
         */
        public function get elapsed():int {
            return _vimeoPlayer.api_getCurrentTime();
        }
		
        /**
         * This property contains a value from 0-100 that represents
         * the level of volume used while playing the video.
         */
        public function get volume():int {
            return _currentVolume;
        }

        /**
         * @private
         */
        public function set volume(value:int):void {
            if (_currentVolume == value) {
                return;
            }

            _currentVolume = checkBounds(value);
            _vimeoPlayer.api_setVolume(_currentVolume);
        }

        /**
         * @private
         * checks the volume bounds
         */
        private function checkBounds(volume:int):int {
            if (volume < 0)
                return 0;
            if (volume > 100)
                return 100;
            return volume;
        }
    }

}

import flash.events.TimerEvent;
import flash.utils.Timer;

/**
 * @private
 * this class observes the player object until it has loaded its next video
 */
internal class LoadObserver {

    internal var object:Object;
    internal var time:Timer;

    public function LoadObserver(obj:Object) {
        object = obj;
    }

    internal function observe(callback:Function):void {
        if (time) {
            return;
        }

        time = new Timer(100, 0);

        function onTimer(event:TimerEvent):void {
            if (object.player_loaded) {
                time.stop();
                time.removeEventListener(TimerEvent.TIMER, onTimer);
                time = null;

                callback(object);
            }
        }

        time.addEventListener(TimerEvent.TIMER, onTimer);
        time.start();
    }
}