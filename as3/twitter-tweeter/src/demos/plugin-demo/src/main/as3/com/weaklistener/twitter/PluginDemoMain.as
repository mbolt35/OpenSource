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

package com.weaklistener.twitter {
    
    //----------------------------------
    //  imports
    //----------------------------------
    import com.weaklistener.twitter.basic.textFieldRenderer;
    import com.weaklistener.twitter.basic.defaultController;
    import com.weaklistener.twitter.basic.rssProvider;
    import com.weaklistener.twitter.core.ITweetFilter;
    import com.weaklistener.twitter.filters.htmlFilter;
    import com.weaklistener.twitter.filters.TweetHtmlFilter;
    import com.weaklistener.twitter.filters.TweetUserNameFilter;
    import com.weaklistener.twitter.filters.userNameFilter;
    import com.weaklistener.twitter.plugins.bubble.bubbleRenderer;
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.events.TimerEvent;
    import flash.system.Security;
    import flash.utils.setInterval;
    import flash.utils.Timer;
    
    /**
     * This class 
     *
     * @author Matt Bolt
     */
    public class PluginDemoMain extends Sprite {
        
        //--------------------------------------------------------------------------
        //
        //  Variables
        //
        //--------------------------------------------------------------------------
        
        /**
         * @private
         * twitter tweeter
         */
        private var _twitterTweeter:TwitterTweeter;
        
        /**
         * @private
         * render canvas for mbolt35's tweets
         */
        private var _mattTweets:DisplayObject;
        
        /**
         * @private
         * interval id
         */
        private var _intervalId:int;
        
        //--------------------------------------------------------------------------
        //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
         * <code>PluginDemoMain</code> Constructor.
         */
        public function PluginDemoMain() {
            addChild(new TwitterTweeterLogo());
            initialize();
        }
        
        //--------------------------------------------------------------------------
        //
        //  Methods
        //
        //--------------------------------------------------------------------------
        
        /**
         * @private
         * initializes twitter tweeter framework.
         */
        private function initialize():void {
            
            Security.allowDomain("*");
            Security.allowInsecureDomain("*");
            Security.loadPolicyFile("http://www.bolt3d.org/crossdomain.xml");
            
            new TwitterTweeterBuilder()
                .tweetsProvidedBy(rssProvider())
                .filteredBy(htmlFilter(), userNameFilter())
                .renderedBy(bubbleRenderer()) // .renderedBy(textFieldRenderer()) <= Default
                .controlledBy(defaultController())
                .build(onTwitterTweeterBuilt);
                
        }
        
        /**
         * @private
         */
        private function onTwitterTweeterBuilt(twitterTweeter:TwitterTweeter):void {
            _twitterTweeter = twitterTweeter;
            _twitterTweeter.controlTweetsFor("mbolt35", 50);
            
            _intervalId = setInterval(tick, 5000);
            
            _mattTweets = _twitterTweeter.tweetRenderCanvasFor("mbolt35");
            _mattTweets.x = 400;
            _mattTweets.y = 25;
            
            tick();
            
            addChild(_mattTweets);
        }
        
        /**
         * @private
         */
        private function tick():void {
            _twitterTweeter.nextTweetFor("mbolt35");
        }
        
        //--------------------------------------------------------------------------
        //
        //  Properties
        //
        //--------------------------------------------------------------------------
        
    }
    
}