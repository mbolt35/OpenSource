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
    using System.Text;
    using System.IO;
    using System.Net;
    using System.Net.Sockets;
    using System.Threading;
    using System.Diagnostics;
    using System.Collections.Generic;

    using Bolt.CSharp.Logging;

    /// <summary>
    /// This class is used to send logs to the SOS Max Socket Output Server - http://sos.powerflasher.com/
    /// It's based off the AS3 SOSLogTarget written by Sönke Rohde.
    /// </summary>
    /// <author>Matt Bolt, Electrotank(C) 2010</author>
    public class SosLogTarget : LineFormattedTarget, ILoggingTarget {

        #region Variables

        private Socket _socket;
        private DnsEndPoint _endPoint;

        private Boolean _connected = false;
        private Boolean _connecting = false;

        private List<LogItem> _history = new List<LogItem>();

        #endregion

        #region Constructor

        /// <summary>
        /// Creates a new <c>SosLogTarget</c> instance
        /// </summary>
        public SosLogTarget() : base() {

        }

        #endregion

        #region Methods

        /// <summary>
        /// This method connects to the socket output server.
        /// </summary>
        /// <param name="host">This parameter is set to the hostname to connect to.</param>
        /// <param name="port">This parameter is set to the port for the server.</param>
        private void Connect(string host = "localhost", int port = 4444) {
            _endPoint = new DnsEndPoint(host, port);
            _socket = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp);
            _connecting = true;

            SocketAsyncEventArgs args = new SocketAsyncEventArgs();
            args.UserToken = _socket;
            args.RemoteEndPoint = _endPoint;
            args.Completed += (s, e) => {
                _connected = (e.SocketError == SocketError.Success);
                _connecting = false;

                if (!_connected) {
                    Debug.WriteLine("Socket Connect Error: {0}", new string[] { e.SocketError.ToString() });
                } else {
                    foreach (LogItem item in _history) {
                        Send(Serialize(FormatLogMessageFor(item)));
                    }

                    _history.Clear();
                }
            };

            _socket.ConnectAsync(args);
        }

        /// <summary>
        /// This method disconnects from the socket server.
        /// </summary>
        private void Disconnect() {
            if (_socket != null) {
                _socket.Close();
            }

        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        public override void  OnLogEvent(object sender, LogEventArgs e) {
            LogItem log = new LogItem(e.Message);

            if (IncludeLevel) {
                log.Level = e.Level;
            }

            log.Category = IncludeCategory ? ((ILogger)sender).Category : "";

            if (_socket != null && _socket.Connected) {
                Send(Serialize(FormatLogMessageFor(log)));
            } else {
                if (!_connecting) {
                    Connect("localhost", 4444);
                }

                _history.Add(log);
            }
        }
          
        /// <summary>
        /// 
        /// </summary>
        /// <param name="log"></param>
        /// <returns></returns>
        private string FormatLogMessageFor(LogItem logItem) {
            string log = logItem.Log;
            string[] lines = log.Split('\n');
            string commandType = lines.Length == 1 ? "showMessage" : "showFoldMessage";
            string level = LogUtil.LevelStringFor(logItem.Level);
            string prefix = "";
            Boolean isMultiLine = lines.Length > 1;

            if (logItem.Category != null) {
                prefix += logItem.Category + FieldSeperator;
            }

            return new StringBuilder("!SOS<")
                .Append(commandType)
                .Append(" key=\"")
                .Append(level)
                .Append("\">")
                .Append(!isMultiLine ? ReplaceXmlSymbols(prefix + log) : LogMessageFor(prefix + lines[0], log))
                .Append("</")
                .Append(commandType)
                .Append(">")
                .ToString();
        }

        /// <summary>
        /// Format the log for SOS Max.
        /// </summary>
        /// <param name="log"></param>
        /// <returns></returns>
        private string LogMessageFor(string title, string log) {
            return new StringBuilder("\n<title>")
                   .Append(ReplaceXmlSymbols(title))
                   .Append("</title>\n")
                   .Append("<message>")
                   .Append(ReplaceXmlSymbols(log.Substring(log.IndexOf('\n') + 2)))
                   .Append("</message>\n")
                   .ToString();
        }

        /// <summary>
        /// This method replaces the greater and less than signs with &lt; and &gt;
        /// </summary>
        /// <param name="str">The string used as the replacement target</param>
        /// <returns>A new <c>string</c> containing the replacements</returns>
        private string ReplaceXmlSymbols(string str) {
            return str.Replace("<", "&lt;").Replace(">", "&gt;");
        }

        /// <summary>
        /// Serializes the message into a byte array
        /// </summary>
        /// <param name="message"></param>
        /// <returns></returns>
        private byte[] Serialize(string message) {
            char[] msgString = message.ToCharArray();
            byte[] byteArray = new byte[message.Length + 1];

            for (int i = 0; i < msgString.Length; ++i) {
                byteArray[i] = (byte)msgString[i];
            }

            // Must terminate with a null byte!
            byteArray[message.Length] = 0;

            return byteArray;
        }

        /// <summary>
        /// Sends the serialized buffer via the socket.
        /// </summary>
        /// <param name="buffer"></param>
        private void Send(byte[] buffer) {
            SocketAsyncEventArgs args = new SocketAsyncEventArgs();
            args.SocketClientAccessPolicyProtocol = SocketClientAccessPolicyProtocol.Tcp;
            args.SetBuffer(buffer, 0, buffer.Length);
            args.UserToken = _socket;
            args.RemoteEndPoint = _endPoint;
            args.Completed += (s, e) => {
                if (e.SocketError != SocketError.Success) {
                    _connected = false;
                    _socket.Close();
                }
            };

            _socket.SendAsync(args);
        }

        #endregion

        #region Properties

        /// <summary>
        /// This read-only property represents the server host the logger connects to.
        /// </summary>
        public string Host {
            get {
                return _endPoint.Host;
            }
        }

        /// <summary>
        /// This read-only property represents the server port the logger connects to.
        /// </summary>
        public int Port {
            get {
                return _endPoint.Port;
            }
        }

        /// <summary>
        /// This read-only property is set to <c>true</c> if we've successfully connectted to the server.
        /// </summary>
        public Boolean IsConnected {
            get {
                return _socket != null && _socket.Connected;
            }
        }

        #endregion

        #region LogItem Class

        /// <summary>
        /// This class contains a log that is made while the socket connection has not been made, but is attempting to
        /// connect. Once the connection is established, the hisory items are immediately logged.
        /// </summary>
        private class LogItem {
            private string _name;
            private LogLevel _level;
            private string _category;

            public LogItem(string log) {
                this.Log = log;
            }

            public LogItem(string log, LogLevel level) {
                this.Log = log;
                this.Level = level;
            }

            public string Log {
                get {
                    return _name;
                }
                set {
                    _name = value;
                }
            }

            public LogLevel Level {
                get {
                    return _level;
                }
                set {
                    _level = value;
                }
            }

            public string Category {
                get {
                    return _category;
                }
                set {
                    _category = value;
                }
            }
        }

        #endregion

    }
}