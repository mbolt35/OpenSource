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

namespace Bolt.AS3 {

    using System;
    using System.Windows;
    using System.Collections;
    using System.Collections.Generic;
    using System.Xml;
    using System.Net;
    using System.Xml.Schema;
    using System.Xml.Serialization;
    using System.IO;
    using System.Reflection;
    using System.Text.RegularExpressions;
    using System.Diagnostics;

    using Bolt.AS3.Xml;
    using Bolt.AS3.Logging;
    using Bolt.AS3.Logging.Target;
    using Bolt.AS3.Util;


    /// <summary>
    /// This class demonstrates how to use the open-source C# TypeUtil class.
    /// </summary>
    /// <author>Matt Bolt [mbolt35@gmail.com]</author>
    public class StringReplaceExample {
        
        private static readonly ILogger log = Log.GetLogger(LogUtil.CategoryFor(MethodBase.GetCurrentMethod()));

        /// <summary>
        /// Creates a new <c>StringReplaceExample</c> instance
        /// </summary>
        public StringReplaceExample() {
            ReplaceString();
        }

        /// <summary>
        /// Performs the replace string example
        /// </summary>
        private void ReplaceString() {
            Person person = new Person("Matt Bolt", 27);
            string message = "Hello, my name is ${Name} and I am ${Age} years old.";

            Debug.WriteLine(ReplaceTokens(message, person));
        }

        /// <summary>
        /// This method applies to regular expression to the string, then replaces the tokens with 
        /// values from the <c>data</c> object provided.
        /// </summary>
        /// <param name="message">The string to replace tokens in.</param>
        /// <param name="data">The object containing the properties referenced in the message</param>
        /// <returns></returns>
        private string ReplaceTokens(string message, object data) {
            Regex genericToken = new Regex("\\$\\{([a-zA-Z0-9_]+)\\}");

            return genericToken.Replace(message, (Match e) => {
                return TypeUtil.InvokePropertyByString<string>(data, e.Groups[1].Value);
            });
        }

        #region Person Class

        /// <summary>
        /// This class represents a data container object representing a person. For simplicity, 
        /// the only properties are <c>Name</c> and <c>Age</c>.
        /// </summary>
        internal class Person {

            #region Variables

            private string _name;
            private int _age;

            #endregion

            #region Constructor

            /// <summary>
            /// Creates a new <c>Person</c> instance
            /// </summary>
            /// <param name="name"></param>
            /// <param name="age"></param>
            public Person(string name, int age) {
                _name = name;
                _age = age;
            }

            #endregion

            #region Properties

            /// <summary>
            /// This property contains the name of the person.
            /// </summary>
            public string Name {
                get {
                    return _name;
                }
            }

            /// <summary>
            /// This property contains the age of the person
            /// </summary>
            public string Age {
                get {
                    return _age.ToString();
                }
            }

            #endregion

        }

        #endregion

    }
}
