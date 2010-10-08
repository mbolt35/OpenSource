////////////////////////////////////////////////////////////////////////////////
//
//  ELECTROTANK INC.
//  Copyright� 2009 Electrotank, Inc.
//  All Rights Reserved.
//
////////////////////////////////////////////////////////////////////////////////

package com.weaklistener.video.vimeo {

    //----------------------------------
    //  imports
    //----------------------------------
    import com.weaklistener.video.IVideoController;
    import com.weaklistener.video.IVideoPlayerFactory;
    import com.weaklistener.video.IVideoPlayerLoader;
    import com.weaklistener.video.VideoPlayerOptions;
    import flash.display.DisplayObject;

    /**
     * This class
     *
     * @author Matt Bolt, Electrotank© 2009
     */
    public class VimeoVideoPlayerFactory implements IVideoPlayerFactory {

        //--------------------------------------------------------------------------
        //
        //  Variables
        //
        //--------------------------------------------------------------------------

        /**
         * @private
         * video player loader
         */
        private var _playerLoader:IVideoPlayerLoader;

        //--------------------------------------------------------------------------
        //
        //  Constructor
        //
        //--------------------------------------------------------------------------

        /**
         * <code>VimeoVideoPlayerFactory</code> Constructor.
         */
        public function VimeoVideoPlayerFactory(playerLoader:IVideoPlayerLoader) {
            _playerLoader = playerLoader;
        }

        //--------------------------------------------------------------------------
        //
        //  Methods
        //
        //--------------------------------------------------------------------------

        /**
         * This method creates a new video player instance using the <code>VideoPlayerOptions
         * </code> and returns generic video api controller.
         *
         * @param	options The <code>VideoPlayerOptions</code> for the video player.
         *
         * @param	callback The <code>Function</code> to call upon completion.
         */
        public function videoPlayer(options:VideoPlayerOptions, callback:Function):void {
            _playerLoader.loadPlayer(options, function(vimeoPlayer:DisplayObject):void {
                callback(new VimeoVideo(
                    new VimeoPlayer(vimeoPlayer, options),
                    new VimeoController(vimeoPlayer, options)) );
            });
        }

        //--------------------------------------------------------------------------
        //
        //  Properties
        //
        //--------------------------------------------------------------------------

    }

}