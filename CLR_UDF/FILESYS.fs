namespace FSUDF_FILESYS
open System
open System.Data
//open System.Data.SqlClient
open System.Data.SqlTypes
open Microsoft.SqlServer.Server
//open System.Collections
//open System.Collections.Generic
open System.Text.RegularExpressions

module filesysUtil =
//    type regexAct =
//    | Match = 0
//    | Replace = 1
//    | Matches = 2

    let filenameFun = fun path ->
        IO.FileInfo(path).Name

    let filedirectoryFun = fun path ->
        IO.FileInfo(path).DirectoryName

    let directorynameFun = fun path ->
        IO.DirectoryInfo(path).Name

    let directoryfullnameFun = fun path ->
        IO.DirectoryInfo(path).FullName

    let filebasenameFun = fun path ->
        Regex.Replace(IO.FileInfo(path).Name, IO.FileInfo(path).Extension, "")

    let filecontentFun = fun path ->
        match IO.FileInfo(path).Exists with
        | true ->
            IO.File.ReadAllText(path).ToString()
        | _ -> 
            ""
    let fileextensionFun = fun path ->
        Regex.Replace(IO.FileInfo(path).Extension, "^\.", "")
    ;
//type public SPParameters =
//    class
//        [<DefaultValue>] val mutable ParamID : SqlInt32
//        [<DefaultValue>] val mutable ParamName : SqlString
//        [<DefaultValue>] val mutable ParamType : SqlString
//        [<DefaultValue>] val mutable ParamDefaultStr : SqlString
//        [<DefaultValue>] val mutable ParamDefaultValue : SqlString
//        new () ={}
//    end

type public UDF_FILESYS =
  
 
    [<SqlFunction(IsDeterministic = true, IsPrecise = true)>]
        static member GetFileNameFromPath(path : string) =
            filesysUtil.filenameFun path

    [<SqlFunction(IsDeterministic = true, IsPrecise = true)>]
        static member GetFileDirectoryFromPath(path : string) =
            filesysUtil.filedirectoryFun path

    [<SqlFunction(IsDeterministic = true, IsPrecise = true)>]
        static member GetDirectoryNameFromPath(path : string) =
            filesysUtil.directorynameFun path

    [<SqlFunction(IsDeterministic = true, IsPrecise = true)>]
        static member GetDirectoryFullNameFromPath(path : string) =
            filesysUtil.directoryfullnameFun path

    [<SqlFunction(IsDeterministic = true, IsPrecise = true)>]
        static member GetFileContentFromPath(path : string) =
            filesysUtil.filecontentFun path

    [<SqlFunction(IsDeterministic = true, IsPrecise = true)>]
        static member GetFileBaseNameFromPath(path : string) =
            filesysUtil.filebasenameFun path

    [<SqlFunction(IsDeterministic = true, IsPrecise = true)>]
        static member GetFileExtensionFromPath(path : string) =
            filesysUtil.fileextensionFun path
//    [<SqlFunction(IsDeterministic = true, IsPrecise = true)>]
//        static member regexVarMatchNm(target : string, expr : string, group : string) =
//            (string)(regexUtil.regexFun target expr group 0 null 0 0 None)
//
//    [<SqlFunction(IsDeterministic = true, IsPrecise = true)>]
//        static member regexVarMatchId(target : string, expr : string, group : int) =
//            (string)(regexUtil.regexFun target expr group 0 null 0 0 None)
// 
//    [<SqlFunction(IsDeterministic = true, IsPrecise = true)>]
//        static member regexReplace(target : string, expr : string, replacement : string) =
//            (string)(regexUtil.regexFun target expr null 1 replacement -1 0 None)