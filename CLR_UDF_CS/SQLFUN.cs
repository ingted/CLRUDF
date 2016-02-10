using System;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
//using System.Transactions;
using Microsoft.SqlServer.Server;
using System.Collections;
using System.Collections.Generic;
namespace CSUDF_SQLFUN {
    public static class funUtil {
        public static DataSet ex(string connStr, string cmdStr, string db, string server) {
            string c;
            SqlConnection connection;
            SqlCommand sqlcmd;
            if (connStr == "" || connStr is String) {
                string catalog = db.ToString() == "" ? "master" : db;
                string serverhost = server.ToString() == "" ? "." : server;
                //c = "Data Source=" + serverhost + ";Initial Catalog=" + catalog + ";Persist Security Info=True;Integrated Security=SSPI;Enlist=false;MultipleActiveResultSets=false;";
                c = connStr == "" ? "Data Source=localhost\\SQL16;Initial Catalog=master;Persist Security Info=True;Integrated Security=SSPI;Enlist=false;MultipleActiveResultSets=false;" : connStr;
                connection = new SqlConnection(c);
                connection.Open();
                sqlcmd = new SqlCommand(cmdStr, connection);
                var da = new SqlDataAdapter(sqlcmd);
                var ds = new DataSet();
                var fill = da.Fill(ds);
                da.Dispose();
                sqlcmd.Dispose();
                connection.Close();
                connection.Dispose();
                return ds;
            } else {
                c = "context connection=true";
                connection = new SqlConnection(c);
                connection.Open();
                sqlcmd = new SqlCommand(cmdStr, connection);
                var rdr = sqlcmd.ExecuteReader();
                SqlContext.Pipe.Send(rdr);
                rdr.Close();
                connection.Close();
                SqlContext.Pipe.Send(rdr);
                rdr.Close();
                connection.Close();
                var ds = new DataSet();
                return ds;
            }
            

            
            
        }
    }
    public class UDF_SQLFUN {
        [SqlFunction(IsDeterministic = false, IsPrecise = true, DataAccess = DataAccessKind.Read)]
        public static SqlString SQLFUN(string conn, string cmd, int r, int c, string db, string server) {
            var ds = funUtil.ex(conn, cmd, db, server);
            var results = new ArrayList();
            var i = ds.Tables[0].Rows[r][c];
            if (i is System.DBNull) {
                return System.Data.SqlTypes.SqlString.Null;
            } else {
                return new System.Data.SqlTypes.SqlString(i.ToString());
            }
        }

        [SqlFunction(IsDeterministic = false, IsPrecise = true)]
        public static System.Nullable<int> INTFUN(string conn, string cmd, int r, int c, string db, string server) {
            var results = new ArrayList();
            var ds = funUtil.ex(conn, cmd, db, server);
            var i = ds.Tables[0].Rows[r][c];
            if (i is System.DBNull) { 
                return new System.Nullable<int>();
            } else {
                return (System.Nullable<int>)i;
            }
        }

        [SqlFunction(IsDeterministic = false, IsPrecise = true)]
        public static SqlDouble FLOATFUN(string conn, string cmd, int r, int c, string db, string server) {
            var results = new ArrayList();
            var ds = funUtil.ex(conn, cmd, db, server);
            var i = ds.Tables[0].Rows[r][c];
            if (i is System.DBNull) {
                return System.Data.SqlTypes.SqlDouble.Null;
            } else {
                return new System.Data.SqlTypes.SqlDouble((float)i);
            }
        }
        [SqlFunction(IsDeterministic = false, IsPrecise = true)]
        public static SqlSingle REALFUN(string conn, string cmd, int r, int c, string db, string server) {
            var results = new ArrayList();
            var ds = funUtil.ex(conn, cmd, db, server);
            var i = ds.Tables[0].Rows[r][c];
            if (i is System.DBNull) {
                return System.Data.SqlTypes.SqlSingle.Null;
            } else {
                return new System.Data.SqlTypes.SqlSingle((Single)i);
            }
        }

        [SqlFunction(IsDeterministic = false, IsPrecise = true)]
        public static SqlDateTime DTFUN(string conn, string cmd, int r, int c, string db, string server) {
            var results = new ArrayList();
            var ds = funUtil.ex(conn, cmd, db, server);
            var i = ds.Tables[0].Rows[r][c];
            if (i is System.DBNull) {
                return System.Data.SqlTypes.SqlDateTime.Null;
            } else {
                return new System.Data.SqlTypes.SqlDateTime((DateTime)i);
            }
        }

        [SqlFunction(IsDeterministic = false, IsPrecise = true)]
        public static SqlBoolean BITFUN(string conn, string cmd, int r, int c, string db, string server) {
            var results = new ArrayList();
            var ds = funUtil.ex(conn, cmd, db, server);
            var i = ds.Tables[0].Rows[r][c];
            if (i is System.DBNull) {
                return System.Data.SqlTypes.SqlBoolean.Null;
            } else {
                return new System.Data.SqlTypes.SqlBoolean((bool)i);
            }
        }

    }
}