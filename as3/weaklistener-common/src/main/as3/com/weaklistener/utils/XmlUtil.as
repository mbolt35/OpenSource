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
    
    //----------------------------------
    //  imports
    //----------------------------------
    import com.weaklistener.events.TextAssetEvent;
    import com.weaklistener.loaders.TextAsset;
    
    /**
     * This class contains useful tools dealing with <code>XML</code>
     * 
     * @author Matt Bolt
     */
    public class XmlUtil {
        
        //--------------------------------------------------------------------------
        //
        //  Methods
        //
        //--------------------------------------------------------------------------
        
        /**
         * <p>This static function loads an <code>XML</code> object given the <code>path</code>
         * parameter and a callback function containing a single <code>xml:XML</code> method
         * signature.</p>
         * 
         * @param    url The url path for the <code>XML</code>
         * 
         * @param    callback A function containing a single <code>xml:XML</code> method
         * signature.
         * 
         * @example
         * This exmample demostrates how to effectively use the static function <code>loadXml</code>.
         * The following code will attempt to parse a configuration file passed in using a <code>
         * String</code> path. It returns a <code>Boolean</code> value representing a successful
         * parse/load using the callback parameter containing a <code>Boolean</code> signature.
         * 
         * <listing version="3.0">
         * 
         * public function MyConfigurationParser() {
         *     parseMyConfigFile('configuration/config.xml', function(success:Boolean):void {
         *         trace('XML Parse Success? ' + success);
         *     });
         * }
         * 
         * private function parseMyConfigFile(path:String, callback:Function):void {
         *     
         *     XmlUtil.loadXml(path, function(loadedXml:XML):void {
         *         
         *         if (loadedXml.elements('errors').length() > 0) {
         *             trace('Errors while trying to parse configuration file: ' + path);
         *             trace(loadedXml.toString());
         *             callback(false);
         *             return;
         *         }
         * 
         *         // .. Parse needed information from XML
         *         processXml(loadedXml);
         * 
         *         // Make callback
         *         callback(true);
         *     });
         * }
         * </listing>
         */
        public static function loadXml(url:String, callback:Function):void {
            var xmlAsset:TextAsset = new TextAsset(url);
            
            function onXmlLoaded(event:TextAssetEvent):void {
                xmlAsset.removeEventListener(TextAssetEvent.TEXT_LOAD_COMPLETE, onXmlLoaded);
                
                if (!xmlAsset.success) {
                    var errStr:String = '<errors>\n';
                    if (xmlAsset.errors) {
                        for each (var str:String in xmlAsset.errors) {
                            errStr += '\t<error>' + str + '</error>\n';
                        }
                    }
                    errStr += '</errors>';
                    callback(XML(errStr));
                    return;
                }
                callback(XML(xmlAsset.data));
            }
            
            xmlAsset.addEventListener(TextAssetEvent.TEXT_LOAD_COMPLETE, onXmlLoaded);
            xmlAsset.load();
        }
        
    }
    
}