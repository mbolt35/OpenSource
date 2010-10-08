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
     * This interface defines an implementation prototype which filters <code>Tweet</code>s
     * for more detailed processing.
     * 
     * @author Matt Bolt
     */
    public interface ITweetFilter {
        
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
         * @return  a <code>Tweet</code> instance containing the filtered contents.
         */
        function applyTo(tweet:Tweet):Tweet;
        
        /**
         * This method converts the implementing class into a <code>String</code>.
         * 
         * @return  The <code>String</code> representation of the implementing class.
         */
        function toString():String;
        
        //--------------------------------------------------------------------------
        //
        //  Properties
        //
        //--------------------------------------------------------------------------
        
        /**
         * This property is set to <code>true</code> if the filter formats the <code>
         * Tweet</code> in HTML.
         */
        function get htmlFormatting():Boolean;

    }
    
}