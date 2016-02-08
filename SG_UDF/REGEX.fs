namespace FSUDF_REGEX
open System
open System.Data
open System.Data.SqlClient
open System.Data.SqlTypes
open Microsoft.SqlServer.Server
open System.Collections
open System.Collections.Generic
open System.Text.RegularExpressions

module regexUtil =
    type regexAct =
    | Match = 0
    | Replace = 1
    | Matches = 2

    let regexFun = fun target expr group regexActMode replStr replCnt replStart (o : option<ref<_>>) ->
        let (|M|R|Ms|) regexActMode =
            match regexActMode % 3 with
             | 0 -> M
             | 1 -> R
             | 2 -> Ms
        let ra =
            match regexActMode with
            | M ->
                enum<regexAct>(0)
            | R ->
                enum<regexAct>(1)
            | Ms ->
                enum<regexAct>(2)
        let g = group :> Object
        let gn = ref 0
        let regex = new Regex(expr, RegexOptions.Multiline + RegexOptions.IgnoreCase)
        match ra with
        | regexAct.Match ->
            let varMatch = regex.Match(target)
            match varMatch.Success with
            | false -> null
            | true ->
                match Array.Exists(regex.GetGroupNames(), (fun gpnm -> (gpnm = (string)g))) with
                | true ->
                    varMatch.Groups.[(string)g].Captures.[0].Value
                | _ when Int32.TryParse((string)g, gn) ->
                    varMatch.Groups.Item(gn.Value).Captures.[0].Value
            | _ -> varMatch.Groups.[0].Captures.[0].Value
        | regexAct.Replace ->
            regex.Replace(target, (string)replStr, replCnt, replStart)
        | regexAct.Matches ->
            let ms = regex.Matches(target)
            o.Value := ms
            "0"
type public SPParameters =
    class
        [<DefaultValue>] val mutable ParamID : SqlInt32
        [<DefaultValue>] val mutable ParamName : SqlString
        [<DefaultValue>] val mutable ParamType : SqlString
        [<DefaultValue>] val mutable ParamDefaultStr : SqlString
        [<DefaultValue>] val mutable ParamDefaultValue : SqlString
        new () ={}
    end

type public UDF_REGEX =
    static member FillSPParameters(o : obj
        , param_id : SqlInt32 byref
        , param_name : SqlString byref
        , param_type : SqlString byref
        , param_default_str : SqlString byref
        , param_default_value : SqlString byref) =
        let o' = o :?> SPParameters
        param_id <- o'.ParamID
        param_name <- o'.ParamName
        param_type <- o'.ParamType
        param_default_str <- o'.ParamDefaultStr
        param_default_value <- o'.ParamDefaultValue
    [<SqlFunction(
        DataAccess = DataAccessKind.Read,
        FillRowMethodName = "FillSPParameters", 
        TableDefinition = "
            [ParamID] [int],
            [ParamName] [nvarchar](50),
            [ParamType] [nvarchar](50),
            [ParamDefaultValueSQLStr] [nvarchar](max),
            [ParamDefaultValue] [nvarchar](max)")>]
        static member GetSPParamDefaultValue(spDefinition : string) =
            let results = new ArrayList()
            //let obj = new Object()
            let o = Some (ref (Regex.Matches("", "")))
            let expr =
                "\s*@(?<nm>\w+)\s*" +
                "(?<type>[^\s\(]+\s*\(\s*((\w+\s*\))|(\d+\s*\))|(\d+\s*,\s*\d+\s*\))))\s*=\s*" +
                "(?<defvalueStr>((?<!(?-i)N*')(?<defvalue>\w+)\s*)|((?-i)N*'" +
                "(?<defvalue>(((?<![^']')''(?!'[^']))|([^']))*)" +
                "'))\s*(,|\))"
            regexUtil.regexFun spDefinition expr null 2 null 0 0 o |> ignore
            let mc = !o.Value // :> System.Text.RegularExpressions.MatchCollection
            let mutable idx = 0
            for m in mc do
                let spparam' = new SPParameters()
                spparam'.ParamID <- new SqlInt32(idx)
                spparam'.ParamName <- new SqlString(m.Groups.["nm"].Value)
                spparam'.ParamType <- new SqlString(m.Groups.["type"].Value)
                spparam'.ParamDefaultStr <- new SqlString(m.Groups.["defvalueStr"].Value)
                spparam'.ParamDefaultValue <- new SqlString(m.Groups.["defvalue"].Value)
                idx <- idx + 1
                results.Add(spparam') |> ignore
            results
 
    [<SqlFunction(IsDeterministic = true, IsPrecise = true)>]
        static member regexMatch(target : string, expr : string) =
            let regex = new Regex(expr, RegexOptions.Multiline + RegexOptions.IgnoreCase)
            regex.IsMatch(target)

    [<SqlFunction(IsDeterministic = true, IsPrecise = true)>]
        static member regexVarMatchNm(target : string, expr : string, group : string) =
            (string)(regexUtil.regexFun target expr group 0 null 0 0 None)

    [<SqlFunction(IsDeterministic = true, IsPrecise = true)>]
        static member regexVarMatchId(target : string, expr : string, group : int) =
            (string)(regexUtil.regexFun target expr group 0 null 0 0 None)
 
    [<SqlFunction(IsDeterministic = true, IsPrecise = true)>]
        static member regexReplace(target : string, expr : string, replacement : string) =
            (string)(regexUtil.regexFun target expr null 1 replacement -1 0 None)