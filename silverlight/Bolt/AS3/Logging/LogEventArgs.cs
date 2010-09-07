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

namespace Bolt.AS3.Logging {

    using System;
    using System.Windows;
    using System.Collections.Generic;


    /// <summary>
    /// 
    /// </summary>
    /// <author>Matt Bolt [mbolt35@gmail.com]</author>
    public class LogEventArgs: EventArgs {

        #region Variables

        private LogLevel _level;
        private string _message;

        #endregion

        #region Constructors

        /// <summary>
        /// Creates a new <c>LogEventArgs</c> instance.
        /// </summary>
        /// <param name="message">The message logged.</param>
        /// <param name="level">The <c>LogLevel</c> in which the message was logged</param>
        public LogEventArgs(string message, LogLevel level = LogLevel.All) {
            _message = message;
            _level = level;
        }

        #endregion

        #region Properties

        /// <summary>
        /// This property contains the <c>LogLevel</c> of the log.
        /// </summary>
        public LogLevel Level {
            get {
                return _level;
            }
        }

        /// <summary>
        /// This property contains the <c>string</c> representaion of the
        /// log.
        /// </summary>
        public string Message {
            get {
                return _message;
            }
        }

        #endregion

    }
}