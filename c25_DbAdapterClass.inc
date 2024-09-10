    Include('c25_DatabaseHandlerClass.inc'), once
    Include('c25_DataTypes.clw'),Once
    Include('c25_DbSourceClass.inc'), once
    Include('C25_DUMMY.CLW'), once
    Include('c25_Equates_Itemized.clw'), once
    Include('C25_DUMMY.CLW'),once
    Include('c25_MachineClass.inc'),once
    Include('c25_MsSqlClass.inc'),once
    Include('c25_NanoSyncClass.inc'), once
    Include('c25_Sqlite34Class.inc'), once
    Include('c25_TrueReflectionClass.inc'),Once
    Include('c25_WinApi32Class.inc'), once
    Include('errors.clw'),Once
    Include('StringTheory.inc'), once
    Include('c25_GlobalMemClass.inc'), once

c25DbAdapterClass                                       Class(),type, Module('c25_DbAdapterClass.clw'), Link('c25_DbAdapterClass.clw',_ABCLinkMode_),DLL(_ABCDllMode_)
Construct                                                   Procedure()
Destruct                                                    Procedure()

AdaptersRecord                                              Group(c25DbAdapters_TYPE),Pre(AdaptersRecord)
                                                            End
c25_AdapterReady                                            Procedure(Long _winHandle, Long _winMes, ULong _wParam, Long _lParam),Long,proc
c25_CreateDatabases                                         Procedure(Long _winHandle, Long _winMes, ULong _wParam, Long _lParam),Long,proc
c25_CreateIndexes                                           Procedure(Long _winHandle, Long _winMes, ULong _wParam, Long _lParam),Long,proc
c25_CreateTables                                            Procedure(Long _winHandle, Long _winMes, ULong _wParam, Long _lParam),Long,proc
c25_EventsQueue                                             Procedure(Long _winHandle, Long _winMes, ULong _wParam, Long _lParam),Long,proc
c25_Exec                                                    Procedure(Long _winHandle, Long _winMes, ULong _wParam, Long _lParam),Long,proc
c25_ExecuteScalar                                           Procedure(Long _winHandle, Long _winMes, ULong _wParam, Long _lParam),Long,proc
c25_GetMachineById                                          Procedure(Long _winHandle, Long _winMes, ULong _wParam, Long _lParam),Long,proc
c25_GetSqlite3ConnHandle                                    Procedure(Long _winHandle, Long _winMes, ULong _wParam, Long _lParam),Long,proc
c25_PrepareServerDBs                                        Procedure(Long _winHandle, Long _winMes, ULong _wParam, Long _lParam),Long,proc
c25_SaveQueueToSqlite3                                      Procedure(Long _winHandle, Long _winMes, ULong _wParam, Long _lParam),Long,proc
c25_SaveQueueToSqlite3_Array_Index                          Long
c25DbSqlObject                                              &c25DbSqlObject_TYPE()
c25DbSqlObjectMem                                           &String
ColumnExist                                                 Procedure(Long _tableId, String _name),Byte
Columns                                                     &c25DbTableColumns_TYPE
ConnectMsSqlServer                                          Procedure(<c25DbDatabases_TYPE _c25DbDatabases>,<String _connStringOrUriUtf8>),String,proc
ConnectSqlite3                                              Procedure(<c25DbDatabases_TYPE _c25DbDatabases>,<String _connStringOrUriUtf8>),String,proc
ConnectSqlite3BySourceName                                  Procedure(<String _name>, <c25DbSources_TYPE _c25DbDatabases>),String,proc
CreateMsSqlDatabase                                         Procedure(<c25DbDatabases_TYPE _c25DbDatabases>,<String _connStringOrUriUtf8>),String,proc
CreateMsSqlIndexes                                          Procedure(<c25DbDatabases_TYPE _c25DbDatabases>,<String _connStringOrUriUtf8>),String,proc
CreateMsSqlTables                                           Procedure(<c25DbDatabases_TYPE _c25DbDatabases>,<String _connStringOrUriUtf8>),String,proc
CreateScript                                                Procedure(Long _scriptType),String,proc
CreateSqlite3Database                                       Procedure(<c25DbDatabases_TYPE _c25DbDatabases>,<String _connStringOrUriUtf8>),String,proc
CreateSqlite3Indexes                                        Procedure(<c25DbDatabases_TYPE _c25DbDatabases>,<String _connStringOrUriUtf8>),String,proc
CreateSqlite3Tables                                         Procedure(<c25DbDatabases_TYPE _c25DbDatabases>,<String _connStringOrUriUtf8>),String,proc
CRLF                                                        String(2)
DataBaseHandler                                             &c25DatabaseHandlerClass
Databases                                                   &c25DbDatabases_TYPE
DummyProc                                                   Procedure(),Long,proc
EventIdTEMP                                                 cstring(64)
EventsQueue                                                 &c25DbEventsQueue_TYPE
EventsQueue_Add                                             Procedure(<c25DbEventsQueue_TYPE _c25DbEventsQueue>, <String _eventId>, <Long _state>, <Long _extraPtr>),String,proc
EventsQueue_Get                                             Procedure(<c25DbEventsQueue_TYPE _c25DbEventsQueue>, <String _eventId>, <String _nanoTimeStamp>),String,proc
EventsQueue_GetStatus                                       Procedure(String _eventId, String _nanoTimeStamp, <Long _removeIfState>),Long
EventsQueue_UpdateStatus                                    Procedure(<c25DbEventsQueue_TYPE _c25DbEventsQueue>, <String _eventId>, <Long _state>, <Long _extraPtr>),String,proc
Exec                                                        Procedure(String _sql,String _sourceName,<String _databaseName>,<String _eventId>,<Byte _async>, <Long _timeoutMMSecs>,<*Byte _isNull>, <*c25DbSqlObjectReturn_TYPE _c25DbSqlObjectReturn>, <Long _returnDataType>, <Long _targetPtr>,<String _tableName>,<String _columnName>),String,proc
ExecuteScalar                                               Procedure(<String _eventId>,<Byte _async>, <Long _timeoutMMSecs>,<*Byte _isNull>, <*c25DbSqlObjectReturn_TYPE _c25DbSqlObjectReturn>, <Long _returnDataType>, <Long _targetPtr>, String _sourceName,String _databaseName,<String _tableName>,<String _columnName>,<String _sql>),String,proc
GetSelfAddress                                              Procedure(),Long
GetSqlConnHandleBySourceName                                Procedure(String _sourceName),Long
GlobalMem                                                   &c25GlobalMemClass
Init                                                        Procedure(),Long,proc
Js1                                                         &JSONClass()
Log                                                         Procedure(String _line),String,proc
MsSql                                                       &c25MsSqlClass()
NanoSync                                                    &NanoSyncClass()
NanoTimeStampTEMP                                           Decimal(20,0)
NetSCW                                                      &NetSCWQ_TYPE
NetTcpInstances                                             &NetTcpInstancesQ_TYPE
ParseDataBaseHandlerQueues                                  Procedure(),Long,proc
PrepareAppDBs                                               Procedure(<Long _dbEngineType>),String,proc
PrepareServerDBs                                            Procedure(<Long _dbEngineType>, <Long _filter>),String,proc
PrimarySqlite3ConnHandle                                    Long
RealReflection                                              &TrueReflectionClass()
ReturnVal                                                   Long
SaveQueue                                                   Procedure(<String _eventId>,<Byte _async>, String _sourceName,<String _databaseName>,<String _tableName>,<String _queueType>,<*Queue _queue>, <Long _queuePtr>,<Byte _skipUpdateId>,<Long _saveQueueToSqlite3Flags>),String,proc
SelfAddress                                                 Long
Sources                                                     &c25DbSources_TYPE
Sqlite34                                                    &Sqlite34Class()
State                                                       cstring(128)
stLog                                                       &StringTheory
stLogFileName                                               &String
Tables                                                      &c25DbTables_TYPE
Tuple2                                                      Like(Tuple2_TYPE)
WinApi                                                      &WinApi32Class()
WM_000016_WM_CLOSE                                          Procedure(Long _winHandle, Long _winMes, ULong _wParam, Long _lParam),Long,proc
WM_000275_WM_TIMER                                          Procedure(Long _winHandle, Long _winMes, ULong _wParam, Long _lParam),Long,proc
WM_SETFIELD                                                 Procedure(Long _winHandle, Long _winMes, ULong _wParam, Long _lParam),Long,proc
WM_TEST                                                     Procedure(Long _winHandle, Long _winMes, ULong _wParam, Long _lParam),Long,proc
WM_TimerCount                                               Long
WndMessageProcessed                                         Byte
WndProc_Process                                             Procedure(Long _winHandle, Long _winMes, ULong _wParam, Long _lParam),Long,proc
WndProc_ReturnVal                                           Long


c25_SaveQueueToSqlite3_Array                                Group,Pre(c25_SaveQueueToSqlite3_Array),DIM(16000)
WinHandle                                                       Long
WinMes                                                          Long
WParam                                                          ULong
LParam                                                          Long
                                                            End
                                                        End

