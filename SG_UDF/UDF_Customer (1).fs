namespace FSUDF

open System
open System.Data
open System.Data.SqlClient
open System.Data.SqlTypes
open Microsoft.SqlServer.Server
open System.Collections
open System.Collections.Generic

module udtf =
    let f a = a.GetType().Name

type public customer =
    class
        [<DefaultValue>] val mutable ID : Data.SqlTypes.SqlInt64
        [<DefaultValue>] val mutable Name : Data.SqlTypes.SqlString
        [<DefaultValue>] val mutable EnglishName : Data.SqlTypes.SqlString
        [<DefaultValue>] val mutable CompanyOwner : Data.SqlTypes.SqlString
        [<DefaultValue>] val mutable Address : Data.SqlTypes.SqlString
        [<DefaultValue>] val mutable Tel : Data.SqlTypes.SqlString
        [<DefaultValue>] val mutable Fax : Data.SqlTypes.SqlString
        [<DefaultValue>] val mutable Capital : Data.SqlTypes.SqlInt32
        [<DefaultValue>] val mutable Web : Data.SqlTypes.SqlString
        [<DefaultValue>] val mutable Modifier : Data.SqlTypes.SqlInt32
        [<DefaultValue>] val mutable ModifyData : Data.SqlTypes.SqlDateTime

    end

type public UDFSET = 
    class
        
        static member Fill (o : obj) (ID : SqlInt64 byref) 
         (Name : SqlString byref)
         (EnglishName : SqlString byref)
         (CompanyOwner : SqlString byref)
         (Address : SqlString byref)
         (Tel : SqlString byref)
         (Fax : SqlString byref)
         (Capital : SqlInt32 byref)
         (Web : SqlString byref)
         (Modifier : SqlInt32 byref)
         (ModifyData : Data.SqlTypes.SqlDateTime byref) =
            let o' = o :?> customer
            ID <- o'.ID
            Name <- o'.Name
        //[<Serializable>]
        //[<Microsoft.SqlServer.Server.SqlFunction(DataAccess = DataAccessKind.Read, FillRowMethodName = "Test_FillRow", TableDefinition = "CustId int, Name nvarchar(50)")>]
        //static member queryOldCustomer = 
            

    end
