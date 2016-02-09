using System;
using System.IO;
using System.Data;
using System.Data.SqlTypes;
using Microsoft.SqlServer.Server;
using System.Text.RegularExpressions;

namespace CSUDF_FILESYS {
    public static class filesysUtil {
        public static string filenameFun(string path) {
            return (new FileInfo(path)).Name;
        } 
        public static string filedirectoryFun(string path) {
            return (new FileInfo(path)).DirectoryName;
        }
        public static string directorynameFun(string path) {
            return (new DirectoryInfo(path)).Name;
        }
        public static string directoryfullnameFun(string path) {
            return (new DirectoryInfo(path)).FullName;
        }
        public static string filebasenameFun(string path) {
            return Regex.Replace((new FileInfo(path)).Name, (new FileInfo(path)).Extension, "");
        }
        public static string filecontentFun(string path) {
            if ((new FileInfo(path)).Exists) {
                return File.ReadAllText(path).ToString();
            } else { return ""; }
        }
        public static string fileextensionFun(string path) {
            return Regex.Replace((new FileInfo(path)).Extension, "^\\.", "");
        }
    }

    public class UDF_FILESYS {
        [SqlFunction(IsDeterministic = true, IsPrecise = true)]
        public static string GetFileNameFromPath(string path) {
            return filesysUtil.filenameFun(path);
        }
        [SqlFunction(IsDeterministic = true, IsPrecise = true)]
        public static string GetFileDirectoryFromPath(string path) {
            return filesysUtil.filedirectoryFun(path);
        }
        [SqlFunction(IsDeterministic = true, IsPrecise = true)]
        public static string GetDirectoryNameFromPath(string path) {
            return filesysUtil.directorynameFun(path);
        }
        [SqlFunction(IsDeterministic = true, IsPrecise = true)]
        public static string GetDirectoryFullNameFromPath(string path) {
            return filesysUtil.directoryfullnameFun(path);
        }
        [SqlFunction(IsDeterministic = true, IsPrecise = true)]
        public static string GetFileContentFromPath(string path) {
            return filesysUtil.filecontentFun(path);
        }
        [SqlFunction(IsDeterministic = true, IsPrecise = true)]
        public static string GetFileBaseNameFromPath(string path) {
            return filesysUtil.filebasenameFun(path);
        }
        [SqlFunction(IsDeterministic = true, IsPrecise = true)]
        public static string GetFileExtensionFromPath(string path) {
            return filesysUtil.fileextensionFun(path);
        }
    }
}