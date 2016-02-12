using System;
using System.Data;
using System.Data.SqlTypes;
using Microsoft.SqlServer.Server;
using System.Text.RegularExpressions;
using System.Collections;
using System.Collections.Generic;
using System.Reflection;
//using System.Web.Script.Serialization;

namespace CSUDF_STR {
    public static class strUtil {
        public static string padFun(string str, bool true_for_left, int len, char symbol) {
            return true_for_left ? str.PadLeft(len, symbol) : str.PadRight(len, symbol);
        }
    }

    public class SplitTable<T>
    {
        public SqlInt32 ID;
        public T value;
    }


    public static class UDF_STR {

        public static void FillSplitTable<T>(
        object o
        , ref SqlInt32 ID
        , ref T value)
        {
            var oo = (SplitTable<T>)o;
            ID = oo.ID;
            value = oo.value;
        }
        public static void Fill2String(object o
        , ref SqlInt32 ID
        , ref SqlString value)
        {
            FillSplitTable<SqlString>(o, ref ID, ref value);
        }

        public static void Fill2Int(object o
        , ref SqlInt32 ID
        , ref SqlInt32 value)
        {
            FillSplitTable<SqlInt32>(o, ref ID, ref value);
        }

        [SqlFunction(
            DataAccess = DataAccessKind.Read,
            FillRowMethodName = "Fill2String",
            TableDefinition = @"
                [ID][int],
                [Value][nvarchar](max)")]
        //public static List<SplitTable<SqlString>> Split2String(string target, string splitter)
        public static ArrayList Split2String(string target, string splitter)
        {
            return Split2T<SqlString>(target, splitter);

        }

        [SqlFunction(
            DataAccess = DataAccessKind.Read,
            FillRowMethodName = "Fill2String",
            TableDefinition = @"
                [ID][int],
                [Value][nvarchar](max)")]
        public static ArrayList Split2StringDist(string target, string splitter)
        {
            return Split2T<SqlString>(target, splitter, true);

        }

        [SqlFunction(
            DataAccess = DataAccessKind.Read,
            FillRowMethodName = "Fill2Int",
            TableDefinition = @"
                [ID][int],
                [Value][int]")]
        //public static List<SplitTable<SqlString>> Split2String(string target, string splitter)
        public static ArrayList Split2Int(string target, string splitter)
        {
            return Split2T<SqlInt32>(target, splitter);

        }

        [SqlFunction(
            DataAccess = DataAccessKind.Read,
            FillRowMethodName = "Fill2Int",
            TableDefinition = @"
                [ID][int],
                [Value][int]")]
        //public static List<SplitTable<SqlString>> Split2String(string target, string splitter)
        public static ArrayList Split2IntDist(string target, string splitter)
        {
            return Split2T<SqlInt32>(target, splitter, true);

        }
        public static ArrayList Split2T<T>(string target, string splitter, bool ifDistinct)
        {
            //JavaScriptSerializer jss = new JavaScriptSerializer();
            var results = new ArrayList();
            int idx = 0;
            var tmp = target.Split(new[] { splitter }, StringSplitOptions.None);
            var dist = new Hashtable();
            foreach(string s in tmp)
            {
                //throw new Exception("456");
                bool keyexists = dist.ContainsKey(s);
                if (keyexists && ifDistinct == true)
                {
                    continue;
                }
                if (!keyexists) { dist.Add(s, null); }
                var stbl = new SplitTable<T>();
                stbl.ID = new SqlInt32(idx);
                //throw new Exception("123");
                //throw new Exception(Nullable.GetUnderlyingType(typeof(T)).Name);
                
                var cstrs = typeof(T).GetConstructors();
                //ConstructorInfo cstr = null;
                ParameterInfo cstrpi = null;
                //var cstrpi = cstrs[0].GetParameters()[0];
                int ctrl = 0;
                foreach (ConstructorInfo ci in cstrs)
                {
                    var gps = ci.GetParameters();
                    if (gps.Length == 1)
                    {
                        foreach (ParameterInfo pi in gps)
                        {
                            if (typeof(T).Name == "Sql" + pi.ParameterType.Name)
                            {
                                cstrpi = pi;
                                //cstr = ci;
                                ctrl = 1;
                                break;
                            }
                        }
                    }
                    if (ctrl == 1) { break; }
                }
                //throw new Exception(typeof(T).GetConstructors()[0].GetParameters().Length.ToString());

                var method = typeof(Convert).GetMethod(
                    "To" + cstrpi.ParameterType.Name, new[] { typeof(String) });
                //throw new Exception("000");
                if (method == null)
                {
                    //throw new Exception("456");
                    stbl.value = (T)Activator.CreateInstance(typeof(T), s);
                } else {
                    //throw new Exception(method.Invoke(null, new [] { s }).GetType().Name + " " + typeof(T).Name);
                    stbl.value = (T)Activator.CreateInstance(typeof(T), method.Invoke(null, new[] { s }));
                }
                idx++;
                results.Add(stbl);
            }
            return results;
        }

        public static ArrayList Split2T<T>(string target, string splitter)
        {
            return Split2T<T>(target, splitter, false);
        }

        [SqlFunction(IsDeterministic = true, IsPrecise = true)]
        public static string PadLeft(string str, int len, char symbol) {
            return strUtil.padFun(str, true, len, symbol);
        }

        [SqlFunction(IsDeterministic = true, IsPrecise = true)]
        public static string PadRight(string str, int len, char symbol) {
            return strUtil.padFun(str, false, len, symbol);
        }

        [SqlFunction(IsDeterministic = true, IsPrecise = true)]
        public static string Replicate(string str, int times) {
            return (new String('-', times)).Replace("-", str);
        }



    }

}