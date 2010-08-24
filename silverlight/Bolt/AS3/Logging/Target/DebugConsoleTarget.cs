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

namespace Bolt.AS3.Logging.Target {

    using System;
    using System.Windows;
    using System.Diagnostics;

    /// <summary>
    /// This class is used to write logs debug console in .NET.
    /// </summary>
    /// <author>Matt Bolt [mbolt35@gmail.com]</author>
    public class DebugConsoleTarget : LineFormattedTarget, ILoggingTarget {

        /// <summary>
        /// Creates a new <c>DebugConsoleTarget</c> instance.
        /// </summary>
        public DebugConsoleTarget() : base() {

        }

        /// <summary>
        /// Overrides the internal log which already has pre-appended options.
        /// </summary>
        /// <param name="message"></param>
        protected override void  InternalLog(string message) {
            Debug.WriteLine(message);
        }
    }

}
