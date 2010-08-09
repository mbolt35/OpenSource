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

using System;
using System.Text;
using System.IO;
using System.Net;
using System.Net.Sockets;
using System.Threading;
using System.Diagnostics;
using System.Collections.Generic;

/// <summary>
/// This class is used to send logs to the SOS Max Socket Output Server - http://sos.powerflasher.com/
/// It's based off the AS3 SOSLogTarget written by Sönke Rohde.
/// 
/// <example>This example shows how to use the SOSLog class.
/// <code>
/// using System;
/// using System.Net;
/// using System.Windows;
/// using System.Threading;
/// 
/// public partial class MainClass : Application {
///     private Timer timer;
///     private int countdown = 10;
///     
///     public MainClass() {
///         InitializeLogging();
///         
///         TimerCallback callback = new TimerCallback(Log);
///         timer = new Timer(callback, null, 1000, 1000);
///     }
///     
///     public void InitializeLogging() {
///         SOSLog.Instance.Connect();
///     }
///     
///     public void Log(Object state) {
///         if (countdown == 10) {
///             SOSLog.Instance.Log("Countdown Started!");
///         } else if (countdown == 0) {
///             SOSLog.Instance.Log("Countdown Finished!", "FATAL");
///             timer.Dispose();
///             return;
///         }
///         
///         SOSLog.Instance.Log(countdown.ToString(), "INFO");
///         
///         countdown--;
///     }
/// }
/// </code>
/// </example>
/// </summary>
public class SOSLog {

    private static SOSLog _instance;

    /// <summary>
    /// The singleton instance for the logger.
    /// </summary>
    public static SOSLog Instance {
        get {
            if (_instance == null) {
                _instance = new SOSLog();
            }

            return _instance;
        }
    }

    private DnsEndPoint _endPoint;

    private Boolean _connecting = false;

    private Socket _socket;

    private Boolean _connected = false;

    private List<HistoryItem> _history = new List<HistoryItem>();

    private SOSLog() {

    }

    /// <summary>
    /// This method connects to the socket output server.
    /// </summary>
    /// <param name="host">This parameter is set to the hostname to connect to.</param>
    /// <param name="port">This parameter is set to the port for the server.</param>
    public void Connect(String host = "localhost", int port = 4444) {
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
                foreach (HistoryItem item in _history) {
                    Log(item.Log, item.Level);
                }

                _history.Clear();
            }
        };

        _socket.ConnectAsync(args);
    }

    /// <summary>
    /// This method disconnects from the socket server.
    /// </summary>
    public void Disconnect() {
        if (_socket != null) {
            _socket.Close();
        }
        
    }

    /// <summary>
    /// This method logs the message to the server using the set level.
    /// </summary>
    /// <param name="log">This is the message you wish to log to the server.</param>
    /// <param name="level">This is the level which you want the log to display.</param>
    public void Log(String log, String level = "DEBUG") {
        if (!IsConnected) {
            if (_connecting) {
                _history.Add(new HistoryItem(log, level));
            }

            return;
        }

        String[] lines = log.Split('\n');
        String commandType = lines.Length == 1 ? "showMessage" : "showFoldMessage";
        String msg;

        if (lines.Length > 1) {
             msg = new StringBuilder("<title>")
                .Append(lines[0])
                .Append("</title>")
                .Append("<message>")
                .Append(log.Substring(log.IndexOf('\n') + 1, log.Length))
                .Append("</message")
                .ToString();
        } else {
            msg = log;
        }

        String xmlMessage = new StringBuilder("!SOS<")
            .Append(commandType)
            .Append(" key=\"")
            .Append(level)
            .Append("\">")
            .Append(msg)
            .Append("</")
            .Append(commandType)
            .Append(">")
            .ToString();

        char[] msgString = xmlMessage.ToCharArray();
        byte[] byteArray = new byte[xmlMessage.Length + 1];

        for (int i = 0; i < msgString.Length; ++i) {
            byte b = (byte)msgString[i];

            byteArray[i] = b;
        }

        // Must terminate with a null byte!
        byteArray[xmlMessage.Length] = 0;

        SocketAsyncEventArgs args = new SocketAsyncEventArgs();
        args.SocketClientAccessPolicyProtocol = SocketClientAccessPolicyProtocol.Tcp;
        args.SetBuffer(byteArray, 0, byteArray.Length);
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

}


#region HistoryItemClass

/// <summary>
/// This class contains a log that is made while the socket connection has not been made, but is attempting to
/// connect. Once the connection is established, the hisory items are immediately logged.
/// </summary>
class HistoryItem {
    private String _name;
    private String _level;

    public HistoryItem(String log, String level) {
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

    public String Level {
        get {
            return _level;
        }
        set {
            _level = value;
        }
    }
}

#endregion
