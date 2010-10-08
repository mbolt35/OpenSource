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
    
    import flash.display.*;
    import flash.geom.ColorTransform;
    import flash.geom.Matrix;
    import flash.geom.Rectangle;
    
    /**
     * This class assists with display objects functionality.
     * 
     * @author Matt Bolt
     */
    public class DisplayObjectUtil {
        
        //--------------------------------------------------------------------------
        //
        //  Methods
        //
        //--------------------------------------------------------------------------
        
        /**
         * Recursively destroys a <code>DisplayObject</code> or <code>DisplayObjectContainer
         * </code> by reverse walking the display list, traversing each node and child node, 
         * stripping the content based on display type, and then removing the object from the 
         * display list.
         *
         * @param    obj <code>DisplayObject</code> to destroy.
         */
        public static function disposeOf(...displayObjects):void {
            for each (var dispObj:DisplayObject in displayObjects) {
                reverseWalkDisplayObjects(dispObj, dispose);
            }
        }
        
        /**
         * Recursively calls <code>stop()</code> on all <code>MovieClip</code> objects us the <code>
         * walkDisplayObjects()</code> function.
         * 
         * @param    movieClip The parent clip to recursively stop.
         */
        public static function stopAll(movieClip:MovieClip):void {
            if (movieClip) {
                reverseWalkDisplayObjects(
                    movieClip, 
                    function(dispObject:DisplayObject):void {
                        if (dispObject && dispObject is MovieClip) {
                            MovieClip(dispObject).stop();
                        }
                    });
            }
        }
        
        /**
         * This function recursively calls a callback function on each <code>DisplayObject
         * </code> within the display list provided in reverse.
         *
         * @param   displayObject The <code>DisplayObject</code> to recursively call the 
         * <code>callback</code> upon.
         *
         * @param   callback The <code>Function</code> to apply to each <code>DisplayObject</code>
         */
        public static function reverseWalkDisplayObjects( displayObject:DisplayObject, 
                                                          callback:Function ):void 
        {
            callback(displayObject)
            if (displayObject is DisplayObjectContainer) {
                var container:DisplayObjectContainer = DisplayObjectContainer(displayObject);
                for (var i:int = container.numChildren - 1; i >= 0; --i) {
                    reverseWalkDisplayObjects(container.getChildAt(i), callback);
                }
            }
        }
        
        //--------------------------------------------------------------------------
        //
        //  Helper
        //
        //--------------------------------------------------------------------------
        
        /**
         * @private
         * disposes of the display object.
         */
        private static function dispose(dispObject:DisplayObject):void {
            if (dispObject) {
                if (dispObject.parent && !(dispObject.parent is Loader))
                    dispObject.parent.removeChild(dispObject);
                if (dispObject is MovieClip)
                    MovieClip(dispObject).stop();
                if (dispObject is Bitmap && Bitmap(dispObject).bitmapData)
                    Bitmap(dispObject).bitmapData.dispose();
                if (dispObject is Shape && Shape(dispObject).graphics)
                    Shape(dispObject).graphics.clear();
            }
        }
        
    }
    
}
