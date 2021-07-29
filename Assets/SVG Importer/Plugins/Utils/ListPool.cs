using System;
using System.Collections.Generic;
using UnityEngine;

namespace SVGImporter.Utils
{
    static class ListPool<T>
    {
        // Object pool to avoid allocations.
        private static readonly SVGImporter.Utils.ObjectPool<List<T>> s_ListPool = new SVGImporter.Utils.ObjectPool<List<T>>(null, Clear);
        static void Clear(List<T> l) { l.Clear(); }

        public static List<T> Get()
        {
            return s_ListPool.Get();
        }

        public static void Release(List<T> toRelease)
        {
            s_ListPool.Release(toRelease);
        }
    }
}
