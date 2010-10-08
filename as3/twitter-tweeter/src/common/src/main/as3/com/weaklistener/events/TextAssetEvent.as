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

package com.weaklistener.events {
    
    import com.weaklistener.loaders.TextAsset;
    import flash.events.Event;
    
    /**
     * This event class dispatches when a <code>TextAsset</code> loading action
     * occurs.
     * 
     * @author Matt Bolt
     */
    public class TextAssetEvent extends Event {
        
        //--------------------------------------------------------------------------
        //
        //  Event Types
        //
        //--------------------------------------------------------------------------
        
        /**
         * This event type dispatches upon a load completion - It will dispatch on a
         * load success <strong>OR</strong> failure.
         * 
         * @eventType   textLoadComplete
         * 
         * @see success
         */
        public static const TEXT_LOAD_COMPLETE:String = "textLoadComplete";
        
        //--------------------------------------------------------------------------
        //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
         * Constructor.
         *
         * @param type The event type; indicates the action that caused the event.
         * 
         * @param textAsset The <code>TextAsset</code> associated with the event.
         * 
         * @param bubbles Specifies whether the event can bubble up the display list 
         * hierarchy.
         *
         * @param cancelable Specifies whether the behavior associated with 
         * the event can be prevented.
         */
        public function TextAssetEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) { 
            super(type, bubbles, cancelable);
        } 
        
        //--------------------------------------------------------------------------
        //
        //  Override Methods: Event
        //
        //--------------------------------------------------------------------------
        
        /**
         * @inheritDoc
         */
        public override function clone():Event { 
            return new TextAssetEvent(type, bubbles, cancelable);
        } 
        
        /**
         * @inheritDoc
         */
        public override function toString():String { 
            return formatToString("TextAssetEvent", "type", "bubbles", "cancelable", "eventPhase"); 
        }
        
        //--------------------------------------------------------------------------
        //
        //  Properties
        //
        //--------------------------------------------------------------------------
        
        /**
         * The <code>TextAsset</code> being loaded.
         */
        public function get asset():TextAsset {
            return super.target as TextAsset;
        }
        
        /**
         * The <code>TextAsset</code> load status.
         */
        public function get success():Boolean {
            var textAsset:TextAsset = super.target as TextAsset;
            return textAsset && textAsset.success;
        }
    }
    
}