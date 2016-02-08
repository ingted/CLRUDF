using System;
using System.Data;
using System.Data.SqlTypes;
using Microsoft.SqlServer.Server;
using System.Text.RegularExpressions;

namespace CSUDF_FILESYS {
    public class filesysUtil {


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
    }

    public class UDF_FILESYS {



        [<SqlFunction(IsDeterministic = true, IsPrecise = true)>]
        static member GetFileNameFromPath(path : string) =
                filesysUtil.filenameFun path

        [< SqlFunction(IsDeterministic = true, IsPrecise = true) >]
            static member GetFileDirectoryFromPath(path : string) =
                filesysUtil.filedirectoryFun path

        [< SqlFunction(IsDeterministic = true, IsPrecise = true) >]
            static member GetDirectoryNameFromPath(path : string) =
                filesysUtil.directorynameFun path

        [< SqlFunction(IsDeterministic = true, IsPrecise = true) >]
            static member GetDirectoryFullNameFromPath(path : string) =
                filesysUtil.directoryfullnameFun path

        [< SqlFunction(IsDeterministic = true, IsPrecise = true) >]
            static member GetFileContentFromPath(path : string) =
                filesysUtil.filecontentFun path

        [< SqlFunction(IsDeterministic = true, IsPrecise = true) >]
            static member GetFileBaseNameFromPath(path : string) =
                filesysUtil.filebasenameFun path

        [< SqlFunction(IsDeterministic = true, IsPrecise = true) >]
            static member GetFileExtensionFromPath(path : string) =
                filesysUtil.fileextensionFun path
    }
}