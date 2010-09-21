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
    /// This interface defines an implementation prototype for an object that is targetted for 
    /// log display
    /// </summary>
    /// <author>Matt Bolt [mbolt35@gmail.com]</author>
    public interface ILoggingTarget {

        /// <summary>
        /// Sets up this target with the specified logger. 
        /// </summary>
        /// <param name="logger"></param>
        void AddLogger(ILogger logger);

        /// <summary>
        /// Removes a logger from recieving log events. 
        /// </summary>
        /// <param name="logger"></param>
        void RemoveLogger(ILogger logger);

        /// <summary>
        /// The log target filters
        /// </summary>
        List<string> Filters {
            get;
            set;
        }

        /// <summary>
        /// The log target level.
        /// </summary>
        LogLevel Level {
            get;
            set;
        }
    }
}