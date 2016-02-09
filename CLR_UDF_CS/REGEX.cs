using System;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using Microsoft.SqlServer.Server;
using System.Collections;
using System.Collections.Generic;
using System.Text.RegularExpressions;


namespace CSUDF_REGEX {
    public static class regexUtil {

        public enum regexAct {
            Match = 0,
            Replace = 1,
            Matches = 2,
        };
        public static string regexFun(string target, string expr, object g, regexAct ra, string replStr, int replCnt, int replStart, ref MatchCollection o) {
            int gn = 0;
            Regex regex = new Regex(expr, RegexOptions.Multiline & RegexOptions.IgnoreCase);
            switch (ra) {
                case regexAct.Match:
                    var varMatch = regex.Match(target);
                    if (!varMatch.Success)
                    {
                        return null;
                    }
                    else {
                        if (Array.Exists(regex.GetGroupNames(), gpnm => (gpnm == (string)g)))
                        {
                            return varMatch.Groups[(string)g].Captures[0].Value;
                        }
                        else {
                            if (Int32.TryParse((string)g, out gn))
                            {
                                return varMatch.Groups[gn].Captures[0].Value;
                            }
                            else {
                                return varMatch.Groups[0].Captures[0].Value;
                            }
                        }
                    }
                case regexAct.Replace:
                    return regex.Replace(target, (string)replStr, replCnt, replStart);
                case regexAct.Matches:
                    var ms = regex.Matches(target);
                    o = ms;
                    return "0";
                default:
                    return "-1";
            }
        }

        public static string regexFun(string target, string expr, object g, regexAct ra, string replStr, int replCnt, int replStart) {
            var o = Regex.Matches("", "");
            return regexFun(target, expr, g, ra, replStr, replCnt, replStart, ref o);
        }
    }

    public class SPParameters {
        public SqlInt32 ParamID;
        public SqlString ParamName;
        public SqlString ParamType;
        public SqlString ParamDefaultStr;
        public SqlString ParamDefaultValue;
    }

    public static class UDF_REGEX {
        public static void FillSPParameters(
            object o
            , ref SqlInt32 param_id
            , ref SqlString param_name
            , ref SqlString param_type
            , ref SqlString param_default_str
            , ref SqlString param_default_value) {
            var oo = (SPParameters)o;
            param_id = oo.ParamID;
            param_name = oo.ParamName;
            param_type = oo.ParamType;
            param_default_str = oo.ParamDefaultStr;
            param_default_value = oo.ParamDefaultValue;
        }
        [SqlFunction(
            DataAccess = DataAccessKind.Read,
            FillRowMethodName = "FillSPParameters",
            TableDefinition = @"
                [ParamID][int],
                [ParamName][nvarchar](50),
                [ParamType][nvarchar](50),
                [ParamDefaultValueSQLStr][nvarchar](max),
                [ParamDefaultValue][nvarchar](max)")]
        public static ArrayList GetSPParamDefaultValue(string spDefinition) {
            var results = new ArrayList();
            MatchCollection o = null;
            string expr =
                "\\s*@(?<nm>\\w+)\\s*" +
                "(?<type>[^\\s\\(]+\\s*\\(\\s*((\\w+\\s*\\))|(\\d+\\s*\\))|(\\d+\\s*,\\s*\\d+\\s*\\))))\\s*=\\s*" +
                "(?<defvalueStr>((?<!(?-i)N*')(?<defvalue>\\w+)\\s*)|((?-i)N*'" +
                "(?<defvalue>(((?<![^']')''(?!'[^']))|([^']))*)" +
                "'))\\s*(,|\\))";
            regexUtil.regexFun(spDefinition, expr, null, (regexUtil.regexAct)2, null, 0, 0, ref o);
            int idx = 0;
            foreach (Match m in o) {
                var spparam = new SPParameters();
                spparam.ParamID = new SqlInt32(idx);
                spparam.ParamName = new SqlString(m.Groups["nm"].Value);
                spparam.ParamType = new SqlString(m.Groups["type"].Value);
                spparam.ParamDefaultStr = new SqlString(m.Groups["defvalueStr"].Value);
                spparam.ParamDefaultValue = new SqlString(m.Groups["defvalue"].Value);
                idx++;
                results.Add(spparam);
            }
            return results;
        }
        [SqlFunction(IsDeterministic = true, IsPrecise = true)]
        public static bool regexMatch(string target, string expr) {
            var regex = new Regex(expr, RegexOptions.Multiline & RegexOptions.IgnoreCase);
            return regex.IsMatch(target);
        }
        [SqlFunction(IsDeterministic = true, IsPrecise = true)]
        public static string regexVarMatchNm(string target, string expr, string group) {
            return (string)regexUtil.regexFun(target, expr, group, 0, null, 0, 0);
        }
    [SqlFunction(IsDeterministic = true, IsPrecise = true)]
    public static member regexVarMatchId(target : string, expr : string, group : int) =
            (string)(regexUtil.regexFun target expr group 0 null 0 0 None)
        }
        [SqlFunction(IsDeterministic = true, IsPrecise = true)]
        public static member regexReplace(target : string, expr : string, replacement : string) =
            (string)(regexUtil.regexFun target expr null 1 replacement -1 0 None)
        }
    }
}