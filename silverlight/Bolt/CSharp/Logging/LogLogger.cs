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

namespace Bolt.CSharp.Logging {

    using System;
    using System.Windows;
    using System.Collections.Generic;


    /// <summary>
    /// 
    /// </summary>
    /// <author>Matt Bolt [mbolt35@gmail.com]</author>
    public class LogLogger : ILogger {

        #region Variables

        private string _category;

        #endregion

        #region Constructors

        /// <summary>
        /// Creates a new <c>LogLogger</c> instance using the supplied category.
        /// </summary>
        /// <param name="category">The category to use with the logger.</param>
        public LogLogger(string category) {
            _category = category;
        }

        #endregion

        #region Methods

        /// <summary>
        /// This logs a message at a particular level.
        /// </summary>
        /// <param name="level">The <c>LogLevel</c> to use when logging.</param>
        /// <param name="message">The message to log</param>
        /// <param name="rest">The objects to use to fill in the special formatting in the message</param>
        public void Log(LogLevel level, string message, params object[] rest) {
            LogEvent(this, new LogEventArgs(string.Format(message, rest), level));
        }

        /// <summary>
        /// Logs a message at the debug level.
        /// </summary>
        /// <param name="message">The message to log</param>
        /// <param name="rest">The objects to use to fill in the special formatting in the message</param>
        public void Debug(string log, params object[] rest) {
            Log(LogLevel.Debug, log, rest);
        }

        /// <summary>
        /// Logs a message at the info level.
        /// </summary>
        /// <param name="message">The message to log</param>
        /// <param name="rest">The objects to use to fill in the special formatting in the message</param>
        public void Info(string log, params object[] rest) {
            Log(LogLevel.Info, log, rest);
        }

        /// <summary>
        /// Logs a message at the warning level.
        /// </summary>
        /// <param name="message">The message to log</param>
        /// <param name="rest">The objects to use to fill in the special formatting in the message</param>
        public void Warn(string log, params object[] rest) {
            Log(LogLevel.Warn, log, rest);
        }

        /// <summary>
        /// Logs a message at the error level.
        /// </summary>
        /// <param name="message">The message to log</param>
        /// <param name="rest">The objects to use to fill in the special formatting in the message</param>
        public void Error(string log, params object[] rest) {
            Log(LogLevel.Error, log, rest);
        }

        /// <summary>
        /// Logs a message at the fatal level.
        /// </summary>
        /// <param name="message">The message to log</param>
        /// <param name="rest">The objects to use to fill in the special formatting in the message</param>
        public void Fatal(string log, params object[] rest) {
            Log(LogLevel.Fatal, log, rest);
        }

        #endregion

        #region Properties

        /// <summary>
        /// This property contains the category used with the logger instance.
        /// </summary>
        public string Category {
            get {
                return _category;
            }
        }

        #endregion

        #region Events

        /// <summary>
        /// This event is dispatched on a finalized log.
        /// </summary>
        public event EventHandler<LogEventArgs> LogEvent;

        #endregion

    }
}