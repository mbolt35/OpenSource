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
    import com.weaklistener.twitter.constants.TwitterConstants;
    import com.weaklistener.twitter.core.ITweetProvider;
    import com.weaklistener.twitter.core.Tweet;
    import com.weaklistener.utils.StringUtil;
    import com.weaklistener.utils.XmlUtil;
    import flash.net.URLLoader;
    import flash.net.URLLoaderDataFormat;
    import flash.net.URLRequest;
    import flash.net.URLRequestHeader;

    /**
     * This class loads, parses and provides the medium for reading in twitter feeds.
     *
     * @author Matt Bolt
     */
    public class RssTweetProvider implements ITweetProvider {
        
        //--------------------------------------------------------------------------
        //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
         * <code>RssTweetProvider</code> Constructor.
         */
        public function RssTweetProvider() {
            // Empty
        }
        
        //--------------------------------------------------------------------------
        //
        //  Methods
        //
        //--------------------------------------------------------------------------
        
        /**
         * This function will gather the tweets for the given user id and then pass back
         * an <code>Array</code> containing them in the <code>callback:Function</code>
         * paramter.
         * 
         * @param	userId The user's twitter id.
         * 
         * @param   count The amount of <code>Tweet</code>s to return in the callback.
         * 
         * @param	callback The function to call upon completion.
         */
        public function tweetsFor(userId:String, count:uint, callback:Function):void {
            
            var tweets:Vector.<Tweet>;
            
            var timelineUrl:String = StringUtil.substitute("${url}?id=${id}&count=${tweetCount}", {
                url: TwitterConstants.TWITTER_TIMELINE_RSS,
                id: userId,
                tweetCount: count
            });
            
            XmlUtil.loadXml(timelineUrl, function(tweetXml:XML):void {
                
                if (tweetXml.errors.length() == 0) {
                    var items:XMLList = tweetXml..item;
                    var len:int = items.length();
                    tweets = new Vector.<Tweet>(len, true);
                    
                    for (var i:int = 0; i < len; ++i) {
                        var twt:XML = items[i];
                        tweets[i] = new Tweet( twt.title.toString(), 
                                               twt.description.toString(), 
                                               twt.pubDate.toString(),
                                               twt.guid.toString(),
                                               twt.link.toString() );
                    }
                } else {
                    trace(tweetXml.errors)
                }
                
                callback(tweets);
            }); 
        }
        
    }
    
}