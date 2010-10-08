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
    
    //----------------------------------
    //  imports
    //----------------------------------
    import com.weaklistener.twitter.core.ITweetFilter;
    import com.weaklistener.twitter.core.Tweet;
    
    /**
     * This class is used to filter the user name from the tweet. ie: "mbolt35: tweet tweet tweet!"
     * becomes "tweet tweet tweet!."
     *
     * @author Matt Bolt
     */
    public class TweetUserNameFilter implements ITweetFilter {
        
        //--------------------------------------------------------------------------
        //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
         * <code>TweetUserNameFilter</code> Constructor.
         */
        public function TweetUserNameFilter() {
            // Empty
        }
        
        //--------------------------------------------------------------------------
        //
        //  Methods
        //
        //--------------------------------------------------------------------------
        
        /**
         * This method filters a <code>Tweet</code> based on the implementation and returns a copy
         * of that <code>Tweet</code>.
         * 
         * @param	tweet The <code>Tweet</code> in which you wish you filter.
         * 
         * @return  a cloned <code>Tweet</code> object containing the filtered message.
         */
        public function applyTo(tweet:Tweet):Tweet {
            return new Tweet( removeUserName(tweet.title),
                              tweet.description,
                              tweet.date, 
                              tweet.guid,
                              tweet.link );
        }
        
        /**
         * @inheritDoc
         */
        public function toString():String {
            return "[TweetUserNameFilter instance]";
        }
        
        /**
         * @private
         * filters the user name
         */
        private function removeUserName(message:String):String {
            var index:int = message.indexOf(':');
            if (index == -1)
                return message;
            return message.substr(index + 2, message.length - 1);
        }
        
        //--------------------------------------------------------------------------
        //
        //  Properties
        //
        //--------------------------------------------------------------------------
        
        /**
         * This property is set to <code>true</code> if the filter formats the <code>
         * Tweet</code> in HTML.
         */
        public function get htmlFormatting():Boolean {
            return false;
        }
        
    }
    
}