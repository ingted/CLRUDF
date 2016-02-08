namespace CSUDF_SQLFUN

open System
open System.Data
open System.Data.SqlClient
open System.Data.SqlTypes
open System.Transactions
open Microsoft.SqlServer.Server
open System.Collections
open System.Collections.Generic

module funUtil =   
    let ex = fun connStr cmdStr ->
        let c = 
            match connStr with
            | "" -> 
                "Data Source=.;Initial Catalog=DARKNET;Persist Security Info=True;Integrated Security=SSPI;Enlist=false;MultipleActiveResultSets=false;"
            | _ when connStr.GetType() = typeof<string> -> 
                connStr
            | _ -> 
                "context connection=true"
        let connection = new SqlConnection(c)
        connection.Open()
        let sqlcmd = new SqlCommand(cmdStr, connection)
        //let reader = sqlcmd.ExecuteReader()
        //(connection, sqlcmd, reader)

        let da = new SqlDataAdapter(sqlcmd)
        let ds = new DataSet()
        let fill = da.Fill(ds)
        da.Dispose()
        sqlcmd.Dispose()
        connection.Close()
        connection.Dispose()
        ds
        ;


type public UDF_SQLFUN = 
    [<SqlFunction(IsDeterministic = false, IsPrecise = true)>]
        static member SQLFUN(conn : string, cmd : string, r : int, c : int) =
            let results = new ArrayList()
            let ds = funUtil.ex conn cmd
            let i = ds.Tables.[0].Rows.[r].Item(c) 
            match i with
            | :? System.DBNull ->
                System.Data.SqlTypes.SqlString.Null
            | _ ->
                //i :?> System.Data.SqlTypes.SqlString
                new System.Data.SqlTypes.SqlString(i.ToString())


    [<SqlFunction(IsDeterministic = false, IsPrecise = true)>]
        static member INTFUN(conn : string, cmd : string, r : int, c : int) =
            let results = new ArrayList()
            let ds = funUtil.ex conn cmd
            let i = ds.Tables.[0].Rows.[r].Item(c) 
            match i with 
            //| _ when (i :?> System.DBNull) = System.DBNull.Value ->
            | :? System.DBNull ->
                new System.Nullable<int>()
            | _ ->
                i :?> System.Nullable<int>


    [<SqlFunction(IsDeterministic = false, IsPrecise = true)>]
        static member FLOATFUN(conn : string, cmd : string, r : int, c : int) =
            let results = new ArrayList()
            let ds = funUtil.ex conn cmd
            let i = ds.Tables.[0].Rows.[r].Item(c)
            match i with
            | :? System.DBNull ->
                System.Data.SqlTypes.SqlDouble.Null
            | _ ->
                new System.Data.SqlTypes.SqlDouble(i :?> float)

    [<SqlFunction(IsDeterministic = false, IsPrecise = true)>]
        static member REALFUN(conn : string, cmd : string, r : int, c : int) =
            let results = new ArrayList()
            let ds = funUtil.ex conn cmd
            let i = ds.Tables.[0].Rows.[r].Item(c)
            match i with
            | :? System.DBNull ->
                System.Data.SqlTypes.SqlSingle.Null
            | _ ->
                new System.Data.SqlTypes.SqlSingle(i :?> single)

    [<SqlFunction(IsDeterministic = false, IsPrecise = true)>]
        static member DTFUN(conn : string, cmd : string, r : int, c : int) =
            let results = new ArrayList()
            let ds = funUtil.ex conn cmd
            let i = ds.Tables.[0].Rows.[r].Item(c)
            match i with
            | :? System.DBNull ->
                System.Data.SqlTypes.SqlDateTime.Null
            | _ ->
                new System.Data.SqlTypes.SqlDateTime(i :?> DateTime)
            
    [<SqlFunction(IsDeterministic = false, IsPrecise = true)>]
        static member BITFUN(conn : string, cmd : string, r : int, c : int) =
            let results = new ArrayList()
            let ds = funUtil.ex conn cmd
            let i = ds.Tables.[0].Rows.[r].Item(c)
            match i with
            | :? System.DBNull ->
                System.Data.SqlTypes.SqlBoolean.Null
            | _ ->
                new System.Data.SqlTypes.SqlBoolean(i :?> bool)

