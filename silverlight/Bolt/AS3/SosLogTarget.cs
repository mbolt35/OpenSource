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

namespace Bolt.AS3 {

    using System;
    using System.Text;
    using System.IO;
    using System.Net;
    using System.Net.Sockets;
    using System.Threading;
    using System.Diagnostics;
    using System.Collections.Generic;

    using Bolt.AS3.Logging;
    using Bolt.AS3.Logging.Target;

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
        public SosLogTarget()
            : base() {

        }

        #endregion

        #region Methods

        /// <summary>
        /// This method connects to the socket output server.
        /// </summary>
        /// <param name="host">This parameter is set to the hostname to connect to.</param>
        /// <param name="port">This parameter is set to the port for the server.</param>
        private void Connect(String host = "localhost", int port = 4444) {
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
                    Debug.WriteLine("Socket Connect Error: {0}", new String[] { e.SocketError.ToString() });
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
        public override void OnLogEvent(object sender, LogEventArgs e) {
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
        private String FormatLogMessageFor(LogItem logItem) {
            String log = logItem.Log;
            String[] lines = log.Split('\n');
            String commandType = lines.Length == 1 ? "showMessage" : "showFoldMessage";
            String level = LogUtil.LevelStringFor(logItem.Level);
            String prefix = "";
            Boolean isMultiLine = lines.Length > 1;

            if (logItem.Category != null) {
                prefix += logItem.Category + FieldSeperator;
            }

            string str = new StringBuilder("!SOS<")
                .Append(commandType)
                .Append(" key=\"")
                .Append(level)
                .Append("\">")
                .Append(!isMultiLine ? prefix + log : LogMessageFor(prefix + lines[0], log))
                .Append("</")
                .Append(commandType)
                .Append(">")
                .ToString();

            Debug.WriteLine(str);

            return str;

        }

        /// <summary>
        /// Format the log for SOS Max.
        /// </summary>
        /// <param name="log"></param>
        /// <returns></returns>
        private String LogMessageFor(String title, String log) {
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
        /// <returns>A new <c>String</c> containing the replacements</returns>
        private String ReplaceXmlSymbols(String str) {
            return str.Replace("<", "&lt;").Replace(">", "&gt;");
        }

        /// <summary>
        /// Serializes the message into a byte array
        /// </summary>
        /// <param name="message"></param>
        /// <returns></returns>
        private byte[] Serialize(String message) {
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
        public String Host {
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
            private String _name;
            private LogLevel _level;
            private String _category;

            public LogItem(String log) {
                this.Log = log;
            }

            public LogItem(String log, LogLevel level) {
                this.Log = log;
                this.Level = level;
            }

            public String Log {
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

            public String Category {
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