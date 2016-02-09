CREATE DATABASE test_clr2
go

alter database test_clr2 set trustworthy on
go

CREATE ASSEMBLY [FSharp.Core]
AUTHORIZATION [dbo]
from 'C:\FSharp.Core.dll'
with permission_set = safe
GO

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
drop ASSEMBLY CLRUDF
END TRY 
BEGIN CATCH
AAA:
END CATCH
go


CREATE ASSEMBLY CLRUDF
AUTHORIZATION [dbo]
from 'C:\CLRUDF.dll'
with permission_set = unsafe
GO


CREATE FUNCTION dbo.regexMatch(@target nvarchar(max), @expr nvarchar(max))
RETURNS bit
AS EXTERNAL NAME  [CLRUDF].[FSUDF_REGEX.UDF_REGEX].regexMatch
go

CREATE FUNCTION dbo.regexVarMatchId(@target nvarchar(max), @expr nvarchar(max), @group int)
RETURNS nvarchar(max)
AS EXTERNAL NAME  [CLRUDF].[FSUDF_REGEX.UDF_REGEX].regexVarMatchId
go

CREATE FUNCTION dbo.regexVarMatchNm(@target nvarchar(max), @expr nvarchar(max), @group nvarchar(max))
RETURNS nvarchar(max)
AS EXTERNAL NAME  [CLRUDF].[FSUDF_REGEX.UDF_REGEX].regexVarMatchNm
go

CREATE FUNCTION dbo.regexReplace(@target nvarchar(max), @expr nvarchar(max), @repl nvarchar(max))
RETURNS nvarchar(max)
AS EXTERNAL NAME  [CLRUDF].[FSUDF_REGEX.UDF_REGEX].regexReplace
go

CREATE FUNCTION dbo.GetFileName(@path nvarchar(max))
RETURNS nvarchar(max)
AS EXTERNAL NAME  [CLRUDF].[FSUDF_FILESYS.UDF_FILESYS].GetFileNameFromPath
go

CREATE FUNCTION dbo.GetFileBaseName(@path nvarchar(max))
RETURNS nvarchar(max)
AS EXTERNAL NAME  [CLRUDF].[FSUDF_FILESYS.UDF_FILESYS].GetFileBaseNameFromPath
go

CREATE FUNCTION dbo.GetFileDirectory(@path nvarchar(max))
RETURNS nvarchar(max)
AS EXTERNAL NAME  [CLRUDF].[FSUDF_FILESYS.UDF_FILESYS].GetFileDirectoryFromPath
go

CREATE FUNCTION dbo.GetDirectoryName(@path nvarchar(max))
RETURNS nvarchar(max)
AS EXTERNAL NAME  [CLRUDF].[FSUDF_FILESYS.UDF_FILESYS].GetDirectoryNameFromPath
go

CREATE FUNCTION dbo.GetFileExtension(@path nvarchar(max))
RETURNS nvarchar(max)
AS EXTERNAL NAME  [CLRUDF].[FSUDF_FILESYS.UDF_FILESYS].GetFileExtensionFromPath
go

CREATE FUNCTION dbo.GetFileContent(@path nvarchar(max))
RETURNS nvarchar(max)
AS EXTERNAL NAME  [CLRUDF].[FSUDF_FILESYS.UDF_FILESYS].GetFileContentFromPath
go

CREATE FUNCTION dbo.GetDirectoryFullName(@path nvarchar(max))
RETURNS nvarchar(max)
AS EXTERNAL NAME  [CLRUDF].[FSUDF_FILESYS.UDF_FILESYS].GetDirectoryFullNameFromPath
go


CREATE FUNCTION dbo.PadLeft(@str nvarchar(max), @len int, @char nchar(1))
RETURNS nvarchar(max)
AS EXTERNAL NAME  [CLRUDF].[FSUDF_STR.UDF_STR].PadLeft
go

CREATE FUNCTION dbo.PadRight(@str nvarchar(max), @len int, @char nchar(1))
RETURNS nvarchar(max)
AS EXTERNAL NAME  [CLRUDF].[FSUDF_STR.UDF_STR].PadRight
go

CREATE FUNCTION dbo.SQLFUN(@conn nvarchar(max), @cmd nvarchar(max), @r int, @c int)
RETURNS nvarchar(max)
AS EXTERNAL NAME  [CLRUDF].[FSUDF_SQLFUN.UDF_SQLFUN].SQLFUN
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
EXTERNAL NAME  [CLRUDF].[FSUDF_REGEX.UDF_REGEX].GetSPParamDefaultValue
GO
select dbo.regexMatch(N'orz', N'd')
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


select dbo.PadRight('fhfhf', 10, '_')
select dbo.PadLeft('fhfhf', 10, '_')

if  dbo.regexMatch(N'orz', N'o') = 1
begin
select 1
end

exec [FS].[VIEWPARAM1] '[dbo].[GETAD]'

select * from  [VIEWPARAM] '[dbo].[GETAD]'

exec  [VIEWPARAM1] '[dbo].[SP_OP_AGREEMENTACCT]'


USE [SMOKE]
GO

/****** Object:  StoredProcedure [FS].[VIEWPARAM1]    Script Date: 10/29/2014 7:49:28 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




 
CREATE proc .[VIEWPARAM1](@SP nvarchar(4000))

AS
BEGIN

set nocount on
declare  @SCHEMA TABLE
(   
  PARAM_NAME NVARCHAR(4000),
  PARAM_DEFVAL Nvarchar(4000)  
)
  declare
        @w varchar(max),
        @p int, @p2 int,
        @t varchar(max)


    /* Andrey Rubanko 18 jul 2013 */

    /* fill temporary table with procedure body */

    select @w = definition
    from sys.sql_modules
    where object_id = object_id(@SP)

    declare @lines table (line varchar(500), id int identity(1, 1))

    while len(@w) > 0 begin
        set @p = charindex(char(10), @w)
        if @p > 0 begin
            insert @lines(line) values(replace(replace(SUBSTRING(@w, 1, @p - 1), char(13), ''), char(9), ' '))
            set @w = SUBSTRING(@w, @p + 1, 10000)
        end else begin
            insert @lines(line) values(replace(@w, char(13), ''))
            set @w = ''
        end
    end



    /* remove comments */

    declare 
        @i int,
        @inCommentNow bit,
        @again bit

    set @i = 1
    set @inCommentNow = 0

	--SELECT * FROM @lines

    while @i <= (select max(id) from @lines) begin
        select @w = line from @lines where id = @i
        set @again = 0

        if @inCommentNow = 0 begin
            set @p = patindex('%--%', @w)
            if @p > 0 begin
                set @w = SUBSTRING(@w, 1, @p - 1)

                update @lines
                set line = @w
                where id = @i

            end

            set @p = patIndex('%/*%', @w)
            if @p > 0 begin
                set @p2 = PATINDEX('%*/%', @w) 
                if @p2 > 0 begin
                    update @lines
                    set line = substring(@w, 1, @p - 1) + SUBSTRING(@w, @p2 + 2, 10000)
                    where id = @i

                    set @again = 1
                end else begin
                    set @inCommentNow = 1

                    update @lines
                    set line = SUBSTRING(@w, 1, @p - 1)
                    where id = @i
                end
            end
        end

        if @inCommentNow = 1 begin
            set @p = PATINDEX('%*/%', @w)
            if @p > 0 begin
                update @lines
                set line = SUBSTRING(@w, @p + 2, 10000)
                where id = @i

                set @inCommentNow = 0
                set @again = 1
            end else 
                update @lines
                set line = ''
                where id = @i
        end

        if @again = 0
            set @i = @i + 1
    end


    /* remove all except parameters */
    declare
        @first int,
        @last int

    set @i = 1

    while @last is null begin
        select @w = line from @lines where id = @i

        if SUBSTRING(@w, 1, 2) = 'as'
            set @last = @i - 1
		if @w like '% as%' begin
			set @p = PATINDEX('% as%', @w) 
		end else begin
			set @p = PATINDEX('%)%as%', @w)
		end
        if @last is null and @p > 0  begin
            set @w = SUBSTRING(@w, 1, @p - 1)

            update @lines
            set line = @w
            where id = @i

            if charindex('@', @w) > 0
                set @last = @i
            else 
                set @last = @i - 1
        end


        set @p = CHARINDEX('@', @w)
        if @first is null and @p > 0 begin
            set @first = @i
            set @w = SUBSTRING(@w, @p, 10000)
        end

        set @i = @i + 1
    end

    delete @lines
    where @first is null 
        or id < @first
        or id > @last



    /* decode lines to paramters */

	declare @ttc nvarchar(max) = ''
	select @ttc += line + ' '
        from @lines
	--select @ttc
   
  select * from dbo.GetSPParamDef(@ttc)

   


   -- declare
   --     @name varchar(50),
   --     @type varchar(50),
   --     @default varchar(50)

   -- declare c cursor for
   --     select line
   --     from @lines
   -- open c
   -- fetch next from c into @w 
   -- while @@FETCH_STATUS = 0 begin
   --     while len(@w) > 0 begin
   --         set @default = null
			--print 1
			--print @w
   --         set @w = SUBSTRING(@w, charindex('@', @w) + 1, 10000)
			--print 'sub @ w: ' + @w
			--if( dbo.regexMatch(@w, N'((?<nm>\w+)\s+)+?(?<typ>\w+\s*\(\d+,\d+\))+?') = 1)
			--begin
			--	set @p = CHARINDEX(',', @w)
			--end else begin
			--	set @p = CHARINDEX(',', @w)
			--end
			--print '@p = CHARINDEX('','', @w) : ' + cast(@p as nvarchar(max))
   --         --print 'start:' + @w
   --         if @p > 0 begin
   --             set @t = SUBSTRING(@w, 1, @p - 1)
			--	print 2
			--	print 'SUBSTRING(@w, 1, @p - 1) : ' + @t
   --             set @w = LTrim(RTrim(SUBSTRING(@w, @p + 1, 10000)))
   --         end else begin
   --             if @w like '% as%' begin
			--		set @p = PATINDEX('% as%', @w) 
			--	end else begin
			--		set @p = PATINDEX('%)%as%', @w)
			--	end
   --             if @p > 0 
			--	begin
					
   --                 set @t = SUBSTRING(@w, 1, @p - 1)
			--		print 3
			--		print 'SUBSTRING(@w, 1, @p - 1) : ' + @t
			--	end
   --             else begin 
   --                 set @t = @w
   --             set @w = '' end
   --         end

            
   --         set @p = charindex(' ', @t) 
			--print 'T= ' + @t
			--print '@p = charindex('' '', @t) : @p = ' +  cast(@p as nvarchar(max))
   --         --if @p = 0
   --         --    print 'NameError:' + @t + ' ->' + cast(@p as varchar)
			--print 4
			
   --         set @name = SUBSTRING(@t, 1, @p - 1)
			--print '@name = SUBSTRING(@t, 1, @p - 1) : ' + @name
			
   --         set @t = SUBSTRING(@t, @p + 1, 10000)
			--print 5
			--print '@t = SUBSTRING(@t, @p + 1, 10000) : ' + @t
   --         set @p = CHARINDEX('=', @t)

			--print '@p = CHARINDEX(''='', @t) : ' + cast(@p as nvarchar(max))

   --         if @p > 0 begin
   --             set @default = Replace(LTrim(RTrim(SUBSTRING(@t, @p + 1, 10000))), '''', '')
			--	print 6
			--	print '@default = Replace(LTrim(RTrim(SUBSTRING(@t, @p + 1, 10000))), '''''''', '''') : ' + @default
   --             set @t = SUBSTRING(@t, 1, @p - 1)
			--	print '@t = SUBSTRING(@t, 1, @p - 1) : ' + @t
   --         end 

   --         set @p = CHARINDEX('(', @t)
   --         if @p > 0 begin
			--	print 7
			--	print '@p = CHARINDEX(''('', @t) : ' + cast(@p as nvarchar(max))
   --             set @type = LTrim(RTrim(SUBSTRING(@t, 1, @p - 1)))
			--end
   --         else begin
   --             set @type = LTrim(RTrim(@t)) end

   --         insert @SCHEMA (PARAM_NAME, PARAM_DEFVAL)
   --         values(@name, @default)
   --     end--while len(@w) > 0

   --     fetch next from c into @w 
   -- end
   -- close c
   -- deallocate c
	--select * from @SCHEMA
   
  RETURN
END


GO




exec [dbo].[VIEWPARAM1]('[SP_OP_AGREEMENTACCT]')



create assembly System
from 'C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.5.1\SYSTEM.dll'
with permission_set = unsafe;
go

create assembly [System.Web.Extensions]
from 'C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.0\System.Web.Extensions.dll'
with permission_set = unsafe;
go

create assembly [System.Web]
from 'C:\Windows\Microsoft.NET\Framework64\v4.0.30319\System.Web.dll'
with permission_set = unsafe;
go

--CREATE ASSEMBLY [system.xaml]
--AUTHORIZATION [dbo]
--from 'C:\system.xaml.dll'
--with permission_set = unsafe
--GO


--CREATE ASSEMBLY [microsoft.build.framework]
--AUTHORIZATION [dbo]
--from 'C:\microsoft.build.framework.dll'
--with permission_set = unsafe
--GO

--CREATE ASSEMBLY [system.web]
--AUTHORIZATION [dbo]
--from 'C:\system.web.dll'
--with permission_set = unsafe
--GO

--CREATE ASSEMBLY [system.servicemodel.activation]
--AUTHORIZATION [dbo]
--from 'C:\system.servicemodel.activation.dll'
--with permission_set = unsafe
--GO

--CREATE ASSEMBLY [System.Web.Extensions]
--AUTHORIZATION [dbo]
--from 'C:\System.Web.Extensions.dll'
--with permission_set = unsafe
--GO