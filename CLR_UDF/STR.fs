namespace FSUDF_STR
open System
open System.Data
//open System.Data.SqlClient
open System.Data.SqlTypes
open Microsoft.SqlServer.Server
//open System.Collections
//open System.Collections.Generic
open System.Text.RegularExpressions

module strUtil =

    let padFun = fun (str : String) (true_for_left : bool) len symbol->
        match true_for_left with 
        | true ->
            str.PadLeft(len, symbol)
        | false ->
            str.PadRight(len, symbol)

type public UDF_STR = 
    [<SqlFunction(IsDeterministic = true, IsPrecise = true)>]
        static member PadLeft(str : string, len : int, symbol : char) =
            strUtil.padFun str true len symbol

    [<SqlFunction(IsDeterministic = true, IsPrecise = true)>]
        static member PadRight(str : string, len : int, symbol : char) =
            strUtil.padFun str false len symbol

    [<SqlFunction(IsDeterministic = true, IsPrecise = true)>]
        static member Replicate(str : string, times : int) =
            String.replicate times str