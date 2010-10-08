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

package com.weaklistener.twitter.basic {
    
    //----------------------------------
    //  imports
    //----------------------------------
    import com.weaklistener.twitter.core.ITweetRenderer;
    import com.weaklistener.twitter.core.Tweet;
    import flash.display.DisplayObject;
    import flash.display.Sprite;
    import flash.text.StyleSheet;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
    import flash.text.TextFormat;
    import flash.text.TextFormatAlign;
    import flash.text.TextFormatDisplay;
    
    /**
     * This class will render <code>Tweet</code> instances to the display list
     * via a <code>TextField</code>.
     *
     * @author Matt Bolt
     */
    public class TextFieldTweetRenderer implements ITweetRenderer{
        
        //--------------------------------------------------------------------------
        //
        //  Variables
        //
        //--------------------------------------------------------------------------
        
        /**
         * @private
         * render canvas
         */
        private var _canvas:Sprite = new Sprite();
        
        /**
         * @private
         * textfield to render to
         */
        private var _textField:TextField = new TextField();

        //--------------------------------------------------------------------------
        //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
         * <code>TextFieldTweetRenderer</code> Constructor.
         */
        public function TextFieldTweetRenderer() {
            _canvas.addChild(_textField);
            construct();
        }
        
        //--------------------------------------------------------------------------
        //
        //  Methods
        //
        //--------------------------------------------------------------------------
        
        /**
         * @private
         * constructs the renderable
         */
        private function construct():void {
            
            // Dimensions
            _textField.width = 300;
            
            // TextField Format
            var format:TextFormat = _textField.defaultTextFormat;
            format.align = TextFormatAlign.CENTER;
            format.bold = true;
            format.size = 14;
            _textField.defaultTextFormat = format;
            _textField.setTextFormat(format);
            
            // Options
            _textField.autoSize = TextFieldAutoSize.CENTER;
            _textField.selectable = false;
            _textField.multiline = true;
            _textField.wordWrap = true;
            _textField.background = true;
            _textField.border = true;
            
            // Properties
            _textField.backgroundColor = 0x282828;
            _textField.borderColor = 0x4CB8E6;
            _textField.textColor = 0xFFFFFF;
            
            // StyleSheet
            // TODO: Test -> Does this override the formatting?
            _textField.styleSheet = new StyleSheet();
            _textField.styleSheet.setStyle("a:link", {
                fontWeight: "bold", 
                textDecoration: "none", 
                fontSize: 14, 
                color: "#4CB8E6" 
            });
            _textField.styleSheet.setStyle("a:hover", {
                fontWeight: "bold",
                textDecoration: "underline",
                fontSize: 14,
                color: "#4CB8E6"
            });
            
        }
        
        /**
         * @inheritDoc
         */
        public function render(tweet:Tweet):void {
            _textField.htmlText = tweet.title;
        }
        
        //--------------------------------------------------------------------------
        //
        //  Properties
        //
        //--------------------------------------------------------------------------
        
        /**
         * This property contains the renderable Tweet.
         */
        public function get canvas():DisplayObject {
            return _canvas;
        }
        
    }
    
}