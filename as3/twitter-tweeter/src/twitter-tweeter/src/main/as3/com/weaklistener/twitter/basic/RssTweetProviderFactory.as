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
    import com.weaklistener.twitter.core.ITweetProvider;
    import com.weaklistener.twitter.core.ITweetProviderFactory;
    
    
    /**
     * This class uses the factory pattern and creates instances of <code>
     * RssTweetProvider</code> objects.
     *
     * @author Matt Bolt
     */
    public class RssTweetProviderFactory implements ITweetProviderFactory {

        //--------------------------------------------------------------------------
        //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
         * <code>RssTweetProviderFactory</code> Constructor.
         */
        public function RssTweetProviderFactory() {
            // Empty
        }
        
        //--------------------------------------------------------------------------
        //
        //  Methods
        //
        //--------------------------------------------------------------------------
        
        /**
         * This method returns a new instance of an <code>ITweetProvider</code> 
         * implementation.
         */
        public function tweetProvider():ITweetProvider {
            return new RssTweetProvider();
        }
        
    }
    
}