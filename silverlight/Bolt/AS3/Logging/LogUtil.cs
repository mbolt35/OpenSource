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
    using System.Xml;

    /// <summary>
    /// 
    /// </summary>
    /// <author>Matt Bolt [mbolt35@gmail.com]</author>
    public static class LogUtil {

        /// <summary>
        /// This class returns a <c>String</c> version of the <c>LogLevel</c>. It returns UNKNOWN
        /// if the <c>LogLevel</c> doesn't exist.
        /// </summary>
        /// <param name="level">The <c>LogLevel</c> to retrieve the <c>String</c> for.</param>
        /// <returns>A meaningful <c>String</c> representation of the <c>LogLevel</c></returns>
        public static String LevelStringFor(LogLevel level) {
            switch (level) {
                case LogLevel.Info:
                    return "INFO";

                case LogLevel.Debug:
                    return "DEBUG";

                case LogLevel.Error:
                    return "ERROR";

                case LogLevel.Warn:
                    return "WARN";

                case LogLevel.Fatal:
                    return "FATAL";

                case LogLevel.All:
                    return "ALL";
            }

            return "UNKNOWN";
        }

    }
}