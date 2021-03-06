﻿////////////////////////////////////////////////////////////////////////////////
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
    import com.weaklistener.twitter.core.ITweetControllerFactory;
    import com.weaklistener.twitter.core.ITweetFilter;
    import com.weaklistener.twitter.core.ITweetProvider;
    import com.weaklistener.twitter.core.ITweetRenderer;
    
    
    /**
     * This class uses the factory pattern and creates instances of <code>
     * DefaultTweetController</code> objects.
     *
     * @author Matt Bolt
     */
    public class DefaultTweetControllerFactory implements ITweetControllerFactory {
        
        //--------------------------------------------------------------------------
        //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
         * <code>DefaultTweetControllerFactory</code> Constructor.
         */
        public function DefaultTweetControllerFactory() {
            // Empty
        }
        
        //--------------------------------------------------------------------------
        //
        //  Methods
        //
        //--------------------------------------------------------------------------
        
        /**
         * This method returns a new instance of an <code>ITweetController</code>
         * implementation passing these parameters to the controller.
         * 
         * @param	provider The <code>ITweetProvider</code> for providing the
         * tweets.
         * 
         * @param	renderer The <code>ITweetRenderer</code> for displaying the
         * tweets to screen.
         * 
         * @param	filters A <code>Vector.&lt;ITweetFilter&rt;</code> containing
         * all the filters to apply to the tweets
         */
        public function controllerUsing( provider:ITweetProvider, 
                                         renderer:ITweetRenderer, 
                                         filters:Vector.<ITweetFilter> ):ITweetController 
        {
            
            return new DefaultTweetController(provider, renderer, filters);
        }
        
    }
    
}