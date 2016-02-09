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

CREATE FUNCTION dbo.SQLFUN(@conn nvarchar(max), @cmd nvarchar(max), @r int, @c int)
RETURNS nvarchar(max)
AS EXTERNAL NAME  [CLR_UDF_CS].[CSUDF_SQLFUN.UDF_SQLFUN].SQLFUN
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

select dbo.regexVarMatchId(N'oddodoojiejwi', N'(?<l>dd)', 0)
select dbo.regexVarMatchNm(N'oddodoojiejwi', N'(?<l>\w)', 'l')
select dbo.regexReplace(N'oddodooj iejwi', N'(?<l>\w+ )', 'lslslsl ')
select dbo.GetFileName('C:\CLR_UDF.XML')
select dbo.GetFileBaseName('C:\CLR_UDF.XML')
select dbo.GetFileExtension('C:\CLR_UDF.XML')
select dbo.GetFileContent('C:\CLR_UDF.XML')
select dbo.GetDirectoryName(N'C:\Users\Administrator\Documents\百度云同步盘\SQL Server Init\.ini')
select dbo.GetDirectoryFullName(N'C:\Users\Administrator\Documents\百度云同步盘\SQL Server Init\.ini')
select dbo.GetFileDirectory(N'C:\Users\Administrator\Documents\百度云同步盘\SQL Server Init\ConfigurationFile.ini')
select dbo.SQLFUN('', 'select @@servername', 0, 0)







