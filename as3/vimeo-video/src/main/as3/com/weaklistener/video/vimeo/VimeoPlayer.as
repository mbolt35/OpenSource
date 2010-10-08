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

package com.weaklistener.video.vimeo {

    //----------------------------------
    //  imports
    //----------------------------------
    import com.weaklistener.utils.DisplayObjectUtil;
    import com.weaklistener.video.VideoPlayerOptions;
    import flash.display.DisplayObject;
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.events.Event;

    //----------------------------------
    //  Events
    //----------------------------------

    /**
     * This class
     *
     * @author Matt Bolt, WeakListener(C) 2009
     */
    public class VimeoPlayer extends Sprite {

        //--------------------------------------------------------------------------
        //
        //  Variables
        //
        //--------------------------------------------------------------------------

        /**
         * @private
         * the vimeo player object
         */
        private var _player:DisplayObject;

        /**
         * @private
         * the player container
         */
        private var _playerContainer:Sprite = new Sprite();

        /**
         * @private
         * video player mask
         */
        private var _mask:Sprite = new Sprite();

        /**
         * @private
         * player options
         */
        private var _options:VideoPlayerOptions;

        //--------------------------------------------------------------------------
        //
        //  Constructor
        //
        //--------------------------------------------------------------------------

        /**
         * <code>VimeoPlayer</code> Constructor.
         */
        public function VimeoPlayer(player:DisplayObject, options:VideoPlayerOptions) {
            constructPlayer(player, options);
        }

        //--------------------------------------------------------------------------
        //
        //  Methods
        //
        //--------------------------------------------------------------------------

        /**
         * @private
         * constructs the player ui
         */
        private function constructPlayer(player:DisplayObject, options:VideoPlayerOptions):void {
            _player = player;
            _options = options;

            _mask.graphics.beginFill(0x00FF00, 1);
            _mask.graphics.drawRect(0, 0, options.playerWidth, options.playerHeight);
            _mask.graphics.endFill();
            _mask.cacheAsBitmap = true;

            _playerContainer.addChild(_player);
            _playerContainer.addChild(_mask);

            addChild(_playerContainer);
            addChild(_mask);

            _playerContainer.mask = _mask;

            _player.addEventListener(Event.RESIZE, onResize);
        }

        private function onResize(e:Event):void {
            trace("Resized!");
        }

        //--------------------------------------------------------------------------
        //
        //  Properties
        //
        //--------------------------------------------------------------------------

    }

}