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
    /// This interface defines a 
    /// </summary>
    /// <author>Matt Bolt [mbolt35@gmail.com]</author>
    public interface ILogger {

        /// <summary>
        /// This logs a message at a particular level.
        /// </summary>
        /// <param name="level">The <c>LogLevel</c> to use when logging.</param>
        /// <param name="message">The message to log</param>
        /// <param name="rest">The objects to use to fill in the special formatting in the message</param>
        void Log(LogLevel level, String message, params object[] rest);

        /// <summary>
        /// Logs a message at the debug level.
        /// </summary>
        /// <param name="message">The message to log</param>
        /// <param name="rest">The objects to use to fill in the special formatting in the message</param>
        void Debug(String log, params object[] rest);

        /// <summary>
        /// Logs a message at the info level.
        /// </summary>
        /// <param name="message">The message to log</param>
        /// <param name="rest">The objects to use to fill in the special formatting in the message</param>
        void Info(String log, params object[] rest);

        /// <summary>
        /// Logs a message at the warning level.
        /// </summary>
        /// <param name="message">The message to log</param>
        /// <param name="rest">The objects to use to fill in the special formatting in the message</param>
        void Warn(String log, params object[] rest);

        /// <summary>
        /// Logs a message at the error level.
        /// </summary>
        /// <param name="message">The message to log</param>
        /// <param name="rest">The objects to use to fill in the special formatting in the message</param>
        void Error(String log, params object[] rest);

        /// <summary>
        /// Logs a message at the fatal level.
        /// </summary>
        /// <param name="message">The message to log</param>
        /// <param name="rest">The objects to use to fill in the special formatting in the message</param>
        void Fatal(String log, params object[] rest);

        /// <summary>
        /// The logging category.
        /// </summary>
        String Category {
            get;
        }

        /// <summary>
        /// This event controls when/how the logs are displayed
        /// </summary>
        event EventHandler<LogEventArgs> LogEvent;
    }
}