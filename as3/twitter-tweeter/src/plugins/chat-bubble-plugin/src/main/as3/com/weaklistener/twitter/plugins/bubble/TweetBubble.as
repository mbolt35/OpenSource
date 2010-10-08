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

package com.weaklistener.twitter.plugins.bubble {
    
    //----------------------------------
    //  imports
    //----------------------------------
    import flash.display.MovieClip;
    import flash.text.TextField;
    
    
    //----------------------------------
    //  meta data
    //----------------------------------
    [Embed(source='/../assets/twitter-assets.swf', symbol='BubbleClip')]
    
    
    /**
     * This class contains the renderable chat bubble that displays tweets.
     *
     * @author Matt Bolt
     */
    public class TweetBubble extends MovieClip {
        
        //--------------------------------------------------------------------------
        //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
         * <code>TweetBubble</code> Constructor.
         */
        public function TweetBubble() {
            // Empty
        }
        
        //--------------------------------------------------------------------------
        //
        //  Properties
        //
        //--------------------------------------------------------------------------
        
        /**
         * This priperty contains the text data from the dynamically read-in tweets.
         */
        public var tweetTF:TextField;
        
        /**
         * This property contains a bubble style tweet container.
         */
        public var bubbleClip:MovieClip;
        
    }
    
}