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

package com.weaklistener.twitter.core {
    
    //----------------------------------
    //  imports
    //----------------------------------
    import com.weaklistener.twitter.core.ITweetFilter;
    import com.weaklistener.twitter.core.Tweet;
    
    /**
     * This class represents an object who's sole purpose is to apply tweet filters 
     * to tweets using the <code>apply</code> method.
     *
     * @author Matt Bolt
     */
    public class TweetFilterApplicator {
        
        //--------------------------------------------------------------------------
        //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
         * <code>TweetFilterApplicator</code> Constructor.
         */
        public function TweetFilterApplicator() {
            // Emptyu
        }
        
        //--------------------------------------------------------------------------
        //
        //  Methods
        //
        //--------------------------------------------------------------------------
        
        /**
         * This method is used to apply a <code>Vector</code> of <code>ITweetFilter
         * </code>s to a <code>Vector</code> of <code>Tweet</code>s.
         * 
         * @param	filters the <code>Vector</code> of <code>ITweetFilter</code> to 
         * apply.
         * 
         * @param	toTweets the <code>Vector</code> of <code>Tweet</code>s to apply
         * the filters to.
         * 
         * @return  a new <code>Vector</code> of <code>Tweet</code>s containing the 
         * filtered tweets.
         */
        public function apply( filters:Vector.<ITweetFilter>, 
                               toTweets:Vector.<Tweet> ):Vector.<Tweet> 
        {
            if (!filters || filters.length == 0) {
                return toTweets.concat();
            }
            
            var filteredTweets:Vector.<Tweet> = new Vector.<Tweet>(toTweets.length, true);
            var index:int = 0;
            
            for each (var tweet:Tweet in toTweets) {
                var tweetClone:Tweet = tweet.clone();
                for each (var filter:ITweetFilter in filters) {
                    tweetClone = filter.applyTo(tweetClone);
                }
                
                filteredTweets[index++] = tweetClone;
            }
            
            return filteredTweets;
        }
        
    }
    
}