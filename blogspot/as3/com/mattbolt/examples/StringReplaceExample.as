////////////////////////////////////////////////////////////////////////////////
//
//  MATTBOLT.BLOGSPOT.COM
//  Copyright(C) 2010 Matt Bolt
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at:
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
////////////////////////////////////////////////////////////////////////////////

package com.mattbolt.examples {

    import flash.display.Sprite;

    /**
     * This example demonstrates how to replace tokens in a string with properties
     * from an object.
     *
     * @author Matt Bolt [mbolt35&#64;gmail.com]
     */
    public class StringReplaceExample extends Sprite {

        //--------------------------------------------------------------------------
        //
        //  Constants
        //
        //--------------------------------------------------------------------------

        /**
         * @private
         * this constant contains the regular expression for the token.
         *
         * Note: the parens around the characters inside the ${ } will group the
         * characters for us to use as the property reference.
         */
        private static const GENERIC_TOKEN:RegExp = /\$\{([a-zA-Z0-9_]+)\}/g;


        //--------------------------------------------------------------------------
        //
        //  Constructor
        //
        //--------------------------------------------------------------------------

        /**
         * Creates a new <code>StringReplaceExample</code> instance.
         */
        public function StringReplaceExample() {
            replaceString();
        }

        //--------------------------------------------------------------------------
        //
        //  Methods
        //
        //--------------------------------------------------------------------------

        /**
         * @private
         * performs the replace string example
         */
        private function replaceString():void {
            var person:Person = new Person("Matt Bolt", 27);
            var message:String = "Hello, my name is ${name} and I am ${age} years old.";

            trace(replaceTokens(message, person));
        }

        /**
         * @private
         * this method applies to regular expression to the string, then replaces the tokens with
         * values from the <code>data</code> object provided.
         */
        private function replaceTokens(message:String, data:Object):String {
            return message.replace(GENERIC_TOKEN, function():String {
                return data[ arguments[1] ]
            });
        }

    }
}

/**
 * This class represents a data container object representing a person. For simplicity, the only properties
 * are <code>name</code> and <code>age</code>.
 *
 * @author Matt Bolt [mbolt35&#64;gmail.com]
 */
class Person {

    //--------------------------------------------------------------------------
    //
    //  Variables
    //
    //--------------------------------------------------------------------------

    /**
     * @private
     * backing variable for name
     */
    private var _name:String;

    /**
     * @private
     * backing variable for age.
     */
    private var _age:int;


    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    /**
     * Creates a new <code>Person</code> instance using a name and age.
     *
     * @param	name The name of the person.
     *
     * @param	age The age of the person.
     */
    public function Person(name:String, age:int) {
        _name = name;
        _age = age;
    }


    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    /**
     * This property contains the name value of the person.
     */
    public function get name():String {
        return _name;
    }

    /**
     * This property contains the age value of the person.
     */
    public function get age():int {
        return _age;
    }

}
