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

namespace Bolt.CSharp {
    
    using System;
    using System.Windows;
    using System.Reflection;

    using Bolt.CSharp.Logging;
    using Bolt.CSharp.Logging.Target;


    /// <summary>
    /// This class demonstrates how to use the open-source C# logging framework at http://mattbolt.blogspot.com.
    /// </summary>
    /// <author>Matt Bolt [mbolt35@gmail.com]</author>
    public class LoggingExample {
        
        /// <summary>
        /// Creates a read-only static logger instance with the fully qualified class name as
        /// the category.
        /// </summary>
        private static readonly ILogger log = Log.GetLogger(MethodBase.GetCurrentMethod().DeclaringType.FullName);

        /// <summary>
        /// Creates a new <c>LoggingExample</c> instance
        /// </summary>
        public LoggingExample() {
            Init();

            DemoLogging();
        }

        /// <summary>
        /// Initializes the logger by adding targets. Note, that would only have to be done *once* in the entire
        /// application, unless removal, and re-adding were a necessity. Then a target could be removed with 
        /// <c>Log.RemoveTarget</c> and re-added with <c>Log.AddTarget</c>
        /// </summary>
        /// <remarks>Use the static class, Bolt.AS3.Logging.Log to setup your log targets!</remarks>
        private void Init() {
            // Use this type of target on a regular C# project -- this writes the log using System.Console.WriteLine
            Log.AddTarget(new ConsoleTarget() { IncludeCategory = true, IncludeLevel = true });            
            
            // Use this type of target in a Silverlight Application -- this writes a log using System.Diagnostics.Debug.WriteLine
            Log.AddTarget(new DebugConsoleTarget() { IncludeCategory = true, IncludeLevel = true });

            // This target can be used in a stand-alone Silverlight or regular C# project -- logs to PowerFlasher's SOS Max Logger 
            Log.AddTarget(new SosLogTarget() { IncludeCategory = true, IncludeLevel = true });
        }

        /// <summary>
        /// This method simply logs some lines to demo the use of the logger.
        /// </summary>
        private void DemoLogging() {
            int a = 25;
            string b = "Test, 1, 2, 3";
            bool c = true;

            // Use the read-only static instance to log!
            log.Info("This is a Logging Test");
            log.Debug("You can log like this: " + b);
            log.Warn("But it's preferable to use this: {0}", b);
            log.Error("You can have multiple parameters in your log: {0} - that are any type (object) - {1},\nand multiline is supported: {2}", c, b, a);
            log.Fatal("The End...");
        }

    }
}
