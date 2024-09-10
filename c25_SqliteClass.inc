    Include('c25_ProgramHandlerClass.inc'),Once

c25_SqliteClass                                                        Class(),Type, Module('c25_SqliteClass.clw'), Link('c25_SqliteClass.clw',1),DLL(0)

Construct                                                                   Procedure()
Destruct                                                                    Procedure(),virtual
ClassTypeName                                                               cstring(128)
Turbo                                                                       BOOL
AutoIncrementId                                                             BOOL

stSqlStatementInsert                                                        &StringTheory
stSqlStatementSelect                                                        &StringTheory
stSqlStatementUpdate                                                        &StringTheory
stSqlStatementScalar                                                        &StringTheory

In_8Zero                                                                     STRING(8)
In_8Zero_Address                                                             LONG
In_Address                                                                   Long
In_AutoIncrement                                                             BOOL
In_BindCount                                                                 Long
In_BindId                                                                    Long
In_BindIndex                                                                 Long
In_BindOffset                                                                Long
In_ClarionFields                                                             &ClarionFields_TYPE
In_ColIndex                                                                  Long
In_ColumnBytes                                                               Long
In_ColumnType                                                                Long
In_ColumnValInt1                                                             byte
In_ColumnValInt1Address                                                      Long
In_ColumnValInt2                                                             Short
In_ColumnValInt2Address                                                      long
In_ColumnValInt4                                                             Long
In_ColumnValInt4Address                                                      Long
In_ColumnValUInt2                                                            UShort
In_ColumnValUInt2Address                                                     Long
In_ColumnValUInt4                                                            ULong
In_ColumnValUInt4Address                                                     Long
In_ConnHandle                                                                Long
In_CurrentFieldAny                                                           ANY
In_DisposeDummy                                                              &String
In_DummyStringStr8                                                           string(8)
In_DummyStringStr8_Address                                                   Long
In_F                                                                         Long
In_F_INIT                                                                    Long
In_FieldsCount                                                               Long
In_FieldsCountStmtInsert                                                     LONG
In_FieldsCountStmtSelect                                                     LONG
In_FieldsCountStmtUpdate                                                     LONG
In_FieldValueStringRef                                                       &STRING
In_Index                                                                     LONG
In_IntVal                                                                    Long
In_IsLast                                                                    Byte
In_LastRowId                                                                 Long
In_NanoClockClass                                                            &C25_NanoSyncClass
In_NewField                                                                  &String
In_NewFieldLen                                                               Long
In_PostInsertRemove                                                          BOOL
In_PtrString                                                                 &String
In_Q                                                                         &QUEUE
In_Q_Address                                                                 Long
In_Q_Count                                                                   long
In_QIndex                                                                    LONG
In_QoutputAddress                                                            Long
In_QueueRecordString                                                         &String
In_QueueRecordStringAddress                                                  long
In_QueueRecordStringLen                                                      Long
In_RecIdx                                                                    Long
In_RecordHasChanged                                                          Byte
In_RecordsCount                                                              Long
In_Reflection                                                                &c25_DataReflectionClass()
In_RetrievedCount                                                            LONG
In_RowExists                                                                 Byte
In_SHA256RECORDStr                                                           &String
In_SqlColumnCount                                                            LONG
In_SQLITE_API_RETURN                                                         LONG
In_SqliteStmtHandle                                                          Long
In_SQLLine16K                                                                String(17000)
In_SqlStatementInsertHandle                                                  long
In_SQLText                                                                   &String
In_SqlTextLen                                                                Long
In_st1                                                                       &StringTheory
In_StringSize                                                                Long
In_Sqlite3ColumnMeta                                                         &Sqlite3ColumnMeta_TYPE
In_TableName                                                                 cstring(128)
In_TablePrefix                                                               cstring(128)
In_TextPtr                                                                   LONG
In_UInt64Grp                                                                 LIKE(UINT64)
In_UpdateDateTime                                                            DECIMAL(20)
In_UpdatePhase                                                               Long
In_StringRefGrp                                                             Group,Pre(In_StringRefGrp)
StringRef                                                                         &String
                                                                            End
In_sqlite3_uint64                                                            real,over(In_UInt64Grp)

In_AdrGroup                                                                  Group,pre(In_AdrGroup)
PtrAddress                                                                      Long
PtrSize                                                                         Long
                                                                            End
In_AddressFromAny                                                            String(4),over(In_Address)
In_AddressAndSizeFromAny                                                     String(8),over(In_AdrGroup)






Out_8Zero                                                                     STRING(8)
Out_8Zero_Address                                                             LONG
Out_Address                                                                   Long
Out_AutoIncrement                                                             BOOL
Out_BindCount                                                                 Long
Out_BindId                                                                    Long
Out_BindIndex                                                                 Long
Out_BindOffset                                                                Long
Out_ClarionFields                                                             &ClarionFields_TYPE
Out_ColIndex                                                                  Long
Out_SourceIndex                                                               Long
Out_ColumnBytes                                                               Long
Out_ColumnType                                                                Long
Out_ColumnValInt1                                                             byte
Out_ColumnValInt1Address                                                      Long
Out_ColumnValInt2                                                             Short
Out_ColumnValInt2Address                                                      long
Out_ColumnValInt4                                                             Long
Out_ColumnValInt4Address                                                      Long
Out_ColumnValUInt2                                                            UShort
Out_ColumnValUInt2Address                                                     Long
Out_ColumnValUInt4                                                            ULong
Out_ColumnValUInt4Address                                                     Long
Out_ConnHandle                                                                Long
Out_CurrentFieldAny                                                           ANY
Out_DisposeDummy                                                              &String
Out_DummyStringGrpStr8                                                           string(8)
Out_DummyStringGrpStr8_Address                                                   Long
Out_F                                                                         Long
Out_F_INIT                                                                    Long
Out_FieldsCount                                                               Long
Out_FieldsCountStmtInsert                                                     LONG
Out_FieldsCountStmtSelect                                                     LONG
Out_FieldsCountStmtUpdate                                                     LONG
Out_FieldValueStringRef                                                       &STRING
Out_Index                                                                     LONG
Out_IntVal                                                                    Long
Out_IsLast                                                                    Byte
Out_LastRowId                                                                 Long
Out_NanoClockClass                                                            &C25_NanoSyncClass
Out_NewField                                                                  &String
Out_NewFieldLen                                                               Long
Out_PostInsertRemove                                                          BOOL
Out_PtrString                                                                 &String
Out_Q                                                                         &QUEUE
Out_Q_Address                                                                 Long
Out_Q_Count                                                                   long
Out_QIndex                                                                    LONG
Out_QoutputAddress                                                            Long
Out_QueueRecordString                                                         &String
Out_QueueRecordStringAddress                                                  long
Out_QueueRecordStringLen                                                      Long
Out_RecIdx                                                                    Long
Out_RecordHasChanged                                                          Byte
Out_RecordsCount                                                              Long
Out_Reflection                                                                &c25_DataReflectionClass()
Out_RetrievedCount                                                            LONG
Out_RowExists                                                                 Byte
Out_SHA256RECORDStr                                                           &String
Out_SqlColumnCount                                                            LONG
Out_SQLITE_API_RETURN                                                         LONG
Out_SqliteStmtHandle                                                          Long
Out_SQLLine16K                                                                String(17000)
Out_SqlStatementSelectHandle                                                  long
Out_SQLText                                                                   &String
Out_SqlTextLen                                                                Long
Out_st1                                                                       &StringTheory
Out_StringSize                                                                Long
Out_Sqlite3ColumnMeta                                                         &Sqlite3ColumnMeta_TYPE
Out_TableName                                                                 cstring(128)
Out_TablePrefix                                                               cstring(128)
Out_TextPtr                                                                     LONG
Out_Text16k                                                                    STRING(17000)
Out_Text                                                                    &STRING
Out_UInt64Grp                                                                 LIKE(UINT64)
Out_UpdateDateTime                                                            DECIMAL(20)
Out_UpdatePhase                                                             Long



Out_StringRefGrp                                                          Group,Pre(Out_StringRefGrp)
StringRef                                                                         &String
                                                                            End

Out_sqlite3_uint64                                                            real,over(Out_UInt64Grp)

Out_AdrGroup                                                                  Group,pre(Out_AdrGroup)
PtrAddress                                                                      Long
PtrSize                                                                         Long
                                                                            End
Out_AddressFromAny                                                            String(4),over(Out_Address)
Out_AddressAndSizeFromAny                                                     String(8),over(Out_AdrGroup)

AnyField                                                                    ANY

Zero                                                                        byte
ZeroAddress                                                                 long



FieldIndex                                                                  Long

FoundRow                                                                    BOOL
FoundField                                                                  BOOL

AppMemConnHandle                                                            Long
ConnectionString                                                            String(1024)
ConnHandle                                                                  Long
CRLF                                                                        String(2)
ErrorCodeExtended                                                           Long
Int16MaxValue                                                               decimal(20)
Int16MinValue                                                               decimal(20)
Int32                                                                       Long
Int32MaxValue                                                               decimal(20)
Int32MinValue                                                               decimal(20)
Int64MaxValue                                                               decimal(20)
Int64MinValue                                                               decimal(20)
ResultCode                                                                  Long
SelfAddress                                                                 Long
UInt16MaxValue                                                              decimal(20)
UInt16MinValue                                                              decimal(20)
UInt32MaxValue                                                              decimal(20)
UInt32MinValue                                                              decimal(20)
UInt64MaxValue                                                              decimal(20)
UInt64MinValue                                                              decimal(20)
CurrentMethod                                                               cstring(2024)
ConnectionStringBackup                                                      string(1024)
ConnHandleBackup                                                            long
NanoClockClass                                                              &C25_NanoSyncClass
BitConverter                                                                &c25_BitConverterClass
ProgramHandlerClass                                                         &c25_ProgramHandlerClass
WinApiClass                                                                 &c25_WinApiClass
DataReflectionClass                                                         &c25_DataReflectionClass
AddClaQRowToQ3Blob_PrepareSql                                               &STRING
AddClaQRowToQ3Blob_PrepareSqlStmtHandle                                     Long

StLog                                                                       &StringTheory
CommandText                                                                 &String
Js1                                                                         &JSONClass
Js2                                                                         &JSONClass
Js3                                                                         &JSONClass
Js4                                                                         &JSONClass
Js5                                                                         &JSONClass
PragmaDbList                                                                &PragmaDbList_TYPE
St1                                                                         &StringTheory
St2                                                                         &StringTheory
St3                                                                         &StringTheory
St4                                                                         &StringTheory
StProperty                                                                  &StringTheory

EnumRowsPrepare                                                             Procedure(<string _tableName>, <string _sql>),Long
EnumRows                                                                    Procedure(),long
EnumFields                                                                  Procedure(*c25_ObjectClass _objectClass),bool
!EnumFields                                                                  Procedure(),*c25_ObjectClass


ClarionFieldPropertyAndValueExist                                           Procedure(*ClarionFields_TYPE _clarionFields, string _fieldName, string _key, string _value, <bool reGetPointer>),string,PROC
GetClarionFieldProperty                                                     Procedure(*ClarionFields_TYPE _clarionFields, string _fieldName, string _key, <string _defaultValue>, <bool reGetPointer>),string,PROC
ClarionFieldPropertyExist                                                   Procedure(*ClarionFields_TYPE _clarionFields, string _fieldName, string _key, <bool reGetPointer>),bool,PROC
SetClarionFieldProperty                                                     Procedure(*ClarionFields_TYPE _clarionFields, string _fieldName, string _prop, string _value, <long _dataType>),long,PROC
AddClarionQueueRowToQ3Blob                                                  Procedure(long _ptr, long _size, <bool _isLast>),string,PROC
ApplyCString                                                                Procedure(long _targetAddress, long _textPtr, long _columnBytes, long _claBytes),long,PROC
ApplyString                                                                 Procedure(long _targetAddress, long _textPtr, long _columnBytes, long _claBytes),long,PROC
ApplyStringRef                                                              Procedure(long _targetAddress, long _textPtr, long _columnBytes),long,PROC
AttachDb                                                                    Procedure(<Long _connHandle>, String _uriUtf8, String _dbAlias),Long,proc
BackupInit                                                                  Procedure(string _fileName, <byte _silently>),string,PROC
CalcSqlOpenFlagsValue                                                       Procedure(<SqlOpenFlags_TYPE _sqlOpenFlags>),Long
Connect                                                                     Procedure(String _connString, <SqlOpenFlags_TYPE _sqlOpenFlags>, <bool _inMemory>),Long,proc
CreateInsertPrepareSql                                                      Procedure(<string _sql>, <ClarionFields_TYPE ClarionFields> , <string _tableName>),Long,proc
CreateSelectPrepareSql                                                      Procedure(<string _sql>, <ClarionFields_TYPE ClarionFields> , <string _tableName>),Long,proc
CreateTableFromQueue                                                        Procedure(*QUEUE _queue, string _tableName, <bool _dropIfExists>, <bool _makeFirstFieldPrimary>, <string _tablePrefix>, <ClarionFields_TYPE _clarionFields>, <bool _skipAutoIncrement>),string,PROC
DetachDb                                                                    Procedure(<Long _connHandle>, String _dbAlias),Long,proc
Disconnect                                                                  Procedure(<Long _connHandle>),Long,proc
Exec                                                                        Procedure(<Long _connHandle>, String _sql),Long,proc
ExecuteScalar                                                               Procedure(<String _commandText>,<*c25DbSqlObjectReturn_TYPE _c25DbSqlObjectReturn>),String,proc
Get_ErrorMessage                                                            Procedure(long _errorCode),string,proc
Get_ErrorString                                                             Procedure(long _errorCode, byte _extended),string,proc
Get_ExtendedCodeInfo                                                        Procedure(<Long _errorCodeExtended>),String,proc
Get_ResultCodeInfo                                                          Procedure(),string,proc
GetPragma                                                                   Procedure(String _pragma, <String _paramA>,<*queue _queueOut>),String,proc
GetPragmaDbList                                                             Procedure(<Long _connHandle>,<PragmaDbList_TYPE _pragmaDbList>, <Byte _inJson>,<Byte _show>),String,proc
GetSelfAddress                                                              Procedure(),Long,proc
GetTableMetaInfoAsync                                                       Procedure(<string _sql>, <ClarionFields_TYPE _clarionFieldsMapping>, <string _tableName> , Sqlite3ColumnMeta_TYPE _sqlite3ColumnMetaOut),long,PROC
Handle_ErrorInfo                                                            Procedure(<byte _showErrorWin>),string,proc
In_InitTurbo                                                                Procedure(*QUEUE _queue, string _tableName, <bool _noAutoIncrement>),long,PROC
InsertAllAsync                                                              Procedure(<bool inTransaction>,<bool _postInsertRemove>),long,PROC
Out_InitTurbo                                                               Procedure(*QUEUE _queue, <string _tableName>, <string _sql>),long,PROC
QueryAsync                                                                  Procedure(*QUEUE _qOutput, <string _tableName>, <string _sql>),long,PROC
QueryAsyncToDataTableClass                                                  Procedure(<*c25_DataTableClass _DataTableClass>, <string _tableName>, <string _sql>),*c25_DataTableClass,PROC
Reset_ErrorInfo                                                             Procedure(),string,proc
SetConnectionStringBackup                                                   Procedure(string _connString),string,proc
StoreToDisk                                                                 Procedure(string _fileAndPath),string,proc

Str4OverInt32                                                               String(4),Over(Int32)
c25DbSqlObjectReturn                                                        Group(c25DbSqlObjectReturn_TYPE),Pre(c25DbSqlObjectReturn)
                                                                            End
SqlOpenFlags                                                                Group(SqlOpenFlags_TYPE),Pre(SqlOpenFlags)
                                                                            End
ResultCodeInfo                                                              group(SQLITE_ResultCodeInfo_TYPE)
                                                                            end
RESULT                                                                      group(Sqlite_CommandObject_TYPE)
                                                                            end
                                                                        End
