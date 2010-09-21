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
    public class LineFormattedTarget : AbstractTarget {

        #region Variables

        private string _fieldSeperator = " ";
        private Boolean _includeCategory;
        private Boolean _includeDate;
        private Boolean _includeLevel;
        private Boolean _includeTime;

        #endregion

        #region Constructors

        /// <summary>
        /// Creates a new <c>LineFormattedTarget</c> instance.
        /// </summary>
        public LineFormattedTarget() : base() {
            _includeTime = false;
            _includeDate = false;
            _includeCategory = true;
            _includeLevel = true;
        }

        #endregion

        #region Methods

        /// <summary>
        /// Handles the LogEvent
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        public override void OnLogEvent(object sender, LogEventArgs e) {
            StringBuilder date = new StringBuilder();

            if (_includeDate || _includeTime) {
                DateTime d = new DateTime();
                
                if (_includeDate) {
                    date.Append(d.Month + 1)
                        .Append("/").Append(d.Date)
                        .Append("/").Append(d.Year)
                        .Append(_fieldSeperator);
                }

                if (_includeTime) {
                    date.Append(PadTime(d.Hour)).Append(":")
                        .Append(PadTime(d.Minute)).Append(":")
                        .Append(PadTime(d.Second)).Append(".")
                        .Append(PadTime(d.Millisecond, true))
                        .Append(_fieldSeperator);
                }
            }

            string level = "";

            if (_includeLevel) {
                level = string.Format("[{0}]{1}", LogUtil.LevelStringFor(e.Level), _fieldSeperator);
            }

            string category = _includeCategory ? ((ILogger)sender).Category + _fieldSeperator : "";

            InternalLog(string.Format("{0}{1}{2}{3}", date.ToString(), level, category, e.Message));
        }

        private string PadTime(int num, Boolean millis = false) {
            if (millis) {
                if (num < 10) {
                    return "00" + num.ToString();
                } else if (num < 100) {
                    return "0" + num.ToString();
                } else {
                    return num.ToString();
                }
            }

            return num > 9 ? num.ToString() : "0" + num.ToString();
        }

        protected virtual void InternalLog(string message) {
            // Override this to internally log.
        }

        #endregion

        #region Properties

        /// <summary>
        /// This property contains the field separator character(s) for
        /// the log.
        /// </summary>
        public string FieldSeperator {
            get {
                return _fieldSeperator;
            }
            set {
                _fieldSeperator = value;
            }
        }

        /// <summary>
        /// This property is set to <c>true</c> if the log category is included in
        /// the log.
        /// </summary>
        public Boolean IncludeCategory {
            get {
                return _includeCategory;
            }
            set {
                _includeCategory = value;
            }
        }

        /// <summary>
        /// This property is set to <c>true</c> if the date is included in the log.
        /// </summary>
        public Boolean IncludeDate {
            get {
                return _includeDate;
            }
            set {
                _includeDate = value;
            }
        }

        /// <summary>
        /// This property is set to <c>true</c> if the level is included in the log.
        /// </summary>
        public Boolean IncludeLevel {
            get {
                return _includeLevel;
            }
            set {
                _includeLevel = value;
            }
        }

        /// <summary>
        /// This property is set to <c>true</c> if the time is included in the log.
        /// </summary>
        public Boolean IncludeTime {
            get {
                return _includeTime;
            }
            set {
                _includeTime = value;
            }
        }

        #endregion
    }
}
