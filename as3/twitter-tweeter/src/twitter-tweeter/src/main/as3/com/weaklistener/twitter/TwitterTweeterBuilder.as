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
    
    
    /**
     * This class uses the builder pattern and creates a <code>TwitterTweeter</code> 
     * instance based on the paramters passed during the build.
     * 
     * <p><strong>In order to reduce headaches, the builder should be implemented based 
     * on the example provided.</strong></p>
     * 
     * @example
     * This example demonstrates how one should implement this class:
     * <listing version="3.0">
     * private var _twitterTweeter:TwitterTweeter;
     * 
     * // ...
     * 
     * new TwitterTweeterBuilder()
     *    .tweetsProvidedBy(rssProvider())
     *    .filteredBy(htmlFilter(), userNameFilter())
     *    .renderedBy(textFieldRenderer())
     *    .controlledBy(defaultController())
     *    .build(function(tweeter:TwitterTweeter):void {
     *         _twitterTweeter = tweeter;
     * 
     *         // Initialization, processing, etc... *you* define.
     *         initialize(_twitterTweeter); 
     *     });
     * </listing>
     * 
     * @author Matt Bolt
     */
    public class TwitterTweeterBuilder {
        
        //--------------------------------------------------------------------------
        //
        //  Variables
        //
        //--------------------------------------------------------------------------
        
        /**
         * @private
         * tweet provider
         */
        private var _providerFactory:ITweetProviderFactory;
        
        /**
         * @private
         * tweet renderer factory
         */
        private var _rendererFactory:ITweetRendererFactory;
        
        /**
         * @private
         * tweet controller factory
         */
        private var _controllerFactory:ITweetControllerFactory;
        
        /**
         * @private
         * tweet filters
         */
        private var _filters:Vector.<ITweetFilter>;
        
        //--------------------------------------------------------------------------
        //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
         * <code>TwitterTweeterBuilder</code> Constructor.
         */
        public function TwitterTweeterBuilder() {
            // Empty
        }
        
        //--------------------------------------------------------------------------
        //
        //  Methods
        //
        //--------------------------------------------------------------------------
        
        /**
         * This method sets the <code>ITweetProviderFactory</code> implementation and returns
         * the builder instance used to call the method. This method is to be imeplemented
         * using the builder pattern.
         * 
         * @param    provider An <code>ITweetProviderFactory</code> implementation.
         */
        public function tweetsProvidedBy(provider:ITweetProviderFactory):TwitterTweeterBuilder {
            _providerFactory = provider;
            
            return this;
        }
        
        /**
         * This method sets the filters, <code>ITweetFilter</code> implementations that
         * will be processed on all the tweets.
         * 
         * @param    filters a <code>Vector.&lt;ITweetFilter&gt;</code> containing filters
         * to apply.
         */
        public function filteredBy(...filters):TwitterTweeterBuilder {
            _filters = Vector.<ITweetFilter>(filters);
            
            return this;
        }
        
        /**
         * This method sets the <code>ITweetRendererFactory</code> implementation and returns 
         * the builder instance used to call the method. This method is to be implemented 
         * using the builder pattern.
         * 
         * @param    renderer An <code>ITweetRendererFactory</code> implementation.
         */
        public function renderedBy(renderer:ITweetRendererFactory):TwitterTweeterBuilder {
            _rendererFactory = renderer;
            
            return this;
        }
        
        /**
         * This method sets the <code>ITweetControllerFactory</code> implemenation and returns
         * the builder instance used to call the method. This method is to be implemented
         * using the builder pattern.
         * 
         * @param    controller An <code>ITweetControllerFactory</code> implementation.
         */
        public function controlledBy(controller:ITweetControllerFactory):TwitterTweeterBuilder {
            _controllerFactory = controller;
            
            return this;
        }
        
        /**
         * 
         * @param    callback
         */
        public function build(callback:Function):void {
            
            check( _providerFactory, 
                  "Provider is not set - " + 
                  "Use TwitterTweeterBuilder::tweetsProvidedBy(ITweetProviderFactory)." );
                  
            check( _rendererFactory, 
                  "Renderer is not set - " + 
                  "Use TwitterTweeterBuilder::renderedBy(ITweetRendererFactory)." );
                  
            check( _controllerFactory, 
                  "Controller is not set - " + 
                  "Use TwitterTweeterBuilder::controlledBy(ITweetControllerFactory)." );
            
            callback(new TwitterTweeter( _providerFactory, 
                                         _rendererFactory,
                                         _controllerFactory,
                                         _filters ));
        }
        
        /**
         * @private
         * checks the builder component and throws an error if the object is null.
         */
        private function check(obj:*, error:String):void {
            if (!obj) {
                throw new Error(error);
            }
        }
        
    }
    
}