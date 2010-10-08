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
    import flash.display.MovieClip;
    
    //----------------------------------
    //  meta data
    //----------------------------------
    [Embed(source='/../assets/assets.swf', symbol='TwitterTweeterLogo')]
    
    
    /**
     * This class represents the twitter tweeter logo.
     *
     * @author Matt Bolt
     */
    public class TwitterTweeterLogo extends MovieClip {
        
        //--------------------------------------------------------------------------
        //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
         * <code>TwitterTweeterLogo</code> Constructor.
         */
        public function TwitterTweeterLogo() {
            super();
            cacheAsBitmap = true;
        } 
        
    }
    
}