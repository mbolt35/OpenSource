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
    import com.weaklistener.twitter.core.ITweetController;
    import com.weaklistener.twitter.core.ITweetControllerFactory;
    import com.weaklistener.twitter.core.ITweetFilter;
    import com.weaklistener.twitter.core.ITweetProvider;
    import com.weaklistener.twitter.core.ITweetProviderFactory;
    import com.weaklistener.twitter.core.ITweetRenderer;
    import com.weaklistener.twitter.core.ITweetRendererFactory;
    import flash.display.DisplayObject;
    import flash.display.MovieClip;
    import flash.utils.Dictionary;
    
    /**
     * This class follows the proxy pattern and is the primary method of message 
     * transport to the controller.
     *
     * @author Matt Bolt
     */
    public class TwitterTweeter {
        
        //--------------------------------------------------------------------------
        //
        //  Variables
        //
        //--------------------------------------------------------------------------
        
        /**
         * @private
         * tweet controller
         */
        private var _controller:ITweetControllerFactory;
        
        /**
         * @private
         * tweet renderer
         */
        private var _renderer:ITweetRendererFactory;
        
        /**
         * @private
         * tweet provider
         */
        private var _provider:ITweetProviderFactory;
        
        /**
         * @private
         * a vector of tweet controllers
         */
        private var _tweetControllers:Vector.<ITweetController> = new Vector.<ITweetController>();
        
        /**
         * @private
         * tweet filters
         */
        private var _tweetFilters:Vector.<ITweetFilter>;
        
        /**
         * @private
         * hash-table lookup for controllers
         */
        private var _controllerHash:Dictionary = new Dictionary();
        
        //--------------------------------------------------------------------------
        //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
         * <code>TwitterTweeter</code> Constructor.
         */
        public function TwitterTweeter( providerFactory:ITweetProviderFactory,
                                        rendererFactory:ITweetRendererFactory,
                                        controllerFactory:ITweetControllerFactory,
                                        filters:Vector.<ITweetFilter> ) 
        {
            _provider = providerFactory;
            _renderer = rendererFactory;
            _controller = controllerFactory;
            _tweetFilters = filters;
        }
        
        //--------------------------------------------------------------------------
        //
        //  Methods
        //
        //--------------------------------------------------------------------------
        
        /**
         * This method beings controlling the tweets for a specific Twitter user name
         * 
         * @param    userName The user name to control tweets for.
         */
        public function controlTweetsFor(userName:String, count:int = 50):void {
            
            // Create controller
            var tweetController:ITweetController = 
                _controller.controllerUsing( _provider.tweetProvider(), 
                                             _renderer.tweetRenderer(),
                                             _tweetFilters );
            // Push new Controller
            _tweetControllers.push(tweetController);
            _controllerHash[userName] = tweetController;
            
            // Initialize Controller
            tweetController.initializeTweetsFor(userName, count);
            
        }
        
        /**
         * This method releases the controller for a specific Twitter user name.
         * 
         * @param    userName The Twitter user's name to release the controller for.
         */
        public function releaseControlFor(userName:String):void {
            if (!_controllerHash[userName]) {
                return;
            }
            
            // Splice Vector.<ITweetController> and release it
            _tweetControllers.splice( 
                _tweetControllers.indexOf( _controllerHash[userName] ),
                1)
                [0].release();
                
            // Remove from Hash Table
            delete _controllerHash[userName];
            
        }
        
        /**
         * Get the <code>DisplayObject</code> containing the render canvas for 
         * a Twitter user.
         */
        public function tweetRenderCanvasFor(userName:String):DisplayObject {
            if (!_controllerHash[userName]) {
                return null;
            }
            
            return ITweetController(_controllerHash[userName]).renderer.canvas;
        }
        
        /**
         * This method renders the next tweet message for the specified user.
         * 
         * @param    userName The Twitter user id to render the next tweet 
         * for.
         */
        public function nextTweetFor(userName:String):void {
            if (!_controllerHash[userName]) {
                return;
            }
            
            ITweetController(_controllerHash[userName]).nextTweet();
        }
        
        /**
         * This method renders the previous tweet message for the specified user.
         * 
         * @param    userName The Twitter user id to render the previous tweet 
         * for.
         */
        public function previousTweetFor(userName:String):void {
            if (!_controllerHash[userName]) {
                return;
            }
            
            ITweetController(_controllerHash[userName]).previousTweet();
        }
        
        //--------------------------------------------------------------------------
        //
        //  Properties
        //
        //--------------------------------------------------------------------------
    }
    
}