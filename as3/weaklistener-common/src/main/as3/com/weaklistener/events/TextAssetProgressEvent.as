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
     * This event class dispatches containg load progress information.
     * 
     * @author Matt Bolt
     */
    public class TextAssetProgressEvent extends Event {
        
        //--------------------------------------------------------------------------
        //
        //  Event Types
        //
        //--------------------------------------------------------------------------
        
        /**
         * This event dispatches when loading a <code>TextAsset</code> containing
         * byte-level load information.
         * 
         * @eventType textLoadProgress
         */
        public static const TEXT_LOAD_PROGRESS:String = "textLoadProgress";
        
        //--------------------------------------------------------------------------
        //
        //  Variables
        //
        //--------------------------------------------------------------------------
        
        /**
         * @private
         * bytes loaded thus far.
         */
        private var _bytesLoaded:Number = 0;
        
        /**
         * @private
         * total bytes to load.
         */
        private var _totalBytes:Number = 0;
        
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
         * @param bubbles Specifies whether the event can bubble up the display list hierarchy.
         *
         * @param cancelable Specifies whether the behavior associated with 
         * the event can be prevented.
         */
        public function TextAssetProgressEvent(type:String, bytesLoaded:Number, totalBytes:Number, bubbles:Boolean=false, cancelable:Boolean=false) { 
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
            return new TextAssetProgressEvent(type, _bytesLoaded, _totalBytes, bubbles, cancelable);
        } 
        
        /**
         * @inheritDoc
         */
        public override function toString():String { 
            return formatToString("TextAssetProgressEvent", "type", "bytesLoaded", "totalBytes", "bubbles", "cancelable", "eventPhase"); 
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
         * The bytes loaded thus far.
         */
        public function get bytesLoaded():Number {
            return _bytesLoaded;
        }
        
        /**
         * The total bytes to load.
         */
        public function get totalBytes():Number {
            return _totalBytes;
        }
    }
    
}