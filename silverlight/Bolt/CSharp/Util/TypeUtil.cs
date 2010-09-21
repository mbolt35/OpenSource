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

namespace Bolt.CSharp.Util {

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

    using Bolt.CSharp.Xml;
    using Bolt.CSharp.Logging;
    using Bolt.CSharp.Logging.Target;


    /// <summary>
    /// This class contains useful tools dealing with <c>Type</c> objects
    /// </summary>
    /// <author>Matt Bolt [mbolt35@gmail.com]</author>
    public static class TypeUtil {

        /// <summary>
        /// This method invokes another method "dynamically" using the name of the method.
        /// </summary>
        /// <param name="obj">The object to use to invoke the method.</param>
        /// <param name="methodName">The name of the method to invoke</param>
        /// <param name="methodParameters">The optional parameters to pass to the method</param>
        /// <returns>An instance of the return type, <c>TResult</c></returns>
        public static TResult InvokeByString<TResult>(object obj, string methodName, params object[] methodParameters) {
            Type objType = obj.GetType();

            return (TResult)objType.InvokeMember(
                methodName, 
                BindingFlags.InvokeMethod | BindingFlags.Public | BindingFlags.Static, 
                null, 
                obj, 
                methodParameters);
        }

        /// <summary>
        /// This method invokes a property "dynamically" using the name of the property.
        /// </summary>
        /// <param name="obj">The object to use to invoke the property.</param>
        /// <param name="propertyName">The name of the property to invoke</param>
        /// <returns>An instance of the return type, <c>TResult</c></returns>
        public static TResult InvokePropertyByString<TResult>(object obj, string propertyName) {
            Type type = obj.GetType();
            PropertyInfo pInfo = type.GetProperty(propertyName, typeof(TResult));

            return (TResult)pInfo.GetValue(obj, null);
        }

    }
}
