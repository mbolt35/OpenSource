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

namespace Bolt.CSharp.Xml {

    using System;
    using System.Windows;
    using System.Collections.Generic;
    using System.Collections;
    using System.Text;
    using System.Xml;
    using System.IO;
    using System.Reflection;

    using Bolt.CSharp.Logging;
 

    /// <summary>
    /// This class parses xml data into <c>Xml</c> instances.
    /// </summary>
    /// <author>Matt Bolt [mbolt35@gmail.com]</author>
    public class XmlParser : IDisposable {

        #region Variables

        private static readonly ILogger log = Log.GetLogger(LogUtil.CategoryFor(MethodBase.GetCurrentMethod()));

        private XmlReaderSettings _settings;

        #endregion

        #region Constructors

        /// <summary>
        /// Creates a new <c>XmlParser</c> instance
        /// </summary>
        public XmlParser() {
            _settings = new XmlReaderSettings() {
                IgnoreComments = true,
                IgnoreWhitespace = true
            };
        }

        /// <summary>
        /// Creates a new <c>XmlParser</c> instance
        /// </summary>
        /// <param name="settings">The settings to use when parsing the xml data</param>
        public XmlParser(XmlReaderSettings settings) {
            _settings = settings;
        }

        #endregion

        #region Methods

        /// <summary>
        /// This method parses an incoming <c>Stream</c> containing xml data
        /// into an <c>Xml</c> instance.
        /// </summary>
        /// <param name="xmlStream">The <c>Stream</c> containing the xml data to parse.</param>
        /// <returns>An <c>Xml</c> instance containing the parsed data.</returns>
        public Xml Parse(Stream xmlStream) {
            using (StreamReader reader = new StreamReader(xmlStream)) {
                using (StringReader strReader = new StringReader(reader.ReadToEnd())) {
                    return Parse(strReader);
                }
            }
        }

        /// <summary>
        /// This method parses a <c>string</c> representing xml data into
        /// an <c>Xml</c> instance.
        /// </summary>
        /// <param name="xmlString">The <c>string</c> containing xml</param>
        /// <returns>An <c>Xml</c> instance containing the parsed data.</returns>
        public Xml Parse(string xmlString) {
            using (StringReader strReader = new StringReader(xmlString)) {
                return Parse(strReader);
            }
        }

        /// <summary>
        /// This method parses xml using a <c>StringReader</c> instance and returns an <c>Xml</c> instance
        /// containing the parsed data.
        /// </summary>
        /// <param name="stringReader">The <c>StringReader</c> instance containing the xml data to parse</param>
        /// <returns>An <c>Xml</c> instance containing the parsed data.</returns>
        public Xml Parse(StringReader stringReader) {
            using (XmlReader reader = XmlReader.Create(stringReader, _settings)) {
                Xml currentElement = null;
                Stack<Xml> elementStack = new Stack<Xml>();

                while (reader.Read()) {

                    switch (reader.NodeType) {

                        // Handle Open Element, <element>
                        case XmlNodeType.Element:
                            Xml xmlElement = new Xml(reader.Name, reader.NamespaceURI);

                            // Check for Attributes and Read All Attributes
                            if (reader.HasAttributes) {
                                while (reader.MoveToNextAttribute()) {
                                    xmlElement.AddAttribute(reader.Name, reader.Value);
                                }
                                
                                // Move back to the element
                                reader.MoveToElement();
                            }

                            // Handles node that only contains attributes: <someNode x='10' y='5'/>
                            if (!reader.HasValue && reader.IsEmptyElement) {
                                currentElement.AppendElement(xmlElement);
                                break;
                            }
                            
                            elementStack.Push(xmlElement);

                            if (currentElement == null) {
                                currentElement = xmlElement;
                            } else {
                                currentElement.AppendElement(xmlElement);
                                currentElement = xmlElement;
                            }

                            break;

                        // Handle attribute or element text, ... prop="myProp" ...
                        case XmlNodeType.Text:
                            currentElement.Value = reader.Value;
                            break;

                        // Handle end element, </element>
                        case XmlNodeType.EndElement:
                            if (elementStack.Count > 1) {
                                elementStack.Pop();

                                currentElement = elementStack.Peek();
                            } else if (elementStack.Count > 0) {
                                elementStack.Pop();
                            }

                            break;
                    }
                }

                return currentElement;
            }
        }

        /// <summary>
        /// Disposes of this objects instance data.
        /// </summary>
        public void Dispose() {
            _settings = null;
        }

        #endregion

        #region Properties

        #endregion

    }
}
