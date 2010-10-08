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

package com.weaklistener.utils {
    
    import flash.net.URLRequest;
    
    /**
     * This class contains tools used for processing URLs.
     *
     * @author Matt Bolt
     */
    public class UrlUtil {
        
        //--------------------------------------------------------------------------
        //
        //  Constants
        //
        //--------------------------------------------------------------------------
        
        /**
         * This constant is used as a <code>navigateToUrl</code> target to follow a link in a new page.
         */
        public static const BLANK:String = "_blank";
        
        /**
         * This constant is used as a <code>navigateToUrl</code> target to follow a link in a same page.
         */
        public static const SELF:String = "_self";
        
        /**
         * This regular expression is used to verify a qualified url.
         */
        private static const ABSOLUTE_URL:RegExp = /^(https?|file|rtmp):(\/\/|\\\\)/i;
        
        /**
         * This regular expression will recognize any illegal "//" in a url.
         */
        private static const DOUBLE_SLASH:RegExp = /([^:\/])(\/\/)|(\\\\)/gi;
        
        //--------------------------------------------------------------------------
        //
        //  Methods
        //
        //--------------------------------------------------------------------------
        
        /**
         * This static function will accept a <code>String</code> url and ensure that
         * a "//" format does not exist (omitting the protocol "//").
         * 
         * @param    url A path possibly containing a double-slash.
         * 
         * @return  a <code>String</code> containing the url with the double slashes 
         * removed.
         */
        public static function trimDoubleSlashes(url:String):String {
            return url.replace( DOUBLE_SLASH, function():String { 
                return String(arguments[1].charAt(0)).concat('/');
            });
        }
        
        /**
         * Returns true if an URL is absolute (versus relative) and currently supports the 
         * following protocols: HTTP, HTTPS, FILE, RTMP
         * 
         * <p>The regular expression is verified against <code>[PROTOCOL]://</code> or <code>[PROTOCOLO]:\\</code>.
         * 
         * @example
         * <listing>
         * if (UrlUtil.isAbsolute("http://www.google.com")) {
         *     trace('http://www.google.com is absolute!');
         * }
         * </listing>
         */
        public static function isAbsolute(url:String):Boolean {
            return ABSOLUTE_URL.test(url);
        }
    }
    
}