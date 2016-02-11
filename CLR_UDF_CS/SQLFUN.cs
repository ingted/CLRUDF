using System;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using System.Reflection;
//using System.Transactions;
using Microsoft.SqlServer.Server;
using System.Collections;
using System.Collections.Generic;
using System.Text.RegularExpressions;
namespace CSUDF_SQLFUN {
    public static class funUtil {
        public static void exI(ref SqlConnection connection, string cmdStr, ref SqlDataReader sdr, bool ifSend, bool ifCloseConn)
        {
            connection = new SqlConnection("context connection=true;");
            //if (connection.State != ConnectionState.Open) { 
                connection.Open();
            //}
            var sqlcmd = new SqlCommand(cmdStr, connection);
            
            sdr = sqlcmd.ExecuteReader();
            if (ifSend) {
                SqlContext.Pipe.Send(sdr);
            }
            sqlcmd.Dispose();
            if (ifCloseConn)
            {
                connection.Close();
                connection.Dispose();
            }
        }

        public static void exI(ref SqlConnection connection, string cmdStr, ref SqlDataReader sdr, bool ifSend)
        {
            exI(ref connection, cmdStr, ref sdr, ifSend, false);
        }

        public static void exI(ref SqlConnection connection, string cmdStr, ref SqlDataReader sdr)
        {
            exI(ref connection, cmdStr, ref sdr, true, true);
        }
        public static void ex(string connStr, string cmdStr, string db, string server, ref DataSet ds, int r, int cc, ref object dtout)
        {
            string catalog = db.ToString() == "" ? "master" : db;
            string c;
            SqlConnection connection = null;
            //SqlCommand sqlcmd = null;
            if (connStr != null && Regex.IsMatch(connStr, "context\\s+connection=true"))
            {
                //c = "context connection=true"; // + ";Initial Catalog=" + catalog + ";";
                //connection = new SqlConnection(c);
                //connection.Open();
                //sqlcmd = new SqlCommand(cmdStr, connection);
                SqlDataReader rdr = null;
                exI(ref connection, cmdStr, ref rdr, false);
                
                //SqlContext.Pipe.Send(rdr);

                //throw new Exception(rdr.Read().ToString());

                for (int ridx = 0; ridx <= r; ridx++) { rdr.Read(); };
                dtout = rdr.GetSqlValue(cc);
                rdr.Close();
                

            }
            else {
                string serverhost = server.ToString() == "" ? "localhost" : server;
                c = connStr == "" || connStr == null ? "Data Source=" + serverhost + "; Initial Catalog=" + catalog + "; Persist Security Info=True;Integrated Security=SSPI;Enlist=false;MultipleActiveResultSets=false;" : connStr;
                connection = new SqlConnection(c);
                connection.Open();
                var sqlcmd = new SqlCommand(cmdStr, connection);
                var da = new SqlDataAdapter(sqlcmd);
                ds = new DataSet();
                var fill = da.Fill(ds);
                da.Dispose();
                sqlcmd.Dispose();
            }
            
            connection.Close();
            connection.Dispose();
        }
        public static T convertByType<T>(object o)
        {
            return (T)o;
        }
        public static object exT(string connStr, string cmdStr, string db, string server, Type T, ref DataSet ds, int r, int cc, ref object dtout)
        {
            ex(connStr, cmdStr, db, server, ref ds, r, cc, ref dtout);

            if (connStr == "" || connStr == null)
            {
                var results = new ArrayList();
                var i = ds.Tables[0].Rows[r][cc];
                if (i == null || i is System.DBNull)
                {
                    //var nullprop = T.GetProperty("Null");
                    //return nullprop.GetValue(null, null);
                    
                    var nullf = T.GetField("Null");
                    return Convert.ChangeType(nullf.GetValue(null), T);
                }
                //if (i.GetType() == typeof(SqlInt32))
                //{
                //    if (dtout.Equals(SqlInt32.Null))
                //    {
                //        var nullf = T.GetField("Null");
                //        return Convert.ChangeType(nullf.GetValue(null), T);
                //    }
                //}
                //else {
                //throw new Exception(i.ToString());
                //return Convert.ChangeType(i, T);
                return Activator.CreateInstance(T, i);
                //}
            }
            else
            {
                //throw new Exception("123");
                if (dtout.GetType() == typeof(SqlInt32))
                {
                    //throw new Exception(dtout.GetType().Name);
                    if (dtout.Equals(SqlInt32.Null)) {
                        var nullf = T.GetField("Null");
                        //throw new Exception(nullf.ToString());
                        if (nullf == null) {
                            return null;
                        }
                        else {
                            var rtn = Convert.ChangeType(nullf.GetValue(null), T);
                            return rtn;
                        }
                        
                    }
                }

                //var nullprop = T.GetProperty("IsNull");
                ////throw new Exception(dtout.GetType().Name.ToString());
                //var nullval = nullprop.GetValue(dtout);

                //if ((bool)nullval)
                //{
                //    //throw new Exception("123");

                //    return null;
                //}
                //else {
                //if (T.IsGenericType && T.GetGenericTypeDefinition() == typeof(Nullable<>))
                //{
                //    //Type[] typeArgs = { Nullable.GetUnderlyingType(T) };
                //    Type typeArg = Nullable.GetUnderlyingType(T);
                //    throw new Exception(Nullable.GetUnderlyingType(T).Name + " " + dtout.GetType().Name);
                //    //var genTyp = typeof(Nullable<>).MakeGenericType(typeArgs);

                //    var method = typeof(funUtil).GetMethod("convertByType", BindingFlags.Public | BindingFlags.Static);
                //    var genMethod = method.MakeGenericMethod(new[] { typeArg });



                //    object o = Activator.CreateInstance(
                //        //T, Activator.CreateInstance(typeArg, dtout));
                //        //T, Convert.ChangeType(dtout, typeArg));
                //        T, genMethod.Invoke(null, new[] { dtout }));
                //    return o;
                //}
                //else {
                //throw new Exception(dtout.ToString() + " " + T.Name + " " + dtout.GetType().Name);
                return Convert.ChangeType(dtout, T);
                //}
                
            }




        }

        public static void ex(string connStr, string cmdStr, string db, string server) {
            var ds = new DataSet();
            object o = null;
            ex(connStr, cmdStr, db, server, ref ds, -1, -1, ref o);
        }
        public static void ex(string connStr, string cmdStr, string db, string server, ref DataSet ds)
        {
            object o = null;
            ex(connStr, cmdStr, db, server, ref ds, -1, -1, ref o);
        }

    }
    public class UDF_SQLFUN {
        
        [SqlFunction(IsDeterministic = false, IsPrecise = true, DataAccess = DataAccessKind.Read)]
        public static SqlString SQLFUN(string conn, string cmd, int r, int c, string db, string server)
        {
            return FUN<SqlString>(conn, cmd, r, c, db, server);

        }


        [SqlFunction(IsDeterministic = false, IsPrecise = true, DataAccess = DataAccessKind.Read)]
        public static SqlInt32 INTFUN(string conn, string cmd, int r, int c, string db, string server)
        {
            return FUN<SqlInt32>(conn, cmd, r, c, db, server);

        }

        public static T FUN<T>(string conn, string cmd, int r, int c, string db, string server)
        {
            var ds = new DataSet();
            object o = null;
            var oc = funUtil.exT(conn, cmd, db, server, typeof(T), ref ds, r, c, ref o);
            return (T)oc;
        }

        [SqlFunction(IsDeterministic = false, IsPrecise = true, DataAccess = DataAccessKind.Read)]
        public static SqlDouble FLOATFUN(string conn, string cmd, int r, int c, string db, string server) {
            return FUN<SqlDouble>(conn, cmd, r, c, db, server);
        }
        [SqlFunction(IsDeterministic = false, IsPrecise = true, DataAccess = DataAccessKind.Read)]
        public static SqlSingle REALFUN(string conn, string cmd, int r, int c, string db, string server) {
            return FUN<SqlSingle>(conn, cmd, r, c, db, server);
        }

        [SqlFunction(IsDeterministic = false, IsPrecise = true, DataAccess = DataAccessKind.Read)]
        public static SqlDateTime DTFUN(string conn, string cmd, int r, int c, string db, string server) {
            return FUN<SqlDateTime>(conn, cmd, r, c, db, server);
        }

        [SqlFunction(IsDeterministic = false, IsPrecise = true, DataAccess = DataAccessKind.Read)]
        public static SqlBoolean BITFUN(string conn, string cmd, int r, int c, string db, string server) {
            return FUN<SqlBoolean>(conn, cmd, r, c, db, server);
        }

    }
}