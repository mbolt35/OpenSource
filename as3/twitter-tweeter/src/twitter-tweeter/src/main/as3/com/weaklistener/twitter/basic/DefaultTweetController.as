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

package com.weaklistener.twitter.basic {
    
    //----------------------------------
    //  imports
    //----------------------------------
    import com.weaklistener.twitter.core.ITweetController;
    import com.weaklistener.twitter.core.ITweetFilter;
    import com.weaklistener.twitter.core.ITweetProvider;
    import com.weaklistener.twitter.core.ITweetRenderer;
    import com.weaklistener.twitter.core.Tweet;
    import com.weaklistener.twitter.core.TweetFilterApplicator;
    
    /**
     * This class 
     *
     * @author Matt Bolt
     */
    public class DefaultTweetController implements ITweetController {
        
        //--------------------------------------------------------------------------
        //
        //  Variables
        //
        //--------------------------------------------------------------------------
        
        /**
         * @private
         * the tweet provider
         */
        private var _tweetProvider:ITweetProvider;
        
        /**
         * @private
         * the tweet renderer
         */
        private var _tweetRenderer:ITweetRenderer;
        
        /**
         * @private
         * filtered tweets
         */
        private var _tweets:Vector.<Tweet>;
        
        /**
         * @private
         * the tweet filters.
         */
        private var _tweetFilters:Vector.<ITweetFilter>;
        
        /**
         * @private
         * the index
         */
        private var _currentIndex:int = 0;
        
        //--------------------------------------------------------------------------
        //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
         * <code>DefaultTweetController</code> Constructor.
         */
        public function DefaultTweetController( provider:ITweetProvider, 
                                                renderer:ITweetRenderer, 
                                                filters:Vector.<ITweetFilter> ) 
        {
            _tweetProvider = provider;
            _tweetRenderer = renderer;
            _tweetFilters = filters;
        }
        
        //--------------------------------------------------------------------------
        //
        //  Methods
        //
        //--------------------------------------------------------------------------
        
        /**
         * This method initializes the tweets for a specific user.
         * 
         * @param	userName The user name to gather the tweet information for.
         * 
         * @param   count The amount of tweets to initialize for the user.
         */
        public function initializeTweetsFor(userName:String, count:uint):void {
            
            _tweetProvider.tweetsFor(userName, count, function(tweets:Vector.<Tweet>):void {
                _tweets = new TweetFilterApplicator().apply( _tweetFilters, tweets );
                
                if (_tweets && _tweets.length != 0) {
                    _tweetRenderer.render( _tweets[_currentIndex] );
                }
            });
            
        }
        
        /**
         * This method will forward the tweet message to the next one available.
         */
        public function nextTweet():void {
            if (!_tweets || _tweets.length == 0) {
                return;
            }
            
            _currentIndex = _currentIndex + 1 == _tweets.length ?
                            0 :
                            _currentIndex + 1;
            
            _tweetRenderer.render( _tweets[_currentIndex] );
        }
        
        /**
         * This method will rewind the tweet messages to the previous one available.
         */
        public function previousTweet():void {
            if (!_tweets || _tweets.length == 0) {
                return;
            }
            
            _currentIndex = _currentIndex -1 < 0 ?
                            _tweets.length - 1 :
                            _currentIndex - 1;
            
            _tweetRenderer.render( _tweets[_currentIndex] );
        }
        
        /**
         * This method releases control for a user.
         */
        public function release():void {
            _tweetProvider = null;
            _tweetRenderer = null;
            _tweets.length = 0;
        }
        
        //--------------------------------------------------------------------------
        //
        //  Properties
        //
        //--------------------------------------------------------------------------
        
        /**
         * This property contains an instance of the <code>ITweetRenderer</code> used
         * to render the tweets.
         */
        public function get renderer():ITweetRenderer {
            return _tweetRenderer;
        }
    }
    
}