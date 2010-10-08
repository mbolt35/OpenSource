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
    import com.weaklistener.video.IVideoPlayerLoader;
    import com.weaklistener.video.VideoPlayerOptions;

    import flash.display.MovieClip;
    import flash.events.Event;
    import flash.events.HTTPStatusEvent;
    import flash.events.IOErrorEvent;
    import flash.events.SecurityErrorEvent;
    import flash.system.ApplicationDomain;
    import flash.system.LoaderContext;
    import flash.system.Security;

    import flash.net.URLVariables;
    import flash.display.Loader;
    import flash.net.URLRequest;

    /**
     * This class
     *
     * @author Matt Bolt, WeakListener(C) 2009
     */
    public class VimeoPlayerLoader implements IVideoPlayerLoader {

        //--------------------------------------------------------------------------
        //
        //  Variables
        //
        //--------------------------------------------------------------------------

        /**
         * @private
         * base url for the video player
         */
        private var _baseUrl:String;

        /**
         * @private
         * player url request
         */
        private var _urlRequest:URLRequest;

        /**
         * @private
         * player loader
         */
        private var _loader:Loader;

        //--------------------------------------------------------------------------
        //
        //  Constructor
        //
        //--------------------------------------------------------------------------

        /**
         * <code>VimeoPlayerLoader</code> Constructor.
         */
        public function VimeoPlayerLoader(baseUrl:String) {
            Security.allowDomain("http://bitcast.vimeo.com");

            _baseUrl = baseUrl;
        }

        //--------------------------------------------------------------------------
        //
        //  Methods
        //
        //--------------------------------------------------------------------------

        /**
         * This method loads a video player based on the <code>VideoPlayerOptions</code>
         * instance passed.
         *
         * @param	options The <code>VideoPlayerOptions</code> instance that contains
         * the options used to load/display the video player.
         *
         * @param	callback The <code>Function</code> to call when the player has completed
         * loading. This method requires a signature containing an <code>IVideoPlayer</code>
         * implementation.
         */
        public function loadPlayer(options:VideoPlayerOptions, callback:Function):void {
            _urlRequest = new URLRequest(_baseUrl);
            _urlRequest.data = urlVariablesFor(options);

            _loader = new Loader();

            // Complete Handler
            function onComplete(event:Event):void {
                removeListeners();

                callback(_loader.content);
            }

            // HTTP Status Handler
            function onHttpStatus(event:HTTPStatusEvent):void {
                trace(event.status);
            }

            // I/O Error Handler
            function onIOError(event:IOErrorEvent):void {
                removeListeners();
                callback(null);
            }

            // Security Error Handler
            function onSecurityError(event:SecurityErrorEvent):void {
                removeListeners();
                callback(null);
            }

            // Removes the event listeners
            function removeListeners():void {
                with (_loader.contentLoaderInfo) {
                    removeEventListener(Event.COMPLETE, onComplete);
                    removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
                    removeEventListener(HTTPStatusEvent.HTTP_STATUS, onHttpStatus);
                    removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
                }
            }

            // Listen
            _loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
            _loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
            _loader.contentLoaderInfo.addEventListener(HTTPStatusEvent.HTTP_STATUS, onHttpStatus);
            _loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);

            _loader.load(_urlRequest, new LoaderContext(true, new ApplicationDomain(ApplicationDomain.currentDomain)));
        }

        /**
         * @private
         * converts video player options to url vars
         */
        private function urlVariablesFor(options:VideoPlayerOptions):URLVariables {
            var urlVars:URLVariables = new URLVariables();

            if (options.videoId) {
                urlVars.clip_id = options.videoId;
            }

            if (!options.isFullScreen) {
                urlVars.width = options.playerWidth;
                urlVars.height = options.playerHeight;

                urlVars.fullscreen = 0;
            } else {
                urlVars.fullscreen = 1;
            }

            if (!options.useChrome) {
                urlVars.portrait = 0;
                urlVars.title = 0;
                urlVars.byline = 0;
            }

            return urlVars;
        }

        //--------------------------------------------------------------------------
        //
        //  Properties
        //
        //--------------------------------------------------------------------------

    }

}