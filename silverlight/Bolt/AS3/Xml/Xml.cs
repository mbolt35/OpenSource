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

namespace Bolt.AS3.Xml {

    using System;
    using System.Windows;
    using System.Collections.Generic;
    using System.Collections;
    using System.Text;


    /// <summary>
    /// 
    /// </summary>
    public class Xml {

        #region Static Read-Only

        /// <summary>
        /// This static property contains the <c>Xml</c> 
        /// </summary>
        public static readonly Xml Undefined = new Xml(true);

        #endregion

        #region Variables

        private Xml _parent;

        private string _name;
        private string _namespaceUri;
        private string _qName;
        private string _value;
        private Boolean _isUndefined;

        private Dictionary<string, string> _attributes = new Dictionary<string, string>();
        private Dictionary<string, List<Xml>> _elements = new Dictionary<string, List<Xml>>();

        #endregion

        #region Constructors

        /// <summary>
        /// This static constructor executes one time when the first 
        /// instance is created.
        /// </summary>
        static Xml() {
            Undefined.Value = "undefined";
        }

        /// <summary>
        /// Creates a new <c>Xml</c> instance.
        /// </summary>
        /// <param name="name">The name of the element</param>
        /// <param name="namespaceUri">The namespace uri.</param>
        public Xml(string name, string namespaceUri) {
            _name = name;
            _namespaceUri = namespaceUri;
        }

        /// <summary>
        /// This private constructor is meant to be used for the "undefined"
        /// <c>Xml</c> instance only.
        /// </summary>
        /// <param name="isUndefined"></param>
        private Xml(Boolean isUndefined) {
            _isUndefined = isUndefined;
        }

        #endregion

        #region Methods

        /// <summary>
        /// This method adds an attribute to the <c>Xml</c> node.
        /// </summary>
        /// <param name="attributeName"></param>
        /// <param name="attributeValue"></param>
        public void AddAttribute(string attributeName, string attributeValue) {
            if (_isUndefined) {
                throw new Exception("Cannot add attributes to an undefined Xml node.");
            }

            _attributes[attributeName] = attributeValue;
        }

        /// <summary>
        /// This method returns an <c>Xml</c> attribute value using the name
        /// </summary>
        /// <param name="name"></param>
        /// <returns></returns>
        public string AttributeByName(string name) {
            if (_isUndefined) {
                return "";
            }

            if (!_attributes.ContainsKey(name)) {
                return "";
            }

            return _attributes[name];
        }

        /// <summary>
        /// This allows the <c>Xml</c> instance to behave using e4x specs. We can
        /// access elements and attributes using [] notation.
        /// </summary>
        /// <param name="index"></param>
        /// <returns></returns>
        public object this[string element] {
            get {
                if (element[0] == '@') {
                    return AttributeByName(element.Substring(1));
                }

                Xml ele = ElementByName(element);
                //if (ele.Elements.Count == 0 && ele._attributes.Count == 0) {
                //    return ele.Value;
                //}

                return ele;
            }
            set {
                if (element[0] == '@') {
                    AddAttribute(element.Substring(1), (string)value);
                } else if (value is Xml) {
                    AppendElement(value as Xml);
                }
            }
        }

        /// <summary>
        /// This method returns the first element in the list.
        /// </summary>
        /// <param name="name">The name of the element to return</param>
        /// <returns>The <c>Xml</c> instance for the element name</returns>
        public Xml ElementByName(string name) {
            List<Xml> list = ElementsByName(name);

            if (list.Count > 0) {
                return list[0];
            }

            return Undefined;
        }

        /// <summary>
        /// This method returns either a <c>List</c> of <c>Xml</c> elements.
        /// </summary>
        /// <param name="name"></param>
        /// <returns></returns>
        public List<Xml> ElementsByName(string name) {
            if (!_elements.ContainsKey(name)) {
                return new List<Xml>();
            }

            return _elements[name];
        }

        /// <summary>
        /// This method appends additional XML elements to this node.
        /// </summary>
        /// <param name="element"></param>
        public void AppendElement(Xml element) {
            if (_isUndefined) {
                throw new Exception("Cannot append elements to an undefined Xml node.");
            }

            if (!_elements.ContainsKey(element.Name)) {
                _elements[element.Name] = new List<Xml>();
            }

            _elements[element.Name].Add(element);

            element.SetParent(this);
        }

        /// <summary>
        /// This method returns a <c>string</c> representation of the <c>Xml</c> object.
        /// </summary>
        /// <returns></returns>
        public override string ToString() {
            if (_attributes.Count == 0 && _elements.Count == 0) {
                return Value;
            }

            return ToString("");
        }

        /// <summary>
        /// This method returns a <c>string</c> representation of the <c>Xml</c> object using
        /// a leading tab.
        /// </summary>
        /// <param name="tab"></param>
        /// <returns></returns>
        public string ToString(string tab) {
            StringBuilder str = new StringBuilder().AppendFormat("{0}<{1}", tab, _name);
            string newTab = string.Concat(tab, "  ");

            if (_attributes.Count > 0) {
                foreach (string attribKey in _attributes.Keys) {
                    str.AppendFormat(" {0}=\"{1}\"", attribKey, _attributes[attribKey]);
                }
            }

            if (_elements.Count > 0) {
                str.Append(">\n");

                foreach (string eleKey in _elements.Keys) {
                    foreach (Xml element in _elements[eleKey]) {
                        str.Append(element.ToString(newTab));
                    }
                }
            } else {
                if (_value == null) {
                    return str.Append("/>\n").ToString();
                }

                return str.AppendFormat(">{0}</{1}>\n", _value, _name).ToString();
            }

            return str.AppendFormat("{0}</{1}>\n", tab, _name).ToString();
        }

        /// <summary>
        /// This method creates a cloned copy of this instance and returns it.
        /// </summary>
        public Xml Clone() {
            if (_isUndefined) {
                throw new Exception("Cannot clone the undefined Xml node.");
            }

            Xml clone = new Xml(_name, _namespaceUri);

            foreach (string key in _attributes.Keys) {
                clone.AddAttribute(key, _attributes[key]);
            }

            foreach (Xml element in Elements) {
                clone.AppendElement(element);
            }

            clone.Value = Value;

            return clone;
        }
        

        /// <summary>
        /// This override method compares this <c>Xml</c> instance to another <c>object</c>
        /// </summary>
        /// <param name="obj"></param>
        /// <returns></returns>
        public override bool Equals(object obj) {
            if (obj is string) {
                return Value.Equals((string)obj);
            }

            if (obj is Xml) {
                return Value.Equals(((Xml)obj).Value);
            }

            return base.Equals(obj);
        }

        /// <summary>
        /// This method sets the parent for the <c>Xml</c> node.
        /// </summary>
        /// <param name="parent"></param>
        private void SetParent(Xml parent) {
            _parent = parent;
        }

        #endregion

        #region Static Methods

        /// <summary>
        /// This static method compares two <c>Xml</c> instances and returns their
        /// equality based on their <c>Value</c> property.
        /// </summary>
        /// <param name="node1">The first node to compare</param>
        /// <param name="node2">The second node to compare</param>
        /// <returns>A <c>true</c> if the two nodes are equal, otherwise <c>false</c></returns>
        public static Boolean Equals(Xml node1, Xml node2) {
            if (Xml.ReferenceEquals(node1, node2)) {
                return true;
            }

            return node1.Equals(node2);
        }

        #endregion

        #region Properties

        /// <summary>
        /// The elements name identifier.
        /// </summary>
        public string Name {
            get {
                return _name;
            }
        }

        /// <summary>
        /// The element namespace uri.
        /// </summary>
        public string NamespaceUri {
            get {
                return _namespaceUri;
            }
        }

        /// <summary>
        /// This property contains this <c>Xml</c> instance's parent node.
        /// </summary>
        public Xml Parent {
            get {
                return _parent;
            }
        }

        /// <summary>
        /// This property contains a list of all the elements in this <c>Xml</c>
        /// instance.
        /// </summary>
        public List<Xml> Elements {
            get {
                List<Xml> list = new List<Xml>();

                foreach (string key in _elements.Keys) {
                    foreach (Xml xmlNode in _elements[key]) {
                        list.Add(xmlNode);
                    }
                }

                return list;
            }
        }

        /// <summary>
        /// The element's value.
        /// </summary>
        public string Value {
            get {
                return _value;
            }
            set {
                _value = value;
            }
        }

        #endregion

        #region Operators

        public static explicit operator Xml(string xmlString) {
            using (XmlParser parser = new XmlParser()) {
                return parser.Parse(xmlString);
            }
        }

        public static Boolean operator ==(Xml node1, Xml node2) {
            return Xml.Equals(node1, node2);
        }

        public static Boolean operator !=(Xml node1, Xml node2) {
            return !Xml.Equals(node1, node2);
        }

        public static Xml operator +(Xml node1, Xml node2) {
            Xml clone = node1.Clone();

            foreach (Xml element in node2.Elements) {
                clone.AppendElement(element);
            }

            return clone;
        }

        public static Xml operator -(Xml node1, Xml node2) {
            Xml clone = node1.Clone();

            if (clone.ElementByName(node2.Name) == node2) {
                clone._elements.Remove(node2.Name);
            }

            return clone;
        }

        #endregion

    }
}
