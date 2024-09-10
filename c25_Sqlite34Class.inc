!    Include('c25_DataTypes.clw'),Once
!    Include('c25_Equates_Sqlite3.clw'),Once
!    Include('C25_DUMMY.CLW'),Once
!    Include('c25_NanoSyncClass.inc'), once
!    Include('c25_TrueReflectionClass.inc'), once
!    Include('c25_WinApi32Class.inc'), once
!    Include('errors.clw'),Once
!    Include('jfiles.inc'), once
!    Include('StringTheory.inc'), once
!    Include('c25_Equates_Itemized.clw'), once

    Include('c25_ProgramHandlerClass.inc'),Once


c25Sqlite34Class                                                            Class(),type, Module('c25_Sqlite34Class.clw'), Link('c25_Sqlite34Class.clw',1),DLL(0)
Construct                                                                       Procedure()
Destruct                                                                        Procedure(),virtual

AppMemConnHandle                                                                Long
AttachDb                                                                        Procedure(<Long _connHandle>, String _uriUtf8, String _dbAlias),Long,proc
BitConverter                                                                    &c25BitConverterClass
CalcSqlOpenFlagsValue                                                           Procedure(<SqlOpenFlags_TYPE _sqlOpenFlags>),Long
ClearEFData                                                                     Procedure(),Long,proc
CommandText                                                                     &String
Connect                                                                         Procedure(String _connString, <SqlOpenFlags_TYPE _sqlOpenFlags>),Long,proc
ConnectionString                                                                String(1024)
ConnHandle                                                                      Long
CRLF                                                                            String(2)
DetachDb                                                                        Procedure(<Long _connHandle>, String _dbAlias),Long,proc
Disconnect                                                                      Procedure(<Long _connHandle>),Long,proc
EF_Address                                                                      Long
EF_BindCount                                                                    Long
EF_BindId                                                                       Long
EF_BindOffset                                                                   Long
EF_ConnHandle                                                                   Long
EF_CurrentFieldAny                                                              ANY
EF_F                                                                            Long
EF_FieldsCount                                                                  Long
EF_IntVal                                                                       Long
EF_IsLast                                                                       Byte
EF_Last_Insert_RowId                                                            Long
EF_LastRowId                                                                    Long
EF_NewField                                                                     &String
EF_NewFieldLen                                                                  Long
EF_ptrString                                                                    &String
EF_QueueRecordString                                                            &String
EF_QueueRecordStringLen                                                         Long
EF_RecIdx                                                                       Long
EF_RecordHasChanged                                                             Byte
EF_RecordsCount                                                                 Long
EF_RowExists                                                                    Byte
EF_SHA256RECORDStr                                                              &String
EF_Sqlite_API_Return                                                            Long
EF_SqliteStmtHandle                                                             Long
EF_SQLLine16K                                                                   String(17000)
EF_SQLText                                                                      &String
EF_SqlTextLen                                                                   Long
EF_StringSize                                                                   Long
EF_TableName                                                                    cstring(128)
EF_UInt64Grp                                                                    LIKE(UINT64)
EF_UpdateDateTime                                                               DECIMAL(20)
EF_UpdatePhase                                                                  Long
EF2_Address                                                                     Long
EF2_AnyField                                                                    ANY
EF2_ColCount                                                                    Long
EF2_ColIndex                                                                    Long
EF2_ColumnBytes                                                                 Long
EF2_ColumnBytes16                                                               Long
EF2_ColumnName                                                                  &String
EF2_ColumnNamePtr                                                               Long
EF2_ColumnsCount                                                                Long
EF2_ColumnType                                                                  Long
EF2_ColumnTypeStr                                                               cstring(128)
EF2_ColumnVal                                                                   &String
EF2_CommandText                                                                 &String
EF2_CurrentMethod                                                               cstring(128)
EF2_Debug                                                                       Byte
EF2_DebugStep                                                                   Long
EF2_Dec20                                                                       DECIMAL(20)
EF2_DurationNano                                                                decimal(20)
EF2_EndTime                                                                     decimal(20)
EF2_FoundRow                                                                    Byte
EF2_Index                                                                       Long
EF2_Index1                                                                      Long
EF2_Index2                                                                      Long
EF2_Int16                                                                       Short
EF2_Int16Value                                                                  Short
EF2_Int32                                                                       Long
EF2_Int32Value                                                                  Long
EF2_Int64Grp                                                                    LIKE(INT64)
EF2_Int64Value                                                                  decimal(20,0)
EF2_INTSTR8                                                                     String(8)
EF2_IsInt64                                                                     Byte
EF2_ObjectBindId                                                                Long
EF2_RealVal                                                                     REAL
EF2_RealVal2                                                                    REAL
EF2_RecSize                                                                     Long
EF2_RecStr                                                                      &String
EF2_RecStrClear                                                                 &String
EF2_RetriesOnBusy                                                               Long
EF2_RetryOnBusyTime                                                             decimal(20)
EF2_RowIndex                                                                    Long
EF2_SleepMM                                                                     Long
EF2_Sqlite3ColumnMetaQ                                                          &Sqlite3ColumnMeta_TYPE
EF2_SQLiteSqlTextPtr                                                            Long
EF2_StartTime                                                                   decimal(20)
EF2_StmtHandle                                                                  Long
EF2_SysTime                                                                     DECIMAL(20)
EF2_TimeOut                                                                     decimal(20)
EF2_UInt16                                                                      UShort
EF2_UInt32                                                                      ULong
EF2_UInt64Grp                                                                   LIKE(UINT64)
EF2_ValueObjectPtr                                                              Long
ErrorCodeExtended                                                               Long
Exec                                                                            Procedure(<Long _connHandle>, String _sql),Long,proc
ExecuteQueryToQueue                                                             Procedure(String _commandText, *queue _queue),String,proc
ExecuteQueryToQueueEntity                                                       Procedure(String _commandText, *queue _queue, <*ClarionFields_TYPE _clarionFields>, <Long _logLevel>),String,proc
ExecuteScalar                                                                   Procedure(<String _commandText>,<*c25DbSqlObjectReturn_TYPE _c25DbSqlObjectReturn>),String,proc
Get_ExtendedCodeInfo                                                            Procedure(<Long _errorCodeExtended>),String,proc
GetPragma                                                                       Procedure(String _pragma, <String _paramA>,<*queue _queueOut>),String,proc
GetPragmaDbList                                                                 Procedure(<Long _connHandle>,<PragmaDbList_TYPE _pragmaDbList>, <Byte _inJson>,<Byte _show>),String,proc
GetSelfAddress                                                                  Procedure(),Long,proc
Int16MaxValue                                                                   decimal(20)
Int16MinValue                                                                   decimal(20)
Int32                                                                           Long
Int32MaxValue                                                                   decimal(20)
Int32MinValue                                                                   decimal(20)
Int64MaxValue                                                                   decimal(20)
Int64MinValue                                                                   decimal(20)
Js1                                                                             &JSONClass
Js2                                                                             &JSONClass
Js3                                                                             &JSONClass
Js4                                                                             &JSONClass
Js5                                                                             &JSONClass
NanoSync                                                                        &c25NanoSyncClass
PragmaDbList                                                                    &PragmaDbList_TYPE
QueueDataToSqliteTable                                                          Procedure(*QUEUE _queue, String _tableName, <Byte _updateQRowId>, <Byte _retainTrueReflectionClass>, <Byte _skipSpecialFields>),Long,proc
QueueDataToSqliteTableEntity                                                    Procedure(*QUEUE _queue, String _tableName, <*ClarionFields_TYPE _clarionFields>, <Byte _updateIds>, <Long _saveQueueToSqlite3Flags>),Long,proc
QueueDataToSqliteTableEntityFinalize                                            Procedure(),Long,PROC
QueueDataToSqliteTableIsolated                                                  Procedure(*QUEUE _queue, String _attachedAliasDb,String _tableName, String _dbFileName),Long,proc
ResultCode                                                                      Long
SelfAddress                                                                     Long
St1                                                                             &StringTheory
St2                                                                             &StringTheory
St3                                                                             &StringTheory
St4                                                                             &StringTheory
St5                                                                             &StringTheory
Str4OverInt32                                                                   String(4),Over(Int32)
TrueReflection                                                                  &TrueReflectionClass
UInt16MaxValue                                                                  decimal(20)
UInt16MinValue                                                                  decimal(20)
UInt32MaxValue                                                                  decimal(20)
UInt32MinValue                                                                  decimal(20)
UInt64MaxValue                                                                  decimal(20)
UInt64MinValue                                                                  decimal(20)
WinApi                                                                          &c25WinApiClass

EF2_DummyBYTE                                                                   Byte
EF2_DummyLONG                                                                   Long
EF2_DummySHORT                                                                  Short
EF2_DummyULONG                                                                  ULong
EF2_DummyUSHORT                                                                 UShort





EF2_AdrGroup                                                                    Group,Pre(EF2_AdrGroup)
EF2_PtrAddress                                                                      Long
EF2_PtrSize                                                                         Long
                                                                                End
EF2_GrpDummyString                                                              Group,Pre(EF2_GrpDummyString)
EF2_DummyString                                                                     &String
                                                                                End
EF2_GrpDummyCString                                                             Group,Pre(EF2_GrpDummyCString)
EF2_DummyCString                                                                    &CSTRING
                                                                                End
EF_AdrGroup                                                                     Group,pre()
EF_PtrAddress                                                                       Long
EF_PtrSize                                                                          Long
                                                                                End
c25DbSqlObjectReturn                                                            Group(c25DbSqlObjectReturn_TYPE),Pre(c25DbSqlObjectReturn)
                                                                                End
SqlOpenFlags                                                                    Group(SqlOpenFlags_TYPE),Pre(SqlOpenFlags)
                                                                                End

EF_AddressAndSizeFromAny                                                        String(8),over(EF_AdrGroup)
EF_AddressFromAny                                                               String(4),over(EF_Address)
EF2_AddressAndSizeFromAny                                                       String(8),over(EF2_AdrGroup)
EF2_AddressFromAny                                                              String(4),over(EF2_Address)
EF2_DummyBYTEOver                                                               String(1),Over(EF2_DummyBYTE)
EF2_DummyLONGOver                                                               String(4),Over(EF2_DummyLONG)
EF2_DummySHORTOver                                                              String(2),Over(EF2_DummySHORT)
EF2_DummyULONGOver                                                              String(4),Over(EF2_DummyULONG)
EF2_DummyUSHORTOver                                                             String(2),Over(EF2_DummyUSHORT)
EF2_Str2OverInt16                                                               String(2),OVER(EF2_Int16)
EF2_Str2OverUInt16                                                              String(2),OVER(EF2_UInt16)
EF2_Str4OverInt32                                                               String(4),OVER(EF2_Int32)
EF2_Str4OverUInt32                                                              String(4),OVER(EF2_UInt32)
EF2_Str8OverInt64                                                               String(8),OVER(EF2_Int64Grp)
EF2_Str8OverUInt64                                                              String(8),OVER(EF2_UInt64Grp)
EF_sqlite3_uint64                                                               real,over(EF_UInt64Grp)
                                                                            End

