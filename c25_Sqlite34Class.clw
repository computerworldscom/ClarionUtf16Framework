    Member()

    Include('c25_Sqlite34Class.inc'), once

            Map
                Include('c25_Prototypes_Sqlite3.clw')
                Include('c25_WinApiPrototypes.clw')
                Include('i64.inc')
            End

c25Sqlite34Class.Construct                                 Procedure()

    Code

        Self.CRLF                        = Chr(13) & Chr(10)
        Self.st1                        &= New StringTheory()
        Self.st2                        &= New StringTheory()
        Self.st3                        &= New StringTheory()
        Self.st4                        &= New StringTheory()
        Self.st5                        &= New StringTheory()

        Self.Js1                        &= New JSONClass()
        Self.Js2                        &= New JSONClass()
        Self.Js3                        &= New JSONClass()
        Self.Js4                        &= New JSONClass()
        Self.Js5                        &= New JSONClass()

        Self.WinApi                     &= New c25WinApiClass()
        Self.NanoSync                   &= New c25NanoSyncClass()
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

c25Sqlite34Class.Destruct                                  Procedure()

    Code

c25Sqlite34Class.GetSelfAddress                            Procedure()

    Code

        Self.SelfAddress = Address(Self)
        Return Self.SelfAddress

c25Sqlite34Class.Connect                                   Procedure(String _connString, <SqlOpenFlags_TYPE _sqlOpenFlags>)

ConnHandle                   Long
SQLLine                      String(1024)
Sqlite3ConnType              Long
DBEncoding                   Long
SqlOpenFlags                 Group(SqlOpenFlags_TYPE),Pre(SqlOpenFlags)
                             End

    Code

        Self.ConnHandle = 0
        Self.ConnectionString = Clip(_connString) & Chr(0)
        If OMITTED(_sqlOpenFlags) = True
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

        Self.ResultCode = Sqlite3_open_V2(Address(Self.ConnectionString),Address(ConnHandle),Self.CalcSqlOpenFlagsValue(SqlOpenFlags), 0)

        If Self.ResultCode <> 0
            Self.st1.Start()
            Self.st1.Append('Sqlite3_open_V2 error ' & Self.ResultCode & ', ' & Self.ConnectionString & Self.CRLF )
            Self.st1.SaveFile('sqlite34-log.txt',true)

            Self.Js1.Start()
            Self.Js1.Save(SqlOpenFlags,'sqlite34-log-SqlOpenFlags.json')

            Return 0
        End
        Self.ConnHandle = ConnHandle
        sqlite3_extended_result_codes(ConnHandle, True)
            SQLLine = 'PRAGMA SYNCHRONOUS = OFF;' & Chr(0)
            sqlite3_exec(ConnHandle,Address(SQLLine),0,0,0)
            SQLLine = 'PRAGMA JOURNAL_MODE = OFF;' & Chr(0)
            sqlite3_exec(ConnHandle,Address(SQLLine),0,0,0)
            SQLLine = 'PRAGMA TEMP_STORE = MEMORY;' & Chr(0)
            sqlite3_exec(ConnHandle,Address(SQLLine),0,0,0)
            SQLLine = 'PRAGMA LOCKING_MODE = NORMAL;' & Chr(0)
            sqlite3_exec(ConnHandle,Address(SQLLine),0,0,0)

        If SqlOpenFlags.ForceEncoding <> 0 And 1 > 2
            Case SqlOpenFlags.ForceEncoding
            Of C25_SQLITE_UTF8              !EQUATE(1) !    /* IMP: R-37514-35566 */
                SQLLine = 'PRAGMA ENCODING="UTF-8";'    & Chr(0)
            Of C25_SQLITE_UTF16LE           !EQUATE(2) !    /* IMP: R-03371-37637 */
                SQLLine = 'PRAGMA ENCODING="UTF-16le";' & Chr(0)
            Of C25_SQLITE_UTF16BE           !EQUATE(3) !    /* IMP: R-51971-34154 */
                SQLLine = 'PRAGMA ENCODING="UTF-16be";' & Chr(0)
            Of C25_SQLITE_UTF16             !EQUATE(4) !    /* Use native Byte order */
                SQLLine = 'PRAGMA ENCODING="UTF-16";'   & Chr(0)
            Of C25_SQLITE_ANY               !EQUATE(5) !    /* Deprecated */
                SQLLine = 'PRAGMA ENCODING="UTF-8";'    & Chr(0)
            Of C25_SQLITE_UTF16_ALIGNED     !EQUATE(8) !    /* sqlite3_create_collation only */
               SQLLine = 'PRAGMA ENCODING="UTF-16le";'  & Chr(0)
            End
        End
        SQLLine = 'CREATE TABLE DummyTABLE (ROWID INTEGER PRIMARY KEY AUTOINCREMENT, SESSIONINPUTID     TEXT COLLATE NOCASE)' & Chr(0)
        sqlite3_exec(Self.ConnHandle,Address(SQLLine),0,0,0)
        SQLLine = 'insert into dummytable (SESSIONINPUTID) values(''abc'');' & Chr(0)
        sqlite3_exec(Self.ConnHandle,Address(SQLLine),0,0,0)
        SQLLine = 'DROP TABLE DummyTABLE' & Chr(0)
        sqlite3_exec(Self.ConnHandle,Address(SQLLine),0,0,0)

        Return Self.ConnHandle

c25Sqlite34Class.GetPragmaDbList                           Procedure(<Long _connHandle>,<PragmaDbList_TYPE _pragmaDbList>, <Byte _inJson>,<Byte _show>)

json                                     &JSONClass,auto
st1                                     &StringTheory,auto

    Code

        Free(Self.PragmaDbList)
        Self.ExecuteQueryToQueue('select * from pragma_database_list;',Self.PragmaDbList)
        If _inJson = True Or 1 > 0
            st1 &= NEW StringTheory()
            st1.Start()
            json &= new JSONClass
            json.start()
            json.SetTagCase(jf:CaseAsIs)
            json.Save(Self.PragmaDbList,st1)
            Message(st1.GetValue())
        End

        Return ''

c25Sqlite34Class.GetPragma                                 Procedure(String _pragma, <String _paramA>,<*queue _queueOut>)

    Code

        Case Lower(Clip(_pragma))
        Of 'table_info'
        Of 'database_list'
        End

        Return ''

c25Sqlite34Class.ExecuteQueryToQueue                       Procedure(String _commandText, *queue _queue)

ClarionFields                   &ClarionFields_TYPE
Reflection                      &TrueReflectionClass()
RecSize                         Long
RecStr                          &String
GrpDummyString                  Group,Pre(GrpDummyString)
DummyString                         &String
                                End
GrpDummyCString                 Group,Pre(GrpDummyCString)
DummyCString                        &CSTRING
                                End
DummyBYTE                       Byte
DummyBYTEOver                   String(1),Over(DummyBYTE)
DummyUSHORT                     UShort
DummyUSHORTOver                 String(2),Over(DummyUSHORT)
DummySHORT                      Short
DummySHORTOver                  String(2),Over(DummySHORT)
DummyULONG                      ULong
DummyULONGOver                  String(4),Over(DummyULONG)
DummyLONG                       Long
DummyLONGOver                   String(4),Over(DummyLONG)
Address                         Long
AdrGroup                        Group,pre()
PtrAddress                          Long
PtrSize                             Long
                                End
AddressFromAny                  String(4),over(Address)
AddressAndSizeFromAny           String(8),over(AdrGroup)
AnyField                        ANY
ColIndex                        Long
ColCount                        Long

SQLiteSqlTextPtr                Long
StmtHandle                      Long
TimeOut                         decimal(20)
StartTime                       decimal(20)
EndTime                         decimal(20)
DurationNano                    decimal(20)
RetriesOnBusy                   Long
RetryOnBusyTime                 decimal(20)
SleepMM                         Long
FoundRow                        Byte
CurrentMethod                   cstring(128)
RowIndex                        Long
ObjectBindId                    Long
ColumnsCount                    Long
ColumnVal                       &String
ColumnBytes                     Long
ColumnType                      Long
ColumnTypeStr                   cstring(128)
Int64Value                      decimal(20,0)
Int32Value                      Long
IsInt64                         Byte
ColumnNamePtr                   Long
ColumnName                      &String
CommandText                     &String
SysTime                         DECIMAL(20)
Sqlite3ColumnMetaQ              &Sqlite3ColumnMeta_TYPE
Dec20                           DECIMAL(20)
Index                           Long
Index1                          Long
Index2                          Long
ColumnBytes16                   Long
RealVal                         REAL
RealVal2                        REAL
RecStrClear                     &String
INTSTR8                         String(8)
Int32                           Long
Str4OverInt32                   String(4),OVER(Int32)
Int64Grp                        LIKE(INT64)
Str8OverInt64                   String(8),OVER(Int64Grp)
UInt32                          ULong
Str4OverUInt32                  String(4),OVER(UInt32)
UInt64Grp                       LIKE(UINT64)
Str8OverUInt64                  String(8),OVER(UInt64Grp)

Debug                           Byte
DebugStep                       Long
ValueObjectPtr                  Long

    Code

        If _queue &= NULL
            Return ''
        End
        ColumnVal                 &= null
        ClarionFields              &= NEW ClarionFields_TYPE()
        Reflection                 &= NEW TrueReflectionClass()
        Reflection.Analyze(_queue,ClarionFields)
        Clear(GrpDummyString)
        Clear(GrpDummyCString)
        RecSize                 = Size(_queue)
        If RecSize < 1
            Return ''
        End
        RecStr                     &= NEW String(RecSize)
        RecStrClear             &= NEW String(RecSize)
        Clear(_queue)
        RecStrClear             = _queue

        CommandText             &= NEW String(Size(_commandText)+1)
        CommandText             = _commandText & Chr(0)

        SysTime                    = Self.NanoSync.GetSysTime()
        StartTime                  = Self.NanoSync.GetSysTime()
        Sqlite3ColumnMetaQ      &= NEW Sqlite3ColumnMeta_TYPE()

L0      Loop 1 Times
            TimeOut = Self.NanoSync.CalcSysTimeout(0,15,0,0)
L1          Loop
                If TimeOut < Self.NanoSync.GetSysTime()
                    BREAK L0
                End
                Self.ResultCode = sqlite3_prepare_v2(Self.ConnHandle,Address(CommandText),Size(CommandText),Address(StmtHandle),0)

                Case Self.ResultCode
                Of C25_SQLITE_OK
                    BREAK L1
                Of C25_SQLITE_BUSY !
                OrOf C25_SQLITE_BUSY_RECOVERY
                OrOf C25_SQLITE_BUSY_SNAPSHOT
                OrOf C25_SQLITE_LOCKED
                    If StmtHandle <> 0
                        sqlite3_finalize(StmtHandle)
                        StmtHandle = 0
                    End
                    c25_SleepEx(50,0)
                    Cycle
                Else
                    If StmtHandle <> 0
                        sqlite3_finalize(StmtHandle)
                        StmtHandle = 0
                    End
                    BREAK L0
                End
            End

            If StmtHandle = 0
                BREAK L0
            End

            RetriesOnBusy       = 0
            RetryOnBusyTime     = 0
            TimeOut             = Self.NanoSync.CalcSysTimeout(0,15,0,0)
L2          Loop
                If TimeOut < Self.NanoSync.GetSysTime()
                    BREAK L2
                End
                Self.ResultCode = sqlite3_step(StmtHandle)
                Case Self.ResultCode
                Of C25_SQLITE_ROW
                Of C25_SQLITE_DONE
                    BREAK L2
                Of C25_SQLITE_BUSY !
                OrOf C25_SQLITE_BUSY_RECOVERY
                OrOf C25_SQLITE_BUSY_SNAPSHOT
                OrOf C25_SQLITE_LOCKED
                    c25_SleepEx(50,0)
                    Cycle
                Else
                    Message('! UNKNOWN RESULT Code')
                    BREAK L2
                End
                RecStr = RecStrClear
                RowIndex = RowIndex + 1

                If RowIndex = 1
                    ColumnsCount = sqlite3_column_count(StmtHandle)
                    ColIndex = -1
                    Loop ColumnsCount Times
                        ColIndex = ColIndex + 1
                        Clear(Sqlite3ColumnMetaQ)
                        Sqlite3ColumnMetaQ.Id = Records(Sqlite3ColumnMetaQ) + 1
                        Sqlite3ColumnMetaQ.Index = ColIndex
                        ColumnNamePtr = 0
                        ColumnNamePtr = sqlite3_column_name(StmtHandle, ColIndex)
                        If ColumnNamePtr <> 0
                            Sqlite3ColumnMetaQ.Name = Self.BitConverter.ParseZeroTerminatedStringA(ColumnNamePtr, True)
                        End
                        Add(Sqlite3ColumnMetaQ)
                    End
                    Index1 = 0
                    Loop
                        Index1 = Index1 + 1
                        Get(Sqlite3ColumnMetaQ,Index1)
                        If Errorcode() <> 0
                            BREAK
                        End

                        Index2 = 0
                        Loop
                            Index2 = Index2 + 1
                            Get(ClarionFields,Index2)
                            If Errorcode() <> 0
                                BREAK
                            End
                            If CLIP(Upper(Sqlite3ColumnMetaQ.Name)) = CLIP(Upper(ClarionFields.Name))
                                Sqlite3ColumnMetaQ.TargetQFieldIndex = Index2
                                Put(Sqlite3ColumnMetaQ)
                                Break
                            End
                        End
                    End
                End

                ColIndex = -1
                Loop ColumnsCount Times
                    ColIndex = ColIndex + 1
                    Get(Sqlite3ColumnMetaQ,ColIndex+1)
                    If Errorcode() <> 0
                        Cycle
                    End
                    If Sqlite3ColumnMetaQ.TargetQFieldIndex = 0 ! no mapping to target queue
                        CYCLE
                    End
                    INDEX = Sqlite3ColumnMetaQ.TargetQFieldIndex
                    Get(ClarionFields,INDEX)
                    If Errorcode() <> 0
                        Cycle
                    End
                    If NOT ColumnVal &= null
                        ColumnVal &= null
                        Dispose(ColumnVal)
                    End
                    ColumnType = sqlite3_column_type(StmtHandle, ColIndex)
                    ValueObjectPtr = sqlite3_column_value(StmtHandle, ColIndex)

                    Case sqlite3_column_type(StmtHandle, ColIndex)
                    Of C25_SQLITE_INTEGER

                        Case ClarionFields.SizeBytes
                        Of 1
                            DummyBYTE = sqlite3_column_int(StmtHandle, ColIndex)
                            RecStr[ClarionFields.Offset + 1 : ClarionFields.OffsetEnd+1] = DummyBYTEOver
                        Of 4
                            Dec20 = sqlite3_column_int(StmtHandle, ColIndex)
                            If Dec20 > -1
                                UInt32 =  Dec20
                                RecStr[ClarionFields.Offset + 1 : ClarionFields.OffsetEnd+1] = Str4OverUInt32
                            ELSE
                                Int32 = Dec20
                                RecStr[ClarionFields.Offset + 1 : ClarionFields.OffsetEnd+1] = Str4OverInt32

                            End
                        Of 8
                            Dec20 = sqlite3_column_int64(StmtHandle, ColIndex)
                            If Dec20 > -1
                                i64FromDecimal(UInt64Grp,Dec20)
                                RecStr[ClarionFields.Offset + 1 : ClarionFields.OffsetEnd+1] = Str8OverUInt64
                            ELSE
                                i64FromDecimal(Int64Grp,Dec20)
                                RecStr[ClarionFields.Offset + 1 : ClarionFields.OffsetEnd+1] = Str8OverInt64
                            End
                        ELSE
                        End
                    Of C25_SQLITE_BLOB

                        SQLiteSqlTextPtr = sqlite3_column_blob(StmtHandle,ColIndex)
                        If SQLiteSqlTextPtr <> 0
                            ColumnBytes = sqlite3_column_bytes(StmtHandle, ColIndex)
                            If ColumnBytes > 0

                                ColumnVal &= new String(ColumnBytes)
                                c25_MemCpy(Address(ColumnVal),SQLiteSqlTextPtr, ColumnBytes)

                                Case ClarionFields.IsRef
                                Of True
                                    Case Upper(ClarionFields.DataType)
                                    Of 'String'

                                        GrpDummyString.DummyString &= NEW String(ColumnBytes)
                                        GrpDummyString.DummyString = ColumnVal
                                        AnyField &= What(GrpDummyString,1)
                                        AddressAndSizeFromAny = AnyField
                                        RecStr[ClarionFields.Offset + 1 : ClarionFields.OffsetEnd+1] = AddressAndSizeFromAny
                                    End
                                Else
                                    Case Upper(ClarionFields.DataType)
                                    Of 'String'
                                            RecStr[ClarionFields.Offset + 1 : ClarionFields.OffsetEnd+1] = ColumnVal & All(Chr(32),ClarionFields.SizeBytes)
                                    End
                                End
                            End
                        End
                    Of C25_SQLITE_TEXT
                    OrOf C25_SQLITE_FLOAT
                        If ClarionFields.IsUtf16
                            SQLiteSqlTextPtr = sqlite3_column_text16(StmtHandle, ColIndex)
                        ELSE
                            SQLiteSqlTextPtr = sqlite3_column_text(StmtHandle, ColIndex)
                        End
                        If SQLiteSqlTextPtr <> 0
                            If ClarionFields.IsUtf16
                                ColumnBytes = sqlite3_column_bytes16(StmtHandle, ColIndex)
                            Else
                                ColumnBytes = sqlite3_column_bytes(StmtHandle, ColIndex)
                            End
                            If ColumnBytes > 0
                                ColumnVal &= new String(ColumnBytes)
                                c25_MemCpy(Address(ColumnVal),SQLiteSqlTextPtr, ColumnBytes)

                                Case ClarionFields.IsRef
                                Of True
                                    Case Upper(ClarionFields.DataType)
                                    Of 'String'
                                        If ClarionFields.IsUtf16

                                            GrpDummyString.DummyString &= NEW String(Size(ColumnVal))
                                            GrpDummyString.DummyString = ColumnVal
                                        Else
                                            GrpDummyString.DummyString &= NEW String(Size(ColumnVal))
                                            GrpDummyString.DummyString = ColumnVal
                                        End
                                        AnyField &= What(GrpDummyString,1)
                                        AddressAndSizeFromAny = AnyField
                                        RecStr[ClarionFields.Offset + 1 : ClarionFields.OffsetEnd+1] = AddressAndSizeFromAny
                                    Of 'CSTRING'

                                        GrpDummyCString.DummyCString &= NEW CSTRING(Size(ColumnVal)+1) ! ?+1 is good?
                                        GrpDummyCString.DummyCString = ColumnVal
                                        AnyField &= What(GrpDummyCString,1)
                                        AddressAndSizeFromAny = AnyField
                                        RecStr[ClarionFields.Offset + 1 : ClarionFields.OffsetEnd+1] = AddressAndSizeFromAny
                                    End
                                Else
                                    Case Upper(ClarionFields.DataType)
                                    Of 'String'
                                        If ClarionFields.IsUtf16

                                            RecStr[ClarionFields.Offset + 1 : ClarionFields.OffsetEnd+1] = ColumnVal & All(Chr(0),ClarionFields.SizeBytes) !Self.st1.GetValue() & All(Chr(32),ClarionFields.SizeBytes)
                                        Else
                                            If ClarionFields.IsUtf8
                                                RecStr[ClarionFields.Offset + 1 : ClarionFields.OffsetEnd+1] = ColumnVal & All(Chr(0),ClarionFields.SizeBytes)
                                            Else
                                                RecStr[ClarionFields.Offset + 1 : ClarionFields.OffsetEnd+1] = ColumnVal & All(Chr(32),ClarionFields.SizeBytes)
                                            End
                                        End
                                    Of 'CSTRING'
                                        Padding# = ColumnBytes - ClarionFields.SizeBytes
                                        If Padding# > 0
                                            RecStr[ClarionFields.Offset + 1 : ClarionFields.OffsetEnd+1] = ColumnVal & All(Chr(0),Padding#)
                                        Else
                                            RecStr[ClarionFields.Offset + 1 : ClarionFields.OffsetEnd+1] = ColumnVal & Chr(0)
                                        End
                                    End
                                End
                            End
                        End
                    Of C25_SQLITE_NULL
                    ELSE
                        message('aha')
                    End

                End
                _queue = RecStr
                Add(_queue)
                Case Self.ResultCode
                Of C25_SQLITE_ROW
                    Cycle
                Of C25_SQLITE_DONE
                    BREAK
                End
            End
        End

        If StmtHandle <> 0
            sqlite3_finalize(StmtHandle)
            StmtHandle = 0
        End

        EndTime = Self.NanoSync.GetSysTime()
        DurationNano = EndTime - StartTime
        DurationNano = DurationNano

        If NOT ColumnVal &= null
            ColumnVal &= null
            Dispose(ColumnVal)
        End
        If not ClarionFields &= NULL
            Dispose(ClarionFields)
        End
        If not Sqlite3ColumnMetaQ &= NULL
            Dispose(Sqlite3ColumnMetaQ)
        End
        Return ''

c25Sqlite34Class.QueueDataToSqliteTableIsolated            Procedure(*QUEUE _queue, String _attachedAliasDb, String _tableName, String _connectString)

Sqlite34                                                &c25Sqlite34Class

    Code

        Sqlite34 &= NEW c25Sqlite34Class()

        Self.DetachDb(Self.ConnHandle,_attachedAliasDb)

        Sqlite34 &= NEW c25Sqlite34Class()
        Sqlite34.Connect(_connectString)
        Sqlite34.QueueDataToSqliteTable(_queue, _tableName)

        Sqlite34.Disconnect(Sqlite34.ConnHandle)
        Self.AttachDb(Self.ConnHandle, _connectString, _attachedAliasDb)

        Dispose(Sqlite34)

    Return 0

c25Sqlite34Class.CalcSqlOpenFlagsValue                     Procedure(<SqlOpenFlags_TYPE _sqlOpenFlags>)

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

c25Sqlite34Class.Disconnect                                Procedure(<Long _connHandle>)

    Code

        If omitted(_connHandle) = False Or _connHandle = 0
            R# = sqlite3_close(_connHandle)
        ELSE
            R# = sqlite3_close(Self.ConnHandle)
        End
        Self.ConnHandle = 0
        Return R#

c25Sqlite34Class.Exec                                      Procedure(<Long _connHandle>, String _sql)

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
            R# = sqlite3_exec(ConnHandle,Address(SqlLine),0,0,0)

            Dispose(SqlLine)
        End

        Return R#

c25Sqlite34Class.AttachDb                                  Procedure(<Long _connHandle>, String _uriUtf8, String _dbAlias)

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
        Self.ResultCode     = sqlite3_exec(ConnHandle,Address(SQLCommandLine),0,0,0)

        Return Self.ResultCode

c25Sqlite34Class.DetachDb                                  Procedure(<_connHandle>, String _dbAlias)

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
        Self.ResultCode     = sqlite3_exec(ConnHandle,Address(SQLCommandLine),0,0,0)
        Return Self.ResultCode

c25Sqlite34Class.ExecuteScalar                             Procedure(<String _commandText>,<*c25DbSqlObjectReturn_TYPE _c25DbSqlObjectReturn>)

    Code

        Clear(Self.c25DbSqlObjectReturn)

        Self.c25DbSqlObjectReturn.StartTime = Self.NanoSync.GetSysTime()

        If Omitted(_commandText) = False
            If not Self.CommandText &= NULL
                Dispose(Self.CommandText)
            End
            Self.CommandText &= NEW String(Len(Clip(_commandText)) + 2)
            Self.CommandText = Clip(Left(_commandText)) & Chr(0) & Chr(0)
        End

L0      Loop 1 Times
            Self.NanoSync.SetTimeOut(0,1,0,0)
L1          Loop
                If Self.NanoSync.IsTimeOut()
                    BREAK L0
                End
                Self.ResultCode = sqlite3_prepare_v2(Self.ConnHandle,Address(Self.CommandText),Len(Self.CommandText),Address(Self.c25DbSqlObjectReturn.StmtHandle),0)
                Self.c25DbSqlObjectReturn.PrepareResultCode = Self.ResultCode
                Case Self.ResultCode
                Of C25_SQLITE_OK
                ELSE
                End

                Case Self.ResultCode
                Of C25_SQLITE_OK
                    BREAK L1
                Of C25_SQLITE_BUSY !
                OrOf C25_SQLITE_BUSY_RECOVERY
                OrOf C25_SQLITE_BUSY_SNAPSHOT
                OrOf C25_SQLITE_LOCKED
                    If Self.c25DbSqlObjectReturn.StmtHandle <> 0
                        sqlite3_finalize(Self.c25DbSqlObjectReturn.StmtHandle)
                        Self.c25DbSqlObjectReturn.StmtHandle = 0
                    End
                    Self.c25DbSqlObjectReturn.RetriesOnBusy = Self.c25DbSqlObjectReturn.RetriesOnBusy + 1
                    c25_SleepEx(20,0)
                    Cycle
                Else
                    If Self.c25DbSqlObjectReturn.StmtHandle <> 0
                        sqlite3_finalize(Self.c25DbSqlObjectReturn.StmtHandle)
                        Self.c25DbSqlObjectReturn.StmtHandle = 0
                    End
                    BREAK L0
                End
            End

            If Self.c25DbSqlObjectReturn.StmtHandle = 0
                BREAK L0
            End

            Self.NanoSync.SetTimeOut(0,1,0,0)
L2          Loop
                If Self.NanoSync.IsTimeOut()
                    BREAK L0
                End
                Self.ResultCode = sqlite3_step(Self.c25DbSqlObjectReturn.StmtHandle)
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
                        sqlite3_finalize(Self.c25DbSqlObjectReturn.StmtHandle)
                        Self.c25DbSqlObjectReturn.StmtHandle = 0
                    End
                    BREAK L0
                Of C25_SQLITE_BUSY !
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

            Self.c25DbSqlObjectReturn.Sqlite3ColumnTypeId = sqlite3_column_type(Self.c25DbSqlObjectReturn.StmtHandle, 0)

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
                Self.c25DbSqlObjectReturn.ColumnBytes       = sqlite3_column_bytes(Self.c25DbSqlObjectReturn.StmtHandle, 0)
                Self.c25DbSqlObjectReturn.IntegerValue      = sqlite3_column_int(Self.c25DbSqlObjectReturn.StmtHandle, 0)

                If Self.c25DbSqlObjectReturn.IntegerValue = 0
                    Self.c25DbSqlObjectReturn.IntegerIsZero = True
                End

                If Self.c25DbSqlObjectReturn.IntegerValue > -1
                    If Self.c25DbSqlObjectReturn.IntegerValue           < 128
                        Self.c25DbSqlObjectReturn.IntegerType       = c25_rf:Int8
                        Self.c25DbSqlObjectReturn.IsInt8            = True
                    ElsIf Self.c25DbSqlObjectReturn.IntegerValue        < 256
                        Self.c25DbSqlObjectReturn.IntegerType       = c25_rf:UInt8
                        Self.c25DbSqlObjectReturn.IsUInt8           = True
                    ElsIf Self.c25DbSqlObjectReturn.IntegerValue        =< Self.Int16MaxValue
                        Self.c25DbSqlObjectReturn.IntegerType       = c25_rf:Int16
                    ElsIf Self.c25DbSqlObjectReturn.IntegerValue        =< Self.UInt16MaxValue
                        Self.c25DbSqlObjectReturn.IntegerType       = c25_rf:UInt16
                    ElsIf Self.c25DbSqlObjectReturn.IntegerValue        =< Self.Int32MaxValue
                        Self.c25DbSqlObjectReturn.IntegerType       = c25_rf:Int32
                    ElsIf Self.c25DbSqlObjectReturn.IntegerValue        =< Self.UInt32MaxValue
                        Self.c25DbSqlObjectReturn.IntegerType       = c25_rf:UInt32
                    ElsIf Self.c25DbSqlObjectReturn.IntegerValue        =< Self.Int64MaxValue
                        Self.c25DbSqlObjectReturn.IntegerType       = c25_rf:Int64
                    ElsIf Self.c25DbSqlObjectReturn.IntegerValue        =< Self.UInt64MaxValue
                        Self.c25DbSqlObjectReturn.IntegerType       = c25_rf:UInt32
                    ELSE
                        Self.c25DbSqlObjectReturn.IntegerType       = c25_rf:numeric
                    End
                ElsIf Self.c25DbSqlObjectReturn.IntegerValue < 0
                    Self.c25DbSqlObjectReturn.IntegerIsNegative = True

                    If Self.c25DbSqlObjectReturn.IntegerValue           >= Self.Int16MinValue
                        Self.c25DbSqlObjectReturn.IntegerType       = c25_rf:Int16
                    ElsIf Self.c25DbSqlObjectReturn.IntegerValue        => Self.Int32MinValue
                        Self.c25DbSqlObjectReturn.IntegerType       = c25_rf:Int32
                    ElsIf Self.c25DbSqlObjectReturn.IntegerValue        => Self.Int64MinValue
                        Self.c25DbSqlObjectReturn.IntegerType       = c25_rf:Int64
                    ELSE
                        Self.c25DbSqlObjectReturn.IntegerType       = c25_rf:numeric
                    End
                End

            End
            Self.c25DbSqlObjectReturn.Success  = True
        End
        If Self.c25DbSqlObjectReturn.StmtHandle <> 0
            Self.ResultCode = sqlite3_finalize(Self.c25DbSqlObjectReturn.StmtHandle)
            Self.c25DbSqlObjectReturn.StmtHandle = 0
        End
        Self.c25DbSqlObjectReturn.EndTime = Self.NanoSync.GetSysTime()
        Self.c25DbSqlObjectReturn.Duration = Self.c25DbSqlObjectReturn.EndTime - Self.c25DbSqlObjectReturn.StartTime

        If Omitted(_c25DbSqlObjectReturn) = False
            _c25DbSqlObjectReturn = Self.c25DbSqlObjectReturn
            Return Self.c25DbSqlObjectReturn
        End
        V# = Self.c25DbSqlObjectReturn.IntegerValue
        Return V# !Format(Self.c25DbSqlObjectReturn.IntegerValue,@N_20)

c25Sqlite34Class.Get_ExtendedCodeInfo                      Procedure(<Long _errorCodeExtended>)

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
            ShortDescription = 'C25_SQLITE ABORT ROLLBACK'
        Of C25_SQLITE_BUSY_RECOVERY
            ShortDescription = 'C25_SQLITE BUSY RECOVERY'
        Of C25_SQLITE_BUSY_SNAPSHOT
            ShortDescription = 'C25_SQLITE BUSY SNAPSHOT'
        Of C25_SQLITE_BUSY_TIMEOUT
            ShortDescription = 'C25_SQLITE BUSY TIMEOUT'
        Of C25_SQLITE_CANTOPEN_CONVPATH
            ShortDescription = 'C25_SQLITE CANTOPEN CONVPATH'
        Of C25_SQLITE_CANTOPEN_DIRTYWAL
            ShortDescription = 'C25_SQLITE CANTOPEN DIRTYWAL'
        Of C25_SQLITE_CANTOPEN_FULLPATH
            ShortDescription = 'C25_SQLITE CANTOPEN FULLPATH'
        Of C25_SQLITE_CANTOPEN_ISDIR
            ShortDescription = 'C25_SQLITE CANTOPEN ISDIR'
        Of C25_SQLITE_CANTOPEN_NOTEMPDIR
            ShortDescription = 'C25_SQLITE CANTOPEN NOTEMPDIR'
        Of C25_SQLITE_CANTOPEN_SYMLINK
            ShortDescription = 'C25_SQLITE CANTOPEN SYMLINK'
        Of C25_SQLITE_CONSTRAINT_CHECK
            ShortDescription = 'C25_SQLITE CONSTRAINT CHECK'
        Of C25_SQLITE_CONSTRAINT_COMMITHOOK
            ShortDescription = 'C25_SQLITE CONSTRAINT COMMITHOOK'
        Of C25_SQLITE_CONSTRAINT_FOREIGNKEY
            ShortDescription = 'C25_SQLITE CONSTRAINT FOREIGNKEY'
        Of C25_SQLITE_CONSTRAINT_FUNCTION
            ShortDescription = 'C25_SQLITE CONSTRAINT FUNCTION'
        Of C25_SQLITE_CONSTRAINT_NOTNULL
            ShortDescription = 'C25_SQLITE CONSTRAINT NOTNULL'
        Of C25_SQLITE_CONSTRAINT_PINNED
            ShortDescription = 'C25_SQLITE CONSTRAINT PINNED'
        Of C25_SQLITE_CONSTRAINT_PRIMARYKEY
            ShortDescription = 'C25_SQLITE CONSTRAINT PRIMARYKEY'
        Of C25_SQLITE_CONSTRAINT_ROWID
            ShortDescription = 'C25_SQLITE CONSTRAINT ROWID'
        Of C25_SQLITE_CONSTRAINT_TRIGGER
            ShortDescription = 'C25_SQLITE CONSTRAINT TRIGGER'
        Of C25_SQLITE_CONSTRAINT_UNIQUE
            ShortDescription = 'C25_SQLITE CONSTRAINT UNIQUE'
        Of C25_SQLITE_CONSTRAINT_VTAB
            ShortDescription = 'C25_SQLITE CONSTRAINT VTAB'
        Of C25_SQLITE_CORRUPT_INDEX
            ShortDescription = 'C25_SQLITE CORRUPT INDEX'
        Of C25_SQLITE_CORRUPT_SEQUENCE
            ShortDescription = 'C25_SQLITE CORRUPT SEQUENCE'
        Of C25_SQLITE_CORRUPT_VTAB
            ShortDescription = 'C25_SQLITE CORRUPT VTAB'
        Of C25_SQLITE_ERROR_MISSING_COLLSEQ
            ShortDescription = 'C25_SQLITE ERROR MISSING COLLSEQ'
        Of C25_SQLITE_ERROR_RETRY
            ShortDescription = 'C25_SQLITE ERROR RETRY'
        Of C25_SQLITE_ERROR_SNAPSHOT
            ShortDescription = 'C25_SQLITE ERROR SNAPSHOT'
        Of C25_SQLITE_IOERR_ACCESS
            ShortDescription = 'C25_SQLITE IOERR ACCESS'
        Of C25_SQLITE_IOERR_AUTH
            ShortDescription = 'C25_SQLITE IOERR AUTH'
        Of C25_SQLITE_IOERR_BEGIN_ATOMIC
            ShortDescription = 'C25_SQLITE IOERR BEGIN ATOMIC'
        Of C25_SQLITE_IOERR_BLOCKED
            ShortDescription = 'C25_SQLITE IOERR BLOCKED'
        Of C25_SQLITE_IOERR_CHECKRESERVEDLOCK
            ShortDescription = 'C25_SQLITE IOERR CHECKRESERVEDLOCK'
        Of C25_SQLITE_IOERR_CLOSE
            ShortDescription = 'C25_SQLITE IOERR CLOSE'
        Of C25_SQLITE_IOERR_COMMIT_ATOMIC
            ShortDescription = 'C25_SQLITE IOERR COMMIT ATOMIC'
        Of C25_SQLITE_IOERR_CONVPATH
            ShortDescription = 'C25_SQLITE IOERR CONVPATH'
        Of C25_SQLITE_IOERR_DATA
            ShortDescription = 'C25_SQLITE IOERR DATA'
        Of C25_SQLITE_IOERR_DELETE
            ShortDescription = 'C25_SQLITE IOERR DELETE'
        Of C25_SQLITE_IOERR_DELETE_NOENT
            ShortDescription = 'C25_SQLITE IOERR DELETE NOENT'
        Of C25_SQLITE_IOERR_DIR_CLOSE
            ShortDescription = 'C25_SQLITE IOERR DIR CLOSE'
        Of C25_SQLITE_IOERR_DIR_FSYNC
            ShortDescription = 'C25_SQLITE IOERR DIR FSYNC'
        Of C25_SQLITE_IOERR_FSTAT
            ShortDescription = 'C25_SQLITE IOERR FSTAT'
        Of C25_SQLITE_IOERR_FSYNC
            ShortDescription = 'C25_SQLITE IOERR FSYNC'
        Of C25_SQLITE_IOERR_GETTEMPPATH
            ShortDescription = 'C25_SQLITE IOERR GETTEMPPATH'
        Of C25_SQLITE_IOERR_LOCK
            ShortDescription = 'C25_SQLITE IOERR LOCK'
        Of C25_SQLITE_IOERR_MMAP
            ShortDescription = 'C25_SQLITE IOERR MMAP'
        Of C25_SQLITE_IOERR_NOMEM
            ShortDescription = 'C25_SQLITE IOERR NOMEM'
        Of C25_SQLITE_IOERR_RDLOCK
            ShortDescription = 'C25_SQLITE IOERR RDLOCK'
        Of C25_SQLITE_IOERR_READ
            ShortDescription = 'C25_SQLITE IOERR READ'
        Of C25_SQLITE_IOERR_ROLLBACK_ATOMIC
            ShortDescription = 'C25_SQLITE IOERR ROLLBACK ATOMIC'
        Of C25_SQLITE_IOERR_SEEK
            ShortDescription = 'C25_SQLITE IOERR SEEK'
        Of C25_SQLITE_IOERR_SHMLOCK
            ShortDescription = 'C25_SQLITE IOERR SHMLOCK'
        Of C25_SQLITE_IOERR_SHMMAP
            ShortDescription = 'C25_SQLITE IOERR SHMMAP'
        Of C25_SQLITE_IOERR_SHMOPEN
            ShortDescription = 'C25_SQLITE IOERR SHMOPEN'
        Of C25_SQLITE_IOERR_SHMSIZE
            ShortDescription = 'C25_SQLITE IOERR SHMSIZE'
        Of C25_SQLITE_IOERR_SHORT_READ
            ShortDescription = 'C25_SQLITE IOERR Short READ'
        Of C25_SQLITE_IOERR_TRUNCATE
            ShortDescription = 'C25_SQLITE IOERR TRUNCATE'
        Of C25_SQLITE_IOERR_UNLOCK
            ShortDescription = 'C25_SQLITE IOERR UNLOCK'
        Of C25_SQLITE_IOERR_VNODE
            ShortDescription = 'C25_SQLITE IOERR VNODE'
        Of C25_SQLITE_IOERR_WRITE
            ShortDescription = 'C25_SQLITE IOERR WRITE'
        Of C25_SQLITE_LOCKED_SHAREDCACHE
            ShortDescription = 'C25_SQLITE LOCKED SHAREDCACHE'
        Of C25_SQLITE_LOCKED_VTAB
            ShortDescription = 'C25_SQLITE LOCKED VTAB'
        Of C25_SQLITE_NOTICE_RECOVER_ROLLBACK
            ShortDescription = 'C25_SQLITE NOTICE RECOVER ROLLBACK'
        Of C25_SQLITE_NOTICE_RECOVER_WAL
            ShortDescription = 'C25_SQLITE NOTICE RECOVER WAL'
        Of C25_SQLITE_OK_LOAD_PERMANENTLY
            ShortDescription = 'C25_SQLITE OK LOAD PERMANENTLY'
        Of C25_SQLITE_READONLY_CANTINIT
            ShortDescription = 'C25_SQLITE READONLY CANTINIT'
        Of C25_SQLITE_READONLY_CANTLOCK
            ShortDescription = 'C25_SQLITE READONLY CANTLOCK'
        Of C25_SQLITE_READONLY_DBMOVED
            ShortDescription = 'C25_SQLITE READONLY DBMOVED'
        Of C25_SQLITE_READONLY_DIRECTORY
            ShortDescription = 'C25_SQLITE READONLY DIRECTORY'
        Of C25_SQLITE_READONLY_RECOVERY
            ShortDescription = 'C25_SQLITE READONLY RECOVERY'
        Of C25_SQLITE_READONLY_ROLLBACK
            ShortDescription = 'C25_SQLITE READONLY ROLLBACK'
        Of C25_SQLITE_WARNING_AUTOINDEX
            ShortDescription = 'C25_SQLITE WARNING AUTOINDEX'
        Else
            ShortDescription = 'C25_SQLITE UNKNOWN'
        End
        Return ShortDescription

c25Sqlite34Class.QueueDataToSqliteTable                    Procedure(*QUEUE _queue, String _tableName, <Byte _updateQRowId>, <Byte _retainTrueReflectionClass>, <Byte _skipSpecialFields>)

CurrentFieldAny                 ANY
Address                         Long
AdrGroup                        Group,pre()
PtrAddress                          Long
PtrSize                             Long
                                End
AddressFromAny                  String(4),over(Address)
AddressAndSizeFromAny           String(8),over(AdrGroup)
NewField                        &String
NewFieldLen                     Long
ptrString                       &String
UInt64Grp                       LIKE(UINT64)
sqlite3_uint64                  real,over(UInt64Grp)
LastRowId                       Long
SHA256RECORDStr                 &String
StringSize                      Long
QueueRecordString               &String
QueueRecordStringLen            Long
Reflection                      &TrueReflectionClass()
FieldsCount                     Long
TablePrefix                     cstring(128)
TableName                       cstring(128)
RecordsCount                    Long
SQLLine16K                      String(17000)
UpdatePhase                     Long
BindOffset                      Long
F                               Long
BindCount                       Long
IsLast                          Byte
SQLText                         &String
SqlTextLen                      Long
BindId                          Long
ConnHandle                      Long
SqliteStmtHandle                Long
Sqlite_API_Return               Long
RecIdx                          Long
IntVal                          Long
RowExists                       Byte
UpdateDateTime                  DECIMAL(20)
NanoSync                        &c25NanoSyncClass
RecordHasChanged                Byte
st1                             &StringTheory

    Code

        If _queue &= NULL
            Return ''
        End
        QueueRecordStringLen            = Size(_queue)
        QueueRecordString               &= NEW String(QueueRecordStringLen)
        NanoSync                        &= NEW c25NanoSyncClass()
        st1                             &= NEW StringTheory()
        Reflection                      &= NEW TrueReflectionClass()
        Reflection.Analyze(_queue)
        FieldsCount                 = Records(Reflection.ClarionFields)
        If Len(Clip(TablePrefix)) > 0
            TableName = Clip(TablePrefix) & _tableName
        Else
            TableName = _tableName
        End
        ConnHandle         = Self.ConnHandle
        RecordsCount     = Records(_queue)
        If RecordsCount = 0
            Dispose(Reflection)
            Dispose(QueueRecordString)
            Return ''
        End
        Clear(SQLLine16K)
        UpdatePhase = 0
        Loop 2 Times
            UpdatePhase = UpdatePhase + 1
            If _updateQRowId = False
                If UpdatePhase = 2
                    BREAK
                End
            End
            Case UpdatePhase
            Of 1
                SQLLine16K         = 'INSERT INTO ' & TableName & ' ('
            Of 2
                SQLLine16K = 'UPDATE ' & TableName & ' SET ([SESSIONINPUTID], [UPDATEDATETIME], [SHA256RECORD], '
            End
            BindOffset         = 0
            F                 = 0
            BINDCOUNT         = + BindOffset
            IsLast             = 0
            Loop
                F = F + 1
                Get(Reflection.ClarionFields,F)
                If Errorcode() <> 0
                    BREAK
                End
                If F = Records(Reflection.ClarionFields)
                    IsLast = TRUE
                End
                BINDCOUNT = BINDCOUNT + 1
                If IsLast = True
                    SQLLine16K = Clip(SQLLine16K) & ' [' & Reflection.ClarionFields.Name & ']'
                    BREAK
                End
                SQLLine16K = Clip(SQLLine16K) & ' [' & Reflection.ClarionFields.Name & '], '
            End
            Case UpdatePhase
            Of 1
                SQLLine16K = Clip(SQLLine16K)& ') Values( '
            Of 2
                SQLLine16K = Clip(SQLLine16K)& ') = ( '
            End
            BINDID = 0
            Loop BINDCOUNT Times
                BINDID = BINDID + 1
                If BINDID = BINDCOUNT
                    SQLLine16K = Clip(SQLLine16K) & ', @p' & BINDID
                    SQLLine16K = Clip(SQLLine16K) & ');'
                    BREAK
                End
                If BINDID = 1
                    SQLLine16K = Clip(SQLLine16K) & '@p' & BINDID
                Else
                    SQLLine16K = Clip(SQLLine16K) & ', @p' & BINDID
                End
            End
            If not SQLText &= null
                Dispose(SQLText)
            End

            SqlTextLen             = Len(Clip(SQLLine16K))
            SQLText             &= NEW String(SqlTextLen)
            SQLText             = SQLLine16K
            SQLITE_API_RETURN     = sqlite3_prepare_v2(ConnHandle,Address(SQLText),SqlTextLen,Address(SqliteStmtHandle),0)
            If SQLITE_API_RETURN <> C25_SQLITE_OK
                Self.ErrorCodeExtended = sqlite3_extended_errcode(ConnHandle)
                Message(ConnHandle & ', ' & SqliteStmtHandle & ', ' & SQLITE_API_RETURN & ', ' & Self.ErrorCodeExtended & ', ' & Self.Get_ExtendedCodeInfo())
                Message('ERROR at : sqlite3_prepare_v2, ' & Clip(SQLText))
                Return ''
            End

            RecIdx = 0
l0          Loop RecordsCount Times
                RecIdx = RecIdx + 1
                Get(_queue,RecIdx)
                If Errorcode() <> 0
                    BREAK
                End
                Case UpdatePhase
                Of 1
                    QueueRecordString     = _queue
                Of 2
                    RecordHasChanged = 0
                End
                BINDID = 0
                F = 0
                Loop Reflection.FieldsCount Times
                    F = F + 1
                    Get(Reflection.ClarionFields,F)
                    Clear(AdrGroup)
                    IntVal = 0
                    ptrString &= null
                    Clear(AddressAndSizeFromAny)
                    BINDID = BINDID + 1
                    sqlite3_bind_null(SqliteStmtHandle, sqlite3_bind_parameter_index(SqliteStmtHandle, '@p' & BINDID & Chr(0)))
                    CurrentFieldAny &= null
                    CurrentFieldAny &= WHAT(_queue,F)
                    If CurrentFieldAny &= NULL
                        CYCLE
                    End
                    Case Upper(Reflection.ClarionFields.DataType)
                    Of 'Byte'
                    OrOf 'Short'
                    OrOf 'UShort'
                    OrOf 'Long'
                    OrOf 'ULong'
                        If not CurrentFieldAny &= null
                            IntVal = CurrentFieldAny
                            sqlite3_bind_int(SqliteStmtHandle, sqlite3_bind_parameter_index(SqliteStmtHandle, '@p' & BINDID & Chr(0)), IntVal)
                        End
                    Else
                        If Reflection.ClarionFields.IsRef = True
                            If CurrentFieldAny &= null
                                Cycle
                            End
                            If not CurrentFieldAny &= null
                                AddressAndSizeFromAny = CurrentFieldAny
                                ptrString &= AdrGroup.PtrAddress & ':' & AdrGroup.PtrSize
                                If ptrString &= NULL
                                    CYCLE
                                End
                                If not CurrentFieldAny &= null
                                    AddressAndSizeFromAny = CurrentFieldAny
                                    ptrString &= PtrAddress & ':' & PtrSize
                                    If not ptrString &= null
                                        st1.Start()
                                        If Reflection.ClarionFields.IsAnsi
                                            st1.encoding = st:EncodeAnsi
                                            st1.codepage = st:CP_ACP
                                            st1.SetValue(Clip(ptrString))
                                            st1.ToUnicode(st:EncodeUtf16)
                                        End
                                        If Reflection.ClarionFields.IsUtf8
                                            st1.encoding = st:EncodeUtf8
                                            st1.codepage = st:CP_UTF8
                                            st1.SetValue(Clip(ptrString))
                                            st1.ToUnicode(st:EncodeUtf16)
                                        End
                                        If Reflection.ClarionFields.IsUtf16
                                            st1.encoding = st:EncodeUtf16
                                            st1.SetValue(Clip(ptrString))
                                        End
                                        If Reflection.ClarionFields.IsUtf32
                                            st1.encoding = st:EncodeUtf32
                                            st1.SetValue(Clip(ptrString))
                                            st1.ToUnicode(st:EncodeUtf16)
                                        End
                                        If Reflection.ClarionFields.IsBinary = True
                                            If not NewField &= NULL
                                                Dispose(NewField)
                                            End
                                            st1.encoding = st:EncodeAnsi
                                            st1.codepage = st:CP_ACP
                                            st1.SetValue(Clip(ptrString))
                                            NewFieldLen = St1.Length()
                                            If NewFieldLen > 0
                                                NewField &= NEW String(St1.Length())
                                                NewField = St1.GetValue()
                                                Clear(UInt64Grp)
                                                UInt64Grp.Lo = St1.Length()
                                                sqlite3_bind_blob( SqliteStmtHandle, sqlite3_bind_parameter_index( SqliteStmtHandle, '@p' & BINDID & Chr(0)), Address(NewField),UInt64Grp.Lo,C25_SQLITE_TRANSIENT)
                                            End
                                        ELSE
                                            If not NewField &= NULL
                                                Dispose(NewField)
                                            End
                                            NewFieldLen = St1.Length()
                                            If NewFieldLen > 0
                                                NewField &= NEW String(St1.Length() + 0)
                                                NewField = St1.GetValue()
                                                sqlite3_bind_text16( SqliteStmtHandle, sqlite3_bind_parameter_index( SqliteStmtHandle, '@p' & BINDID & Chr(0)), Address(NewField),St1.Length(),C25_SQLITE_TRANSIENT)
                                            End
                                        End
                                    End
                                End
                            End
                        Else
                            st1.Start()
                            If Reflection.ClarionFields.IsAnsi
                                st1.encoding = st:EncodeAnsi
                                st1.codepage = st:CP_ACP
                                st1.SetValue(Clip(CurrentFieldAny))
                                st1.ToUnicode(st:EncodeUtf16)
                            End
                            If Reflection.ClarionFields.IsUtf8
                                st1.encoding = st:EncodeUtf8
                                st1.codepage = st:CP_UTF8
                                st1.SetValue(Clip(CurrentFieldAny))
                                st1.ToUnicode(st:EncodeUtf16)
                            End
                            If Reflection.ClarionFields.IsUtf16
                                st1.encoding = st:EncodeUtf16
                                st1.SetValue(Clip(CurrentFieldAny))
                            End
                            If Reflection.ClarionFields.IsUtf32
                                st1.encoding = st:EncodeUtf32
                                st1.SetValue(Clip(CurrentFieldAny))
                                st1.ToUnicode(st:EncodeUtf16)
                            End
                            If Reflection.ClarionFields.IsBinary
                                st1.Start()
                                St1.SetValue(CurrentFieldAny)
                                If not NewField &= NULL
                                    Dispose(NewField)
                                End
                                NewFieldLen = St1.Length()
                                If NewFieldLen > 0
                                    NewField &= NEW String(NewFieldLen)
                                    NewField = St1.GetValue()
                                    Clear(UInt64Grp)
                                    UInt64Grp.Lo = St1.Length()
                                    sqlite3_bind_blob( SqliteStmtHandle, sqlite3_bind_parameter_index( SqliteStmtHandle, '@p' & BINDID & Chr(0)), Address(NewField),UInt64Grp.Lo,C25_SQLITE_TRANSIENT)
                                End
                            ELSE
                                If not NewField &= NULL
                                    Dispose(NewField)
                                End
                                NewFieldLen = St1.Length()
                                If NewFieldLen > 0
                                    NewField &= NEW String(St1.Length())
                                    NewField = St1.GetValue()
                                    sqlite3_bind_text16( SqliteStmtHandle, sqlite3_bind_parameter_index( SqliteStmtHandle, '@p' & BINDID & Chr(0)), Address(NewField),St1.Length(),C25_SQLITE_TRANSIENT)
                                End
                            End
                        End
                    End
                End
                If not NewField &= NULL
                    DISPOSE(NewField)
                End
                SQLITE_API_RETURN = sqlite3_step(SqliteStmtHandle)
                If (SQLITE_API_RETURN <> C25_SQLITE_ROW and SQLITE_API_RETURN <> C25_SQLITE_DONE)
                    Message('ERROR at : sqlite3_step')
                    Self.ErrorCodeExtended = sqlite3_extended_errcode(ConnHandle)
                    Message(ConnHandle & ', ' & SqliteStmtHandle & ', ' & SQLITE_API_RETURN & ', ' & Self.ErrorCodeExtended & ', ' & Self.Get_ExtendedCodeInfo())
                    Message('ERROR at : sqlite3_prepare_v2, ' & Clip(SQLText))
                    Return 0
                End
                SQLITE_API_RETURN = sqlite3_clear_bindings(SqliteStmtHandle)
                If SQLITE_API_RETURN <> C25_SQLITE_OK
                End
                SQLITE_API_RETURN = sqlite3_reset(SqliteStmtHandle)
                If SQLITE_API_RETURN <> C25_SQLITE_OK
                End
            End
            If SqliteStmtHandle <> 0
                SQLITE_API_RETURN = sqlite3_finalize(SqliteStmtHandle)
                If SQLITE_API_RETURN <> C25_SQLITE_OK
                    Return 0
                End
            End
            Dispose(SQLText)
            If not NewField &= NULL
                Dispose(NewField)
            End

            Break
        End
        If not QueueRecordString &= NULL
            Dispose(QueueRecordString)
        End
        If not Reflection &= NULL
            Dispose(Reflection)
        End
        If not SQLText &= NULL
            Dispose(SQLText)
        End
        If not NewField &= NULL
            Dispose(NewField)
        End

        Self.Exec(, 'UPDATE ' & TableName & ' SET ID = ROWID WHERE ID = 0')

        Return LastRowId

c25Sqlite34Class.ClearEFData                               Procedure()

    Code

        Clear(Self.EF_Address)
        Clear(Self.EF_AdrGroup)
        Clear(Self.EF_AddressFromAny)
        Clear(Self.EF_AddressAndSizeFromAny)
        If not Self.EF_NewField &= null
            Dispose(Self.EF_NewField)
        End
        Clear(Self.EF_NewFieldLen)
        If not Self.EF_ptrString &= null
            Dispose(Self.EF_ptrString)
        End
        Clear(Self.EF_UInt64Grp)
        Clear(Self.EF_sqlite3_uint64)
        Clear(Self.EF_LastRowId)
        If not Self.EF_SHA256RECORDStr &= null
            Dispose(Self.EF_SHA256RECORDStr)
        End
        Clear(Self.EF_StringSize)
        Clear(Self.EF_SQLLine16K)
        Clear(Self.EF_UpdatePhase)
        Clear(Self.EF_F)
        Clear(Self.EF_IsLast)
        If not Self.EF_SQLText &= null
            Dispose(Self.EF_SQLText)
        End
        Clear(Self.EF_SqlTextLen)
        Clear(Self.EF_BindId)
        Clear(Self.EF_Sqlite_API_Return)
        Clear(Self.EF_RecIdx)
        Clear(Self.EF_IntVal)
        Clear(Self.EF_RowExists)
        Clear(Self.EF_UpdateDateTime)
        Clear(Self.EF_RecordHasChanged)
        Return 0

c25Sqlite34Class.QueueDataToSqliteTableEntityFinalize      Procedure()

    Code

        Dispose(Self.EF_QueueRecordString)
        Clear(Self.EF_QueueRecordStringLen)
        Clear(Self.EF_FieldsCount)
        Clear(Self.EF_TableName)
        Clear(Self.EF_RecordsCount)
        Clear(Self.EF_BindOffset)
        Clear(Self.EF_BindCount)
        Clear(Self.EF_ConnHandle)
        Clear(Self.EF_SqliteStmtHandle)
        Return 0

c25Sqlite34Class.QueueDataToSqliteTableEntity              Procedure(*QUEUE _queue, String _tableName, <*ClarionFields_TYPE _clarionFields>, <Byte _skipUpdateIds>, <Long _saveQueueToSqlite3Flags>)

LogLevel                                                Long
LogErrorLevel                                           Long
ClarionFields                                           &ClarionFields_TYPE
stLogFileName                                           cstring(1024)
stLog                                                   &StringTheory

    Code

        If _queue &= NULL
            Return -1
        End
        If Records(_queue) < 1
            Return -1
        End

        LogLevel = 0
        LogErrorLevel = 0
        If LogLevel Or LogErrorLevel
        End

        If _queue &= NULL
            If LogLevel Or LogErrorLevel
            End
            Return -1
        End

        If omitted(_clarionFields) = False
            If LogLevel
            End
            ClarionFields &= _clarionFields
        ELSE
            If LogLevel
            End
            ClarionFields &= NEW ClarionFields_TYPE()
            If not Self.TrueReflection &= null
                Dispose(Self.TrueReflection)
            End
            Self.TrueReflection &= NEW TrueReflectionClass()
            Self.TrueReflection.Analyze(_queue,ClarionFields)

            If LogLevel
            End
        End

        Get(_queue,1)
        If Errorcode() <> 0
            If LogLevel Or LogErrorLevel
            End
            Return -1
        End
        Self.EF_RecordsCount = Records(_queue)
        If LogLevel
        End
        If Self.EF_RecordsCount = 0
            If LogLevel Or LogErrorLevel
            End
            Return -1
        End

        If LogLevel
        End

        Clear(Self.EF_Address)
        Clear(Self.EF_AdrGroup)
        Clear(Self.EF_AddressFromAny)
        Clear(Self.EF_AddressAndSizeFromAny)

        If not Self.EF_NewField &= null
            Dispose(Self.EF_NewField)
        End
        Clear(Self.EF_NewFieldLen)

        Clear(Self.EF_UInt64Grp)
        Clear(Self.EF_sqlite3_uint64)
        Clear(Self.EF_LastRowId)
        If not Self.EF_SHA256RECORDStr &= null
            Dispose(Self.EF_SHA256RECORDStr)
        End
        Clear(Self.EF_StringSize)
        Clear(Self.EF_SQLLine16K)
        Clear(Self.EF_UpdatePhase)
        Clear(Self.EF_F)
        Clear(Self.EF_IsLast)
        If not Self.EF_SQLText &= null
            Dispose(Self.EF_SQLText)
        End
        Clear(Self.EF_SqlTextLen)
        Clear(Self.EF_BindId)
        Clear(Self.EF_Sqlite_API_Return)
        Clear(Self.EF_RecIdx)
        Clear(Self.EF_IntVal)
        Clear(Self.EF_RowExists)
        Clear(Self.EF_UpdateDateTime)
        Clear(Self.EF_RecordHasChanged)

        Self.EF_QueueRecordStringLen         = Size(_queue)

        If LogLevel
        End
        If Self.EF_QueueRecordStringLen < 1
            If LogLevel Or LogErrorLevel
            End
            Return -1
        End
        Self.EF_QueueRecordString             &= NEW String(Self.EF_QueueRecordStringLen)
        Self.EF_FieldsCount                 = Records(ClarionFields)
        Self.EF_TableName                   = Clip(Left(_tableName))
        Loop 1 Times
            Self.EF_SQLLine16K         = 'INSERT INTO ' & Self.EF_TableName & ' ('
            Self.EF_BindOffset         = 0
            Self.EF_F                 = 0
            Self.EF_BINDCOUNT         = Self.EF_BindOffset
            Self.EF_IsLast             = 0
            Loop
                Self.EF_F = Self.EF_F + 1
                Get(ClarionFields,Self.EF_F)
                If Errorcode() <> 0
                    If LogLevel Or LogErrorLevel
                    End
                    BREAK
                End
                If Self.EF_F = Records(ClarionFields)
                    Self.EF_IsLast = TRUE
                End
                Self.EF_BINDCOUNT = Self.EF_BINDCOUNT + 1
                If Self.EF_IsLast = True
                    Self.EF_SQLLine16K = Clip(Self.EF_SQLLine16K) & ' [' & ClarionFields.Name & ']'
                    BREAK
                End
                Self.EF_SQLLine16K = Clip(Self.EF_SQLLine16K) & ' [' & ClarionFields.Name & '], '
            End
            Self.EF_SQLLine16K = Clip(Self.EF_SQLLine16K)& ') Values( '
            Self.EF_BINDID = 0
            Loop Self.EF_BINDCOUNT Times
                Self.EF_BINDID = Self.EF_BINDID + 1
                If Self.EF_BINDID = Self.EF_BINDCOUNT
                    Self.EF_SQLLine16K = Clip(Self.EF_SQLLine16K) & ', @p' & Self.EF_BINDID
                    Self.EF_SQLLine16K = Clip(Self.EF_SQLLine16K) & ');'
                    BREAK
                End
                If Self.EF_BINDID = 1
                    Self.EF_SQLLine16K = Clip(Self.EF_SQLLine16K) & '@p' & Self.EF_BINDID
                Else
                    Self.EF_SQLLine16K = Clip(Self.EF_SQLLine16K) & ', @p' & Self.EF_BINDID
                End
            End
            If not Self.EF_SQLText &= null
                Dispose(Self.EF_SQLText)
            End

            Self.EF_SqlTextLen             = Len(Clip(Self.EF_SQLLine16K))
            Self.EF_SQLText             &= NEW String(Self.EF_SqlTextLen)
            Self.EF_SQLText             = Self.EF_SQLLine16K

            If LogLevel
            End
            Self.EF_SQLITE_API_RETURN     = sqlite3_prepare_v2(Self.ConnHandle,Address(Self.EF_SQLText),Self.EF_SqlTextLen,Address(Self.EF_SqliteStmtHandle),0)
            If Self.EF_SQLITE_API_RETURN <> C25_SQLITE_OK
                If LogLevel Or LogErrorLevel
                End
                Self.ErrorCodeExtended = sqlite3_extended_errcode(Self.ConnHandle)
                If LogLevel Or LogErrorLevel
                End
                Return -1
            ELSE
                If LogLevel
                End
            End
        End

        Self.EF_RecIdx = 0
lq      Loop Self.EF_RecordsCount Times
            Self.EF_RecIdx = Self.EF_RecIdx + 1
            Get(_queue,Self.EF_RecIdx)
            If Errorcode() <> 0
                BREAK
            End

            Self.EF_QueueRecordString     = _queue
            Self.EF_BINDID = 0
            Self.EF_F = 0
            Loop Self.EF_FieldsCount Times
                Self.EF_F = Self.EF_F + 1
                Get(ClarionFields,Self.EF_F)

                Clear(Self.EF_AdrGroup)
                Self.EF_IntVal = 0
                Self.EF_ptrString &= null
                Clear(Self.EF_AddressAndSizeFromAny)
                Self.EF_BINDID = Self.EF_BINDID + 1
                sqlite3_bind_null(Self.EF_SqliteStmtHandle, sqlite3_bind_parameter_index(Self.EF_SqliteStmtHandle, '@p' & Self.EF_BINDID & Chr(0)))
                Self.EF_CurrentFieldAny &= null
                If LogLevel
                End
                Self.EF_CurrentFieldAny &= NULL

                If _queue &= NULL
                    If LogLevel Or LogErrorLevel
                    End
                    Return -1
                ELSE
                    If LogLevel
                    End
                End
                Self.EF_CurrentFieldAny &= WHAT(_queue,Self.EF_F)

                If LogLevel
                End
                If Self.EF_CurrentFieldAny &= NULL
                    If LogLevel Or LogErrorLevel
                    End
                    Return -1
                    BREAK
                ELSE
                    If LogLevel
                    End
                End

                If BAND(_saveQueueToSqlite3Flags, SaveQueueToSqlite3Flags:NoInsertWhenId)
                    If Upper(Clip(ClarionFields.Name)) = 'ID'
                        If Self.EF_CurrentFieldAny <> 0
                            CYCLE lq
                        End
                    End
                End

                If LogLevel
                End
                Case Upper(ClarionFields.DataType)
                Of 'Byte'
                OrOf 'Short'
                OrOf 'UShort'
                OrOf 'Long'
                OrOf 'ULong'
                    If not Self.EF_CurrentFieldAny &= null
                        Self.EF_IntVal = Self.EF_CurrentFieldAny
                        sqlite3_bind_int(Self.EF_SqliteStmtHandle, sqlite3_bind_parameter_index(Self.EF_SqliteStmtHandle, '@p' & Self.EF_BINDID & Chr(0)), Self.EF_IntVal)
                    End
                Else
                    If ClarionFields.IsRef = True
                        If Self.EF_CurrentFieldAny &= null
                            Cycle
                        End
                        If not Self.EF_CurrentFieldAny &= null
                            Self.EF_AddressAndSizeFromAny = Self.EF_CurrentFieldAny
                            Self.EF_ptrString &= Self.EF_AdrGroup.EF_PtrAddress & ':' & Self.EF_AdrGroup.EF_PtrSize
                            If Self.EF_ptrString &= NULL
                                CYCLE
                            End
                            If not Self.EF_CurrentFieldAny &= null
                                Self.EF_AddressAndSizeFromAny = Self.EF_CurrentFieldAny
                                Self.EF_ptrString &= Self.EF_AdrGroup.EF_PtrAddress & ':' & Self.EF_AdrGroup.EF_PtrSize
                                If not Self.EF_ptrString &= null
                                    If not Self.EF_NewField &= NULL
                                        Dispose(Self.EF_NewField)
                                    End
                                    Self.st1.Start()
                                    If ClarionFields.IsAnsi
                                        Self.st1.encoding = st:EncodeAnsi
                                        Self.st1.codepage = st:CP_ACP
                                        Self.st1.SetValue(Clip(Self.EF_ptrString))
                                        Self.st1.ToUnicode(st:EncodeUtf16)
                                    ElsIf ClarionFields.IsUtf8
                                        Self.st1.encoding = st:EncodeUtf8
                                        Self.st1.codepage = st:CP_UTF8
                                        Self.st1.SetValue(Clip(Self.EF_ptrString))
                                        Self.st1.ToUnicode(st:EncodeUtf16)
                                    ElsIf ClarionFields.IsUtf16
                                        Self.st1.encoding = st:EncodeUtf16
                                        Self.st1.SetValue(Clip(Self.EF_ptrString))
                                    ElsIf ClarionFields.IsUtf32
                                        Self.st1.encoding = st:EncodeUtf32
                                        Self.st1.SetValue(Clip(Self.EF_ptrString))
                                        Self.st1.ToUnicode(st:EncodeUtf16)
                                    ElsIf ClarionFields.IsBinary = True
                                        Self.st1.encoding = st:EncodeAnsi
                                        Self.st1.codepage = st:CP_ACP
                                        Self.st1.SetValue(Clip(Self.EF_ptrString))

                                        Self.EF_NewFieldLen = Self.st1.Length()
                                        If Self.EF_NewFieldLen > 0
                                            Self.EF_NewField &= NEW String(Self.st1.Length())
                                            Self.EF_NewField = Self.st1.GetValue()
                                            Clear(Self.EF_UInt64Grp)
                                            Self.EF_UInt64Grp.Lo = Self.st1.Length()
                                            sqlite3_bind_blob( Self.EF_SqliteStmtHandle, sqlite3_bind_parameter_index( Self.EF_SqliteStmtHandle, '@p' & Self.EF_BINDID & Chr(0)), Address(Self.EF_NewField),Self.EF_UInt64Grp.Lo,C25_SQLITE_TRANSIENT)
                                        End
                                    ELSE
                                        Self.st1.encoding = st:EncodeAnsi
                                        Self.st1.codepage = st:CP_ACP
                                        Self.st1.SetValue(Clip(Self.EF_ptrString))
                                        Self.st1.ToUnicode(st:EncodeUtf16)
                                    End
                                    If Self.st1.Length() > 0
                                        If not Self.EF_NewField &= NULL
                                            Dispose(Self.EF_NewField)
                                        End
                                        Self.EF_NewFieldLen = Self.st1.Length()
                                        If Self.EF_NewFieldLen > 0
                                            Self.EF_NewField &= NEW String(Self.st1.Length() + 0)
                                            Self.EF_NewField = Self.st1.GetValue()
                                            sqlite3_bind_text16( Self.EF_SqliteStmtHandle, sqlite3_bind_parameter_index( Self.EF_SqliteStmtHandle, '@p' & Self.EF_BINDID & Chr(0)), Address(Self.EF_NewField),Self.st1.Length(),C25_SQLITE_TRANSIENT)
                                        End
                                    End
                                End
                            End
                        End
                    Else
                        Self.st1.Start()
                        If ClarionFields.IsAnsi
                            If ClarionFields.DataType = 'DECIMAL'
                                Self.st1.encoding = st:EncodeAnsi
                                Self.st1.codepage = st:CP_ACP
                                Self.st1.SetValue(Self.EF_CurrentFieldAny)

                                Self.st1.ToUnicode(st:EncodeUtf16)
                            ELSE
                                Self.st1.encoding = st:EncodeAnsi
                                Self.st1.codepage = st:CP_ACP
                                Self.st1.SetValue(Clip(Self.EF_CurrentFieldAny))
                                Self.st1.ToUnicode(st:EncodeUtf16)
                            End
                        ElsIf ClarionFields.IsUtf8
                            Self.st1.encoding = st:EncodeUtf8
                            Self.st1.codepage = st:CP_UTF8
                            Self.st1.SetValue(Clip(Self.EF_CurrentFieldAny))
                            Self.st1.ToUnicode(st:EncodeUtf16)
                        ElsIf ClarionFields.IsUtf16
                            Self.st1.encoding = st:EncodeUtf16
                            Self.st1.SetValue(Clip(Self.EF_CurrentFieldAny))
                        ElsIf ClarionFields.IsUtf32
                            Self.st1.encoding = st:EncodeUtf32
                            Self.st1.SetValue(Clip(Self.EF_CurrentFieldAny))
                            Self.st1.ToUnicode(st:EncodeUtf16)
                        ELSE
                            Self.st1.encoding = st:EncodeAnsi
                            Self.st1.codepage = st:CP_ACP
                            Self.st1.SetValue(Clip(Self.EF_CurrentFieldAny))
                            Self.st1.ToUnicode(st:EncodeUtf16)
                        End
                        If ClarionFields.IsBinary
                            Self.st1.Start()
                            Self.st1.SetValue(Self.EF_CurrentFieldAny)
                            If not Self.EF_NewField &= NULL
                                Dispose(Self.EF_NewField)
                            End
                            Self.EF_NewFieldLen = Self.st1.Length()
                            If Self.EF_NewFieldLen > 0
                                Self.EF_NewField &= NEW String(Self.EF_NewFieldLen)
                                Self.EF_NewField = Self.st1.GetValue()
                                Clear(Self.EF_UInt64Grp)
                                Self.EF_UInt64Grp.Lo = Self.st1.Length()
                                sqlite3_bind_blob( Self.EF_SqliteStmtHandle, sqlite3_bind_parameter_index( Self.EF_SqliteStmtHandle, '@p' & Self.EF_BINDID & Chr(0)), Address(Self.EF_NewField),Self.EF_UInt64Grp.Lo,C25_SQLITE_TRANSIENT)
                            End
                        ELSE
                            If not Self.EF_NewField &= NULL
                                Dispose(Self.EF_NewField)
                            End
                            Self.EF_NewFieldLen = Self.st1.Length()
                            If Self.EF_NewFieldLen > 0
                                Self.EF_NewField &= NEW String(Self.st1.Length())
                                Self.EF_NewField = Self.St1.GetValue()
                                sqlite3_bind_text16( Self.EF_SqliteStmtHandle, sqlite3_bind_parameter_index( Self.EF_SqliteStmtHandle, '@p' & Self.EF_BINDID & Chr(0)), Address(Self.EF_NewField),Self.St1.Length(),C25_SQLITE_TRANSIENT)
                            End
                        End
                    End
                End
            End
            If not Self.EF_NewField &= NULL
                DISPOSE(Self.EF_NewField)
            End
            If LogLevel
            End
            Self.EF_SQLITE_API_RETURN = sqlite3_step(Self.EF_SqliteStmtHandle)
            If (Self.EF_SQLITE_API_RETURN <> C25_SQLITE_ROW and Self.EF_SQLITE_API_RETURN <> C25_SQLITE_DONE)
                If LogLevel Or LogErrorLevel
                End
                Self.ErrorCodeExtended = sqlite3_extended_errcode(Self.ConnHandle)
                If LogLevel Or LogErrorLevel
                End
                Return -1
            Else
                If LogLevel
                End
                If _skipUpdateIds = False
                    Get(ClarionFields,1)
                    If errorcode() = 0
                        If Upper(ClarionFields.Name) = 'ID'
                            Case Upper(ClarionFields.DataType)
                            Of 'Long'
                            OrOf 'ULong'
                                Self.EF_Last_Insert_RowId = sqlite3_last_insert_rowid(Self.ConnHandle)
                                Self.Int32 = Self.EF_Last_Insert_RowId
                                Self.EF_QueueRecordString[ClarionFields.Offset + 1 : ClarionFields.OffsetEnd+1] = Self.Str4OverInt32
                                _queue = Self.EF_QueueRecordString
                                Put(_queue)
                            End
                        End
                    End
                End
            End
            Self.EF_SQLITE_API_RETURN = sqlite3_clear_bindings(Self.EF_SqliteStmtHandle)
            If Self.EF_SQLITE_API_RETURN <> C25_SQLITE_OK
                If LogLevel Or LogErrorLevel
                End
                Return -1
            ELSE
                If LogLevel
                End
            End
            Self.EF_SQLITE_API_RETURN = sqlite3_reset(Self.EF_SqliteStmtHandle)
            If Self.EF_SQLITE_API_RETURN <> C25_SQLITE_OK
                If LogLevel Or LogErrorLevel
                End
                Return -1
            ELSE
                If LogLevel
                End
            End
        End
        If LogLevel
        End
        Self.Exec(, 'UPDATE ' & Self.EF_TableName & ' SET ID = ROWID WHERE ID = 0')
        If LogLevel
        End
        If Self.EF_SqliteStmtHandle <> 0
            Self.EF_SQLITE_API_RETURN = sqlite3_finalize(Self.EF_SqliteStmtHandle)
            If Self.EF_SQLITE_API_RETURN <> C25_SQLITE_OK
                If LogLevel Or LogErrorLevel
                End
                Return -1
            ELSE
                If LogLevel
                End
            End
            Self.EF_SqliteStmtHandle = 0
        End

        If omitted(_clarionFields) = True
            If ClarionFields &= NULL
                Dispose(ClarionFields)
            End
        End

        Return Self.EF_Last_Insert_RowId

c25Sqlite34Class.ExecuteQueryToQueueEntity                 Procedure(String _commandText, *queue _queue, <*ClarionFields_TYPE _clarionFields>, <Long _logLevel>)

ClarionFields &ClarionFields_TYPE

LogLevel                                                    Long
LogErrorLevel                                               Long
SomeReal                                                    REAL

IntText                                                     String(64)

DecStr11                                                    String(11)
Dec20                                                       DECIMAL(20,0),over(DecStr11)

    Code

        If omitted(_logLevel) = False
            LogLevel = _logLevel
            LogErrorLevel = True
        End
        If LogLevel <> 0
        End

        If _queue &= NULL
            If LogErrorLevel Or LogLevel
            End
            Return ''
        End

        If omitted(_clarionFields) = False
            If LogLevel
            End
            ClarionFields &= _clarionFields
        ELSE
            If LogLevel
            End
            ClarionFields &= NEW ClarionFields_TYPE()
            If not Self.TrueReflection &= null
                Dispose(Self.TrueReflection)
            End
            Self.TrueReflection &= NEW TrueReflectionClass()
            Self.TrueReflection.Analyze(_queue,ClarionFields)

            If LogLevel
            End
            Dispose(Self.TrueReflection)
        End

        Self.EF2_ColumnVal                 &= null
        Self.EF2_RecSize                 = Size(_queue)
        If Self.EF2_RecSize < 1
            Return ''
        End
        If not Self.EF2_RecStr &= NULL
            Dispose(Self.EF2_RecStr)
        End
        Self.EF2_RecStr                 &= NEW String(Self.EF2_RecSize)
        If not Self.EF2_RecStrClear &= NULL
            Dispose(Self.EF2_RecStrClear)
        End
        Self.EF2_RecStrClear             &= NEW String(Self.EF2_RecSize)
        Clear(_queue)
        Self.EF2_RecStrClear             = _queue

        If not Self.EF2_CommandText &= NULL
            Dispose(Self.EF2_CommandText)
        End
        Self.EF2_CommandText             &= NEW String(Size(_commandText)+1)
        Self.EF2_CommandText             = Clip(_commandText) & Chr(0)

        If not Self.EF2_Sqlite3ColumnMetaQ &= NULL ! todo deep dispose
            Dispose(Self.EF2_Sqlite3ColumnMetaQ)
        End
        Self.EF2_Sqlite3ColumnMetaQ      &= NEW Sqlite3ColumnMeta_TYPE()

L0      Loop 1 Times
            Self.EF2_TimeOut = Self.NanoSync.CalcSysTimeout(0,15,0,0)
L1          Loop
                If Self.EF2_TimeOut < Self.NanoSync.GetSysTime()
                    BREAK L0
                End
                Self.ResultCode = sqlite3_prepare_v2(Self.ConnHandle,Address(Self.EF2_CommandText),Size(Self.EF2_CommandText),Address(Self.EF2_StmtHandle),0)
                If LogLevel
                End
                Case Self.ResultCode
                Of C25_SQLITE_OK
                    BREAK L1
                Of C25_SQLITE_BUSY !
                OrOf C25_SQLITE_BUSY_RECOVERY
                OrOf C25_SQLITE_BUSY_SNAPSHOT
                OrOf C25_SQLITE_LOCKED
                    If Self.EF2_StmtHandle <> 0
                        sqlite3_finalize(Self.EF2_StmtHandle)
                        Self.EF2_StmtHandle = 0
                    End
                    c25_SleepEx(50,0)
                    Cycle
                Else
                    If LogLevel Or LogErrorLevel
                    End
                    If Self.EF2_StmtHandle <> 0
                        sqlite3_finalize(Self.EF2_StmtHandle)
                        Self.EF2_StmtHandle = 0
                    End
                    BREAK L0
                End
            End

            If Self.EF2_StmtHandle = 0
                BREAK L0
            End
            Self.EF2_RowIndex               = 0
            Self.EF2_RetriesOnBusy          = 0
            Self.EF2_RetryOnBusyTime        = 0
            Self.EF2_TimeOut                = Self.NanoSync.CalcSysTimeout(0,15,0,0)
L2          Loop
                If Self.EF2_TimeOut < Self.NanoSync.GetSysTime()
                    BREAK L2
                End
                Self.ResultCode = sqlite3_step(Self.EF2_StmtHandle)
                If LogLevel
                End
                Case Self.ResultCode
                Of C25_SQLITE_ROW
                    If LogLevel
                    End
                Of C25_SQLITE_DONE
                    If LogLevel
                    End
                    BREAK L2
                Of C25_SQLITE_BUSY !
                    If LogLevel
                    End
                OrOf C25_SQLITE_BUSY_RECOVERY
                OrOf C25_SQLITE_BUSY_SNAPSHOT
                OrOf C25_SQLITE_LOCKED
                    If LogLevel
                    End
                    c25_SleepEx(50,0)
                    Cycle
                Else
                    If LogLevel Or LogErrorLevel
                    End
                    BREAK L2
                End

                Self.EF2_RecStr = Self.EF2_RecStrClear
                Self.EF2_RowIndex = Self.EF2_RowIndex + 1

                If LogLevel
                End

                If Self.EF2_RowIndex = 1
                    Self.EF2_ColumnsCount = sqlite3_column_count(Self.EF2_StmtHandle)

                    If LogLevel
                    End

                    Self.EF2_ColIndex = -1
                    Loop Self.EF2_ColumnsCount Times
                        Self.EF2_ColIndex = Self.EF2_ColIndex + 1
                        Clear(Self.EF2_Sqlite3ColumnMetaQ)
                        Self.EF2_Sqlite3ColumnMetaQ.Id = Records(Self.EF2_Sqlite3ColumnMetaQ) + 1
                        Self.EF2_Sqlite3ColumnMetaQ.Index = Self.EF2_ColIndex
                        Self.EF2_ColumnNamePtr = 0
                        Self.EF2_ColumnNamePtr = sqlite3_column_name(Self.EF2_StmtHandle, Self.EF2_ColIndex)
                        If Self.EF2_ColumnNamePtr <> 0
                            Self.EF2_Sqlite3ColumnMetaQ.Name = Self.BitConverter.ParseZeroTerminatedStringA(Self.EF2_ColumnNamePtr, True)
                        End
                        If LogLevel
                        End
                        Add(Self.EF2_Sqlite3ColumnMetaQ)
                    End
                    Self.EF2_Index1 = 0
                    Loop
                        Self.EF2_Index1 = Self.EF2_Index1 + 1
                        Get(Self.EF2_Sqlite3ColumnMetaQ,Self.EF2_Index1)
                        If Errorcode() <> 0
                            BREAK
                        End

                        Self.EF2_Index2 = 0
                        Loop
                            Self.EF2_Index2 = Self.EF2_Index2 + 1
                            Get(ClarionFields,Self.EF2_Index2)
                            If Errorcode() <> 0
                                BREAK
                            End
                            If CLIP(Upper(Self.EF2_Sqlite3ColumnMetaQ.Name)) = CLIP(Upper(ClarionFields.Name))
                                Self.EF2_Sqlite3ColumnMetaQ.TargetQFieldIndex = Self.EF2_Index2
                                Put(Self.EF2_Sqlite3ColumnMetaQ)
                                Break
                            End
                        End
                    End
                End

                Self.EF2_ColIndex = -1
                Loop Self.EF2_ColumnsCount Times
                    Self.EF2_ColIndex = Self.EF2_ColIndex + 1
                    Get(Self.EF2_Sqlite3ColumnMetaQ,Self.EF2_ColIndex+1)
                    If Errorcode() <> 0
                        Cycle
                    End
                    If Self.EF2_Sqlite3ColumnMetaQ.TargetQFieldIndex = 0 ! no mapping to target queue
                        CYCLE
                    End
                    Self.EF2_INDEX = Self.EF2_Sqlite3ColumnMetaQ.TargetQFieldIndex
                    Get(ClarionFields,Self.EF2_INDEX)
                    If Errorcode() <> 0
                        Cycle
                    End
                    If NOT Self.EF2_ColumnVal &= null
                        Dispose(Self.EF2_ColumnVal)
                        Self.EF2_ColumnVal &= null
                    End
                    Self.EF2_ColumnType = sqlite3_column_type(Self.EF2_StmtHandle, Self.EF2_ColIndex)
                    Self.EF2_ValueObjectPtr = sqlite3_column_value(Self.EF2_StmtHandle, Self.EF2_ColIndex)

                    Case sqlite3_column_type(Self.EF2_StmtHandle, Self.EF2_ColIndex)

                    Of C25_SQLITE_INTEGER
                        Self.EF2_RecStr[ClarionFields.Offset + 1 : ClarionFields.OffsetEnd+1] = All(Chr(0), ClarionFields.OffsetEnd - ClarionFields.Offset)

                        Self.EF2_SQLiteSqlTextPtr = sqlite3_column_text(Self.EF2_StmtHandle, Self.EF2_ColIndex)

                        Self.EF2_ColumnBytes = sqlite3_column_bytes(Self.EF2_StmtHandle, Self.EF2_ColIndex)
                        If Self.EF2_ColumnBytes = 0
                            Message('error Self.EF2_ColumnBytes = 0')
                        End
                        Self.EF2_ColumnVal &= new String(Self.EF2_ColumnBytes)
                        c25_MemCpy(Address(Self.EF2_ColumnVal),Self.EF2_SQLiteSqlTextPtr, Self.EF2_ColumnBytes)

                        Dec20 = Self.EF2_ColumnVal
                        Case Upper(ClarionFields.DataType)
                        Of 'Byte'
                            Self.EF2_DummyBYTE = Dec20
                            Self.EF2_RecStr[ClarionFields.Offset + 1 : ClarionFields.OffsetEnd+1] = Self.EF2_DummyBYTEOver
                        Of 'UShort'
                            Self.EF2_UInt16 = Dec20
                            Self.EF2_RecStr[ClarionFields.Offset + 1 : ClarionFields.OffsetEnd+1] = Self.EF2_Str2OverUInt16
                        Of 'Short'
                            Self.EF2_Int16 = Dec20
                            Self.EF2_RecStr[ClarionFields.Offset + 1 : ClarionFields.OffsetEnd+1] = Self.EF2_Str2OverInt16
                        Of 'ULong'
                            Self.EF2_UInt32 = Dec20
                            Self.EF2_RecStr[ClarionFields.Offset + 1 : ClarionFields.OffsetEnd+1] = Self.EF2_Str4OverUInt32
                        Of 'Long'
                            Self.EF2_Int32 = Dec20
                            Self.EF2_RecStr[ClarionFields.Offset + 1 : ClarionFields.OffsetEnd+1] = Self.EF2_Str4OverInt32
                        Of 'DECIMAL'

                            O2# = 12
                            O# = ClarionFields.OffsetEnd + 1
                            Loop
                                O# = O# - 1
                                O2# = O2# - 1
                                If O# < ClarionFields.Offset + 1
                                    BREAK
                                End
                                Self.EF2_RecStr[O#] = DecStr11[O2#]
                            End

                        End

                    Of C25_SQLITE_BLOB
                        Self.EF2_SQLiteSqlTextPtr = sqlite3_column_blob(Self.EF2_StmtHandle,Self.EF2_ColIndex)
                        If Self.EF2_SQLiteSqlTextPtr <> 0
                            Self.EF2_ColumnBytes = sqlite3_column_bytes(Self.EF2_StmtHandle, Self.EF2_ColIndex)
                            If Self.EF2_ColumnBytes > 0

                                Self.EF2_ColumnVal &= new String(Self.EF2_ColumnBytes)
                                c25_MemCpy(Address(Self.EF2_ColumnVal),Self.EF2_SQLiteSqlTextPtr, Self.EF2_ColumnBytes)

                                Case ClarionFields.IsRef
                                Of True
                                    Case Upper(ClarionFields.DataType)
                                    Of 'String'

                                        Self.EF2_GrpDummyString.EF2_DummyString &= NEW String(Self.EF2_ColumnBytes)
                                        Self.EF2_GrpDummyString.EF2_DummyString = Self.EF2_ColumnVal
                                        Self.EF2_AnyField &= What(Self.EF2_GrpDummyString,1)
                                        Self.EF2_AddressAndSizeFromAny = Self.EF2_AnyField
                                        Self.EF2_RecStr[ClarionFields.Offset + 1 : ClarionFields.OffsetEnd+1] = Self.EF2_AddressAndSizeFromAny
                                    End
                                Else
                                    Case Upper(ClarionFields.DataType)
                                    Of 'String'
                                        Self.EF2_RecStr[ClarionFields.Offset + 1 : ClarionFields.OffsetEnd+1] = Self.EF2_ColumnVal & All(Chr(32),ClarionFields.SizeBytes)
                                    End
                                End
                            End
                        End
                    Of C25_SQLITE_TEXT
                    OrOf C25_SQLITE_FLOAT
                        If ClarionFields.IsUtf16
                            Self.EF2_SQLiteSqlTextPtr = sqlite3_column_text16(Self.EF2_StmtHandle, Self.EF2_ColIndex)
                        ELSE
                            Self.EF2_SQLiteSqlTextPtr = sqlite3_column_text(Self.EF2_StmtHandle, Self.EF2_ColIndex)
                        End
                        If Self.EF2_SQLiteSqlTextPtr <> 0
                            If ClarionFields.IsUtf16
                                Self.EF2_ColumnBytes = sqlite3_column_bytes16(Self.EF2_StmtHandle, Self.EF2_ColIndex)
                            Else
                                Self.EF2_ColumnBytes = sqlite3_column_bytes(Self.EF2_StmtHandle, Self.EF2_ColIndex)
                            End
                            If Self.EF2_ColumnBytes > 0
                                Self.EF2_ColumnVal &= new String(Self.EF2_ColumnBytes)
                                c25_MemCpy(Address(Self.EF2_ColumnVal),Self.EF2_SQLiteSqlTextPtr, Self.EF2_ColumnBytes)

                                Case ClarionFields.IsRef
                                Of True
                                    Case Upper(ClarionFields.DataType)
                                    Of 'String'
                                        If ClarionFields.IsUtf16

                                            Self.EF2_GrpDummyString.EF2_DummyString &= NEW String(Size(Self.EF2_ColumnVal))
                                            Self.EF2_GrpDummyString.EF2_DummyString = Self.EF2_ColumnVal
                                        Else
                                            Self.EF2_GrpDummyString.EF2_DummyString &= NEW String(Size(Self.EF2_ColumnVal))
                                            Self.EF2_GrpDummyString.EF2_DummyString = Self.EF2_ColumnVal
                                        End
                                        Self.EF2_AnyField &= What(Self.EF2_GrpDummyString,1)
                                        Self.EF2_AddressAndSizeFromAny = Self.EF2_AnyField
                                        Self.EF2_RecStr[ClarionFields.Offset + 1 : ClarionFields.OffsetEnd+1] = Self.EF2_AddressAndSizeFromAny
                                    Of 'CSTRING'

                                        Self.EF2_GrpDummyCString.EF2_DummyCString &= NEW CSTRING(Size(Self.EF2_ColumnVal)+1) ! ?+1 is good?
                                        Self.EF2_GrpDummyCString.EF2_DummyCString = Self.EF2_ColumnVal
                                        Self.EF2_AnyField &= What(Self.EF2_GrpDummyCString,1)
                                        Self.EF2_AddressAndSizeFromAny = Self.EF2_AnyField
                                        Self.EF2_RecStr[ClarionFields.Offset + 1 : ClarionFields.OffsetEnd+1] = Self.EF2_AddressAndSizeFromAny
                                    End
                                Else
                                    Case Upper(ClarionFields.DataType)
                                    Of 'String'
                                        If ClarionFields.IsUtf16

                                            Self.EF2_RecStr[ClarionFields.Offset + 1 : ClarionFields.OffsetEnd+1] = Self.EF2_ColumnVal & All(Chr(0),ClarionFields.SizeBytes) !Self.st1.GetValue() & All(Chr(32),ClarionFields.SizeBytes)
                                        Else
                                            If ClarionFields.IsUtf8
                                                Self.EF2_RecStr[ClarionFields.Offset + 1 : ClarionFields.OffsetEnd+1] = Self.EF2_ColumnVal & All(Chr(0),ClarionFields.SizeBytes)
                                            Else
                                                Self.EF2_RecStr[ClarionFields.Offset + 1 : ClarionFields.OffsetEnd+1] = Self.EF2_ColumnVal & All(Chr(32),ClarionFields.SizeBytes)
                                            End
                                        End
                                    Of 'CSTRING'
                                        Padding# = Self.EF2_ColumnBytes - ClarionFields.SizeBytes
                                        If Padding# > 0
                                            Self.EF2_RecStr[ClarionFields.Offset + 1 : ClarionFields.OffsetEnd+1] = Self.EF2_ColumnVal & All(Chr(0),Padding#)
                                        Else
                                            Self.EF2_RecStr[ClarionFields.Offset + 1 : ClarionFields.OffsetEnd+1] = Self.EF2_ColumnVal & Chr(0)
                                        End
                                    End
                                End
                            End
                        End
                    Of C25_SQLITE_NULL
                    ELSE
                        message('aha')
                    End

                End
                _queue = Self.EF2_RecStr
                Add(_queue)
                Case Self.ResultCode
                Of C25_SQLITE_ROW
                    Cycle
                Of C25_SQLITE_DONE
                    BREAK
                End
            End
        End

        If Self.EF2_StmtHandle <> 0
            sqlite3_finalize(Self.EF2_StmtHandle)
            Self.EF2_StmtHandle = 0
        End
        Return ''

