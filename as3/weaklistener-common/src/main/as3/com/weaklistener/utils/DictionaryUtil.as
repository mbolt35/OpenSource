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
    
    import flash.utils.Dictionary;
    
    /**
     * This class assets with specific <code>Dictionary</code> functionality.
     * 
     * @author Matt Bolt
     */
    public class DictionaryUtil {
        
        //--------------------------------------------------------------------------
        //
        //  Methods
        //
        //--------------------------------------------------------------------------
        
        /**
         * This static function returns an <code>Array</code> conversion of a 
         * <code>Dictionary</code>.
         * 
         * @param    dictionary The <code>Dictionary</code> to convert to an <code>Array</code>.
         * 
         * @return  A <code>Array</code> that contains the elements of the <code>dictionary</code>
         * paramter.
         */
        public static function arrayConversionFor(dictionary:Dictionary):Array {
            var arr:Array = [];
            if (!dictionary) {
                return arr;
            }
            for each (var obj:* in dictionary) {
                arr.push(obj);
            }
            return arr;
        }
        
        /**
         * This static function disposes of all <code>Dictionary</code> key objects
         * and will recursively call any nested <code>Dictionary</code> objects.
         * 
         * @param    ...dictionaries <code>Dictionary</code> objects to dispose of.
         */
        public static function disposeOf(...dictionaries):void {
            for each (var dictionary:Dictionary in dictionaries) {
                for (var key:String in dictionary) {
                    if (dictionary[key] is Dictionary)
                        disposeOf(dictionary[key]);
                    delete dictionary[key];
                }
                dictionary = null;
            }
        }
        
    }
    
}