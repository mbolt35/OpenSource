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
     * This class 
     *
     * @author Matt Bolt
     */
    public class TweetHtmlFilter implements ITweetFilter {
        
        //--------------------------------------------------------------------------
        //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
         * <code>TweetHtmlFilter</code> Constructor.
         */
        public function TweetHtmlFilter() {
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
         * @return  a cloned <code>Tweet</code> object containing an html filtered message.
         */
        public function applyTo(tweet:Tweet):Tweet {
            return new Tweet( htmlTextFor(tweet.title),
                              tweet.description,
                              tweet.date, 
                              htmlTextFor(tweet.guid),
                              htmlTextFor(tweet.link) );
        }
        
        /**
         * @inheritDoc
         */
        public function toString():String {
            return "[TweetHtmlFilter instance]";
        }
        
        /**
         * @private
         * converts plain text url links with html formatted links.
         */
        private function htmlTextFor(plainText:String):String {
            return plainText
               .replace(/\\swww./ig, "http://www.")
               .replace(/^www./ig, "http://www.")
               .replace(/(@[a-zA-Z0-9_]*)/ig, "<font color='#4CB8E6'>$1</font>")
               .replace(/(https:\/\/|http:\/\/|ftp:\/\/|www\.)([a-zA-Z0-9\.-_=\?&]*)/ig, 
                        "<a href='$1$2' target='_blank'>$1$2</a>");
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
            return true;
        }
        
    }
    
}