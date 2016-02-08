using System;
using System.Data;
using System.Data.SqlTypes;
using Microsoft.SqlServer.Server;
using System.Text.RegularExpressions;

namespace CSUDF_STR {
    public static class strUtil {
        public static string padFun(string str, bool true_for_left, int len, char symbol) {
            return true_for_left ? str.PadLeft(len, symbol) : str.PadRight(len, symbol);
        }
    }


    public static class UDF_STR {
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