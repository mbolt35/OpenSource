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

package com.weaklistener.loaders {
    
    //----------------------------------
    //  imports
    //----------------------------------
    import com.weaklistener.events.TextAssetEvent;
    import com.weaklistener.events.TextAssetProgressEvent;
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.HTTPStatusEvent;
    import flash.events.IEventDispatcher;
    import flash.events.IOErrorEvent;
    import flash.events.ProgressEvent;
    import flash.events.SecurityErrorEvent;
    import flash.net.URLLoader;
    import flash.net.URLLoaderDataFormat;
    import flash.net.URLRequest;
    
    /**
     * This class represents a text-based asset loader that can be used to load
     * <code>XML</code>.
     *
     * @author Matt Bolt
     */
    public class TextAsset extends EventDispatcher implements IEventDispatcher {
        
        //--------------------------------------------------------------------------
        //
        //  Variables
        //
        //--------------------------------------------------------------------------
        
        /**
         * @private
         * the url of the asset
         */
        private var _url:String;
        
        /**
         * @private
         * the loader
         */
        private var _urlLoader:URLLoader;
        
        /**
         * @private
         * event listener flag.
         */
        private var _isListening:Boolean = false;
        
        /**
         * @private
         * errors
         */
        private var _errors:Vector.<String>;
        
        //--------------------------------------------------------------------------
        //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
         * <code>TextAsset</code> Constructor.
         */
        public function TextAsset(url:String) {
            _url = url;
        }
        
        //--------------------------------------------------------------------------
        //
        //  Methods
        //
        //--------------------------------------------------------------------------
        
        /**
         * This method begins the load process for the url provided in the constructor.
         */
        public function load():void {
            _urlLoader = new URLLoader();
            _urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
            isEventListening = true;
            
            _urlLoader.load(new URLRequest(_url));
        }
        
        //--------------------------------------------------------------------------
        //
        //  Event Handlers
        //
        //--------------------------------------------------------------------------
        
        /**
         * @private
         * load complete handler
         */
        private function onComplete(event:Event):void {
            dispatchEvent(new TextAssetEvent(TextAssetEvent.TEXT_LOAD_COMPLETE));                                        
        }
        
        /**
         * @private
         * load complete handler
         */
        private function onProgress(event:ProgressEvent):void {
            dispatchEvent(
                new TextAssetProgressEvent( TextAssetProgressEvent.TEXT_LOAD_PROGRESS, 
                                            event.bytesLoaded, 
                                            event.bytesTotal ));
        }
        
        /**
         * @private
         * load complete handler
         */
        private function onSecurityError(event:SecurityErrorEvent):void {
            failureFor(event);
        }
        
        /**
         * @private
         * load complete handler
         */
        private function onIOError(event:IOErrorEvent):void {
            failureFor(event);
        }
        
        /**
         * @private
         * Handles load failure.
         */
        private function failureFor(event:Event):void {
            if (!_errors)
                _errors = new Vector.<String>();
            _errors.push(event.toString());
            
            isEventListening = false;
            dispatchEvent(new TextAssetEvent(TextAssetEvent.TEXT_LOAD_COMPLETE));
        }
        
        //--------------------------------------------------------------------------
        //
        //  Properties
        //
        //--------------------------------------------------------------------------
        
        /**
         * This property contains the data loaded.
         */
        public function get data():* {
            return _urlLoader.data;
        }
        
        /**
         * This property contains a <code>Boolean</code> set to <code>true</code> if 
         * the data successfully loaded or <code>false</code> otherwise.
         */
        public function get success():Boolean {
            return !_errors;
        }
        
        /**
         * This <code>Vector</code> contains any errors that occured during the load
         * should they exist.
         */
        public function get errors():Vector.<String> {
            return _errors;
        }
        
        /**
         * @private
         * This value is <code>true</code> if the load event listeners are active.
         */
        private function get isEventListening():Boolean {
            return _isListening;
        }
        
        /**
         * @private
         */
        private function set isEventListening(value:Boolean):void {
            if (_isListening == value || !_urlLoader)
                return;
            _isListening = value;
            
            // Either calls "addEventListener" or "removeEventListener"
            var methodId:String = (_isListening ? "add" : "remove") + "EventListener";
            _urlLoader[methodId](Event.COMPLETE, onComplete);
            _urlLoader[methodId](ProgressEvent.PROGRESS, onProgress);
            _urlLoader[methodId](SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
            _urlLoader[methodId](IOErrorEvent.IO_ERROR, onIOError);
        }
        
    }
    
}