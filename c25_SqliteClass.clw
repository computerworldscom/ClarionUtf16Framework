    Member()

    Include('c25_SqliteClass.inc'),ONCE

            Map
                Include('Sqlite3Prototypes.inc')
                Include('c25_WinApiPrototypes.inc')
                Include('i64.inc')
            End

c25_SqliteClass.Construct                                       Procedure()

ClassStarter  &c25_ClassStarter

Code

    
    Self.ClassTypeName = 'c25_SqliteClass'

    Self.ZeroAddress = Address(Self.Zero)
    
    ClassStarter &= NEW c25_ClassStarter()
    Self.ProgramHandlerClass &= (ClassStarter.Start(Self.ClassTypeName))
    Dispose(ClassStarter)
    
    !Self.StLog &= NEW StringTheory()
    
    !Remove('m:\c25_SqliteClass_log.txt')
    !Self.StLog.SetValue('start' & Chr(13) & Chr(10))
    !Self.StLog.SaveFile('m:\c25_SqliteClass_log.txt')    

    Self.CRLF                        = Chr(13) & Chr(10)
    Self.st1                        &= New StringTheory()
    Self.st2                        &= New StringTheory()
    Self.st3                        &= New StringTheory()
    Self.st4                        &= New StringTheory()
    Self.StProperty                 &= New StringTheory()

    Self.Js1                        &= New JSONClass()
    Self.Js2                        &= New JSONClass()
    Self.Js3                        &= New JSONClass()
    Self.Js4                        &= New JSONClass()
    Self.Js5                        &= New JSONClass()

    Self.WinApiClass                &= New c25_WinApiClass()
    Self.NanoClockClass             &= New C25_NanoSyncClass()
    Self.BitConverter               &= New c25_BitConverterClass()
    Self.DataReflectionClass        &= New c25_DataReflectionClass()
    Self.PragmaDbList               &= New PragmaDbList_TYPE()
    Self.SelfAddress                = Address(Self)

    Self.Int16MaxValue              = 32767
    Self.Int16MinValue              = -32768
    Self.UInt16MaxValue             = 65535
    Self.UInt16MinValue             = 0

    Self.Int32MaxValue              = 2147483647
    Self.Int32MinValue              = -2147483648
    Self.UInt32MaxValue             = 4294967295
    Self.UInt32MinValue             = 0

    Self.Int64MaxValue              = 9223372036854775807
    Self.Int64MinValue              = -9223372036854775808
    Self.UInt64MaxValue             = 18446744073709551615
    Self.UInt64MinValue             = 0

    Self.stSqlStatementInsert               &= NEW StringTheory()
    Self.stSqlStatementSelect               &= NEW StringTheory()
    Self.stSqlStatementUpdate               &= NEW StringTheory()
    Self.stSqlStatementScalar               &= NEW StringTheory()

    Self.In_ColumnValInt1Address     = Address(Self.In_ColumnValInt1)
    Self.In_ColumnValInt2Address     = Address(Self.In_ColumnValInt2)

    Self.In_ColumnValInt4Address     = Address(Self.In_ColumnValInt4)
    Self.In_ColumnValUInt2Address    = Address(Self.In_ColumnValUInt2)
    Self.In_ColumnValUInt4Address    = Address(Self.In_ColumnValUInt4)

    Self.In_Sqlite3ColumnMeta &= NEW Sqlite3ColumnMeta_TYPE()

    Clear(Self.In_8Zero,-1)
    Self.In_8Zero_Address = Address(Self.In_8Zero)

    Self.In_DummyStringStr8_Address          = Address(Self.In_DummyStringStr8)

    Self.In_NanoClockClass                   &= NEW C25_NanoSyncClass()

    Self.In_st1                              &= NEW StringTheory()

    Self.In_Reflection                       &= NEW c25_DataReflectionClass()

    Self.In_ClarionFields &= NEW ClarionFields_TYPE
    Self.Out_ColumnValInt1Address     = Address(Self.Out_ColumnValInt1)
    Self.Out_ColumnValInt2Address     = Address(Self.Out_ColumnValInt2)

    Self.Out_ColumnValInt4Address     = Address(Self.Out_ColumnValInt4)
    Self.Out_ColumnValUInt2Address    = Address(Self.Out_ColumnValUInt2)
    Self.Out_ColumnValUInt4Address    = Address(Self.Out_ColumnValUInt4)

    Self.Out_Sqlite3ColumnMeta &= NEW Sqlite3ColumnMeta_TYPE()

    Clear(Self.Out_8Zero,-1)
    Self.Out_8Zero_Address = Address(Self.Out_8Zero)

    Self.Out_DummyStringGrpStr8_Address          = Address(Self.Out_DummyStringGrpStr8)

    Self.Out_NanoClockClass                   &= NEW C25_NanoSyncClass()

    Self.Out_st1                              &= NEW StringTheory()
    Self.Out_Reflection                       &= NEW c25_DataReflectionClass()

    Self.Out_ClarionFields &= NEW ClarionFields_TYPE

c25_SqliteClass.Destruct                                        Procedure()

Code

    If Self.In_SqlStatementInsertHandle <> 0
        c25_sqlite3_finalize(Self.In_SqlStatementInsertHandle)
    End
    Self.Disconnect()

    
c25_SqliteClass.QueryAsyncToDataTableClass                      Procedure(<*c25_DataTableClass _dataTableClass>, <string _tableName>, <string _sql>)    

DataTableClass  &c25_DataTableClass
FirstRow        bool

Code
    
    ! TODO move columns data to cell data
    
    
    If omitted(_tableName) = FALSE
        Self.Out_TableName = _tableName
    End
    
    If omitted(_dataTableClass) = TRUE
        DataTableClass &= NEW c25_DataTableClass()
    ELSE
        DataTableClass &= _dataTableClass
    End
    

    If omitted(_sql) = False
        Self.Out_SqlStatementSelectHandle = Self.CreateSelectPrepareSql(_sql)
    Else
        Self.Out_SqlStatementSelectHandle = Self.CreateSelectPrepareSql( , , Self.Out_TableName)
    End
    
    If DataTableClass.Columns &= null
        DataTableClass.Columns &= NEW DataColumnCollection_TYPE()
    Else
        Free(DataTableClass.Columns)
    End
    

    Free(DataTableClass.Rows) ! todo free incl string refs etc
    
    FirstRow = True
    
    If NOT Self.Out_FieldValueStringRef &= NULL
        Dispose(Self.Out_FieldValueStringRef)
    End

    Self.Out_RetrievedCount = 0
    Loop
        Self.ResultCode = c25_sqlite3_step(Self.Out_SqlStatementSelectHandle)
        Case Self.ResultCode
        Of C25_SQLITE_ROW 
            Clear(DataTableClass.Rows)
            DataTableClass.Rows.DataColumn &= NEW c25_DataColumnClass()

            Self.Out_SourceIndex = -1
            Loop Self.Out_FieldsCount Times
                Self.Out_SourceIndex = Self.Out_SourceIndex + 1

                If FirstRow
                    Clear(DataTableClass.Columns.DataColumn)
                    DataTableClass.Columns.DataColumn.Ordinal = Self.Out_SourceIndex
                    DataTableClass.Columns.DataColumn &= NEW c25_DataColumnClass()
                    DataTableClass.Columns.DataColumn.DataTypeEnum = c25_sqlite3_column_type(Self.Out_SqlStatementSelectHandle, Self.Out_SourceIndex)
                    DataTableClass.Columns.DataColumn.Name &= Self.BitConverter.BinaryCopy( c25_sqlite3_column_name(Self.Out_SqlStatementSelectHandle, Self.Out_SourceIndex) )
                    Add(DataTableClass.Columns)
                End
                DataTableClass.Rows.DataColumn.ObjectValue &= NEW c25_ObjectClass()
                DataTableClass.Rows.DataColumn.DataTypeEnum = DataTableClass.Rows.DataColumn.ObjectValue.ParseSqlite3Value(Self.Out_SqlStatementSelectHandle, Self.Out_SourceIndex)
            End
            Self.Out_RetrievedCount = Self.Out_RetrievedCount + 1
        Of C25_SQLITE_DONE
            BREAK
        Of C25_SQLITE_BUSY
        OrOf C25_SQLITE_BUSY_RECOVERY
        OrOf C25_SQLITE_BUSY_SNAPSHOT
        OrOf C25_SQLITE_LOCKED
            c25_SleepEx(50,0)
            Cycle
        Else
            Message('step unknown error: ' & Self.ResultCode)
            BREAK
        End
        If FirstRow
            FirstRow = 0
        End
    End

    Return DataTableClass


c25_SqliteClass.EnumRowsPrepare               Procedure(<string _tableName>, <string _sql>)    

Code
    
    
    If omitted(_tableName) = FALSE
        Self.Out_TableName = _tableName
    End
    Self.Out_SqlStatementSelectHandle = 0
    
    If omitted(_sql) = False
        Self.Out_SqlStatementSelectHandle = Self.CreateSelectPrepareSql(_sql)
    Else
        Self.Out_SqlStatementSelectHandle = Self.CreateSelectPrepareSql( , , Self.Out_TableName)
    End
    If Self.Out_SqlStatementSelectHandle = 0
        Self.Out_FieldsCount = -1
        Return 0
    End
    Self.Out_FieldsCount = c25_sqlite3_column_count(Self.Out_SqlStatementSelectHandle)
    
    Return Self.Out_FieldsCount


c25_SqliteClass.EnumRows                      Procedure()    


Code
    
    Self.FieldIndex = -1
    
    Self.FoundRow = 0
    Loop 1000 Times ! implement lock exit timeout
        Self.ResultCode = c25_sqlite3_step(Self.Out_SqlStatementSelectHandle)
        Case Self.ResultCode
        Of C25_SQLITE_ROW 
            Self.FoundRow = TRUE
            Break
        Of C25_SQLITE_DONE
            BREAK
        Of C25_SQLITE_BUSY
        OrOf C25_SQLITE_BUSY_RECOVERY
        OrOf C25_SQLITE_BUSY_SNAPSHOT
        OrOf C25_SQLITE_LOCKED
            c25_SleepEx(50,0)
            Cycle
        Else
            Return Self.ResultCode
            BREAK
        End
    End
    Return Self.FoundRow
    
    

c25_SqliteClass.EnumFields          Procedure(*c25_ObjectClass _objectClass)    

FieldName                               cstring(128)

Code
    
    Self.FieldIndex = Self.FieldIndex + 1
    If Self.FieldIndex > Self.Out_FieldsCount
        Return False
    End
!    Self.Out_SourceIndex = 1
!    !_objectClass.Reset()
!    
    _objectClass.Ordinal = Self.FieldIndex
    _objectClass.SourceTypeEnum = c25_sqlite3_column_type(Self.Out_SqlStatementSelectHandle, Self.FieldIndex)
    
    FieldName = Self.BitConverter.ParseZeroTerminatedStringA(c25_sqlite3_column_name(Self.Out_SqlStatementSelectHandle, Self.FieldIndex),true)
    
    _objectClass.Name &= Self.BitConverter.BinaryCopy(FieldName)
    !_objectClass.Name &= Self.BitConverter.AnsiToUtf16(FieldName,,true)    
!    
    _objectClass.DataTypeEnum = _objectClass.ParseSqlite3Value(Self.Out_SqlStatementSelectHandle, Self.FieldIndex)

    Return true
    

!c25_SqliteClass.EnumFields          Procedure()    
!
!ObjectClass                         &c25_ObjectClass
!FieldName                               cstring(128)
!
!Code
!    
!    Self.Out_SourceIndex = Self.Out_SourceIndex + 1
!    If Self.Out_SourceIndex > Self.Out_FieldsCount
!        Return NULL
!    End
!
!    ObjectClass &= NEW c25_ObjectClass()
!
!    ObjectClass.Ordinal = Self.Out_SourceIndex
!    ObjectClass.SourceTypeEnum = c25_sqlite3_column_type(Self.Out_SqlStatementSelectHandle, Self.Out_SourceIndex)
!    !ObjectClass.Name &= Self.BitConverter.BinaryCopy(c25_sqlite3_column_name(Self.Out_SqlStatementSelectHandle, Self.Out_SourceIndex) )
!    
!    !FieldName = Self.BitConverter.ParseZeroTerminatedStringA(c25_sqlite3_column_name(Self.Out_SqlStatementSelectHandle, Self.Out_SourceIndex),true)
!    FieldName = 'test'
!    ObjectClass.Name &= Self.BitConverter.AnsiToUtf16(FieldName,,true)
!    
!    ObjectClass.DataTypeEnum = ObjectClass.ParseSqlite3Value(Self.Out_SqlStatementSelectHandle, Self.Out_SourceIndex)
!
!    Return ObjectClass
    
    
                                                                    
c25_SqliteClass.GetSelfAddress                                  Procedure()

    Code

        Self.SelfAddress = Address(Self)
        Return Self.SelfAddress

c25_SqliteClass.Connect                                         Procedure(String _connString, <SqlOpenFlags_TYPE _sqlOpenFlags>, <bool _inMemory>)

ConnHandle                   Long
SQLLine                      String(65000)
Sqlite3ConnType              Long
DBEncoding                   Long
SqlOpenFlags                 &SqlOpenFlags_TYPE

    Code

        SqlOpenFlags &= NEW SqlOpenFlags_TYPE()

        Self.ConnHandle = 0

        If omitted(_inMemory) = True Or _inMemory = 0
            Self.ConnectionString = Clip(_connString) & Chr(0) & Chr(0)
            If OMITTED(_sqlOpenFlags) = True
                Clear(SqlOpenFlags)

                SqlOpenFlags.AUTOPROXY              = 0
                SqlOpenFlags.CREATE                 = True
                SqlOpenFlags.DELETEONCLOSE          = 0
                SqlOpenFlags.EXCLUSIVE              = False
                SqlOpenFlags.EXRESCODE              = False
                SqlOpenFlags.FULLMUTEX              = False
                SqlOpenFlags.MAIN_DB                = 0
                SqlOpenFlags.MAIN_JOURNAL           = 0
                SqlOpenFlags.MEMORY                 = False
                SqlOpenFlags.NOFOLLOW               = 0
                SqlOpenFlags.NOMUTEX                = 0
                SqlOpenFlags.PRIVATECACHE           = 0
                SqlOpenFlags.READONLY               = 0
                SqlOpenFlags.READWRITE              = True
                SqlOpenFlags.SHAREDCACHE            = False
                SqlOpenFlags.SUBJOURNAL             = 0
                SqlOpenFlags.SUPER_JOURNAL          = 0
                SqlOpenFlags.TEMP_DB                = 0
                SqlOpenFlags.TEMP_JOURNAL           = 0
                SqlOpenFlags.TRANSIENT_DB           = 0
                SqlOpenFlags.URI                    = True
                SqlOpenFlags.WAL                    = False
                SqlOpenFlags.PRAGMA_ENCODING        = 'UTF-8'
                SqlOpenFlags.PRAGMA_SYNCHRONOUS     = '0'
                SqlOpenFlags.PRAGMA_JOURNAL_MODE    = 'MEMORY'
                SqlOpenFlags.PRAGMA_TEMP_STORE      = 'MEMORY'
                SqlOpenFlags.PRAGMA_LOCKING_MODE    = 'EXCLUSIVE'
                SqlOpenFlags.ForceEncoding          = 0
                SqlOpenFlags.DeleteFileAlways       = False
            Else
                SqlOpenFlags = _sqlOpenFlags

            End
            Self.ResultCode = c25_Sqlite3_open_V2(Address(Self.ConnectionString),Address(ConnHandle),C25_SQLITE_OPEN_URI + c25_SQLITE_OPEN_READWRITE + c25_SQLITE_OPEN_CREATE + c25_SQLITE_OPEN_SHAREDCACHE, 0)
        ElsIf omitted(_inMemory) = False And _inMemory = TRUE
            Self.ConnectionString = ':memory:' & Chr(0) & Chr(0)
            Self.ResultCode = c25_Sqlite3_open_V2(Address(Self.ConnectionString),Address(ConnHandle),c25_SQLITE_OPEN_READWRITE + c25_SQLITE_OPEN_CREATE + c25_SQLITE_OPEN_SHAREDCACHE, 0)
        ELSE
            Message('coding error proc sqlite connect')
            Return 0
        End
        If Self.ResultCode <> 0
            Message('c25_Sqlite3_open_V2 Self.ResultCode ' & Self.ResultCode)

            Return 0
        End
        Self.ConnHandle = ConnHandle
        c25_sqlite3_extended_result_codes(ConnHandle, True)

        SQLLine = 'PRAGMA MAX_PAGE_COUNT = 2147483646;' & Chr(0)
        c25_sqlite3_exec(ConnHandle,Address(SQLLine),0,0,0)
        SQLLine = 'PRAGMA MMAP_SIZE = 10000;' & Chr(0)
        c25_sqlite3_exec(ConnHandle,Address(SQLLine),0,0,0)
        SQLLine = 'PRAGMA CACHE_SIZE = 12884901888;' & Chr(0)
        c25_sqlite3_exec(ConnHandle,Address(SQLLine),0,0,0)
        SQLLine = 'PRAGMA PAGE_SIZE  = 65536;' & Chr(0)
        c25_sqlite3_exec(ConnHandle,Address(SQLLine),0,0,0)
        SQLLine = 'PRAGMA MEMDB_DEFAULT_MAXSIZE = 17179869184;' & Chr(0)
        c25_sqlite3_exec(ConnHandle,Address(SQLLine),0,0,0)

        SQLLine = 'PRAGMA SYNCHRONOUS = OFF;' & Chr(0)
        c25_sqlite3_exec(ConnHandle,Address(SQLLine),0,0,0)
        SQLLine = 'PRAGMA JOURNAL_MODE = OFF;' & Chr(0)
        c25_sqlite3_exec(ConnHandle,Address(SQLLine),0,0,0)
        SQLLine = 'PRAGMA TEMP_STORE = MEMORY;' & Chr(0)
        c25_sqlite3_exec(ConnHandle,Address(SQLLine),0,0,0)
        SQLLine = 'PRAGMA LOCKING_MODE = EXCLUSIVE;' & Chr(0)
        c25_sqlite3_exec(ConnHandle,Address(SQLLine),0,0,0)

        SQLLine = 'CREATE TABLE DummyTABLE (ROWID INTEGER PRIMARY KEY AUTOINCREMENT, SESSIONINPUTID TEXT COLLATE NOCASE)' & Chr(0)
        c25_sqlite3_exec(Self.ConnHandle,Address(SQLLine),0,0,0)

        SQLLine = 'DROP TABLE DummyTABLE' & Chr(0)
        c25_sqlite3_exec(Self.ConnHandle,Address(SQLLine),0,0,0)
        Return Self.ConnHandle

c25_SqliteClass.GetPragmaDbList                                 Procedure(<Long _connHandle>,<PragmaDbList_TYPE _pragmaDbList>, <Byte _inJson>,<Byte _show>)

json                                     &JSONClass,auto
st1                                      &StringTheory,auto

    Code

        Return ''

c25_SqliteClass.GetPragma                                       Procedure(String _pragma, <String _paramA>,<*queue _queueOut>)

    Code

        Case Lower(Clip(_pragma))
        Of 'table_info'
        Of 'database_list'
        End

        Return ''

c25_SqliteClass.CreateTableFromQueue                            Procedure(*QUEUE _queue, string _tableName, <bool _dropIfExists>, <bool _makeFirstFieldPrimary>, <string _tablePrefix>, <ClarionFields_TYPE _clarionFields>, <bool _skipAutoIncrement>)

TableName                           CString(1024)
Sqlite3DT                           Cstring(255)
Sqlite3Collate                      Cstring(255)
Attribute                           STRING(1024)
AttrExists                          BYTE
CurrentField                        string(1024)
SqlText                             string(16000)
SyncHeaderAdded                     BYTE
SQLLine                             String(2048)
c25DbSqlObjectReturn                &c25DbSqlObjectReturn_TYPE
clarionFields                       &ClarionFields_TYPE

    CODE

        c25DbSqlObjectReturn &= NEW c25DbSqlObjectReturn_TYPE()

        If OMITTED(_tablePrefix) Or Size(_tablePrefix) = 0
            TableName = _tableName
        ELSE
            TableName = _tablePrefix & _tableName
        End
        If _dropIfExists = TRUE
            Self.Exec(, 'DROP TABLE IF EXISTS ' & TableName & ';' & Chr(0))
        End
        Self.st1.Start()
        If omitted(_clarionFields) = True
            Self.DataReflectionClass.Analyze(_queue)
            clarionFields &= Self.DataReflectionClass.ClarionFields
        Else
            clarionFields &= _clarionFields
        End

        Self.BitConverter.QToJson(clarionFields, 'm:\CreateTableFromQueue.json', true)

        Self.st1.Start()
        Self.st1.Append('CREATE TABLE IF NOT EXISTS ' & TableName & ' ('  & Self.CRLF)

        G# = 0
        Loop
            G# = G# + 1
            Get(clarionFields,G#)
            If Errorcode() <> 0
                BREAK
            End
            If clarionFields.DataTypeTargetEnum = 0
                Self.DataReflectionClass.UpdateSqliteDataTypeEnum(clarionFields)
                Self.DataReflectionClass.MapDataTypeTarget(clarionFields)
                BREAK
            End
        End

        G# = 0
        Loop
            G# = G# + 1
            Get(clarionFields,G#)
            If Errorcode() <> 0
                BREAK
            End
            If clarionFields.DataTypeTargetEnum = 0
                Message('error clarionFields not clarionFields.DataTypeTargetEnum = 0 sqlite definitions')
                BREAK
            END

            If G# = 1 And _makeFirstFieldPrimary = True
                If clarionFields.DataTypeTarget = 'TEXT'
                    Self.st1.Append('' & clarionFields.Name & ' TEXT PRIMARY KEY COLLATE NOCASE,' & Self.CRLF)
                ELSE
                    If omitted(_skipAutoIncrement) = False And _skipAutoIncrement = True
                        Self.st1.Append('' & clarionFields.Name & ' ' & clarionFields.DataTypeTarget & ' PRIMARY KEY' & ',' & Self.CRLF)
                    Else
                        Self.st1.Append('' & clarionFields.Name & ' ' & clarionFields.DataTypeTarget & ' PRIMARY KEY AUTOINCREMENT' & ',' & Self.CRLF)
                    End
                End
            ELSE
                Self.st1.Append('' & clarionFields.Name & ' ' & clarionFields.DataTypeTarget & ',' & Self.CRLF)
            End
        End
        Self.st1.Crop(1, Self.st1.Length() - 3)
        Self.st1.Append(');'  & Self.CRLF)
        Self.st1.Append(Self.CRLF & Chr(0))
        Self.st1.SaveFile('m:\createSqlite3Table.txt')

        Self.Exec(, Self.st1.GetValue())

        clarionFields &= null

        Return ''

c25_SqliteClass.CalcSqlOpenFlagsValue                           Procedure(<SqlOpenFlags_TYPE _sqlOpenFlags>)

SqlOpenFlagsSumValue  Long

    Code

        Clear(Self.SqlOpenFlags)

        If OMITTED(_sqlOpenFlags) = False
            Self.SqlOpenFlags = _sqlOpenFlags
        End

        If Self.SqlOpenFlags.READONLY = True
            SqlOpenFlagsSumValue = SqlOpenFlagsSumValue + C25_SQLITE_OPEN_READONLY
        End
        If Self.SqlOpenFlags.READWRITE = True
            SqlOpenFlagsSumValue = SqlOpenFlagsSumValue + C25_SQLITE_OPEN_READWRITE
        End
        If Self.SqlOpenFlags.CREATE = True
            SqlOpenFlagsSumValue = SqlOpenFlagsSumValue + C25_SQLITE_OPEN_CREATE
        End
        If Self.SqlOpenFlags.URI = True
            SqlOpenFlagsSumValue = SqlOpenFlagsSumValue + C25_SQLITE_OPEN_URI
        End
        If Self.SqlOpenFlags.MEMORY = True
            SqlOpenFlagsSumValue = SqlOpenFlagsSumValue + C25_SQLITE_OPEN_MEMORY
        End
        If Self.SqlOpenFlags.NOMUTEX = True
            SqlOpenFlagsSumValue = SqlOpenFlagsSumValue + C25_SQLITE_OPEN_NOMUTEX
        End
        If Self.SqlOpenFlags.FULLMUTEX = True
            SqlOpenFlagsSumValue = SqlOpenFlagsSumValue + C25_SQLITE_OPEN_FULLMUTEX
        End
        If Self.SqlOpenFlags.SHAREDCACHE  = True
            SqlOpenFlagsSumValue = SqlOpenFlagsSumValue + C25_SQLITE_OPEN_SHAREDCACHE
        End
        If Self.SqlOpenFlags.PRIVATECACHE = True
            SqlOpenFlagsSumValue = SqlOpenFlagsSumValue + C25_SQLITE_OPEN_PRIVATECACHE
        End
        If Self.SqlOpenFlags.NOFOLLOW = True
            SqlOpenFlagsSumValue = SqlOpenFlagsSumValue + C25_SQLITE_OPEN_NOFOLLOW
        End
        If Self.SqlOpenFlags.EXRESCODE = True
            SqlOpenFlagsSumValue = SqlOpenFlagsSumValue + C25_SQLITE_OPEN_EXRESCODE
        End
        Return SqlOpenFlagsSumValue

c25_SqliteClass.Disconnect                                      Procedure(<Long _connHandle>)

    Code

        If omitted(_connHandle) = False
            R# = c25_sqlite3_close(_connHandle)
        ELSE
            R# = c25_sqlite3_close(Self.ConnHandle)
        End
        Self.ConnHandle = 0
        Return R#

c25_SqliteClass.Exec                                            Procedure(<Long _connHandle>, String _sql)

SqlLine         &String
ConnHandle      Long

    Code

        If OMITTED(_connHandle) = False
            ConnHandle = _connHandle
        ELSE
            ConnHandle = Self.ConnHandle
        End
        SqlLine &= NEW String(Len(_sql) + 2)
        SqlLine = Clip(_sql) & Chr(0) & Chr(0)

        If not SqlLine &= null
            R# = c25_sqlite3_exec(ConnHandle,Address(SqlLine),0,0,0)

            Dispose(SqlLine)
        End

        Return R#

c25_SqliteClass.AttachDb                                        Procedure(<Long _connHandle>, String _uriUtf8, String _dbAlias)

AliasDbAnsi             String(256)
UriUtf8Cropped          String(16000)
SQLCommandLine          String(16000)
ConnHandle                      Long

    Code

        If omitted(_connHandle) = False
            ConnHandle = _connHandle
        ELSE
            ConnHandle = Self.ConnHandle
        End
        AliasDbAnsi         = Clip(Left(_dbAlias))
        UriUtf8Cropped      = Self.BitConverter.CropZerosUtf8(_uriUtf8)
        SQLCommandLine      = 'ATTACH DATABASE "' & Clip(UriUtf8Cropped) & '" AS ' & Clip(AliasDbAnsi) & ';' & Chr(0)
        Self.ResultCode     = c25_sqlite3_exec(ConnHandle,Address(SQLCommandLine),0,0,0)

        Return Self.ResultCode

c25_SqliteClass.DetachDb                                        Procedure(<_connHandle>, String _dbAlias)

AliasDbAnsi             String(256)
SQLCommandLine          String(16000)
ConnHandle                      Long

    Code

        If omitted(_connHandle) = False
            ConnHandle = _connHandle
        ELSE
            ConnHandle = Self.ConnHandle
        End
        AliasDbAnsi         = Clip(Left(_dbAlias))
        SQLCommandLine      = 'DETACH ' & Clip(AliasDbAnsi) & ';' & Chr(0)
        Self.ResultCode     = c25_sqlite3_exec(ConnHandle,Address(SQLCommandLine),0,0,0)
        Return Self.ResultCode

c25_SqliteClass.ExecuteScalar                                   Procedure(<String _commandText>,<*c25DbSqlObjectReturn_TYPE _c25DbSqlObjectReturn>)

    Code

        Clear(Self.c25DbSqlObjectReturn)

        Self.c25DbSqlObjectReturn.StartTime = Self.NanoClockClass.GetSysTime()

        If Omitted(_commandText) = False
            If not Self.CommandText &= NULL
                Dispose(Self.CommandText)
            End
            Self.CommandText &= NEW String(Len(Clip(_commandText)) + 2)
            Self.CommandText = Clip(Left(_commandText)) & Chr(0) & Chr(0)
        End

L0      Loop 1 Times
            Self.NanoClockClass.SetTimeOut(0,1,0,0)
L1          Loop
                If Self.NanoClockClass.IsTimeOut()
                    BREAK L0
                End
                Self.ResultCode = c25_sqlite3_prepare_v2(Self.ConnHandle,Address(Self.CommandText),Len(Self.CommandText),Address(Self.c25DbSqlObjectReturn.StmtHandle),0)
                Self.c25DbSqlObjectReturn.PrepareResultCode = Self.ResultCode
                Case Self.ResultCode
                Of C25_SQLITE_OK
                ELSE
                End

                Case Self.ResultCode
                Of C25_SQLITE_OK
                    BREAK L1
                Of C25_SQLITE_BUSY
                OrOf C25_SQLITE_BUSY_RECOVERY
                OrOf C25_SQLITE_BUSY_SNAPSHOT
                OrOf C25_SQLITE_LOCKED
                    If Self.c25DbSqlObjectReturn.StmtHandle <> 0
                        c25_sqlite3_finalize(Self.c25DbSqlObjectReturn.StmtHandle)
                        Self.c25DbSqlObjectReturn.StmtHandle = 0
                    End
                    Self.c25DbSqlObjectReturn.RetriesOnBusy = Self.c25DbSqlObjectReturn.RetriesOnBusy + 1
                    c25_SleepEx(20,0)
                    Cycle
                Else
                    If Self.c25DbSqlObjectReturn.StmtHandle <> 0
                        c25_sqlite3_finalize(Self.c25DbSqlObjectReturn.StmtHandle)
                        Self.c25DbSqlObjectReturn.StmtHandle = 0
                    End
                    BREAK L0
                End
            End

            If Self.c25DbSqlObjectReturn.StmtHandle = 0
                BREAK L0
            End

            Self.NanoClockClass.SetTimeOut(0,1,0,0)
L2          Loop
                If Self.NanoClockClass.IsTimeOut()
                    BREAK L0
                End
                Self.ResultCode = c25_sqlite3_step(Self.c25DbSqlObjectReturn.StmtHandle)
                Self.c25DbSqlObjectReturn.StepResultCode = Self.ResultCode
                Case Self.ResultCode
                Of C25_SQLITE_ROW
                OrOf C25_SQLITE_DONE
                ELSE
                End

                Case Self.ResultCode
                Of C25_SQLITE_ROW
                    Self.c25DbSqlObjectReturn.FoundRow = True
                    BREAK L2
                Of C25_SQLITE_DONE
                    Self.c25DbSqlObjectReturn.NoResultFound = True
                    If Self.c25DbSqlObjectReturn.StmtHandle <> 0
                        c25_sqlite3_finalize(Self.c25DbSqlObjectReturn.StmtHandle)
                        Self.c25DbSqlObjectReturn.StmtHandle = 0
                    End
                    BREAK L0
                Of C25_SQLITE_BUSY
                OrOf C25_SQLITE_BUSY_RECOVERY
                OrOf C25_SQLITE_BUSY_SNAPSHOT
                OrOf C25_SQLITE_LOCKED
                    Self.c25DbSqlObjectReturn.RetriesOnBusy = Self.c25DbSqlObjectReturn.RetriesOnBusy + 1
                    c25_SleepEx(20,0)
                    Cycle
                Else
                    BREAK L0
                End
            End

            Self.c25DbSqlObjectReturn.Sqlite3ColumnTypeId = c25_sqlite3_column_type(Self.c25DbSqlObjectReturn.StmtHandle, 0)

            Case Self.c25DbSqlObjectReturn.Sqlite3ColumnTypeId
            Of C25_SQLITE_INTEGER
                Self.c25DbSqlObjectReturn.IsInteger         = True
            Of C25_SQLITE_FLOAT
                Self.c25DbSqlObjectReturn.IsFloat           = True
            Of C25_SQLITE_BLOB
                Self.c25DbSqlObjectReturn.IsBlob            = True
            Of C25_SQLITE_NULL
                Self.c25DbSqlObjectReturn.IsNull            = True
            Of C25_SQLITE3_TEXT
                Self.c25DbSqlObjectReturn.IsText            = True
            Else
                Self.c25DbSqlObjectReturn.IsDataTypeOther   = True
            End

            Case Self.c25DbSqlObjectReturn.Sqlite3ColumnTypeId
            Of C25_SQLITE_INTEGER
                Self.c25DbSqlObjectReturn.ColumnBytes       = c25_sqlite3_column_bytes(Self.c25DbSqlObjectReturn.StmtHandle, 0)
                Self.c25DbSqlObjectReturn.IntegerValue      = c25_sqlite3_column_int(Self.c25DbSqlObjectReturn.StmtHandle, 0)

                If Self.c25DbSqlObjectReturn.IntegerValue = 0
                    Self.c25DbSqlObjectReturn.IntegerIsZero = True
                End

                If Self.c25DbSqlObjectReturn.IntegerValue > -1
                    If Self.c25DbSqlObjectReturn.IntegerValue           < 128
                        Self.c25DbSqlObjectReturn.IntegerType       = DataTypeEnum:CSharp_Int8
                        Self.c25DbSqlObjectReturn.IsInt8            = True
                    ElsIf Self.c25DbSqlObjectReturn.IntegerValue        < 256
                        Self.c25DbSqlObjectReturn.IntegerType       = DataTypeEnum:CSharp_UInt8
                        Self.c25DbSqlObjectReturn.IsUInt8           = True
                    ElsIf Self.c25DbSqlObjectReturn.IntegerValue        =< Self.Int16MaxValue
                        Self.c25DbSqlObjectReturn.IntegerType       = DataTypeEnum:CSharp_Int16
                    ElsIf Self.c25DbSqlObjectReturn.IntegerValue        =< Self.UInt16MaxValue
                        Self.c25DbSqlObjectReturn.IntegerType       = DataTypeEnum:CSharp_UInt16
                    ElsIf Self.c25DbSqlObjectReturn.IntegerValue        =< Self.Int32MaxValue
                        Self.c25DbSqlObjectReturn.IntegerType       = DataTypeEnum:CSharp_Int32
                    ElsIf Self.c25DbSqlObjectReturn.IntegerValue        =< Self.UInt32MaxValue
                        Self.c25DbSqlObjectReturn.IntegerType       = DataTypeEnum:CSharp_UInt32
                    ElsIf Self.c25DbSqlObjectReturn.IntegerValue        =< Self.Int64MaxValue
                        Self.c25DbSqlObjectReturn.IntegerType       = DataTypeEnum:CSharp_Int64
                    ElsIf Self.c25DbSqlObjectReturn.IntegerValue        =< Self.UInt64MaxValue
                        Self.c25DbSqlObjectReturn.IntegerType       = DataTypeEnum:CSharp_UInt64
                    ELSE
                        Self.c25DbSqlObjectReturn.IntegerType       = DataTypeEnum:CSharp_Int32
                    End
                ElsIf Self.c25DbSqlObjectReturn.IntegerValue < 0
                    Self.c25DbSqlObjectReturn.IntegerIsNegative = True

                    If Self.c25DbSqlObjectReturn.IntegerValue           >= Self.Int16MinValue
                        Self.c25DbSqlObjectReturn.IntegerType       = DataTypeEnum:CSharp_Int16
                    ElsIf Self.c25DbSqlObjectReturn.IntegerValue        => Self.Int32MinValue
                        Self.c25DbSqlObjectReturn.IntegerType       = DataTypeEnum:CSharp_Int32
                    ElsIf Self.c25DbSqlObjectReturn.IntegerValue        => Self.Int64MinValue
                        Self.c25DbSqlObjectReturn.IntegerType       = DataTypeEnum:CSharp_Int64
                    ELSE
                        Self.c25DbSqlObjectReturn.IntegerType       = DataTypeEnum:CSharp_Int32
                    End
                End

            End
            Self.c25DbSqlObjectReturn.Success  = True
        End
        If Self.c25DbSqlObjectReturn.StmtHandle <> 0
            Self.ResultCode = c25_sqlite3_finalize(Self.c25DbSqlObjectReturn.StmtHandle)
            Self.c25DbSqlObjectReturn.StmtHandle = 0
        End
        Self.c25DbSqlObjectReturn.EndTime = Self.NanoClockClass.GetSysTime()
        Self.c25DbSqlObjectReturn.Duration = Self.c25DbSqlObjectReturn.EndTime - Self.c25DbSqlObjectReturn.StartTime

        If Omitted(_c25DbSqlObjectReturn) = False
            _c25DbSqlObjectReturn = Self.c25DbSqlObjectReturn
            Return Self.c25DbSqlObjectReturn
        End
        Message('Self.c25DbSqlObjectReturn.IntegerValue ' & Self.c25DbSqlObjectReturn.IntegerValue)

        V# = Self.c25DbSqlObjectReturn.IntegerValue
        Return V#

c25_SqliteClass.Get_ExtendedCodeInfo                            Procedure(<Long _errorCodeExtended>)

ShortDescription                                    cstring(1024)

    Code

        If Self.ConnHandle = 0
            Return ''
        End
        If OMITTED(_errorCodeExtended) = False
            Self.ErrorCodeExtended = _errorCodeExtended
        End
        Case Self.ErrorCodeExtended
        Of C25_SQLITE_ABORT_ROLLBACK
            ShortDescription = 'SQLITE ABORT ROLLBACK'
        Of C25_SQLITE_BUSY_RECOVERY
            ShortDescription = 'SQLITE BUSY RECOVERY'
        Of C25_SQLITE_BUSY_SNAPSHOT
            ShortDescription = 'SQLITE BUSY SNAPSHOT'
        Of C25_SQLITE_BUSY_TIMEOUT
            ShortDescription = 'SQLITE BUSY TIMEOUT'
        Of C25_SQLITE_CANTOPEN_CONVPATH
            ShortDescription = 'SQLITE CANTOPEN CONVPATH'
        Of C25_SQLITE_CANTOPEN_DIRTYWAL
            ShortDescription = 'SQLITE CANTOPEN DIRTYWAL'
        Of C25_SQLITE_CANTOPEN_FULLPATH
            ShortDescription = 'SQLITE CANTOPEN FULLPATH'
        Of C25_SQLITE_CANTOPEN_ISDIR
            ShortDescription = 'SQLITE CANTOPEN ISDIR'
        Of C25_SQLITE_CANTOPEN_NOTEMPDIR
            ShortDescription = 'SQLITE CANTOPEN NOTEMPDIR'
        Of C25_SQLITE_CANTOPEN_SYMLINK
            ShortDescription = 'SQLITE CANTOPEN SYMLINK'
        Of C25_SQLITE_CONSTRAINT_CHECK
            ShortDescription = 'SQLITE CONSTRAINT CHECK'
        Of C25_SQLITE_CONSTRAINT_COMMITHOOK
            ShortDescription = 'SQLITE CONSTRAINT COMMITHOOK'
        Of C25_SQLITE_CONSTRAINT_FOREIGNKEY
            ShortDescription = 'SQLITE CONSTRAINT FOREIGNKEY'
        Of C25_SQLITE_CONSTRAINT_FUNCTION
            ShortDescription = 'SQLITE CONSTRAINT FUNCTION'
        Of C25_SQLITE_CONSTRAINT_NOTNULL
            ShortDescription = 'SQLITE CONSTRAINT NOTNULL'
        Of C25_SQLITE_CONSTRAINT_PINNED
            ShortDescription = 'SQLITE CONSTRAINT PINNED'
        Of C25_SQLITE_CONSTRAINT_PRIMARYKEY
            ShortDescription = 'SQLITE CONSTRAINT PRIMARYKEY'
        Of C25_SQLITE_CONSTRAINT_ROWID
            ShortDescription = 'SQLITE CONSTRAINT ROWID'
        Of C25_SQLITE_CONSTRAINT_TRIGGER
            ShortDescription = 'SQLITE CONSTRAINT TRIGGER'
        Of C25_SQLITE_CONSTRAINT_UNIQUE
            ShortDescription = 'SQLITE CONSTRAINT UNIQUE'
        Of C25_SQLITE_CONSTRAINT_VTAB
            ShortDescription = 'SQLITE CONSTRAINT VTAB'
        Of C25_SQLITE_CORRUPT_INDEX
            ShortDescription = 'SQLITE CORRUPT INDEX'
        Of C25_SQLITE_CORRUPT_SEQUENCE
            ShortDescription = 'SQLITE CORRUPT SEQUENCE'
        Of C25_SQLITE_CORRUPT_VTAB
            ShortDescription = 'SQLITE CORRUPT VTAB'
        Of C25_SQLITE_ERROR_MISSING_COLLSEQ
            ShortDescription = 'SQLITE ERROR MISSING COLLSEQ'
        Of C25_SQLITE_ERROR_RETRY
            ShortDescription = 'SQLITE ERROR RETRY'
        Of C25_SQLITE_ERROR_SNAPSHOT
            ShortDescription = 'SQLITE ERROR SNAPSHOT'
        Of C25_SQLITE_IOERR_ACCESS
            ShortDescription = 'SQLITE IOERR ACCESS'
        Of C25_SQLITE_IOERR_AUTH
            ShortDescription = 'SQLITE IOERR AUTH'
        Of C25_SQLITE_IOERR_BEGIN_ATOMIC
            ShortDescription = 'SQLITE IOERR BEGIN ATOMIC'
        Of C25_SQLITE_IOERR_BLOCKED
            ShortDescription = 'SQLITE IOERR BLOCKED'
        Of C25_SQLITE_IOERR_CHECKRESERVEDLOCK
            ShortDescription = 'SQLITE IOERR CHECKRESERVEDLOCK'
        Of C25_SQLITE_IOERR_CLOSE
            ShortDescription = 'SQLITE IOERR CLOSE'
        Of C25_SQLITE_IOERR_COMMIT_ATOMIC
            ShortDescription = 'SQLITE IOERR COMMIT ATOMIC'
        Of C25_SQLITE_IOERR_CONVPATH
            ShortDescription = 'SQLITE IOERR CONVPATH'
        Of C25_SQLITE_IOERR_DATA
            ShortDescription = 'SQLITE IOERR DATA'
        Of C25_SQLITE_IOERR_DELETE
            ShortDescription = 'SQLITE IOERR DELETE'
        Of C25_SQLITE_IOERR_DELETE_NOENT
            ShortDescription = 'SQLITE IOERR DELETE NOENT'
        Of C25_SQLITE_IOERR_DIR_CLOSE
            ShortDescription = 'SQLITE IOERR DIR CLOSE'
        Of C25_SQLITE_IOERR_DIR_FSYNC
            ShortDescription = 'SQLITE IOERR DIR FSYNC'
        Of C25_SQLITE_IOERR_FSTAT
            ShortDescription = 'SQLITE IOERR FSTAT'
        Of C25_SQLITE_IOERR_FSYNC
            ShortDescription = 'SQLITE IOERR FSYNC'
        Of C25_SQLITE_IOERR_GETTEMPPATH
            ShortDescription = 'SQLITE IOERR GETTEMPPATH'
        Of C25_SQLITE_IOERR_LOCK
            ShortDescription = 'SQLITE IOERR LOCK'
        Of C25_SQLITE_IOERR_MMAP
            ShortDescription = 'SQLITE IOERR MMAP'
        Of C25_SQLITE_IOERR_NOMEM
            ShortDescription = 'SQLITE IOERR NOMEM'
        Of C25_SQLITE_IOERR_RDLOCK
            ShortDescription = 'SQLITE IOERR RDLOCK'
        Of C25_SQLITE_IOERR_READ
            ShortDescription = 'SQLITE IOERR READ'
        Of C25_SQLITE_IOERR_ROLLBACK_ATOMIC
            ShortDescription = 'SQLITE IOERR ROLLBACK ATOMIC'
        Of C25_SQLITE_IOERR_SEEK
            ShortDescription = 'SQLITE IOERR SEEK'
        Of C25_SQLITE_IOERR_SHMLOCK
            ShortDescription = 'SQLITE IOERR SHMLOCK'
        Of C25_SQLITE_IOERR_SHMMAP
            ShortDescription = 'SQLITE IOERR SHMMAP'
        Of C25_SQLITE_IOERR_SHMOPEN
            ShortDescription = 'SQLITE IOERR SHMOPEN'
        Of C25_SQLITE_IOERR_SHMSIZE
            ShortDescription = 'SQLITE IOERR SHMSIZE'
        Of C25_SQLITE_IOERR_SHORT_READ
            ShortDescription = 'SQLITE IOERR Short READ'
        Of C25_SQLITE_IOERR_TRUNCATE
            ShortDescription = 'SQLITE IOERR TRUNCATE'
        Of C25_SQLITE_IOERR_UNLOCK
            ShortDescription = 'SQLITE IOERR UNLOCK'
        Of C25_SQLITE_IOERR_VNODE
            ShortDescription = 'SQLITE IOERR VNODE'
        Of C25_SQLITE_IOERR_WRITE
            ShortDescription = 'SQLITE IOERR WRITE'
        Of C25_SQLITE_LOCKED_SHAREDCACHE
            ShortDescription = 'SQLITE LOCKED SHAREDCACHE'
        Of C25_SQLITE_LOCKED_VTAB
            ShortDescription = 'SQLITE LOCKED VTAB'
        Of C25_SQLITE_NOTICE_RECOVER_ROLLBACK
            ShortDescription = 'SQLITE NOTICE RECOVER ROLLBACK'
        Of C25_SQLITE_NOTICE_RECOVER_WAL
            ShortDescription = 'SQLITE NOTICE RECOVER WAL'
        Of C25_SQLITE_OK_LOAD_PERMANENTLY
            ShortDescription = 'SQLITE OK LOAD PERMANENTLY'
        Of C25_SQLITE_READONLY_CANTINIT
            ShortDescription = 'SQLITE READONLY CANTINIT'
        Of C25_SQLITE_READONLY_CANTLOCK
            ShortDescription = 'SQLITE READONLY CANTLOCK'
        Of C25_SQLITE_READONLY_DBMOVED
            ShortDescription = 'SQLITE READONLY DBMOVED'
        Of C25_SQLITE_READONLY_DIRECTORY
            ShortDescription = 'SQLITE READONLY DIRECTORY'
        Of C25_SQLITE_READONLY_RECOVERY
            ShortDescription = 'SQLITE READONLY RECOVERY'
        Of C25_SQLITE_READONLY_ROLLBACK
            ShortDescription = 'SQLITE READONLY ROLLBACK'
        Of C25_SQLITE_WARNING_AUTOINDEX
            ShortDescription = 'SQLITE WARNING AUTOINDEX'
        Else
            ShortDescription = 'SQLITE UNKNOWN'
        End
        Return ShortDescription

c25_SqliteClass.Out_InitTurbo                                   Procedure(*QUEUE _queue, <string _tableName>, <string _sql>)

CODE

    !Self.StLog.SetValue('start Out_InitTurbo' & Chr(13) & Chr(10))
    !Self.StLog.SaveFile('m:\c25_SqliteClass_log.txt', true)
    If _queue &= NULL
        !Message('error _queue is null')
        !Self.StLog.SetValue('error _queue is null' & Chr(13) & Chr(10))
        !Self.StLog.SaveFile('m:\c25_SqliteClass_log.txt', true)
    End

    Free(Self.Out_Sqlite3ColumnMeta)

    Self.Out_Q &= _queue
    Self.Out_Q_Address = Address(Self.Out_Q)

    Self.Out_QueueRecordStringLen             = Size(Self.Out_Q)
    If not Self.Out_QueueRecordString &= NULL
        Dispose(Self.Out_QueueRecordString)
    End
    Self.Out_QueueRecordString                &= NEW String(Self.Out_QueueRecordStringLen)
    Self.Out_QueueRecordStringAddress         = Address(Self.Out_QueueRecordString)
    Self.Out_st1.Start()
    Self.Out_Reflection.Analyze(Self.Out_Q, Self.Out_ClarionFields)
    Self.Out_FieldsCount = Records(Self.Out_ClarionFields)

    If omitted(_tableName) = False
        Self.Out_TableName = _tableName
    END

    If omitted(_sql) = False
        Self.Out_SqlStatementSelectHandle = Self.CreateSelectPrepareSql(_sql, Self.Out_ClarionFields, Self.Out_TableName)
    Else
        Self.Out_SqlStatementSelectHandle = Self.CreateSelectPrepareSql( , Self.Out_ClarionFields, Self.Out_TableName)
    End
    
    !Self.StLog.SetValue('Out_InitTurbo, Self.Out_FieldsCount ' & Self.Out_FieldsCount & Chr(13) & Chr(10))
    !Self.StLog.SaveFile('m:\c25_SqliteClass_log.txt', true)
    !Self.StLog.SetValue('Out_InitTurbo, Self.Out_TableName ' & Self.Out_TableName & Chr(13) & Chr(10))
    !Self.StLog.SaveFile('m:\c25_SqliteClass_log.txt', true)
    !Self.StLog.SetValue('Out_InitTurbo, Self.Out_SqlStatementSelectHandle: ' & Self.Out_SqlStatementSelectHandle & Chr(13) & Chr(10))
    !Self.StLog.SaveFile('m:\c25_SqliteClass_log.txt', true)
        

    Return Self.Out_SqlStatementSelectHandle

c25_SqliteClass.CreateSelectPrepareSql                          Procedure(<string _sql>, <ClarionFields_TYPE _clarionFields> , <string _tableName>)

st          &StringTheory()
F           Long
Handle      Long

CODE

    st &= NEW StringTheory()
    st.Start()

    If omitted(_clarionFields) = False
        If _clarionFields &= null
            !Self.StLog.SetValue('error _clarionFields is null' & Chr(13) & Chr(10))
            !Self.StLog.SaveFile('m:\c25_SqliteClass_log.txt', true)            
        End        
        
        st.Append('SELECT ')
        F = 0
        Loop
            F = F + 1
            Get(_clarionFields, F)

            Case F
            Of Records(_clarionFields)
                If F = 1
                    st.Append(' [' & _clarionFields.Name & ']')
                Else
                    st.Append(' [' & _clarionFields.Name & ']')
                End
                Break
            Of 1
                st.Append(' [' & _clarionFields.Name & '], ')
            Else
                st.Append(' [' & _clarionFields.Name & '], ')
            End
        End
        st.Append(' FROM ' & _tableName)
    ElsIf omitted(_tableName) = False
        st.Append('SELECT * FROM ' & _tableName)        
    ElsIf omitted(_sql) = False
        st.Append(_sql)
    End
    st.Append(Chr(0))
    
    !Self.StLog.SetValue('R# = c25_sqlite3_prepare_v2 SQL: ' & st.GetValue() & Chr(13) & Chr(10))
    !Self.StLog.SaveFile('m:\c25_SqliteClass_log.txt', true)    
    
    
    R# = c25_sqlite3_prepare_v2(Self.ConnHandle, st.GetAddress(), st.Length(), Address(Handle),0)
    If R# <> C25_SQLITE_OK
        Self.ErrorCodeExtended = c25_sqlite3_extended_errcode(Self.ConnHandle)
        !Message('ERROR at : c25_sqlite3_prepare_v2, ' & st.GetValue() )
        !Self.StLog.SetValue('ERROR R# = c25_sqlite3_prepare_v2 Self.ErrorCodeExtended : ' & Self.ErrorCodeExtended & Chr(13) & Chr(10))
        !Self.StLog.SaveFile('m:\c25_SqliteClass_log.txt', true)              
    Else
        !Self.StLog.SetValue('OK R# = c25_sqlite3_prepare_v2 Handle: ' & Handle & Chr(13) & Chr(10))
        !Self.StLog.SaveFile('m:\c25_SqliteClass_log.txt', true)        
    End
    
    
    st.Start()
    Dispose(st)

    !!Self.StLog.SetValue('R# = c25_sqlite3_prepare_v2: ' & st.GetValue() & Chr(13) & Chr(10))
    !!Self.StLog.SaveFile('m:\c25_SqliteClass_log.txt', true)          
    
    Return Handle

c25_SqliteClass.In_InitTurbo                                    Procedure(*QUEUE _queue, string _tableName, <bool _noAutoIncrement>)

CODE

    If omitted(_noAutoIncrement) = False And _noAutoIncrement = True
        Self.In_AutoIncrement = False
    Else
        Self.In_AutoIncrement = True
    End

    Free(Self.In_Sqlite3ColumnMeta)

    Self.In_Q &= _queue
    Self.In_Q_Address = Address(Self.In_Q)

    Self.In_QueueRecordStringLen             = Size(Self.In_Q)
    Self.In_QueueRecordString                &= NEW String(Self.In_QueueRecordStringLen)
    Self.In_QueueRecordStringAddress         = Address(Self.In_QueueRecordString)
    Self.In_DummyStringStr8_Address          = Address(Self.In_DummyStringStr8)

    Self.In_st1.Start()
    Self.stSqlStatementInsert.Start()

    Free(Self.In_Reflection.ClarionFields)
    Free(Self.In_ClarionFields)

    Self.In_Reflection.Analyze(Self.In_Q, Self.In_ClarionFields)
    Self.In_FieldsCount = Records(Self.In_ClarionFields)

    If Self.In_AutoIncrement = True
        Self.In_FieldsCountStmtInsert = Self.In_FieldsCount -1

        Self.In_F_INIT = 1
    ELSE
        Self.In_FieldsCountStmtInsert = Self.In_FieldsCount
        Self.In_F_INIT = 0
    End

    If Len(Clip(Self.In_TablePrefix)) > 0
        Self.In_TableName = Clip(Self.In_TablePrefix) & _tableName
    Else
        Self.In_TableName = _tableName
    End

    Self.In_SqlStatementInsertHandle = Self.CreateInsertPrepareSql( , Self.In_ClarionFields, Self.In_TableName)

    Self.GetTableMetaInfoAsync( , Self.In_ClarionFields, Self.In_TableName, Self.In_Sqlite3ColumnMeta)

    Return 0

c25_SqliteClass.CreateInsertPrepareSql                          Procedure(<string _sql>, <ClarionFields_TYPE _clarionFields>, <string _tableName>)

Handle long

CODE

    Self.stSqlStatementInsert.Start()
    Self.stSqlStatementInsert.Append('INSERT INTO ' & Self.In_TableName & ' (')

    Self.In_F = Self.In_F_INIT

    Loop Self.In_FieldsCountStmtInsert Times
        Self.In_F = Self.In_F + 1
        Get(Self.In_ClarionFields,Self.In_F)

        Case Self.In_F
        Of Self.In_FieldsCount
            If Self.In_F = Self.In_F_INIT
                Self.stSqlStatementInsert.Append(' [' & Self.In_ClarionFields.Name & ']')
            Else
                Self.stSqlStatementInsert.Append(' [' & Self.In_ClarionFields.Name & ']')
            End
            Break
        Of 1 + Self.In_F_INIT
            Self.stSqlStatementInsert.Append(' [' & Self.In_ClarionFields.Name & '], ')
        Else
            Self.stSqlStatementInsert.Append(' [' & Self.In_ClarionFields.Name & '], ')
        End
    End
    Self.stSqlStatementInsert.Append(') Values(')

    Self.In_F = Self.In_F_INIT

    Loop Self.In_FieldsCountStmtInsert Times
        Self.In_F = Self.In_F + 1
        Get(Self.In_ClarionFields,Self.In_F)

        Case Self.In_F
        Of Self.In_FieldsCount
            If Self.In_F = Self.In_F_INIT
                Self.stSqlStatementInsert.Append(' @p' & Self.In_F - Self.In_F_INIT)
            ELSE
                Self.stSqlStatementInsert.Append(', @p' & Self.In_F - Self.In_F_INIT)
            End
            Self.stSqlStatementInsert.Append(' );')
            BREAK
        Of 1 + Self.In_F_INIT
            Self.stSqlStatementInsert.Append(' @p' & Self.In_F - Self.In_F_INIT)
        Else
            Self.stSqlStatementInsert.Append(', @p' & Self.In_F - Self.In_F_INIT)
        End
    End
    Self.stSqlStatementInsert.Append(Chr(0))

    Self.In_SQLITE_API_RETURN = c25_sqlite3_prepare_v2(Self.ConnHandle,Self.stSqlStatementInsert.GetAddress(),Self.stSqlStatementInsert.Length(),Address(Self.In_SqlStatementInsertHandle),0)
    If Self.In_SQLITE_API_RETURN <> C25_SQLITE_OK
        Self.ErrorCodeExtended = c25_sqlite3_extended_errcode(Self.ConnHandle)
        Message('ERROR at : c25_sqlite3_prepare_v2, ' & Self.stSqlStatementInsert.GetValue() )
        Return ''
    Else
    End

    Return Self.In_SqlStatementInsertHandle

c25_SqliteClass.InsertAllAsync                                  Procedure(<bool inTransaction>, <bool _postInsertRemove>)

T_DummyString                                                               Group,Pre(T_DummyString)
DummyString                                                                     &String
                                                                            End
ZERO8          STRING(8)

Code

    If inTransaction = True
        Self.Exec(, 'BEGIN TRANSACTION;')
    End

    Clear(ZERO8,-1)

    If Self.In_Q &= NULL
        Return 0
    End
    Self.In_Q_Count = Records(Self.In_Q)

    If Self.In_Q_Count = 0
        Return 0
    End

    If omitted(_postInsertRemove) = False And _postInsertRemove = True
        Self.In_PostInsertRemove = True
    ELSE
        Self.In_PostInsertRemove = False
    End

    If Self.In_AutoIncrement
        c25_sqlite3_bind_null(Self.In_SqlStatementInsertHandle, 1)
    End

    Self.In_QIndex = 0
    Loop
        Self.In_QIndex = Self.In_QIndex + 1
        Get(Self.In_Q, Self.In_QIndex)
        If Errorcode() <> 0
            BREAK
        End

        Self.In_F = Self.In_F_INIT
        Self.In_BindIndex = 0
        Loop Self.In_FieldsCountStmtInsert Times
            Self.In_F = Self.In_F + 1
            Self.In_BindIndex = Self.In_BindIndex + 1

            Get(Self.In_ClarionFields, Self.In_F)
            Self.In_CurrentFieldAny &= WHAT(Self.In_Q, Self.In_F)

            If Self.In_ClarionFields.IsRef = True
                Self.In_AddressAndSizeFromAny = Self.In_CurrentFieldAny
                Self.In_PtrString &= Self.In_AdrGroup.PtrAddress & ':' & Self.In_AdrGroup.PtrSize
                If Self.In_AdrGroup.PtrAddress = 0 Or Self.In_AdrGroup.PtrSize = 0
                    c25_sqlite3_bind_null(Self.In_SqlStatementInsertHandle, Self.In_BindIndex)
                    Cycle
                End
            End

            Case Self.In_ClarionFields.DataTypeEnum
            Of DataTypeEnum:CLA_LONG
            OrOf DataTypeEnum:CLA_ULONG
            OrOf DataTypeEnum:CLA_SHORT
            OrOf DataTypeEnum:CLA_USHORT
            OrOf DataTypeEnum:CLA_BYTE
            OrOf DataTypeEnum:SQLITE_INT
            OrOf DataTypeEnum:SQLITE_INTEGER
            OrOf DataTypeEnum:SQLITE_TINYINT
            OrOf DataTypeEnum:SQLITE_SMALLINT
            OrOf DataTypeEnum:SQLITE_MEDIUMINT
            OrOf DataTypeEnum:SQLITE_INT1
            OrOf DataTypeEnum:SQLITE_INT2
            OrOf DataTypeEnum:SQLITE_INT4
            OrOf DataTypeEnum:SQLITE_INT4
                Self.In_IntVal = Self.In_CurrentFieldAny
                c25_sqlite3_bind_int(Self.In_SqlStatementInsertHandle, Self.In_BindIndex, Self.In_IntVal)
            Of DataTypeEnum:CLA_STRING
            OrOf DataTypeEnum:CLA_CSTRING
            OrOf DataTypeEnum:SQLITE_CHARACTER
            OrOf DataTypeEnum:SQLITE_VARCHAR
            OrOf DataTypeEnum:SQLITE_VARYING_CHARACTER
            OrOf DataTypeEnum:SQLITE_NCHAR
            OrOf DataTypeEnum:SQLITE_NATIVE_CHARACTER
            OrOf DataTypeEnum:SQLITE_NVARCHAR
            OrOf DataTypeEnum:SQLITE_TEXT
                If Self.In_ClarionFields.IsRef = True
                    c25_sqlite3_bind_text16(Self.In_SqlStatementInsertHandle, Self.In_BindIndex, Self.In_AdrGroup.PtrAddress, Self.In_AdrGroup.PtrSize, C25_SQLITE_TRANSIENT)
                Else
                    c25_sqlite3_bind_text16( Self.In_SqlStatementInsertHandle, Self.In_BindIndex, Address(Self.In_CurrentFieldAny), Size(Self.In_CurrentFieldAny), C25_SQLITE_TRANSIENT)
                End
            Of DataTypeEnum:CLA_BLOB
            OrOf DataTypeEnum:SQLITE_BLOB
                If Self.In_ClarionFields.IsRef = True
                    c25_sqlite3_bind_blob(Self.In_SqlStatementInsertHandle, Self.In_BindIndex, Self.In_AdrGroup.PtrAddress, Self.In_AdrGroup.PtrSize, C25_SQLITE_TRANSIENT)
                Else
                    c25_sqlite3_bind_blob( Self.In_SqlStatementInsertHandle, Self.In_BindIndex, Address(Self.In_CurrentFieldAny), Size(Self.In_CurrentFieldAny), C25_SQLITE_TRANSIENT)
                End
            Else
                c25_sqlite3_bind_text(Self.In_SqlStatementInsertHandle, Self.In_BindIndex, Address(Self.In_CurrentFieldAny), Size(Self.In_CurrentFieldAny), C25_SQLITE_TRANSIENT)
            End
        End

        If c25_sqlite3_step(Self.In_SqlStatementInsertHandle) <> C25_SQLITE_DONE
            Self.ErrorCodeExtended = c25_sqlite3_extended_errcode(Self.ConnHandle)
            Message('ERROR at : c25_sqlite3_step Self.In_SQLITE_API_RETURN: ' & Self.ConnHandle & ', ' & Self.In_SqlStatementInsertHandle & ', ' & Self.In_SQLITE_API_RETURN & ', ' & Self.ErrorCodeExtended & ', ' & Self.GeT_ExtendedCodeInfo())

            Self.In_SQLITE_API_RETURN = c25_sqlite3_reset(Self.In_SqlStatementInsertHandle)
        End
        Self.In_SQLITE_API_RETURN = c25_sqlite3_reset(Self.In_SqlStatementInsertHandle)
        Self.In_SQLITE_API_RETURN = c25_sqlite3_clear_bindings(Self.In_SqlStatementInsertHandle)

        If Self.In_PostInsertRemove

            Self.In_F = Self.In_F_INIT
            Loop Self.In_FieldsCountStmtInsert Times
                Self.In_F = Self.In_F + 1
                Get(Self.In_ClarionFields, Self.In_F)
                If Self.In_ClarionFields.IsRef = FALSE
                    CYCLE
                End
                C25_Memcpy( Self.In_DummyStringStr8_Address  , Self.In_Q_Address + Self.In_ClarionFields.Offset ,8)
                Self.In_StringRefGrp = Self.In_DummyStringStr8

                If NOT Self.In_StringRefGrp.StringRef &= NULL
                    Dispose(Self.In_StringRefGrp.StringRef)
                End
            End
        End
    End
    If inTransaction = True
        Self.Exec(, 'COMMIT;')
    End
    If Self.In_PostInsertRemove
        Free(Self.In_Q)
    End
    Self.In_SQLITE_API_RETURN = c25_sqlite3_reset(Self.In_SqlStatementInsertHandle)
    Self.In_SQLITE_API_RETURN = c25_sqlite3_clear_bindings(Self.In_SqlStatementInsertHandle)

    Return 0

c25_SqliteClass.GetTableMetaInfoAsync                           Procedure(<string _sql>, <ClarionFields_TYPE _clarionFieldsMapping>, <string _tableName> , Sqlite3ColumnMeta_TYPE _sqlite3ColumnMetaOut )

PrepHandle    Long

CODE

    If omitted(_sql) = False
        PrepHandle = Self.CreateSelectPrepareSql(_sql)
    Else
        PrepHandle = Self.CreateSelectPrepareSql('select * from ' & _tableName & ' where 0 > 1')
    End

    Free(_sqlite3ColumnMetaOut)

    Self.In_SqlColumnCount = c25_sqlite3_column_count(PrepHandle)

    Self.In_Index = -1
    Loop Self.In_SqlColumnCount Times
        Self.In_Index = Self.In_Index + 1

        _sqlite3ColumnMetaOut.Index = Self.In_Index

        Self.In_TextPtr = c25_sqlite3_column_name(PrepHandle, Self.In_Index)
        If Self.In_TextPtr <> 0
            _sqlite3ColumnMetaOut.Name &= Self.BitConverter.ParseZeroTerminatedStringAToRef(Self.In_TextPtr, True)
        End
        _sqlite3ColumnMetaOut.DataTypeNativeEnum = c25_sqlite3_column_type(PrepHandle, Self.In_Index)
        Case _sqlite3ColumnMetaOut.DataTypeNativeEnum
        Of Sqlite3DataTypeEnum:INTEGER
            _sqlite3ColumnMetaOut.DataTypeNative &= Self.BitConverter.BinaryCopy('INTEGER')
        Of Sqlite3DataTypeEnum:FLOAT
            _sqlite3ColumnMetaOut.DataTypeNative &= Self.BitConverter.BinaryCopy('FLOAT')
        Of Sqlite3DataTypeEnum:TEXT
            _sqlite3ColumnMetaOut.DataTypeNative &= Self.BitConverter.BinaryCopy('TEXT')
        Of Sqlite3DataTypeEnum:BLOB
            _sqlite3ColumnMetaOut.DataTypeNative &= Self.BitConverter.BinaryCopy('BLOB')
        Of Sqlite3DataTypeEnum:NULL
            _sqlite3ColumnMetaOut.DataTypeNative &= Self.BitConverter.BinaryCopy('NULL')
        Else
            _sqlite3ColumnMetaOut.DataTypeNative &= Self.BitConverter.BinaryCopy('UNKNOWN')
        End
        Add(_sqlite3ColumnMetaOut)
    End
    c25_sqlite3_finalize(PrepHandle)
    Return 0

c25_SqliteClass.QueryAsync                                      Procedure(*QUEUE _qOutput, <string _tableName>, <string _sql>)

CODE

    
    
    If _qOutput &= NULL
        Return 0
    End

    !Message('start QueryAsync')
!    If omitted(_tableName) = True and omitted(_sql) = True
!        Self.Out_InitTurbo(_qOutput)
!    ElsIf omitted(_tableName) = False
!        If omitted(_sql) = False
!            Self.Out_InitTurbo(_qOutput, ,_sql)
!        ElsIf omitted(_tableName) = False
!            Self.Out_InitTurbo(_qOutput, _tableName,)
!        ELSE
!            Self.Out_InitTurbo(_qOutput, _tableName, _sql)
!        End
!    End

    If omitted(_sql) = False
        Self.Out_SqlStatementSelectHandle = Self.CreateSelectPrepareSql(_sql)
    Else
        Self.Out_SqlStatementSelectHandle = Self.CreateSelectPrepareSql(, Self.Out_ClarionFields, Self.Out_TableName)
    End

    !Message('Self.Out_SqlStatementSelectHandle: ' & Self.Out_SqlStatementSelectHandle)
    !Message('Out_TableName : ' & Self.Out_TableName)


    !Self.StLog.SetValue('Self.Out_SqlStatementSelectHandle: ' & Self.Out_SqlStatementSelectHandle & Chr(13) & Chr(10))
    !Self.StLog.SaveFile('m:\c25_SqliteClass_log.txt', true)
    
    
    
    
    Self.Out_QoutputAddress = Address(_qOutput)

    If NOT Self.Out_FieldValueStringRef &= NULL
        Dispose(Self.Out_FieldValueStringRef)
    End

    Self.Out_RetrievedCount = 0
    Loop
        Self.ResultCode = c25_sqlite3_step(Self.Out_SqlStatementSelectHandle)
        Case Self.ResultCode
        Of C25_SQLITE_ROW
            Clear(_qOutput)
            Add(_qOutput)            
            Self.Out_ColIndex = 0
            Self.Out_SourceIndex = -1
            Loop Self.Out_FieldsCount Times
                Self.Out_ColIndex = Self.Out_ColIndex + 1
                Self.Out_SourceIndex = Self.Out_SourceIndex + 1
                Get(Self.Out_ClarionFields, Self.Out_ColIndex)
                
                Self.Out_ColumnType = c25_sqlite3_column_type(Self.Out_SqlStatementSelectHandle, Self.Out_SourceIndex)
                Self.Out_ColumnValInt4 = 0
                
                Case Self.Out_ColumnType
                Of Sqlite3DataTypeEnum:INTEGER
                    Self.Out_ColumnBytes = c25_sqlite3_column_bytes(Self.Out_SqlStatementSelectHandle, Self.Out_SourceIndex)
                    If Self.Out_ColumnBytes < 5
                        Self.Out_ColumnValInt4 = c25_sqlite3_column_int(Self.Out_SqlStatementSelectHandle, Self.Out_SourceIndex)

                    ELSE
                        
                    End

                    Case Self.Out_ClarionFields.DataTypeEnum
                    Of DataTypeEnum:CLA_BYTE
                    OrOf DataTypeEnum:MSSQL_BIT
                    OrOf DataTypeEnum:MSSQL_TINYINT
                    OrOf DataTypeEnum:SQLC_BIT
                    OrOf DataTypeEnum:SQLC_TINYINT
                    OrOf DataTypeEnum:SQLC_UTINYINT
                    OrOf DataTypeEnum:CSHARP_Int1
                    OrOf DataTypeEnum:SQLITE_TINYINT
                    OrOf DataTypeEnum:SQLITE_INT1
                    OrOf DataTypeEnum:SQLITE_BOOLEAN
                        
                        Self.Out_ColumnValInt1 = Self.Out_ColumnValInt4
                        c25_MemCpy(Self.Out_QoutputAddress + Self.Out_ClarionFields.Offset,Self.Out_ColumnValInt1Address, 1)

                        
                    Of DataTypeEnum:CLA_SHORT
                    OrOf DataTypeEnum:CSHARP_Int16
                    OrOf DataTypeEnum:SQLC_SHORT
                        Self.Out_ColumnValInt2 = Self.Out_ColumnValInt4
                        c25_MemCpy(Self.Out_QoutputAddress + Self.Out_ClarionFields.Offset,Self.Out_ColumnValInt2Address, 2)
                        
                    Of DataTypeEnum:CLA_USHORT
                    OrOf DataTypeEnum:CSHARP_UInt16
                    OrOf DataTypeEnum:SQLC_USHORT
                        Self.Out_ColumnValUInt2 = Self.Out_ColumnValInt4
                        c25_MemCpy(Self.Out_QoutputAddress + Self.Out_ClarionFields.Offset,Self.Out_ColumnValUInt2Address, 2)
                    
                    Of DataTypeEnum:CLA_LONG
                    OrOf DataTypeEnum:CSHARP_Int32
                    OrOf DataTypeEnum:SQLC_LONG
                        c25_MemCpy(Self.Out_QoutputAddress + Self.Out_ClarionFields.Offset,Self.Out_ColumnValInt4Address, 4)
                        
                    Of DataTypeEnum:CLA_ULONG
                    OrOf DataTypeEnum:CSHARP_UInt32
                    OrOf DataTypeEnum:SQLC_ULONG
                        Self.Out_ColumnValUInt4 = Self.Out_ColumnValInt4
                        c25_MemCpy(Self.Out_QoutputAddress + Self.Out_ClarionFields.Offset,Self.Out_ColumnValUInt4Address, 4)
                        
                    End

                Of Sqlite3DataTypeEnum:FLOAT

                Of Sqlite3DataTypeEnum:TEXT
                    Case Self.Out_ClarionFields.DataTypeEnum
                    Of DataTypeEnum:CLA_STRING
                        If Self.ClarionFieldPropertyAndValueExist(Self.Out_ClarionFields, 'Line', 'encoding', 'utf16' , true)
                        !If Self.ClarionFieldPropertyExist(Self.Out_ClarionFields, 'Line', 'encoding', 'utf16' , true)
                            !Message('yes utf16')
                            Self.Out_ColumnBytes = c25_sqlite3_column_bytes16(Self.Out_SqlStatementSelectHandle, Self.Out_SourceIndex)
                            Self.Out_TextPtr = c25_sqlite3_column_text16(Self.Out_SqlStatementSelectHandle, Self.Out_SourceIndex)      
                        Else
                            Self.Out_ColumnBytes = c25_sqlite3_column_bytes(Self.Out_SqlStatementSelectHandle, Self.Out_SourceIndex)
                            Self.Out_TextPtr = c25_sqlite3_column_text(Self.Out_SqlStatementSelectHandle, Self.Out_SourceIndex)    
                        End
                        If Self.Out_ClarionFields.IsRef
                            Self.ApplyStringRef(Self.Out_QoutputAddress + Self.Out_ClarionFields.Offset, Self.Out_TextPtr, Self.Out_ColumnBytes)
                        Else
                            Self.ApplyString(Self.Out_QoutputAddress + Self.Out_ClarionFields.Offset, Self.Out_TextPtr, Self.Out_ColumnBytes, Self.Out_ClarionFields.SizeBytes)
                        End
                    Of DataTypeEnum:CLA_CSTRING
                        Self.Out_ColumnBytes = c25_sqlite3_column_bytes(Self.Out_SqlStatementSelectHandle, Self.Out_SourceIndex)
                        Self.Out_TextPtr = c25_sqlite3_column_text(Self.Out_SqlStatementSelectHandle, Self.Out_SourceIndex)                        
                        If Self.Out_ClarionFields.IsRef
                            Self.ApplyStringRef(Self.Out_QoutputAddress + Self.Out_ClarionFields.Offset, Self.Out_TextPtr, Self.Out_ColumnBytes)
                        Else
                            Self.ApplyCString(Self.Out_QoutputAddress + Self.Out_ClarionFields.Offset, Self.Out_TextPtr, Self.Out_ColumnBytes, Self.Out_ClarionFields.SizeBytes)
                        End                        
                            
                        !Self.Out_Text &= NEW STRING(
!                        Self.Out_ColumnBytes = c25_sqlite3_column_bytes16(Self.Out_SqlStatementSelectHandle, Self.Out_SourceIndex)
!                        Self.Out_TextPtr = c25_sqlite3_column_text16(Self.Out_SqlStatementSelectHandle, Self.Out_SourceIndex)
                    End

                Of Sqlite3DataTypeEnum:BLOB

                Of Sqlite3DataTypeEnum:NULL

                Else

                End
            End
            Self.Out_RetrievedCount = Self.Out_RetrievedCount + 1
            Put(_qOutput)
            
        Of C25_SQLITE_DONE
            BREAK
        Of C25_SQLITE_BUSY
        OrOf C25_SQLITE_BUSY_RECOVERY
        OrOf C25_SQLITE_BUSY_SNAPSHOT
        OrOf C25_SQLITE_LOCKED
            c25_SleepEx(50,0)
            Cycle
        Else
            Message('step unknown error: ' & Self.ResultCode)
            BREAK
        End
        
    End
    !Message('done QueryAsync')

    Return 0
    
c25_SqliteClass.ApplyStringRef                                  Procedure(long _targetAddress, long _textPtr, long _columnBytes)

StringRef &String

CODE 

    If _columnBytes > 0
        StringRef &= NEW STRING(_columnBytes)
        Self.Out_StringRefGrp.StringRef &= NEW String(_columnBytes)
        C25_Memcpy(Address(Self.Out_StringRefGrp.StringRef), _textPtr, _columnBytes) 

        Self.AnyField &= What(Self.Out_StringRefGrp,1)
        Self.Out_AddressAndSizeFromAny = Self.AnyField
        
        C25_Memcpy(_targetAddress, Address(Self.Out_AddressAndSizeFromAny), 8)
    ELSE
    End
    Return 0
    
c25_SqliteClass.ApplyString                                     Procedure(long _targetAddress, long _textPtr, long _columnBytes, long _claBytes)

CODE 

    If _columnBytes > 0
        If _columnBytes =< _claBytes
            C25_Memcpy(_targetAddress, _textPtr, _columnBytes)
        ElsIf _columnBytes > _claBytes
            C25_Memcpy(_targetAddress, _textPtr, _claBytes)
        End
    End
    Return 0
    
c25_SqliteClass.ApplyCString                                    Procedure(long _targetAddress, long _textPtr, long _columnBytes, long _claBytes)

CODE 

    If _columnBytes > 0
        If _columnBytes =< _claBytes
            C25_Memcpy(_targetAddress, _textPtr, _columnBytes)
        ElsIf _columnBytes > _claBytes
            C25_Memcpy(_targetAddress, _textPtr, _claBytes)
        End
        If _columnBytes < _claBytes
            C25_Memcpy(_targetAddress + _columnBytes + 1, Self.ZeroAddress, 1)
        End
    Else
        C25_Memcpy(_targetAddress, Self.ZeroAddress, 1)
    End
    Return 0
    
c25_SqliteClass.SetClarionFieldProperty                         Procedure(*ClarionFields_TYPE _clarionFields, string _fieldName, string _key, string _value, <long _dataType>)

I                                                               Long
I2                                                              Long
F                                                               BOOL

Code

    If _clarionFields &= NULL
        Return 0
    End
    !P# = Pointer(_clarionFields)
    I = 0
    LOOP
        I = I + 1
        Get(_clarionFields,I)
        If Errorcode() <> 0
            BREAK
        END
        If Upper(Clip(_clarionFields.Name)) = Upper(Clip(_fieldName))
            If _clarionFields.KeyValues &= NULL
                _clarionFields.KeyValues &= NEW KeyValue_TYPE()
            End
            
            I2 = 0
            LOOP
                I2 = I2 + 1
                Get(_clarionFields.KeyValues,I2)
                If Errorcode() <> 0
                    BREAK
                END
                
                If _clarionFields.KeyValues.Key &= NULL
                    CYCLE
                END
                If Upper(Clip(_clarionFields.KeyValues.Key)) = Upper(Clip(_key))
                    If _clarionFields.KeyValues.Value &= NULL
                        _clarionFields.KeyValues.Value &= NEW STRING(SIZE(_value))
                        _clarionFields.KeyValues.Value = _value
                        Put(_clarionFields)
                    Else
                        If Upper(Clip( _clarionFields.KeyValues.Value)) <> Upper(Clip(_value)) 
                            Dispose(_clarionFields.KeyValues.Value)
                            _clarionFields.KeyValues.Value &= NEW STRING(SIZE(_value))
                            _clarionFields.KeyValues.Value = _value           
                            Put(_clarionFields)
                        End
                    End
                    F = TRUE
                    Break
                End
            End
            If F = 0
                _clarionFields.KeyValues.Key &= NEW STRING(SIZE(_key))
                _clarionFields.KeyValues.Key = _key
                
                _clarionFields.KeyValues.Value &= NEW STRING(SIZE(_value))
                _clarionFields.KeyValues.Value = _value

                Add(_clarionFields.KeyValues)
            End
            Break
        End
    End
    !Get(_clarionFields,P#)
    return 0

c25_SqliteClass.GetClarionFieldProperty                         Procedure(*ClarionFields_TYPE _clarionFields, string _fieldName, string _key, <string _defaultValue>, <bool reGetPointer>)

I                                                               Long
I2                                                              Long
F                                                               BOOL

Code

    If _clarionFields &= NULL
        Return 0
    END
    P# = Pointer(_clarionFields)
    I = 0
    LOOP
        I = I + 1
        Get(_clarionFields,I)
        If Errorcode() <> 0
            BREAK
        END
        If Upper(Clip(_clarionFields.Name)) = Upper(Clip(_fieldName))
            If _clarionFields.KeyValues &= NULL
                _clarionFields.KeyValues &= NEW KeyValue_TYPE()
            End
            
            I2 = 0
            LOOP
                I2 = I2 + 1
                Get(_clarionFields.KeyValues,I2)
                If Errorcode() <> 0
                    BREAK
                END
                
                If _clarionFields.KeyValues.Key &= NULL
                    CYCLE
                END
                If Upper(Clip(_clarionFields.KeyValues.Key)) = Upper(Clip(_key))
                    If _clarionFields.KeyValues.Value &= NULL
                        If omitted(_defaultValue) = FALSE
                            Return _defaultValue
                        End
                        Return ''
                    End
                    If reGetPointer = True
                        Self.StProperty.Start()
                        Self.StProperty.SetValue(_clarionFields.KeyValues.Value)
                        Get(_clarionFields,P#)
                        Return Self.StProperty.GetValue()
                    End
                    Return _clarionFields.KeyValues.Value
                End
            End
            If omitted(_defaultValue) = FALSE
                If reGetPointer = True
                    Self.StProperty.Start()
                    Self.StProperty.SetValue(_defaultValue)
                    Get(_clarionFields,P#)
                    Return Self.StProperty.GetValue()
                End                
                Return _defaultValue
            End            
            Return ''
        End
    End
    If omitted(_defaultValue) = FALSE
        If reGetPointer = True
            Self.StProperty.Start()
            Self.StProperty.SetValue(_defaultValue)
            Get(_clarionFields,P#)
            Return Self.StProperty.GetValue()
        End            
        Return _defaultValue
    End            
    Return ''    

c25_SqliteClass.ClarionFieldPropertyExist                       Procedure(*ClarionFields_TYPE _clarionFields, string _fieldName, string _key, <bool reGetPointer>)

I                                                               Long
I2                                                              Long


Code

    If _clarionFields &= NULL
        Return 0
    END
    P# = Pointer(_clarionFields)
    I = 0
    LOOP
        I = I + 1
        Get(_clarionFields,I)
        If Errorcode() <> 0
            BREAK
        END
        If Upper(Clip(_clarionFields.Name)) = Upper(Clip(_fieldName))
            If _clarionFields.KeyValues &= NULL
                _clarionFields.KeyValues &= NEW KeyValue_TYPE()
            End
            
            I2 = 0
            LOOP
                I2 = I2 + 1
                Get(_clarionFields.KeyValues,I2)
                If Errorcode() <> 0
                    BREAK
                END
                
                If _clarionFields.KeyValues.Key &= NULL
                    CYCLE
                END
                If Upper(Clip(_clarionFields.KeyValues.Key)) = Upper(Clip(_key))
                    
                    If reGetPointer = True
                        Get(_clarionFields,P#)
                        Return True
                    End                          
                    
                    Return true
                End
            End
        End
    End
    If reGetPointer = True
        Get(_clarionFields,P#)
        Return False
    End   
    Return False
    
c25_SqliteClass.ClarionFieldPropertyAndValueExist               Procedure(*ClarionFields_TYPE _clarionFields, string _fieldName, string _key, string _value, <bool reGetPointer>)

I                                                               Long
I2                                                              Long


Code

    If _clarionFields &= NULL
        Return 0
    END
    P# = Pointer(_clarionFields)
    I = 0
    LOOP
        I = I + 1
        Get(_clarionFields,I)
        If Errorcode() <> 0
            BREAK
        END
        If Upper(Clip(_clarionFields.Name)) = Upper(Clip(_fieldName))
            If _clarionFields.KeyValues &= NULL
                _clarionFields.KeyValues &= NEW KeyValue_TYPE()
            End
            
            I2 = 0
            LOOP
                I2 = I2 + 1
                Get(_clarionFields.KeyValues,I2)
                If Errorcode() <> 0
                    BREAK
                END
                
                If _clarionFields.KeyValues.Key &= NULL
                    CYCLE
                END
                
                
                If _clarionFields.KeyValues.Value &= NULL
                    CYCLE
                END
                
                
                If Upper(Clip(_clarionFields.KeyValues.Key)) = Upper(Clip(_key)) And Upper(Clip(_clarionFields.KeyValues.Value)) = Upper(Clip(_value))
                    
                    If reGetPointer = True
                        Get(_clarionFields,P#)
                        Return True
                    End                          
                    
                    Return true
                End
            End
        End
    End
    If reGetPointer = True
        Get(_clarionFields,P#)
        Return False
    End   
    Return False
    
c25_SqliteClass.SetConnectionStringBackup                       Procedure(string _connString)

    CODE

        Self.ConnectionStringBackup = Clip(_connString)
        return ''

c25_SqliteClass.BackupInit                                      Procedure(string _filenameBackup,<byte _silently>)

ThisConnHandleBackup            long
ThisConnectionStringBackup      string(1024)
ThisSourceName                  string(1024)
ThisTargetName                  string(1024)
ThisBackupHandle                LONG
CurrentMethod           cstring(128)

    CODE

        CurrentMethod = 'BackupInit'
        Self.CurrentMethod = CurrentMethod

    If len(clip(_filenameBackup)) > 0
        Self.SetConnectionStringBackup(_filenameBackup)
    End

    Self.ConnHandleBackup = 0
    Loop 1 Times
        If Len(Clip(Self.ConnectionStringBackup)) = 0
            BREAK
        End
        ThisConnectionStringBackup = Clip(Self.ConnectionStringBackup) & Chr(0) & Chr(0)

        Self.ResultCode = c25_Sqlite3_open_V2(Address(ThisConnectionStringBackup),Address(ThisConnHandleBackup),c25_SQLITE_OPEN_READWRITE + c25_SQLITE_OPEN_CREATE, 0)

        Self.Handle_ErrorInfo(_silently*-1)

        If Self.ResultCode <> c25_SQLITE_OK
            BREAK
        Else
            Self.ConnHandleBackup = ThisConnHandleBackup
            ThisSourceName = 'main' & Chr(0) & Chr(0)
            ThisTargetName = 'main' & Chr(0) & Chr(0)
            ThisBackupHandle = c25_sqlite3_backup_init(ThisConnHandleBackup, Address(ThisTargetName), Self.ConnHandle, Address(ThisSourceName))
            If ThisBackupHandle <> 0
                Loop 1000 Times
                    Self.ResultCode = c25_sqlite3_backup_step(ThisBackupHandle,-1)

                    Case Self.ResultCode
                    Of c25_SQLITE_OK
                        CYCLE
                    Of c25_SQLITE_BUSY
                    OrOf c25_SQLITE_LOCKED
                        c25_sleepex(100,0)
                    Else
                        Self.Handle_ErrorInfo(_silently*-1)
                        BREAK
                    End
                End
                Self.ResultCode = c25_sqlite3_backup_finish(ThisBackupHandle)

            End

        End
        RETURN 0
    End
    RETURN 0

c25_SqliteClass.StoreToDisk                                     Procedure(string _fileAndPath)

ReturnString            String(16000)
CurrentMethod           cstring(128)

    CODE

        CurrentMethod = 'StoreToDisk'
        Self.CurrentMethod = CurrentMethod

    ReturnString = Self.BackupInit(_fileAndPath)

    RETURN Clip(ReturnString)

c25_SqliteClass.Handle_ErrorInfo                                Procedure(<byte _showErrorWin>)

CurrentMethod           cstring(128)

    CODE

    return ''

c25_SqliteClass.Get_ErrorString                                 Procedure(long _errorCode, byte _extended)

ErrStrAddress                       LONG
LengthString                        LONG
ErrorCode                           LONG
CurrentMethod           cstring(128)

    CODE

        RETURN ''

c25_SqliteClass.Get_ErrorMessage                                Procedure(long _errorCode)

ErrMsgAddress   LONG
LengthString    LONG
CurrentMethod           cstring(128)

    CODE

        RETURN ''

c25_SqliteClass.Get_ResultCodeInfo                              Procedure()

ResultCodeInfo      GROUP(SQLITE_ResultCodeInfo_TYPE)
                    End
CurrentMethod           cstring(128)

    CODE

        CurrentMethod = 'Get_ResultCodeInfo'
        Self.CurrentMethod = CurrentMethod

        Case Self.ResultCode
        Of c25_SQLITE_OK
            ResultCodeInfo.ShortDescription = 'SQLITE OK'
            ResultCodeInfo.Description = 'Successful result'
            ResultCodeInfo.ResultCode = 0
        Of c25_SQLITE_ERROR
            ResultCodeInfo.ShortDescription = 'SQLITE ERROR'
            ResultCodeInfo.Description = 'Generic error'
            ResultCodeInfo.ResultCode = 1
        Of c25_SQLITE_INTERNAL
            ResultCodeInfo.ShortDescription = 'SQLITE INTERNAL'
            ResultCodeInfo.Description = 'Internal logic error in SQLite'
            ResultCodeInfo.ResultCode = 2
        Of c25_SQLITE_PERM
            ResultCodeInfo.ShortDescription = 'SQLITE PERM'
            ResultCodeInfo.Description = 'Access permission denied'
            ResultCodeInfo.ResultCode = 3
        Of c25_SQLITE_ABORT
            ResultCodeInfo.ShortDescription = 'SQLITE ABORT'
            ResultCodeInfo.Description = 'Callback routine requested an abort'
            ResultCodeInfo.ResultCode = 4
        Of c25_SQLITE_BUSY
            ResultCodeInfo.ShortDescription = 'SQLITE BUSY'
            ResultCodeInfo.Description = 'The database file is locked'
            ResultCodeInfo.ResultCode = 5
        Of c25_SQLITE_LOCKED
            ResultCodeInfo.ShortDescription = 'SQLITE LOCKED'
            ResultCodeInfo.Description = 'A table in the database is locked'
            ResultCodeInfo.ResultCode = 6
        Of c25_SQLITE_NOMEM
            ResultCodeInfo.ShortDescription = 'SQLITE NOMEM'
            ResultCodeInfo.Description = 'A malloc() failed'
            ResultCodeInfo.ResultCode = 7
        Of c25_SQLITE_READONLY
            ResultCodeInfo.ShortDescription = 'SQLITE READONLY'
            ResultCodeInfo.Description = 'Attempt to write a readonly database'
            ResultCodeInfo.ResultCode = 8
        Of c25_SQLITE_INTERRUPT
            ResultCodeInfo.ShortDescription = 'SQLITE INTERRUPT'
            ResultCodeInfo.Description = 'Operation terminated by sqlite3 interrupt()*'
            ResultCodeInfo.ResultCode = 9
        Of c25_SQLITE_IOERR
            ResultCodeInfo.ShortDescription = 'SQLITE IOERR'
            ResultCodeInfo.Description = 'Some kind Of disk I/O error occurred'
            ResultCodeInfo.ResultCode = 10
        Of c25_SQLITE_CORRUPT
            ResultCodeInfo.ShortDescription = 'SQLITE CORRUPT'
            ResultCodeInfo.Description = 'The database disk image is malformed'
            ResultCodeInfo.ResultCode = 11
        Of c25_SQLITE_NOTFOUND
            ResultCodeInfo.ShortDescription = 'SQLITE NOTFOUND'
            ResultCodeInfo.Description = 'Unknown opcode in sqlite3 file control()'
            ResultCodeInfo.ResultCode = 12
        Of c25_SQLITE_FULL
            ResultCodeInfo.ShortDescription = 'SQLITE FULL'
            ResultCodeInfo.Description = 'Insertion failed because database is full'
            ResultCodeInfo.ResultCode = 13
        Of c25_SQLITE_CANTOPEN
            ResultCodeInfo.ShortDescription = 'SQLITE CANTOPEN'
            ResultCodeInfo.Description = 'Unable to open the database file'
            ResultCodeInfo.ResultCode = 14
        Of c25_SQLITE_PROTOCOL
            ResultCodeInfo.ShortDescription = 'SQLITE PROTOCOL'
            ResultCodeInfo.Description = 'Database lock protocol error'
            ResultCodeInfo.ResultCode = 15
        Of c25_SQLITE_EMPTY
            ResultCodeInfo.ShortDescription = 'SQLITE EMPTY'
            ResultCodeInfo.Description = 'Internal use only'
            ResultCodeInfo.ResultCode = 16
        Of c25_SQLITE_SCHEMA
            ResultCodeInfo.ShortDescription = 'SQLITE SCHEMA'
            ResultCodeInfo.Description = 'The database schema changed'
            ResultCodeInfo.ResultCode = 17
        Of c25_SQLITE_TOOBIG
            ResultCodeInfo.ShortDescription = 'SQLITE TOOBIG'
            ResultCodeInfo.Description = 'String or BLOB exceeds size limit'
            ResultCodeInfo.ResultCode = 18
        Of c25_SQLITE_CONSTRAINT
            ResultCodeInfo.ShortDescription = 'SQLITE CONSTRAINT'
            ResultCodeInfo.Description = 'Abort due to constraint violation'
            ResultCodeInfo.ResultCode = 19
        Of c25_SQLITE_MISMATCH
            ResultCodeInfo.ShortDescription = 'SQLITE MISMATCH'
            ResultCodeInfo.Description = 'Data type mismatch'
            ResultCodeInfo.ResultCode = 20
        Of c25_SQLITE_MISUSE
            ResultCodeInfo.ShortDescription = 'SQLITE MISUSE'
            ResultCodeInfo.Description = 'Library used incorrectly'
            ResultCodeInfo.ResultCode = 21
        Of c25_SQLITE_NOLFS
            ResultCodeInfo.ShortDescription = 'SQLITE NOLFS'
            ResultCodeInfo.Description = 'Uses OS features not supported on host'
            ResultCodeInfo.ResultCode = 22
        Of c25_SQLITE_AUTH
            ResultCodeInfo.ShortDescription = 'SQLITE AUTH'
            ResultCodeInfo.Description = 'Authorization denied'
            ResultCodeInfo.ResultCode = 23
        Of c25_SQLITE_FORMAT
            ResultCodeInfo.ShortDescription = 'SQLITE FORMAT'
            ResultCodeInfo.Description = 'Not used'
            ResultCodeInfo.ResultCode = 24
        Of c25_SQLITE_RANGE
            ResultCodeInfo.ShortDescription = 'SQLITE RANGE'
            ResultCodeInfo.Description = '2nd parameter to sqlite3 bind out Of range'
            ResultCodeInfo.ResultCode = 25
        Of c25_SQLITE_NOTADB
            ResultCodeInfo.ShortDescription = 'SQLITE NOTADB'
            ResultCodeInfo.Description = 'File opened that is not a database file'
            ResultCodeInfo.ResultCode = 26
        Of c25_SQLITE_NOTICE
            ResultCodeInfo.ShortDescription = 'SQLITE NOTICE'
            ResultCodeInfo.Description = 'Notifications from sqlite3 log()'
            ResultCodeInfo.ResultCode = 27
        Of c25_SQLITE_WARNING
            ResultCodeInfo.ShortDescription = 'SQLITE WARNING'
            ResultCodeInfo.Description = 'Warnings from sqlite3 log()'
            ResultCodeInfo.ResultCode = 28
        Of c25_SQLITE_ROW
            ResultCodeInfo.ShortDescription = 'SQLITE ROW'
            ResultCodeInfo.Description = 'sqlite3 step() has another row ready'
            ResultCodeInfo.ResultCode = 100
        Of c25_SQLITE_DONE
            ResultCodeInfo.ShortDescription = 'SQLITE DONE'
            ResultCodeInfo.Description = 'sqlite3 step() has finished executing'
            ResultCodeInfo.ResultCode = 101
        Else
            ResultCodeInfo.ShortDescription = 'UNKNOWN'
            ResultCodeInfo.Description = 'unknown'
            ResultCodeInfo.ResultCode = Self.ResultCode
        END
        Self.ResultCodeInfo = ResultCodeInfo
        RETURN ResultCodeInfo

c25_SqliteClass.Reset_ErrorInfo                                 Procedure()

CurrentMethod           cstring(128)

    CODE

        return ''

c25_SqliteClass.AddClarionQueueRowToQ3Blob                      Procedure(long _ptr, long _size, <bool _isLast>)

LastRowId Long

    CODE

        If Self.AddClaQRowToQ3Blob_PrepareSqlStmtHandle = 0
            Self.AddClaQRowToQ3Blob_PrepareSql &= Self.BitConverter.BinaryCopy('INSERT INTO Q3 ([QRowBytes]) Values(@p1)' & Chr(0))

            RetValue# = c25_sqlite3_prepare_v2(Self.ConnHandle,Address(Self.AddClaQRowToQ3Blob_PrepareSql),Size(Self.AddClaQRowToQ3Blob_PrepareSql),Address(Self.AddClaQRowToQ3Blob_PrepareSqlStmtHandle),0)
            If RetValue#  <> C25_SQLITE_OK
                Message('error stmt Self.AddClaQRowToQ3Blob_PrepareSqlStmtHandle' & RetValue#)
                Self.AddClaQRowToQ3Blob_PrepareSqlStmtHandle = 0
                Return 0
            End
        END

        Loop 1 Times
            c25_sqlite3_bind_blob(Self.AddClaQRowToQ3Blob_PrepareSqlStmtHandle, 1, _ptr, _size, 0)
            RetValue# = c25_sqlite3_step(Self.AddClaQRowToQ3Blob_PrepareSqlStmtHandle)
        End
        LastRowId = c25_sqlite3_last_insert_rowid(Self.ConnHandle)
            RetValue# = c25_sqlite3_clear_bindings(Self.AddClaQRowToQ3Blob_PrepareSqlStmtHandle)
            RetValue# = c25_sqlite3_reset(Self.AddClaQRowToQ3Blob_PrepareSqlStmtHandle)
            RetValue# = c25_sqlite3_finalize(Self.AddClaQRowToQ3Blob_PrepareSqlStmtHandle)
            Dispose(Self.AddClaQRowToQ3Blob_PrepareSql)
        Self.AddClaQRowToQ3Blob_PrepareSqlStmtHandle = 0

        Return LastRowId

