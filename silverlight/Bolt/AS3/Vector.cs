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
    using System.Windows;
    using System.Collections.Generic;
    using System.Collections;
    using System.Text;
 

    /// <summary>
    /// This callback delegate is used with the <c>Map()</c> method in <c>Vector</c>
    /// </summary>
    public delegate T VectorMapCallback<T>(T item, int index, Vector<T> vector);

    /// <summary>
    /// This callback delegate is used with the <c>ForEach()</c> method in <c>Vector</c>
    /// </summary>
    public delegate void VectorForEachCallback<T>(T item, int index, Vector<T> vector);

    /// <summary>
    /// This callback delegate is used with the <c>Filter(), Every(), Some()</c> methods in <c>Vector</c>
    /// </summary>
    public delegate Boolean VectorFilterCallback<T>(T item, int index, Vector<T> vector);

    /// <summary>
    /// This class is a Silverlight (C#) version of the <c>Vector.&lt;T&gt;</c> class from AS3. It uses generics
    /// to handle multiple types, and is backed by a <c>System.Collections.Generic.List&lt;T&gt;</c> instance. Note
    /// that the performance may be a slight amount slower than a native collection, but you'll get the AS3 methods.
    /// 
    /// <para>You can also access the indices like you would an array or list using the [] brackets. You may also use
    /// <c>foreach</c> iteration.</para>
    ///
    /// <para>*Note that isFixed is not yet implemented, but is stubbed out*</para>
    /// 
    /// <para>The Vector class lets you access and manipulate a vector — an array whose elements all have the 
    /// same data type. The data type of a Vector's elements is known as the Vector's base type. The base 
    /// type can be any class, including built in classes and custom classes. The base type is specified 
    /// when declaring a Vector variable as well as when creating an instance by calling the class constructor.</para>
    /// </summary>
    public class Vector<T> : IEnumerable<T>, IEnumerable {

        #region Variables

        private List<T> _list;
        private Boolean _isFixed;

        #endregion

        #region Constructors

        /// <summary>
        /// Creates a new <c>Vector</c> instance.
        /// </summary>
        public Vector() {
            _list = new List<T>();
        }

        /// <summary>
        /// Creates a new <c>Vector</c> instance.
        /// </summary>
        /// <param name="size"></param>
        public Vector(int size) {
            if (size <= 0) {
                throw new ArgumentOutOfRangeException("Size must be > 0");
            }

            _list = new List<T>(size);
        }

        /// <summary>
        /// Creates a new <c>Vector</c> instance.
        /// </summary>
        /// <param name="size">The default capacity of the vector</param>
        /// <param name="isFixed">Whether or not the vector is fixed length or not</param>
        public Vector(int size, Boolean isFixed) {
            if (size == 0 && isFixed) {
                throw new Exception("Cannot created a 0 sized fixed length Vector!");
            }

            _list = new List<T>(size);
            _isFixed = isFixed;
        }

        #endregion

        #region Methods

        /// <summary>
        /// Concatenates the elements specified in the parameters with the elements 
        /// in the <c>Vector</c> and creates a new <c>Vector</c>.
        /// </summary>
        /// <param name="objs"></param>
        /// <returns></returns>
        public Vector<T> Concat(params object[] objs) {
            Vector<T> vectorCopy = new Vector<T>();
            foreach (T item in this) {
                vectorCopy.Push(item);
            }

            foreach (object obj in objs) {
                if (obj is Vector<T>) {
                    Vector<T> vector = obj as Vector<T>;

                    foreach (T item in vector) {
                        vectorCopy.Push(item);
                    }
                } else if (obj is T) {
                    vectorCopy.Push((T)obj);
                }
            }

            return vectorCopy;
        }

        /// <summary>
        /// Access the index of a <c>Vector</c> like you would an array.
        /// </summary>
        /// <param name="index"></param>
        /// <returns></returns>
        public T this[int index] {
            get {
                if (index < 0 || index >= _list.Count) {
                    throw new IndexOutOfRangeException();
                }

                return _list[index];
            }
            set {
                if (index < 0 || index >= _list.Count) {
                    throw new IndexOutOfRangeException();
                }

                _list[index] = value;
            }
        }

        /// <summary>
        /// Searches for an item in the Vector and returns the index position of the item.
        /// </summary>
        /// <param name="item"></param>
        /// <returns></returns>
        public int IndexOf(T item) {
            return _list.IndexOf(item);
        }

        /// <summary>
        /// Adds one or more elements to the end of the Vector and returns the new length of the <c>Vector</c>.
        /// </summary>
        /// <param name="item"></param>
        /// <returns></returns>
        public int Push(params T[] items) {
            _list.AddRange(items);
            return _list.Count;
        }

        /// <summary>
        /// Removes the last element from the <c>Vector</c> and returns that element.
        /// </summary>
        public T Pop() {
            T result = _list[_list.Count - 1];
            _list.RemoveAt(_list.Count - 1);

            return result;
        }

        /// <summary>
        /// Adds elements to and removes elements from the Vector.
        /// </summary>
        /// <param name="index"></param>
        /// <param name="deleteCount"></param>
        /// <param name="items"></param>
        public void Splice(int index, int deleteCount, params T[] items) {
            int length = index + deleteCount;

            for (int i = index; i < length; ++i) {
                _list.RemoveAt(i);
            }

            _list.InsertRange(index, items);
        }

        /// <summary>
        /// Removes the first element from the Vector and returns that element.
        /// </summary>
        /// <returns></returns>
        public T Shift() {
            T result = _list[0];
            _list.RemoveAt(0);

            return result;
        }

        /// <summary>
        /// Adds one or more elements to the beginning of the Vector and returns the new length of the <c>Vector</c>.
        /// </summary>
        /// <param name="items"></param>
        /// <returns></returns>
        public int Unshift(params T[] items) {
            _list.InsertRange(0, items);

            return _list.Count;
        }

        /// <summary>
        /// Converts the elements in the Vector to strings, inserts the specified separator between the elements, concatenates 
        /// them, and returns the resulting string.
        /// </summary>
        /// <param name="sep"></param>
        /// <returns></returns>
        public String Join(String sep = ",") {
            StringBuilder builder = new StringBuilder();

            for (int i = 0; i < _list.Count; ++i) {
                builder.Append(_list[i]);

                if (i != _list.Count - 1) {
                    builder.Append(sep);
                }
            }

            return builder.ToString();
        }

        /// <summary>
        /// Reverses the order of the elements in the Vector.
        /// </summary>
        public Vector<T> Reverse() {
            _list.Reverse();

            return this;
        }

        /// <summary>
        /// Returns a new <c>Vector</c> that consists of a range of elements from the original <c>Vector</c>, without 
        /// modifying the original <c>Vector</c>.
        /// </summary>
        /// <param name="startIndex"></param>
        /// <returns></returns>
        public Vector<T> Slice(int startIndex) {
            Vector<T> v = this.Concat();

            for (int i = 0; i < startIndex; ++i) {
                v.Shift();
            }

            return v;
        }

        /// <summary>
        /// Returns a new <c>Vector</c> that consists of a range of elements from the original <c>Vector</c>, without 
        /// modifying the original <c>Vector</c>.
        /// </summary>
        /// <param name="startIndex"></param>
        /// <param name="endIndex"></param>
        /// <returns></returns>
        public Vector<T> Slice(int startIndex, int endIndex) {
            Vector<T> v = this.Concat();

            for (int i = 0; i < startIndex; ++i) {
                v.Shift();
            }

            for (int i = endIndex; i < _list.Count; ++i) {
                v.Pop();
            }

            return v;
        }

        /// <summary>
        /// Executes a function on each item in the <c>Vector</c>, and returns a new <c>Vector</c> of items corresponding 
        /// to the results of calling the function on each item in this <c>Vector</c>.
        /// </summary>
        /// <param name="callback"></param>
        /// <returns>A new <c>Vector</c> instance containing the mapped result</returns>
        public Vector<T> Map(VectorMapCallback<T> callback) {
            Vector<T> mappedList = new Vector<T>();

            foreach (T item in _list) {
                mappedList.Push(callback(item, _list.IndexOf(item), this));
            }

            return mappedList;
        }

        /// <summary>
        /// Executes a test function on each item in the <c>Vector</c> until an item is reached that returns <c>true</c>. 
        /// Use this method to determine whether any items in a <c>Vector</c> meet a criterion, such as having a 
        /// value less than a particular number.
        /// </summary>
        /// <param name="callback"></param>
        public Boolean Some(VectorFilterCallback<T> callback) {
            foreach (T item in _list) {
                if (callback(item, _list.IndexOf(item), this)) {
                    return true;
                }
            }

            return false;
        }

        /// <summary>
        /// Executes a test function on each item in the <c>Vector</c> until an item is reached that returns <c>true</c>.
        /// </summary>
        /// <param name="callback"></param>
        /// <returns></returns>
        public Boolean Every(VectorFilterCallback<T> callback) {
            Boolean all = true;

            foreach (T item in _list) {
                all = all && callback(item, _list.IndexOf(item), this);
            }

            return all;
        }

        /// <summary>
        /// Executes a test function on each item in the Vector and returns a new Vector containing all items that return true for the specified function.
        /// </summary>
        /// <param name="callback"></param>
        /// <returns></returns>
        public Vector<T> Filter(VectorFilterCallback<T> callback) {
            Vector<T> filteredList = new Vector<T>();

            foreach (T item in _list) {
                if (callback(item, _list.IndexOf(item), this)) {
                    filteredList.Push(item);
                }
            }

            return filteredList;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="callback"></param>
        /// <returns></returns>
        public void ForEach(VectorForEachCallback<T> callback) {
            foreach (T item in _list) {
                callback(item, _list.IndexOf(item), this);
            }
        }

        /// <summary>
        /// Creates and returns a new <c>IEnumerator</c> for a <c>Vector</c> instance.
        /// </summary>
        public IEnumerator<T> GetEnumerator() {
            return new VectorEnumerator(_list);
        }

        /// <summary>
        /// Creates and returns a new <c>IEnumerator</c> for a <c>Vector</c> instance.
        /// </summary>
        IEnumerator IEnumerable.GetEnumerator() {
            return GetEnumerator();
        }

        #endregion

        #region Class VectorEnumerator

        class VectorEnumerator : IEnumerator<T> {
            private List<T> _collection;
            private int _currentIndex;
            private T _currentT;

            public VectorEnumerator(List<T> collection) {
                _collection = collection;
                _currentIndex = -1;
                _currentT = default(T);
            }

            public bool MoveNext() {
                if (++_currentIndex >= _collection.Count) {
                    return false;
                } else {
                    _currentT = _collection[_currentIndex];
                }

                return true;
            }

            public void Reset() {
                _currentIndex = -1;
            }

            public T Current {
                get {
                    return _currentT;
                }
            }

            object IEnumerator.Current {
                get { 
                    return Current; 
                }
            }

            void IDisposable.Dispose() { }
        }

        #endregion

    }
}
