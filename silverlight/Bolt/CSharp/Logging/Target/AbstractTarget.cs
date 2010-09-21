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

namespace Bolt.CSharp.Logging.Target {

    using System;
    using System.Windows;
    using System.Collections.Generic;
    using System.Collections;
    using System.Text;

    /// <summary>
    /// 
    /// </summary>
    public abstract class AbstractTarget : ILoggingTarget {

        private uint _loggerCount = 0;
        private LogLevel _level = LogLevel.All;
        private List<string> _filters = new List<string>() { "*" };

        public AbstractTarget() {

        }

        public void AddLogger(ILogger logger) {
            if (logger == null) {
                return;
            }

            _loggerCount++;
            logger.LogEvent += new EventHandler<LogEventArgs>(LogHandler);
        }

        public void RemoveLogger(ILogger logger) {
            if (logger == null) {
                return;
            }

            _loggerCount--;
            logger.LogEvent -= new EventHandler<LogEventArgs>(LogHandler);
        }

        private void LogHandler(object sender, LogEventArgs e) {
            if (e.Level >= Level) {
                OnLogEvent(sender, e);
            }
        }

        public abstract void OnLogEvent(object sender, LogEventArgs e);

        public List<string> Filters {
            get {
                return _filters;
            }
            set {
                if (value == null || value.Count == 0) {
                    value = new List<string>() { "*" };
                }

                if (_loggerCount > 0) {
                    Log.RemoveTarget(this);
                    _filters = value;
                    Log.AddTarget(this);
                } else {
                    _filters = value;
                }
            }
        }

        public LogLevel Level {
            get {
                return _level;
            }
            set {
                Log.RemoveTarget(this);
                _level = value;
                Log.AddTarget(this);
            }
        }
    }
}
