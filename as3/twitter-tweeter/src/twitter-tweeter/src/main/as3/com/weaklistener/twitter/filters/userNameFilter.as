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

package com.weaklistener.twitter.filters {
    
    import com.weaklistener.twitter.core.ITweetFilter;
    
    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    /**
     * This function returns a new instance of a <code>TweetUserNameFilter</code>.
     * 
     * @author Matt Bolt
     */
    public function userNameFilter():ITweetFilter {
        return new TweetUserNameFilter();
    }
    
}