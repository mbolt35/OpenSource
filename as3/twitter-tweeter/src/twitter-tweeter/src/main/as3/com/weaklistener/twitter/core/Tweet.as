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
    
    /**
     * This class represents a Twitter "Tweet message".
     *
     * @author Matt Bolt
     */
    public class Tweet {
        
        //--------------------------------------------------------------------------
        //
        //  Variables
        //
        //--------------------------------------------------------------------------
        
        /**
         * @private
         * the tweet title (message)
         */
        private var _title:String;
        
        /**
         * @private
         * the tweet description (message repeat - looks to be the same as title)
         */
        private var _description:String;
        
        /**
         * @private
         * the date the tweet was made
         */
        private var _date:String;
        
        /**
         * @private
         * the unique id assigned by twitter
         */
        private var _guid:String;
        
        /**
         * @private
         * the url link to the tweet.
         */
        private var _link:String;
        
        //--------------------------------------------------------------------------
        //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
         * <code>Tweet</code> Constructor.
         */
        public function Tweet(title:String, description:String, date:String, guid:String, link:String) {
            _title = title;
            _description = description;
            _date = date;
            _guid = guid;
            _link = link;
        }
        
        //--------------------------------------------------------------------------
        //
        //  Generics
        //
        //--------------------------------------------------------------------------
        
        /**
         * This method converts this object instance into a <code>String</code>.
         */
        public function toString():String {
            return _title;
        }
        
        /**
         * This method duplicates the data inside this object instance and returns
         * a new instance containing the duplicated data.
         */
        public function clone():Tweet {
            return new Tweet( _title,
                              _description, 
                              _date, 
                              _guid,
                              _link );
        }
        
        //--------------------------------------------------------------------------
        //
        //  Properties
        //
        //--------------------------------------------------------------------------
        
        /**
         * The title of the tweet (message).
         */
        public function get title():String { 
            return _title; 
        }
        
        /**
         * The description of the tweet (message - same as title ?)
         */
        public function get description():String { 
            return _description; 
        }
        
        /**
         * The date and time the tweet was made.
         */
        public function get date():String { 
            return _date; 
        }
        
        /**
         * The unique identifier assigned by twitter to the tweet.
         */
        public function get guid():String { 
            return _guid; 
        }
        
        /**
         * A link to the url containing this tweet.
         */
        public function get link():String { 
            return _link; 
        }
        
    }
    
}