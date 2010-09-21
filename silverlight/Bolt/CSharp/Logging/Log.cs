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
    using System.Collections;
    using System.Text;

    /// <summary>
    /// 
    /// </summary>
    public static class Log {

        #region Variables

        private static int _targetLevel = int.MaxValue;
        private static Dictionary<string, ILogger> _loggers = new Dictionary<string, ILogger>();
        private static List<ILoggingTarget> _targets = new List<ILoggingTarget>();
        
        #endregion

        #region Methods

        public static ILogger GetLogger(string category) {
            if (!_loggers.ContainsKey(category)) {
                _loggers[category] = new LogLogger(category);
            }

            ILogger result = _loggers[category];

            ILoggingTarget target;
            for (int i = 0; i < _targets.Count; ++i) {
                target = _targets[i];

                if (CategoryMatchInFilterList(category, target.Filters)) {
                    target.AddLogger(result);
                }
            }

            return result;
        }

        public static void AddTarget(ILoggingTarget target) {
            if (target == null) {
                return;
            }

            List<string> filters = target.Filters;

            foreach (string key in _loggers.Keys) {
                if (CategoryMatchInFilterList(key, filters)) {
                    target.AddLogger(_loggers[key]);
                }
            }

            _targets.Add(target);
            if (_targetLevel == int.MaxValue || (int)target.Level < _targetLevel) {
                _targetLevel = (int)target.Level;
            } else if ((int)target.Level < _targetLevel) {
                _targetLevel = (int)target.Level;
            }
        }

        public static void RemoveTarget(ILoggingTarget target) {
            if (target == null) {
                return;
            }

            List<string> filters = target.Filters;

            foreach (string key in _loggers.Keys) {
                if (CategoryMatchInFilterList(key, filters)) {
                    target.RemoveLogger(_loggers[key]);
                }

            }

            for (int j = 0; j < _targets.Count; j++) {
                if (target == _targets[j]) {
                    _targets.RemoveAt(j);
                    j--;
                }
            }

            ResetTargetLevel();
        }

        private static void ResetTargetLevel() {
            int minLevel = int.MaxValue;
            for (int i = 0; i < _targets.Count; ++i) {
                if (minLevel == int.MaxValue || (int)_targets[i].Level < minLevel) {
                    minLevel = (int)_targets[i].Level;
                }
            }

            _targetLevel = minLevel;
        }

        private static Boolean CategoryMatchInFilterList(string category, List<string> filters) {
            string filter;
            int index = -1;

            for (int i = 0; i < filters.Count; ++i) {
                filter = filters[i];
                index = filter.IndexOf("*");

                if (index == 0) {
                    return true;
                }

                index = index < 0 ? category.Length : index - 1;

                if (category.Substring(0, index) == filter.Substring(0, index)) {
                    return true;
                }
            }

            return false;
        }

        #endregion

        #region Properties

        

        #endregion
    }
}
