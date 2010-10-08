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
    
    /**
     * This class contains useful <code>String</code> functionality.
     *
     * @author Matt Bolt
     */
    public class StringUtil {
        
        //--------------------------------------------------------------------------
        //
        //  Constant
        //
        //--------------------------------------------------------------------------
        
        /**
         * @private
         * This regular expression will parse tokens '${token}' where token can be any 
         * length <code>String</code> containing characters a-z, A-Z, and 0-9. 
         */
        private static const GENERIC_TOKEN:RegExp = /\$\{([a-zA-Z0-9_]+)\}/g;
        
        //--------------------------------------------------------------------------
        //
        //  Methods
        //
        //--------------------------------------------------------------------------
        
        /**
         * This function will substitute tags/tokens in a string with corresponding properties of the tags object.
         * 
         * @param    str This is the string to parse
         * 
         * @param    tags This object is where the token values will be pulled .
         * 
         * @return    A string with the ${myToken} values replaced with the values in the object parameter where
         * "myToken" is a property of that object.
         */
        public static function substitute(str:String, tags:Object):String {
            return str.replace( 
                GENERIC_TOKEN, 
                function():String { 
                    return tags[ arguments[1] ] 
                });
        }
        
    }
    
}