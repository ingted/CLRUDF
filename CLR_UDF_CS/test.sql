/*
CREATE ASSEMBLY [System]
AUTHORIZATION [dbo]
from 'C:\System.dll'
with permission_set = safe
GO

CREATE ASSEMBLY [System.Core]
AUTHORIZATION [dbo]
from 'C:\System.Core.dll'
with permission_set = safe
GO

CREATE ASSEMBLY [System.Data]
AUTHORIZATION [dbo]
from 'C:\System.Data.dll'
with permission_set = safe
GO

CREATE ASSEMBLY [System.Xml]
AUTHORIZATION [dbo]
from 'C:\System.Xml.dll'
with permission_set = safe
GO





CREATE ASSEMBLY [CLR_UDF_CS]
AUTHORIZATION [dbo]
from 'E:\CLR_String\CLR_UDF_CS\bin\Debug\CLR_UDF_CS.dll'
with permission_set = safe
GO
*/
use test_clr2
go


BEGIN TRY 
drop FUNCTION dbo.regexMatch
END TRY 
BEGIN CATCH
AAA:
END CATCH
go
BEGIN TRY 
drop FUNCTION dbo.regexVarMatchId
END TRY 
BEGIN CATCH
AAA:
END CATCH
go
BEGIN TRY 
drop FUNCTION dbo.regexVarMatchNm
END TRY 
BEGIN CATCH
AAA:
END CATCH
go

BEGIN TRY 
drop FUNCTION dbo.regexVarMatchId2
END TRY 
BEGIN CATCH
AAA:
END CATCH
go
BEGIN TRY 
drop FUNCTION dbo.regexVarMatchNm2
END TRY 
BEGIN CATCH
AAA:
END CATCH
go

BEGIN TRY 
drop FUNCTION dbo.regexReplace
END TRY 
BEGIN CATCH
AAA:
END CATCH
go
BEGIN TRY 
drop Function GetSPParamDef
END TRY 
BEGIN CATCH
AAA:
END CATCH
go
BEGIN TRY 
drop Function GetFileName
END TRY 
BEGIN CATCH
AAA:
END CATCH
go
BEGIN TRY 
drop Function GetFileExtension
END TRY 
BEGIN CATCH
AAA:
END CATCH
go
BEGIN TRY 
drop Function GetFileBaseName
END TRY 
BEGIN CATCH
AAA:
END CATCH
go
BEGIN TRY 
drop Function GetFileContent
END TRY 
BEGIN CATCH
AAA:
END CATCH
go
BEGIN TRY 
drop Function GetFileContent
END TRY 
BEGIN CATCH
AAA:
END CATCH
go

BEGIN TRY 
drop Function GetDirectoryFullName
END TRY 
BEGIN CATCH
AAA:
END CATCH
go


BEGIN TRY 
drop Function PadLeft
END TRY 
BEGIN CATCH
AAA:
END CATCH
go

BEGIN TRY 
drop Function PadRight
END TRY 
BEGIN CATCH
AAA:
END CATCH
go
BEGIN TRY 
drop Function GetDirectoryName
END TRY 
BEGIN CATCH
AAA:
END CATCH
go

BEGIN TRY 
drop Function GetFileDirectory
END TRY 
BEGIN CATCH
AAA:
END CATCH
go

BEGIN TRY 
drop Function SQLFUN
END TRY 
BEGIN CATCH
AAA:
END CATCH
go

BEGIN TRY 
drop Function INTFUN
END TRY 
BEGIN CATCH
AAA:
END CATCH
go

BEGIN TRY 
drop Function DTFUN
END TRY 
BEGIN CATCH
AAA:
END CATCH
go

BEGIN TRY 
drop Function REALFUN
END TRY 
BEGIN CATCH
AAA:
END CATCH
go

BEGIN TRY 
drop Function FLOATFUN
END TRY 
BEGIN CATCH
AAA:
END CATCH
go

BEGIN TRY 
drop Function [Replicate]
END TRY 
BEGIN CATCH
AAA:
END CATCH
go


BEGIN TRY 
drop Function Split2String
END TRY 
BEGIN CATCH
AAA:
END CATCH
go

BEGIN TRY 
drop Function Split2StringDist
END TRY 
BEGIN CATCH
AAA:
END CATCH
go


BEGIN TRY 
drop Function Split2Int
END TRY 
BEGIN CATCH
AAA:
END CATCH
go

BEGIN TRY 
drop Function Split2IntDist
END TRY 
BEGIN CATCH
AAA:
END CATCH
go

BEGIN TRY 
drop ASSEMBLY [CLR_UDF_CS]
END TRY 
BEGIN CATCH
AAA:
END CATCH
go

begin try
CREATE ASSEMBLY [CLR_UDF_CS]
AUTHORIZATION [dbo]
from 'E:\CLR_String\CLR_UDF_CS\bin\Debug\CLR_UDF_CS.dll'
with permission_set = safe
end try
begin catch 
aaa:
return
end catch
GO

begin try
CREATE ASSEMBLY [System.Web]
AUTHORIZATION [dbo]
from 'C:\System.Web.dll'
with permission_set = safe
end try
begin catch 
aaa:
return
end catch
GO

begin try
CREATE ASSEMBLY [System.Web.Extensions]
AUTHORIZATION [dbo]
from 'C:\System.Web.Extensions.dll'
with permission_set = safe
end try
begin catch 
aaa:
return
end catch
GO



CREATE FUNCTION dbo.regexMatch(@target nvarchar(max), @expr nvarchar(max))
RETURNS bit
AS EXTERNAL NAME  [CLR_UDF_CS].[CSUDF_REGEX.UDF_REGEX].regexMatch
go

CREATE FUNCTION dbo.regexVarMatchId(@target nvarchar(max), @expr nvarchar(max), @group int)
RETURNS nvarchar(max)
AS EXTERNAL NAME  [CLR_UDF_CS].[CSUDF_REGEX.UDF_REGEX].regexVarMatchId
go

CREATE FUNCTION dbo.regexVarMatchNm(@target nvarchar(max), @expr nvarchar(max), @group nvarchar(max))
RETURNS nvarchar(max)
AS EXTERNAL NAME  [CLR_UDF_CS].[CSUDF_REGEX.UDF_REGEX].regexVarMatchNm
go

CREATE FUNCTION dbo.regexVarMatchId2(@target nvarchar(max), @expr nvarchar(max), @group int, @capture int)
RETURNS nvarchar(max)
AS EXTERNAL NAME  [CLR_UDF_CS].[CSUDF_REGEX.UDF_REGEX].regexVarMatchId2
go

CREATE FUNCTION dbo.regexVarMatchNm2(@target nvarchar(max), @expr nvarchar(max), @group nvarchar(max), @capture int)
RETURNS nvarchar(max)
AS EXTERNAL NAME  [CLR_UDF_CS].[CSUDF_REGEX.UDF_REGEX].regexVarMatchNm2
go

CREATE FUNCTION dbo.regexReplace(@target nvarchar(max), @expr nvarchar(max), @repl nvarchar(max))
RETURNS nvarchar(max)
AS EXTERNAL NAME  [CLR_UDF_CS].[CSUDF_REGEX.UDF_REGEX].regexReplace
go

CREATE FUNCTION dbo.GetFileName(@path nvarchar(max))
RETURNS nvarchar(max)
AS EXTERNAL NAME  [CLR_UDF_CS].[CSUDF_FILESYS.UDF_FILESYS].GetFileNameFromPath
go

CREATE FUNCTION dbo.GetFileBaseName(@path nvarchar(max))
RETURNS nvarchar(max)
AS EXTERNAL NAME  [CLR_UDF_CS].[CSUDF_FILESYS.UDF_FILESYS].GetFileBaseNameFromPath
go

CREATE FUNCTION dbo.GetFileDirectory(@path nvarchar(max))
RETURNS nvarchar(max)
AS EXTERNAL NAME  [CLR_UDF_CS].[CSUDF_FILESYS.UDF_FILESYS].GetFileDirectoryFromPath
go

CREATE FUNCTION dbo.GetDirectoryName(@path nvarchar(max))
RETURNS nvarchar(max)
AS EXTERNAL NAME  [CLR_UDF_CS].[CSUDF_FILESYS.UDF_FILESYS].GetDirectoryNameFromPath
go

CREATE FUNCTION dbo.GetFileExtension(@path nvarchar(max))
RETURNS nvarchar(max)
AS EXTERNAL NAME  [CLR_UDF_CS].[CSUDF_FILESYS.UDF_FILESYS].GetFileExtensionFromPath
go

CREATE FUNCTION dbo.GetFileContent(@path nvarchar(max))
RETURNS nvarchar(max)
AS EXTERNAL NAME  [CLR_UDF_CS].[CSUDF_FILESYS.UDF_FILESYS].GetFileContentFromPath
go

CREATE FUNCTION dbo.GetDirectoryFullName(@path nvarchar(max))
RETURNS nvarchar(max)
AS EXTERNAL NAME  [CLR_UDF_CS].[CSUDF_FILESYS.UDF_FILESYS].GetDirectoryFullNameFromPath
go


CREATE FUNCTION dbo.PadLeft(@str nvarchar(max), @len int, @char nchar(1))
RETURNS nvarchar(max)
AS EXTERNAL NAME  [CLR_UDF_CS].[CSUDF_STR.UDF_STR].PadLeft
go

CREATE FUNCTION dbo.PadRight(@str nvarchar(max), @len int, @char nchar(1))
RETURNS nvarchar(max)
AS EXTERNAL NAME  [CLR_UDF_CS].[CSUDF_STR.UDF_STR].PadRight
go

CREATE FUNCTION dbo.SQLFUN(@conn nvarchar(max), @cmd nvarchar(max), @r int, @c int, @db nvarchar(max), @server nvarchar(max))
RETURNS nvarchar(max)
AS EXTERNAL NAME  [CLR_UDF_CS].[CSUDF_SQLFUN.UDF_SQLFUN].SQLFUN
go

CREATE FUNCTION dbo.INTFUN(@conn nvarchar(max), @cmd nvarchar(max), @r int, @c int, @db nvarchar(max), @server nvarchar(max))
RETURNS INT
AS EXTERNAL NAME  [CLR_UDF_CS].[CSUDF_SQLFUN.UDF_SQLFUN].INTFUN
go

CREATE FUNCTION dbo.DTFUN(@conn nvarchar(max), @cmd nvarchar(max), @r int, @c int, @db nvarchar(max), @server nvarchar(max))
RETURNS DATETIME
AS EXTERNAL NAME  [CLR_UDF_CS].[CSUDF_SQLFUN.UDF_SQLFUN].DTFUN
go

CREATE FUNCTION dbo.REALFUN(@conn nvarchar(max), @cmd nvarchar(max), @r int, @c int, @db nvarchar(max), @server nvarchar(max))
RETURNS REAL
AS EXTERNAL NAME  [CLR_UDF_CS].[CSUDF_SQLFUN.UDF_SQLFUN].REALFUN
go

CREATE FUNCTION dbo.[Replicate](@str nvarchar(max), @times int)
RETURNS nvarchar(max)
AS EXTERNAL NAME  [CLR_UDF_CS].[CSUDF_STR.UDF_STR].[Replicate]
go	


CREATE FUNCTION dbo.Split2String(@target nvarchar(max), @splitter nvarchar(max))
RETURNS table (
	id int,
	value nvarchar(max)
)
AS EXTERNAL NAME  [CLR_UDF_CS].[CSUDF_STR.UDF_STR].Split2String
go	


CREATE FUNCTION dbo.Split2Int(@target nvarchar(max), @splitter nvarchar(max))
RETURNS table (
	id int,
	value int
)
AS EXTERNAL NAME  [CLR_UDF_CS].[CSUDF_STR.UDF_STR].Split2Int
go	

CREATE FUNCTION dbo.Split2StringDist(@target nvarchar(max), @splitter nvarchar(max))
RETURNS table (
	id int,
	value nvarchar(max)
)
AS EXTERNAL NAME  [CLR_UDF_CS].[CSUDF_STR.UDF_STR].Split2StringDist
go	


CREATE FUNCTION dbo.Split2IntDist(@target nvarchar(max), @splitter nvarchar(max))
RETURNS table (
	id int,
	value int
)
AS EXTERNAL NAME  [CLR_UDF_CS].[CSUDF_STR.UDF_STR].Split2IntDist
go	

CREATE FUNCTION dbo.FLOATFUN(@conn nvarchar(max), @cmd nvarchar(max), @r int, @c int, @db nvarchar(max), @server nvarchar(max))
RETURNS FLOAT
AS EXTERNAL NAME  [CLR_UDF_CS].[CSUDF_SQLFUN.UDF_SQLFUN].FLOATFUN
go

CREATE FUNCTION dbo.GetSPParamDef (@STR NVARCHAR(MAX))
RETURNS TABLE 
(
				[ParamID] [int],
	            [ParamName] [nvarchar](50) ,
	            [ParamType] [nvarchar](50) ,
				[ParamDefaultStr] [nvarchar](max),
	            [ParamDefaultValue] [nvarchar](max)
)
EXTERNAL NAME  [CLR_UDF_CS].[CSUDF_REGEX.UDF_REGEX].GetSPParamDefaultValue
GO
IF (select dbo.regexMatch(N'orz', N'd')) = 0 BEGIN PRINT 'regexMatch: pos OK!' END
IF (select dbo.regexMatch(N'ddt', N'd')) = 1 BEGIN PRINT 'regexMatch: neg OK!' END

declare  @test int = 1
if (select dbo.regexVarMatchId2(N'odddoddoojiejwi', N'((?<l>d+)|(?<t>o+))+', 0, 0)) = 'odddoddoo'	BEGIN PRINT 'TEST001 - regexVarMatchId2: 0, 0 OK!' END
if (select dbo.regexVarMatchId2(N'odddoddoojiejwi', N'((?<l>d+)|(?<t>o+))+', 0, 1)) = 'err:-2'		BEGIN PRINT 'TEST002 - regexVarMatchId2: 0, 1 OK!' END
if (select dbo.regexVarMatchId2(N'odddoddoojiejwi', N'((?<l>d+)|(?<t>o+))+', 1, 0)) = 'o'			BEGIN PRINT 'TEST003 - regexVarMatchId2: 1, 0 OK!' END
if (select dbo.regexVarMatchId2(N'odddoddoojiejwi', N'((?<l>d+)|(?<t>o+))+', 1, 1)) = 'ddd'			BEGIN PRINT 'TEST004 - regexVarMatchId2: 1, 1 OK!' END
if (select dbo.regexVarMatchId2(N'odddoddoojiejwi', N'((?<l>d+)|(?<t>o+))+', 1, 2)) = 'o'			BEGIN PRINT 'TEST005 - regexVarMatchId2: 1, 2 OK!' END
if (select dbo.regexVarMatchId2(N'odddoddoojiejwi', N'((?<l>d+)|(?<t>o+))+', 1, 3)) = 'dd'			BEGIN PRINT 'TEST006 - regexVarMatchId2: 1, 3 OK!' END

if (select dbo.regexVarMatchNm2(N'odddoddoojiejwi', N'((?<l>d+)|(?<t>o+))+', 'l', 0)) = 'ddd'		BEGIN PRINT 'TEST007 - regexVarMatchNm2: l, 0 OK!' END
if (select dbo.regexVarMatchNm2(N'odddoddoojiejwi', N'((?<l>d+)|(?<t>o+))+', 'l', 1)) = 'dd'		BEGIN PRINT 'TEST008 - regexVarMatchNm2: l, 1 OK!' END
if (select dbo.regexVarMatchNm2(N'odddoddoojiejwi', N'((?<l>d+)|(?<t>o+))+', 't', 0)) = 'o'			BEGIN PRINT 'TEST009 - regexVarMatchNm2: t, 0 OK!' END
if (select dbo.regexVarMatchNm2(N'odddoddoojiejwi', N'((?<l>d+)|(?<t>o+))+', 't', 1)) = 'o'			BEGIN PRINT 'TEST010 - regexVarMatchNm2: t, 1 OK!' END
if (select dbo.regexVarMatchNm2(N'odddoddoojiejwi', N'((?<l>d+)|(?<t>o+))+', 't', 2)) = 'oo'		BEGIN PRINT 'TEST011 - regexVarMatchNm2: t, 2 OK!' END
if (select dbo.regexVarMatchNm2(N'odddoddoojiejwi', N'((?<l>d+)|(?<t>o+))+', 't', 3)) = 'err:-2'	BEGIN PRINT 'TEST012 - regexVarMatchNm2: t, 3 OK!' END




if (select dbo.regexVarMatchId(N'odddoddoojiejwi', N'(?<l>d+)', '0')) = 'ddd'						BEGIN PRINT 'TEST013 - regexVarMatchId: ''0'' OK!' END 
declare @err int = 0
begin try print dbo.regexVarMatchId(N'odddoddoojiejwi', N'(?<l>d+)', 'l'); select @err = 1; end try 
begin catch print 'TEST014 - regexVarMatchId:verbal id exception, OK!' end catch
if @err = 1 begin THROW 51000, 'wrong verbal id passed, Not OK! ', 1; end

if (select dbo.regexReplace(N'oddodooj iejwi', N'(?<l>\w+ )', 'lslslsl ')) = 'lslslsl iejwi'		BEGIN PRINT 'TEST015 - regexReplace: OK!' END
/*select dbo.GetFileName('C:\CLR_UDF.XML')
select dbo.GetFileBaseName('C:\CLR_UDF.XML')
select dbo.GetFileExtension('C:\CLR_UDF.XML')
select dbo.GetFileContent('C:\CLR_UDF.XML')
select dbo.GetDirectoryName(N'C:\Users\Administrator\Documents\百度云同步盘\SQL Server Init\.ini')
select dbo.GetDirectoryFullName(N'C:\Users\Administrator\Documents\百度云同步盘\SQL Server Init\.ini')
select dbo.GetFileDirectory(N'C:\Users\Administrator\Documents\百度云同步盘\SQL Server Init\ConfigurationFile.ini')*/
if (select dbo.SQLFUN('context connection=true', 'select db_name()', 0, 0, 'test_clr2', 'localhost\SQL16')) = 'test_clr2' BEGIN PRINT 'TEST016 - SQLFUN: OK!' END
if (select dbo.SQLFUN('context connection=true', 'select ''1'' a', 0, 0, 'test_clr2', '')) + 1 = 2  BEGIN PRINT 'TEST017 - SQLFUN: OK!' END
if (select dbo.SQLFUN('context connection=true', 'select 1 a, ''2''', 0, 1, '', '')) = 2  BEGIN PRINT 'TEST018 - SQLFUN: OK!' END
if (select dbo.SQLFUN('', 'select ''11'' a', 0, 0, 'test_clr2', 'localhost\SQL16')) = 11 BEGIN PRINT 'TEST019 - SQLFUN: OK!' END
if (select dbo.SQLFUN(null, 'select ''11'' a', 0, 0, 'test_clr2', 'localhost\SQL16')) = 11 BEGIN PRINT 'TEST020 - SQLFUN: OK!' END
if (select dbo.SQLFUN('', 'select null a', 0, 0, 'test_clr2', 'localhost\SQL16')) is null BEGIN PRINT 'TEST021 - SQLFUN: OK!' END
if (select dbo.SQLFUN('', 'select cast(null as nvarchar(max)) a', 0, 0, 'test_clr2', 'localhost\SQL16')) is null BEGIN PRINT 'TEST022 - SQLFUN: OK!' END

if (select dbo.SQLFUN('context connection=true', 'select cast(null as nvarchar(max)) a', 0, 0, '', '')) is null BEGIN PRINT 'TEST023 - SQLFUN: OK!' END
if (select dbo.SQLFUN('context connection=true', 'select null a', 0, 0, '', '')) is null BEGIN PRINT 'TEST024 - SQLFUN: OK!' END


select @err = 0
begin try 
	print dbo.INTFUN('context connection=true', 'select db_name()', 0, 0, 'test_clr2', 'localhost\SQL16')
	select @err = 1
end try 
begin catch PRINT 'TEST025 - SQLFUN: OK!' END catch
if @err = 1 begin THROW 51000, 'wrong INTFUN passed, Not OK! ', 1; end

if (select dbo.INTFUN('context connection=true', 'select 1 a', 0, 0, 'test_clr2', '')) + 1 = 2  BEGIN PRINT 'TEST026 - INTFUN: OK!' END
if (select dbo.INTFUN('context connection=true', 'select 1 a, 2', 0, 1, '', '')) = 2  BEGIN PRINT 'TEST027 - INTFUN: OK!' END
if (select dbo.INTFUN('', 'select 11 a', 0, 0, 'test_clr2', 'localhost\SQL16')) = 11 BEGIN PRINT 'TEST028 - INTFUN: OK!' END
if (select dbo.INTFUN(null, 'select 11 a', 0, 0, 'test_clr2', 'localhost\SQL16')) = 11 BEGIN PRINT 'TEST029 - INTFUN: OK!' END
if (select dbo.INTFUN('', 'select null a', 0, 0, 'test_clr2', 'localhost\SQL16')) is null BEGIN PRINT 'TEST030 - INTFUN: OK!' END
if (select dbo.INTFUN('', 'select cast(null as int) a', 0, 0, 'test_clr2', 'localhost\SQL16')) is null BEGIN PRINT 'TEST031 - INTFUN: OK!' END
if (select dbo.INTFUN('context connection=true', 'select cast(null as INT) a', 0, 0, '', '')) is null BEGIN PRINT 'TEST032 - INTFUN: OK!' END
if (select dbo.INTFUN('context connection=true', 'select null a', 0, 0, '', '')) is null BEGIN PRINT 'TEST033 - INTFUN: OK!' END

--DECLARE @err int = 0
select @err = 0
begin try 
	print dbo.FLOATFUN('context connection=true', 'select db_name()', 0, 0, 'test_clr2', 'localhost\SQL16')
	select @err = 1
end try 
begin catch PRINT 'TEST034 - SQLFUN: OK!' END catch
if @err = 1 begin THROW 51000, 'wrong FLOATFUN passed, Not OK! ', 1; end

if (select dbo.FLOATFUN('context connection=true', 'select cast(1.0 as float) a', 0, 0, 'test_clr2', '')) + 1.0 = 2.0  BEGIN PRINT 'TEST035 - FLOATFUN: OK!' END
if (select dbo.FLOATFUN('context connection=true', 'select 1 a, cast(2 as float)', 0, 1, '', '')) = 2.0  BEGIN PRINT 'TEST036 - FLOATFUN: OK!' END
if (select dbo.FLOATFUN('', 'select cast(11 as float) a', 0, 0, 'test_clr2', 'localhost\SQL16')) = 11 BEGIN PRINT 'TEST037- FLOATFUN: OK!' END
if (select dbo.FLOATFUN(null, 'select cast(11 as float) a', 0, 0, 'test_clr2', 'localhost\SQL16')) = 11 BEGIN PRINT 'TEST038 - FLOATFUN: OK!' END
if (select dbo.FLOATFUN('', 'select null a', 0, 0, 'test_clr2', 'localhost\SQL16')) is null BEGIN PRINT 'TEST039 - FLOATFUN: OK!' END
if (select dbo.FLOATFUN('', 'select cast(null as float) a', 0, 0, 'test_clr2', 'localhost\SQL16')) is null BEGIN PRINT 'TEST040 - FLOATFUN: OK!' END
if (select dbo.FLOATFUN('context connection=true', 'select cast(null as float) a', 0, 0, '', '')) is null BEGIN PRINT 'TEST041 - FLOATFUN: OK!' END
if (select dbo.FLOATFUN('context connection=true', 'select null a', 0, 0, '', '')) is null BEGIN PRINT 'TEST042 - FLOATFUN: OK!' END

--ONLY PARTIAL
if (select dbo.REALFUN('context connection=true', 'select cast(1.0 as REAL) a', 0, 0, 'test_clr2', '')) + 2.0 = 3.0  BEGIN PRINT 'TEST043 - REALFUN: OK!' END


if (select dbo.DTFUN('context connection=true', 'select cast(''2010'' as DATETIME) a', 0, 0, 'test_clr2', '')) = '2010-01-01'  BEGIN PRINT 'TEST044 - DTFUN: OK!' END

if (select dbo.PadLeft('ff', 5, 'o')) = 'oooff' begin print 'padleft ok!' end
if (select dbo.PadLeft('fffffffff', 5, 'o')) = 'fffffffff' begin print 'padleft ok!' end

if (select dbo.PadRight('ff', 5, 'o')) = 'ffooo' begin print 'PadRight ok!' end
if (select dbo.PadRight('fffffffff', 5, 'o')) = 'fffffffff' begin print 'PadRight ok!' end


if (SELECT DBO.[Replicate]('123', 4)) = '123123123123' begin print 'replicate ok!' end


select * from dbo.Split2String('dddfffdddfffdddfff123ddd', 'ddd')
select * from dbo.Split2Int('5234512345123451', '45')

select * from dbo.Split2StringDist('dddfffdddfffdddfff123ddd', 'ddd')
select * from dbo.Split2IntDist('5234512345123451', '45')
