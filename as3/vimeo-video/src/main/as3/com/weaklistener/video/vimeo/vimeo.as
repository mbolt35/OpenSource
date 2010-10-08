////////////////////////////////////////////////////////////////////////////////
//
//  ELECTROTANK INC.
//  Copyright� 2009 Electrotank, Inc.
//  All Rights Reserved.
//
////////////////////////////////////////////////////////////////////////////////

package com.weaklistener.video.vimeo {
    import com.weaklistener.video.IVideoPlayerFactory;

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    /**
     * This function
     *
     * @author Matt Bolt, Electrotank© 2009
     */
    public function vimeo():IVideoPlayerFactory {
        return new VimeoVideoPlayerFactory(
            new VimeoPlayerLoader("http://bitcast.vimeo.com/vimeo/swf/moogaloop.swf"));
    }

}