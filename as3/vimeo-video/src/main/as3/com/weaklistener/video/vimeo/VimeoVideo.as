////////////////////////////////////////////////////////////////////////////////
//
//  ELECTROTANK INC.
//  Copyright� 2009 Electrotank, Inc.
//  All Rights Reserved.
//
////////////////////////////////////////////////////////////////////////////////

package com.weaklistener.video.vimeo {
    import com.weaklistener.video.IVideoPlayer;
    import flash.display.DisplayObject;

    //----------------------------------
    //  imports
    //----------------------------------

    //----------------------------------
    //  Events
    //----------------------------------

    /**
     * This class
     *
     * @author Matt Bolt, Electrotank© 2009
     */
    public class VimeoVideo implements IVideoPlayer {

        //--------------------------------------------------------------------------
        //
        //  Variables
        //
        //--------------------------------------------------------------------------

        private var _player:VimeoPlayer;

        private var _controller:VimeoController;

        //--------------------------------------------------------------------------
        //
        //  Constructor
        //
        //--------------------------------------------------------------------------

        /**
         * <code>VimeoVideo</code> Constructor.
         */
        public function VimeoVideo(vimeoPlayer:VimeoPlayer, controller:VimeoController) {
            _player = vimeoPlayer;
            _controller = controller;
        }

        //--------------------------------------------------------------------------
        //
        //  Methods
        //
        //--------------------------------------------------------------------------

        public function get playerRender():DisplayObject {
            return _player;
        }

        //--------------------------------------------------------------------------
        //
        //  Properties
        //
        //--------------------------------------------------------------------------

    }

}