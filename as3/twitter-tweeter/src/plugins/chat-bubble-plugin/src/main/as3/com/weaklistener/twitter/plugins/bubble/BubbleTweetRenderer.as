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
    import com.weaklistener.twitter.core.ITweetRenderer;
    import com.weaklistener.twitter.core.Tweet;
    import flash.display.DisplayObject;
    import flash.display.Sprite;
    import flash.text.StyleSheet;
    import flash.text.TextFieldAutoSize;

    
    /**
     * This class controls the render
     *
     * @author Matt Bolt
     */
    public class BubbleTweetRenderer implements ITweetRenderer {
        
        //--------------------------------------------------------------------------
        //
        //  Variables
        //
        //--------------------------------------------------------------------------
        
        /**
         * @private
         * container holding the renderables
         */
        private var _canvas:Sprite = new Sprite();
        
        /**
         * @private
         * chat bubble tweet render
         */
        private var _tweetBubble:TweetBubble = new TweetBubble();
        
        //--------------------------------------------------------------------------
        //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
         * <code>BubbleTweetRenderer</code> Constructor.
         */
        public function BubbleTweetRenderer() {
            _canvas.addChild( initBubble(_tweetBubble) );
        }
        
        //--------------------------------------------------------------------------
        //
        //  Methods
        //
        //--------------------------------------------------------------------------
        
        /**
         * @inheritDoc
         */
        public function render(tweet:Tweet):void {
            _tweetBubble.tweetTF.htmlText = tweet.title;
            
            _tweetBubble.bubbleClip.width = _tweetBubble.tweetTF.textWidth + 20;
            _tweetBubble.bubbleClip.height = _tweetBubble.tweetTF.textHeight + 40;
            
            _tweetBubble.y = 0; // -_tweetBubble.bubbleClip.height / 2;
        }
        
        /**
         * @private
         * initializes the tweet bubble
         */
        private function initBubble(bubble:TweetBubble):DisplayObject {
            
            bubble.tweetTF.autoSize = TextFieldAutoSize.LEFT;
            bubble.tweetTF.text = "";
            
            bubble.tweetTF.styleSheet = new StyleSheet();
            bubble.tweetTF.styleSheet.setStyle("a:link", {
                fontWeight: "bold", 
                textDecoration: "none", 
                fontSize: 14, 
                color: "#4CB8E6" 
            });
            bubble.tweetTF.styleSheet.setStyle("a:hover", {
                fontWeight: "bold",
                textDecoration: "underline",
                fontSize: 14,
                color: "#4CB8E6"
            });
            
            return bubble;
        }
        
        //--------------------------------------------------------------------------
        //
        //  Properties
        //
        //--------------------------------------------------------------------------
        
        /**
         * This property contains the renderable Tweet.
         */
        public function get canvas():DisplayObject {
            return _canvas;
        }
        
    }
    
}